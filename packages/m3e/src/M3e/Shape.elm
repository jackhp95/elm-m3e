module M3e.Shape exposing ( view, name )

{-|
A shape used to add emphasis and decorative flair.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Shapes" -->
```elm
[ M3e.Shape.view [ M3e.Shape.name M3e.Value.value12SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value9SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value8LeafClover ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value7SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value6SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value4SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.value4LeafClover ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.arch ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.arrow ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.boom ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.bun ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.diamond ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.fan ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.flower ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.gem ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.ghostIsh ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.heart ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.hexagon ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.pentagon ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.pill ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.pixelCircle ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.pixelTriangle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.puffy ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.puffyDiamond ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.semicircle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.slanted ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.softBoom ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.softBurst ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.square ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.circle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.triangle ] []
    ]
```

<!-- elm-cem:example title="Images and video" -->
```elm
[ M3e.Shape.view [ M3e.Shape.name M3e.Value.sunny ] [ Native.img [] ]
    , M3e.Shape.view [ M3e.Shape.name M3e.Value.sunny ] [ Native.node Html.video [] [ Native.node Html.source [] [], Native.node Html.source [] [] ] ]
    ]
```

<!-- elm-cem:example title="Morphing" -->
```elm
M3e.Shape.view [] []
```

@docs view, name
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Shape
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-shape>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { nameEnum : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | shape : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Shape.shape
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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
    -> M3e.Cem.Attr.Attr { c | nameEnum : M3e.Value.Supported } msg
name =
    M3e.Cem.Shape.name