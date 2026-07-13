module M3e.Build.ButtonSegment exposing
    ( Builder, AttrCaps, SlotCaps, buttonSegment, attr, checked
    , disabled, value, onBeforeinput, onInput, onChange, onClick
    , child, icon, build
    )

{-| The Build form for `<m3e-button-segment>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ButtonSegment as ButtonSegment`.

@docs Builder, AttrCaps, SlotCaps, buttonSegment, attr, checked
@docs disabled, value, onBeforeinput, onInput, onChange, onClick
@docs child, icon, build

-}

import M3e.Build.Internal
import M3e.Html.ButtonSegment
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-button-segment>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | buttonSegment : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-button-segment>`.
-}
buttonSegment : Builder AttrCaps SlotCaps msg kind
buttonSegment =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ButtonSegment.buttonSegment
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


{-| Whether the element is checked. (default: `false`)
-}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg kind
checked v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.checked v_)
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
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.disabled v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the segment. (default: `"on"`)
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ButtonSegment.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the checked state changes.
-}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes.
-}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.onInput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the checked state changes.
-}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.onChange v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked.
-}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.ButtonSegment.onClick v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-button-segment>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { buttonSegment : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
