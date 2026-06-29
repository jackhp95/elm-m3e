module Cem.M3e.BreadcrumbItem exposing
    ( component, itemLabel, disabled, current, href, target
    , download, rel, onClick, iconSlot
    )

{-| An item in a breadcrumb.

@docs component, itemLabel, disabled, current, href, target
@docs download, rel, onClick, iconSlot

-}

import Cem.M3e.Common
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

**CSS Custom Properties:**

  - `--m3e-breadcrumb-item-shape`: Shape of the internal breadcrumb item button.
  - `--m3e-breadcrumb-item-container-height`: Height of the internal breadcrumb item button container.
  - `--m3e-breadcrumb-item-icon-color`: Color of breadcrumb item icon-only content.
  - `--m3e-breadcrumb-item-icon-padding-inline`: Horizontal padding for icon-only breadcrumb items.
  - `--m3e-breadcrumb-item-icon-hover-state-layer-color`: Hover state layer color for icon-only breadcrumb items.
  - `--m3e-breadcrumb-item-icon-focus-state-layer-color`: Focus state layer color for icon-only breadcrumb items.
  - `--m3e-breadcrumb-item-icon-pressed-state-layer-color`: Pressed state layer color for icon-only breadcrumb items.
  - `--m3e-breadcrumb-item-label-color`: Color of breadcrumb item label content.
  - `--m3e-breadcrumb-item-label-font-size`: Font size of breadcrumb item label content.
  - `--m3e-breadcrumb-item-label-font-weight`: Font weight of breadcrumb item label content.
  - `--m3e-breadcrumb-item-label-line-height`: Line height of breadcrumb item label content.
  - `--m3e-breadcrumb-item-label-tracking`: Letter spacing of breadcrumb item label content.
  - `--m3e-breadcrumb-item-label-padding-inline`: Horizontal padding for label breadcrumb items.
  - `--m3e-breadcrumb-item-label-hover-state-layer-color`: Hover state layer color for label breadcrumb items.
  - `--m3e-breadcrumb-item-label-focus-state-layer-color`: Focus state layer color for label breadcrumb items.
  - `--m3e-breadcrumb-item-label-pressed-state-layer-color`: Pressed state layer color for label breadcrumb items.
  - `--m3e-breadcrumb-item-last-color`: Color used for the current breadcrumb item.
  - `--m3e-breadcrumb-item-icon-label-space`: Space between icon and label.
  - `--m3e-breadcrumb-item-icon-size`: Size of the icon.
  - `--m3e-breadcrumb-item-disabled-color`: Disabled color used by the breadcrumb item button.
  - `--m3e-breadcrumb-item-disabled-opacity`: Disabled opacity used by the breadcrumb item button.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-breadcrumb-item" attributes children


{-| The accessible label given to the item's internal button. (default: `""`)
-}
itemLabel : String -> Html.Attribute msg
itemLabel val_ =
    Html.Attributes.attribute "item-label" val_


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Indicates the current item in the breadcrumb path.
-}
current :
    Cem.M3e.Common.Value
        { date : Cem.M3e.Common.Supported
        , location : Cem.M3e.Common.Supported
        , page : Cem.M3e.Common.Supported
        , step : Cem.M3e.Common.Supported
        , time : Cem.M3e.Common.Supported
        , true : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
current =
    Cem.M3e.Common.current


{-| The URL to which the internal breadcrumb link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The target of the internal breadcrumb link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The relationship between the internal link target and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the item's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"
