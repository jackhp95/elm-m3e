module M3e.Build.Switch exposing
    ( Builder, AttrCaps, SlotCaps, switch, checked, disabled
    , icons, name, value, onBeforeinput, onInput, onChange, onClick
    , build
    )

{-|
The ⑤ Build shape for `<m3e-switch>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Switch as Switch`.

@docs Builder, AttrCaps, SlotCaps, switch, checked, disabled
@docs icons, name, value, onBeforeinput, onInput, onChange
@docs onClick, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Switch
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-switch>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | switch : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , icons : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-switch>`. -}
switch : Builder AttrCaps SlotCaps msg kind
switch =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Switch.switch
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg kind
checked v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.checked v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The icons to present. (default: `"none"`) -}
icons :
    M3e.Value.Value { both : M3e.Value.Supported
    , none : M3e.Value.Supported
    , selected : M3e.Value.Supported
    }
    -> Builder { a | icons : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | icons : M3e.Build.Internal.Used } s msg kind
icons v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.icons v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the switch. (default: `"on"`) -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the checked state changes. -}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.onBeforeinput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes. -}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes. -}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.onChange v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Switch.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-switch>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { switch : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)