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

Basic level (this task):
- `[a, b, c]` → all elements, `unresolved = False`.
- Anything else → `unresolved = True`, no known elements.

Medium and Ambitious levels are added in later tasks.

-}
tracedList : ModuleNameLookupTable -> Node Expression -> TracedList
tracedList _ node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        _ ->
            { known = [], unresolved = True }


decapitalize : String -> String
decapitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s
