module M3e.Element exposing (Element(..), fromNode, toNode, withSlot)

import M3e.Cem.Attr as Attr
import M3e.Node as Node exposing (Node)

type Element supported msg = El (Node msg)

fromNode : Node msg -> Element any msg
fromNode = El

toNode : Element supported msg -> Node msg
toNode (El n) = n

withSlot : String -> Element supported msg -> Element supported msg
withSlot name (El node) = El (Node.addAttr (Attr.forget (Attr.slot name)) node)
