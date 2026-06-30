module Neg1 exposing (main)
import Html exposing (Html)
import M3e.Button as Button
import M3e.Element as Element
import M3e.Node as Node
import M3e.Value as Value
main : Html msg
main = Button.button [ Button.variant Value.small ] [] |> Element.toNode |> Node.toHtml
