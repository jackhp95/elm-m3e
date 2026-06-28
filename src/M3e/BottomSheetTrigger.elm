module M3e.BottomSheetTrigger exposing
    ( view
    , Option
    , for, detent, secondary
    )

{-| `<m3e-bottom-sheet-trigger>` — a companion element, nested within a
clickable element, that opens a [`M3e.BottomSheet`](M3e.BottomSheet).

Wire it to the target bottom sheet via [`for`](#for). Optionally specify
which detent index the sheet should snap to with [`detent`](#detent).

Spec (per upstream CEM):

  - Required: none
  - Options: for, detent, secondary
  - Slots: default (the trigger label / content)
  - Attrs: `for` via `Node.attribute` (introspectable)
  - Properties: `detent`, `secondary` via `Node.property` (introspectable)
  - Tag: bottomSheetTrigger

@docs view
@docs Option
@docs for, detent, secondary

-}

import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Private configuration record.
-}
type alias Config =
    { for : Maybe String
    , detent : Maybe Float
    , secondary : Bool
    }


{-| Configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| Wire this trigger to a bottom sheet by its `id` (the `for` attribute).
-}
for : String -> Option msg
for v =
    Internal.option (\c -> { c | for = Just v })


{-| The zero-based index of the detent the sheet should open to (the `detent`
DOM property). When omitted the sheet opens to its default detent.
-}
detent : Float -> Option msg
detent n =
    Internal.option (\c -> { c | detent = Just n })


{-| Mark this as a secondary trigger (the `secondary` DOM property). Secondary
triggers do not receive ARIA ownership. Default `False`.
-}
secondary : Bool -> Option msg
secondary b =
    Internal.option (\c -> { c | secondary = b })


{-| Render an `<m3e-bottom-sheet-trigger>`. Place inside a clickable element
to open the target bottom sheet.

    M3e.Button.view { label = "", variant = M3e.Button.Filled }
        [ M3e.Button.extraContent
            [ M3e.BottomSheetTrigger.view
                [ M3e.Element.text "Show options" ]
                [ M3e.BottomSheetTrigger.for "my-sheet"
                , M3e.BottomSheetTrigger.detent 1
                ]
            ]
        ]

-}
view : List (Element any msg) -> List (Option msg) -> Element { s | bottomSheetTrigger : Supported } msg
view content opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { for = Nothing
                , detent = Nothing
                , secondary = False
                }
    in
    Internal.fromNode
        (Node.element "m3e-bottom-sheet-trigger"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "for") c.for
                , Maybe.map (\n -> Node.property "detent" (Encode.float n)) c.detent
                , Just (Node.property "secondary" (Encode.bool c.secondary))
                ]
            )
            (List.map Internal.toNode content)
        )
