module M3e.Build.NavMenu exposing (Builder, AttrCaps, SlotCaps, navMenu, attr, build)

{-| The Build form for `<m3e-nav-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenu as NavMenu`.

@docs Builder, AttrCaps, SlotCaps, navMenu, attr, build

-}

import M3e.Build.Internal
import M3e.Html.NavMenu
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-nav-menu>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | navMenu : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-nav-menu>`.
-}
navMenu : Builder AttrCaps SlotCaps msg kind
navMenu =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.NavMenu.navMenu
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


{-| Build the `<m3e-nav-menu>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { navMenu : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
