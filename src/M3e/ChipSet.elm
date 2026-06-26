module M3e.ChipSet exposing
    ( ChipSet, Item
    , new, filterSet, inputSet
    , withChips, withAriaLabel
    , toNode
    )

{-| `<m3e-chip-set>` and friends — typed chip-set containers.

Spec (per docs/CONVENTIONS.md):

  - `new`       → `<m3e-chip-set>`        (generic; assist/suggestion/display chips)
  - `filterSet` → `<m3e-filter-chip-set>` (filter chips)
  - `inputSet`  → `<m3e-input-chip-set>`  (input chips)
  - All accept `Item msg = Renderable { chip : Supported } msg` (strict — no escape)
  - `role="group"` on the wrapper; `aria-label` from constructor arg / withAriaLabel
  - Tag: chipSet

Strict container: the accepted set is `{ chip : Supported }` only — no `element`
or `html` escape. A wrong child kind is a compile error.

-}

import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| The only thing a chip set accepts: a chip. No escape hatch.
-}
type alias Item msg =
    Renderable { chip : Supported } msg


type ChipSet msg
    = ChipSet
        { tag : String
        , ariaLabel : Maybe String
        , chips : List (Node msg)
        }


{-| A generic chip set (`<m3e-chip-set>`) for assist/suggestion/display chips.
-}
new : ChipSet msg
new =
    ChipSet { tag = "m3e-chip-set", ariaLabel = Nothing, chips = [] }


{-| A filter chip set (`<m3e-filter-chip-set>`). The required label names the
group for assistive technology.
-}
filterSet : String -> ChipSet msg
filterSet label =
    ChipSet { tag = "m3e-filter-chip-set", ariaLabel = Just label, chips = [] }


{-| An input chip set (`<m3e-input-chip-set>`). The required label names the
group for assistive technology.
-}
inputSet : String -> ChipSet msg
inputSet label =
    ChipSet { tag = "m3e-input-chip-set", ariaLabel = Just label, chips = [] }


{-| Set the `aria-label` naming the group.
-}
withAriaLabel : String -> ChipSet msg -> ChipSet msg
withAriaLabel label (ChipSet cfg) =
    ChipSet { cfg | ariaLabel = Just label }


{-| Append chips to the set.
-}
withChips : List (Item msg) -> ChipSet msg -> ChipSet msg
withChips items (ChipSet cfg) =
    ChipSet { cfg | chips = cfg.chips ++ List.map Renderable.toNode items }


toNode : ChipSet msg -> Node msg
toNode (ChipSet cfg) =
    Node.element cfg.tag
        (List.filterMap identity
            [ Just (Node.attribute "role" "group")
            , Maybe.map (Node.attribute "aria-label") cfg.ariaLabel
            ]
        )
        cfg.chips
