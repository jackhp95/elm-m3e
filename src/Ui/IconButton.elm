module Ui.IconButton exposing
    ( IconButton
    , Variant(..), Size(..), Shape(..), Width(..), DisabledState(..)
    , new
    , withAttributes
    , withSize, withShape, withWidth, withDisabled
    , withOnClick, withHref, withToggle
    , withTarget, withRel, withDownload
    , withExtraContent
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withSize, withShape, withWidth, withDisabled


# Action wiring (mutually exclusive — last-write-wins)

@docs withOnClick, withHref, withToggle


# Anchor refinements (only meaningful with `withHref`)

@docs withTarget, withRel, withDownload


# Extra default-slot content

@docs withExtraContent


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import Cem.M3e.IconButton
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| An icon button.
-}
type IconButton msg
    = IconButton (Config msg)


type alias Config msg =
    { icon : Ui.Icon.Icon msg
    , attributes : List (Attribute msg)
    , label : String
    , variant : Variant
    , size : Size
    , shape : Maybe Shape
    , width : Width
    , disabled : DisabledState
    , wiring : Maybe (Wiring msg)
    , anchorTarget : Maybe String
    , anchorRel : Maybe String
    , anchorDownload : Maybe String
    , extraContent : List (Html msg)
    }


{-| Container style — `Standard` (the m3e `variant` default), `Filled`,
`Tonal`, or `Outlined`.
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


{-| Container shape (m3e `shape`, default `rounded`).
-}
type Shape
    = Round
    | Square


{-| Container width relative to the chosen Size (m3e `width`, default
`default`).
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
        , attributes = []
        , label = c.label
        , variant = c.variant
        , size = Small
        , shape = Nothing
        , width = Default
        , disabled = Enabled
        , wiring = Nothing
        , anchorTarget = Nothing
        , anchorRel = Nothing
        , anchorDownload = Nothing
        , extraContent = []
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-icon-button>` host element — the
escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> IconButton msg -> IconButton msg
withAttributes attributes (IconButton cfg) =
    IconButton { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the container size (m3e `size`, default `small`).
-}
withSize : Size -> IconButton msg -> IconButton msg
withSize size (IconButton cfg) =
    IconButton { cfg | size = size }


{-| Set the container shape (m3e `shape`, default `rounded`).
-}
withShape : Shape -> IconButton msg -> IconButton msg
withShape shape (IconButton cfg) =
    IconButton { cfg | shape = Just shape }


{-| Set the container width (m3e `width`, default `default`).
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


{-| Set the anchor `target` (e.g. `"_blank"`). Only emitted when the button is
wired as a link via `withHref`; ignored under `withOnClick`/`withToggle`.
-}
withTarget : String -> IconButton msg -> IconButton msg
withTarget target (IconButton cfg) =
    IconButton { cfg | anchorTarget = Just target }


{-| Set the anchor `rel` (e.g. `"noreferrer noopener"`). Only emitted with
`withHref`.
-}
withRel : String -> IconButton msg -> IconButton msg
withRel rel (IconButton cfg) =
    IconButton { cfg | anchorRel = Just rel }


{-| Set the anchor `download` attribute (an empty string requests the default
filename). Only emitted with `withHref`.
-}
withDownload : String -> IconButton msg -> IconButton msg
withDownload download (IconButton cfg) =
    IconButton { cfg | anchorDownload = Just download }


{-| Append element(s) into the icon button's default slot, after the glyph.
The escape hatch for marker elements that must be nested inside a clickable —
e.g. `Ui.Menu.triggerFor` to make the icon button open a menu. Accumulates
across calls.
-}
withExtraContent : List (Html msg) -> IconButton msg -> IconButton msg
withExtraContent content (IconButton cfg) =
    IconButton { cfg | extraContent = cfg.extraContent ++ content }



-- RENDER -----------------------------------------------------------------


{-| Render the icon button to `Html`.
-}
view : IconButton msg -> Html msg
view (IconButton cfg) =
    Cem.M3e.IconButton.component
        (cfg.attributes
            ++ List.concat
                [ [ Attr.attribute "aria-label" cfg.label
                  , Attr.title cfg.label
                  , variantAttr cfg.variant
                  , sizeAttr cfg.size
                  , widthAttr cfg.width
                  ]
                , shapeAttr cfg.shape
                , disabledAttrs cfg.disabled
                , wiringAttrs cfg
                ]
        )
        (renderIcon (currentIcon cfg) :: cfg.extraContent)


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
            Cem.M3e.IconButton.variant Cem.M3e.IconButton.Standard

        Filled ->
            Cem.M3e.IconButton.variant Cem.M3e.IconButton.Filled

        Tonal ->
            Cem.M3e.IconButton.variant Cem.M3e.IconButton.Tonal

        Outlined ->
            Cem.M3e.IconButton.variant Cem.M3e.IconButton.Outlined


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        ExtraSmall ->
            Cem.M3e.IconButton.size Cem.M3e.IconButton.ExtraSmall

        Small ->
            Cem.M3e.IconButton.size Cem.M3e.IconButton.Small

        Medium ->
            Cem.M3e.IconButton.size Cem.M3e.IconButton.Medium

        Large ->
            Cem.M3e.IconButton.size Cem.M3e.IconButton.Large

        ExtraLarge ->
            Cem.M3e.IconButton.size Cem.M3e.IconButton.ExtraLarge


widthAttr : Width -> Html.Attribute msg
widthAttr w =
    case w of
        Narrow ->
            Cem.M3e.IconButton.width Cem.M3e.IconButton.Narrow

        Default ->
            Cem.M3e.IconButton.width Cem.M3e.IconButton.Default

        Wide ->
            Cem.M3e.IconButton.width Cem.M3e.IconButton.Wide


shapeAttr : Maybe Shape -> List (Html.Attribute msg)
shapeAttr shape =
    case shape of
        Nothing ->
            []

        Just Round ->
            [ Cem.M3e.IconButton.shape Cem.M3e.IconButton.Rounded ]

        Just Square ->
            [ Cem.M3e.IconButton.shape Cem.M3e.IconButton.Square ]


disabledAttrs : DisabledState -> List (Html.Attribute msg)
disabledAttrs d =
    case d of
        Enabled ->
            []

        Disabled ->
            [ Cem.M3e.IconButton.disabled True ]

        DisabledInteractive ->
            [ Cem.M3e.IconButton.disabledInteractive True ]


wiringAttrs : Config msg -> List (Html.Attribute msg)
wiringAttrs cfg =
    case cfg.wiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            Cem.M3e.IconButton.href href
                :: List.filterMap identity
                    [ Maybe.map Cem.M3e.IconButton.target cfg.anchorTarget
                    , Maybe.map Cem.M3e.IconButton.rel cfg.anchorRel
                    , Maybe.map Cem.M3e.IconButton.download cfg.anchorDownload
                    ]

        Just (WireToggle { selected, onChange }) ->
            [ Cem.M3e.IconButton.toggle True
            , Cem.M3e.IconButton.selected selected
            , Cem.M3e.IconButton.onChange (toggleChangeDecoder onChange)
            ]


toggleChangeDecoder : (Bool -> msg) -> Decode.Decoder msg
toggleChangeDecoder toMsg =
    Decode.at [ "target", "selected" ] Decode.bool
        |> Decode.map toMsg
