module M3e.Shape exposing (view, name)

{-| A shape used to add emphasis and decorative flair.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Shapes" -->
```elm
[ M3e.Shape.view [ M3e.Shape.name M3e.Token.value12SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value9SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value8LeafClover ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value7SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value6SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value4SidedCookie ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.value4LeafClover ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.arch ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.arrow ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.boom ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.bun ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.diamond ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.fan ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.flower ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.gem ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.ghostIsh ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.heart ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.hexagon ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.pentagon ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.pill ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.pixelCircle ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.pixelTriangle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.puffy ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.puffyDiamond ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.semicircle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.slanted ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.softBoom ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.softBurst ] []
    , Native.br
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.square ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.circle ] []
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.triangle ] []
    ]
```

<!-- elm-cem:example title="Images and video" -->
```elm
[ M3e.Shape.view [ M3e.Shape.name M3e.Token.sunny, M3e.Attributes.class "image-shape" ] [ Native.img [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480" ] ]
    , M3e.Shape.view [ M3e.Shape.name M3e.Token.sunny, M3e.Attributes.class "image-shape" ] [ Native.node Html.video [ Native.attribute "autoplay" "", Native.attribute "loop" "", Native.attribute "poster" "https://www.shutterstock.com/shutterstock/videos/1006393/thumb/1.jpg?ip=x480", Native.attribute "preload" "auto" ] [ Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.webm", Native.attribute "type" "video/webm" ] [], Native.node Html.source [ Native.attribute "src" "https://www.shutterstock.com/shutterstock/videos/1006393/preview/stock-footage-business-people-working-in-office.mp4", Native.attribute "type" "video/mp4" ] [] ] ]
    ]
```

<!-- elm-cem:example title="Morphing" -->
```elm
M3e.Shape.view [ M3e.Attributes.id "morph" ] []
```

@docs view, name

-}

import M3e.Html.Shape
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-shape>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { nameEnum : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | shape : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Shape.shape
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The name of the shape. (default: `null`)
-}
name :
    M3e.Token.Value
        { value12SidedCookie : M3e.Token.Supported
        , value4LeafClover : M3e.Token.Supported
        , value4SidedCookie : M3e.Token.Supported
        , value6SidedCookie : M3e.Token.Supported
        , value7SidedCookie : M3e.Token.Supported
        , value8LeafClover : M3e.Token.Supported
        , value9SidedCookie : M3e.Token.Supported
        , arch : M3e.Token.Supported
        , arrow : M3e.Token.Supported
        , boom : M3e.Token.Supported
        , bun : M3e.Token.Supported
        , burst : M3e.Token.Supported
        , circle : M3e.Token.Supported
        , diamond : M3e.Token.Supported
        , fan : M3e.Token.Supported
        , flower : M3e.Token.Supported
        , gem : M3e.Token.Supported
        , ghostIsh : M3e.Token.Supported
        , heart : M3e.Token.Supported
        , hexagon : M3e.Token.Supported
        , oval : M3e.Token.Supported
        , pentagon : M3e.Token.Supported
        , pill : M3e.Token.Supported
        , pixelCircle : M3e.Token.Supported
        , pixelTriangle : M3e.Token.Supported
        , puffy : M3e.Token.Supported
        , puffyDiamond : M3e.Token.Supported
        , semicircle : M3e.Token.Supported
        , slanted : M3e.Token.Supported
        , softBoom : M3e.Token.Supported
        , softBurst : M3e.Token.Supported
        , square : M3e.Token.Supported
        , sunny : M3e.Token.Supported
        , triangle : M3e.Token.Supported
        , verySunny : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | nameEnum : M3e.Token.Supported } msg
name =
    M3e.Html.Shape.name
