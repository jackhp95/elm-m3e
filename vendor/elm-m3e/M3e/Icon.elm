module M3e.Icon exposing (Grade(..), Variant(..), component, filled, grade, name, opticalSize, variant, weight)

{-| 
A small symbol used to easily identify an action or category.

## Component

@docs component

### Attributes

@docs filled, Grade, grade, opticalSize, name, Variant, variant, weight
-}


import Html
import Html.Attributes
import Json.Encode


{-| A small symbol used to easily identify an action or category. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-icon" attributes children


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> Html.Attribute msg
filled val_ =
    Html.Attributes.property "filled" (Json.Encode.bool val_)


{-| Values for the `grade` attribute. -}
type Grade
    = High
    | Low
    | Medium


{-| The grade of the icon. (default: `"medium"`) -}
grade : Grade -> Html.Attribute msg
grade val_ =
    Html.Attributes.attribute "grade" (gradeToString val_)


gradeToString : Grade -> String
gradeToString val_ =
    case val_ of
        High ->
            "high"
    
        Low ->
            "low"
    
        Medium ->
            "medium"


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "optical-size" (Json.Encode.float val_)


{-| The name of the icon. (default: `""`) -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Values for the `variant` attribute. -}
type Variant
    = Outlined
    | Rounded
    | Sharp


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Outlined ->
            "outlined"
    
        Rounded ->
            "rounded"
    
        Sharp ->
            "sharp"


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> Html.Attribute msg
weight val_ =
    Html.Attributes.attribute "weight" val_