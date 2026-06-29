module Cem.M3e.Option exposing
    ( component, disabled, disableHighlight, highlightMode, selected, term
    , value
    )

{-| An option that can be selected.

@docs component, disabled, disableHighlight, highlightMode, selected, term
@docs value

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| An option that can be selected.

**CSS Custom Properties:**

  - `--m3e-option-container-height`: The height of the option container.
  - `--m3e-option-color`: The text color of the option.
  - `--m3e-option-container-hover-color`: The color for the hover state layer.
  - `--m3e-option-container-focus-color`: The color for the focus state layer.
  - `--m3e-option-ripple-color`: The color of the ripple effect.
  - `--m3e-option-selected-color`: The text color when the option is selected.
  - `--m3e-option-selected-container-color`: The background color when the option is selected.
  - `--m3e-option-selected-container-hover-color`: The hover color for the selected state layer.
  - `--m3e-option-selected-container-focus-color`: The focus color for the selected state layer.
  - `--m3e-option-selected-ripple-color`: The ripple color when the option is selected.
  - `--m3e-option-disabled-color`: The text color when the option is disabled.
  - `--m3e-option-disabled-opacity`: The opacity level applied to the disabled text color.
  - `--m3e-option-icon-label-space`: The spacing between the icon and label.
  - `--m3e-option-padding-start`: The left padding of the option content.
  - `--m3e-option-padding-end`: The right padding of the option content.
  - `--m3e-option-label-text-font-size`: The font size of the option label.
  - `--m3e-option-label-text-font-weight`: The font weight of the option label.
  - `--m3e-option-label-text-line-height`: The line height of the option label.
  - `--m3e-option-label-text-tracking`: The letter spacing of the option label.
  - `--m3e-option-focus-ring-shape`: The corner radius of the focus ring.
  - `--m3e-option-icon-size`: The size of the option icons.
  - `--m3e-option-shape`: Base shape of the option.
  - `--m3e-option-selected-shape`: Shape used for a selected option.
  - `--m3e-option-first-child-shape`: Shape for the first option in a list.
  - `--m3e-option-last-child-shape`: Shape for the last option in a list.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-option" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight : Bool -> Html.Attribute msg
disableHighlight val_ =
    Html.Attributes.property "disable-highlight" (Json.Encode.bool val_)


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    Cem.M3e.Common.Value
        { contains : Cem.M3e.Common.Supported
        , endsWith : Cem.M3e.Common.Supported
        , startsWith : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
highlightMode =
    Cem.M3e.Common.highlightMode


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The search term to highlight. (default: `""`)
-}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| A string representing the value of the option.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value
