module M3e.Value.Core exposing (Value, Supported, toString, token)
type Value tags = Value String
type Supported = Supported
toString : Value tags -> String
toString (Value s) = s
token : String -> Value tags
token = Value
