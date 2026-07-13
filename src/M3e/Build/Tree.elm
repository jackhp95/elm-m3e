module M3e.Build.Tree exposing
    ( Builder, AttrCaps, SlotCaps, tree, attr, multi
    , cascade, onChange, build
    )

{-| The Build form for `<m3e-tree>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tree as Tree`.

@docs Builder, AttrCaps, SlotCaps, tree, attr, multi
@docs cascade, onChange, build

-}

import M3e.Build.Internal
import M3e.Html.Tree
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-tree>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | tree : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , cascade : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-tree>`.
-}
tree : Builder AttrCaps SlotCaps msg kind
tree =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Tree.tree
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


{-| Whether multiple items can be selected. (default: `false`)
-}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Tree.multi v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade :
    Bool
    -> Builder { a | cascade : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | cascade : M3e.Build.Internal.Used } s msg kind
cascade v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Tree.cascade v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Tree.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tree>` element from a `Builder`.
-}
build : Builder a s msg kind -> Markup.Element.Element { tree : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
