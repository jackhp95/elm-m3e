module M3e.Skeleton exposing
    ( view, animation, shape, loaded, child, children
    )

{-|
A visual placeholder that mimics the layout of content while it's still loading.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Card loading placeholder with wave animation" -->
```elm
M3e.Skeleton.view [ M3e.Skeleton.animation M3e.Value.wave, M3e.Skeleton.shape M3e.Value.rounded ] [ M3e.Skeleton.child (Native.div [] [ Native.p [] [ Kit.text "Loading content..." ] ]) ]
```

<!-- elm-cem:example title="Circular avatar and text placeholders" -->
```elm
Native.div [] [ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.circular, M3e.Skeleton.animation M3e.Value.pulse ] [], M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.rounded, M3e.Skeleton.animation M3e.Value.pulse ] [], M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.rounded, M3e.Skeleton.animation M3e.Value.pulse ] [] ]
```

<!-- elm-cem:example title="Loaded skeleton revealing content" -->
```elm
M3e.Skeleton.view [ M3e.Skeleton.loaded True, M3e.Skeleton.shape M3e.Value.auto, M3e.Skeleton.animation M3e.Value.none ] [ M3e.Skeleton.child (Native.p [] [ Kit.text "Content has finished loading." ]) ]
```

@docs view, animation, shape, loaded, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Skeleton
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-skeleton>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { animation : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , loaded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | skeleton : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Skeleton.skeleton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animation =
    M3e.Cem.Skeleton.animation


{-| The shape of the skeleton. (default: `"auto"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.Skeleton.shape


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
loaded =
    M3e.Cem.Skeleton.loaded


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els