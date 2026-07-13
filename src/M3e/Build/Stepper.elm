module M3e.Build.Stepper exposing
    ( Builder, AttrCaps, SlotCaps, stepper, attr, headerPosition
    , labelPosition, linear, orientation, onChange, onBeforeinput, onInput
    , build
    )

{-| The Build form for `<m3e-stepper>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Stepper as Stepper`.

@docs Builder, AttrCaps, SlotCaps, stepper, attr, headerPosition
@docs labelPosition, linear, orientation, onChange, onBeforeinput, onInput
@docs build

-}

import M3e.Build.Internal
import M3e.Html.Stepper
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-stepper>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | stepper : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { headerPosition : M3e.Build.Internal.Available
    , labelPosition : M3e.Build.Internal.Available
    , linear : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-stepper>`.
-}
stepper : Builder AttrCaps SlotCaps msg kind
stepper =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Stepper.stepper
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
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


{-| The position of the step header, when oriented horizontally. (default: `"above"`)
-}
headerPosition :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg kind
headerPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Stepper.headerPosition v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition :
    M3e.Token.Value { below : M3e.Token.Supported, end : M3e.Token.Supported }
    -> Builder { a | labelPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | labelPosition : M3e.Build.Internal.Used } s msg kind
labelPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Stepper.labelPosition v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear :
    Bool
    -> Builder { a | linear : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | linear : M3e.Build.Internal.Used } s msg kind
linear v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Stepper.linear v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The orientation of the stepper. (default: `"horizontal"`)
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.Stepper.orientation v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected step changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Stepper.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a step changes.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Stepper.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a step changes.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Stepper.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-stepper>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { stepper : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
