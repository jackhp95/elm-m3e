module Cem.M3e.BreadcrumbItem exposing (Current(..), component, current, disabled, download, href, iconSlot, itemLabel, onClick, rel, target)

{-| 
An item in a breadcrumb.

## Component

@docs component

### Attributes

@docs itemLabel, disabled, Current, current, href, target, download, rel

### Events

@docs onClick

### Slots

@docs iconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An item in a breadcrumb.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the item's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-breadcrumb-item" attributes children


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel : String -> Html.Attribute msg
itemLabel val_ =
    Html.Attributes.attribute "item-label" val_


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Values for the `current` attribute. -}
type Current
    = Date
    | Location
    | Page
    | Step
    | Time
    | True


{-| Indicates the current item in the breadcrumb path. -}
current : Current -> Html.Attribute msg
current val_ =
    Html.Attributes.attribute "current" (currentToString val_)


currentToString : Current -> String
currentToString val_ =
    case val_ of
        Date ->
            "date"
    
        Location ->
            "location"
    
        Page ->
            "page"
    
        Step ->
            "step"
    
        Time ->
            "time"
    
        True ->
            "true"


{-| The URL to which the internal breadcrumb link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The target of the internal breadcrumb link button. (default: `""`) -}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`) -}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The relationship between the internal link target and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the item's label. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"