module M3e.Build.SlideGroup exposing
    ( Builder, AttrCaps, SlotCaps, slideGroup, disabled, nextPageLabel
    , previousPageLabel, threshold, vertical, nextIcon, prevIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-slide-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SlideGroup as SlideGroup`.

@docs Builder, AttrCaps, SlotCaps, slideGroup, disabled, nextPageLabel
@docs previousPageLabel, threshold, vertical, nextIcon, prevIcon, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.SlideGroup
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-slide-group>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | slideGroup : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , threshold : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-slide-group>`. -}
slideGroup : Builder AttrCaps SlotCaps msg kind
slideGroup =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SlideGroup.slideGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SlideGroup.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg kind
nextPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SlideGroup.nextPageLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> Builder { a
        | previousPageLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg kind
previousPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.SlideGroup.previousPageLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float
    -> Builder { a | threshold : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | threshold : M3e.Build.Internal.Used } s msg kind
threshold v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SlideGroup.threshold v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether content is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SlideGroup.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | nextIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | nextIcon : M3e.Build.Internal.Used } msg kind
nextIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "next-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | prevIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | prevIcon : M3e.Build.Internal.Used } msg kind
prevIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "prev-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slide-group>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { slideGroup : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)