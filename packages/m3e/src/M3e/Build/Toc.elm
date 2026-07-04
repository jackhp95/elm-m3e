module M3e.Build.Toc exposing ( Builder, AttrCaps, SlotCaps, toc )

{-|
The ⑤ Build shape for `<m3e-toc>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toc as Toc`.

@docs Builder, AttrCaps, SlotCaps, toc
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-toc>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { for : Maybe String
    , maxDepth : Maybe Float
    , default : Maybe (M3e.Element.Element any_ msg)
    , overline : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , title : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-toc>`. -}
toc : Builder AttrCaps SlotCaps msg
toc =
    Builder
        { for = Nothing
        , maxDepth = Nothing
        , default = Nothing
        , overline = Nothing
        , title = Nothing
        }