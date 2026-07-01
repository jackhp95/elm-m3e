module M3e.Cem.Menu exposing (menu, onBeforetoggle, onToggle, positionX, positionY, submenu, variant)

{-| 
@docs menu, positionX, positionY, variant, submenu, onBeforetoggle, onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Menu
import M3e.Value


{-| Presents a list of choices on a temporary surface.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
menu :
    List (M3e.Cem.Attr.Attr { positionX : M3e.Value.Supported
    , positionY : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , submenu : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menu attributes children =
    M3e.Cem.Html.Menu.menu
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionX v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.positionX (M3e.Value.toString v_)


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionY v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.positionY (M3e.Value.toString v_)


{-| The appearance variant of the menu. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.variant (M3e.Value.toString v_)


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
submenu =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.submenu


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Menu.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.onToggle (Json.Decode.succeed f_)