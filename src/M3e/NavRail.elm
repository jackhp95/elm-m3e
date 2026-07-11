module M3e.NavRail exposing (view, mode, onBeforeinput, onInput, onChange)

{-| A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Component Info:**

  - **Extends:** `M3eNavBarElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state of an item changes.
  - `input`: Dispatched when the selected state of an item changes.
  - `change`: Dispatched when the selected state of an item changes.

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Items" -->
```elm
M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "news" ] []), Kit.text "News" ]
```

@docs view, mode, onBeforeinput, onInput, onChange

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.NavRail
import M3e.Node
import M3e.Token


{-| Build the `<m3e-nav-rail>` element (lazy IR).
-}
view :
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
    ->
        List
            (M3e.Element.Element
                { navItem : M3e.Token.Supported
                , iconButton : M3e.Token.Supported
                , fab : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | navRail : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.NavRail.navRail
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The mode in which items in the rail are presented. (default: `"compact"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , compact : M3e.Token.Supported
        , expanded : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.NavRail.mode


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.NavRail.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.NavRail.onInput


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.NavRail.onChange
