module Ui.Dialog exposing
    ( Dialog
    , new
    , withId, withBody, withActions
    , withDismissible, withAlert, withFullScreen
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


# Modifiers

@docs withId, withBody, withActions
@docs withDismissible, withAlert, withFullScreen


# Render

@docs view

-}

import Html exposing (Html)
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
    , title : String
    , open : Bool
    , onClose : msg
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , dismissible : Bool
    , alert : Bool
    , fullScreen : Bool
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
        , title = c.title
        , open = c.open
        , onClose = c.onClose
        , body = Nothing
        , actions = []
        , dismissible = True
        , alert = False
        , fullScreen = False
        }



-- MODIFIERS --------------------------------------------------------------


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
-}
withDismissible : Bool -> Dialog msg -> Dialog msg
withDismissible b (Dialog cfg) =
    Dialog { cfg | dismissible = b }


{-| Mark the dialog as an alert (sets ARIA `role=alertdialog`).
Use for messages that interrupt the user about an important state
change (failure, irreversible action).
-}
withAlert : Bool -> Dialog msg -> Dialog msg
withAlert b (Dialog cfg) =
    Dialog { cfg | alert = b }


{-| Switch to full-screen mode (m3's second dialog type). Use for
dialogs that contain a complete task workflow.
-}
withFullScreen : Bool -> Dialog msg -> Dialog msg
withFullScreen b (Dialog cfg) =
    Dialog { cfg | fullScreen = b }



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
            (List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Dialog.open "true")
                , Just (M3e.Dialog.alert cfg.alert)
                , Just (M3e.Dialog.dismissible cfg.dismissible)
                , maybeAttr cfg.fullScreen (Attr.attribute "full-screen" "true")
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


maybeAttr : Bool -> Html.Attribute msg -> Maybe (Html.Attribute msg)
maybeAttr b a =
    if b then
        Just a

    else
        Nothing


titleElement : Config msg -> Html msg
titleElement cfg =
    Html.h2
        [ M3e.Dialog.headerSlot
        , Attr.class "ds-dialog-headline"
        ]
        [ Html.text cfg.title ]


bodyElement : Maybe (Html msg) -> List (Html msg)
bodyElement body =
    case body of
        Nothing ->
            []

        Just b ->
            [ Html.div [ Attr.class "ds-dialog-body" ] [ b ] ]


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div
                [ M3e.Dialog.actionsSlot, Attr.class "ds-dialog-actions" ]
                (List.map Ui.Button.view actions)
            ]
