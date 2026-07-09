module M3e.SlideGroup exposing
    ( view, disabled, nextPageLabel, previousPageLabel, threshold, vertical
    , nextIcon, prevIcon
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

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.SlideGroup.view [] [ Native.div [] [ Kit.text "Item 1" ], Native.div [] [ Kit.text "Item 2" ], Native.div [] [ Kit.text "Item 3" ], Native.div [] [ Kit.text "Item 4" ], Native.div [] [ Kit.text "Item 5" ], Native.div [] [ Kit.text "Item 6" ], Native.div [] [ Kit.text "Item 7" ], Native.div [] [ Kit.text "Item 8" ], Native.div [] [ Kit.text "Item 9" ], Native.div [] [ Kit.text "Item 10" ], Native.div [] [ Kit.text "Item 11" ], Native.div [] [ Kit.text "Item 12" ], Native.div [] [ Kit.text "Item 13" ], Native.div [] [ Kit.text "Item 14" ], Native.div [] [ Kit.text "Item 15" ], Native.div [] [ Kit.text "Item 16" ], Native.div [] [ Kit.text "Item 17" ], Native.div [] [ Kit.text "Item 18" ], Native.div [] [ Kit.text "Item 19" ], Native.div [] [ Kit.text "Item 20" ] ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
M3e.SlideGroup.view [ M3e.SlideGroup.vertical True ] [ Native.div [] [ Kit.text "Item 1" ], Native.div [] [ Kit.text "Item 2" ], Native.div [] [ Kit.text "Item 3" ], Native.div [] [ Kit.text "Item 4" ], Native.div [] [ Kit.text "Item 5" ], Native.div [] [ Kit.text "Item 6" ], Native.div [] [ Kit.text "Item 7" ], Native.div [] [ Kit.text "Item 8" ], Native.div [] [ Kit.text "Item 9" ], Native.div [] [ Kit.text "Item 10" ], Native.div [] [ Kit.text "Item 11" ], Native.div [] [ Kit.text "Item 12" ], Native.div [] [ Kit.text "Item 13" ], Native.div [] [ Kit.text "Item 14" ], Native.div [] [ Kit.text "Item 15" ], Native.div [] [ Kit.text "Item 16" ], Native.div [] [ Kit.text "Item 17" ], Native.div [] [ Kit.text "Item 18" ], Native.div [] [ Kit.text "Item 19" ], Native.div [] [ Kit.text "Item 20" ] ]
```

@docs view, disabled, nextPageLabel, previousPageLabel, threshold, vertical
@docs nextIcon, prevIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SlideGroup
import M3e.Element
import M3e.Element.Internal
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slideGroup : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SlideGroup.slideGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
nextIcon el =
    M3e.Element.Internal.placeSlot "next-icon" el


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
prevIcon el =
    M3e.Element.Internal.placeSlot "prev-icon" el