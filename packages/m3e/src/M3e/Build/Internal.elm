module M3e.Build.Internal exposing ( Available, Used, NotFilled, Filled )

{-|
Marker types for `M3e.Build.*` capability-row phantoms.

The `Available → Used` transition guards optional-singular setters: applying a
setter twice is a compile-time TYPE MISMATCH. The `NotFilled → Filled` ratchet
guards required-multi slots: `build` refuses to type-check when a required-multi
slot has zero applications.

@docs Available, Used, NotFilled, Filled
-}



{-| Optional-singular capability that has not yet been used. -}
type Available
    = Available


{-| Optional-singular capability that has been used and cannot be applied again. -}
type Used
    = Used


{-| Required-multi slot that has not yet been filled. `build` requires `Filled`. -}
type NotFilled
    = NotFilled


{-| Required-multi slot that has been filled at least once. -}
type Filled
    = Filled