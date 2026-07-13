module M3e.Build.MenuItem exposing
    ( Builder, AttrCaps, SlotCaps, menuItem, attr, disabled
    , download, href, rel, target, onClick, child
    , icon, trailingIcon, build
    )

{-| The Build form for `<m3e-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItem as MenuItem`.

@docs Builder, AttrCaps, SlotCaps, menuItem, attr, disabled
@docs download, href, rel, target, onClick, child
@docs icon, trailingIcon, build

-}

import M3e.Build.Internal
import M3e.Html.MenuItem
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-menu-item>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | menuItem : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-menu-item>`.
-}
menuItem : Builder AttrCaps SlotCaps msg kind
menuItem =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.MenuItem.menuItem
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.download v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the link button points. (default: `""`)
-}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.href v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.rel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The target of the link button. (default: `""`)
-}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.target v_))
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.MenuItem.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , dialogTrigger : M3e.Kind.Brand
        , dialogAction : M3e.Kind.Brand
        , menuTrigger : M3e.Kind.Brand
        , fabMenuTrigger : M3e.Kind.Brand
        , bottomSheetTrigger : M3e.Kind.Brand
        , bottomSheetAction : M3e.Kind.Brand
        , stepperPrevious : M3e.Kind.Brand
        , stepperReset : M3e.Kind.Brand
        , richTooltipAction : M3e.Kind.Brand
        , drawerToggle : M3e.Kind.Brand
        , datepickerToggle : M3e.Kind.Brand
        , navRailToggle : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
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


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "trailing-icon" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-menu-item>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { menuItem : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
