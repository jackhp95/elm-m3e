module Ui.SideSheet exposing
    ( SideSheet
    , Side(..)
    , new
    , withAttributes
    , withId, withBody, withActions, withSide, withModal, withContent
    , view
    )

{-| Typed builder for a side-anchored sheet (`<m3e-drawer-container>`
panel in side mode). Mirrors the Material 3 [Side sheets][m3] surface.

[m3]: https://m3.material.io/components/side-sheets/overview

A side sheet is a panel anchored to the start or end edge of the
viewport, holding **supplementary** content for the current view —
filters, details, a contextual editor. (For top-level destination
switching reach for `Ui.NavigationDrawer` instead; both ride
`<m3e-drawer-container>`, but the side sheet is content, not navigation.)
It can be **modal** (overlays content with a scrim) or **non-modal**
(occupies layout alongside content).

Note: m3e ships side-sheets via `<m3e-drawer-container>` rather than a
dedicated `<m3e-side-sheet>`. This module renders the drawer with the
appropriate side + mode attributes. Project your page's main content
into the container with [`withContent`](#withContent) so the sheet
sits beside (or overlays) it and the element manages the push/overlay
and open/close transitions.


# Open state is caller-owned

Same shape as `Ui.Dialog` / `Ui.BottomSheet`.


# Quick example

    Ui.SideSheet.new
        { open = state.filtersOpen
        , onClose = FiltersClosed
        }
        |> Ui.SideSheet.withSide Ui.SideSheet.End
        |> Ui.SideSheet.withBody filtersForm
        |> Ui.SideSheet.withContent [ pageBody ]
        |> Ui.SideSheet.view


# Type

@docs SideSheet


# Configuration

@docs Side


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withBody, withActions, withSide, withModal, withContent


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import Cem.M3e.DrawerContainer
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
    , attributes : List (Attribute msg)
    , open : Bool
    , onClose : msg
    , side : Side
    , modal : Bool
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , content : List (Html msg)
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a side sheet. Default `End`, modal.
-}
new : { open : Bool, onClose : msg } -> SideSheet msg
new c =
    SideSheet
        { id = Nothing
        , attributes = []
        , open = c.open
        , onClose = c.onClose
        , side = End
        , modal = True
        , body = Nothing
        , actions = []
        , content = []
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-drawer-container>` host element —
the escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> SideSheet msg -> SideSheet msg
withAttributes attributes (SideSheet cfg) =
    SideSheet { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> SideSheet msg -> SideSheet msg
withId id (SideSheet cfg) =
    SideSheet { cfg | id = Just id }


{-| Set the panel's body content — rendered into the drawer's `start`/`end`
slot (per `withSide`), above any actions.
-}
withBody : Html msg -> SideSheet msg -> SideSheet msg
withBody body (SideSheet cfg) =
    SideSheet { cfg | body = Just body }


{-| Set the panel's actions row — buttons rendered into the same `start`/`end`
slot, below the body. Replaces any previously set actions.
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


{-| Project the host's main page content into the drawer container's default
slot, so the sheet sits beside it (non-modal) or overlays it with a scrim
(modal) and the element manages the layout + open/close transitions.
-}
withContent : List (Html msg) -> SideSheet msg -> SideSheet msg
withContent content (SideSheet cfg) =
    SideSheet { cfg | content = content }



-- RENDER -----------------------------------------------------------------


{-| Render the side sheet.
-}
view : SideSheet msg -> Html msg
view (SideSheet cfg) =
    -- Always render the container so the projected main content (default slot)
    -- persists and the element animates open/close. `open` is a controlled
    -- property on the configured side.
    Cem.M3e.DrawerContainer.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (openAttr cfg)
                , Just (modeAttr cfg)
                , Just (Cem.M3e.DrawerContainer.onChange (Decode.succeed cfg.onClose))
                ]
        )
        (panelElement cfg :: cfg.content)


openAttr : Config msg -> Html.Attribute msg
openAttr cfg =
    case cfg.side of
        Start ->
            Cem.M3e.DrawerContainer.start cfg.open

        End ->
            Cem.M3e.DrawerContainer.end cfg.open


modeAttr : Config msg -> Html.Attribute msg
modeAttr cfg =
    let
        mode : ( Cem.M3e.DrawerContainer.StartMode, Cem.M3e.DrawerContainer.EndMode )
        mode =
            if cfg.modal then
                ( Cem.M3e.DrawerContainer.StartModeOver, Cem.M3e.DrawerContainer.EndModeOver )

            else
                ( Cem.M3e.DrawerContainer.StartModeSide, Cem.M3e.DrawerContainer.EndModeSide )
    in
    case cfg.side of
        Start ->
            Cem.M3e.DrawerContainer.startMode (Tuple.first mode)

        End ->
            Cem.M3e.DrawerContainer.endMode (Tuple.second mode)


{-| The panel content — body + actions — routed into the slot matching
the configured side (`start` or `end`). The default slot is reserved
for the host's main content, which callers compose themselves.
-}
panelElement : Config msg -> Html msg
panelElement cfg =
    Html.div [ slotAttr cfg ]
        (List.concat
            [ bodyContent cfg.body
            , List.map Ui.Button.view cfg.actions
            ]
        )


slotAttr : Config msg -> Html.Attribute msg
slotAttr cfg =
    case cfg.side of
        Start ->
            Cem.M3e.DrawerContainer.startSlot

        End ->
            Cem.M3e.DrawerContainer.endSlot


bodyContent : Maybe (Html msg) -> List (Html msg)
bodyContent body =
    case body of
        Nothing ->
            []

        Just b ->
            [ b ]
