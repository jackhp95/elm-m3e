module Ui.IconButton exposing
    ( IconButton
    , Variant(..), Size(..), Shape(..), Width(..), DisabledState(..)
    , new
    , withSize, withShape, withWidth, withDisabled
    , withOnClick, withHref, withToggle
    , view
    )

{-| Typed builder for `<m3e-icon-button>` — a one-tap minor action
represented by a single glyph and no visible text label. Mirrors the
Material 3 [Icon buttons][m3] surface 1:1.

[m3]: https://m3.material.io/components/icon-buttons/overview

For labeled actions, see `Ui.Button`.


# Action wiring is a builder, not a constructor

`withOnClick` / `withHref` / `withToggle` are mutually exclusive
setters (**last-write-wins**) — a deliberate MISI carve-out matching
`Ui.Button`. The rule: only set one.


# Required-by-design

`new` requires:

  - `icon` — the glyph; per Material spec its meaning must be clear.
  - `label` — concise action description. Rendered as both
    `aria-label` (screen readers) and the hover `title` (Material's
    required tooltip).
  - `variant` — container style.

Optional setters: `withSize` / `withShape` / `withWidth` /
`withDisabled` + the action wiring.


# Quick examples

Action — delete a row:

    Ui.IconButton.new
        { icon = Ui.Icon.fontAwesome Icon.FontAwesome.trash
        , label = "Delete row"
        , variant = Ui.IconButton.Filled
        }
        |> Ui.IconButton.withOnClick (DeleteRowRequested rowId)
        |> Ui.IconButton.view

Link — open external documentation:

    Ui.IconButton.new
        { icon = Ui.Icon.fontAwesome Icon.FontAwesome.circleQuestion
        , label = "Open documentation"
        , variant = Ui.IconButton.Outlined
        }
        |> Ui.IconButton.withHref "https://help.avetta.com"
        |> Ui.IconButton.view

Toggle — favorite a record. Material guidance: outlined glyph when
unselected, filled glyph when selected. Pass the _unselected_ glyph in
`new`'s `icon`; pass the _selected_ glyph in the toggle record:

    Ui.IconButton.new
        { icon = Ui.Icon.fontAwesome Icon.FontAwesome.heart
        , label = "Favorite"
        , variant = Ui.IconButton.Standard
        }
        |> Ui.IconButton.withToggle
            { selected = state.isFavorite
            , onChange = FavoriteToggled
            , selectedIcon = Just (Ui.Icon.fontAwesome Icon.FontAwesome.solidHeart)
            }
        |> Ui.IconButton.view


# Type

@docs IconButton


# Configuration

@docs Variant, Size, Shape, Width, DisabledState


# Constructor

@docs new


# Modifiers

@docs withSize, withShape, withWidth, withDisabled


# Action wiring (mutually exclusive — last-write-wins)

@docs withOnClick, withHref, withToggle


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import M3e.IconButton
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| An icon button.
-}
type IconButton msg
    = IconButton (Config msg)


type alias Config msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , variant : Variant
    , size : Size
    , shape : Maybe Shape
    , width : Width
    , disabled : DisabledState
    , wiring : Maybe (Wiring msg)
    }


{-| Container style.
-}
type Variant
    = Standard
    | Filled
    | Tonal
    | Outlined


{-| Container size. Defaults to `Small`.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Container shape.
-}
type Shape
    = Round
    | Square


{-| Container width relative to the chosen Size.
-}
type Width
    = Narrow
    | Default
    | Wide


{-| Tri-state disabled.
-}
type DisabledState
    = Enabled
    | Disabled
    | DisabledInteractive


type Wiring msg
    = WireClick msg
    | WireHref String
    | WireToggle
        { selected : Bool
        , onChange : Bool -> msg
        , selectedIcon : Maybe (Ui.Icon.Icon msg)
        }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct an icon button. Add an action via `withOnClick` /
`withHref` / `withToggle`.
-}
new :
    { icon : Ui.Icon.Icon msg, label : String, variant : Variant }
    -> IconButton msg
new c =
    IconButton
        { icon = c.icon
        , label = c.label
        , variant = c.variant
        , size = Small
        , shape = Nothing
        , width = Default
        , disabled = Enabled
        , wiring = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the container size.
-}
withSize : Size -> IconButton msg -> IconButton msg
withSize size (IconButton cfg) =
    IconButton { cfg | size = size }


{-| Set the container shape.
-}
withShape : Shape -> IconButton msg -> IconButton msg
withShape shape (IconButton cfg) =
    IconButton { cfg | shape = Just shape }


