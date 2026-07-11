module M3e.Html.NavRail exposing (navRail, mode, onBeforeinput, onInput, onChange)

{-| Middle layer for `<m3e-nav-rail>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavRail` module for everyday use.

@docs navRail, mode, onBeforeinput, onInput, onChange

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.NavRail
import M3e.Token


{-| A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Component Info:**

  - **Extends:** `M3eNavBarElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state of an item changes.
  - `input`: Dispatched when the selected state of an item changes.
  - `change`: Dispatched when the selected state of an item changes.

-}
navRail :
    List
        (M3e.Html.Attr.Attr
            { mode : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
navRail attributes children =
    M3e.Raw.NavRail.navRail
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The mode in which items in the rail are presented. (default: `"compact"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , compact : M3e.Token.Supported
        , expanded : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavRail.mode
        (M3e.Token.toString v_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavRail.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavRail.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavRail.onChange
        (Json.Decode.succeed f_)
