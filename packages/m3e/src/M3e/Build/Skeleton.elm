module M3e.Build.Skeleton exposing ( Builder, AttrCaps, SlotCaps, skeleton )

{-|
The ⑤ Build shape for `<m3e-skeleton>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Skeleton as Skeleton`.

@docs Builder, AttrCaps, SlotCaps, skeleton
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-skeleton>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { animation :
        Maybe (M3e.Value.Value { none : M3e.Value.Supported
        , pulse : M3e.Value.Supported
        , wave : M3e.Value.Supported
        })
    , shape :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , circular : M3e.Value.Supported
        , rounded : M3e.Value.Supported
        , square : M3e.Value.Supported
        })
    , loaded : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-skeleton>`. -}
skeleton : Builder AttrCaps SlotCaps msg
skeleton =
    Builder
        { animation = Nothing
        , shape = Nothing
        , loaded = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }