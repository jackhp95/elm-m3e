module Ui.BottomSheet exposing
    ( BottomSheet
    , new
    , withId, withHeader, withBody, withActions, withHandle, withHideable, withModal
    , view
    )

{-| Typed builder for `<m3e-bottom-sheet>` — a surface that slides up
from the bottom of the viewport. Mirrors the Material 3
[Bottom sheets][m3] surface.

[m3]: https://m3.material.io/components/bottom-sheets/overview

Bottom sheets are most useful on small viewports for action menus,
detail panes, or task workflows. Use a `Ui.Dialog` for desktop-centric
modal flows.


# Open state is caller-owned

Same shape as `Ui.Dialog`: pass `open : Bool`, supply an `onClose`
handler. Rendering is pure — the `open` attribute drives the element,
and the element's `closed`/`cancel` events are wired back to `onClose`.


# Required-by-design

  - `open` — current visibility.
  - `onClose` — handler for user dismiss.


# Quick example

    Ui.BottomSheet.new { open = state.detailsOpen, onClose = DetailsClosed }
        |> Ui.BottomSheet.withBody supplierDetails
        |> Ui.BottomSheet.view


# Type

@docs BottomSheet


# Constructor

@docs new


# Modifiers

@docs withId, withHeader, withBody, withActions, withHandle, withHideable, withModal


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.BottomSheet
import M3e.BottomSheetAction
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A bottom sheet.
-}
type BottomSheet msg
    = BottomSheet (Config msg)


type alias Config msg =
    { id : Maybe String
    , open : Bool
    , onClose : msg
    , header : Maybe (Html msg)
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , handle : Bool
    , hideable : Bool
    , modal : Bool
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a bottom sheet.
-}
new : { open : Bool, onClose : msg } -> BottomSheet msg
new c =
    BottomSheet
        { id = Nothing
        , open = c.open
        , onClose = c.onClose
        , header = Nothing
        , body = Nothing
        , actions = []
        , handle = True
        , hideable = True
        , modal = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> BottomSheet msg -> BottomSheet msg
withId id (BottomSheet cfg) =
    BottomSheet { cfg | id = Just id }


{-| Set the sheet's header content (rendered in the `header` slot).
-}
withHeader : Html msg -> BottomSheet msg -> BottomSheet msg
withHeader header (BottomSheet cfg) =
    BottomSheet { cfg | header = Just header }


{-| Set the sheet's body content (rendered in the default slot).
-}
withBody : Html msg -> BottomSheet msg -> BottomSheet msg
withBody body (BottomSheet cfg) =
    BottomSheet { cfg | body = Just body }


{-| Set the actions. Each is rendered as an `<m3e-bottom-sheet-action>`
element so that activating it closes the parent sheet.
-}
withActions :
    List (Ui.Button.Button msg)
    -> BottomSheet msg
    -> BottomSheet msg
withActions actions (BottomSheet cfg) =
    BottomSheet { cfg | actions = actions }


{-| Show the drag handle (the small bar at the top of the sheet that
indicates draggability). Default `True`.
-}
withHandle : Bool -> BottomSheet msg -> BottomSheet msg
withHandle b (BottomSheet cfg) =
    BottomSheet { cfg | handle = b }


{-| Allow the user to dismiss the sheet by dragging it down. Default `True`.
-}
withHideable : Bool -> BottomSheet msg -> BottomSheet msg
withHideable b (BottomSheet cfg) =
    BottomSheet { cfg | hideable = b }


{-| Make the sheet modal (overlays content with a scrim). Default `False`.
-}
withModal : Bool -> BottomSheet msg -> BottomSheet msg
withModal b (BottomSheet cfg) =
    BottomSheet { cfg | modal = b }



-- RENDER -----------------------------------------------------------------


{-| Render the bottom sheet. Empty node when `open = False`.
-}
view : BottomSheet msg -> Html msg
view (BottomSheet cfg) =
    if not cfg.open then
        Html.text ""

    else
        M3e.BottomSheet.component
            (List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.BottomSheet.open True)
                , Just (M3e.BottomSheet.handle cfg.handle)
                , Just (M3e.BottomSheet.hideable cfg.hideable)
                , Just (M3e.BottomSheet.modal cfg.modal)
                , Just (M3e.BottomSheet.onClosed (Decode.succeed cfg.onClose))
                , Just (M3e.BottomSheet.onCancel (Decode.succeed cfg.onClose))
                ]
            )
            (List.concat
                [ headerElement cfg.header
                , bodyElement cfg.body
                , actionsElement cfg.actions
                ]
            )


headerElement : Maybe (Html msg) -> List (Html msg)
headerElement header =
    case header of
        Nothing ->
            []

        Just h ->
            [ Html.div [ M3e.BottomSheet.headerSlot ] [ h ] ]


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
    List.map
        (\button ->
            M3e.BottomSheetAction.component [] [ Ui.Button.view button ]
        )
        actions
