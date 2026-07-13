module M3e.Build.Chip exposing
    ( Builder, AttrCaps, SlotCaps, chip, attr, value
    , variant, icon, trailingIcon, build
    )

{-| The Build form for `<m3e-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Chip as Chip`.

@docs Builder, AttrCaps, SlotCaps, chip, attr, value
@docs variant, icon, trailingIcon, build

-}

import M3e.Build.Internal
import M3e.Html.Chip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-chip>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | chip : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-chip>` with the required fields.
-}
chip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
chip req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Chip.chip
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


{-| A string representing the value of the chip.
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Chip.value v_))
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.Chip.variant v_))
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


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "trailing-icon" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-chip>` element from a `Builder`.
-}
build : Builder a s msg kind -> Markup.Element.Element { chip : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
