module PreferSpecificSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
import PreferSpecificSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = []
      , multiSlots = []
      , attrRewrites = [ ( "variant", "variant" ), ( "shapeAttr", "shape" ) ]
      , slotRewrites = [ ( "unnamed", "child" ), ( "icon", "icon" ) ]
      , surfaces = [ Standard, Record ]
      , requiredAttrs = []
      , actionMap = []
      }
    ]


all : Test
all =
    describe "PreferSpecificSlot"
        [ describe "attr case"
            [ test "rewrites M3e.variant to M3e.Button.variant" <|
                \() ->
                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.variant filled ] []
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`variant` can be replaced with the per-component setter `M3e.Button.variant` for tighter type safety"
                                , details =
                                    [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                    ]
                                , under = "M3e.variant"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant filled ] []
"""
                            ]
            , test "rewrites shape-collision-suffixed name" <|
                \() ->
                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.shapeAttr rounded ] []
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`shapeAttr` can be replaced with the per-component setter `M3e.Button.shape` for tighter type safety"
                                , details =
                                    [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                    ]
                                , under = "M3e.shapeAttr"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.shape rounded ] []
"""
                            ]
            ]
        , describe "slot case"
            [ test "rewrites M3e.Content.slot to per-component setter" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Content
v = M3e.Button.view [] [ M3e.Content.slot "icon" someIcon ]
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`.slot \"icon\"` can be replaced with the typed setter `M3e.Button.icon`"
                                , details =
                                    [ "The typed setter enforces the slot's kinds at compile time."
                                    ]
                                , under = "M3e.Content.slot \"icon\" someIcon"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
import M3e.Content
v = M3e.Button.view [] [ M3e.Button.icon (someIcon) ]
"""
                            ]
            , test "wraps multi-arg application body in parens" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Content
import M3e.Icon
v = M3e.Button.view [] [ M3e.Content.slot "icon" (M3e.Icon.view [] []) ]
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`.slot \"icon\"` can be replaced with the typed setter `M3e.Button.icon`"
                                , details =
                                    [ "The typed setter enforces the slot's kinds at compile time."
                                    ]
                                , under = "M3e.Content.slot \"icon\" (M3e.Icon.view [] [])"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
import M3e.Content
import M3e.Icon
v = M3e.Button.view [] [ M3e.Button.icon ((M3e.Icon.view [] [])) ]
"""
                            ]
            ]
        , test "rewrites barrel attr in Record call" <|
            \() ->
                """module A exposing (v)
import M3e
import M3e.Button
import M3e.Record.Button
v = M3e.Record.Button.view {} [ M3e.variant filled ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`variant` can be replaced with the per-component setter `M3e.Button.variant` for tighter type safety"
                            , details =
                                [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                ]
                            , under = "M3e.variant"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (v)
import M3e
import M3e.Button
import M3e.Record.Button
v = M3e.Record.Button.view {} [ M3e.Button.variant filled ] []
"""
                        ]
        , test "inserts missing import M3e.Button when only M3e is imported" <|
            \() ->
                """module A exposing (v)
import M3e
v = M3e.Button.view [ M3e.variant filled ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`variant` can be replaced with the per-component setter `M3e.Button.variant` for tighter type safety"
                            , details =
                                [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                ]
                            , under = "M3e.variant"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant filled ] []
"""
                        ]
        , test "no-op when already using per-component setter" <|
            \() ->
                """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant filled ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "flags barrel attr in let-bound attrs list" <|
            \() ->
                """module A exposing (v)
import M3e
import M3e.Button
v =
    let
        attrs = [ M3e.variant filled ]
    in
    M3e.Button.view attrs []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`variant` can be replaced with the per-component setter `M3e.Button.variant` for tighter type safety"
                            , details =
                                [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                ]
                            , under = "M3e.variant"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (v)
import M3e
import M3e.Button
v =
    let
        attrs = [ M3e.Button.variant filled ]
    in
    M3e.Button.view attrs []
"""
                        ]
        ]
