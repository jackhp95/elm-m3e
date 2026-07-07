module M3e.ContentPane exposing ( view )

{-|
A shaped surface for vertically scrollable content.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Usage" -->
```elm
M3e.ContentPane.view [] (M3e.ContentPane.children [ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large ] [ M3e.Heading.child (Kit.text "Content header") ], Native.p [] [ Kit.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae ligula at ipsum pulvinar tincidunt.\n    Integer feugiat, tortor non aliquet facilisis, velit risus faucibus lorem, vitae porttitor justo arcu\n    nec sapien. Curabitur euismod, urna vel placerat dictum, augue sem ullamcorper velit, id interdum neque\n    magna non nisl. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.\n    Suspendisse potenti. Praesent ac orci eget urna volutpat fermentum. Donec non mi sed sapien gravida\n    aliquet. Vivamus at orci id libero scelerisque convallis. Pellentesque habitant morbi tristique senectus\n    et netus et malesuada fames ac turpis egestas. Cras ac erat id velit pharetra luctus. Mauris sed nisl\n    sed arcu facilisis tincidunt. Aliquam erat volutpat. Sed sit amet massa non magna gravida cursus. Sed\n    vulputate, velit id suscipit convallis, lorem ipsum varius neque, sed porttitor lacus justo vitae\n    libero. Integer at felis vel lacus porta posuere. Aenean non lorem ac nulla gravida tincidunt.\n    Pellentesque vel urna id libero dictum gravida. Donec sit amet velit nec sapien ultricies tincidunt.\n    Vivamus in augue id libero sodales tincidunt. Integer id lorem nec sapien bibendum tincidunt. Sed id\n    lacus non justo viverra tincidunt. Curabitur id risus vitae justo tincidunt gravida. Vivamus id ligula\n    non ipsum porta tincidunt. Pellentesque id lorem nec sapien dictum tincidunt. Integer id lorem nec\n    sapien bibendum tincidunt." ] ])
```

<!-- elm-cem:example title="Content header" -->
```elm
M3e.ContentPane.view [] (M3e.ContentPane.children [ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large ] [ M3e.Heading.child (Kit.text "Content header") ], Native.p [] [] ])
```

@docs view
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ContentPane
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-content-pane>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | contentPane : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ContentPane.contentPane
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )