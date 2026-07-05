module MissingRequiredSingularSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
import MissingRequiredSingularSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = [ "unnamed" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = [ ( "unnamed", "child" ) ]
      , surfaces = [ Standard, Record ]
      , requiredAttrs = []
      }
    ]


all : Test
all =
    describe "MissingRequiredSingularSlot"
        [ test "flags Standard call missing required-singular slot" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `button` requires content slot `unnamed` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e.Button.child <value>` to the content list, or use `M3e.Record.Button.view` which enforces this at the type level."
                                ]
                            , under = "M3e.Button.view"
                            }
                        ]
        , test "accepts Standard call with child" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] [ M3e.Button.child a ]
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent on Record call (record is compile-time enforced)" <|
            \() ->
                """module A exposing (v)
import M3e.Record.Button
v = M3e.Record.Button.view { content = a } [] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent when content list is unresolved" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] dynamicContent
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "flags call whose content is a let-bound empty list" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v =
    let
        content = []
    in
    M3e.Button.view [] content
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `button` requires content slot `unnamed` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e.Button.child <value>` to the content list, or use `M3e.Record.Button.view` which enforces this at the type level."
                                ]
                            , under = "M3e.Button.view"
                            }
                        ]
        , test "scope reset: second declaration does not inherit let-bindings of first" <|
            \() ->
                """module A exposing (v1, v2)
import M3e.Button
v1 =
    let
        content = [ M3e.Button.child someText ]
    in
    M3e.Button.view [] content
v2 =
    let
        content = []
    in
    M3e.Button.view [] content
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `button` requires content slot `unnamed` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e.Button.child <value>` to the content list, or use `M3e.Record.Button.view` which enforces this at the type level."
                                ]
                            , under = "M3e.Button.view"
                            }
                            |> Review.Test.atExactly { start = { row = 12, column = 5 }, end = { row = 12, column = 20 } }
                        ]
        ]
