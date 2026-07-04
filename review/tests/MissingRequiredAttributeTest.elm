module MissingRequiredAttributeTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
import MissingRequiredAttribute exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


iconButtonFacts : List Facts.Fact
iconButtonFacts =
    [ { component = "iconButton"
      , module_ = "M3e.IconButton"
      , enums = []
      , requiredSlots = [ "unnamed" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = [ ( "unnamed", "child" ) ]
      , shapes = [ Shape3, Shape4 ]
      , requiredAttrs = [ "aria-label" ]
      }
    ]


all : Test
all =
    describe "MissingRequiredAttribute"
        [ test "flags Shape3 call missing aria-label" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v = M3e.IconButton.view [] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `iconButton` requires attribute `aria-label` but this call doesn't provide it"
                            , details =
                                [ "The Material 3 spec (and accessibility guidance) treats `aria-label` as required for iconButton."
                                , "Add `M3e.Aria.label \"...\"` to the attrs list."
                                ]
                            , under = "M3e.IconButton.view"
                            }
                        ]
        , test "accepts Shape3 call with M3e.Aria.label" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
import M3e.Aria
v = M3e.IconButton.view [ M3e.Aria.label "Close" ] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "accepts raw M3e.Cem.Attr.attribute escape hatch" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
import M3e.Cem.Attr
v = M3e.IconButton.view [ M3e.Cem.Attr.attribute "aria-label" "Close" ] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "flags Shape4 call missing aria-label" <|
            \() ->
                """module A exposing (v)
import M3e.Record.IconButton
v = M3e.Record.IconButton.view { content = a } [] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `iconButton` requires attribute `aria-label` but this call doesn't provide it"
                            , details =
                                [ "The Material 3 spec (and accessibility guidance) treats `aria-label` as required for iconButton."
                                , "Add `M3e.Aria.label \"...\"` to the attrs list."
                                ]
                            , under = "M3e.Record.IconButton.view"
                            }
                        ]
        , test "silent when attrs list is unresolved" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v = M3e.IconButton.view dynamicAttrs []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "no-op on component with no requiredAttrs" <|
            \() ->
                """module A exposing (v)
import M3e.Card
v = M3e.Card.view [] []
"""
                    |> Review.Test.run
                        (rule [ { component = "card", module_ = "M3e.Card", enums = [], requiredSlots = [], multiSlots = [], attrRewrites = [], slotRewrites = [], shapes = [ Shape3 ], requiredAttrs = [] } ])
                    |> Review.Test.expectNoErrors
        ]
