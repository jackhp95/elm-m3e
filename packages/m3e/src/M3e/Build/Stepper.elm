module M3e.Build.Stepper exposing
    ( Builder, AttrCaps, SlotCaps, stepper, headerPosition, labelPosition
    , linear, orientation, onChange, onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-stepper>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Stepper as Stepper`.

@docs Builder, AttrCaps, SlotCaps, stepper, headerPosition, labelPosition
@docs linear, orientation, onChange, onBeforeinput, onInput, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Stepper
import M3e.Cem.Stepper
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-stepper>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | stepper : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { headerPosition : M3e.Build.Internal.Available
    , labelPosition : M3e.Build.Internal.Available
    , linear : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-stepper>`. -}
stepper : Builder AttrCaps SlotCaps msg kind
stepper =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Stepper.stepper
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The position of the step header, when oriented horizontally. (default: `"above"`) -}
headerPosition :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg kind
headerPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Stepper.headerPosition v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> Builder { a | labelPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | labelPosition : M3e.Build.Internal.Used } s msg kind
labelPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Stepper.labelPosition v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear :
    Bool
    -> Builder { a | linear : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | linear : M3e.Build.Internal.Used } s msg kind
linear v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Stepper.linear v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg kind
orientation v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Stepper.orientation v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected step changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Stepper.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a step changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Stepper.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a step changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Stepper.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-stepper>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { stepper : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)