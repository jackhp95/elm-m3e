module M3e.Cem.Html.SuggestionChip exposing (disabled, disabledInteractive, download, href, name, onClick, rel, suggestionChip, target, type_, value, variant)

{-| 
@docs suggestionChip, disabled, disabledInteractive, download, href, name, rel, target, type_, value, variant, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-suggestion-chip>` element — a partial application of `Html.node`. -}
suggestionChip :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
suggestionChip =
    Html.node "m3e-suggestion-chip"


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| The type of the element. (default: `"button"`) -}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| A string representing the value of the chip. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"