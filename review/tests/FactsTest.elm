module FactsTest exposing (all)

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Review.Test
import Test exposing (Test, describe, test)


{-| A minimal rule that flags any top-layer call site it recognises via
`Facts.callSite`. Used only in tests to verify `callSite`'s classification.
-}
probeRule : Rule
probeRule =
    Rule.newModuleRuleSchemaUsingContextCreator "FactsProbe" initContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable }


initContext : Rule.ContextCreator () Context
initContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup })
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: _) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    ( [ Rule.error
                            { message =
                                "probe: " ++ site.noun ++ " " ++ shapeLabel site.shape
                            , details = [ "used only for tests" ]
                            }
                            (Node.range fnNode)
                      ]
                    , context
                    )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


shapeLabel : Shape -> String
shapeLabel s =
    case s of
        Shape3 ->
            "Shape3"

        Shape4 ->
            "Shape4"


all : Test
all =
    describe "Facts"
        [ describe "callSite"
            [ test "recognises M3e.Button.view as button/Shape3" <|
                \_ ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape3"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Button.view"
                                }
                            ]
            , test "recognises M3e.Record.Button.view as button/Shape4" <|
                \_ ->
                    """module A exposing (v)
import M3e.Record.Button
v = M3e.Record.Button.view {} [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape4"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Record.Button.view"
                                }
                            ]
            , test "recognises M3e.button (barrel) as button/Shape3" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape3"
                                , details = [ "used only for tests" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "recognises M3e.Record.button (Shape4 barrel)" <|
                \_ ->
                    """module A exposing (v)
import M3e.Record
v = M3e.Record.button {} [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape4"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Record.button"
                                }
                            ]
            , test "returns Nothing for M3e.Cem.Button (middle layer)" <|
                \_ ->
                    """module A exposing (v)
import M3e.Cem.Button
v = M3e.Cem.Button.button [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectNoErrors
            ]
        ]
