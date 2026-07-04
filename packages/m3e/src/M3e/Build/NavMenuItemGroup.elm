module M3e.Build.NavMenuItemGroup exposing
    ( Builder, AttrCaps, SlotCaps, navMenuItemGroup, label
    )

{-|
The ⑤ Build shape for `<m3e-nav-menu-item-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItemGroup as NavMenuItemGroup`.

@docs Builder, AttrCaps, SlotCaps, navMenuItemGroup, label
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-menu-item-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available }


type alias Fields msg =
    { label :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , heading : M3e.Value.Supported
        } msg)
    , default :
        List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-menu-item-group>`. -}
navMenuItemGroup : Builder AttrCaps SlotCaps msg
navMenuItemGroup =
    Builder { label = Nothing, default = [], phantomMsg_ = Nothing }


{-| Set the `label` slot. Consumes the `label` slot capability. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported
    , heading : M3e.Value.Supported
    } msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg
    -> Builder a { s | label : M3e.Build.Internal.Used } msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }