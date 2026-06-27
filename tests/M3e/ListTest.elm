module M3e.ListTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.List as MList
import M3e.Node as Node exposing (Attr(..), Node(..))
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


listNode : List (MList.Option msg) -> List (Element { listItem : Element.Supported } msg) -> Node msg
listNode opts items =
    MList.list { items = items } opts
        |> Element.toNode


actionListNode : List (MList.Option msg) -> List (Element { actionItem : Element.Supported } msg) -> Node msg
actionListNode opts items =
    MList.actionList { items = items } opts
        |> Element.toNode


selectionListNode : List (MList.SelectionOption msg) -> List (Element { optionItem : Element.Supported } msg) -> Node msg
selectionListNode opts items =
    MList.selectionList { items = items } opts
        |> Element.toNode


{-| Count the number of RawAttr (event listeners / opaque attrs) on an element node.
Used to verify that event handlers are registered without inspecting their names.
-}
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


suite : Test
suite =
    describe "M3e.List — view-style port"
        [ -- ── Plain list container ────────────────────────────────────────
          describe "list container (<m3e-list>)"
            [ test "list renders <m3e-list>" <|
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
            ]

        -- ── Action list container ────────────────────────────────────────
        , describe "actionList container (<m3e-action-list>)"
            [ test "actionList renders <m3e-action-list>" <|
                \_ ->
                    actionListNode [] []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-action-list")
            , test "id sets the 'id' attribute on actionList" <|
                \_ ->
                    actionListNode [ MList.id "my-actions" ] []
                        |> Node.findAttribute "id"
                        |> Expect.equal (Just "my-actions")
            , test "actionList item count reflects the items list" <|
                \_ ->
                    actionListNode []
                        [ MList.actionItem { headline = "A" } []
                        , MList.actionItem { headline = "B" } []
                        ]
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            ]

        -- ── Selection list container ─────────────────────────────────────
        , describe "selectionList container (<m3e-selection-list>)"
            [ test "selectionList renders <m3e-selection-list>" <|
                \_ ->
                    selectionListNode [] []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-selection-list")
            , test "selectionId sets the 'id' attribute" <|
                \_ ->
                    selectionListNode [ MList.selectionId "my-sel" ] []
                        |> Node.findAttribute "id"
                        |> Expect.equal (Just "my-sel")
            , test "multi=true sets the multi DOM property" <|
                \_ ->
                    selectionListNode [ MList.multi True ] []
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "multi defaults to false" <|
                \_ ->
                    selectionListNode [] []
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "selectionName sets the 'name' attribute" <|
                \_ ->
                    selectionListNode [ MList.selectionName "topics" ] []
                        |> Node.findAttribute "name"
                        |> Expect.equal (Just "topics")
            , test "selectionList item count reflects the items list" <|
                \_ ->
                    selectionListNode []
                        [ MList.option { headline = "A" } []
                        , MList.option { headline = "B" } []
                        ]
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            ]

        -- ── Static item ─────────────────────────────────────────────────
        , describe "item (<m3e-list-item>)"
            [ test "item renders <m3e-list-item>" <|
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
            ]

        -- ── Action item ──────────────────────────────────────────────────
        , describe "actionItem (<m3e-list-action>)"
            [ test "actionItem renders <m3e-list-action> (not m3e-list-item-button)" <|
                \_ ->
                    MList.actionItem { headline = "Settings" } []
                        |> Element.toNode
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-list-action")
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
            , test "actionOnClick wires a click event listener" <|
                \_ ->
                    -- Event listeners are opaque (RawAttr); we verify one is present.
                    MList.actionItem { headline = "Settings" }
                        [ MList.actionOnClick () ]
                        |> Element.toNode
                        |> countRawAttrs
                        |> Expect.greaterThan 0
            , test "actionHref is absent by default" <|
                \_ ->
                    -- href is a RawAttr, so we check no extra opaque attrs appear
                    -- without setting href.
                    MList.actionItem { headline = "Settings" } []
                        |> Element.toNode
                        |> countRawAttrs
                        |> Expect.equal 0
            , test "actionHref adds a link attr (RawAttr present)" <|
                \_ ->
                    MList.actionItem { headline = "Account" }
                        [ MList.actionHref "/account" ]
                        |> Element.toNode
                        |> countRawAttrs
                        |> Expect.greaterThan 0
            ]

        -- ── Option item ──────────────────────────────────────────────────
        , describe "option (<m3e-list-option>)"
            [ test "option renders <m3e-list-option>" <|
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
            , test "optionOnChange wires a 'change' event listener (not click)" <|
                \_ ->
                    -- The change event is registered as an opaque RawAttr.
                    -- Without onChange the node has 0 RawAttrs; with it, 1+.
                    -- This proves the handler is wired; the event name is 'change'
                    -- per the Node.on "change" ... call in the implementation.
                    let
                        withoutHandler : Int
                        withoutHandler =
                            MList.option { headline = "Wi-Fi" } []
                                |> Element.toNode
                                |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            MList.option { headline = "Wi-Fi" }
                                [ MList.optionOnChange (\_ -> ()) ]
                                |> Element.toNode
                                |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            ]

        -- ── Divider ─────────────────────────────────────────────────────
        , test "divider renders <m3e-divider>" <|
            \_ ->
                MList.divider
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-divider")

        -- ── Expandable item ──────────────────────────────────────────────
        , describe "expandable (<m3e-expandable-list-item>)"
            [ test "expandable renders <m3e-expandable-list-item>" <|
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
        ]
