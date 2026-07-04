module M3e.Build.BottomSheetTrigger exposing ( Builder, AttrCaps, SlotCaps, bottomSheetTrigger )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetTrigger as BottomSheetTrigger`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetTrigger
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-bottom-sheet-trigger>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { detent : Maybe Float
    , secondary : Maybe Bool
    , for : Maybe String
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-bottom-sheet-trigger>`. -}
bottomSheetTrigger : Builder AttrCaps SlotCaps msg
bottomSheetTrigger =
    Builder
        { detent = Nothing
        , secondary = Nothing
        , for = Nothing
        , default = Nothing
        }