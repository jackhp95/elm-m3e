module Ui.SplitButton exposing
    ( SplitButton
    , Variant(..)
    , new
    , withVariant, withDisabled, withTriggerLabel
    , view
    )

{-| Typed builder for `<m3e-split-button>` — a primary action paired
with a dropdown trigger for related actions. Mirrors the Material 3
[Split button][m3] surface.

[m3]: https://m3.material.io/components/split-button/overview


# Type

@docs SplitButton


# Configuration

@docs Variant


# Constructor

@docs new


# Modifiers

@docs withVariant, withDisabled, withTriggerLabel


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.SplitButton
import Ui.Icon


{-| A split button.
-}
type SplitButton msg
    = SplitButton (Config msg)


type alias Config msg =
    { label : String
    , variant : Variant
    , onPrimaryClick : msg
    , onTriggerClick : msg
    , trailingIcon : Ui.Icon.Icon msg
    , triggerLabel : String
    , disabled : Bool
    }


{-| Variant.
-}
type Variant
    = Elevated
    | Filled
    | Tonal
    | Outlined



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a split button.

  - `label` — the primary action's text.
  - `onPrimaryClick` — handler for the primary action.
  - `onTriggerClick` — handler for the dropdown trigger (the caller
    opens an overlay menu in response).
  - `trailingIcon` — glyph on the trigger half (usually a caret).

-}
new :
    { label : String
    , onPrimaryClick : msg
    , onTriggerClick : msg
    , trailingIcon : Ui.Icon.Icon msg
    }
    -> SplitButton msg
new c =
    SplitButton
        { label = c.label
        , variant = Filled
        , onPrimaryClick = c.onPrimaryClick
        , onTriggerClick = c.onTriggerClick
        , trailingIcon = c.trailingIcon
        , triggerLabel = "More actions"
        , disabled = False
        }


{-| Set the variant.
-}
withVariant : Variant -> SplitButton msg -> SplitButton msg
withVariant v (SplitButton cfg) =
    SplitButton { cfg | variant = v }


{-| Disable the split button.
-}
withDisabled : Bool -> SplitButton msg -> SplitButton msg
withDisabled b (SplitButton cfg) =
    SplitButton { cfg | disabled = b }


{-| Override the accessible label on the trigger (dropdown) half.
Defaults to `"More actions"`.
-}
withTriggerLabel : String -> SplitButton msg -> SplitButton msg
withTriggerLabel label (SplitButton cfg) =
    SplitButton { cfg | triggerLabel = label }


{-| Render the split button.
-}
view : SplitButton msg -> Html msg
view (SplitButton cfg) =
    M3e.SplitButton.component
        [ variantAttr cfg.variant ]
        [ Html.button
            [ M3e.SplitButton.leadingButtonSlot
            , HtmlEvents.onClick cfg.onPrimaryClick
            , Attr.disabled cfg.disabled
            ]
            [ Html.text cfg.label ]
        , Html.button
            [ M3e.SplitButton.trailingButtonSlot
            , HtmlEvents.onClick cfg.onTriggerClick
            , Attr.disabled cfg.disabled
            , Attr.attribute "aria-label" cfg.triggerLabel
            ]
            [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.trailingIcon ] ]
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Elevated ->
            M3e.SplitButton.variant M3e.SplitButton.Elevated

        Filled ->
            M3e.SplitButton.variant M3e.SplitButton.Filled

        Tonal ->
            M3e.SplitButton.variant M3e.SplitButton.Tonal

        Outlined ->
            M3e.SplitButton.variant M3e.SplitButton.Outlined
