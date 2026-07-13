module M3e.Build.Slider exposing
    ( Builder, AttrCaps, SlotCaps, slider, attr, disabled
    , discrete, labelled, max, min, step, size
    , onBeforeinput, onInput, onChange, build
    )

{-| The Build form for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider, attr, disabled
@docs discrete, labelled, max, min, step, size
@docs onBeforeinput, onInput, onChange, build

-}

import M3e.Build.Internal
import M3e.Html.Slider
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-slider>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | slider : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
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


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-slider>`.
-}
slider : Builder AttrCaps SlotCaps msg kind
slider =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Slider.slider
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show tick marks. (default: `false`)
-}
discrete :
    Bool
    -> Builder { a | discrete : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | discrete : M3e.Build.Internal.Used } s msg kind
discrete v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.discrete v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled :
    Bool
    -> Builder { a | labelled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | labelled : M3e.Build.Internal.Used } s msg kind
labelled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.labelled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The maximum allowable value. (default: `100`)
-}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.max v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The minimum allowable value. (default: `0`)
-}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | min : M3e.Build.Internal.Used } s msg kind
min v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.min v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The value at which the thumb will snap. (default: `1`)
-}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | step : M3e.Build.Internal.Used } s msg kind
step v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.step v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the slider. (default: `"extra-small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the value of a thumb changes.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Slider.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value of a thumb changes.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the value of a thumb changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Slider.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slider>` element from a `Builder`.
-}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> Markup.Element.Element { slider : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