{-| Set the container width.
-}
withWidth : Width -> IconButton msg -> IconButton msg
withWidth width (IconButton cfg) =
    IconButton { cfg | width = width }


{-| Set the disabled state.
-}
withDisabled : DisabledState -> IconButton msg -> IconButton msg
withDisabled disabled (IconButton cfg) =
    IconButton { cfg | disabled = disabled }



-- ACTION WIRING (mutually exclusive — last-write-wins) -------------------


{-| Wire an action `msg`. Last-write-wins among the action setters.
-}
withOnClick : msg -> IconButton msg -> IconButton msg
withOnClick msg (IconButton cfg) =
    IconButton { cfg | wiring = Just (WireClick msg) }


{-| Wire navigation: activation navigates to `href`. Last-write-wins.
-}
withHref : String -> IconButton msg -> IconButton msg
withHref href (IconButton cfg) =
    IconButton { cfg | wiring = Just (WireHref href) }


{-| Wire toggle semantics. `selectedIcon` (optional) swaps the glyph
when selected — per m3 guidance, use the filled icon for the selected
state when `icon` is outlined. Last-write-wins.
-}
withToggle :
    { selected : Bool
    , onChange : Bool -> msg
    , selectedIcon : Maybe (Ui.Icon.Icon msg)
    }
    -> IconButton msg
    -> IconButton msg
withToggle c (IconButton cfg) =
    IconButton { cfg | wiring = Just (WireToggle c) }



-- RENDER -----------------------------------------------------------------


{-| Render the icon button to `Html`.
-}
view : IconButton msg -> Html msg
view (IconButton cfg) =
    M3e.IconButton.component
        (List.concat
            [ [ Attr.attribute "aria-label" cfg.label
              , Attr.title cfg.label
              , variantAttr cfg.variant
              , sizeAttr cfg.size
              , widthAttr cfg.width
              ]
            , shapeAttr cfg.shape
            , disabledAttrs cfg.disabled
            , wiringAttrs cfg.wiring
            ]
        )
        [ renderIcon (currentIcon cfg) ]


currentIcon : Config msg -> Ui.Icon.Icon msg
currentIcon cfg =
    case cfg.wiring of
        Just (WireToggle { selected, selectedIcon }) ->
            case ( selected, selectedIcon ) of
                ( True, Just sel ) ->
                    sel

                _ ->
                    cfg.icon

        _ ->
            cfg.icon


renderIcon : Ui.Icon.Icon msg -> Html msg
renderIcon icon =
    Html.span [ Attr.attribute "aria-hidden" "true" ]
        [ Ui.Icon.view icon ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Standard ->
            M3e.IconButton.variantStandard

        Filled ->
            M3e.IconButton.variantFilled

        Tonal ->
            M3e.IconButton.variantTonal

        Outlined ->
            M3e.IconButton.variantOutlined


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        ExtraSmall ->
            M3e.IconButton.sizeExtraSmall

        Small ->
            M3e.IconButton.sizeSmall

        Medium ->
            M3e.IconButton.sizeMedium

        Large ->
            M3e.IconButton.sizeLarge

        ExtraLarge ->
            M3e.IconButton.sizeExtraLarge


widthAttr : Width -> Html.Attribute msg
widthAttr w =
    case w of
        Narrow ->
            M3e.IconButton.widthNarrow

        Default ->
            M3e.IconButton.widthDefault

        Wide ->
            M3e.IconButton.widthWide


shapeAttr : Maybe Shape -> List (Html.Attribute msg)
shapeAttr shape =
    case shape of
        Nothing ->
            []

        Just Round ->
            [ M3e.IconButton.shapeRounded ]

        Just Square ->
            [ M3e.IconButton.shapeSquare ]


disabledAttrs : DisabledState -> List (Html.Attribute msg)
disabledAttrs d =
    case d of
        Enabled ->
            []

        Disabled ->
            [ M3e.IconButton.disabled True ]

        DisabledInteractive ->
            [ M3e.IconButton.disabledInteractive True ]


wiringAttrs : Maybe (Wiring msg) -> List (Html.Attribute msg)
wiringAttrs maybeWiring =
    case maybeWiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            [ M3e.IconButton.href href ]

        Just (WireToggle { selected, onChange }) ->
            [ M3e.IconButton.toggle True
            , M3e.IconButton.selected selected
            , M3e.IconButton.onChange (toggleChangeDecoder onChange)
            ]


toggleChangeDecoder : (Bool -> msg) -> Decode.Decoder msg
toggleChangeDecoder toMsg =
    Decode.at [ "target", "selected" ] Decode.bool
        |> Decode.map toMsg
