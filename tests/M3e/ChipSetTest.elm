module M3e.ChipSetTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import M3e.Chip as Chip
import M3e.ChipSet as ChipSet
import M3e.Node as Node


suite : Test
suite =
    describe "M3e.ChipSet — expanded surface"
        [ test "new renders m3e-chip-set with role=group" <|
            \_ ->
                ChipSet.new
                    |> ChipSet.toNode
                    |> (\n -> ( Node.tagOf n, Node.findAttribute "role" n ))
                    |> Expect.equal ( Just "m3e-chip-set", Just "group" )
        , test "withChips (existing) populates children" <|
            \_ ->
                ChipSet.new
                    |> ChipSet.withChips [ Chip.view { label = "A" } [], Chip.view { label = "B" } [] ]
                    |> ChipSet.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "filterSet renders m3e-filter-chip-set" <|
            \_ ->
                ChipSet.filterSet "Filters"
                    |> ChipSet.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-filter-chip-set")
        , test "filterSet has role=group and aria-label" <|
            \_ ->
                ChipSet.filterSet "Status filters"
                    |> ChipSet.toNode
                    |> (\n ->
                            ( Node.findAttribute "role" n
                            , Node.findAttribute "aria-label" n
                            )
                       )
                    |> Expect.equal ( Just "group", Just "Status filters" )
        , test "inputSet renders m3e-input-chip-set" <|
            \_ ->
                ChipSet.inputSet "Tags"
                    |> ChipSet.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-input-chip-set")
        , test "withAriaLabel sets aria-label on generic set" <|
            \_ ->
                ChipSet.new
                    |> ChipSet.withAriaLabel "Quick actions"
                    |> ChipSet.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Quick actions")
        , test "filterSet withChips populates filter chips" <|
            \_ ->
                ChipSet.filterSet "Filters"
                    |> ChipSet.withChips
                        [ Chip.filter { label = "Active", onToggle = () } []
                        , Chip.filter { label = "Pending", onToggle = () } []
                        ]
                    |> ChipSet.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
