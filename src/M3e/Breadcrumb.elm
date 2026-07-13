module M3e.Breadcrumb exposing (view, wrap, separator)

{-| Displays a hierarchical navigation path and identifies the user's
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
M3e.Breadcrumb.view [] [ M3e.BreadcrumbItem.view [] [ Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ Kit.text "Annual" ] ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.Breadcrumb.view [] [ M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.href "https://developer.mozilla.org/en-US/docs/Web", M3e.BreadcrumbItem.target "_blank" ] [ Kit.text "Web" ] ]
```

<!-- elm-cem:example title="Icons" -->
```elm
M3e.Breadcrumb.view [] [ M3e.BreadcrumbItem.view [ M3e.BreadcrumbItem.itemLabel "Dashboard" ] [ M3e.Icon.view [ M3e.Icon.name "dashboard" ] [] ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), Kit.text "Annual" ] ]
```

<!-- elm-cem:example title="Custom separators" -->
```elm
M3e.Breadcrumb.view [] [ M3e.Breadcrumb.separator (Native.span [] [ Kit.text "/" ]), M3e.BreadcrumbItem.view [] [ Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ Kit.text "Annual" ] ]
```

<!-- elm-cem:example title="Wrapping" -->
```elm
M3e.Breadcrumb.view [ M3e.Breadcrumb.wrap True ] [ M3e.BreadcrumbItem.view [] [ Kit.text "Lorem ipsum dolor sit amet" ], M3e.BreadcrumbItem.view [] [ Kit.text "Consectetur adipiscing elit sed do" ], M3e.BreadcrumbItem.view [] [ Kit.text "Tempor incididunt ut labore et dolore" ], M3e.BreadcrumbItem.view [] [ Kit.text "Magna aliqua ut enim ad minim veniam" ], M3e.BreadcrumbItem.view [] [ Kit.text "Quis nostrud exercitation ullamco laboris nisi ut aliquip" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Breadcrumb.view [ M3e.Attributes.class "density-3" ] [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), Kit.text "Annual" ] ]
    , M3e.Breadcrumb.view [ M3e.Attributes.class "density-2" ] [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), Kit.text "Annual" ] ]
    , M3e.Breadcrumb.view [ M3e.Attributes.class "density-1" ] [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), Kit.text "Annual" ] ]
    , M3e.Breadcrumb.view [ M3e.Attributes.class "density-0" ] [ M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), Kit.text "Dashboard" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "analytics" ] []), Kit.text "Reports" ], M3e.BreadcrumbItem.view [] [ M3e.BreadcrumbItem.icon (M3e.Icon.view [ M3e.Icon.name "calendar_month" ] []), Kit.text "Annual" ] ]
    ]
```

@docs view, wrap, separator

-}

import M3e.Html.Breadcrumb
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-breadcrumb>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { wrap : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { breadcrumbItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | breadcrumb : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Breadcrumb.breadcrumb
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap : Bool -> Markup.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
wrap =
    M3e.Html.Breadcrumb.wrap


{-| Place content in the `separator` slot.
-}
separator : Markup.Element.Element any msg -> Markup.Element.Element k msg
separator el =
    Markup.Element.Internal.placeSlot "separator" el
