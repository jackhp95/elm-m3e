module M3e.Build.FocusRing exposing ( Builder, AttrCaps, SlotCaps, focusRing )

{-|
The ⑤ Build shape for `<m3e-focus-ring>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusRing as FocusRing`.

@docs Builder, AttrCaps, SlotCaps, focusRing
-}



{-| Opaque builder for `<m3e-focus-ring>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , inward : Maybe Bool
    , for : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-focus-ring>`. -}
focusRing : Builder AttrCaps SlotCaps msg
focusRing =
    Builder
        { disabled = Nothing
        , inward = Nothing
        , for = Nothing
        , phantomMsg_ = Nothing
        }