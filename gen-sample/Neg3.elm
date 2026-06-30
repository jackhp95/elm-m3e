module Neg3 exposing (main)
import Html exposing (Html)
import M3e.Button as Button
import M3e.Element as Element
import M3e.Node as Node
main : Html msg
main = Button.button [] [ Button.button [] [] ] |> Element.toNode |> Node.toHtml
