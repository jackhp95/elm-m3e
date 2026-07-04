module M3e.Build.Ripple exposing
    ( Builder, AttrCaps, SlotCaps, ripple, centered, disabled
    , for, radius, unbounded
    )

{-|
The ⑤ Build shape for `<m3e-ripple>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Ripple as Ripple`.

@docs Builder, AttrCaps, SlotCaps, ripple, centered, disabled
@docs for, radius, unbounded
-}


import M3e.Build.Internal


{-| Opaque builder for `<m3e-ripple>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , radius : M3e.Build.Internal.Available
    , unbounded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { centered : Maybe Bool
    , disabled : Maybe Bool
    , for : Maybe String
    , radius : Maybe Float
    , unbounded : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-ripple>`. -}
ripple : Builder AttrCaps SlotCaps msg
ripple =
    Builder
        { centered = Nothing
        , disabled = Nothing
        , for = Nothing
        , radius = Nothing
        , unbounded = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered :
    Bool
    -> Builder { a | centered : M3e.Build.Internal.Available } s msg
    -> Builder { a | centered : M3e.Build.Internal.Used } s msg
centered v_ (Builder f_) =
    Builder { f_ | centered = Just v_ }


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
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


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius :
    Float
    -> Builder { a | radius : M3e.Build.Internal.Available } s msg
    -> Builder { a | radius : M3e.Build.Internal.Used } s msg
radius v_ (Builder f_) =
    Builder { f_ | radius = Just v_ }


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool
    -> Builder { a | unbounded : M3e.Build.Internal.Available } s msg
    -> Builder { a | unbounded : M3e.Build.Internal.Used } s msg
unbounded v_ (Builder f_) =
    Builder { f_ | unbounded = Just v_ }