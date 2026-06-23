module Ui.SideSheet exposing
    ( SideSheet
    , Side(..)
    , new
    , withId, withBody, withActions, withSide, withModal
    , view
    )

{-| Typed builder for a side-anchored sheet (`<m3e-drawer-container>`
panel in side mode). Mirrors the Material 3 [Side sheets][m3] surface.

[m3]: https://m3.material.io/components/side-sheets/overview

A side sheet is a panel anchored to the start or end edge of the
viewport. It can be **modal** (overlays content with a scrim) or
**non-modal** (occupies layout alongside content).

Note: m3e ships side-sheets via `<m3e-drawer-container>` rather than a
dedicated `<m3e-side-sheet>`. This module renders the drawer with the
appropriate side + mode attributes. The full host-layout
DrawerContainer integration (split with main content) is a known v1
gap; callers wrap their page composition themselves.


# Open state is caller-owned

Same shape as `Ui.Dialog` / `Ui.BottomSheet`.


# Quick example

    Ui.SideSheet.new
        { open = state.filtersOpen
        , onClose = FiltersClosed
        }
        |> Ui.SideSheet.withSide Ui.SideSheet.End
        |> Ui.SideSheet.withBody filtersForm
        |> Ui.SideSheet.view


# Type

@docs SideSheet


# Configuration

@docs Side


# Constructor

@docs new


# Modifiers

@docs withId, withBody, withActions, withSide, withModal


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.DrawerContainer
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A side sheet.
-}
type SideSheet msg
    = SideSheet (Config msg)


{-| Which edge of the viewport the sheet is anchored to.
-}
type Side
    = Start
    | End


type alias Config msg =
    { id : Maybe String
    , open : Bool
    , onClose : msg
    , side : Side
    , modal : Bool
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a side sheet. Default `End`, modal.
-}
new : { open : Bool, onClose : msg } -> SideSheet msg
new c =
    SideSheet
        { id = Nothing
        , open = c.open
        , onClose = c.onClose
        , side = End
        , modal = True
        , body = Nothing
        , actions = []
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> SideSheet msg -> SideSheet msg
withId id (SideSheet cfg) =
    SideSheet { cfg | id = Just id }


{-| Set the body content.
-}
withBody : Html msg -> SideSheet msg -> SideSheet msg
withBody body (SideSheet cfg) =
    SideSheet { cfg | body = Just body }


{-| Set the actions row.
-}
withActions :
    List (Ui.Button.Button msg)
    -> SideSheet msg
    -> SideSheet msg
withActions actions (SideSheet cfg) =
    SideSheet { cfg | actions = actions }


{-| Set which edge the sheet anchors to (default `End`).
-}
withSide : Side -> SideSheet msg -> SideSheet msg
withSide s (SideSheet cfg) =
    SideSheet { cfg | side = s }


{-| Set modal (`True`, scrim + dismisses on click-outside) vs non-modal
(`False`, occupies layout). Default `True`.
-}
withModal : Bool -> SideSheet msg -> SideSheet msg
withModal b (SideSheet cfg) =
    SideSheet { cfg | modal = b }



-- RENDER -----------------------------------------------------------------


{-| Render the side sheet.
-}
view : SideSheet msg -> Html msg
view (SideSheet cfg) =
    if not cfg.open then
        Html.text ""

    else
        M3e.DrawerContainer.component
            (List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (sideAttr cfg)
                , Just (modeAttr cfg)
                ]
            )
            (List.concat
                [ bodyElement cfg.body
                , actionsElement cfg.actions
                ]
            )


sideAttr : Config msg -> Html.Attribute msg
sideAttr cfg =
    case cfg.side of
        Start ->
            M3e.DrawerContainer.start True

        End ->
            M3e.DrawerContainer.end True


modeAttr : Config msg -> Html.Attribute msg
modeAttr cfg =
    let
        attrName : String
        attrName =
            case cfg.side of
                Start ->
                    "start-mode"

                End ->
                    "end-mode"

        value : String
        value =
            if cfg.modal then
                "over"

            else
                "side"
    in
    Attr.attribute attrName value


bodyElement : Maybe (Html msg) -> List (Html msg)
bodyElement body =
    case body of
        Nothing ->
            []

        Just b ->
            [ Html.div [ Attr.class "ds-side-sheet-body" ] [ b ] ]


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ Attr.class "ds-side-sheet-actions" ]
                (List.map Ui.Button.view actions)
            ]
