module M3e.ChipSet exposing
    ( view, filterSet, inputSet
    , Item, Option
    , chips, ariaLabel
    , onChange, onInput, onChipsChange
    )

{-| `<m3e-chip-set>` and friends — typed chip-set containers.

Spec (per docs/CONVENTIONS.md):

  - `view` → `<m3e-chip-set>` (generic; assist/suggestion/display chips)
  - `filterSet {label}` → `<m3e-filter-chip-set>` (filter chips)
  - `inputSet {label}` → `<m3e-input-chip-set>` (input chips)
  - All return `Element { s | chipSet : Supported } msg`
  - Item: `Element { chip : Supported } msg` (strict — no escape)
  - Options (shared): chips, ariaLabel
  - Options (filterSet): onChange, onInput
  - Options (inputSet): onChipsChange
  - `role="group"` on the wrapper; `filterSet`/`inputSet` take a required label
    naming the group for assistive technology.
  - Tag: chipSet

Events (upstream `M3eFilterChipSetElement`):
`change` — dispatched when the selected state of a chip changes;
`event.target.value` is `string | null` (single-select
default). Exposed as `onChange`.
`input` — same signal, live (fires synchronously). Exposed as
`onInput`.
(`beforeinput` is also emitted upstream but is not exposed here — it
arrives before state changes and cannot be cancelled from Elm.)

Events (upstream `M3eInputChipSetElement`):
`change` — dispatched when a chip is added to or removed from the
set; `event.target.value` is `readonly string[] | null`
(always an array). Exposed as `onChipsChange`.

Strict container: the accepted child set is `{ chip : Supported }` only — no
`element` or `html` escape. A wrong child kind is a compile error.

@docs view, filterSet, inputSet
@docs Item, Option
@docs chips, ariaLabel
@docs onChange, onInput, onChipsChange

-}

import Json.Decode as Decode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES ------------------------------------------------------------------


{-| The only thing a chip set accepts: a chip. No escape hatch.
-}
type alias Item msg =
    Element { chip : Supported } msg


type alias Config msg =
    { ariaLabel : Maybe String
    , chips : List (Node msg)
    , onChange : Maybe (String -> msg)
    , onInput : Maybe (String -> msg)
    , onChipsChange : Maybe (List String -> msg)
    }


{-| An option configuring a chip set.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { ariaLabel = Nothing
    , chips = []
    , onChange = Nothing
    , onInput = Nothing
    , onChipsChange = Nothing
    }



-- OPTIONS ----------------------------------------------------------------


{-| Set the `aria-label` naming the group. (On `filterSet`/`inputSet` this
overrides the required label argument.)
-}
ariaLabel : String -> Option msg
ariaLabel label =
    Internal.option (\c -> { c | ariaLabel = Just label })


{-| Append chips to the set.
-}
chips : List (Item msg) -> Option msg
chips items =
    Internal.option (\c -> { c | chips = c.chips ++ List.map Element.toNode items })


{-| Handle selection changes on a `filterSet`. Receives the selected
value string decoded from `event.target.value` on the `change` event.
Valid for `<m3e-filter-chip-set>` in single-select mode (the default).
No-op on `view` or `inputSet`.
-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Handle live selection changes on a `filterSet`. Receives the
selected value string decoded from `event.target.value` on the `input`
event. Fires synchronously as the selected state changes.
No-op on `view` or `inputSet`.
-}
onInput : (String -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


{-| Handle chip additions and removals on an `inputSet`. Receives the
current chip values as a `List String` decoded from `event.target.value`
on the `change` event (`M3eInputChipSetElement.value` — always an array).
No-op on `view` or `filterSet`.
-}
onChipsChange : (List String -> msg) -> Option msg
onChipsChange f =
    Internal.option (\c -> { c | onChipsChange = Just f })



-- VIEW -------------------------------------------------------------------


{-| A generic chip set (`<m3e-chip-set>`) for assist/suggestion/display chips.
-}
view : List (Option msg) -> Element { s | chipSet : Supported } msg
view opts =
    render "m3e-chip-set" (Internal.applyOptions opts defaultConfig)


{-| A filter chip set (`<m3e-filter-chip-set>`). The required label names the
group for assistive technology. Accepts `onChange` and `onInput` options to
listen to the element's `change` and `input` events.
-}
filterSet : { label : String } -> List (Option msg) -> Element { s | chipSet : Supported } msg
filterSet req opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts { defaultConfig | ariaLabel = Just req.label }
    in
    Internal.fromNode
        (Node.element "m3e-filter-chip-set"
            (List.filterMap identity
                [ Just (Node.attribute "role" "group")
                , Maybe.map (Node.attribute "aria-label") cfg.ariaLabel
                , Maybe.map (decodeStringValue "change") cfg.onChange
                , Maybe.map (decodeStringValue "input") cfg.onInput
                ]
            )
            cfg.chips
        )


{-| An input chip set (`<m3e-input-chip-set>`). The required label names the
group for assistive technology. Accepts `onChipsChange` to listen to the
element's `change` event.
-}
inputSet : { label : String } -> List (Option msg) -> Element { s | chipSet : Supported } msg
inputSet req opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts { defaultConfig | ariaLabel = Just req.label }
    in
    Internal.fromNode
        (Node.element "m3e-input-chip-set"
            (List.filterMap identity
                [ Just (Node.attribute "role" "group")
                , Maybe.map (Node.attribute "aria-label") cfg.ariaLabel
                , Maybe.map decodeStringListValue cfg.onChipsChange
                ]
            )
            cfg.chips
        )


render : String -> Config msg -> Element { s | chipSet : Supported } msg
render tag cfg =
    Internal.fromNode
        (Node.element tag
            (List.filterMap identity
                [ Just (Node.attribute "role" "group")
                , Maybe.map (Node.attribute "aria-label") cfg.ariaLabel
                ]
            )
            cfg.chips
        )


{-| Wire a handler on `eventName` that decodes `event.target.value` as a
String. Used by `filterSet` for the `change` and `input` events.
-}
decodeStringValue : String -> (String -> msg) -> Node.Attr msg
decodeStringValue eventName f =
    Node.on eventName
        (Decode.at [ "target", "value" ] Decode.string
            |> Decode.map f
        )


{-| Wire the `change` handler for `inputSet`, decoding `event.target.value`
as a JSON array of strings (`M3eInputChipSetElement.value` type).
-}
decodeStringListValue : (List String -> msg) -> Node.Attr msg
decodeStringListValue f =
    Node.on "change"
        (Decode.at [ "target", "value" ] (Decode.list Decode.string)
            |> Decode.map f
        )
