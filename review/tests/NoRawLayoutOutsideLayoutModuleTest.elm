module NoRawLayoutOutsideLayoutModuleTest exposing (all)

import NoRawLayoutOutsideLayoutModule exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Hand-rolled layout element — use Layout module instead"


details : List String
details =
    [ "This `Node.element` call uses one of the layout tags (div, section, span, nav, ul, li) with a single class attribute."
    , "Replace it with the equivalent `Layout.*` helper from `docs/src/Layout.elm`. Use a named preset when the class string matches exactly, or `Layout.div` / `Layout.section` / `Layout.span` / … for an exact-class escape."
    ]


all : Test
all =
    describe "NoRawLayoutOutsideLayoutModule"
        [ test "flags Node.element div with single rawAttr class in Route module" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "flex gap-4") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "div" [ Node.rawAttr (class "flex gap-4") ] []"""
                            }
                        ]
        , test "flags section tag" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "section" [ Node.rawAttr (class "space-y-4") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "section" [ Node.rawAttr (class "space-y-4") ] []"""
                            }
                        ]
        , test "flags span tag" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "span" [ Node.rawAttr (class "inline-block size-6") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "span" [ Node.rawAttr (class "inline-block size-6") ] []"""
                            }
                        ]
        , test "flags nav tag" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "nav" [ Node.rawAttr (class "flex gap-2") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "nav" [ Node.rawAttr (class "flex gap-2") ] []"""
                            }
                        ]
        , test "flags ul tag" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "ul" [ Node.rawAttr (class "px-2") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "ul" [ Node.rawAttr (class "px-2") ] []"""
                            }
                        ]
        , test "flags li tag" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "li" [ Node.rawAttr (class "flex items-center gap-2") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "li" [ Node.rawAttr (class "flex items-center gap-2") ] []"""
                            }
                        ]
        , test "flags in Shared module" <|
            \() ->
                """module Shared exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "flex") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "div" [ Node.rawAttr (class "flex") ] []"""
                            }
                        ]
        , test "flags in ErrorPage module" <|
            \() ->
                """module ErrorPage exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "p-4") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "div" [ Node.rawAttr (class "p-4") ] []"""
                            }
                        ]
        , test "flags dynamic class expression" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view x = Node.element "div" [ Node.rawAttr (class ("flex " ++ x)) ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "div" [ Node.rawAttr (class ("flex " ++ x)) ] []"""
                            }
                        ]
        , test "flags qualified Attr.class form" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes as Attr
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (Attr.class "flex gap-4") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = """Node.element "div" [ Node.rawAttr (Attr.class "flex gap-4") ] []"""
                            }
                        ]
        , test "does not flag multi-attr elements" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class, id)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "flex"), Node.rawAttr (id "foo") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag zero-attr elements" <|
            \() ->
                """module Route.Index exposing (view)
import M3e.Node as Node
view = Node.element "div" [] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag non-layout tag button" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "button" [ Node.rawAttr (class "btn") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag non-layout tag code" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "code" [ Node.rawAttr (class "font-mono") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag in Layout module" <|
            \() ->
                """module Layout exposing (div)
import Html.Attributes as Attr
import M3e.Node as Node exposing (Node)
div cls children = Node.element "div" [ Node.rawAttr (Attr.class cls) ] children
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag Node.attribute class (not rawAttr)" <|
            \() ->
                """module Route.Index exposing (view)
import M3e.Node as Node
view = Node.element "div" [ Node.attribute "class" "flex" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag rawAttr with non-class attr" <|
            \() ->
                """module Route.Index exposing (view)
import Html.Attributes exposing (id)
import M3e.Node as Node
view = Node.element "span" [ Node.rawAttr (id "anchor") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag in M3e library module" <|
            \() ->
                """module M3e.SomeHelper exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "foo") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag in a non-Route sub-module" <|
            \() ->
                """module Api.Endpoint exposing (view)
import Html.Attributes exposing (class)
import M3e.Node as Node
view = Node.element "div" [ Node.rawAttr (class "foo") ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
