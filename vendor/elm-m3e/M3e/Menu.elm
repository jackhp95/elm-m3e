module M3e.Menu exposing
    ( component
    , positionX, positionY, submenu
    , onBeforetoggle, onToggle
    )

{-| Presents a list of choices on a temporary surface.


## Component

@docs component


### Attributes

@docs positionX, positionY, submenu


### Events

@docs onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a list of choices on a temporary surface.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu" attributes children


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX : String -> Html.Attribute msg
positionX val_ =
    Html.Attributes.attribute "position-x" val_


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY : String -> Html.Attribute msg
positionY val_ =
    Html.Attributes.attribute "position-y" val_


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    Html.Attributes.property "submenu" (Json.Encode.bool val_)


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder
