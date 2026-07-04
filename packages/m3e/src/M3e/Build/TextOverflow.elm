module M3e.Build.TextOverflow exposing
    ( Builder, AttrCaps, SlotCaps, textOverflow, default
    )

{-|
The ⑤ Build shape for `<m3e-text-overflow>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextOverflow as TextOverflow`.

@docs Builder, AttrCaps, SlotCaps, textOverflow, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-text-overflow>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-text-overflow>`. -}
textOverflow : Builder AttrCaps SlotCaps msg
textOverflow =
    Builder { default = Nothing, phantomMsg_ = Nothing }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }