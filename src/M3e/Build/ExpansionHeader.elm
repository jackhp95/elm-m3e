module M3e.Build.ExpansionHeader exposing
    ( Builder, AttrCaps, SlotCaps, expansionHeader, attr, hideToggle
    , toggleDirection, togglePosition, disabled, onClick, child, toggleIcon
    , build
    )

{-| The Build form for `<m3e-expansion-header>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionHeader as ExpansionHeader`.

@docs Builder, AttrCaps, SlotCaps, expansionHeader, attr, hideToggle
@docs toggleDirection, togglePosition, disabled, onClick, child, toggleIcon
@docs build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.ExpansionHeader
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-expansion-header>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | expansionHeader : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { hideToggle : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expansion-header>`.
-}
expansionHeader : Builder AttrCaps SlotCaps msg kind
expansionHeader =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ExpansionHeader.expansionHeader
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle :
    Bool
    -> Builder { a | hideToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideToggle : M3e.Build.Internal.Used } s msg kind
hideToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.ExpansionHeader.hideToggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Builder { a | toggleDirection : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | toggleDirection : M3e.Build.Internal.Used } s msg kind
toggleDirection v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.ExpansionHeader.toggleDirection v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Builder { a | togglePosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | togglePosition : M3e.Build.Internal.Used } s msg kind
togglePosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.ExpansionHeader.togglePosition v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.ExpansionHeader.disabled v_)
            )
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
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.ExpansionHeader.onClick v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg kind
toggleIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "toggle-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-expansion-header>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { expansionHeader : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
