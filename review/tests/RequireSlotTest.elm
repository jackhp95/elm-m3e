module RequireSlotTest exposing (all)

import RequireSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


{-| A component whose default slot is BOTH required and repeatable (required-multi): the
type system can't enforce it, so the rule must. -}
facts : List { component : String, module_ : String, enums : List ( String, List String ), requiredSlots : List String, multiSlots : List String }
facts =
    [ { component = "grid"
      , module_ = "M3e.Grid"
      , enums = []
      , requiredSlots = [ "default" ]
      , multiSlots = [ "default" ]
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
        ]
