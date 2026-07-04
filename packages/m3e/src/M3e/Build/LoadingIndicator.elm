module M3e.Build.LoadingIndicator exposing ( Builder, AttrCaps, SlotCaps, loadingIndicator )

{-|
The ⑤ Build shape for `<m3e-loading-indicator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.LoadingIndicator as LoadingIndicator`.

@docs Builder, AttrCaps, SlotCaps, loadingIndicator
-}


import M3e.Value


{-| Opaque builder for `<m3e-loading-indicator>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { contained : M3e.Value.Supported
        , uncontained : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-loading-indicator>`. -}
loadingIndicator : Builder AttrCaps SlotCaps msg
loadingIndicator =
    Builder { variant = Nothing, phantomMsg_ = Nothing }