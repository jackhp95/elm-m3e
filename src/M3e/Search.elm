module M3e.Search exposing
    ( Option
    , view
    , onInput, value, clearable, clearLabel, onClear, leadingIcon, trailingIcon
    )

{-| `<m3e-search-bar>` — a Material 3 Search bar.

Spec (per docs/CONVENTIONS.md):

  - Required: { placeholder : String }
  - Options: onInput, value, clearable, clearLabel, onClear,
    leadingIcon, trailingIcon
  - Slots:
    leading : Renderable { icon : Supported } (via leadingIcon option)
    input : always rendered as <input type=search slot=input>
    trailing : Renderable { icon : Supported } (via trailingIcon option)
  - Properties: clearable (DOM property)
  - Attrs: clear-label
  - Events: input (onInput), clear (onClear)
  - Escape: none (leaf — slots are option-driven, not caller-supplied nodes)
  - Tag: search

Note: `placeholder` goes on the `<input>` child, not the bar root, per the CEM
slot contract. The root element is still `m3e-search-bar`, so a parent
`Node.setAttribute "id"` (e.g. `M3e.Field`) continues to work.

@docs Option
@docs view
@docs onInput, value, clearable, clearLabel, onClear, leadingIcon, trailingIcon

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- OPTIONS ----------------------------------------------------------------


{-| Configuration option for the search bar, built by the helpers below.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Wire a handler for the `input` event. Receives the current input value.
-}
onInput : (String -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


{-| Set the controlled value of the search input.
-}
value : String -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


{-| Show a clear button when the input is non-empty.
-}
clearable : Bool -> Option msg
clearable b =
    Internal.option (\c -> { c | clearable = b })


{-| Set the accessible label for the clear button.
-}
clearLabel : String -> Option msg
clearLabel v =
    Internal.option (\c -> { c | clearLabel = Just v })


{-| Wire a handler fired when the clear button is pressed.
-}
onClear : msg -> Option msg
onClear m =
    Internal.option (\c -> { c | onClear = Just m })


{-| Place an icon in the bar's leading slot.
-}
leadingIcon : Renderable { icon : Supported } msg -> Option msg
leadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Place an icon in the bar's trailing slot.
-}
trailingIcon : Renderable { icon : Supported } msg -> Option msg
trailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })



-- CONFIG -----------------------------------------------------------------


type alias Config msg =
    { onInput : Maybe (String -> msg)
    , value : Maybe String
    , clearable : Bool
    , clearLabel : Maybe String
    , onClear : Maybe msg
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    }


defaults : Config msg
defaults =
    { onInput = Nothing
    , value = Nothing
    , clearable = False
    , clearLabel = Nothing
    , onClear = Nothing
    , leadingIcon = Nothing
    , trailingIcon = Nothing
    }



-- VIEW -------------------------------------------------------------------


{-| Render a search bar. `placeholder` is set on the inner `<input>`.
-}
view : { placeholder : String } -> List (Option msg) -> Renderable { s | search : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaults
    in
    Internal.fromNode
        (Node.element "m3e-search-bar"
            (List.filterMap identity
                [ if c.clearable then
                    Just (Node.property "clearable" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (Node.attribute "clear-label") c.clearLabel
                , Maybe.map (\m -> Node.on "clear" (Decode.succeed m)) c.onClear
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "leading" (Renderable.toNode i)) c.leadingIcon
                , Just (inputElement req.placeholder c)
                , Maybe.map (\i -> Node.withSlot "trailing" (Renderable.toNode i)) c.trailingIcon
                ]
            )
        )


inputElement : String -> Config msg -> Node msg
inputElement placeholder c =
    Node.element "input"
        (List.filterMap identity
            [ Just (Node.attribute "slot" "input")
            , Just (Node.attribute "type" "search")
            , Just (Node.attribute "placeholder" placeholder)
            , Maybe.map (Node.attribute "value") c.value
            , Maybe.map
                (\f ->
                    Node.on "input"
                        (Decode.at [ "target", "value" ] Decode.string
                            |> Decode.map f
                        )
                )
                c.onInput
            ]
        )
        []
