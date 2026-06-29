module Cem.M3e.BreadcrumbItemButton exposing
    ( component, current, href, target, rel, download
    , disabled, onClick
    )

{-|

@docs component, current, href, target, rel, download
@docs disabled, onClick

-}

import Cem.M3e.Common
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


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| Whether the element is disabled. (default: `false`)
-}
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
