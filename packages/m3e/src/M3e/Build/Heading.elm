module M3e.Build.Heading exposing
    ( Builder, AttrCaps, SlotCaps, heading, attr, emphasized
    , level, size, variant, build
    )

{-|
The ⑤ Build shape for `<m3e-heading>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Heading as Heading`.

@docs Builder, AttrCaps, SlotCaps, heading, attr, emphasized
@docs level, size, variant, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Heading
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-heading>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | heading : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { emphasized : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-heading>` with the required fields. -}
heading :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
heading req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Heading.heading
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             [ M3e.Element.toNode req_.content ]
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


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool
    -> Builder { a | emphasized : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | emphasized : M3e.Build.Internal.Used } s msg kind
emphasized v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Heading.emphasized v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessibility level of the heading. -}
level :
    Int
    -> Builder { a | level : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | level : M3e.Build.Internal.Used } s msg kind
level v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Heading.level v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the heading. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Heading.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the heading. (default: `"display"`) -}
variant :
    M3e.Value.Value { display : M3e.Value.Supported
    , headline : M3e.Value.Supported
    , label : M3e.Value.Supported
    , title : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Heading.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-heading>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { heading : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)