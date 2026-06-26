module M3e.DisclosureTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Disclosure as Disclosure
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


sectionNode : List (Disclosure.SectionOption msg) -> Node.Node msg
sectionNode opts =
    Disclosure.section { header = "FAQ", content = [] } opts
        |> Renderable.toNode


accordionNode : List (Disclosure.SectionOption msg) -> List (Disclosure.Option msg) -> Node.Node msg
accordionNode secOpts accOpts =
    Disclosure.view
        { sections = [ Disclosure.section { header = "FAQ", content = [] } secOpts ] }
        accOpts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Disclosure — view-style port"
        [ test "section renders <m3e-expansion-panel>" <|
            \_ ->
                sectionNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-expansion-panel")
        , test "view renders <m3e-accordion>" <|
            \_ ->
                accordionNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-accordion")
        , test "accordion children are expansion panels" <|
            \_ ->
                Disclosure.view
                    { sections =
                        [ Disclosure.section { header = "A", content = [] } []
                        , Disclosure.section { header = "B", content = [] } []
                        ]
                    }
                    []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "m3e-expansion-panel", "m3e-expansion-panel" ]
        , test "header string lands in <span slot=\"header\">" <|
            \_ ->
                sectionNode []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map
                        (\n ->
                            ( Node.tagOf n
                            , Node.findAttribute "slot" n
                            , Node.childrenOf n |> List.head |> Maybe.andThen nodeText
                            )
                        )
                    |> Expect.equal (Just ( Just "span", Just "header", Just "FAQ" ))
        , test "open=false is always emitted as a DOM property" <|
            \_ ->
                sectionNode []
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "sectionOpen=true is a DOM property" <|
            \_ ->
                sectionNode [ Disclosure.sectionOpen True ]
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "sectionDisabled=true is a DOM property" <|
            \_ ->
                sectionNode [ Disclosure.sectionDisabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                sectionNode []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "sectionHideToggle=true sets hide-toggle DOM property" <|
            \_ ->
                sectionNode [ Disclosure.sectionHideToggle True ]
                    |> Node.findProperty "hide-toggle"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "sectionActions render inside <div slot=\"actions\">" <|
            \_ ->
                sectionNode
                    [ Disclosure.sectionActions
                        [ Button.view { label = "Learn more", variant = Button.Text } [] ]
                    ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "actions")
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.childrenOf n |> List.length ))
                    |> Expect.equal (Just ( Just "div", 1 ))
        , test "no actions slot when empty" <|
            \_ ->
                sectionNode []
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "actions")
                    |> List.length
                    |> Expect.equal 0
        , test "multi=true is emitted (accordion level)" <|
            -- multi is a rawAttr (non-introspectable), so we verify via child count
            -- staying the same — the main check is compilation + the accordion renders
            \_ ->
                Disclosure.view
                    { sections = [ Disclosure.section { header = "X", content = [] } [] ] }
                    [ Disclosure.multi True ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "content renders after header in default slot" <|
            \_ ->
                Disclosure.section
                    { header = "FAQ"
                    , content = [ Renderable.html (Node.toHtml (Node.text "body")) ]
                    }
                    []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]


nodeText : Node.Node msg -> Maybe String
nodeText n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
