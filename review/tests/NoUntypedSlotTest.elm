module NoUntypedSlotTest exposing (all)

import NoUntypedSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Untyped slot string — use the typed M3e.<Module>.<name>Slot helper"


details : List String
details =
    [ "Slot names are strings, so `Attr.attribute \"slot\" \"…\"` is well-typed even when the element has no such slot — the content then silently never renders. This is the shape of the CRITICAL spec deltas."
    , "Set the slot via the typed `M3e.<Module>.<name>Slot` helper. If the slot genuinely has no typed binding, it must be an allowlisted native slot (e.g. \"label\")."
    ]


all : Test
all =
    describe "NoUntypedSlot"
        [ test "flags a raw slot string in a Ui module" <|
            \() ->
                """module Ui.Tabs exposing (view)
import Html
import Html.Attributes as Attr
view b = Html.span [ Attr.attribute "slot" "badge" ] [ Html.text b ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Attr.attribute \"slot\" \"badge\""
                            }
                        ]
        , test "flags slot=\"input\" (has a typed binding, not allowlisted)" <|
            \() ->
                """module Ui.Search exposing (view)
import Html
import Html.Attributes as Attr
view = Html.input [ Attr.attribute "slot" "input" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Attr.attribute \"slot\" \"input\""
                            }
                        ]
        , test "passes the allowlisted native slot \"label\"" <|
            \() ->
                """module Ui.Checkbox exposing (view)
import Html
import Html.Attributes as Attr
view t = Html.span [ Attr.attribute "slot" "label" ] [ Html.text t ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a typed slot helper" <|
            \() ->
                """module Ui.NavigationBar exposing (view)
import Html
import M3e.NavMenuItem
view icon = Html.span [ M3e.NavMenuItem.iconSlot ] [ icon ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag a raw slot string outside src/Ui" <|
            \() ->
                """module Demo exposing (view)
import Html
import Html.Attributes as Attr
view = Html.span [ Attr.attribute "slot" "badge" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag non-slot raw attributes" <|
            \() ->
                """module Ui.Foo exposing (view)
import Html
import Html.Attributes as Attr
view = Html.span [ Attr.attribute "aria-label" "x" ] []
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
