module M3e.Value exposing (Value, Supported, toString, filled, tonal, elevated, outlined, textVariant, small)

type Supported = Supported
type Value tags = Value String

toString : Value tags -> String
toString (Value s) = s

filled : Value { a | filled : Supported }
filled = Value "filled"
tonal : Value { a | tonal : Supported }
tonal = Value "tonal"
elevated : Value { a | elevated : Supported }
elevated = Value "elevated"
outlined : Value { a | outlined : Supported }
outlined = Value "outlined"
textVariant : Value { a | textVariant : Supported }
textVariant = Value "text"
small : Value { a | small : Supported }
small = Value "small"
