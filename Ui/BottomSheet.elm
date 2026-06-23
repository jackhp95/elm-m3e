module Ui.BottomSheet exposing
    ( BottomSheet
    , new
    , withId, withBody, withActions, withHandle, withHideable
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
handler. Rendering is pure.


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

@docs withId, withBody, withActions, withHandle, withHideable


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.BottomSheet
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
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , handle : Bool
    , hideable : Bool
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
        , body = Nothing
        , actions = []
        , handle = True
        , hideable = True
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> BottomSheet msg -> BottomSheet msg
withId id (BottomSheet cfg) =
    BottomSheet { cfg | id = Just id }


{-| Set the sheet's body content.
-}
withBody : Html msg -> BottomSheet msg -> BottomSheet msg
withBody body (BottomSheet cfg) =
    BottomSheet { cfg | body = Just body }


{-| Set the actions row.
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
                , Just (M3e.BottomSheet.handle cfg.handle)
                , Just (M3e.BottomSheet.hideable cfg.hideable)
                ]
            )
            (List.concat
                [ bodyElement cfg.body
                , actionsElement cfg.actions
                ]
            )


bodyElement : Maybe (Html msg) -> List (Html msg)
bodyElement body =
    case body of
        Nothing ->
            []

        Just b ->
            [ Html.div [ Attr.class "ds-bottom-sheet-body" ] [ b ] ]


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ Attr.class "ds-bottom-sheet-actions" ]
                (List.map Ui.Button.view actions)
            ]
