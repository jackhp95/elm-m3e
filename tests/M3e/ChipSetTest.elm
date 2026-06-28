module M3e.ChipSetTest exposing (suite)

import Expect
import M3e.Chip as Chip
import M3e.ChipSet as ChipSet
import M3e.Element as Element
import M3e.Node as Node exposing (Attr(..), Node(..))
import Test exposing (Test, describe, test)


{-| Count RawAttr (opaque event listeners) on a node.
-}
countRawAttrs : Node msg -> Int
countRawAttrs n =
    case n of
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
    describe "M3e.ChipSet — expanded surface"
        [ test "view renders m3e-chip-set with role=group" <|
            \_ ->
                ChipSet.view []
                    |> Element.toNode
                    |> (\n -> ( Node.tagOf n, Node.findAttribute "role" n ))
                    |> Expect.equal ( Just "m3e-chip-set", Just "group" )
        , test "chips option populates children" <|
            \_ ->
                ChipSet.view
                    [ ChipSet.chips [ Chip.view { label = "A" } [], Chip.view { label = "B" } [] ] ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "filterSet renders m3e-filter-chip-set" <|
            \_ ->
                ChipSet.filterSet { label = "Filters" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-filter-chip-set")
        , test "filterSet has role=group and aria-label" <|
            \_ ->
                ChipSet.filterSet { label = "Status filters" } []
                    |> Element.toNode
                    |> (\n ->
                            ( Node.findAttribute "role" n
                            , Node.findAttribute "aria-label" n
                            )
                       )
                    |> Expect.equal ( Just "group", Just "Status filters" )
        , test "inputSet renders m3e-input-chip-set" <|
            \_ ->
                ChipSet.inputSet { label = "Tags" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-input-chip-set")
        , test "ariaLabel sets aria-label on generic set" <|
            \_ ->
                ChipSet.view [ ChipSet.ariaLabel "Quick actions" ]
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Quick actions")
        , test "filterSet chips populates filter chips" <|
            \_ ->
                ChipSet.filterSet { label = "Filters" }
                    [ ChipSet.chips
                        [ Chip.filter { label = "Active", onToggle = () } []
                        , Chip.filter { label = "Pending", onToggle = () } []
                        ]
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "filterSet onChange wires a 'change' listener on the filter set" <|
            \_ ->
                -- Without onChange the element has 0 RawAttrs; with it, 1+.
                let
                    withoutHandler : Int
                    withoutHandler =
                        ChipSet.filterSet { label = "F" } []
                            |> Element.toNode
                            |> countRawAttrs

                    withHandler : Int
                    withHandler =
                        ChipSet.filterSet { label = "F" } [ ChipSet.onChange identity ]
                            |> Element.toNode
                            |> countRawAttrs
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        , test "filterSet onInput wires a 'input' listener on the filter set" <|
            \_ ->
                let
                    withoutHandler : Int
                    withoutHandler =
                        ChipSet.filterSet { label = "F" } []
                            |> Element.toNode
                            |> countRawAttrs

                    withHandler : Int
                    withHandler =
                        ChipSet.filterSet { label = "F" } [ ChipSet.onInput identity ]
                            |> Element.toNode
                            |> countRawAttrs
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        , test "filterSet onChange and onInput produce independent listeners" <|
            \_ ->
                ChipSet.filterSet { label = "F" }
                    [ ChipSet.onChange identity
                    , ChipSet.onInput identity
                    ]
                    |> Element.toNode
                    |> countRawAttrs
                    |> Expect.equal 2
        , test "inputSet onChipsChange wires a 'change' listener on the input set" <|
            \_ ->
                let
                    withoutHandler : Int
                    withoutHandler =
                        ChipSet.inputSet { label = "Tags" } []
                            |> Element.toNode
                            |> countRawAttrs

                    withHandler : Int
                    withHandler =
                        ChipSet.inputSet { label = "Tags" }
                            [ ChipSet.onChipsChange (\_ -> ()) ]
                            |> Element.toNode
                            |> countRawAttrs
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        ]
