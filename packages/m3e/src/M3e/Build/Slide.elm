module M3e.Build.Slide exposing
    ( Builder, AttrCaps, SlotCaps, slide, selectedIndex
    )

{-|
The ⑤ Build shape for `<m3e-slide>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slide as Slide`.

@docs Builder, AttrCaps, SlotCaps, slide, selectedIndex
-}


import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-slide>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { selectedIndex : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { selectedIndex : Maybe Float
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-slide>`. -}
slide : Builder AttrCaps SlotCaps msg
slide =
    Builder { selectedIndex = Nothing, default = [], phantomMsg_ = Nothing }


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float
    -> Builder { a | selectedIndex : M3e.Build.Internal.Available } s msg
    -> Builder { a | selectedIndex : M3e.Build.Internal.Used } s msg
selectedIndex v_ (Builder f_) =
    Builder { f_ | selectedIndex = Just v_ }