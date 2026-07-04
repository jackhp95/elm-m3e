module M3e.Build.Avatar exposing
    ( Builder, AttrCaps, SlotCaps, avatar, default
    )

{-|
The ⑤ Build shape for `<m3e-avatar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Avatar as Avatar`.

@docs Builder, AttrCaps, SlotCaps, avatar, default
-}


import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-avatar>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-avatar>`. -}
avatar : Builder AttrCaps SlotCaps msg
avatar =
    Builder { default = Nothing, phantomMsg_ = Nothing }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }