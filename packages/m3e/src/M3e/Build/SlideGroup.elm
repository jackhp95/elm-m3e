module M3e.Build.SlideGroup exposing ( Builder, AttrCaps, SlotCaps, slideGroup )

{-|
The ⑤ Build shape for `<m3e-slide-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SlideGroup as SlideGroup`.

@docs Builder, AttrCaps, SlotCaps, slideGroup
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-slide-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { disabled : Maybe Bool
    , nextPageLabel : Maybe String
    , previousPageLabel : Maybe String
    , threshold : Maybe Float
    , vertical : Maybe Bool
    , nextIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , prevIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-slide-group>`. -}
slideGroup : Builder AttrCaps SlotCaps msg
slideGroup =
    Builder
        { disabled = Nothing
        , nextPageLabel = Nothing
        , previousPageLabel = Nothing
        , threshold = Nothing
        , vertical = Nothing
        , nextIcon = Nothing
        , prevIcon = Nothing
        , default = []
        }