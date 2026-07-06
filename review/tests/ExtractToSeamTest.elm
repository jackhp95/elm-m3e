module ExtractToSeamTest exposing (all)

import ExtractToSeam exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


config : { seamModule : String, allowedModules : List String }
config =
    { seamModule = "Seam", allowedModules = [ "Native", "Layout" ] }


{-| A tiny stand-in for `Html.Attributes` so `class` resolves to an imported
module (not a free variable) inside the test project.
-}
attrModule : String
attrModule =
    """module Attr exposing (class)


class : String -> Int
class _ =
    0
"""


{-| A tiny seam module with one primitive escape (`asAttribute`).
-}
seamModule : String
seamModule =
    """module Seam exposing (asAttribute)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x
"""


all : Test
all =
    describe "ExtractToSeam"
        [ test "lifts a closed escape into the seam module and rewrites the call site" <|
            \() ->
                [ """module Feature exposing (v)

import Attr exposing (class)
import Seam


v =
    Seam.asAttribute (class "flex-auto")
"""
                , seamModule
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectErrorsForModules
                        [ ( "Feature"
                          , [ Review.Test.error
                                { message = "`Seam.asAttribute` escape can be lifted into `Seam.flexAuto`"
                                , details =
                                    [ "This `Seam.*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `Seam` as `flexAuto` and rewrites this call site to `Seam.flexAuto`."
                                    , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `Seam` function is never re-extracted."
                                    ]
                                , under = "Seam.asAttribute (class \"flex-auto\")"
                                }
                                |> Review.Test.shouldFixFiles
                                    [ ( "Feature", """module Feature exposing (v)

import Attr exposing (class)
import Seam


v =
    Seam.flexAuto
""" )
                                    , ( "Seam", """module Seam exposing (asAttribute, flexAuto)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


flexAuto =
    Seam.asAttribute (class "flex-auto")
""" )
                                    ]
                            ]
                          )
                        ]
        , test "de-duplicates identical escapes into one lifted function reused by both call sites" <|
            \() ->
                [ """module Feature exposing (a, b)

import Attr exposing (class)
import Seam


a =
    Seam.asAttribute (class "flex-auto")


b =
    Seam.asAttribute (class "flex-auto")
"""
                , seamModule
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectErrorsForModules
                        [ ( "Feature"
                          , [ Review.Test.error
                                { message = "`Seam.asAttribute` escape can be lifted into `Seam.flexAuto`"
                                , details =
                                    [ "This `Seam.*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `Seam` as `flexAuto` and rewrites this call site to `Seam.flexAuto`."
                                    , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `Seam` function is never re-extracted."
                                    ]
                                , under = "Seam.asAttribute (class \"flex-auto\")"
                                }
                                |> Review.Test.atExactly { start = { row = 8, column = 5 }, end = { row = 8, column = 41 } }
                                |> Review.Test.shouldFixFiles
                                    [ ( "Feature", """module Feature exposing (a, b)

import Attr exposing (class)
import Seam


a =
    Seam.flexAuto


b =
    Seam.flexAuto
""" )
                                    , ( "Seam", """module Seam exposing (asAttribute, flexAuto)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


flexAuto =
    Seam.asAttribute (class "flex-auto")
""" )
                                    ]
                            ]
                          )
                        ]
        , test "gives distinct escapes distinct deterministically-named functions" <|
            \() ->
                [ """module Feature exposing (a, b)

import Attr exposing (class)
import Seam


a =
    Seam.asAttribute (class "flex-auto")


b =
    Seam.asAttribute (class "grid-row")
"""
                , seamModule
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectErrorsForModules
                        [ ( "Feature"
                          , [ Review.Test.error
                                { message = "`Seam.asAttribute` escape can be lifted into `Seam.flexAuto`"
                                , details =
                                    [ "This `Seam.*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `Seam` as `flexAuto` and rewrites this call site to `Seam.flexAuto`."
                                    , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `Seam` function is never re-extracted."
                                    ]
                                , under = "Seam.asAttribute (class \"flex-auto\")"
                                }
                                |> Review.Test.shouldFixFiles
                                    [ ( "Feature", """module Feature exposing (a, b)

import Attr exposing (class)
import Seam


a =
    Seam.flexAuto


b =
    Seam.asAttribute (class "grid-row")
""" )
                                    , ( "Seam", """module Seam exposing (asAttribute, flexAuto)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


flexAuto =
    Seam.asAttribute (class "flex-auto")
""" )
                                    ]
                            , Review.Test.error
                                { message = "`Seam.asAttribute` escape can be lifted into `Seam.gridRow`"
                                , details =
                                    [ "This `Seam.*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `Seam` as `gridRow` and rewrites this call site to `Seam.gridRow`."
                                    , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `Seam` function is never re-extracted."
                                    ]
                                , under = "Seam.asAttribute (class \"grid-row\")"
                                }
                                |> Review.Test.shouldFixFiles
                                    [ ( "Feature", """module Feature exposing (a, b)

import Attr exposing (class)
import Seam


a =
    Seam.asAttribute (class "flex-auto")


b =
    Seam.gridRow
""" )
                                    , ( "Seam", """module Seam exposing (asAttribute, gridRow)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


gridRow =
    Seam.asAttribute (class "grid-row")
""" )
                                    ]
                            ]
                          )
                        ]
        , test "parameterizes a captured free variable and threads it at the call site" <|
            \() ->
                [ """module Feature exposing (v)

import Attr exposing (class)
import Seam


v n =
    Seam.asAttribute (class ("col-" ++ n))
"""
                , seamModule
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectErrorsForModules
                        [ ( "Feature"
                          , [ Review.Test.error
                                { message = "`Seam.asAttribute` escape can be lifted into `Seam.col`"
                                , details =
                                    [ "This `Seam.*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `Seam` as `col` and rewrites this call site to `Seam.col`."
                                    , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `Seam` function is never re-extracted."
                                    ]
                                , under = "Seam.asAttribute (class (\"col-\" ++ n))"
                                }
                                |> Review.Test.shouldFixFiles
                                    [ ( "Feature", """module Feature exposing (v)

import Attr exposing (class)
import Seam


v n =
    Seam.col n
""" )
                                    , ( "Seam", """module Seam exposing (asAttribute, col)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


col n =
    Seam.asAttribute (class ("col-" ++ n))
""" )
                                    ]
                            ]
                          )
                        ]
        , test "converges: already-lifted closed and parameterized seam calls are not re-extracted" <|
            \() ->
                [ """module Feature exposing (v, w)

import Seam


v =
    Seam.flexAuto


w n =
    Seam.col n
"""
                , """module Seam exposing (asAttribute, col, flexAuto)

import Attr exposing (class)


asAttribute : a -> a
asAttribute x =
    x


flexAuto =
    Seam.asAttribute (class "flex-auto")


col n =
    Seam.asAttribute (class ("col-" ++ n))
"""
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectNoErrors
        , test "does not touch a Seam.* call inside an allowed module" <|
            \() ->
                [ """module Native exposing (v)

import Attr exposing (class)
import Seam


v =
    Seam.asAttribute (class "flex-auto")
"""
                , seamModule
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectNoErrors
        , test "reports a fixless error for a point-free seam reference" <|
            \() ->
                [ """module Feature exposing (v)

import Seam


v xs =
    List.map Seam.asElement xs
"""
                , """module Seam exposing (asElement)


asElement : a -> a
asElement x =
    x
"""
                , attrModule
                ]
                    |> Review.Test.runOnModules (rule config)
                    |> Review.Test.expectErrorsForModules
                        [ ( "Feature"
                          , [ Review.Test.error
                                { message = "`Seam.asElement` is used point-free and cannot be auto-extracted"
                                , details =
                                    [ "This is a bare (point-free) reference to a seam function rather than an applied escape expression, so there is nothing self-contained to lift."
                                    , "Refactor it into an applied escape, or lift the surrounding expression into the seam module by hand."
                                    ]
                                , under = "Seam.asElement"
                                }
                            ]
                          )
                        ]
        ]
