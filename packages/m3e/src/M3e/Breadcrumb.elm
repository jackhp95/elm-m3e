module M3e.Breadcrumb exposing
    ( view, wrap, child, separator, children
    )

{-|
Displays a hierarchical navigation path and identifies the user's
current location within an application.

**Slots:**
- `separator`: Renders a custom separator between breadcrumb items.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Breadcrumb trail" -->
```elm
M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "/" ] [ M3e.BreadcrumbItem.child (Kit.text "Home") ], M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "/work" ] [ M3e.BreadcrumbItem.child (Kit.text "Work") ], M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "/work/tags" ] [ M3e.BreadcrumbItem.child (Kit.text "Tags") ] ])
```

<!-- elm-cem:example title="Breadcrumb trail with current page" -->
```elm
M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "/photos" ] [ M3e.BreadcrumbItem.child (Kit.text "Photos") ], M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "/collections" ] [ M3e.BreadcrumbItem.child (Kit.text "Collections") ], M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.current M3e.Value.page ] [ M3e.BreadcrumbItem.child (Kit.text "Title") ] ])
```

@docs view, wrap, child, separator, children
-}


import M3e.Cem.Attr
import M3e.Cem.Breadcrumb
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-breadcrumb>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { wrap : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , separator : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | breadcrumb : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Breadcrumb.breadcrumb
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
wrap =
    M3e.Cem.Breadcrumb.wrap


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `separator` slot. -}
separator :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | separator : M3e.Value.Supported } msg
separator el =
    M3e.Content.slot "separator" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els