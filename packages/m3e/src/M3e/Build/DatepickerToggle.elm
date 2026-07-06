module M3e.Build.DatepickerToggle exposing
    ( Builder, AttrCaps, SlotCaps, datepickerToggle, for, child
    , build
    )

{-|
The ⑤ Build shape for `<m3e-datepicker-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DatepickerToggle as DatepickerToggle`.

@docs Builder, AttrCaps, SlotCaps, datepickerToggle, for, child
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.DatepickerToggle
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-datepicker-toggle>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | datepickerToggle : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-datepicker-toggle>`. -}
datepickerToggle : Builder AttrCaps SlotCaps msg kind
datepickerToggle =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.DatepickerToggle.datepickerToggle
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DatepickerToggle.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-datepicker-toggle>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { datepickerToggle : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)