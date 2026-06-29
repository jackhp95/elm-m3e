module Cem.M3e.StateLayer exposing (component, disabled, disableHover, for)

{-| Provides focus and hover state layer treatment for an interactive element.

@docs component, disabled, disableHover, for

-}

import Html
import Html.Attributes
import Json.Encode


{-| Provides focus and hover state layer treatment for an interactive element.

**CSS Custom Properties:**

  - `--m3e-state-layer-duration`: Duration of state layer changes.
  - `--m3e-state-layer-easing`: Easing curve of state layer changes.
  - `--m3e-state-layer-focus-color`: Color on hover.
  - `--m3e-state-layer-focus-opacity`: Opacity on focus.
  - `--m3e-state-layer-hover-color`: Color on hover.
  - `--m3e-state-layer-hover-opacity`: Opacity on hover.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-state-layer" attributes children


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Html.Attribute msg
disableHover val_ =
    Html.Attributes.property "disable-hover" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
