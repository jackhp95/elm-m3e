module Ui.ExtendedFab exposing
    ( ExtendedFab
    , Variant(..), Size(..)
    , new
    , withAttributes
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withSize, withLowered, withDisabled


# Action wiring

@docs withOnClick, withHref


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Cem.M3e.Fab
import Ui.Icon


{-| An extended floating action button.
-}
type ExtendedFab msg
    = ExtendedFab (Config msg)


type alias Config msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , attributes : List (Attribute msg)
    , variant : Variant
    , size : Size
    , lowered : Bool
    , disabled : Bool
    , wiring : Maybe (Wiring msg)
    }


{-| FAB variant — one of seven m3 color roles (m3e `variant`, default
`primary-container`).
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
        , attributes = []
        , variant = c.variant
        , size = Medium
        , lowered = False
        , disabled = False
        , wiring = Nothing
        }


{-| Append attributes to the underlying `<m3e-fab>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> ExtendedFab msg -> ExtendedFab msg
withAttributes attributes (ExtendedFab cfg) =
    ExtendedFab { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the FAB size (m3e `size`, default `medium`).
-}
withSize : Size -> ExtendedFab msg -> ExtendedFab msg
withSize s (ExtendedFab cfg) =
    ExtendedFab { cfg | size = s }


{-| Present a lowered resting elevation (m3e `lowered`, default false).
-}
withLowered : Bool -> ExtendedFab msg -> ExtendedFab msg
withLowered b (ExtendedFab cfg) =
    ExtendedFab { cfg | lowered = b }


{-| Disable the FAB (m3e `disabled`, default false).
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
    Cem.M3e.Fab.component
        (List.concat
            [ cfg.attributes
            , [ Cem.M3e.Fab.extended True
              , variantAttr cfg.variant
              , sizeAttr cfg.size
              , Cem.M3e.Fab.lowered cfg.lowered
              , Cem.M3e.Fab.disabled cfg.disabled
              ]
            , wiringAttrs cfg.wiring
            ]
        )
        [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.icon ]
        , Html.span [ Cem.M3e.Fab.labelSlot ] [ Html.text cfg.label ]
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Primary ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.Primary

        PrimaryContainer ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.PrimaryContainer

        Secondary ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.Secondary

        SecondaryContainer ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.SecondaryContainer

        Tertiary ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.Tertiary

        TertiaryContainer ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.TertiaryContainer

        Surface ->
            Cem.M3e.Fab.variant Cem.M3e.Fab.Surface


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            Cem.M3e.Fab.size Cem.M3e.Fab.Small

        Medium ->
            Cem.M3e.Fab.size Cem.M3e.Fab.Medium

        Large ->
            Cem.M3e.Fab.size Cem.M3e.Fab.Large


wiringAttrs : Maybe (Wiring msg) -> List (Html.Attribute msg)
wiringAttrs maybeWiring =
    case maybeWiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            [ Cem.M3e.Fab.href href ]
