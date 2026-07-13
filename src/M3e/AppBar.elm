module M3e.AppBar exposing
    ( view, centered, for, size, leading, title
    , subtitle, trailing, leadingIcon, trailingIcon
    )

{-| A bar, placed a the top of a screen, used to help users navigate through an application.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `leading`: Renders content positioned at the start of the bar.
  - `subtitle`: Renders the subtitle of the bar.
  - `title`: Renders the title of the bar.
  - `trailing`: Renders one or more action buttons aligned to the end of the bar.
  - `leading-icon`: Deprecated: use the `leading` slot.
  - `trailing-icon`: Deprecated: use the `trailing` slot.

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.AppBar.view [] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]), M3e.AppBar.title (Native.span [] [ Kit.text "Top 10 hiking trails" ]), M3e.AppBar.subtitle (Native.span [] [ Kit.text "Discover popular trails" ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "Bookmark", M3e.IconButton.variant M3e.Token.tonal ] [ M3e.Icon.view [ M3e.Icon.name "bookmark", M3e.Icon.filled True ] [] ]) ]
```

<!-- elm-cem:example title="Sizes" -->
```elm
M3e.AppBar.view [ M3e.AppBar.size M3e.Token.medium ] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]), M3e.AppBar.title (Native.span [] [ Kit.text "Top 10 hiking trails" ]), M3e.AppBar.subtitle (Native.span [] [ Kit.text "Discover popular trails" ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "Bookmark", M3e.IconButton.variant M3e.Token.tonal ] [ M3e.Icon.view [ M3e.Icon.name "bookmark", M3e.Icon.filled True ] [] ]) ]
```

<!-- elm-cem:example title="Sizes (2)" -->
```elm
M3e.AppBar.view [ M3e.AppBar.size M3e.Token.large ] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]), M3e.AppBar.title (Native.span [] [ Kit.text "Top 10 hiking trails" ]), M3e.AppBar.subtitle (Native.span [] [ Kit.text "Discover popular trails" ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "Bookmark", M3e.IconButton.variant M3e.Token.tonal ] [ M3e.Icon.view [ M3e.Icon.name "bookmark", M3e.Icon.filled True ] [] ]) ]
```

<!-- elm-cem:example title="Centered" -->
```elm
M3e.AppBar.view [ M3e.AppBar.centered True ] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]), M3e.AppBar.title (Native.span [] [ Kit.text "Top 10 hiking trails" ]), M3e.AppBar.subtitle (Native.span [] [ Kit.text "Discover popular trails" ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "Bookmark" ] [ M3e.Icon.view [ M3e.Icon.name "bookmark" ] [] ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "help" ] [ M3e.Icon.view [ M3e.Icon.name "help" ] [] ]) ]
```

<!-- elm-cem:example title="Scroll effects" -->
```elm
Native.div [ Native.attribute "id" "scrollContainer" ] [ M3e.AppBar.view [ M3e.AppBar.for "scrollContainer" ] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]), M3e.AppBar.title (Native.span [] [ Kit.text "Top 10 hiking trails" ]), M3e.AppBar.subtitle (Native.span [] [ Kit.text "Discover popular trails" ]), M3e.AppBar.trailing (M3e.IconButton.view [ M3e.Aria.label "Bookmark", M3e.IconButton.variant M3e.Token.tonal ] [ M3e.Icon.view [ M3e.Icon.name "bookmark", M3e.Icon.filled True ] [] ]) ], Native.div [ Native.attribute "class" "scroll-item" ] [ Kit.text "Scroll down to see the elevation effect" ] ]
```

@docs view, centered, for, size, leading, title
@docs subtitle, trailing, leadingIcon, trailingIcon

-}

import M3e.Html.AppBar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-app-bar>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , for : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | appBar : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.AppBar.appBar
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> Markup.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    M3e.Html.AppBar.centered


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.AppBar.for


{-| The size of the bar. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.AppBar.size


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
leading el =
    Markup.Element.Internal.placeSlot "leading" el


{-| Place content in the `title` slot.
-}
title :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
title el =
    Markup.Element.Internal.placeSlot "title" el


{-| Place content in the `subtitle` slot.
-}
subtitle :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
subtitle el =
    Markup.Element.Internal.placeSlot "subtitle" el


{-| Place content in the `trailing` slot.
-}
trailing :
    Markup.Element.Element
        { iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        , searchBar : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
trailing el =
    Markup.Element.Internal.placeSlot "trailing" el


{-| Place content in the `leading-icon` slot.
-}
leadingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
leadingIcon el =
    Markup.Element.Internal.placeSlot "leading-icon" el


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
trailingIcon el =
    Markup.Element.Internal.placeSlot "trailing-icon" el
