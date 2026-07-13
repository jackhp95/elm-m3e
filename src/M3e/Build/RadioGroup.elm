module M3e.Build.RadioGroup exposing
    ( Builder, AttrCaps, SlotCaps, radioGroup, attr, ariaInvalid
    , disabled, name, required, onBeforeinput, onInput, onChange
    , build
    )

{-| The Build form for `<m3e-radio-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RadioGroup as RadioGroup`.

@docs Builder, AttrCaps, SlotCaps, radioGroup, attr, ariaInvalid
@docs disabled, name, required, onBeforeinput, onInput, onChange
@docs build

-}

import M3e.Build.Internal
import M3e.Html.RadioGroup
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-radio-group>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | radioGroup : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { ariaInvalid : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-radio-group>`.
-}
radioGroup : Builder AttrCaps SlotCaps msg kind
radioGroup =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.RadioGroup.radioGroup
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


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid :
    String
    -> Builder { a | ariaInvalid : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | ariaInvalid : M3e.Build.Internal.Used } s msg kind
ariaInvalid v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RadioGroup.ariaInvalid v_)
            )
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.RadioGroup.disabled v_))
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.RadioGroup.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is required. (default: `false`)
-}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.RadioGroup.required v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the checked state of a radio button changes.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RadioGroup.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state of a radio button changes.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.RadioGroup.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state of a radio button changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.RadioGroup.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-radio-group>` element from a `Builder`.
-}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> Markup.Element.Element { radioGroup : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
