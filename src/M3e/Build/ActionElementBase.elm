module M3e.Build.ActionElementBase exposing
    ( Builder, AttrCaps, SlotCaps, actionElementBase, attr, build
    )

{-|
The ⑤ Build shape for `<ActionElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionElementBase as ActionElementBase`.

@docs Builder, AttrCaps, SlotCaps, actionElementBase, attr, build
-}


import M3e.Build.Internal
import M3e.Cem.ActionElementBase
import M3e.Cem.Attr.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<ActionElementBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | actionElementBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<ActionElementBase>`. -}
actionElementBase : Builder AttrCaps SlotCaps msg kind
actionElementBase =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ActionElementBase.actionElementBase
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


{-| Build the `<ActionElementBase>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { actionElementBase : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)