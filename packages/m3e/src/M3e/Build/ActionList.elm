module M3e.Build.ActionList exposing
    ( Builder, AttrCaps, SlotCaps, actionList, variant
    )

{-|
The ⑤ Build shape for `<m3e-action-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionList as ActionList`.

@docs Builder, AttrCaps, SlotCaps, actionList, variant
-}


import M3e.Build.Internal
import M3e.Cem.ActionList
import M3e.Cem.Attr
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-action-list>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | actionList : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-action-list>`. -}
actionList : Builder AttrCaps SlotCaps msg kind
actionList =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ActionList.actionList
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ActionList.variant v_))
             (M3e.Build.Internal.node_ b_)
        )