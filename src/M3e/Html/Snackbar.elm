module M3e.Html.Snackbar exposing
    ( snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
    , onToggle
    )

{-| Middle layer for `<m3e-snackbar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Snackbar` module for everyday use.

@docs snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
@docs onToggle

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Snackbar
import M3e.Token


{-| Presents short updates about application processes at the bottom of the screen.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**Slots:**

  - `close-icon`: Renders the icon of the button used to close the snackbar.

-}
snackbar :
    List
        (M3e.Html.Attr.Attr
            { action : M3e.Token.Supported
            , closeLabel : M3e.Token.Supported
            , dismissible : M3e.Token.Supported
            , duration : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
snackbar attributes children =
    M3e.Raw.Snackbar.snackbar
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> M3e.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
action =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Snackbar.action


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Snackbar.closeLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> M3e.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Snackbar.dismissible


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> M3e.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
duration =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Snackbar.duration


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Snackbar.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Snackbar.onToggle
        (Json.Decode.succeed f_)
