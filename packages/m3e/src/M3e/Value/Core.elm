module M3e.Value.Core exposing
    ( Value, Supported
    , toString, token
    )

{-| The primitive behind every token enum. A `Value tags` is a string tagged
with a phantom `tags` row naming which token families it belongs to, so a token
can only be passed where that family is accepted. `Supported` is the marker
written into a row to mean "this member is admitted here".

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


{-| Construct a token from its string.
-}
token : String -> Value tags
token =
    Value
