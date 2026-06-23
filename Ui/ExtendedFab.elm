module Ui.ExtendedFab exposing
    ( ExtendedFab
    , Variant(..), Size(..)
    , new
    , withSize, withLowered, withDisabled
    , withOnClick, withHref
    , view
    )

{-| Typed builder for the _extended_ form of `<m3e-fab>` — a floating
action button with visible label. Mirrors the Material 3
[Extended FAB][m3] surface.

[m3]: https://m3.material.io/components/extended-fab/overview

For the icon-only floating action button, see `Ui.Fab`. The extended
variant adds the visible label and is typically used when the action
needs explicit text.

Renders `<m3e-fab>` with the `extended` attribute set (m3e represents
extended-FAB as a variant on the regular FAB element).


# Type

@docs ExtendedFab


# Configuration

@docs Variant, Size


# Constructor

@docs new


# Modifiers

@docs withSize, withLowered, withDisabled


# Action wiring

@docs withOnClick, withHref


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Fab
import Ui.Icon


{-| An extended floating action button.
-}
type ExtendedFab msg
    = ExtendedFab (Config msg)


type alias Config msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , variant : Variant
    , size : Size
    , lowered : Bool
    , disabled : Bool
    , wiring : Maybe (Wiring msg)
    }


{-| FAB variant.
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


{-| Construct an extended FAB with required icon + label + variant.
-}
new :
    { icon : Ui.Icon.Icon msg, label : String, variant : Variant }
    -> ExtendedFab msg
new c =
    ExtendedFab
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
withSize : Size -> ExtendedFab msg -> ExtendedFab msg
withSize s (ExtendedFab cfg) =
    ExtendedFab { cfg | size = s }


{-| Render in lowered elevation.
-}
withLowered : Bool -> ExtendedFab msg -> ExtendedFab msg
withLowered b (ExtendedFab cfg) =
    ExtendedFab { cfg | lowered = b }


{-| Disable the FAB.
-}
withDisabled : Bool -> ExtendedFab msg -> ExtendedFab msg
withDisabled b (ExtendedFab cfg) =
    ExtendedFab { cfg | disabled = b }


{-| Wire a click action.
-}
withOnClick : msg -> ExtendedFab msg -> ExtendedFab msg
withOnClick msg (ExtendedFab cfg) =
    ExtendedFab { cfg | wiring = Just (WireClick msg) }


{-| Wire navigation.
-}
withHref : String -> ExtendedFab msg -> ExtendedFab msg
withHref href (ExtendedFab cfg) =
    ExtendedFab { cfg | wiring = Just (WireHref href) }


{-| Render the extended FAB.
-}
view : ExtendedFab msg -> Html msg
view (ExtendedFab cfg) =
    M3e.Fab.component
        (List.concat
            [ [ M3e.Fab.extended True
              , variantAttr cfg.variant
              , sizeAttr cfg.size
              , M3e.Fab.lowered cfg.lowered
              , M3e.Fab.disabled cfg.disabled
              ]
            , wiringAttrs cfg.wiring
            ]
        )
        [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.icon ]
        , Html.text cfg.label
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Primary ->
            M3e.Fab.variantPrimary

        PrimaryContainer ->
            M3e.Fab.variantPrimaryContainer

        Secondary ->
            M3e.Fab.variantSecondary

        SecondaryContainer ->
            M3e.Fab.variantSecondaryContainer

        Tertiary ->
            M3e.Fab.variantTertiary

        TertiaryContainer ->
            M3e.Fab.variantTertiaryContainer

        Surface ->
            M3e.Fab.variantSurface


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            M3e.Fab.sizeSmall

        Medium ->
            M3e.Fab.sizeMedium

        Large ->
            M3e.Fab.sizeLarge


wiringAttrs : Maybe (Wiring msg) -> List (Html.Attribute msg)
wiringAttrs maybeWiring =
    case maybeWiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            [ M3e.Fab.href href ]
