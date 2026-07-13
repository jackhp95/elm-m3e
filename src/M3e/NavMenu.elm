module M3e.NavMenu exposing (view)

{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Multilevel menus" -->
```elm
M3e.NavMenu.view [] [ M3e.NavMenuItem.view [ M3e.NavMenuItem.open True ] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Getting Started"), M3e.NavMenuItem.view [] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "widgets", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Overview") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Installation") ] ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Actions"), M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Button") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon Button") ] ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.NavMenu.view [] [ M3e.NavMenuItem.view [ M3e.NavMenuItem.open True, M3e.NavMenuItem.disabled True ] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Getting Started"), M3e.NavMenuItem.view [] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "widgets", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Overview") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2", M3e.Aria.hidden "true" ] []), M3e.NavMenuItem.label (Kit.text "Installation") ] ], M3e.NavMenuItem.view [ M3e.NavMenuItem.open True ] [ M3e.NavMenuItem.label (Kit.text "Actions"), M3e.NavMenuItem.view [ M3e.NavMenuItem.disabled True ] [ M3e.NavMenuItem.label (Kit.text "Button") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon Button") ] ] ]
```

@docs view

-}

import M3e.Html.NavMenu
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-nav-menu>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { navMenuItem : M3e.Kind.Brand
                , navMenuItemGroup : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | navMenu : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.NavMenu.navMenu
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
