module M3e.Divider exposing (view, inset, insetStart, insetEnd, vertical)

{-| A thin line that separates content in lists or other containers.

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

import M3e.Html.Divider
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-divider>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { inset : M3e.Token.Supported
            , insetStart : M3e.Token.Supported
            , insetEnd : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | divider : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Divider.divider
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> Markup.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
inset =
    M3e.Html.Divider.inset


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> Markup.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
insetStart =
    M3e.Html.Divider.insetStart


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> Markup.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
insetEnd =
    M3e.Html.Divider.insetEnd


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Divider.vertical
