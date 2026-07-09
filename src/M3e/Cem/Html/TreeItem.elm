module M3e.Cem.Html.TreeItem exposing
    ( treeItem, disabled, indeterminate, open, selected, onOpening
    , onOpened, onClosing, onClosed, onClick
    )

{-|
Bottom layer for `<m3e-tree-item>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs treeItem, disabled, indeterminate, open, selected, onOpening
@docs onOpened, onClosing, onClosed, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-tree-item>` element — a partial application of `Html.node`. -}
treeItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
treeItem =
    Html.node "m3e-tree-item"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    if val_ then
        Html.Attributes.attribute "indeterminate" ""
    
    else
        Html.Attributes.classList []


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    if val_ then
        Html.Attributes.attribute "open" ""
    
    else
        Html.Attributes.classList []


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    if val_ then
        Html.Attributes.attribute "selected" ""
    
    else
        Html.Attributes.classList []


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