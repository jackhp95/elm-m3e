module M3e.Kind exposing
    ( Brand, Ctx
    , Available, Used
    )

{-| The library's private phantom markers and named kind/context sets.

`Brand` marks this library's kind-row fields; `Ctx` marks its context-row
fields. Both are nominal and private to this library — a foreign library's
markers never unify with them, even under the same field name.
`Available`/`Used` are the pipe-builder's write-once capability markers.

@docs Brand, Ctx
@docs Available, Used

-}


{-| The private kind marker (never constructed).
-}
type Brand
    = Brand_


{-| The private context marker (never constructed).
-}
type Ctx
    = Ctx_


{-| Pipe-builder capability: still writable.
-}
type Available
    = Available_


{-| Pipe-builder capability: consumed.
-}
type Used
    = Used_
