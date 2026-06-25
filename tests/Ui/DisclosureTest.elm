module Ui.DisclosureTest exposing (suite)

{-| Spec for `Ui.Disclosure`. The element is chosen AT THE CALL SITE via two
explicit constructors — no render-path inference (D4):

  - `Disclosure.single` → `m3e-expansion-panel`
  - `Disclosure.accordion` → `m3e-accordion`

-}

import Expect
import Html
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag, text)
import Ui.Disclosure as Disclosure


suite : Test
suite =
    describe "Ui.Disclosure"
        [ describe "single"
            [ test "renders an m3e-expansion-panel" <|
                \_ ->
                    Disclosure.single "faq-shipping"
                        (Html.text "Shipping")
                        [ Html.text "We ship worldwide." ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.has [ tag "m3e-expansion-panel" ]
            , test "does NOT render an accordion" <|
                \_ ->
                    Disclosure.single "faq-shipping"
                        (Html.text "Shipping")
                        [ Html.text "We ship worldwide." ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.hasNot [ tag "m3e-accordion" ]
            , test "headline lands in the header slot" <|
                \_ ->
                    Disclosure.single "faq-shipping"
                        (Html.text "Shipping")
                        [ Html.text "We ship worldwide." ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.find [ attribute (Html.Attributes.attribute "slot" "header") ]
                        |> Query.has [ text "Shipping" ]
            , test "content lands in the default slot (panel body)" <|
                \_ ->
                    Disclosure.single "faq-shipping"
                        (Html.text "Shipping")
                        [ Html.text "We ship worldwide." ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.has [ text "We ship worldwide." ]
            , test "carries the caller-supplied id" <|
                \_ ->
                    Disclosure.single "faq-shipping"
                        (Html.text "Shipping")
                        [ Html.text "body" ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.has [ attribute (Html.Attributes.id "faq-shipping") ]
            ]
        , describe "accordion"
            [ test "renders an m3e-accordion" <|
                \_ ->
                    Disclosure.accordion "faq"
                        [ Disclosure.section "faq-a" (Html.text "A") [ Html.text "answer a" ]
                        , Disclosure.section "faq-b" (Html.text "B") [ Html.text "answer b" ]
                        ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.has [ tag "m3e-accordion" ]
            , test "wraps each section in an m3e-expansion-panel" <|
                \_ ->
                    Disclosure.accordion "faq"
                        [ Disclosure.section "faq-a" (Html.text "A") [ Html.text "answer a" ]
                        , Disclosure.section "faq-b" (Html.text "B") [ Html.text "answer b" ]
                        ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.findAll [ tag "m3e-expansion-panel" ]
                        |> Query.count (\n -> n |> Expect.equal 2)
            , test "each section's headline lands in a header slot" <|
                \_ ->
                    Disclosure.accordion "faq"
                        [ Disclosure.section "faq-a" (Html.text "Question A") [ Html.text "answer a" ]
                        , Disclosure.section "faq-b" (Html.text "Question B") [ Html.text "answer b" ]
                        ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Query.findAll [ attribute (Html.Attributes.attribute "slot" "header") ]
                        |> Query.count (\n -> n |> Expect.equal 2)
            , test "section ids are distinct and carried onto the panels" <|
                \_ ->
                    Disclosure.accordion "faq"
                        [ Disclosure.section "faq-a" (Html.text "A") [ Html.text "answer a" ]
                        , Disclosure.section "faq-b" (Html.text "B") [ Html.text "answer b" ]
                        ]
                        |> Disclosure.view
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.has [ attribute (Html.Attributes.id "faq-a") ]
                            , Query.has [ attribute (Html.Attributes.id "faq-b") ]
                            , Query.has [ attribute (Html.Attributes.id "faq") ]
                            ]
            ]
        , describe "no shared magic id"
            [ test "two independent single disclosures keep their own ids (no collision)" <|
                \_ ->
                    let
                        a : Disclosure.Disclosure msg
                        a =
                            Disclosure.single "one" (Html.text "One") [ Html.text "1" ]

                        b : Disclosure.Disclosure msg
                        b =
                            Disclosure.single "two" (Html.text "Two") [ Html.text "2" ]
                    in
                    Html.div []
                        [ Disclosure.view a, Disclosure.view b ]
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.has [ attribute (Html.Attributes.id "one") ]
                            , Query.has [ attribute (Html.Attributes.id "two") ]
                            ]
            ]
        ]
