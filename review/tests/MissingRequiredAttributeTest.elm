module MissingRequiredAttributeTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
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
      , surfaces = [ Standard, Record ]
      , requiredAttrs = [ "aria-label" ]
      }
    ]


fabFacts : List Facts.Fact
fabFacts =
    [ { component = "fab"
      , module_ = "M3e.Fab"
      , enums = []
      , requiredSlots = [ "unnamed" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = [ ( "unnamed", "child" ), ( "label", "label" ), ( "close-icon", "closeIcon" ) ]
      , surfaces = [ Standard, Record ]
      , requiredAttrs = [ "aria-label" ]
      }
    ]


all : Test
all =
    describe "MissingRequiredAttribute"
        [ test "flags Standard call missing aria-label" <|
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
        , test "accepts Standard call with M3e.Aria.label" <|
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
        , test "flags Record call missing aria-label" <|
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
                        (rule [ { component = "card", module_ = "M3e.Card", enums = [], requiredSlots = [], multiSlots = [], attrRewrites = [], slotRewrites = [], surfaces = [ Standard ], requiredAttrs = [] } ])
                    |> Review.Test.expectNoErrors
        , test "flags call whose attrs is a let-bound empty list" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v =
    let
        attrs = []
    in
    M3e.IconButton.view attrs []
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
        , test "scope reset: second declaration does not inherit let-bindings of first" <|
            \() ->
                """module A exposing (v1, v2)
import M3e.IconButton
import M3e.Aria
v1 =
    let
        attrs = [ M3e.Aria.label "Close" ]
    in
    M3e.IconButton.view attrs []
v2 =
    let
        attrs = []
    in
    M3e.IconButton.view attrs []
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
                            |> Review.Test.atExactly { start = { row = 13, column = 5 }, end = { row = 13, column = 24 } }
                        ]
        , test "Fab with label slot filled does not flag aria-label" <|
            \() ->
                """module A exposing (v)
import M3e.Fab
v = M3e.Fab.view [] [ M3e.Fab.label [ M3e.Fab.child icon ] ]
"""
                    |> Review.Test.run (rule fabFacts)
                    |> Review.Test.expectNoErrors
        , test "IconButton (no label slot) still requires aria-label even with content" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v = M3e.IconButton.view [] [ M3e.IconButton.child icon ]
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
        ]
