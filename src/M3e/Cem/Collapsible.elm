module M3e.Cem.Collapsible exposing
    ( collapsible, open, orientation, noAnimate, onOpening, onOpened
    , onClosing, onClosed
    )

{-|
Middle layer for `<m3e-collapsible>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Collapsible` module for everyday use.

@docs collapsible, open, orientation, noAnimate, onOpening, onOpened
@docs onClosing, onClosed
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Collapsible
import M3e.Value


{-| A container used to expand and collapse content.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `opening`: Dispatched when the collapsible begins to open.
- `opened`: Dispatched when the collapsible has opened.
- `closing`: Dispatched when the collapsible begins to close.
- `closed`: Dispatched when the collapsible has closed.
-}
collapsible :
    List (M3e.Cem.Attr.Attr { open : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , noAnimate : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
collapsible attributes children =
    M3e.Cem.Html.Collapsible.collapsible
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether content is visible. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Collapsible.open


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Collapsible.orientation
        (M3e.Value.toString v_)


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool -> M3e.Cem.Attr.Attr { c | noAnimate : M3e.Value.Supported } msg
noAnimate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Collapsible.noAnimate


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Collapsible.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Collapsible.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Collapsible.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Collapsible.onClosed
        (Json.Decode.succeed f_)