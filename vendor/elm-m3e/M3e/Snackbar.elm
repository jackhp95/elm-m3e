module M3e.Snackbar exposing (action, closeIconSlot, component, duration, onBeforetoggle, onToggle)

{-| 
Presents short updates about application processes at the bottom of the screen.

## Component

@docs component

### Attributes

@docs action, duration

### Events

@docs onBeforetoggle, onToggle

### Slots

@docs closeIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents short updates about application processes at the bottom of the screen.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `close-icon`: Renders the icon of the button used to close the snackbar.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-snackbar" attributes children


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> Html.Attribute msg
action val_ =
    Html.Attributes.attribute "action" val_


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> Html.Attribute msg
duration val_ =
    Html.Attributes.property "duration" (Json.Encode.float val_)


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


{-| Renders the icon of the button used to close the snackbar. -}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"