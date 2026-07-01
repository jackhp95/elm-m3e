module M3e.Cem.Html.TreeItem exposing (disabled, indeterminate, onClick, onClosed, onClosing, onOpened, onOpening, open, selected, treeItem)

{-| 
@docs treeItem, disabled, indeterminate, open, selected, onOpening, onOpened, onClosing, onClosed, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-tree-item>` element — a partial application of `Html.node`. -}
treeItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
treeItem =
    Html.node "m3e-tree-item"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| Listen for `opening` events. -}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening =
    Html.Events.on "opening"


{-| Listen for `opened` events. -}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened =
    Html.Events.on "opened"


{-| Listen for `closing` events. -}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing =
    Html.Events.on "closing"


{-| Listen for `closed` events. -}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed =
    Html.Events.on "closed"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"