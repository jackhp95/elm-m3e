module M3e.Build.SegmentedButton exposing
    ( Builder, AttrCaps, SlotCaps, segmentedButton, attr, disabled
    , hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-segmented-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SegmentedButton as SegmentedButton`.

@docs Builder, AttrCaps, SlotCaps, segmentedButton, attr, disabled
@docs hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.SegmentedButton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-segmented-button>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | segmentedButton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-segmented-button>`. -}
segmentedButton : Builder AttrCaps SlotCaps msg kind
segmentedButton =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SegmentedButton.segmentedButton
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SegmentedButton.disabled v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the selection indicator. (default: `false`) -}
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
                  (M3e.Cem.SegmentedButton.hideSelectionIndicator v_)
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SegmentedButton.multi v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SegmentedButton.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state of a segment changes. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SegmentedButton.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the checked state of a segment changes. -}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.SegmentedButton.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state of a segment changes. -}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SegmentedButton.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-segmented-button>` element from a `Builder`. -}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> M3e.Element.Element { segmentedButton : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)