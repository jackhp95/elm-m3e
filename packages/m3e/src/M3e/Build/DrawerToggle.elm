module M3e.Build.DrawerToggle exposing
    ( Builder, AttrCaps, SlotCaps, drawerToggle, for, default
    )

{-|
The ⑤ Build shape for `<m3e-drawer-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerToggle as DrawerToggle`.

@docs Builder, AttrCaps, SlotCaps, drawerToggle, for, default
-}


import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-drawer-toggle>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { for : Maybe String
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-drawer-toggle>`. -}
drawerToggle : Builder AttrCaps SlotCaps msg
drawerToggle =
    Builder { for = Nothing, default = Nothing, phantomMsg_ = Nothing }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }