module EscapeHatch exposing (fromHtml, asElement, asAttribute)

{-| The break-glass escape, usable in ANY file. Loud + greppable; the design-system
team audits usages and fixes either the app or the codegen'd package.
-}

import Html exposing (Html)
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Element as Element exposing (Element)
import M3e.Node as Node


fromHtml : Html msg -> Element supported msg
fromHtml =
    Node.raw >> Element.fromNode


asElement : Element a msg -> Element b msg
asElement =
    Element.toNode >> Element.fromNode


asAttribute : Attr a msg -> Attr b msg
asAttribute =
    Attr.forget
