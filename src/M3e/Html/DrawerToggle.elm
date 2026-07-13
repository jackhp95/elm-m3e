module M3e.Html.DrawerToggle exposing (drawerToggle, for)

{-| Middle layer for `<m3e-drawer-toggle>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DrawerToggle` module for everyday use.

@docs drawerToggle, for

-}

import Html
import M3e.Raw.DrawerToggle
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An element, nested within a clickable element, used to toggle the opened state of a drawer.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
drawerToggle :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
drawerToggle attributes children =
    M3e.Raw.DrawerToggle.drawerToggle
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DrawerToggle.for
