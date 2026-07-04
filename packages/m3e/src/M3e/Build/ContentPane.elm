module M3e.Build.ContentPane exposing
    ( Builder, AttrCaps, SlotCaps, contentPane, default
    )

{-|
The ⑤ Build shape for `<m3e-content-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ContentPane as ContentPane`.

@docs Builder, AttrCaps, SlotCaps, contentPane, default
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


type alias Fields msg =
    { default : List (M3e.Element.Element {} msg), phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<m3e-content-pane>`. -}
contentPane : Builder AttrCaps SlotCaps msg
contentPane =
    Builder { default = [], phantomMsg_ = Nothing }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }