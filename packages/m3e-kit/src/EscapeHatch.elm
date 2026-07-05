module EscapeHatch exposing (asAttribute, asElement, fromHtml)

{-| The break-glass escape, usable in ANY file. Loud + greppable; the design-system
team audits usages and fixes either the app or the codegen'd package.
-}

import Html exposing (Html)
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node.Internal as Node


fromHtml : Html msg -> Element supported msg
fromHtml =
    Node.raw >> Element.fromNode


asElement : Element a msg -> Element b msg
asElement =
    Element.toNode >> Element.fromNode


asAttribute : Attr a msg -> Attr b msg
asAttribute =
    Attr.forget
