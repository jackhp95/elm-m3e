module M3e.Dialog exposing
    ( Option
    , open, onClose, alert, closeButton, dismissible, closeLabel, actions
    , view
    )

{-| `<m3e-dialog>` — a modal surface for a single focused task (Material 3
Dialogs).

Spec (per docs/CONVENTIONS.md):

  - Required: { headline : String, content : List (Element any msg) }
    headline → visible title, always present (accessibility + UX);
    content → the dialog body region (default slot, free row)
  - Options: open, onClose, alert, closeButton, dismissible, closeLabel, actions
  - Slots: header (headline in <span slot="header">)
    default (content region — free row, may include html escape)
    actions (<div slot="actions"> wrapping the button list)
    close-icon (not exposed here; use Element.element for custom)
  - Properties: open (bool), alert (bool), dismissible (bool — close button),
    disable-close (bool — ESC/scrim blocking, inverted from the
    `dismissible` option below)
  - Events: closed → onClose msg; cancel → onClose msg
  - Tag: dialog

**Naming fix vs Ui.Dialog** — Ui.Dialog had two boolean modifiers with
confusing names. Here the options are clearly named:

  - `closeButton : Bool` → sets the `dismissible` DOM property.
    `True` shows a built-in close button in the dialog chrome.
    `False` (default) hides it.

  - `dismissible : Bool` → controls whether the dialog can be dismissed by
    pressing Escape or clicking the scrim. Maps to the `disable-close` DOM
    property (inverted): `True` (default) means ESC/scrim work; `False` blocks
    them (for flows that require an explicit action, like destructive
    confirmations).


# Type

@docs Option


# Options

@docs open, onClose, alert, closeButton, dismissible, closeLabel, actions

@docs view

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Whether the dialog is open. Sets the `open` DOM property. Default false.
-}
open : Bool -> Option msg
open b =
    Internal.option (\c -> { c | open = b })


{-| Handler for user-initiated dismiss. Wired to both the `closed` and
`cancel` events so Escape, scrim click, and programmatic close all fire it.
-}
onClose : msg -> Option msg
onClose m =
    Internal.option (\c -> { c | onClose = Just m })


{-| Mark the dialog as an alert (`role=alertdialog`). Use for important
state changes (failures, irreversible actions). Default false.
-}
alert : Bool -> Option msg
alert b =
    Internal.option (\c -> { c | alert = b })


{-| Show a built-in close button in the dialog chrome (the `dismissible` DOM
property). Default false.
-}
closeButton : Bool -> Option msg
closeButton b =
    Internal.option (\c -> { c | closeButton = b })


{-| Whether the dialog can be dismissed by ESC or clicking the scrim
(inverts `disable-close`). Default true — ESC and scrim work. Set false
for dialogs that require an explicit action choice.
-}
dismissible : Bool -> Option msg
dismissible b =
    Internal.option (\c -> { c | dismissible = b })


{-| Accessible label for the built-in close button (the `close-label`
attribute). Only meaningful alongside `closeButton True`.
-}
closeLabel : String -> Option msg
closeLabel s =
    Internal.option (\c -> { c | closeLabel = Just s })


{-| Action buttons shown in the dialog's `actions` slot. Accepts M3e buttons.
-}
actions : List (Element { button : Supported } msg) -> Option msg
actions xs =
    Internal.option (\c -> { c | actions = xs })


type alias Config msg =
    { open : Bool
    , onClose : Maybe msg
    , alert : Bool
    , closeButton : Bool
    , dismissible : Bool
    , closeLabel : Maybe String
    , actions : List (Element { button : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { open = False
    , onClose = Nothing
    , alert = False
    , closeButton = False
    , dismissible = True
    , closeLabel = Nothing
    , actions = []
    }


{-| Render the dialog as an introspectable IR node.

    M3e.Dialog.view
        { headline = "Discard changes?"
        , content = [ M3e.Text.bodyMedium "Your unsaved edits will be lost." ]
        }
        [ M3e.Dialog.open state.open
        , M3e.Dialog.onClose DiscardDialogClosed
        , M3e.Dialog.actions
            [ M3e.Button.view { label = "Keep editing", variant = M3e.Button.Text } []
            , M3e.Button.view { label = "Discard", variant = M3e.Button.Filled }
                [ M3e.Button.onClick DiscardConfirmed ]
            ]
        ]

-}
view :
    { headline : String, content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | dialog : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-dialog"
            (List.filterMap identity
                [ Just (Node.property "open" (Encode.bool c.open))
                , Just (Node.property "alert" (Encode.bool c.alert))
                , Just (Node.property "dismissible" (Encode.bool c.closeButton))
                , Just (Node.property "disableClose" (Encode.bool (not c.dismissible)))
                , Maybe.map (Node.attribute "close-label") c.closeLabel
                , Maybe.map (\m -> Node.on "closed" (Decode.succeed m)) c.onClose
                , Maybe.map (\m -> Node.on "cancel" (Decode.succeed m)) c.onClose
                ]
            )
            (List.concat
                [ [ Node.element "span"
                        [ Node.attribute "slot" "header" ]
                        [ Node.text req.headline ]
                  ]
                , List.map Element.toNode req.content
                , case c.actions of
                    [] ->
                        []

                    xs ->
                        [ Node.element "div"
                            [ Node.attribute "slot" "actions" ]
                            (List.map Element.toNode xs)
                        ]
                ]
            )
        )
