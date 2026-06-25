module Ui.SwitchTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Switch


suite : Test
suite =
    describe "Ui.Switch (bare control)"
        [ test "renders a bare m3e-switch with the label as aria-label" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-switch"
                        , Selector.attribute (Attr.attribute "aria-label" "Dark mode")
                        ]
        , test "renders no m3e-form-field and no visible label" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                        ]
        , test "control carries the stable id derived from the label" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-switch", Selector.id "uif-dark-mode" ]
        , test "withId overrides the stable id on the control" <|
            \_ ->
                Ui.Switch.new
                    { label = "Dark mode"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Switch.withId "dm"
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-switch", Selector.id "dm" ]
        , test "withAttributes lands on the bare m3e-switch control" <|
            \_ ->
                Ui.Switch.new { label = "Dark mode", checked = False, onChange = always () }
                    |> Ui.Switch.withAttributes [ Attr.class "w-full" ]
                    |> Ui.Switch.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-switch", Selector.classes [ "w-full" ] ]
        ]
