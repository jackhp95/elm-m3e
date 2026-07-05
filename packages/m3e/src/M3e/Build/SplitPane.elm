module M3e.Build.SplitPane exposing
    ( Builder, AttrCaps, SlotCaps, splitPane, label, max
    , min, orientation, overshootLimit, step, value, wrapDetents, name
    , disabled, onChange, onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-split-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitPane as SplitPane`.

@docs Builder, AttrCaps, SlotCaps, splitPane, label, max
@docs min, orientation, overshootLimit, step, value, wrapDetents
@docs name, disabled, onChange, onBeforeinput, onInput, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SplitPane
import M3e.Cem.SplitPane
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-split-pane>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | splitPane : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { label : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , wrapDetents : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { start : M3e.Build.Internal.Available, end : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-split-pane>`. -}
splitPane : Builder AttrCaps SlotCaps msg kind
splitPane =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SplitPane.splitPane
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label :
    String
    -> Builder { a | label : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | label : M3e.Build.Internal.Used } s msg kind
label v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.label v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.max v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | min : M3e.Build.Internal.Used } s msg kind
min v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.min v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The orientation of the split. (default: `"horizontal"`) -}
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
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.orientation v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float
    -> Builder { a | overshootLimit : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | overshootLimit : M3e.Build.Internal.Used } s msg kind
overshootLimit v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.overshootLimit v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | step : M3e.Build.Internal.Used } s msg kind
step v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.step v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value :
    Float
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool
    -> Builder { a | wrapDetents : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | wrapDetents : M3e.Build.Internal.Used } s msg kind
wrapDetents v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.wrapDetents v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.name v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.SplitPane.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the user finishes adjusting the drag handle. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.SplitPane.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched continuously before the user adjusts the drag handle. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.SplitPane.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched continuously while the user adjusts the drag handle. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.SplitPane.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-split-pane>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { splitPane : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)