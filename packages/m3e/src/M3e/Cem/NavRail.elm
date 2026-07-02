module M3e.Cem.NavRail exposing
    ( navRail, mode, onBeforeinput, onInput, onChange
    )

{-|
Middle layer for `<m3e-nav-rail>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavRail` module for everyday use.

@docs navRail, mode, onBeforeinput, onInput, onChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.NavRail
import M3e.Value


{-| A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Events:**
- `beforeinput`: Dispatched before the selected state of an item changes.
- `input`: Dispatched when the selected state of an item changes.
- `change`: Dispatched when the selected state of an item changes.
-}
navRail :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navRail attributes children =
    M3e.Cem.Html.NavRail.navRail
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavRail.mode (M3e.Value.toString v_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavRail.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavRail.onInput (Json.Decode.succeed f_)


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavRail.onChange
        (Json.Decode.succeed f_)