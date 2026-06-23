module M3e.StateLayer exposing (component, disableHover)

{-| 
Provides focus and hover state layer treatment for an interactive element.

## Component

@docs component

### Attributes

@docs disableHover
-}


import Html
import Html.Attributes
import Json.Encode


{-| Provides focus and hover state layer treatment for an interactive element. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-state-layer" attributes children


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Html.Attribute msg
disableHover val_ =
    Html.Attributes.property "disable-hover" (Json.Encode.bool val_)