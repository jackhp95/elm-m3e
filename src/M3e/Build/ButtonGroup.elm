module M3e.Build.ButtonGroup exposing
    ( Builder, AttrCaps, SlotCaps, buttonGroup, attr, multi
    , size, variant, build
    )

{-| The Build form for `<m3e-button-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ButtonGroup as ButtonGroup`.

@docs Builder, AttrCaps, SlotCaps, buttonGroup, attr, multi
@docs size, variant, build

-}

import M3e.Build.Internal
import M3e.Html.ButtonGroup
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-button-group>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | buttonGroup : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-button-group>`.
-}
buttonGroup : Builder AttrCaps SlotCaps msg kind
buttonGroup =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ButtonGroup.buttonGroup
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


{-| Whether multiple toggle buttons can be selected. (default: `false`)
-}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ButtonGroup.multi v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the group. (default: `"small"`)
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.ButtonGroup.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the group. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { connected : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ButtonGroup.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-button-group>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { buttonGroup : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
