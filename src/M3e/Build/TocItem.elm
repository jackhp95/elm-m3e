module M3e.Build.TocItem exposing
    ( Builder, AttrCaps, SlotCaps, tocItem, attr, disabled
    , selected, onClick, build
    )

{-| The Build form for `<m3e-toc-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TocItem as TocItem`.

@docs Builder, AttrCaps, SlotCaps, tocItem, attr, disabled
@docs selected, onClick, build

-}

import M3e.Build.Internal
import M3e.Html.TocItem
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-toc-item>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | tocItem : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-toc-item>` with the required fields.
-}
tocItem :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
tocItem req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.TocItem.tocItem
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode req_.content ]
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


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.TocItem.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`)
-}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.TocItem.selected v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked.
-}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.TocItem.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-toc-item>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { tocItem : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
