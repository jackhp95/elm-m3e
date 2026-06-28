module M3e.RichTooltipAction exposing
    ( view
    , Option
    , disableRestoreFocus
    )

{-| `<m3e-rich-tooltip-action>` — a companion element, nested within a
clickable element, that dismisses a [`M3e.Tooltip`](M3e.Tooltip) rich tooltip.

Spec (per upstream CEM):

  - Required: none
  - Options: disableRestoreFocus
  - Slots: default (the action label / content)
  - Properties: `disableRestoreFocus` via `Node.property` (introspectable)
  - Tag: richTooltipAction

@docs view
@docs Option
@docs disableRestoreFocus

-}

import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Private configuration record.
-}
type alias Config =
    { disableRestoreFocus : Bool
    }


{-| Configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| When `True`, focus is not restored to the tooltip trigger after the
action dismisses the tooltip (the `disableRestoreFocus` DOM property).
Default `False`.
-}
disableRestoreFocus : Bool -> Option msg
disableRestoreFocus b =
    Internal.option (\c -> { c | disableRestoreFocus = b })


{-| Render an `<m3e-rich-tooltip-action>`. Place inside a clickable element
within a rich tooltip's action area.

    M3e.Button.view { label = "", variant = M3e.Button.Text }
        [ M3e.Button.extraContent
            [ M3e.RichTooltipAction.view
                [ M3e.Element.text "Got it" ]
                []
            ]
        ]

-}
view : List (Element any msg) -> List (Option msg) -> Element { s | richTooltipAction : Supported } msg
view content opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { disableRestoreFocus = False }
    in
    Internal.fromNode
        (Node.element "m3e-rich-tooltip-action"
            [ Node.property "disableRestoreFocus" (Encode.bool c.disableRestoreFocus)
            ]
            (List.map Internal.toNode content)
        )
