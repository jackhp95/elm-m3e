module M3e.Build.ActionElementBase exposing ( Builder, AttrCaps, SlotCaps, actionElementBase )

{-|
The ⑤ Build shape for `<ActionElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionElementBase as ActionElementBase`.

@docs Builder, AttrCaps, SlotCaps, actionElementBase
-}



{-| Opaque builder for `<ActionElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<ActionElementBase>`. -}
actionElementBase : Builder AttrCaps SlotCaps msg
actionElementBase =
    Builder { phantomMsg_ = Nothing }