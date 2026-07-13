module M3e.Build.FocusRing exposing
    ( Builder, AttrCaps, SlotCaps, focusRing, attr, disabled
    , inward, for, build
    )

{-| The Build form for `<m3e-focus-ring>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusRing as FocusRing`.

@docs Builder, AttrCaps, SlotCaps, focusRing, attr, disabled
@docs inward, for, build

-}

import M3e.Build.Internal
import M3e.Html.FocusRing
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-focus-ring>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | focusRing : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , inward : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-focus-ring>`.
-}
focusRing : Builder AttrCaps SlotCaps msg kind
focusRing =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.FocusRing.focusRing
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


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FocusRing.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward :
    Bool
    -> Builder { a | inward : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | inward : M3e.Build.Internal.Used } s msg kind
inward v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FocusRing.inward v_))
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.FocusRing.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-focus-ring>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { focusRing : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
