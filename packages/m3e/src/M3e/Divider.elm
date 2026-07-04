module M3e.Divider exposing
    ( view, inset, insetStart, insetEnd, vertical
    )

{-|
A thin line that separates content in lists or other containers.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Dividers separating a settings list" -->
```elm
Native.ul [] [ Native.li [] [ Kit.text "Profile" ], M3e.Divider.view [ M3e.Divider.insetStart True ] [], Native.li [] [ Kit.text "Privacy" ], M3e.Divider.view [ M3e.Divider.insetStart True ] [], Native.li [] [ Kit.text "Notifications" ] ]
```

<!-- elm-cem:example title="Vertical divider between toolbar actions" -->
```elm
Native.nav [] [ M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.child (Kit.text "Bold"), M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "format_bold" ] []) ], M3e.Divider.view [ M3e.Divider.vertical True ] [], M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.child (Kit.text "Link"), M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "link" ] []) ] ]
```

@docs view, inset, insetStart, insetEnd, vertical
-}


import M3e.Cem.Attr
import M3e.Cem.Divider
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-divider>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { inset : M3e.Value.Supported
    , insetStart : M3e.Value.Supported
    , insetEnd : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | divider : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Divider.divider
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> M3e.Cem.Attr.Attr { c | inset : M3e.Value.Supported } msg
inset =
    M3e.Cem.Divider.inset


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool -> M3e.Cem.Attr.Attr { c | insetStart : M3e.Value.Supported } msg
insetStart =
    M3e.Cem.Divider.insetStart


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> M3e.Cem.Attr.Attr { c | insetEnd : M3e.Value.Supported } msg
insetEnd =
    M3e.Cem.Divider.insetEnd


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Divider.vertical