module Neg2 exposing (main)
import Html exposing (Html)
import Html.Attributes
import M3e.Button as Button
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Element as Element
import M3e.Node as Node
import M3e.Value exposing (Supported)
foreign : Attr { c | foreign : Supported } msg
foreign = Attr.attribute (Html.Attributes.attribute "x") "y"
main : Html msg
main = Button.button [ foreign ] [] |> Element.toNode |> Node.toHtml
