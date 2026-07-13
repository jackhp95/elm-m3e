module M3e.Build.SplitPane exposing
    ( Builder, AttrCaps, SlotCaps, splitPane, attr, detents
    , label, max, min, orientation, overshootLimit, step
    , value, wrapDetents, name, disabled, onChange, onBeforeinput
    , onInput, build
    )

{-| The Build form for `<m3e-split-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitPane as SplitPane`.

@docs Builder, AttrCaps, SlotCaps, splitPane, attr, detents
@docs label, max, min, orientation, overshootLimit, step
@docs value, wrapDetents, name, disabled, onChange, onBeforeinput
@docs onInput, build

-}

import M3e.Build.Internal
import M3e.Html.SplitPane
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-split-pane>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | splitPane : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { detents : M3e.Build.Internal.Available
    , label : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , valueFloat : M3e.Build.Internal.Available
    , wrapDetents : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-split-pane>` with the required fields.
-}
splitPane :
    { start : Markup.Element.Element any msg
    , end : Markup.Element.Element any msg
    }
    -> Builder AttrCaps SlotCaps msg kind
splitPane req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.SplitPane.splitPane
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode
                (Markup.Element.withSlot "start" req_.start)
            , Markup.Element.toNode (Markup.Element.withSlot "end" req_.end)
            ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
detents :
    String
    -> Builder { a | detents : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | detents : M3e.Build.Internal.Used } s msg kind
detents v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.detents v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label :
    String
    -> Builder { a | label : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | label : M3e.Build.Internal.Used } s msg kind
label v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.label v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.max v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | min : M3e.Build.Internal.Used } s msg kind
min v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.min v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The orientation of the split. (default: `"horizontal"`)
-}
orientation :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg kind
orientation v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SplitPane.orientation v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit :
    Float
    -> Builder { a | overshootLimit : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | overshootLimit : M3e.Build.Internal.Used } s msg kind
overshootLimit v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SplitPane.overshootLimit v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | step : M3e.Build.Internal.Used } s msg kind
step v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.step v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
value :
    Float
    -> Builder { a | valueFloat : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | valueFloat : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents :
    Bool
    -> Builder { a | wrapDetents : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | wrapDetents : M3e.Build.Internal.Used } s msg kind
wrapDetents v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SplitPane.wrapDetents v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the user finishes adjusting the drag handle.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched continuously before the user adjusts the drag handle.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SplitPane.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched continuously while the user adjusts the drag handle.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitPane.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-split-pane>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { splitPane : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
