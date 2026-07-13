module M3e.Build.NavMenuItem exposing
    ( Builder, AttrCaps, SlotCaps, navMenuItem, attr, disabled
    , open, selected, onOpening, onOpened, onClosing, onClosed
    , onClick, icon, badge, selectedIcon, toggleIcon, build
    )

{-| The Build form for `<m3e-nav-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItem as NavMenuItem`.

@docs Builder, AttrCaps, SlotCaps, navMenuItem, attr, disabled
@docs open, selected, onOpening, onOpened, onClosing, onClosed
@docs onClick, icon, badge, selectedIcon, toggleIcon, build

-}

import M3e.Build.Internal
import M3e.Html.NavMenuItem
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-nav-menu-item>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | navMenuItem : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
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
    , badge : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-nav-menu-item>` with the required fields.
-}
navMenuItem :
    { label :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedLink : Markup.Kind.Shared
            }
            msg
    }
    -> Builder AttrCaps SlotCaps msg kind
navMenuItem req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.NavMenuItem.navMenuItem
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode
                (Markup.Element.withSlot "label" req_.label)
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
                (M3e.Html.NavMenuItem.disabled v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.NavMenuItem.open v_))
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.NavMenuItem.selected v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.NavMenuItem.onOpening v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.NavMenuItem.onOpened v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.NavMenuItem.onClosing v_)
            )
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.NavMenuItem.onClosed v_)
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.NavMenuItem.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `badge` slot.
-}
badge :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , badge : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | badge : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | badge : M3e.Build.Internal.Used } msg kind
badge el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "badge" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected-icon` slot.
-}
selectedIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg kind
selectedIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "selected-icon" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg kind
toggleIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "toggle-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-nav-menu-item>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { navMenuItem : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
