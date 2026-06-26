module M3e.Dialog exposing
    ( Option
    , view
    , open, onClose, alert, closeButton, dismissible, closeLabel, actions
    )

{-| `<m3e-dialog>` — a modal surface for a single focused task (Material 3
Dialogs).

Spec (per docs/CONVENTIONS.md):

  - Required:   { headline : String, content : List (Renderable any msg) }
                headline → visible title, always present (accessibility + UX);
                content  → the dialog body region (default slot, free row)
  - Options:    open, onClose, alert, closeButton, dismissible, closeLabel, actions
  - Slots:      header (headline in <span slot="header">)
                default (content region — free row, may include html escape)
                actions (<div slot="actions"> wrapping the button list)
                close-icon (not exposed here; use Renderable.element for custom)
  - Properties: open (bool), alert (bool), dismissible (bool — close button),
                disable-close (bool — ESC/scrim blocking, inverted from the
                `dismissible` option below)
  - Events:     closed → onClose msg; cancel → onClose msg
  - Tag:        dialog

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

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Open Bool
    | OnClose msg
    | Alert Bool
    | CloseButton Bool
    | Dismissible Bool
    | CloseLabel String
    | Actions (List (Renderable { button : Supported } msg))


{-| Whether the dialog is open. Sets the `open` DOM property. Default false. -}
open : Bool -> Option msg
open =
    Open


{-| Handler for user-initiated dismiss. Wired to both the `closed` and
`cancel` events so Escape, scrim click, and programmatic close all fire it.
-}
onClose : msg -> Option msg
onClose =
    OnClose


{-| Mark the dialog as an alert (`role=alertdialog`). Use for important
state changes (failures, irreversible actions). Default false.
-}
alert : Bool -> Option msg
alert =
    Alert


{-| Show a built-in close button in the dialog chrome (the `dismissible` DOM
property). Default false.
-}
closeButton : Bool -> Option msg
closeButton =
    CloseButton


{-| Whether the dialog can be dismissed by ESC or clicking the scrim
(inverts `disable-close`). Default true — ESC and scrim work. Set false
for dialogs that require an explicit action choice.
-}
dismissible : Bool -> Option msg
dismissible =
    Dismissible


{-| Accessible label for the built-in close button (the `close-label`
attribute). Only meaningful alongside `closeButton True`.
-}
closeLabel : String -> Option msg
closeLabel =
    CloseLabel


{-| Action buttons shown in the dialog's `actions` slot. Accepts M3e buttons.
-}
actions : List (Renderable { button : Supported } msg) -> Option msg
actions =
    Actions


type alias Config msg =
    { open : Bool
    , onClose : Maybe msg
    , alert : Bool
    , closeButton : Bool
    , dismissible : Bool
    , closeLabel : Maybe String
    , actions : List (Renderable { button : Supported } msg)
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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        Open b ->
            { c | open = b }

        OnClose m ->
            { c | onClose = Just m }

        Alert b ->
            { c | alert = b }

        CloseButton b ->
            { c | closeButton = b }

        Dismissible b ->
            { c | dismissible = b }

        CloseLabel s ->
            { c | closeLabel = Just s }

        Actions xs ->
            { c | actions = xs }


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
    { headline : String, content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | dialog : Supported } msg
view req opts =
    let
        c =
            List.foldl apply defaultConfig opts
    in
    Renderable.fromNode
        (Node.element "m3e-dialog"
            (List.filterMap identity
                [ Just (Node.property "open" (Encode.bool c.open))
                , if c.alert then
                    Just (Node.property "alert" (Encode.bool True))

                  else
                    Nothing
                , if c.closeButton then
                    Just (Node.property "dismissible" (Encode.bool True))

                  else
                    Nothing
                , if not c.dismissible then
                    Just (Node.property "disable-close" (Encode.bool True))

                  else
                    Nothing
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
                , List.map Renderable.toNode req.content
                , case c.actions of
                    [] ->
                        []

                    xs ->
                        [ Node.element "div"
                            [ Node.attribute "slot" "actions" ]
                            (List.map Renderable.toNode xs)
                        ]
                ]
            )
        )
