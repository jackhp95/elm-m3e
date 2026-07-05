module M3e.Build.Slider exposing
    ( Builder, AttrCaps, SlotCaps, slider, disabled, discrete
    , labelled, max, min, step, size, onBeforeinput, onInput
    , onChange, build
    )

{-|
The ⑤ Build shape for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider, disabled, discrete
@docs labelled, max, min, step, size, onBeforeinput
@docs onInput, onChange, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Slider
import M3e.Cem.Slider
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-slider>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | slider : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , discrete : M3e.Build.Internal.Available
    , labelled : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-slider>`. -}
slider : Builder AttrCaps SlotCaps msg kind
slider =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Slider.slider
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show tick marks. (default: `false`) -}
discrete :
    Bool
    -> Builder { a | discrete : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | discrete : M3e.Build.Internal.Used } s msg kind
discrete v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.discrete v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show value labels when activated. (default: `false`) -}
labelled :
    Bool
    -> Builder { a | labelled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | labelled : M3e.Build.Internal.Used } s msg kind
labelled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.labelled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum allowable value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.max v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The minimum allowable value. (default: `0`) -}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | min : M3e.Build.Internal.Used } s msg kind
min v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.min v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The value at which the thumb will snap. (default: `1`) -}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | step : M3e.Build.Internal.Used } s msg kind
step v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.step v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the slider. (default: `"extra-small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slider.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the value of a thumb changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Slider.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value of a thumb changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Slider.onInput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value of a thumb changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Slider.onChange
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slider>` element from a `Builder`. -}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> M3e.Element.Element { slider : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)