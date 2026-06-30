module M3e.Cem.Button exposing (button, variant, disabled)

import Html exposing (Html)
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Cem.Html.Button as Bottom
import M3e.Value as Value exposing (Supported, Value)

variant : Value { elevated : Supported, filled : Supported, tonal : Supported, outlined : Supported, textVariant : Supported } -> Attr { c | variant : Supported } msg
variant v = Attr.attribute Bottom.variant (Value.toString v)

disabled : Bool -> Attr { c | disabled : Supported } msg
disabled b = Attr.attribute Bottom.disabled b

button : List (Attr { variant : Supported, disabled : Supported, slot : Supported } msg) -> List (Html msg) -> Html msg
button attrs children = Bottom.button (List.map Attr.toAttribute attrs) children
