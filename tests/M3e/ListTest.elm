module M3e.ListTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.List as MList
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


listNode : List (MList.Option msg) -> List (Element { listItem : Element.Supported } msg) -> Node msg
listNode opts items =
    MList.view { items = items } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.List — view-style port"
        [ -- Container
          test "view renders <m3e-list>" <|
            \_ ->
                listNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-list")
        , test "id sets the 'id' attribute" <|
            \_ ->
                listNode [ MList.id "my-list" ] []
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "my-list")
        , test "item count reflects the items list" <|
            \_ ->
                listNode []
                    [ MList.item { headline = "A" } []
                    , MList.divider
                    , MList.item { headline = "B" } []
                    ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 3

        -- Static item
        , test "item renders <m3e-list-item>" <|
            \_ ->
                MList.item { headline = "Inbox" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-list-item")
        , test "item headline is in the default slot (no slot attr)" <|
            \_ ->
                MList.item { headline = "Inbox" } []
                    |> Element.toNode
                    |> Node.childrenOf
                    -- only child: the headline text node (no leading/trailing)
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Nothing ]
        , test "staticOverline child has slot='overline'" <|
            \_ ->
                MList.item { headline = "Inbox" }
                    [ MList.staticOverline "Unread" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "overline")
        , test "staticSupporting child has slot='supporting-text'" <|
            \_ ->
                MList.item { headline = "Inbox" }
                    [ MList.staticSupporting "12 messages" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "supporting-text")
                    |> List.length
                    |> Expect.equal 1

        -- Action item
        , test "actionItem renders <m3e-list-item-button>" <|
            \_ ->
                MList.actionItem { headline = "Settings" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-list-item-button")
        , test "actionDisabled=true sets the disabled DOM property" <|
            \_ ->
                MList.actionItem { headline = "Settings" }
                    [ MList.actionDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled emits false by default on actionItem" <|
            \_ ->
                MList.actionItem { headline = "Settings" } []
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")

        -- Option item
        , test "option renders <m3e-list-option>" <|
            \_ ->
                MList.option { headline = "Wi-Fi" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-list-option")
        , test "optionSelected=true sets the selected DOM property" <|
            \_ ->
                MList.option { headline = "Wi-Fi" }
                    [ MList.optionSelected True ]
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "optionSelected=false sets the selected DOM property" <|
            \_ ->
                MList.option { headline = "Wi-Fi" }
                    [ MList.optionSelected False ]
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "optionValue sets the value attribute" <|
            \_ ->
                MList.option { headline = "Wi-Fi" }
                    [ MList.optionValue "wifi" ]
                    |> Element.toNode
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "wifi")
        , test "optionDisabled=true sets the disabled DOM property" <|
            \_ ->
                MList.option { headline = "Wi-Fi" }
                    [ MList.optionDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")

        -- Divider
        , test "divider renders <m3e-divider>" <|
            \_ ->
                MList.divider
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-divider")

        -- Expandable item
        , test "expandable renders <m3e-expandable-list-item>" <|
            \_ ->
                MList.expandable { headline = "Folders", children = [] } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-expandable-list-item")
        , test "expandableOpen=true sets the open DOM property" <|
            \_ ->
                MList.expandable { headline = "Folders", children = [] }
                    [ MList.expandableOpen True ]
                    |> Element.toNode
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "open emits false by default on expandable" <|
            \_ ->
                MList.expandable { headline = "Folders", children = [] } []
                    |> Element.toNode
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "expandable children land in the items slot" <|
            \_ ->
                MList.expandable
                    { headline = "Folders"
                    , children =
                        [ MList.item { headline = "Drafts" } []
                        , MList.item { headline = "Sent" } []
                        ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "items")
                    |> List.length
                    |> Expect.equal 2
        , test "expandableDisabled=true sets the disabled DOM property" <|
            \_ ->
                MList.expandable { headline = "Folders", children = [] }
                    [ MList.expandableDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        ]
