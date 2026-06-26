module Cem.M3e.BreadcrumbItemButton exposing (Current(..), component, current, disabled, download, href, onClick, rel, target)

{-| 


## Component

@docs component

### Attributes

@docs Current, current, href, target, rel, download, disabled

### Events

@docs onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Create a m3e-breadcrumb-item-button element

**Events:**
- `click`: No description
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-breadcrumb-item-button" attributes children


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


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Listen for `click` events.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder