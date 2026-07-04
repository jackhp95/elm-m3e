module M3e.Build.NavBar exposing ( Builder, AttrCaps, SlotCaps, navBar )

{-|
The ⑤ Build shape for `<m3e-nav-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavBar as NavBar`.

@docs Builder, AttrCaps, SlotCaps, navBar
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { mode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , compact : M3e.Value.Supported
        , expanded : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element { navItem : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-nav-bar>`. -}
navBar : Builder AttrCaps SlotCaps msg
navBar =
    Builder
        { mode = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , default = []
        }