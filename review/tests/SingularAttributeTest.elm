module SingularAttributeTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
import Review.Test
import SingularAttribute exposing (rule)
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = []
      , multiSlots = []
      , attrRewrites = [ ( "variant", "variant" ), ( "disabled", "disabled" ) ]
      , slotRewrites = []
      , slotUpgrades = []
      , surfaces = [ Standard, Record ]
      , requiredAttrs = []
      , actionMap = []
      , usesAction = False
      }
    ]


all : Test
all =
    describe "SingularAttribute"
        [ test "flags a duplicated attribute setter" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant a, M3e.Button.variant b ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Attribute `variant` is set more than once on this call"
                            , details =
                                [ "HTML allows only one value per attribute; the browser will silently keep one and discard the others."
                                , "Merge or delete the extras."
                                ]
                            , under = "M3e.Button.variant"
                            }
                            |> Review.Test.atExactly { start = { row = 3, column = 23 }, end = { row = 3, column = 41 } }
                        ]
        , test "accepts distinct attributes" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant a, M3e.Button.disabled True ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent on unresolved attrs list" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view dynamicAttrs []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "flags duplicate attribute in Record call" <|
            \() ->
                """module A exposing (v)
import M3e.Record.Button
import M3e.Button
v = M3e.Record.Button.view {} [ M3e.Button.variant a, M3e.Button.variant b ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Attribute `variant` is set more than once on this call"
                            , details =
                                [ "HTML allows only one value per attribute; the browser will silently keep one and discard the others."
                                , "Merge or delete the extras."
                                ]
                            , under = "M3e.Button.variant"
                            }
                            |> Review.Test.atExactly { start = { row = 4, column = 33 }, end = { row = 4, column = 51 } }
                        ]
        ]
