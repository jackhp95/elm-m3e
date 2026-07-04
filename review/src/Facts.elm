module Facts exposing
    ( CallSite, callSite
    , buildIndex, find
    , TracedList, tracedList
    )

{-| Shared helpers for codegen-aware rules that consume `M3e.Review.Facts`.

@docs CallSite, callSite
@docs buildIndex, find
@docs TracedList, tracedList

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)


{-| A resolved top-layer call site: which component + which top-shape variant.
-}
type alias CallSite =
    { noun : String
    , shape : Shape
    }


{-| Resolve a function-reference AST node to a top-layer call site, if any.

Handles four forms:

  - `M3e.Button.view` → `{ noun = "button", shape = Shape3 }`
  - `M3e.Record.Button.view` → `{ noun = "button", shape = Shape4 }`
  - `M3e.button` (barrel) → `{ noun = "button", shape = Shape3 }`
  - `M3e.Record.button` (Shape4 barrel) → `{ noun = "button", shape = Shape4 }`

Returns `Nothing` for non-top-layer references (`M3e.Cem.*`, `Html.*`, etc.).

-}
callSite : ModuleNameLookupTable -> Node Expression -> Maybe CallSite
callSite lookup fnNode =
    case Node.value fnNode of
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor lookup fnNode of
                Just [ "M3e" ] ->
                    Just { noun = name, shape = Shape3 }

                Just [ "M3e", "Record" ] ->
                    Just { noun = name, shape = Shape4 }

                Just [ "M3e", comp ] ->
                    if name == "view" then
                        Just { noun = decapitalize comp, shape = Shape3 }

                    else
                        Nothing

                Just [ "M3e", "Record", comp ] ->
                    if name == "view" then
                        Just { noun = decapitalize comp, shape = Shape4 }

                    else
                        Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


{-| Build a noun-keyed index from a facts list.
-}
buildIndex : List Fact -> Dict String Fact
buildIndex facts =
    facts
        |> List.map (\f -> ( f.component, f ))
        |> Dict.fromList


{-| Look up a fact by component noun.
-}
find : String -> Dict String Fact -> Maybe Fact
find noun index =
    Dict.get noun index


{-| The result of tracing a list expression. `known` are the elements the
tracer could resolve statically; `unresolved` is `True` iff some parts of the
expression couldn't be traced (bare functions from other modules, opaque
`List.map` etc.).
-}
type alias TracedList =
    { known : List (Node Expression)
    , unresolved : Bool
    }


{-| Progressive list-content resolver.

Handles:

  - `[a, b, c]` → all elements, `unresolved = False`.
  - `[a] ++ [b]` → elements from both sides, `unresolved = False`.
  - `[a] ++ dynamic` → elements from literal side, `unresolved = True`.
  - `List.append a b` → equivalent to `++`.
  - `List.concat [[a], [b]]` → flattened elements.
  - `List.map f items` → 1 known (the setter/mapper head), `unresolved = True`.
  - `List.concatMap f items` → same as `List.map`.
  - `elem :: rest` → head element plus resolved tail.
  - `case x of { Branch -> [...] }` → union of all branch elements, `unresolved = True`.
  - `if cond then a else b` → union of both branch elements, `unresolved = True`.
  - Bare variable references resolved via the supplied `scope`.

Callers supply a `scope` dict mapping variable names to their bound
expressions (e.g. let bindings collected by a declaration visitor).

-}
tracedList : ModuleNameLookupTable -> Dict String (Node Expression) -> Node Expression -> TracedList
tracedList lookup scope node =
    tracedListWith lookup scope Dict.empty node


{-| Internal — `seen` accumulates variable names already being followed so a
cyclic reference (`x = y; y = x`) doesn't infinite-loop.
-}
tracedListWith :
    ModuleNameLookupTable
    -> Dict String (Node Expression)
    -> Dict String Bool
    -> Node Expression
    -> TracedList
