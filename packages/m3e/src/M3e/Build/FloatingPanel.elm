module M3e.Build.FloatingPanel exposing ( Builder, AttrCaps, SlotCaps, floatingPanel )

{-|
The ⑤ Build shape for `<m3e-floating-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FloatingPanel as FloatingPanel`.

@docs Builder, AttrCaps, SlotCaps, floatingPanel
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-floating-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { scrollStrategy :
        Maybe (M3e.Value.Value { hide : M3e.Value.Supported
        , reposition : M3e.Value.Supported
        })
    , fitAnchorWidth : Maybe Bool
    , anchorOffset : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-floating-panel>`. -}
floatingPanel : Builder AttrCaps SlotCaps msg
floatingPanel =
    Builder
        { scrollStrategy = Nothing
        , fitAnchorWidth = Nothing
        , anchorOffset = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , default = []
        }