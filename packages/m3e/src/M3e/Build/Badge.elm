module M3e.Build.Badge exposing ( Builder, AttrCaps, SlotCaps, badge )

{-|
The ⑤ Build shape for `<m3e-badge>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Badge as Badge`.

@docs Builder, AttrCaps, SlotCaps, badge
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-badge>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , position :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveAfter : M3e.Value.Supported
        , aboveBefore : M3e.Value.Supported
        , after : M3e.Value.Supported
        , before : M3e.Value.Supported
        , below : M3e.Value.Supported
        , belowAfter : M3e.Value.Supported
        , belowBefore : M3e.Value.Supported
        })
    , for : Maybe String
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-badge>`. -}
badge : Builder AttrCaps SlotCaps msg
badge =
    Builder
        { size = Nothing, position = Nothing, for = Nothing, default = Nothing }