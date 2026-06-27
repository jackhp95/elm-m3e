module M3e.ChipSet exposing
    ( Item
    , Option
    , ariaLabel
    , chips
    , filterSet
    , inputSet
    , view
    )

{-| `<m3e-chip-set>` and friends — typed chip-set containers.

Spec (per docs/CONVENTIONS.md):

  - `view` → `<m3e-chip-set>` (generic; assist/suggestion/display chips)
  - `filterSet {label}` → `<m3e-filter-chip-set>` (filter chips)
  - `inputSet {label}` → `<m3e-input-chip-set>` (input chips)
  - All return `Renderable { s | chipSet : Supported } msg`
  - Item: `Renderable { chip : Supported } msg` (strict — no escape)
  - Options: chips, ariaLabel
  - `role="group"` on the wrapper; `filterSet`/`inputSet` take a required label
    naming the group for assistive technology.
  - Tag: chipSet

Strict container: the accepted child set is `{ chip : Supported }` only — no
`element` or `html` escape. A wrong child kind is a compile error.

-}

import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES ------------------------------------------------------------------


{-| The only thing a chip set accepts: a chip. No escape hatch.
-}
type alias Item msg =
    Renderable { chip : Supported } msg


type alias Config msg =
    { ariaLabel : Maybe String
    , chips : List (Node msg)
    }


type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { ariaLabel = Nothing, chips = [] }



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
    Internal.option (\c -> { c | chips = c.chips ++ List.map Renderable.toNode items })



-- VIEW -------------------------------------------------------------------


{-| A generic chip set (`<m3e-chip-set>`) for assist/suggestion/display chips.
-}
view : List (Option msg) -> Renderable { s | chipSet : Supported } msg
view opts =
    render "m3e-chip-set" (Internal.applyOptions opts defaultConfig)


{-| A filter chip set (`<m3e-filter-chip-set>`). The required label names the
group for assistive technology.
-}
filterSet : { label : String } -> List (Option msg) -> Renderable { s | chipSet : Supported } msg
filterSet req opts =
    render "m3e-filter-chip-set" (Internal.applyOptions opts { defaultConfig | ariaLabel = Just req.label })


{-| An input chip set (`<m3e-input-chip-set>`). The required label names the
group for assistive technology.
-}
inputSet : { label : String } -> List (Option msg) -> Renderable { s | chipSet : Supported } msg
inputSet req opts =
    render "m3e-input-chip-set" (Internal.applyOptions opts { defaultConfig | ariaLabel = Just req.label })


render : String -> Config msg -> Renderable { s | chipSet : Supported } msg
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
