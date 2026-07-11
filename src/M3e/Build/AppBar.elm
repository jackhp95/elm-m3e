module M3e.Build.AppBar exposing
    ( Builder, AttrCaps, SlotCaps, appBar, attr, centered
    , for, size, leading, title, subtitle, leadingIcon
    , trailingIcon, build
    )

{-| The Build form for `<m3e-app-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AppBar as AppBar`.

@docs Builder, AttrCaps, SlotCaps, appBar, attr, centered
@docs for, size, leading, title, subtitle, leadingIcon
@docs trailingIcon, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.AppBar
import M3e.Html.Attr.Internal
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-app-bar>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | appBar : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { leading : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    , subtitle : M3e.Build.Internal.Available
    , leadingIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-app-bar>`.
-}
appBar : Builder AttrCaps SlotCaps msg kind
appBar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.AppBar.appBar
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered :
    Bool
    -> Builder { a | centered : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | centered : M3e.Build.Internal.Used } s msg kind
centered v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.AppBar.centered v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.AppBar.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the bar. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.AppBar.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading` slot.
-}
leading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        , button : M3e.Token.Supported
        }
        msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg kind
leading el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "leading" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `title` slot.
-}
title :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> Builder a { s | title : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | title : M3e.Build.Internal.Used } msg kind
title el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "title" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `subtitle` slot.
-}
subtitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> Builder a { s | subtitle : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | subtitle : M3e.Build.Internal.Used } msg kind
subtitle el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "subtitle" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading-icon` slot.
-}
leadingIcon :
    M3e.Element.Element any msg
    -> Builder a { s | leadingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leadingIcon : M3e.Build.Internal.Used } msg kind
leadingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "leading-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    M3e.Element.Element any msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "trailing-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-app-bar>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { appBar : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
