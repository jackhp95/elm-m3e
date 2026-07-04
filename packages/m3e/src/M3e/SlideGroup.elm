module M3e.SlideGroup exposing
    ( view, disabled, nextPageLabel, previousPageLabel, threshold, vertical
    , child, nextIcon, prevIcon, children
    )

{-|
Presents pagination controls used to scroll overflowing content.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `next-icon`: Renders the icon to present for the next button.
- `prev-icon`: Renders the icon to present for the previous button.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Horizontal scrollable button row" -->
```elm
M3e.SlideGroup.view [ M3e.SlideGroup.threshold 48, M3e.SlideGroup.previousPageLabel "Scroll left", M3e.SlideGroup.nextPageLabel "Scroll right" ] ([ M3e.SlideGroup.prevIcon (M3e.Icon.view [ M3e.Icon.name "chevron_left" ] []), M3e.SlideGroup.nextIcon (M3e.Icon.view [ M3e.Icon.name "chevron_right" ] []) ] ++ M3e.SlideGroup.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.child (Kit.text "All") ], M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ M3e.Button.child (Kit.text "Photos") ], M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ M3e.Button.child (Kit.text "Videos") ], M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ M3e.Button.child (Kit.text "Documents") ], M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ M3e.Button.child (Kit.text "Music") ], M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ M3e.Button.child (Kit.text "Archives") ] ])
```

<!-- elm-cem:example title="Vertical slide group of cards" -->
```elm
M3e.SlideGroup.view [ M3e.SlideGroup.vertical True, M3e.SlideGroup.threshold 32 ] (M3e.SlideGroup.children [ Native.div [] [ Kit.text "Item 1" ], Native.div [] [ Kit.text "Item 2" ], Native.div [] [ Kit.text "Item 3" ], Native.div [] [ Kit.text "Item 4" ], Native.div [] [ Kit.text "Item 5" ] ])
```

@docs view, disabled, nextPageLabel, previousPageLabel, threshold, vertical
@docs child, nextIcon, prevIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.SlideGroup
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slide-group>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , threshold : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | slideGroup : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SlideGroup.slideGroup
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SlideGroup.disabled


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.SlideGroup.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.SlideGroup.previousPageLabel


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float -> M3e.Cem.Attr.Attr { c | threshold : M3e.Value.Supported } msg
threshold =
    M3e.Cem.SlideGroup.threshold


{-| Whether content is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.SlideGroup.vertical


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
nextIcon el =
    M3e.Content.slot "next-icon" el


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
prevIcon el =
    M3e.Content.slot "prev-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els