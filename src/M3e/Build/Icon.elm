module M3e.Build.Icon exposing
    ( Builder, AttrCaps, SlotCaps, icon, attr, filled
    , grade, opticalSize, name, variant, weight, build
    )

{-|
The ⑤ Build shape for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon, attr, filled
@docs grade, opticalSize, name, variant, weight, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Icon
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-icon>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | icon : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { filled : M3e.Build.Internal.Available
    , grade : M3e.Build.Internal.Available
    , opticalSize : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , weight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-icon>`. -}
icon : Builder AttrCaps SlotCaps msg kind
icon =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Icon.icon
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the icon is filled. (default: `false`) -}
filled :
    Bool
    -> Builder { a | filled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | filled : M3e.Build.Internal.Used } s msg kind
filled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.filled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> Builder { a | grade : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | grade : M3e.Build.Internal.Used } s msg kind
grade v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.grade v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float
    -> Builder { a | opticalSize : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | opticalSize : M3e.Build.Internal.Used } s msg kind
opticalSize v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.opticalSize v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the icon. (default: `""`) -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { outlined : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , sharp : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight :
    Int
    -> Builder { a | weight : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | weight : M3e.Build.Internal.Used } s msg kind
weight v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Icon.weight v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-icon>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { icon : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)