module Cem.M3e.ListAction exposing
    ( component, disabled, download, href, rel, target
    , onClick, leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
    )

{-| An item in a list that performs an action.

@docs component, disabled, download, href, rel, target
@docs onClick, leadingSlot, overlineSlot, supportingTextSlot, trailingSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An item in a list that performs an action.

**Component Info:**

  - **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

**CSS Custom Properties:**

  - `--m3e-list-item-between-space`: Horizontal gap between elements.
  - `--m3e-list-item-padding-inline`: Horizontal padding for the list item.
  - `--m3e-list-item-padding-block`: Vertical padding for the list item.
  - `--m3e-list-item-height`: Minimum height of the list item.
  - `--m3e-list-item-font-size`: Font size for main content.
  - `--m3e-list-item-font-weight`: Font weight for main content.
  - `--m3e-list-item-line-height`: Line height for main content.
  - `--m3e-list-item-tracking`: Letter spacing for main content.
  - `--m3e-list-item-overline-font-size`: Font size for overline slot.
  - `--m3e-list-item-overline-font-weight`: Font weight for overline slot.
  - `--m3e-list-item-overline-line-height`: Line height for overline slot.
  - `--m3e-list-item-overline-tracking`: Letter spacing for overline slot.
  - `--m3e-list-item-supporting-text-font-size`: Font size for supporting text slot.
  - `--m3e-list-item-supporting-text-font-weight`: Font weight for supporting text slot.
  - `--m3e-list-item-supporting-text-line-height`: Line height for supporting text slot.
  - `--m3e-list-item-supporting-text-tracking`: Letter spacing for supporting text slot.
  - `--m3e-list-item-trailing-text-font-size`: Font size for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-font-weight`: Font weight for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-line-height`: Line height for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-tracking`: Letter spacing for trailing supporting text slot.
  - `--m3e-list-item-icon-size`: Size for leading/trailing icons.
  - `--m3e-list-item-label-text-color`: Color for the main content.
  - `--m3e-list-item-overline-color`: Color for the overline slot.
  - `--m3e-list-item-supporting-text-color`: Color for the supporting text slot.
  - `--m3e-list-item-leading-color`: Color for the leading content.
  - `--m3e-list-item-trailing-color`: Color for the trailing content.
  - `--m3e-list-item-container-color`: Background color of the list item.
  - `--m3e-list-item-container-shape`: Border radius of the list item.
  - `--m3e-list-item-hover-container-shape`: Border radius of the list item on hover.
  - `--m3e-list-item-focus-container-shape`: Border radius of the list item on focus.
  - `--m3e-list-item-video-width`: Width of the video slot.
  - `--m3e-list-item-video-height`: Height of the video slot.
  - `--m3e-list-item-video-shape`: Border radius of the video slot.
  - `--m3e-list-item-image-width`: Width of the image slot.
  - `--m3e-list-item-image-height`: Height of the image slot.
  - `--m3e-list-item-image-shape`: Border radius of the image slot.
  - `--m3e-list-item-disabled-container-color`: Background color of the list item when disabled.
  - `--m3e-list-item-disabled-label-text-color`: Color for the main content when disabled.
  - `--m3e-list-item-disabled-label-text-opacity`: Opacity for the main content when disabled.
  - `--m3e-list-item-disabled-overline-color`: Color for the overline slot when disabled.
  - `--m3e-list-item-disabled-overline-opacity`: Opacity for the overline slot when disabled.
  - `--m3e-list-item-disabled-supporting-text-color`: Color for the supporting text slot when disabled.
  - `--m3e-list-item-disabled-supporting-text-opacity`: Opacity for the supporting text slot when disabled.
  - `--m3e-list-item-disabled-leading-color`: Color for the leading icon when disabled.
  - `--m3e-list-item-disabled-leading-opacity`: Opacity for the leading icon when disabled.
  - `--m3e-list-item-disabled-trailing-color`: Color for the trailing icon when disabled.
  - `--m3e-list-item-disabled-trailing-opacity`: Opacity for the trailing icon when disabled.
  - `--m3e-list-item-hover-state-layer-color`: Color for the hover state layer.
  - `--m3e-list-item-hover-state-layer-opacity`: Opacity for the hover state layer.
  - `--m3e-list-item-focus-state-layer-color`: Color for the focus state layer.
  - `--m3e-list-item-focus-state-layer-opacity`: Opacity for the focus state layer.
  - `--m3e-list-item-pressed-state-layer-color`: Color for the pressed state layer.
  - `--m3e-list-item-pressed-state-layer-opacity`: Opacity for the pressed state layer.
  - `--m3e-list-item-three-line-top-offset`: Top offset for media in three line items.
  - `--m3e-list-item-disabled-media-opacity`: Opacity for media when disabled.
  - `--m3e-list-item-leading-space`: Horizontal padding for the leading side.
  - `--m3e-list-item-trailing-space`: Horizontal padding for the trailing side.
  - `--m3e-list-item-one-line-top-space`: Top padding for one-line items.
  - `--m3e-list-item-one-line-bottom-space`: Bottom padding for one-line items.
  - `--m3e-list-item-two-line-top-space`: Top padding for two-line items.
  - `--m3e-list-item-two-line-bottom-space`: Bottom padding for two-line items.
  - `--m3e-list-item-three-line-top-space`: Top padding for three-line items.
  - `--m3e-list-item-three-line-bottom-space`: Bottom padding for three-line items.
  - `--m3e-list-item-one-line-height`: Minimum height of a one line list item.
  - `--m3e-list-item-two-line-height`: Minimum height of a two line list item.
  - `--m3e-list-item-three-line-height`: Minimum height of a three line list item.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-action" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the leading content of the list item.
-}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item.
-}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item.
-}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders the trailing content of the list item.
-}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"
