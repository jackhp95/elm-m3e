module M3e.Build.NavMenu exposing
    ( Builder, AttrCaps, SlotCaps, navMenu, build
    )

{-|
The ⑤ Build shape for `<m3e-nav-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenu as NavMenu`.

@docs Builder, AttrCaps, SlotCaps, navMenu, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.NavMenu
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-menu>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navMenu : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-nav-menu>`. -}
navMenu : Builder AttrCaps SlotCaps msg kind
navMenu =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavMenu.navMenu
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-nav-menu>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { navMenu : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)