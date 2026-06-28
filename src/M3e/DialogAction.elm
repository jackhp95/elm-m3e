module M3e.DialogAction exposing
    ( view
    , Option
    , returnValue
    )

{-| `<m3e-dialog-action>` — a companion element, nested within a clickable
element inside a [`M3e.Dialog`](M3e.Dialog), that closes the dialog on click.

Optionally pass a [`returnValue`](#returnValue) to identify which action was
taken (the dialog fires a `close` event and exposes this value).

Spec (per upstream CEM):

  - Required: none
  - Options: returnValue
  - Slots: default (the action label / content)
  - Attrs: `return-value` via `Node.attribute` (introspectable)
  - Tag: dialogAction

@docs view
@docs Option
@docs returnValue

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Private configuration record.
-}
type alias Config =
    { returnValue : Maybe String
    }


{-| Configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the value returned to the dialog when this action closes it
(the `return-value` attribute). The dialog fires a `close` event and
exposes this value via `dialog.returnValue`.
-}
returnValue : String -> Option msg
returnValue v =
    Internal.option (\c -> { c | returnValue = Just v })


{-| Render an `<m3e-dialog-action>`. Place inside a clickable element
within a dialog's action area.

    M3e.Button.view { label = "", variant = M3e.Button.Filled }
        [ M3e.Button.extraContent
            [ M3e.DialogAction.view
                [ M3e.Element.text "Confirm" ]
                [ M3e.DialogAction.returnValue "confirm" ]
            ]
        ]

-}
view : List (Element any msg) -> List (Option msg) -> Element { s | dialogAction : Supported } msg
view content opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { returnValue = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-dialog-action"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "return-value") c.returnValue
                ]
            )
            (List.map Internal.toNode content)
        )
