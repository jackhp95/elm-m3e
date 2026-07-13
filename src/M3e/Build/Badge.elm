module M3e.Build.Badge exposing
    ( Builder, AttrCaps, SlotCaps, badge, attr, size
    , position, for, child, build
    )

{-| The Build form for `<m3e-badge>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Badge as Badge`.

@docs Builder, AttrCaps, SlotCaps, badge, attr, size
@docs position, for, child, build

-}

import M3e.Build.Internal
import M3e.Html.Badge
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-badge>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | badge : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { size : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-badge>`.
-}
badge : Builder AttrCaps SlotCaps msg kind
badge =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Badge.badge
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


{-| The size of the badge. (default: `"medium"`)
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Badge.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The position of the badge, when attached to another element. (default: `"above-after"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveAfter : M3e.Token.Supported
        , aboveBefore : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        , belowAfter : M3e.Token.Supported
        , belowBefore : M3e.Token.Supported
        }
    -> Builder { a | position : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | position : M3e.Build.Internal.Used } s msg kind
position v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Badge.position v_))
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Badge.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-badge>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { badge : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
