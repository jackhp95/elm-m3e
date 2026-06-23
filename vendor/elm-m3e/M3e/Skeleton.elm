module M3e.Skeleton exposing (Animation(..), Shape(..), animation, component, loaded, shape)

{-| 
A visual placeholder that mimics the layout of content while it's still loading.

## Component

@docs component

### Attributes

@docs Animation, animation, Shape, shape, loaded
-}


import Html
import Html.Attributes
import Json.Encode


{-| A visual placeholder that mimics the layout of content while it's still loading. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-skeleton" attributes children


{-| Values for the `animation` attribute. -}
type Animation
    = None
    | Pulse
    | Wave


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation : Animation -> Html.Attribute msg
animation val_ =
    Html.Attributes.attribute "animation" (animationToString val_)


animationToString : Animation -> String
animationToString val_ =
    case val_ of
        None ->
            "none"
    
        Pulse ->
            "pulse"
    
        Wave ->
            "wave"


{-| Values for the `shape` attribute. -}
type Shape
    = Auto
    | Circular
    | Rounded
    | Square


{-| The shape of the skeleton. (default: `"auto"`) -}
shape : Shape -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" (shapeToString val_)


shapeToString : Shape -> String
shapeToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Circular ->
            "circular"
    
        Rounded ->
            "rounded"
    
        Square ->
            "square"


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)