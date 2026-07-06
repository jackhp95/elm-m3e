module RequireSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
import RequireSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


{-| A component whose default slot is BOTH required and repeatable (required-multi): the
type system can't enforce it, so the rule must.
-}
facts : List Facts.Fact
facts =
    [ { component = "grid"
      , module_ = "M3e.Grid"
      , enums = []
      , requiredSlots = [ "default" ]
      , multiSlots = [ "default" ]
      , attrRewrites = []
      , slotRewrites = []
      , surfaces = [ Standard ]
      , requiredAttrs = []
      , actionMap = []
      }
    ]


shape4Facts : List Facts.Fact
shape4Facts =
    [ { component = "grid"
      , module_ = "M3e.Record.Grid"
      , enums = []
      , requiredSlots = [ "default" ]
      , multiSlots = [ "default" ]
      , attrRewrites = []
      , slotRewrites = []
      , surfaces = [ Standard, Record ]
      , requiredAttrs = []
      , actionMap = []
      }
    ]


{-| A component whose default slot is required but NOT repeatable (required-singular):
the constructor's required record already type-enforces it, so this rule intentionally
skips it — `buildIndex` intersects requiredSlots with multiSlots, leaving nothing here.
-}
requiredSingularFacts : List Facts.Fact
requiredSingularFacts =
    [ { component = "grid"
      , module_ = "M3e.Grid"
      , enums = []
      , requiredSlots = [ "default" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = []
      , surfaces = [ Standard ]
      , requiredAttrs = []
      , actionMap = []
      }
    ]


all : Test
all =
    describe "RequireSlot"
        [ test "flags a required-multi slot with an empty content list" <|
            \() ->
                """module A exposing (v)

import M3e exposing (grid)

v =
    grid [] []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Required slot `child` is not filled"
                            , details =
                                [ "This component needs at least one `child` in its content list, but none is present."
                                , "This is a repeatable required slot, so the type system doesn't enforce it — add the missing content."
                                ]
                            , under = "grid"
                            }
                            |> Review.Test.atExactly { start = { row = 6, column = 5 }, end = { row = 6, column = 9 } }
                        ]
        , test "accepts a filled required slot" <|
            \() ->
                """module A exposing (v)

import M3e exposing (grid, child)

v =
    grid [] [ child a ]
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectNoErrors
        , test "stays silent when content is built dynamically (List.map)" <|
            \() ->
                """module A exposing (v)

import M3e exposing (grid, child)

v =
    grid [] (List.map child items)
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectNoErrors
        , test "flags a required-multi slot omission at Record call site" <|
            \() ->
                """module A exposing (v)

import M3e.Record.Grid

v =
    M3e.Record.Grid.view {} [] []
"""
                    |> Review.Test.run (rule shape4Facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Required slot `child` is not filled"
                            , details =
                                [ "This component needs at least one `child` in its content list, but none is present."
                                , "This is a repeatable required slot, so the type system doesn't enforce it — add the missing content."
                                ]
                            , under = "M3e.Record.Grid.view"
                            }
                        ]
        , test "accepts a filled required-multi slot at Record call site" <|
            \() ->
                """module A exposing (v)

import M3e.Record.Grid
import M3e exposing (child)

v =
    M3e.Record.Grid.view {} [] [ child a ]
"""
                    |> Review.Test.run (rule shape4Facts)
                    |> Review.Test.expectNoErrors
        , test "traces through List.map at a Record call site and stays silent" <|
            \() ->
                """module A exposing (v)

import M3e.Record.Grid
import M3e exposing (child)

v =
    M3e.Record.Grid.view {} [] (List.map child items)
"""
                    |> Review.Test.run (rule shape4Facts)
                    |> Review.Test.expectNoErrors
        , test "does not flag a required slot that is not multi (type-enforced elsewhere)" <|
            \() ->
                -- required-singular: the constructor's required record already enforces
                -- presence, so this rule stays silent even with an empty content list.
                """module A exposing (v)

import M3e exposing (grid)

v =
    grid [] []
"""
                    |> Review.Test.run (rule requiredSingularFacts)
                    |> Review.Test.expectNoErrors
        , test "stays silent for a partially-applied constructor (not enough args)" <|
            \() ->
                -- `grid []` is not fully applied (no content list yet); the rule only
                -- checks calls with the content argument present (>= 2 args).
                """module A exposing (v)

import M3e exposing (grid)

v =
    grid []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectNoErrors
        ]
