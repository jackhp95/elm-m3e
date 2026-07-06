module PreferBarrelTest exposing (all)

import M3e.Review.Facts as Facts exposing (Surface(..))
import PreferBarrel exposing (rule, ruleWith)
import Review.Test
import Set
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = [ ( "variant", [ "elevated", "filled", "tonal" ] ) ]
      , requiredSlots = []
      , multiSlots = []
      , attrRewrites = [ ( "attrDisabled", "disabled" ), ( "shapeAttr", "shape" ) ]
      , slotRewrites = [ ( "unnamed", "child" ), ( "icon", "icon" ) ]
      , slotUpgrades = [ ( "slotDefault", "buttonSlotDefault" ), ( "slotIcon", "buttonSlotIcon" ) ]
      , surfaces = [ Standard, Record ]
      , requiredAttrs = []
      , actionMap = []
      , usesAction = False
      }
    ]


all : Test
all =
    describe "PreferBarrel"
        [ describe "constructor class"
            [ test "rewrites M3e.Button.view to M3e.button" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] []
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Button.view` can be flattened to the barrel constructor `M3e.button`"
                                , details = detailsFor "constructor"
                                , under = "M3e.Button.view"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
v = M3e.button [] []
"""
                            ]
            ]
        , describe "scalar attribute class"
            [ test "rewrites a scalar per-component setter to its `attr`-prefixed barrel name" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.disabled True
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Button.disabled` can be flattened to the barrel attribute setter `M3e.attrDisabled`"
                                , details = detailsFor "attribute setter"
                                , under = "M3e.Button.disabled"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
v = M3e.attrDisabled True
"""
                            ]
            , test "rewrites collision-suffixed barrel name (shape -> shapeAttr)" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.shape rounded
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Button.shape` can be flattened to the barrel attribute setter `M3e.shapeAttr`"
                                , details = detailsFor "attribute setter"
                                , under = "M3e.Button.shape"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
v = M3e.shapeAttr rounded
"""
                            ]
            ]
        , describe "enum value class (portmanteau collapse)"
            [ test "collapses `M3e.<Comp>.<enumAttr> M3e.Value.<lit>` to the `M3e.<attr><Value>` portmanteau" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Value
v = M3e.Button.variant M3e.Value.filled
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Button.variant M3e.Value.filled` can be flattened to the barrel enum value `M3e.variantFilled`"
                                , details = detailsFor "enum value"
                                , under = "M3e.Button.variant M3e.Value.filled"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
import M3e.Value
v = M3e.variantFilled
"""
                            ]
            , test "leaves a DYNAMIC enum arg per-component (no static value to fold)" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.variant chosen
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectNoErrors
            , test "leaves an enum applied to a NON-listed token per-component" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Value
v = M3e.Button.variant M3e.Value.bogus
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectNoErrors
            ]
        , describe "slot class"
            [ test "rewrites per-component slot setter to generalized barrel slot" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.child body
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Button.child` can be flattened to the barrel slot setter `M3e.slotDefault`"
                                , details = detailsFor "slot setter"
                                , under = "M3e.Button.child"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
v = M3e.slotDefault body
"""
                            ]
            ]
        , describe "value token class"
            [ test "rewrites re-exposed M3e.Value token to barrel token" <|
                \() ->
                    """module A exposing (v)
import M3e.Value
v = M3e.Value.rounded
"""
                        |> Review.Test.run (ruleWith (Set.fromList [ "rounded" ]) buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Value.rounded` can be flattened to the barrel value token `M3e.rounded`"
                                , details = detailsFor "value token"
                                , under = "M3e.Value.rounded"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Value
v = M3e.rounded
"""
                            ]
            , test "leaves non-re-exposed M3e.Value token alone (default rule)" <|
                \() ->
                    """module A exposing (v)
import M3e.Value
v = M3e.Value.elevated
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectNoErrors
            ]
        , describe "universal aria class"
            [ test "rewrites a universal M3e.Aria setter to its flat `aria*` barrel name" <|
                \() ->
                    """module A exposing (v)
import M3e.Aria
v = M3e.Aria.label "Back"
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`M3e.Aria.label` can be flattened to the barrel aria setter `M3e.ariaLabel`"
                                , details = detailsFor "aria setter"
                                , under = "M3e.Aria.label"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Aria
v = M3e.ariaLabel "Back"
"""
                            ]
            ]
        , describe "scope discipline"
            [ test "never touches the Cem / Record / Build surfaces" <|
                \() ->
                    """module A exposing (v)
import M3e.Cem.Button
import M3e.Record.Button
import M3e.Build.Button
v =
    ( M3e.Cem.Button.view [] []
    , M3e.Record.Button.view {} [] []
    , M3e.Build.Button.button
    )
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectNoErrors
            , test "no-op when already barrel-first" <|
                \() ->
                    """module A exposing (v)
import M3e
v = M3e.button [ M3e.variantFilled, M3e.attrDisabled True ] [ M3e.slotDefault body ]
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectNoErrors
            ]
        ]


detailsFor : String -> List String
detailsFor kind =
    [ "The `M3e` barrel re-exports this "
        ++ kind
        ++ " so a single `import M3e` covers the whole example. The per-component surface stays available for callers who want the tighter type."
    ]
