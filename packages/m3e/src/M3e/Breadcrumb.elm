module M3e.Breadcrumb exposing ( view, wrap, separator )

{-|
Displays a hierarchical navigation path and identifies the user's
current location within an application.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `separator`: Renders a custom separator between breadcrumb items.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.Breadcrumb.view [] [ M3e.Breadcrumb.child (M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "https://developer.mozilla.org/en-US/docs/Web", M3e.BreadcrumbItem.target "_blank" ] [ M3e.BreadcrumbItem.child (Kit.text "Web") ]) ]
```

<!-- elm-cem:example title="Icons" -->
```elm
M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.itemLabel "Dashboard" ] [ M3e.BreadcrumbItem.child (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []) ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
```

<!-- elm-cem:example title="Custom separators" -->
```elm
M3e.Breadcrumb.view [] ([ M3e.Breadcrumb.separator (Native.span [] [ Kit.text "/" ]) ] ++ M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
```

<!-- elm-cem:example title="Wrapping" -->
```elm
M3e.Breadcrumb.view [ M3e.Breadcrumb.wrap True ] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Lorem ipsum dolor sit amet") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Consectetur adipiscing elit sed do") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Tempor incididunt ut labore et dolore") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Magna aliqua ut enim ad minim veniam") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.child (Kit.text "Quis nostrud exercitation ullamco laboris nisi ut aliquip") ] ])
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
    , M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
    , M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
    , M3e.Breadcrumb.view [] (M3e.Breadcrumb.children [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), M3e.BreadcrumbItem.child (Kit.text "Dashboard") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), M3e.BreadcrumbItem.child (Kit.text "Reports") ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), M3e.BreadcrumbItem.child (Kit.text "Annual") ] ])
    ]
```

@docs view, wrap, separator
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Breadcrumb
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-breadcrumb>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { wrap : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | breadcrumb : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Breadcrumb.breadcrumb
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
wrap =
    M3e.Cem.Breadcrumb.wrap


{-| Place content in the `separator` slot. -}
separator : M3e.Element.Element any msg -> M3e.Element.Element k msg
separator el =
    M3e.Element.Internal.placeSlot "separator" el