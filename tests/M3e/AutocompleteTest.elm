module M3e.AutocompleteTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Autocomplete as Auto
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Attr(..), Node(..))
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


viewNode : String -> List (Auto.Option msg) -> Node msg
viewNode forId opts =
    Auto.view { for = forId } opts
        |> Element.toNode


countRawAttrs : Node msg -> Int
countRawAttrs node =
    case node of
        Element { attrs } ->
            List.length
                (List.filter
                    (\a ->
                        case a of
                            RawAttr _ ->
                                True

                            _ ->
                                False
                    )
                    attrs
                )

        _ ->
            0


fruitOpt : Element { autocompleteOption : Element.Supported } msg
fruitOpt =
    Auto.option { value = "apple", label = "Apple" } []


disabledOpt : Element { autocompleteOption : Element.Supported } msg
disabledOpt =
    Auto.option { value = "grape", label = "Grape" }
        [ Auto.optionDisabled True ]



-- Suite -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Autocomplete"
        [ -- ── Container tag ─────────────────────────────────────────────
          describe "view (<m3e-autocomplete>)"
            [ test "view renders <m3e-autocomplete>" <|
                \_ ->
                    viewNode "fruit" []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-autocomplete")
            , test "for is set as an attribute" <|
                \_ ->
                    viewNode "my-input" []
                        |> Node.findAttribute "for"
                        |> Expect.equal (Just "my-input")
            ]

        -- ── Bool properties (emitted unconditionally) ────────────────────
        , describe "bool properties"
            [ test "autoActivate defaults to false" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findProperty "autoActivate"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "autoActivate=True sets DOM property" <|
                \_ ->
                    viewNode "x" [ Auto.autoActivate True ]
                        |> Node.findProperty "autoActivate"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "caseSensitive defaults to false" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findProperty "caseSensitive"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "caseSensitive=True sets DOM property" <|
                \_ ->
                    viewNode "x" [ Auto.caseSensitive True ]
                        |> Node.findProperty "caseSensitive"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "hideSelectionIndicator defaults to false" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findProperty "hideSelectionIndicator"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "loading defaults to false" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findProperty "loading"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "loading=True sets DOM property" <|
                \_ ->
                    viewNode "x" [ Auto.loading True ]
                        |> Node.findProperty "loading"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "required defaults to false" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findProperty "required"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "required=True sets DOM property" <|
                \_ ->
                    viewNode "x" [ Auto.required True ]
                        |> Node.findProperty "required"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            ]

        -- ── Filter attribute ─────────────────────────────────────────────
        , describe "filter attribute"
            [ test "default filter is 'contains'" <|
                \_ ->
                    viewNode "x" []
                        |> Node.findAttribute "filter"
                        |> Expect.equal (Just "contains")
            , test "filter StartsWith sets 'starts-with'" <|
                \_ ->
                    viewNode "x" [ Auto.filter Auto.StartsWith ]
                        |> Node.findAttribute "filter"
                        |> Expect.equal (Just "starts-with")
            , test "filter EndsWith sets 'ends-with'" <|
                \_ ->
                    viewNode "x" [ Auto.filter Auto.EndsWith ]
                        |> Node.findAttribute "filter"
                        |> Expect.equal (Just "ends-with")
            , test "filter None sets 'none'" <|
                \_ ->
                    viewNode "x" [ Auto.filter Auto.None ]
                        |> Node.findAttribute "filter"
                        |> Expect.equal (Just "none")
            ]

        -- ── String attributes ─────────────────────────────────────────────
        , describe "string attributes"
            [ test "loadingLabel sets loading-label attribute" <|
                \_ ->
                    viewNode "x" [ Auto.loadingLabel "Fetching…" ]
                        |> Node.findAttribute "loading-label"
                        |> Expect.equal (Just "Fetching…")
            , test "noDataLabel sets no-data-label attribute" <|
                \_ ->
                    viewNode "x" [ Auto.noDataLabel "Nothing found" ]
                        |> Node.findAttribute "no-data-label"
                        |> Expect.equal (Just "Nothing found")
            , test "panelClass sets panel-class attribute" <|
                \_ ->
                    viewNode "x" [ Auto.panelClass "my-panel" ]
                        |> Node.findAttribute "panel-class"
                        |> Expect.equal (Just "my-panel")
            ]

        -- ── Options (slotted children) ────────────────────────────────────
        , describe "options"
            [ test "options populates autocomplete children" <|
                \_ ->
                    viewNode "x"
                        [ Auto.options
                            [ fruitOpt
                            , disabledOpt
                            ]
                        ]
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            , test "option renders <m3e-option>" <|
                \_ ->
                    fruitOpt
                        |> Element.toNode
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-option")
            , test "option value is set as the 'value' attribute" <|
                \_ ->
                    fruitOpt
                        |> Element.toNode
                        |> Node.findAttribute "value"
                        |> Expect.equal (Just "apple")
            , test "optionDisabled=True sets disabled property on <m3e-option>" <|
                \_ ->
                    disabledOpt
                        |> Element.toNode
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "optionDisabled=False is emitted unconditionally" <|
                \_ ->
                    fruitOpt
                        |> Element.toNode
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            ]

        -- ── Events ───────────────────────────────────────────────────────
        , describe "events"
            [ test "onChange wires a RawAttr event listener" <|
                \_ ->
                    let
                        withoutHandler : Int
                        withoutHandler =
                            viewNode "x" [] |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            viewNode "x" [ Auto.onChange (\_ -> ()) ] |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            , test "onQuery wires a RawAttr event listener" <|
                \_ ->
                    let
                        withoutHandler : Int
                        withoutHandler =
                            viewNode "x" [] |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            viewNode "x" [ Auto.onQuery (\_ -> ()) ] |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            , test "onToggle wires a RawAttr event listener" <|
                \_ ->
                    let
                        withoutHandler : Int
                        withoutHandler =
                            viewNode "x" [] |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            viewNode "x" [ Auto.onToggle (\_ -> ()) ] |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            , test "all three event options each add an independent RawAttr" <|
                \_ ->
                    viewNode "x"
                        [ Auto.onChange (\_ -> ())
                        , Auto.onQuery (\_ -> ())
                        , Auto.onToggle (\_ -> ())
                        ]
                        |> countRawAttrs
                        |> Expect.equal 3
            ]

        -- ── Slotted loading/no-data content ──────────────────────────────
        , describe "slotted content"
            [ test "loadingContent adds a child with slot='loading'" <|
                \_ ->
                    viewNode "x"
                        [ Auto.loadingContent (Element.text "Loading…") ]
                        |> Node.childrenOf
                        |> List.filterMap (Node.findAttribute "slot")
                        |> List.member "loading"
                        |> Expect.equal True
            , test "noDataContent adds a child with slot='no-data'" <|
                \_ ->
                    viewNode "x"
                        [ Auto.noDataContent (Element.text "No results") ]
                        |> Node.childrenOf
                        |> List.filterMap (Node.findAttribute "slot")
                        |> List.member "no-data"
                        |> Expect.equal True
            ]
        ]
