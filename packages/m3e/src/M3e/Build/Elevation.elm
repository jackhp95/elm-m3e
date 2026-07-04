module M3e.Build.Elevation exposing
    ( Builder, AttrCaps, SlotCaps, elevation, disabled, for
    , level
    )

{-|
The ⑤ Build shape for `<m3e-elevation>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Elevation as Elevation`.

@docs Builder, AttrCaps, SlotCaps, elevation, disabled, for
@docs level
-}


import M3e.Build.Internal


{-| Opaque builder for `<m3e-elevation>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , for : Maybe String
    , level : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-elevation>`. -}
elevation : Builder AttrCaps SlotCaps msg
elevation =
    Builder
        { disabled = Nothing
        , for = Nothing
        , level = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The level at which to visually depict elevation. (default: `null`) -}
level :
    String
    -> Builder { a | level : M3e.Build.Internal.Available } s msg
    -> Builder { a | level : M3e.Build.Internal.Used } s msg
level v_ (Builder f_) =
    Builder { f_ | level = Just v_ }