module M3e.Shape exposing ( view, name, child, children )

{-|
A shape used to add emphasis and decorative flair.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Decorative sunny shape with icon" -->
```elm
M3e.Shape.view [ M3e.Shape.name M3e.Value.sunny ] [ M3e.Shape.child (M3e.Icon.view [ M3e.Icon.name "star" ] []) ]
```

<!-- elm-cem:example title="Row of expressive decorative shapes" -->
```elm
Native.div [] [ M3e.Shape.view [ M3e.Shape.name M3e.Value.value4LeafClover ] [], M3e.Shape.view [ M3e.Shape.name M3e.Value.heart ] [], M3e.Shape.view [ M3e.Shape.name M3e.Value.diamond ] [], M3e.Shape.view [ M3e.Shape.name M3e.Value.burst ] [] ]
```

@docs view, name, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Shape
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-shape>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { name : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | shape : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Shape.shape
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The name of the shape. (default: `null`) -}
name :
    M3e.Value.Value { value12SidedCookie : M3e.Value.Supported
    , value4LeafClover : M3e.Value.Supported
    , value4SidedCookie : M3e.Value.Supported
    , value6SidedCookie : M3e.Value.Supported
    , value7SidedCookie : M3e.Value.Supported
    , value8LeafClover : M3e.Value.Supported
    , value9SidedCookie : M3e.Value.Supported
    , arch : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , boom : M3e.Value.Supported
    , bun : M3e.Value.Supported
    , burst : M3e.Value.Supported
    , circle : M3e.Value.Supported
    , diamond : M3e.Value.Supported
    , fan : M3e.Value.Supported
    , flower : M3e.Value.Supported
    , gem : M3e.Value.Supported
    , ghostIsh : M3e.Value.Supported
    , heart : M3e.Value.Supported
    , hexagon : M3e.Value.Supported
    , oval : M3e.Value.Supported
    , pentagon : M3e.Value.Supported
    , pill : M3e.Value.Supported
    , pixelCircle : M3e.Value.Supported
    , pixelTriangle : M3e.Value.Supported
    , puffy : M3e.Value.Supported
    , puffyDiamond : M3e.Value.Supported
    , semicircle : M3e.Value.Supported
    , slanted : M3e.Value.Supported
    , softBoom : M3e.Value.Supported
    , softBurst : M3e.Value.Supported
    , square : M3e.Value.Supported
    , sunny : M3e.Value.Supported
    , triangle : M3e.Value.Supported
    , verySunny : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Shape.name


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