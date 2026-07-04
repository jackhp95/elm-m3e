module M3e.Build.TooltipElementBase exposing ( Builder, AttrCaps, SlotCaps, tooltipElementBase )

{-|
The ⑤ Build shape for `<TooltipElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TooltipElementBase as TooltipElementBase`.

@docs Builder, AttrCaps, SlotCaps, tooltipElementBase
-}


import M3e.Value


{-| Opaque builder for `<TooltipElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { disabled : Maybe Bool
    , showDelay : Maybe Float
    , hideDelay : Maybe Float
    , touchGestures :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , off : M3e.Value.Supported
        , on : M3e.Value.Supported
        })
    , for : Maybe String
    }


{-| Seed a `Builder` for `<TooltipElementBase>`. -}
tooltipElementBase : Builder AttrCaps SlotCaps msg
tooltipElementBase =
    Builder
        { disabled = Nothing
        , showDelay = Nothing
        , hideDelay = Nothing
        , touchGestures = Nothing
        , for = Nothing
        }