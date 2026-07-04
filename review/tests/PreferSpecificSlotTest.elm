module PreferSpecificSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
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
      , shapes = [ Shape3 ]
      , requiredAttrs = []
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
            [ test "rewrites M3e.Cem.Attr.slot to per-component setter" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Cem.Attr
v = M3e.Button.view [] [ M3e.Cem.Attr.slot "icon" someIcon ]
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`.slot \"icon\"` can be replaced with the typed setter `M3e.Button.icon`"
                                , details =
                                    [ "The typed setter enforces the slot's kinds at compile time."
                                    ]
                                , under = "M3e.Cem.Attr.slot \"icon\" someIcon"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
import M3e.Cem.Attr
v = M3e.Button.view [] [ M3e.Button.icon someIcon ]
"""
                            ]
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
        ]
