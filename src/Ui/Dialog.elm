module Ui.Dialog exposing
    ( Dialog
    , new
    , withAttributes
    , withId, withBody, withActions
    , withDismissible, withCloseButton, withAlert
    , view
    )

{-| Typed builder for `<m3e-dialog>` — a modal surface that overlays the
page to focus the user on a single task. Mirrors the Material 3
[Dialogs][m3] surface.

[m3]: https://m3.material.io/components/dialogs/overview


# Open state is caller-owned

A dialog has no hidden state. Pass the current `open : Bool` through
`new`, and supply an `onClose` handler that fires when the user
dismisses the dialog (Escape, scrim click, programmatic close). Your
`update` flips your model field to `False`.

This shape — explicit `open` + `onClose` — matches the rest of the
library: rendering is a pure function of state.


# Required-by-design

`new` requires:

  - `title` — visible headline. Per Material guidance, every dialog
    has one short, descriptive title.
  - `open` — whether the dialog is currently visible.
  - `onClose` — handler for user-initiated dismiss.


# Quick examples

A confirmation dialog with two actions:

    Ui.Dialog.new
        { title = "Discard changes?"
        , open = state.confirmDiscardOpen
        , onClose = ConfirmDiscardClosed
        }
        |> Ui.Dialog.withBody (text "Your unsaved edits will be lost.")
        |> Ui.Dialog.withActions
            [ Ui.Button.new { label = "Keep editing", variant = Ui.Button.Text }
                |> Ui.Button.withOnClick ConfirmDiscardClosed
            , Ui.Button.new { label = "Discard", variant = Ui.Button.Filled }
                |> Ui.Button.withOnClick DiscardConfirmed
            ]
        |> Ui.Dialog.view

An alert dialog (semantic role):

    Ui.Dialog.new { title = "Submission failed", open = errorOpen, onClose = ErrorDismissed }
        |> Ui.Dialog.withAlert True
        |> Ui.Dialog.withBody (text "Please check your connection and retry.")
        |> Ui.Dialog.view


# Type

@docs Dialog


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withBody, withActions
@docs withDismissible, withCloseButton, withAlert


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Dialog
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A modal dialog. Built with `new`, configured with `with*` modifiers.
-}
type Dialog msg
    = Dialog (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , title : String
    , open : Bool
    , onClose : msg
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , dismissible : Bool
    , closeButton : Bool
    , alert : Bool
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a dialog.

    Ui.Dialog.new
        { title = "Discard changes?"
        , open = state.confirmDiscardOpen
        , onClose = ConfirmDiscardClosed
        }
        |> Ui.Dialog.view

-}
new : { title : String, open : Bool, onClose : msg } -> Dialog msg
new c =
    Dialog
        { id = Nothing
        , attributes = []
        , title = c.title
        , open = c.open
        , onClose = c.onClose
        , body = Nothing
        , actions = []
        , dismissible = True
        , closeButton = False
        , alert = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-dialog>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Dialog msg -> Dialog msg
withAttributes attributes (Dialog cfg) =
    Dialog { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Dialog msg -> Dialog msg
withId id (Dialog cfg) =
    Dialog { cfg | id = Just id }


{-| Set the dialog's body content.
-}
withBody : Html msg -> Dialog msg -> Dialog msg
withBody body (Dialog cfg) =
    Dialog { cfg | body = Just body }


{-| Set the actions row. Takes `Ui.Button.Button msg` values — action
buttons by convention (toggles aren't standard in dialog actions).

    |> Ui.Dialog.withActions
        [ Ui.Button.new { label = "Cancel", variant = Ui.Button.Text }
            |> Ui.Button.withOnClick CancelClicked
        , Ui.Button.new { label = "Confirm", variant = Ui.Button.Filled }
            |> Ui.Button.withOnClick ConfirmClicked
        ]

-}
withActions :
    List (Ui.Button.Button msg)
    -> Dialog msg
    -> Dialog msg
withActions actions (Dialog cfg) =
    Dialog { cfg | actions = actions }


{-| Toggle whether the dialog can be dismissed by Escape / scrim click.
Default `True`. Set `False` for dialogs that require an explicit action
choice (delete confirmations, etc.).

This wires the underlying element's `disable-close` attribute (inverted):
`withDismissible False` emits `disable-close`, blocking both backdrop
click and the Escape key.

-}
withDismissible : Bool -> Dialog msg -> Dialog msg
withDismissible b (Dialog cfg) =
    Dialog { cfg | dismissible = b }


{-| Show a built-in close button in the dialog chrome. Default `False`.

This wires the underlying element's `dismissible` attribute, which —
despite the name — controls _only_ whether a close **button** is
presented. Escape / scrim dismissal is governed separately by
`withDismissible`.

-}
withCloseButton : Bool -> Dialog msg -> Dialog msg
withCloseButton b (Dialog cfg) =
    Dialog { cfg | closeButton = b }


{-| Mark the dialog as an alert (sets ARIA `role=alertdialog`).
Use for messages that interrupt the user about an important state
change (failure, irreversible action).
-}
withAlert : Bool -> Dialog msg -> Dialog msg
withAlert b (Dialog cfg) =
    Dialog { cfg | alert = b }



-- RENDER -----------------------------------------------------------------


{-| Render the dialog. Returns an empty node when `open` is `False`
(so callers can render unconditionally).
-}
view : Dialog msg -> Html msg
view (Dialog cfg) =
    if not cfg.open then
        Html.text ""

    else
        M3e.Dialog.component
            (cfg.attributes
                ++ List.filterMap identity
                    [ Maybe.map Attr.id cfg.id
                    , Just (M3e.Dialog.open "true")
                    , Just (M3e.Dialog.alert cfg.alert)
                    , Just (M3e.Dialog.dismissible cfg.closeButton)
                    , Just (M3e.Dialog.disableClose (not cfg.dismissible))
                    , Just (M3e.Dialog.onClosed (Decode.succeed cfg.onClose))
                    , Just (M3e.Dialog.onCancel (Decode.succeed cfg.onClose))
                    ]
            )
            (List.concat
                [ [ titleElement cfg ]
                , bodyElement cfg.body
                , actionsElement cfg.actions
                ]
            )


titleElement : Config msg -> Html msg
titleElement cfg =
    Html.h2 [ M3e.Dialog.headerSlot ] [ Html.text cfg.title ]


bodyElement : Maybe (Html msg) -> List (Html msg)
bodyElement body =
    case body of
        Nothing ->
            []

        Just b ->
            [ b ]


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ M3e.Dialog.actionsSlot ]
                (List.map Ui.Button.view actions)
            ]
