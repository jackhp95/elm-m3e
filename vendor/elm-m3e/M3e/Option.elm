module M3e.Option exposing
    ( component
    , disableHighlight, highlightMode, value
    )

{-| An option that can be selected.


## Component

@docs component


### Attributes

@docs disableHighlight, highlightMode, value

-}

import Html
import Html.Attributes
import Json.Encode


{-| An option that can be selected.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-option" attributes children


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight : Bool -> Html.Attribute msg
disableHighlight val_ =
    Html.Attributes.property "disable-highlight" (Json.Encode.bool val_)


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode : String -> Html.Attribute msg
highlightMode val_ =
    Html.Attributes.attribute "highlight-mode" val_


{-| A string representing the value of the option.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value
