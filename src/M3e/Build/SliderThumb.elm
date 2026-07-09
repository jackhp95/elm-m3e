module M3e.Build.SliderThumb exposing
    ( Builder, AttrCaps, SlotCaps, sliderThumb, attr, disabled
    , name, value, onValueChange, onBeforeinput, onInput, onChange, onClick
    , build
    )

{-|
The ⑤ Build shape for `<m3e-slider-thumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SliderThumb as SliderThumb`.

@docs Builder, AttrCaps, SlotCaps, sliderThumb, attr, disabled
@docs name, value, onValueChange, onBeforeinput, onInput, onChange
@docs onClick, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.SliderThumb
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-slider-thumb>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | sliderThumb : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , valueFloat : M3e.Build.Internal.Available
    , onValueChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-slider-thumb>`. -}
sliderThumb : Builder AttrCaps SlotCaps msg kind
sliderThumb =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SliderThumb.sliderThumb
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.disabled v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The value of the thumb. (default: `null`) -}
value :
    Float
    -> Builder { a | valueFloat : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | valueFloat : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `value-change` events. -}
onValueChange :
    msg
    -> Builder { a | onValueChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onValueChange : M3e.Build.Internal.Used } s msg kind
onValueChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.SliderThumb.onValueChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the value changes. -}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.SliderThumb.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value changes. -}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value changes. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.onChange v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SliderThumb.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slider-thumb>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { sliderThumb : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)