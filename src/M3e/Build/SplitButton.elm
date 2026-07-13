module M3e.Build.SplitButton exposing
    ( Builder, AttrCaps, SlotCaps, splitButton, attr, variant
    , size, build
    )

{-| The Build form for `<m3e-split-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitButton as SplitButton`.

@docs Builder, AttrCaps, SlotCaps, splitButton, attr, variant
@docs size, build

-}

import M3e.Build.Internal
import M3e.Html.SplitButton
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-split-button>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | splitButton : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-split-button>` with the required fields.
-}
splitButton :
    { leadingButton : Markup.Element.Element { button : M3e.Kind.Brand } msg
    , trailingButton :
        Markup.Element.Element { iconButton : M3e.Kind.Brand } msg
    }
    -> Builder AttrCaps SlotCaps msg kind
splitButton req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.SplitButton.splitButton
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode
                (Markup.Element.withSlot "leading-button" req_.leadingButton)
            , Markup.Element.toNode
                (Markup.Element.withSlot "trailing-button" req_.trailingButton)
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


{-| The appearance variant of the button. (default: `"filled"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        , tonal : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitButton.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"small"`)
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.SplitButton.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-split-button>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { splitButton : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
