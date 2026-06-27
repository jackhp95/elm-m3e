module M3e.ChipSetTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import M3e.Chip as Chip
import M3e.ChipSet as ChipSet
import M3e.Node as Node
import M3e.Renderable as Renderable


suite : Test
suite =
    describe "M3e.ChipSet — expanded surface"
        [ test "view renders m3e-chip-set with role=group" <|
            \_ ->
                ChipSet.view []
                    |> Renderable.toNode
                    |> (\n -> ( Node.tagOf n, Node.findAttribute "role" n ))
                    |> Expect.equal ( Just "m3e-chip-set", Just "group" )
        , test "chips option populates children" <|
            \_ ->
                ChipSet.view
                    [ ChipSet.chips [ Chip.view { label = "A" } [], Chip.view { label = "B" } [] ] ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "filterSet renders m3e-filter-chip-set" <|
            \_ ->
                ChipSet.filterSet { label = "Filters" } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-filter-chip-set")
        , test "filterSet has role=group and aria-label" <|
            \_ ->
                ChipSet.filterSet { label = "Status filters" } []
                    |> Renderable.toNode
                    |> (\n ->
                            ( Node.findAttribute "role" n
                            , Node.findAttribute "aria-label" n
                            )
                       )
                    |> Expect.equal ( Just "group", Just "Status filters" )
        , test "inputSet renders m3e-input-chip-set" <|
            \_ ->
                ChipSet.inputSet { label = "Tags" } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-input-chip-set")
        , test "ariaLabel sets aria-label on generic set" <|
            \_ ->
                ChipSet.view [ ChipSet.ariaLabel "Quick actions" ]
                    |> Renderable.toNode
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
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
