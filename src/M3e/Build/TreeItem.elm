module M3e.Build.TreeItem exposing
    ( Builder, AttrCaps, SlotCaps, treeItem, attr, disabled
    , indeterminate, open, selected, onOpening, onOpened, onClosing
    , onClosed, onClick, icon, selectedIcon, toggleIcon, openToggleIcon
    , build
    )

{-| The Build form for `<m3e-tree-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TreeItem as TreeItem`.

@docs Builder, AttrCaps, SlotCaps, treeItem, attr, disabled
@docs indeterminate, open, selected, onOpening, onOpened, onClosing
@docs onClosed, onClick, icon, selectedIcon, toggleIcon, openToggleIcon
@docs build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.TreeItem
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-tree-item>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | treeItem : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , indeterminate : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    , openToggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-tree-item>` with the required fields.
-}
treeItem :
    { label :
        M3e.Element.Element
            { text : M3e.Token.Supported
            , link : M3e.Token.Supported
            }
            msg
    }
    -> Builder AttrCaps SlotCaps msg kind
treeItem req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.TreeItem.treeItem
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ M3e.Element.toNode (M3e.Element.withSlot "label" req_.label) ]
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Builder { a | indeterminate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | indeterminate : M3e.Build.Internal.Used } s msg kind
indeterminate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.indeterminate v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the item is expanded. (default: `false`)
-}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.open v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the item is selected. (default: `false`)
-}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.selected v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to open.
-}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.onOpening v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has opened.
-}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.onOpened v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to close.
-}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.onClosing v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has closed.
-}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.onClosed v_))
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
            (M3e.Html.Attr.Internal.forget (M3e.Html.TreeItem.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected-icon` slot.
-}
selectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg kind
selectedIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "selected-icon" el_))
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


{-| Place content in the `open-toggle-icon` slot.
-}
openToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | openToggleIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | openToggleIcon : M3e.Build.Internal.Used } msg kind
openToggleIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "open-toggle-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tree-item>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { treeItem : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
