module M3e.Cem.Html.Option exposing (disableHighlight, disabled, highlightMode, option, selected, term, value)

{-| 
@docs option, disabled, disableHighlight, highlightMode, selected, term, value
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-option>` element — a partial application of `Html.node`. -}
option : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
option =
    Html.node "m3e-option"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight : Bool -> Html.Attribute msg
disableHighlight val_ =
    Html.Attributes.property "disableHighlight" (Json.Encode.bool val_)


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode : String -> Html.Attribute msg
highlightMode =
    Html.Attributes.attribute "highlight-mode"


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| The search term to highlight. (default: `""`) -}
term : String -> Html.Attribute msg
term =
    Html.Attributes.attribute "term"


{-| A string representing the value of the option. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"