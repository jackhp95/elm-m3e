module M3e.Build.Tree exposing
    ( Builder, AttrCaps, SlotCaps, tree, multi, cascade
    , onChange, build
    )

{-|
The ⑤ Build shape for `<m3e-tree>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tree as Tree`.

@docs Builder, AttrCaps, SlotCaps, tree, multi, cascade
@docs onChange, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Tree
import M3e.Cem.Tree
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tree>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tree : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , cascade : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-tree>`. -}
tree : Builder AttrCaps SlotCaps msg kind
tree =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tree.tree (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| Whether multiple items can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tree.multi v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade :
    Bool
    -> Builder { a | cascade : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | cascade : M3e.Build.Internal.Used } s msg kind
cascade v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tree.cascade v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Tree.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tree>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tree : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)