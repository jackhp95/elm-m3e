module Ui.SelectTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Select


type Plan
    = Free
    | Pro


plan : Ui.Select.Select Ui.Select.Single Plan ()
plan =
    Ui.Select.single
        { label = "Plan"
        , options =
            [ Ui.Select.option { value = Free, label = "Free" }
            , Ui.Select.option { value = Pro, label = "Pro" }
            ]
        , selected = Just Pro
        , onChange = always ()
        }


suite : Test
suite =
    describe "Ui.Select"
        [ test "renders m3e-select standalone (no m3e-form-field wrap)" <|
            \_ ->
                plan
                    |> Ui.Select.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-form-field" ]
                    |> Query.count (Expect.equal 0)
        , test "uses the native label attribute on m3e-select" <|
            \_ ->
                -- With no help/error, the root node IS the m3e-select, so
                -- assert against the root rather than via descendant find.
                plan
                    |> Ui.Select.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-select"
                        , Selector.attribute (Attr.attribute "label" "Plan")
                        ]
        , test "does not render a separate <label> element" <|
            \_ ->
                plan
                    |> Ui.Select.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "label" ]
                    |> Query.count (Expect.equal 0)
        , test "options do not bind value to their display label" <|
            \_ ->
                -- Two options with the same display label must not collide
                -- on the value attribute. We assert no value attr is set.
                Ui.Select.single
                    { label = "Choice"
                    , options =
                        [ Ui.Select.option { value = Free, label = "Same" }
                        , Ui.Select.option { value = Pro, label = "Same" }
                        ]
                    , selected = Just Free
                    , onChange = always ()
                    }
                    |> Ui.Select.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-option" ]
                    |> Query.each
                        (Query.hasNot [ Selector.attribute (Attr.value "Same") ])
        ]
