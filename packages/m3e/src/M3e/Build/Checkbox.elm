module M3e.Build.Checkbox exposing
    ( Builder, AttrCaps, SlotCaps, checkbox, checked, disabled
    , indeterminate, name, required, value, onBeforeinput, onInput, onChange
    , onInvalid, onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Checkbox as Checkbox`.

@docs Builder, AttrCaps, SlotCaps, checkbox, checked, disabled
@docs indeterminate, name, required, value, onBeforeinput, onInput
@docs onChange, onInvalid, onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Checkbox
import M3e.Cem.Html.Checkbox
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-checkbox>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | checkbox : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , indeterminate : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onInvalid : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-checkbox>`. -}
checkbox : Builder AttrCaps SlotCaps msg kind
checkbox =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Checkbox.checkbox
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg kind
    -> Builder { checked : M3e.Build.Internal.Used } s msg kind
checked v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.checked v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool
    -> Builder { a | indeterminate : M3e.Build.Internal.Available } s msg kind
    -> Builder { indeterminate : M3e.Build.Internal.Used } s msg kind
indeterminate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.indeterminate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is required. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.required v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the checkbox. (default: `"on"`) -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Checkbox.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the checked state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Checkbox.onBeforeinput v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Checkbox.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Checkbox.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a form is submitted and the element fails constraint validation. -}
onInvalid :
    Json.Decode.Decoder msg
    -> Builder { a | onInvalid : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInvalid : M3e.Build.Internal.Used } s msg kind
onInvalid v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Checkbox.onInvalid v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Checkbox.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-checkbox>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { checkbox : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)