module M3e.Build.BottomSheetAction exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheetAction, build
    )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetAction as BottomSheetAction`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetAction, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.BottomSheetAction
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet-action>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | bottomSheetAction : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet-action>`. -}
bottomSheetAction : Builder AttrCaps SlotCaps msg kind
bottomSheetAction =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.BottomSheetAction.bottomSheetAction
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-bottom-sheet-action>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { bottomSheetAction : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)