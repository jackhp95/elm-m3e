module M3e.Value.Core.Internal exposing
    ( Value(..), Supported
    , toString, token
    )

{-| The **unfenced** interior of [`M3e.Value.Core`](M3e-Value-Core): the opaque
`Value` type _with its constructor_ plus the free assertion [`token`](#token),
which mints a `Value` at any `tags` row from a bare string. Importable only by
generated `M3e.*` code (the generated `M3e.Value` token declarations call it at a
concrete row) and a team's `Seam` module (enforced by
`NoInternalImportOutsideAllowed`). See ADR 0014 §2.

@docs Value, Supported
@docs toString, token

-}


{-| A phantom-tagged string token.
-}
type Value tags
    = Value String


{-| Row marker meaning "admitted here".
-}
type Supported
    = Supported


{-| The token's underlying string (what the element observes).
-}
toString : Value tags -> String
toString (Value s) =
    s


{-| Construct a token from its string. The `tags` row is free here — that is the
free assertion — so this lives out of `M3e.Value.Core`'s public surface.
-}
token : String -> Value tags
token =
    Value
