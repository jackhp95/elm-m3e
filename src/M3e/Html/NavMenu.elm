module M3e.Html.NavMenu exposing (navMenu)

{-| Middle layer for `<m3e-nav-menu>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavMenu` module for everyday use.

@docs navMenu

-}

import Html
import M3e.Raw.NavMenu
import M3e.Token
import Markup.Html.Attr


{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

**Component Info:**

  - **Extends:** `LitElement`

-}
navMenu :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navMenu attributes children =
    M3e.Raw.NavMenu.navMenu
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
