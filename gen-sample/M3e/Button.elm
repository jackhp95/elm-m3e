module M3e.Button exposing (button, variant, disabled, text)

import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Cem.Button as Cem
import M3e.Element as Element exposing (Element)
import M3e.Node as Node
import M3e.Value as Value exposing (Supported, Value)

variant : Value { elevated : Supported, filled : Supported, tonal : Supported, outlined : Supported, textVariant : Supported } -> Attr { c | variant : Supported } msg
variant = Cem.variant

disabled : Bool -> Attr { c | disabled : Supported } msg
disabled = Cem.disabled

text : String -> Element { s | element : Supported } msg
text s = Element.fromNode (Node.text s)

button :
    List (Attr { variant : Supported, disabled : Supported, slot : Supported } msg)
    -> List (Element { icon : Supported, element : Supported } msg)
    -> Element { s | button : Supported } msg
button attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Cem.button (List.map Attr.forget erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )
