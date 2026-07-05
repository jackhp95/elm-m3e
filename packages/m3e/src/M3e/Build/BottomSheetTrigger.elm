module M3e.Build.BottomSheetTrigger exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheetTrigger, detent, secondary
    , for, build
    )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetTrigger as BottomSheetTrigger`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetTrigger, detent, secondary
@docs for, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.BottomSheetTrigger
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet-trigger>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | bottomSheetTrigger : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , secondary : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet-trigger>`. -}
bottomSheetTrigger : Builder AttrCaps SlotCaps msg kind
bottomSheetTrigger =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.BottomSheetTrigger.bottomSheetTrigger
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The zero‑based index of the detent the sheet should open to. -}
detent :
    Float
    -> Builder { a | detent : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | detent : M3e.Build.Internal.Used } s msg kind
detent v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BottomSheetTrigger.detent v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary :
    Bool
    -> Builder { a | secondary : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | secondary : M3e.Build.Internal.Used } s msg kind
secondary v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BottomSheetTrigger.secondary v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BottomSheetTrigger.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-bottom-sheet-trigger>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { bottomSheetTrigger : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)