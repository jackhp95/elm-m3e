module Ui.ShapeTest exposing (suite)

import Html.Attributes
import Cem.M3e.Shape
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Shape


suite : Test
suite =
    describe "Ui.Shape"
        [ test "withName projects the typed shape name onto the element" <|
            \_ ->
                Ui.Shape.new
                    |> Ui.Shape.withName Cem.M3e.Shape.Circle
                    |> Ui.Shape.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "name" "circle")
                        ]
        ]
