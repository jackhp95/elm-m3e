module M3e.Token.Core exposing
    ( Value, Supported
    , toString
    )

{-| The primitive behind every token enum. A `Value tags` is a string tagged
with a phantom `tags` row naming which token families it belongs to, so a token
can only be passed where that family is accepted. `Supported` is the marker
written into a row to mean "this member is admitted here".

The type is **opaque** and the free constructor `token` (mint at any row) is
_not_ re-exported here — both live in
[`M3e.Token.Core.Internal`](M3e-Value-Core-Internal), reachable only by generated
`M3e.*` code and a team's `Seam` module. The extraction
[`toString`](#toString) stays public.

@docs Value, Supported
@docs toString

-}

import M3e.Token.Core.Internal as I


{-| A phantom-tagged string token, opaque and re-exported from
[`M3e.Token.Core.Internal`](M3e-Value-Core-Internal).
-}
type alias Value tags =
    I.Value tags


{-| Row marker meaning "admitted here", re-exported from
[`M3e.Token.Core.Internal`](M3e-Value-Core-Internal).
-}
type alias Supported =
    I.Supported


{-| The token's underlying string (what the element observes).
-}
toString : Value tags -> String
toString =
    I.toString
