module Ui.Button exposing
    ( Button
    , Variant(..), Size(..), Shape(..), DisabledState(..)
    , new
    , withSize, withShape, withDisabled, withLeadingIcon, withTrailingIcon
    , withOnClick, withHref, withToggle
    , view
    )

{-| Typed builder for `<m3e-button>` — a labeled action button. Mirrors
the Material 3 [Buttons][m3] surface 1:1.

[m3]: https://m3.material.io/components/buttons/overview

For an icon-only one-tap action, see `Ui.IconButton`.


# Action wiring is a builder, not a constructor

`withOnClick`, `withHref`, and `withToggle` set the button's wiring as
mutually-exclusive `with*` setters (**last-write-wins**). This is a
deliberate MISI carve-out: we _could_ enforce mutual exclusivity by
splitting into three constructors (`button` / `buttonLink` / `toggle`),
but the value of a single `new` constructor + composable setters
outweighs the small risk of someone accidentally writing
`withOnClick … |> withHref …`. The rule is: **only set one**.

A button with no wiring set is degenerate-but-valid (no action fires).


# Required-by-design

`new` requires:

  - `label` — visible text. Per Material spec, concise sentence case.
  - `variant` — container style (the five m3 emphasis levels).

Optional, via `with*`:

  - `withSize` (default `Small`), `withShape`, `withDisabled`,
    `withLeadingIcon`, `withTrailingIcon`.
  - **Action wiring (pick one)**: `withOnClick` / `withHref` /
    `withToggle`.


# Quick examples

Action — save a form:

    Ui.Button.new { label = "Save changes", variant = Ui.Button.Filled }
        |> Ui.Button.withOnClick SaveRequested
        |> Ui.Button.view

Link — open external help:

    Ui.Button.new { label = "Open documentation", variant = Ui.Button.Text }
        |> Ui.Button.withHref "https://help.avetta.com"
        |> Ui.Button.view

With a leading icon — reinforce the label, don't replace it:

    Ui.Button.new { label = "Add row", variant = Ui.Button.Tonal }
        |> Ui.Button.withOnClick AddRowRequested
        |> Ui.Button.withLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.plus)
        |> Ui.Button.view

Toggle — show/hide archived records:

    Ui.Button.new { label = "Show archived", variant = Ui.Button.Outlined }
        |> Ui.Button.withToggle
            { selected = state.showArchived, onChange = ShowArchivedToggled }
        |> Ui.Button.view


# Type

@docs Button


# Configuration

@docs Variant, Size, Shape, DisabledState


# Constructor

@docs new


# Modifiers

@docs withSize, withShape, withDisabled, withLeadingIcon, withTrailingIcon


# Action wiring (mutually exclusive — last-write-wins)

@docs withOnClick, withHref, withToggle


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import M3e.Button
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A labeled button.
-}
type Button msg
    = Button (Config msg)


type alias Config msg =
    { label : String
    , variant : Variant
    , size : Size
    , shape : Maybe Shape
    , disabled : DisabledState
    , leadingIcon : Maybe (Ui.Icon.Icon msg)
    , trailingIcon : Maybe (Ui.Icon.Icon msg)
    , wiring : Maybe (Wiring msg)
    }


{-| Container style. Per Material 3 Expressive, the five color styles
are content-tied emphasis choices.

  - **Elevated** — raised; medium emphasis with a shadow.
  - **Filled** — strongest emphasis; primary action.
  - **Tonal** — medium-high emphasis; complementary primary.
  - **Outlined** — bordered; medium-low.
  - **Text** — lowest emphasis; inline / unobtrusive.

-}
type Variant
    = Elevated
    | Filled
    | Tonal
    | Outlined
    | Text


{-| Container size. Defaults to `Small`.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Container shape. Defaults to the underlying element's default.
-}
type Shape
    = Round
    | Square


{-| Tri-state disabled, mirroring the M3e element.

  - **Enabled** — interactive (the default).
  - **Disabled** — non-interactive and not focusable.
  - **DisabledInteractive** — visually disabled but focusable, so
    screen readers can announce _why_ it's disabled.

-}
type DisabledState
    = Enabled
    | Disabled
    | DisabledInteractive


type Wiring msg
    = WireClick msg
    | WireHref String
    | WireToggle { selected : Bool, onChange : Bool -> msg }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a button. Add an action via `withOnClick` / `withHref` /
`withToggle`.
-}
new : { label : String, variant : Variant } -> Button msg
new c =
    Button
        { label = c.label
        , variant = c.variant
        , size = Small
        , shape = Nothing
        , disabled = Enabled
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , wiring = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the container size.
-}
withSize : Size -> Button msg -> Button msg
withSize size (Button cfg) =
    Button { cfg | size = size }


