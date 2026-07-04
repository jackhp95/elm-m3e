module M3e.Build.TabPanel exposing
    ( Builder, AttrCaps, SlotCaps, tabPanel, default
    )

{-|
The ⑤ Build shape for `<m3e-tab-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TabPanel as TabPanel`.

@docs Builder, AttrCaps, SlotCaps, tabPanel, default
-}


import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-tab-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { default : Maybe (M3e.Element.Element {} msg), phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<m3e-tab-panel>`. -}
tabPanel : Builder AttrCaps SlotCaps msg
tabPanel =
    Builder { default = Nothing, phantomMsg_ = Nothing }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }