module Seam exposing (asAttribute, asElement, fromHtml)

{-| The sanctioned constructor for CANONIZING new supported vocabulary — meant for
design-system files only (no suppression; a DS-file edit review catches). The
`Kit`/`Native` producers are built on this. See docs/ADOPTION\_AND\_SLOTS.md §8.
-}

import Html exposing (Html)
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node.Internal as Node exposing (Node)


asElement : Node msg -> Element supported msg
asElement =
    Element.fromNode


fromHtml : Html msg -> Element supported msg
fromHtml =
    Node.raw >> Element.fromNode


asAttribute : Html.Attribute msg -> Attr capability msg
asAttribute a =
    Attr.attribute (\_ -> a) ()
