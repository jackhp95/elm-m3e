module M3e.Build.Chip exposing ( Builder, AttrCaps, SlotCaps, chip )

{-|
The ⑤ Build shape for `<m3e-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Chip as Chip`.

@docs Builder, AttrCaps, SlotCaps, chip
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-chip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , trailingIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-chip>` with the required fields. -}
chip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
chip req_ =
    Builder
        { content = req_.content
        , value = Nothing
        , variant = Nothing
        , icon = Nothing
        , trailingIcon = Nothing
        }