module Kit exposing (text, link)

{-| The user-provided `text` and `link` producers (docs §8): slotted text needs a
wrapper, and navigation is a plain anchor — the library doesn't opinionate either,
so they live here in userland. Built on `Seam`, they carry the `text` / `link` kind.
-}

import Html
import Html.Attributes
import M3e.Cem.Attr as Attr
import M3e.Element as Element exposing (Element)
import M3e.Node as Node
import M3e.Value exposing (Supported)
import Seam


text : String -> Element { k | text : Supported } msg
text s =
    Seam.asElement (Node.text s)


link : String -> List (Element s msg) -> Element { k | link : Supported } msg
link href kids =
    Seam.asElement
        (Node.fromComponent
            (\a c -> Html.a (Html.Attributes.href href :: List.map Attr.toAttribute a) c)
            []
            (List.map Element.toNode kids)
        )
