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

import M3e.Html.NavRail
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-nav-rail>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
            (Markup.Element.Element
                { navItem : M3e.Kind.Brand
                , iconButton : M3e.Kind.Brand
                , fab : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | navRail : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.NavRail.navRail
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The mode in which items in the rail are presented. (default: `"compact"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , compact : M3e.Token.Supported
        , expanded : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.NavRail.mode


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.NavRail.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.NavRail.onInput


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.NavRail.onChange
