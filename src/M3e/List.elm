module M3e.List exposing (view, variant)

{-| A list of items.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "person" ] []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Headline", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (Native.span [] [ Kit.text "100+" ]) ] ]
```

<!-- elm-cem:example title="Variants" -->
```elm
M3e.List.view [ {- round-trip: dropped variant="outlined" on m3e-list — not a valid variant value (expected standard|segmented) -} ] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Variants (2)" -->
```elm
M3e.List.view [ M3e.List.variant M3e.Token.segmented ] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Multiline items" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Label text" ], M3e.ListItem.view [] [ Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]) ], M3e.ListItem.view [] [ M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]) ] ]
```

<!-- elm-cem:example title="Media content" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Label text", M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (2)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), Kit.text "Label text", M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (3)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480" ]), Kit.text "Label text", M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480" ]), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (4)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [ Native.attribute "autoplay" "", Native.attribute "loop" "", Native.attribute "poster" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480", Native.attribute "preload" "auto" ] [ Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.webm", Native.attribute "type" "video/webm" ] [], Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.mp4", Native.attribute "type" "video/mp4" ] [] ]), Kit.text "Label text", M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [ Native.attribute "autoplay" "", Native.attribute "loop" "", Native.attribute "poster" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480", Native.attribute "preload" "auto" ] [ Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.webm", Native.attribute "type" "video/webm" ] [], Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.mp4", Native.attribute "type" "video/mp4" ] [] ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [ Native.attribute "autoplay" "", Native.attribute "loop" "", Native.attribute "poster" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480", Native.attribute "preload" "auto" ] [ Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.webm", Native.attribute "type" "video/webm" ] [], Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.mp4", Native.attribute "type" "video/mp4" ] [] ]), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), Kit.text "Label text", M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []) ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Dividers" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Dividers (2)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.Divider.view [ M3e.Divider.inset True ] [], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.Divider.view [ M3e.Divider.inset True ] [], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Action lists" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [] [ Kit.text "Action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Action lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Token.segmented ] [ M3e.ListAction.view [] [ Kit.text "Action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [ M3e.ListAction.disabled True ] [ Kit.text "Disabled action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Token.segmented ] [ M3e.ListAction.view [ M3e.ListAction.disabled True ] [ Kit.text "Disabled action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [ M3e.ListAction.href "https://www.google.com", M3e.ListAction.target "_blank" ] [ Kit.text "Google" ] ]
```

<!-- elm-cem:example title="Nested lists" -->
```elm
M3e.ActionList.view [] [ M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ] ]
```

<!-- elm-cem:example title="Nested lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Token.segmented ] [ M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item", M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]) ] ]
```

<!-- elm-cem:example title="Selection lists" -->
```elm
M3e.SelectionList.view [] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Selection lists (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Token.segmented ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Multiple selection" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Multiple selection (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Token.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Hiding the selection indicator" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True, M3e.SelectionList.hideSelectionIndicator True ] [ M3e.ListOption.view [ M3e.ListOption.selected True ] [ Kit.text "Option 1", M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []) ], M3e.ListOption.view [] [ Kit.text "Option 2", M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []) ], M3e.ListOption.view [] [ Kit.text "Option 3", M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []) ] ]
```

<!-- elm-cem:example title="Disabling (3)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ Kit.text "Option 1" ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Disabling (4)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Token.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ Kit.text "Option 1" ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.SelectionList.view [ M3e.Attributes.class "density-3", M3e.SelectionList.variant M3e.Token.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

@docs view, variant

-}

import M3e.Html.List
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-list>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { listItem : M3e.Kind.Brand
                , listAction : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , listOption : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | list : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.List.list
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.List.variant
