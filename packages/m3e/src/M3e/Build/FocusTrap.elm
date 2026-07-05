module M3e.Build.FocusTrap exposing
    ( Builder, AttrCaps, SlotCaps, focusTrap, disabled
    )

{-|
The ⑤ Build shape for `<m3e-focus-trap>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusTrap as FocusTrap`.

@docs Builder, AttrCaps, SlotCaps, focusTrap, disabled
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FocusTrap
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-focus-trap>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | focusTrap : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-focus-trap>`. -}
focusTrap : Builder AttrCaps SlotCaps msg kind
focusTrap =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FocusTrap.focusTrap
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Disables the focus trap. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FocusTrap.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )