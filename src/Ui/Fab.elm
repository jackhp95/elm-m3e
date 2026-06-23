module Ui.Fab exposing
    ( Fab
    , Variant(..), Size(..)
    , new
    , withSize, withLowered, withDisabled
    , withOnClick, withHref
    , view
    )

{-| Typed builder for `<m3e-fab>` — a floating action button that
hovers above content for a region's primary action. Mirrors the
Material 3 [Floating action button][m3] surface.

[m3]: https://m3.material.io/components/floating-action-button/overview

For a FAB with visible label text, see `Ui.ExtendedFab`. For a FAB that
opens a menu, see `Ui.FabMenu`.


# Type

@docs Fab


# Configuration

@docs Variant, Size


# Constructor

@docs new


# Modifiers

@docs withSize, withLowered, withDisabled


# Action wiring (mutually exclusive — last-write-wins)

@docs withOnClick, withHref


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Fab
import Ui.Icon


{-| A floating action button.
-}
type Fab msg
    = Fab (Config msg)


type alias Config msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , variant : Variant
    , size : Size
    , lowered : Bool
    , disabled : Bool
    , wiring : Maybe (Wiring msg)
    }


{-| FAB variant (m3 color roles).
-}
type Variant
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Tertiary
    | TertiaryContainer
    | Surface


{-| FAB size. Defaults to `Medium`.
-}
type Size
    = Small
    | Medium
    | Large


type Wiring msg
    = WireClick msg
    | WireHref String


{-| Construct a FAB. `label` is required for accessibility (rendered
as aria-label).
-}
new :
    { icon : Ui.Icon.Icon msg, label : String, variant : Variant }
    -> Fab msg
new c =
    Fab
        { icon = c.icon
        , label = c.label
        , variant = c.variant
        , size = Medium
        , lowered = False
        , disabled = False
        , wiring = Nothing
        }


{-| Set the size.
-}
withSize : Size -> Fab msg -> Fab msg
withSize s (Fab cfg) =
    Fab { cfg | size = s }


{-| Render in lowered elevation.
-}
withLowered : Bool -> Fab msg -> Fab msg
withLowered b (Fab cfg) =
    Fab { cfg | lowered = b }


{-| Disable the FAB.
-}
withDisabled : Bool -> Fab msg -> Fab msg
withDisabled b (Fab cfg) =
    Fab { cfg | disabled = b }


{-| Wire a click action. Last-write-wins with `withHref`.
-}
withOnClick : msg -> Fab msg -> Fab msg
withOnClick msg (Fab cfg) =
    Fab { cfg | wiring = Just (WireClick msg) }


{-| Wire navigation. Last-write-wins with `withOnClick`.
-}
withHref : String -> Fab msg -> Fab msg
withHref href (Fab cfg) =
    Fab { cfg | wiring = Just (WireHref href) }


{-| Render the FAB.
-}
view : Fab msg -> Html msg
view (Fab cfg) =
    M3e.Fab.component
        (List.concat
            [ [ Attr.attribute "aria-label" cfg.label
              , Attr.title cfg.label
              , variantAttr cfg.variant
              , sizeAttr cfg.size
              , M3e.Fab.lowered cfg.lowered
              , M3e.Fab.disabled cfg.disabled
              ]
            , wiringAttrs cfg.wiring
            ]
        )
        [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.icon ] ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Primary ->
            (M3e.Fab.variant M3e.Fab.Primary)

        PrimaryContainer ->
            (M3e.Fab.variant M3e.Fab.PrimaryContainer)

        Secondary ->
            (M3e.Fab.variant M3e.Fab.Secondary)

        SecondaryContainer ->
            (M3e.Fab.variant M3e.Fab.SecondaryContainer)

        Tertiary ->
            (M3e.Fab.variant M3e.Fab.Tertiary)

        TertiaryContainer ->
            (M3e.Fab.variant M3e.Fab.TertiaryContainer)

        Surface ->
            (M3e.Fab.variant M3e.Fab.Surface)


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            (M3e.Fab.size M3e.Fab.Small)

        Medium ->
            (M3e.Fab.size M3e.Fab.Medium)

        Large ->
            (M3e.Fab.size M3e.Fab.Large)


wiringAttrs : Maybe (Wiring msg) -> List (Html.Attribute msg)
wiringAttrs maybeWiring =
    case maybeWiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            [ M3e.Fab.href href ]
