module Ui.SwitchTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Switch


suite : Test
suite =
    describe "Ui.Switch label anchoring"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-dark-mode")
                        ]
        , test "control carries the same stable id" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-switch" ]
                    |> Query.has [ Selector.id "uif-dark-mode" ]
        , test "withId overrides on both label and control" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.withId "dm"
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "label" ]
                            >> Query.has [ Selector.attribute (Attr.for "dm") ]
                        , Query.find [ Selector.tag "m3e-switch" ]
                            >> Query.has [ Selector.id "dm" ]
                        ]
        , describe "withVisibleLabel False (bare mode)"
            [ test "renders no m3e-form-field and no visible label" <|
                \_ ->
                    Ui.Switch.new { label = "Reduce motion", checked = False, onChange = always () }
                        |> Ui.Switch.withVisibleLabel False
                        |> Ui.Switch.view
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                            , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                            ]
            , test "keeps the label as aria-label on the bare control" <|
                \_ ->
                    Ui.Switch.new { label = "Reduce motion", checked = False, onChange = always () }
                        |> Ui.Switch.withVisibleLabel False
                        |> Ui.Switch.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.tag "m3e-switch", Selector.attribute (Attr.attribute "aria-label" "Reduce motion") ]
            ]
        , describe "withAttributes (dual-root host)"
            [ test "labeled mode: caller class lands on the m3e-form-field wrapper" <|
                \_ ->
                    Ui.Switch.new { label = "Dark mode", checked = False, onChange = always () }
                        |> Ui.Switch.withAttributes [ Attr.class "w-full" ]
                        |> Ui.Switch.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.tag "m3e-form-field", Selector.classes [ "w-full" ] ]
            , test "bare mode: caller class lands on the m3e-switch control" <|
                \_ ->
                    Ui.Switch.new { label = "Dark mode", checked = False, onChange = always () }
                        |> Ui.Switch.withVisibleLabel False
                        |> Ui.Switch.withAttributes [ Attr.class "w-full" ]
                        |> Ui.Switch.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.tag "m3e-switch", Selector.classes [ "w-full" ] ]
            ]
        ]
