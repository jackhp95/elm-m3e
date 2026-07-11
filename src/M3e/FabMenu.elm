module M3e.FabMenu exposing (view, variant, onBeforetoggle, onToggle)

{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

<!-- elm-cem:docmeta category=Actions -->


## Examples


### Examples

<!-- elm-cem:example title="Icons" -->
```elm
M3e.FabMenuItem.view [] [ M3e.FabMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "email", M3e.Icon.filled True ] []), Kit.text "Email" ]
```

@docs view, variant, onBeforetoggle, onToggle

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.FabMenu
import M3e.Node
import M3e.Token


{-| Build the `<m3e-fab-menu>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { fabMenuItem : M3e.Token.Supported
                , menuItem : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | fabMenu : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.FabMenu.fabMenu
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the menu. (default: `"primary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.FabMenu.variant


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.FabMenu.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.FabMenu.onToggle
