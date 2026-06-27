module M3e.SplitButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.SplitButton as SplitButton
import Test exposing (Test, describe, test)


req :
    { label : String
    , name : String
    , trailingContent : List (Element { icon : Element.Supported, element : Element.Supported } ())
    , onPrimaryClick : ()
    , onTriggerClick : ()
    }
req =
    { label = "Save"
    , name = "More actions"
    , trailingContent =
        [ Element.fromNode (Node.element "m3e-icon" [ Node.attribute "name" "expand_more" ] []) ]
    , onPrimaryClick = ()
    , onTriggerClick = ()
    }


node : List (SplitButton.Option ()) -> Node ()
node opts =
    SplitButton.view req opts |> Element.toNode


{-| Find a child by its slot attribute.
-}
childWithSlot : String -> Node msg -> Maybe (Node msg)
childWithSlot slotName n =
    Node.childrenOf n
        |> List.filter (\c -> Node.findAttribute "slot" c == Just slotName)
        |> List.head


suite : Test
suite =
    describe "M3e.SplitButton — view-style port + Bug Fix #16"
        [ test "renders <m3e-split-button>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-split-button")
        , test "BUG FIX #16: leading-button slot child is <m3e-button>, NOT <button>" <|
            \_ ->
                node []
                    |> childWithSlot "leading-button"
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-button")
        , test "BUG FIX #16: trailing-button slot child is <m3e-icon-button>, NOT <button>" <|
            \_ ->
                node []
                    |> childWithSlot "trailing-button"
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon-button")
        , test "leading button carries the label as text child" <|
            \_ ->
                node []
                    |> childWithSlot "leading-button"
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen
                        (\children ->
                            children
                                |> List.filterMap
                                    (\c ->
                                        case c of
                                            Node.Text s ->
                                                Just s

                                            _ ->
                                                Nothing
                                    )
                                |> List.head
                        )
                    |> Expect.equal (Just "Save")
        , test "trailing icon-button carries aria-label from name" <|
            \_ ->
                node []
                    |> childWithSlot "trailing-button"
                    |> Maybe.andThen (Node.findAttribute "aria-label")
                    |> Expect.equal (Just "More actions")
        , test "disabled propagates to leading m3e-button as DOM property" <|
            \_ ->
                node [ SplitButton.disabled True ]
                    |> childWithSlot "leading-button"
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled propagates to trailing m3e-icon-button as DOM property" <|
            \_ ->
                node [ SplitButton.disabled True ]
                    |> childWithSlot "trailing-button"
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "variant option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ SplitButton.variant SplitButton.Outlined ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-split-button")

        -- Fix #63 — trailingContent is a typed slot input
        , test "fix-#63: trailingContent is rendered inside the trailing m3e-icon-button" <|
            \_ ->
                node []
                    |> childWithSlot "trailing-button"
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon")
        , test "fix-#63: multiple trailingContent elements are all rendered" <|
            \_ ->
                SplitButton.view
                    { label = "Save"
                    , name = "More options"
                    , trailingContent =
                        [ Element.fromNode (Node.element "m3e-icon" [ Node.attribute "name" "expand_more" ] [])
                        , Element.fromNode (Node.element "m3e-menu-trigger" [ Node.attribute "for" "my-menu" ] [])
                        ]
                    , onPrimaryClick = ()
                    , onTriggerClick = ()
                    }
                    []
                    |> Element.toNode
                    |> childWithSlot "trailing-button"
                    |> Maybe.map Node.childrenOf
                    |> Maybe.map List.length
                    |> Expect.equal (Just 2)
        ]
