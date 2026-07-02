module M3e.Cem.Snackbar exposing
    ( snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
    , onToggle
    )

{-|
Middle layer for `<m3e-snackbar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Snackbar` module for everyday use.

@docs snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
@docs onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Snackbar
import M3e.Value


{-| Presents short updates about application processes at the bottom of the screen.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `close-icon`: Renders the icon of the button used to close the snackbar.
-}
snackbar :
    List (M3e.Cem.Attr.Attr { action : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , duration : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
snackbar attributes children =
    M3e.Cem.Html.Snackbar.snackbar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> M3e.Cem.Attr.Attr { c | action : M3e.Value.Supported } msg
action =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Snackbar.action


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Snackbar.closeLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Snackbar.dismissible


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> M3e.Cem.Attr.Attr { c | duration : M3e.Value.Supported } msg
duration =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Snackbar.duration


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Snackbar.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Snackbar.onToggle
        (Json.Decode.succeed f_)