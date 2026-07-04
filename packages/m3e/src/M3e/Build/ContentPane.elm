module M3e.Build.ContentPane exposing ( Builder, AttrCaps, SlotCaps, contentPane )

{-|
The ⑤ Build shape for `<m3e-content-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ContentPane as ContentPane`.

@docs Builder, AttrCaps, SlotCaps, contentPane
-}


import M3e.Element


{-| Opaque builder for `<m3e-content-pane>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { default : List (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-content-pane>`. -}
contentPane : Builder AttrCaps SlotCaps msg
contentPane =
    Builder { default = [] }