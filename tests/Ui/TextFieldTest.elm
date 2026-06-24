module Ui.TextFieldTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.TextField


suite : Test
suite =
    describe "Ui.TextField label anchoring"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                Ui.TextField.text
                    { label = "Supplier name"
                    , value = ""
                    , variant = Ui.TextField.Filled
                    , onChange = always ()
                    }
                    |> Ui.TextField.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-supplier-name")
                        ]
        , test "single-line input carries the same stable id" <|
            \_ ->
                Ui.TextField.text
                    { label = "Supplier name"
                    , value = ""
                    , variant = Ui.TextField.Filled
                    , onChange = always ()
                    }
                    |> Ui.TextField.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "input" ]
                    |> Query.has [ Selector.id "uif-supplier-name" ]
        , test "multiline textarea carries the stable id" <|
            \_ ->
                Ui.TextField.multiline
                    { label = "Description"
                    , value = ""
                    , variant = Ui.TextField.Outlined
                    , onChange = always ()
                    }
                    |> Ui.TextField.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "textarea" ]
                    |> Query.has [ Selector.id "uif-description" ]
        , test "withId overrides on both label and input" <|
            \_ ->
                Ui.TextField.text
                    { label = "Supplier name"
                    , value = ""
                    , variant = Ui.TextField.Filled
                    , onChange = always ()
                    }
                    |> Ui.TextField.withId "sn"
                    |> Ui.TextField.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "label" ]
                            >> Query.has [ Selector.attribute (Attr.for "sn") ]
                        , Query.find [ Selector.tag "input" ]
                            >> Query.has [ Selector.id "sn" ]
                        ]
        ]
