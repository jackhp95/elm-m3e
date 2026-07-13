module M3e.Build.FabMenu exposing
    ( Builder, AttrCaps, SlotCaps, fabMenu, attr, variant
    , onBeforetoggle, onToggle, build
    )

{-| The Build form for `<m3e-fab-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenu as FabMenu`.

@docs Builder, AttrCaps, SlotCaps, fabMenu, attr, variant
@docs onBeforetoggle, onToggle, build

-}

import M3e.Build.Internal
import M3e.Html.FabMenu
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-fab-menu>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | fabMenu : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-fab-menu>`.
-}
fabMenu : Builder AttrCaps SlotCaps msg kind
fabMenu =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.FabMenu.fabMenu
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


{-| The appearance variant of the menu. (default: `"primary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FabMenu.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes.
-}
onBeforetoggle :
    msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FabMenu.onBeforetoggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed.
-}
onToggle :
    msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FabMenu.onToggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-fab-menu>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { fabMenu : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
