module FactsTest exposing (all)

import Dict
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Expect
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
    Rule.newModuleRuleSchemaUsingContextCreator "FactsProbe" initBasicContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias BasicContext =
    { lookup : ModuleNameLookupTable }


initBasicContext : Rule.ContextCreator () BasicContext
initBasicContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup })
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> BasicContext -> ( List (Error {}), BasicContext )
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


{-| Probe rule that inspects the second argument of `M3e.button` via
`Facts.tracedList` and reports `known:N unresolved:B`. Used to verify
`tracedList` classifications.
-}
probeContentRule : Rule
probeContentRule =
    Rule.newModuleRuleSchemaUsingContextCreator "TracedListProbe" initContext
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
        |> Rule.withExpressionEnterVisitor tracedListVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , scope : Dict.Dict String (Node Expression)
    }


initContext : Rule.ContextCreator () Context
initContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup, scope = Dict.empty })
        |> Rule.withModuleNameLookupTable


declarationEnterVisitor : Node Declaration.Declaration -> Context -> ( List (Error {}), Context )
declarationEnterVisitor node context =
    case Node.value node of
        Declaration.FunctionDeclaration { declaration } ->
            case Node.value (Node.value declaration).expression of
                Expression.LetExpression { declarations } ->
                    let
                        scope =
                            List.foldl
                                (\dec acc ->
                                    case Node.value dec of
                                        Expression.LetFunction fn ->
                                            let
                                                fnDecl =
                                                    Node.value fn.declaration

                                                name =
                                                    Node.value fnDecl.name
                                            in
                                            Dict.insert name fnDecl.expression acc

                                        _ ->
                                            acc
                                )
                                context.scope
                                declarations
                    in
                    ( [], { context | scope = scope } )

                _ ->
                    ( [], context )

        _ ->
            ( [], context )


tracedListVisitor : Node Expression -> Context -> ( List (Error {}), Context )
tracedListVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case ( Facts.callSite context.lookup fnNode, List.reverse args ) of
                ( Just site, last :: _ ) ->
                    if site.noun /= "button" then
                        ( [], context )

                    else
                        let
                            traced =
                                Facts.tracedList context.lookup context.scope last
                        in
                        ( [ Rule.error
                                { message =
                                    "known:"
                                        ++ String.fromInt (List.length traced.known)
                                        ++ " unresolved:"
                                        ++ (if traced.unresolved then
                                                "True"

                                            else
                                                "False"
                                           )
                                , details = [ "probe" ]
                                }
                                (Node.range fnNode)
                          ]
                        , context
                        )

                _ ->
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
        [ describe "tracedList (Medium)"
            [ test "two-literal concat" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] ([ M3e.child a ] ++ [ M3e.child b ])
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:False"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "partial concat — literal left, dynamic right" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] ([ M3e.child a ] ++ tail)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "bare variable resolves to its let binding" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    let
        content = [ M3e.child a, M3e.child b ]
    in
    M3e.button [] content
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:False"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            ]
        , describe "tracedList (Ambitious)"
            [ test "List.map with bare function reference — dominant docs-app pattern" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (List.map M3e.child items)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "List.map with single-setter lambda counts as one known" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (List.map (\\x -> M3e.child x) items)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "List.map with partial application counts as one known (head fn)" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (List.map (navItem current) items)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "case scrutinee with all-literal branches — union" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    M3e.button []
        (case flag of
            True -> [ M3e.child a ]
            False -> [ M3e.child b ]
        )
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "case with mixed literal and empty branches — union" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    M3e.button []
        (case flag of
            True -> [ M3e.child a, M3e.child b ]
            False -> []
        )
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "List.concatMap with bare function reference" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (List.concatMap M3e.children items)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "cons operator: elem :: literal list" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (M3e.child a :: [ M3e.child b, M3e.child c ])
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:3 unresolved:False"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "cons operator: elem :: dynamic tail" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (M3e.child a :: rest)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "if-then-else producing a list — union both branches" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    M3e.button []
        (if flag then
            [ M3e.child a ]
         else
            []
        )
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "cross-module: value imported from another module — deferred" <|
                \_ ->
                    -- Multi-module tracing requires project-scope rule context
                    -- (Rule.withModuleContext + project context). This requires
                    -- re-architecting from module-scope to project-scope, which
                    -- is a significant lift. Deferred to a follow-up.
                    Expect.pass
            ]
        , describe "callSite"
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
