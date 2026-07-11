module M3e.NavBar exposing (view, mode, onChange, onBeforeinput, onInput)

{-| A horizontal bar, typically used on smaller devices, that allows a user to switch between 3-5 views.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected state of an item changes.
  - `beforeinput`: Dispatched before the selected state of an item changes.
  - `input`: Dispatched when the selected state of an item changes.

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Modes" -->
```elm
[ M3e.NavBar.view [ M3e.NavBar.mode M3e.Token.compact ] [ M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "globe" ] []), Kit.text "Global" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "star" ] []), Kit.text "For you" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "newsstand" ] []), Kit.text "Trending" ] ]
    , Native.br
    , M3e.NavBar.view [ M3e.NavBar.mode M3e.Token.expanded ] [ M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "globe" ] []), Kit.text "Global" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "star" ] []), Kit.text "For you" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "newsstand" ] []), Kit.text "Trending" ] ]
    ]
```

<!-- elm-cem:example title="Items" -->
```elm
M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.NavBar.view [] [ M3e.NavItem.view [ M3e.NavItem.selected True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "globe" ] []), Kit.text "Global" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "star" ] []), Kit.text "For you" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "newsstand" ] []), Kit.text "Trending" ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.NavBar.view [] [ M3e.NavItem.view [ M3e.NavItem.disabled True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ], M3e.NavItem.view [ M3e.NavItem.disabledInteractive True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "globe" ] []), Kit.text "Global" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "star" ] []), Kit.text "For you" ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "newsstand" ] []), Kit.text "Trending" ] ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.NavBar.view [] [ M3e.NavItem.view [ M3e.NavItem.href "https://www.google.com", M3e.NavItem.target "_blank" ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ] ]
```

@docs view, mode, onChange, onBeforeinput, onInput

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.NavBar
import M3e.Node
import M3e.Token


{-| Build the `<m3e-nav-bar>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { mode : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { navItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | navBar : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.NavBar.navBar
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The mode in which items in the bar are presented. (default: `"compact"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , compact : M3e.Token.Supported
        , expanded : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.NavBar.mode


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.NavBar.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.NavBar.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.NavBar.onInput
