module M3e.Build.Step exposing
    ( Builder, AttrCaps, SlotCaps, step, completed, disabled
    , editable, for, optional, selected, invalid, onBeforeinput, onInput
    , onChange, onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-step>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Step as Step`.

@docs Builder, AttrCaps, SlotCaps, step, completed, disabled
@docs editable, for, optional, selected, invalid, onBeforeinput
@docs onInput, onChange, onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Step
import M3e.Cem.Step
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-step>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | step : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { completed : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , editable : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , optional : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , invalid : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , doneIcon : M3e.Build.Internal.Available
    , editIcon : M3e.Build.Internal.Available
    , errorIcon : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-step>` with the required fields. -}
step :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
step req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Step.step (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool
    -> Builder { a | completed : M3e.Build.Internal.Available } s msg kind
    -> Builder { completed : M3e.Build.Internal.Used } s msg kind
completed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.completed v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.Step.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable :
    Bool
    -> Builder { a | editable : M3e.Build.Internal.Available } s msg kind
    -> Builder { editable : M3e.Build.Internal.Used } s msg kind
editable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.editable v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step is optional. (default: `false`) -}
optional :
    Bool
    -> Builder { a | optional : M3e.Build.Internal.Available } s msg kind
    -> Builder { optional : M3e.Build.Internal.Used } s msg kind
optional v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.optional v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step has an error. (default: `false`) -}
invalid :
    Bool
    -> Builder { a | invalid : M3e.Build.Internal.Available } s msg kind
    -> Builder { invalid : M3e.Build.Internal.Used } s msg kind
invalid v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Step.invalid v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Step.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Step.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Step.onChange v_)
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Step.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-step>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { step : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)