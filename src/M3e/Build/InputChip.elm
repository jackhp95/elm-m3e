module M3e.Build.InputChip exposing
    ( Builder, AttrCaps, SlotCaps, inputChip, attr, disabled
    , disabledInteractive, removable, removeLabel, value, variant, onRemove
    , onClick, avatar, icon, removeIcon, build
    )

{-| The Build form for `<m3e-input-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChip as InputChip`.

@docs Builder, AttrCaps, SlotCaps, inputChip, attr, disabled
@docs disabledInteractive, removable, removeLabel, value, variant, onRemove
@docs onClick, avatar, icon, removeIcon, build

-}

import M3e.Build.Internal
import M3e.Html.InputChip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-input-chip>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | inputChip : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , removable : M3e.Build.Internal.Available
    , removeLabel : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onRemove : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { avatar : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , removeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-input-chip>` with the required fields.
-}
inputChip :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
inputChip req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.InputChip.inputChip
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode req_.content ]
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Builder
            { a
                | disabledInteractive : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.InputChip.disabledInteractive v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the chip is removable. (default: `false`)
-}
removable :
    Bool
    -> Builder { a | removable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | removable : M3e.Build.Internal.Used } s msg kind
removable v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.removable v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel :
    String
    -> Builder { a | removeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | removeLabel : M3e.Build.Internal.Used } s msg kind
removeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.InputChip.removeLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the chip.
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.
-}
onRemove :
    msg
    -> Builder { a | onRemove : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onRemove : M3e.Build.Internal.Used } s msg kind
onRemove v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.onRemove v_))
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.InputChip.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `avatar` slot.
-}
avatar :
    Markup.Element.Element { avatar : M3e.Kind.Brand } msg
    -> Builder a { s | avatar : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | avatar : M3e.Build.Internal.Used } msg kind
avatar el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "avatar" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `remove-icon` slot.
-}
removeIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | removeIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | removeIcon : M3e.Build.Internal.Used } msg kind
removeIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "remove-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-input-chip>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { inputChip : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
