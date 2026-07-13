module M3e.Build.Shape exposing
    ( Builder, AttrCaps, SlotCaps, shape, attr, name
    , child, build
    )

{-| The Build form for `<m3e-shape>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Shape as Shape`.

@docs Builder, AttrCaps, SlotCaps, shape, attr, name
@docs child, build

-}

import M3e.Build.Internal
import M3e.Html.Shape
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-shape>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | shape : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { nameEnum : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-shape>`.
-}
shape : Builder AttrCaps SlotCaps msg kind
shape =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Shape.shape
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
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
    -> Builder { a | nameEnum : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nameEnum : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Shape.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-shape>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { shape : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
