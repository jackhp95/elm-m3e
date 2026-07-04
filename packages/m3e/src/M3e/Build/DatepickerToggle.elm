module M3e.Build.DatepickerToggle exposing ( Builder, AttrCaps, SlotCaps, datepickerToggle )

{-|
The ⑤ Build shape for `<m3e-datepicker-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DatepickerToggle as DatepickerToggle`.

@docs Builder, AttrCaps, SlotCaps, datepickerToggle
-}


import M3e.Element


{-| Opaque builder for `<m3e-datepicker-toggle>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { for : Maybe String
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-datepicker-toggle>`. -}
datepickerToggle : Builder AttrCaps SlotCaps msg
datepickerToggle =
    Builder { for = Nothing, default = Nothing, phantomMsg_ = Nothing }