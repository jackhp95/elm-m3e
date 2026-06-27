module M3e.MenuTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Menu as Menu
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


menuNode : List (Menu.Option msg) -> List (Element { menuItem : Element.Supported } msg) -> Node msg
menuNode opts items =
    Menu.view { items = items } opts
        |> Element.toNode


plainItem : Element { menuItem : Element.Supported } String
plainItem =
    Menu.item { label = "Edit", action = Menu.Click "EditClicked" } []


checkedItem : Bool -> Element { menuItem : Element.Supported } String
checkedItem b =
    Menu.checkboxItem
        { label = "Show grid"
        , onChange =
            \checked ->
                if checked then
                    "on"

                else
                    "off"
        }
        [ Menu.checkboxChecked b ]


radioItem_ : Bool -> Element { menuItem : Element.Supported } String
radioItem_ sel =
    Menu.radioItem { label = "Left", onClick = "AlignLeft" } [ Menu.radioSelected sel ]


suite : Test
suite =
    describe "M3e.Menu — view-style port"
        [ -- Container
          test "view renders <m3e-menu>" <|
            \_ ->
                menuNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu")
        , test "id sets the 'id' attribute" <|
            \_ ->
                menuNode [ Menu.id "my-menu" ] []
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "my-menu")
        , test "id absent by default" <|
            \_ ->
                menuNode [] []
                    |> Node.findAttribute "id"
                    |> Expect.equal Nothing
        , test "submenu=true sets the submenu DOM property" <|
            \_ ->
                menuNode [ Menu.submenu True ] []
                    |> Node.findProperty "submenu"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "submenu emits false by default" <|
            \_ ->
                menuNode [] []
                    |> Node.findProperty "submenu"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "item count reflects the items list" <|
            \_ ->
                menuNode [] [ plainItem, plainItem ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2

        -- Plain item
        , test "item renders <m3e-menu-item>" <|
            \_ ->
                plainItem
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu-item")
        , test "item label is in the default slot (no slot attr)" <|
            \_ ->
                plainItem
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Nothing ]
        , test "item link sets the 'href' attribute" <|
            \_ ->
                Menu.item { label = "Docs", action = Menu.Link "https://example.com" } []
                    |> Element.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "https://example.com")
        , test "itemDisabled=true sets the disabled DOM property" <|
            \_ ->
                Menu.item { label = "X", action = Menu.Click "X" }
                    [ Menu.itemDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled emits false by default on item" <|
            \_ ->
                plainItem
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")

        -- Checkbox item
        , test "checkboxItem renders <m3e-menu-item-checkbox>" <|
            \_ ->
                checkedItem False
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu-item-checkbox")
        , test "checkboxChecked=true sets the checked DOM property" <|
            \_ ->
                checkedItem True
                    |> Element.toNode
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "checkboxChecked=false sets the checked DOM property" <|
            \_ ->
                checkedItem False
                    |> Element.toNode
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "checkboxDisabled=true sets the disabled DOM property" <|
            \_ ->
                Menu.checkboxItem { label = "X", onChange = identity }
                    [ Menu.checkboxDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")

        -- Radio item
        , test "radioItem renders <m3e-menu-item-radio>" <|
            \_ ->
                radioItem_ False
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu-item-radio")
        , test "radioSelected=true sets the checked DOM property" <|
            \_ ->
                radioItem_ True
                    |> Element.toNode
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "radioSelected=false sets the checked DOM property" <|
            \_ ->
                radioItem_ False
                    |> Element.toNode
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")

        -- Divider
        , test "divider renders <m3e-divider>" <|
            \_ ->
                Menu.divider
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-divider")

        -- Group
        , test "group renders <m3e-menu-item-group>" <|
            \_ ->
                Menu.group { label = "Section", items = [] }
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu-item-group")
        , test "group label child has slot='label'" <|
            \_ ->
                Menu.group { label = "Section", items = [] }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "label")
        , test "group items appear after the label child" <|
            \_ ->
                Menu.group { label = "Section", items = [ Menu.divider ] }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2

        -- Trigger
        , test "triggerFor renders <m3e-menu-trigger>" <|
            \_ ->
                Menu.triggerFor "my-menu"
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-menu-trigger")
        , test "triggerFor sets the 'for' attribute" <|
            \_ ->
                Menu.triggerFor "my-menu"
                    |> Element.toNode
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-menu")
        ]
