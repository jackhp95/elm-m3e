module M3e.Build.Breadcrumb exposing ( Builder, AttrCaps, SlotCaps, breadcrumb )

{-|
The ⑤ Build shape for `<m3e-breadcrumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Breadcrumb as Breadcrumb`.

@docs Builder, AttrCaps, SlotCaps, breadcrumb
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { wrap : Maybe Bool
    , separator : Maybe (M3e.Element.Element any_ msg)
    , default :
        List (M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-breadcrumb>`. -}
breadcrumb : Builder AttrCaps SlotCaps msg
breadcrumb =
    Builder { wrap = Nothing, separator = Nothing, default = [] }