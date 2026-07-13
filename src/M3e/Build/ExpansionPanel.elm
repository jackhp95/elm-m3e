module M3e.Build.ExpansionPanel exposing
    ( Builder, AttrCaps, SlotCaps, expansionPanel, attr, disabled
    , hideToggle, open, toggleDirection, togglePosition, onOpening, onOpened
    , onClosing, onClosed, child, toggleIcon, build
    )

{-| The Build form for `<m3e-expansion-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionPanel as ExpansionPanel`.

@docs Builder, AttrCaps, SlotCaps, expansionPanel, attr, disabled
@docs hideToggle, open, toggleDirection, togglePosition, onOpening, onOpened
@docs onClosing, onClosed, child, toggleIcon, build

-}

import M3e.Build.Internal
import M3e.Html.ExpansionPanel
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-expansion-panel>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | expansionPanel : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideToggle : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expansion-panel>` with the required fields.
-}
expansionPanel :
    { header : Markup.Element.Element any msg }
    -> Builder AttrCaps SlotCaps msg kind
expansionPanel req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ExpansionPanel.expansionPanel
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode
                (Markup.Element.withSlot "header" req_.header)
            ]
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.disabled v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.hideToggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the panel is expanded. (default: `false`)
-}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ExpansionPanel.open v_))
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.toggleDirection v_)
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.togglePosition v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to open.
-}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.onOpening v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has opened.
-}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.onOpened v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to close.
-}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.onClosing v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has closed.
-}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ExpansionPanel.onClosed v_)
            )
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


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg kind
toggleIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "toggle-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-expansion-panel>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { expansionPanel : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
