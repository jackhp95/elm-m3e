module M3e.Build.ListOption exposing
    ( Builder, AttrCaps, SlotCaps, listOption, disabled, selected
    , value, onBeforeinput, onInput, onChange, onClick, child, leading
    , overline, supportingText, trailing, build
    )

{-|
The ⑤ Build shape for `<m3e-list-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListOption as ListOption`.

@docs Builder, AttrCaps, SlotCaps, listOption, disabled, selected
@docs value, onBeforeinput, onInput, onChange, onClick, child
@docs leading, overline, supportingText, trailing, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ListOption
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list-option>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | listOption : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
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


{-| Seed a `Builder` for `<m3e-list-option>`. -}
listOption : Builder AttrCaps SlotCaps msg kind
listOption =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ListOption.listOption
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the option. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.onChange v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ListOption.onClick v_))
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


{-| Build the `<m3e-list-option>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { listOption : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)