tracedListWith lookup scope seen node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        Expression.OperatorApplication "++" _ left right ->
            concatTraced
                (tracedListWith lookup scope seen left)
                (tracedListWith lookup scope seen right)

        Expression.Application (fnNode :: args) ->
            resolveApp lookup scope seen fnNode args

        Expression.ParenthesizedExpression inner ->
            tracedListWith lookup scope seen inner

        Expression.OperatorApplication "::" _ head tail ->
            -- cons: `elem :: rest` — the head is one known element; tail may resolve further.
            let
                tailTraced =
                    tracedListWith lookup scope seen tail
            in
            { known = head :: tailTraced.known
            , unresolved = tailTraced.unresolved
            }

        Expression.CaseExpression { cases } ->
            let
                branchTraces =
                    List.map (\( _, branchExpr ) -> tracedListWith lookup scope seen branchExpr) cases
            in
            { known = List.concatMap .known branchTraces
            , unresolved = True
            }

        Expression.IfBlock _ thenExpr elseExpr ->
            let
                thenTraced =
                    tracedListWith lookup scope seen thenExpr

                elseTraced =
                    tracedListWith lookup scope seen elseExpr
            in
            { known = thenTraced.known ++ elseTraced.known
            , unresolved = True
            }

        Expression.FunctionOrValue _ name ->
            if Dict.member name seen then
                { known = [], unresolved = True }

            else
                case Dict.get name scope of
                    Just referred ->
                        tracedListWith lookup scope (Dict.insert name True seen) referred

                    Nothing ->
                        { known = [], unresolved = True }

        _ ->
            { known = [], unresolved = True }


resolveApp :
    ModuleNameLookupTable
    -> Dict String (Node Expression)
    -> Dict String Bool
    -> Node Expression
    -> List (Node Expression)
    -> TracedList
resolveApp lookup scope seen fnNode args =
    case ( Node.value fnNode, args ) of
        ( Expression.FunctionOrValue [ "List" ] "append", [ a, b ] ) ->
            concatTraced
                (tracedListWith lookup scope seen a)
                (tracedListWith lookup scope seen b)

        ( Expression.FunctionOrValue [ "List" ] "concat", [ inner ] ) ->
            case Node.value inner of
                Expression.ListExpr parts ->
                    List.foldl
                        (\part acc ->
                            concatTraced acc (tracedListWith lookup scope seen part)
                        )
                        { known = [], unresolved = False }
                        parts

                _ ->
                    { known = [], unresolved = True }

        ( Expression.FunctionOrValue [ "List" ] "map", [ mapperNode, _ ] ) ->
            resolveListMapMapper mapperNode

        ( Expression.FunctionOrValue [ "List" ] "concatMap", [ mapperNode, _ ] ) ->
            -- concatMap f list — same analysis as map: mapper head is the setter,
            -- unresolved because we can't know at analysis time which items are produced.
            resolveListMapMapper mapperNode

        _ ->
            { known = [], unresolved = True }


{-| Inspect the mapper argument of `List.map mapper items`.

Returns the "setter node" representing what each list element looks like, with
`unresolved = True` since we can't know how many items the list produces at
static analysis time.

Handles three mapper shapes:
  - `ContentPane.child` — bare function reference → the fnNode itself as known.
  - `\x -> M3e.child x` — lambda with single-Application body → the head of the
    Application is the setter.
  - `(navItem current)` — partial application → the outer Application node itself
    is the setter (we record it as one known element with `unresolved`).
  - Anything else → empty known, `unresolved = True`.

-}
resolveListMapMapper : Node Expression -> TracedList
resolveListMapMapper mapperNode =
    case Node.value mapperNode of
        Expression.FunctionOrValue _ _ ->
            -- Bare function reference: `List.map ContentPane.child items`
            { known = [ mapperNode ], unresolved = True }

        Expression.LambdaExpression lambda ->
            -- Lambda: inspect the body
            case Node.value lambda.expression of
                Expression.Application (setterNode :: _) ->
                    -- `\x -> M3e.child x` or `\x -> M3e.child SomeValue x`
                    { known = [ setterNode ], unresolved = True }

                Expression.FunctionOrValue _ _ ->
                    -- `\x -> x` — identity, the setter is the lambda arg itself (opaque)
                    { known = [], unresolved = True }

                _ ->
                    { known = [], unresolved = True }

        Expression.Application (headFn :: _) ->
            -- Partial application: `List.map (navItem current) items`
            -- The head function is the setter (partially applied).
            { known = [ headFn ], unresolved = True }

        Expression.ParenthesizedExpression inner ->
            -- `List.map (ContentPane.child) items` — parenthesised bare ref
            resolveListMapMapper inner

        _ ->
            { known = [], unresolved = True }


concatTraced : TracedList -> TracedList -> TracedList
concatTraced a b =
    { known = a.known ++ b.known
    , unresolved = a.unresolved || b.unresolved
    }


decapitalize : String -> String
decapitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s
