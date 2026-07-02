module M3e.Cem.FabMenu exposing ( fabMenu, variant, onBeforetoggle, onToggle )

{-|
Middle layer for `<m3e-fab-menu>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FabMenu` module for everyday use.

@docs fabMenu, variant, onBeforetoggle, onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.FabMenu
import M3e.Value


{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
fabMenu :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
fabMenu attributes children =
    M3e.Cem.Html.FabMenu.fabMenu
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FabMenu.variant (M3e.Value.toString v_)


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.FabMenu.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.FabMenu.onToggle
        (Json.Decode.succeed f_)