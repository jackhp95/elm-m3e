module M3e.Cem.Attr exposing (Attr, attribute, toAttribute, forget, slot)

import Html
import Html.Attributes
import M3e.Value exposing (Supported)

type Attr capability msg = Attr (() -> Html.Attribute msg)

attribute : (a -> Html.Attribute msg) -> a -> Attr capability msg
attribute fn value = Attr (\() -> fn value)

toAttribute : Attr capability msg -> Html.Attribute msg
toAttribute (Attr run) = run ()

forget : Attr a msg -> Attr b msg
forget (Attr run) = Attr run

slot : String -> Attr { c | slot : Supported } msg
slot = attribute (Html.Attributes.attribute "slot")
