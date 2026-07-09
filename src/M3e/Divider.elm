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

<!-- elm-cem:example title="Lists" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Inset" -->
```elm
[ M3e.Divider.view [] []
    , Native.br
    , M3e.Divider.view [ M3e.Divider.inset True ] []
    , Native.br
    , M3e.Divider.view [ M3e.Divider.insetStart True ] []
    , Native.br
    , M3e.Divider.view [ M3e.Divider.insetEnd True ] []
    ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
[ M3e.Divider.view [ M3e.Divider.vertical True ] []
    , M3e.Divider.view [ M3e.Divider.vertical True, M3e.Divider.inset True ] []
    , M3e.Divider.view [ M3e.Divider.vertical True, M3e.Divider.insetStart True ] []
    , M3e.Divider.view [ M3e.Divider.vertical True, M3e.Divider.insetEnd True ] []
    ]
```

@docs view, inset, insetStart, insetEnd, vertical
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Divider
import M3e.Element
import M3e.Element.Internal
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | divider : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Divider.divider
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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