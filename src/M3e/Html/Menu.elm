module M3e.Html.Menu exposing
    ( menu, positionX, positionY, variant, submenu, onBeforetoggle
    , onToggle
    )

{-| Middle layer for `<m3e-menu>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Menu` module for everyday use.

@docs menu, positionX, positionY, variant, submenu, onBeforetoggle
@docs onToggle

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Menu
import M3e.Token


{-| Presents a list of choices on a temporary surface.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
menu :
    List
        (M3e.Html.Attr.Attr
            { positionX : M3e.Token.Supported
            , positionY : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , submenu : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
menu attributes children =
    M3e.Raw.Menu.menu (List.map M3e.Html.Attr.toAttribute attributes) children


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionX v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Menu.positionX
        (M3e.Token.toString v_)


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionY v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Menu.positionY
        (M3e.Token.toString v_)


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { standard : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Menu.variant
        (M3e.Token.toString v_)


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> M3e.Html.Attr.Attr { c | submenu : M3e.Token.Supported } msg
submenu =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Menu.submenu


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Menu.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle :
    (String -> msg)
    -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Menu.onToggle
        (Json.Decode.map f_ (Json.Decode.at [ "newState" ] Json.Decode.string))
