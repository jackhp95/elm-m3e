module M3e.DatePickerToggleTest exposing (suite)

import Expect
import M3e.DatePickerToggle as DatePickerToggle
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (DatePickerToggle.Option msg) -> Node msg
node opts =
    DatePickerToggle.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.DatePickerToggle — view-style port"
        [ test "renders <m3e-datepicker-toggle>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-datepicker-toggle")
        , test "datepicker-toggle is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "for sets the introspectable attribute" <|
            \_ ->
                node [ DatePickerToggle.for "my-datepicker" ]
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-datepicker")
        , test "for is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        ]
