module NoRawAttributeInUiTest exposing (all)

import NoRawAttributeInUi exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Raw attribute string duplicates a typed M3e binding"


details : List String
details =
    [ "`Html.Attributes.attribute` accepts any two strings, so a raw structural attribute can drift from (or typo against) the typed `M3e.*` binding that the underlying element actually reads."
    , "Set this attribute via the typed `M3e.<Module>` binding instead of a raw attribute string."
    ]


all : Test
all =
    describe "NoRawAttributeInUi"
        [ test "flags raw structural attribute \"value\" in a Ui module" <|
            \() ->
                """module Ui.Slider exposing (view)
import Html
import Html.Attributes as Attr
view v = Html.node "m3e-slider" [ Attr.attribute "value" (String.fromFloat v) ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Attr.attribute \"value\" (String.fromFloat v)"
                            }
                        ]
        , test "flags raw \"selected\" in a Ui module" <|
            \() ->
                """module Ui.Stepper exposing (view)
import Html
import Html.Attributes as Attr
view = Html.node "m3e-step" [ Attr.attribute "selected" "true" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Attr.attribute \"selected\" \"true\""
                            }
                        ]
        , test "passes a global a11y attribute" <|
            \() ->
                """module Ui.IconButton exposing (view)
import Html
import Html.Attributes as Attr
view = Html.span [ Attr.attribute "aria-label" "x" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a data-* attribute" <|
            \() ->
                """module Ui.Foo exposing (view)
import Html
import Html.Attributes as Attr
view = Html.span [ Attr.attribute "data-testid" "x" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a non-structural wrapper/native attribute (\"message\", \"rows\")" <|
            \() ->
                """module Ui.Snackbar exposing (view)
import Html
import Html.Attributes as Attr
view m = Html.node "avt-snackbar" [ Attr.attribute "message" m ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes the slot attribute (owned by NoUntypedSlot)" <|
            \() ->
                """module Ui.Tabs exposing (view)
import Html
import Html.Attributes as Attr
view = Html.span [ Attr.attribute "slot" "badge" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag raw structural attributes outside src/Ui" <|
            \() ->
                """module Demo exposing (view)
import Html
import Html.Attributes as Attr
view = Html.node "m3e-slider" [ Attr.attribute "value" "5" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
