module M3e.Icon exposing (icon, leadingIcon)

import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Cem.Icon as Cem
import M3e.Element as Element exposing (Element)
import M3e.Node as Node
import M3e.Value exposing (Supported)

icon : List (Attr { slot : Supported } msg) -> List (Element { element : Supported } msg) -> Element { s | icon : Supported } msg
icon attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Cem.icon (List.map Attr.forget erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )

leadingIcon : List (Attr { slot : Supported } msg) -> List (Element { element : Supported } msg) -> Element { s | icon : Supported } msg
leadingIcon attrs children = Element.withSlot "leading" (icon attrs children)