{-| Set the container shape (`Round` / `Square`).
-}
withShape : Shape -> Button msg -> Button msg
withShape shape (Button cfg) =
    Button { cfg | shape = Just shape }


{-| Set the disabled state.
-}
withDisabled : DisabledState -> Button msg -> Button msg
withDisabled disabled (Button cfg) =
    Button { cfg | disabled = disabled }


{-| Add a leading icon (renders before the label).
-}
withLeadingIcon : Ui.Icon.Icon msg -> Button msg -> Button msg
withLeadingIcon icon (Button cfg) =
    Button { cfg | leadingIcon = Just icon }


{-| Add a trailing icon (renders after the label).
-}
withTrailingIcon : Ui.Icon.Icon msg -> Button msg -> Button msg
withTrailingIcon icon (Button cfg) =
    Button { cfg | trailingIcon = Just icon }



-- ACTION WIRING (mutually exclusive — last-write-wins) -------------------


{-| Wire an action `msg` dispatched when the button is activated. Last-
write-wins among `withOnClick` / `withHref` / `withToggle`.
-}
withOnClick : msg -> Button msg -> Button msg
withOnClick msg (Button cfg) =
    Button { cfg | wiring = Just (WireClick msg) }


{-| Wire navigation: activation navigates to `href`. Last-write-wins
among the action setters.
-}
withHref : String -> Button msg -> Button msg
withHref href (Button cfg) =
    Button { cfg | wiring = Just (WireHref href) }


{-| Wire toggle semantics: the button represents an on/off selection.
Last-write-wins among the action setters.
-}
withToggle :
    { selected : Bool, onChange : Bool -> msg }
    -> Button msg
    -> Button msg
withToggle c (Button cfg) =
    Button { cfg | wiring = Just (WireToggle c) }



-- RENDER -----------------------------------------------------------------


{-| Render the button to `Html`.
-}
view : Button msg -> Html msg
view (Button cfg) =
    M3e.Button.component
        (List.concat
            [ [ variantAttr cfg.variant
              , sizeAttr cfg.size
              ]
            , shapeAttr cfg.shape
            , disabledAttrs cfg.disabled
            , wiringAttrs cfg.wiring
            ]
        )
        (List.concat
            [ leadingSlot cfg.leadingIcon
            , [ Html.text cfg.label ]
            , trailingSlot cfg.trailingIcon
            ]
        )


leadingSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
leadingSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ slottedIcon M3e.Button.iconSlot i ]


trailingSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
trailingSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ slottedIcon M3e.Button.trailingIconSlot i ]


slottedIcon : Html.Attribute msg -> Ui.Icon.Icon msg -> Html msg
slottedIcon slotAttr icon =
    Html.span
        [ slotAttr
        , Attr.attribute "aria-hidden" "true"
        ]
        [ Ui.Icon.view icon ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Elevated ->
            M3e.Button.variant M3e.Button.Elevated

        Filled ->
            M3e.Button.variant M3e.Button.Filled

        Tonal ->
            M3e.Button.variant M3e.Button.Tonal

        Outlined ->
            M3e.Button.variant M3e.Button.Outlined

        Text ->
            M3e.Button.variant M3e.Button.Text


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        ExtraSmall ->
            M3e.Button.size M3e.Button.ExtraSmall

        Small ->
            M3e.Button.size M3e.Button.Small

        Medium ->
            M3e.Button.size M3e.Button.Medium

        Large ->
            M3e.Button.size M3e.Button.Large

        ExtraLarge ->
            M3e.Button.size M3e.Button.ExtraLarge


shapeAttr : Maybe Shape -> List (Html.Attribute msg)
shapeAttr shape =
    case shape of
        Nothing ->
            []

        Just Round ->
            [ M3e.Button.shape M3e.Button.Rounded ]

        Just Square ->
            [ M3e.Button.shape M3e.Button.Square ]


disabledAttrs : DisabledState -> List (Html.Attribute msg)
disabledAttrs d =
    case d of
        Enabled ->
            []

        Disabled ->
            [ M3e.Button.disabled True ]

        DisabledInteractive ->
            [ M3e.Button.disabledInteractive True ]


wiringAttrs : Maybe (Wiring msg) -> List (Html.Attribute msg)
wiringAttrs maybeWiring =
    case maybeWiring of
        Nothing ->
            []

        Just (WireClick msg) ->
            [ HtmlEvents.onClick msg ]

        Just (WireHref href) ->
            [ M3e.Button.href href ]

        Just (WireToggle { selected, onChange }) ->
            [ M3e.Button.toggle True
            , M3e.Button.selected selected
            , M3e.Button.onChange (toggleChangeDecoder onChange)
            ]


toggleChangeDecoder : (Bool -> msg) -> Decode.Decoder msg
toggleChangeDecoder toMsg =
    Decode.at [ "target", "selected" ] Decode.bool
        |> Decode.map toMsg
