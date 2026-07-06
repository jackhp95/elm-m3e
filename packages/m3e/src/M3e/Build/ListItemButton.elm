module M3e.Build.ListItemButton exposing
    ( Builder, AttrCaps, SlotCaps, listItemButton, href, target
    , rel, download, disabled, onClick, child, leading, overline
    , supportingText, trailing, build
    )

{-|
The ⑤ Build shape for `<m3e-list-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItemButton as ListItemButton`.

@docs Builder, AttrCaps, SlotCaps, listItemButton, href, target
@docs rel, download, disabled, onClick, child, leading
@docs overline, supportingText, trailing, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ListItemButton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list-item-button>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | listItemButton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-item-button>`. -}
listItemButton : Builder AttrCaps SlotCaps msg kind
listItemButton =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ListItemButton.listItemButton
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The URL to which the link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.href v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.target v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.rel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.download v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `click` events. -}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListItemButton.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg kind
leading el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "leading" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "overline" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `supporting-text` slot. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg kind
supportingText el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "supporting-text" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg kind
trailing el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "trailing" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-list-item-button>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { listItemButton : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)