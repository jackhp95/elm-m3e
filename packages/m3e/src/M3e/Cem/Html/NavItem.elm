module M3e.Cem.Html.NavItem exposing (disabled, disabledInteractive, download, href, navItem, onBeforeinput, onChange, onClick, onInput, orientation, rel, selected, target)

{-| 
@docs navItem, disabled, disabledInteractive, download, href, orientation, rel, selected, target, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-nav-item>` element — a partial application of `Html.node`. -}
navItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navItem =
    Html.node "m3e-nav-item"


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


{-| The layout orientation of the item. (default: `"vertical"`) -}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| A value indicating whether the element is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"