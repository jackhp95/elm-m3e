module M3e.ListItemButton exposing (component, disabled, download, href, leadingSlot, onClick, overlineSlot, rel, supportingTextSlot, target, trailingSlot)

{-| 


## Component

@docs component

### Attributes

@docs href, target, rel, download, disabled

### Events

@docs onClick

### Slots

@docs leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Create a m3e-list-item-button element

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `click`: No description

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-item-button" attributes children


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


{-| Renders the leading content of the list item. -}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item. -}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item. -}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders the trailing content of the list item. -}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"