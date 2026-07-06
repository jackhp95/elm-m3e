module M3e.Build.MenuItem exposing
    ( Builder, AttrCaps, SlotCaps, menuItem, disabled, download
    , href, rel, target, onClick, child, icon, trailingIcon
    , build
    )

{-|
The ⑤ Build shape for `<m3e-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItem as MenuItem`.

@docs Builder, AttrCaps, SlotCaps, menuItem, disabled, download
@docs href, rel, target, onClick, child, icon
@docs trailingIcon, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItem
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-menu-item>`. -}
menuItem : Builder AttrCaps SlotCaps msg kind
menuItem =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MenuItem.menuItem
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.download v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.href v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.rel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The target of the link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.target v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MenuItem.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported
    , dialogTrigger : M3e.Value.Supported
    , dialogAction : M3e.Value.Supported
    , menuTrigger : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    , bottomSheetTrigger : M3e.Value.Supported
    , bottomSheetAction : M3e.Value.Supported
    , stepperPrevious : M3e.Value.Supported
    , stepperReset : M3e.Value.Supported
    , richTooltipAction : M3e.Value.Supported
    , drawerToggle : M3e.Value.Supported
    , datepickerToggle : M3e.Value.Supported
    , navRailToggle : M3e.Value.Supported
    } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "trailing-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-menu-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { menuItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)