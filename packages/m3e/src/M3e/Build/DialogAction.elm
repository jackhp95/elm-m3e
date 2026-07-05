module M3e.Build.DialogAction exposing
    ( Builder, AttrCaps, SlotCaps, dialogAction, returnValue, build
    )

{-|
The ⑤ Build shape for `<m3e-dialog-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DialogAction as DialogAction`.

@docs Builder, AttrCaps, SlotCaps, dialogAction, returnValue, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.DialogAction
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-dialog-action>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | dialogAction : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { returnValue : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-dialog-action>`. -}
dialogAction : Builder AttrCaps SlotCaps msg kind
dialogAction =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.DialogAction.dialogAction
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String
    -> Builder { a | returnValue : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | returnValue : M3e.Build.Internal.Used } s msg kind
returnValue v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DialogAction.returnValue v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-dialog-action>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { dialogAction : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)