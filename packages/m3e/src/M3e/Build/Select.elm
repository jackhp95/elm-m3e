module M3e.Build.Select exposing
    ( Builder, AttrCaps, SlotCaps, select, attr, disabled
    , hideSelectionIndicator, multi, name, panelClass, required, onChange, onToggle
    , onBeforeinput, onInput, arrow, value, build
    )

{-|
The ⑤ Build shape for `<m3e-select>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Select as Select`.

@docs Builder, AttrCaps, SlotCaps, select, attr, disabled
@docs hideSelectionIndicator, multi, name, panelClass, required, onChange
@docs onToggle, onBeforeinput, onInput, arrow, value, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Select
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-select>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | select : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , panelClass : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { arrow : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , unnamed : M3e.Build.Internal.NotFilled
    }


{-| Seed a `Builder` for `<m3e-select>`. -}
select : Builder AttrCaps SlotCaps msg kind
select =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Select.select
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the selection indicator for single select options. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Used
    } s msg kind
hideSelectionIndicator v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Select.hideSelectionIndicator v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple options can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.multi v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass :
    String
    -> Builder { a | panelClass : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | panelClass : M3e.Build.Internal.Used } s msg kind
panelClass v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.panelClass v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is required. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.required v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.onChange v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `toggle` events. -}
onToggle :
    (String -> msg)
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.onToggle v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.onBeforeinput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Select.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `arrow` slot. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | arrow : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | arrow : M3e.Build.Internal.Used } msg kind
arrow el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "arrow" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `value` slot. -}
value :
    M3e.Element.Element any msg
    -> Builder a { s | value : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | value : M3e.Build.Internal.Used } msg kind
value el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "value" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-select>` element from a `Builder`. -}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> M3e.Element.Element { select : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)