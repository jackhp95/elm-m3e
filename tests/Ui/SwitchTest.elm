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
        ]
