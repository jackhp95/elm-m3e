module M3e.Kind exposing (Brand)

{-| Per-library kind brand — the phantom marker type for private-tier
component kind rows (`{ s | button : M3e.Kind.Brand }`).

This type is opaque and nullary. Each library mints its own `Brand`
in its own namespace so Elm's nominal type system keeps them distinct —
a foreign library's elements are rejected by slots expecting this brand,
without any runtime cost.

@docs Brand

-}


{-| The per-library phantom kind marker. Never constructed by user code.
-}
type Brand
    = Brand_
