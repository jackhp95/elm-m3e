module M3e.Build.NavMenu exposing
    ( Builder, AttrCaps, SlotCaps, navMenu, default
    )

{-|
The ⑤ Build shape for `<m3e-nav-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenu as NavMenu`.

@docs Builder, AttrCaps, SlotCaps, navMenu, default
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-menu>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { default :
        List (M3e.Element.Element { navMenuItem : M3e.Value.Supported
        , navMenuItemGroup : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-menu>`. -}
navMenu : Builder AttrCaps SlotCaps msg
navMenu =
    Builder { default = [], phantomMsg_ = Nothing }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported
    , navMenuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }