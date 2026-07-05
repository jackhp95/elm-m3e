module M3e.Build.TocItem exposing
    ( Builder, AttrCaps, SlotCaps, tocItem, disabled, selected
    , onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-toc-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TocItem as TocItem`.

@docs Builder, AttrCaps, SlotCaps, tocItem, disabled, selected
@docs onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.TocItem
import M3e.Cem.TocItem
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-toc-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tocItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-toc-item>` with the required fields. -}
tocItem :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
tocItem req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.TocItem.tocItem
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TocItem.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TocItem.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.TocItem.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-toc-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tocItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)