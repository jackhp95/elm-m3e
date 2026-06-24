module NoActionlessButtonTest exposing (all)

import NoActionlessButton exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Button has no action and no explicit disabled state"


details : List String
details =
    [ "A Ui.Button.new pipeline that reaches Ui.Button.view without withOnClick, withHref, or withToggle renders a well-typed but inert button — a degenerate state the type system permits."
    , "Add one of withOnClick / withHref / withToggle, or make the inert state explicit with withDisabled."
    ]


all : Test
all =
    describe "NoActionlessButton"
        [ test "flags new |> view with no action" <|
            \() ->
                """module A exposing (saveBtn)
import Ui.Button
saveBtn = Ui.Button.new { label = "Save", variant = Ui.Button.Filled } |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Ui.Button.new"
                            }
                        ]
        , test "flags a pipeline with a non-action modifier but no action" <|
            \() ->
                """module A exposing (withIcon)
import Ui.Button
withIcon icon =
    Ui.Button.new { label = "Add", variant = Ui.Button.Tonal }
        |> Ui.Button.withLeadingIcon icon
        |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Ui.Button.new"
                            }
                        ]
        , test "passes a pipeline with withOnClick" <|
            \() ->
                """module A exposing (ok)
import Ui.Button
ok = Ui.Button.new { label = "Save", variant = Ui.Button.Filled } |> Ui.Button.withOnClick Save |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a pipeline with withHref" <|
            \() ->
                """module A exposing (link)
import Ui.Button
link = Ui.Button.new { label = "Help", variant = Ui.Button.Text } |> Ui.Button.withHref "/help" |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a pipeline with withToggle" <|
            \() ->
                """module A exposing (tog)
import Ui.Button
tog state =
    Ui.Button.new { label = "Archived", variant = Ui.Button.Outlined }
        |> Ui.Button.withToggle { selected = state, onChange = Toggled }
        |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes an explicitly disabled button" <|
            \() ->
                """module A exposing (disabled)
import Ui.Button
disabled =
    Ui.Button.new { label = "X", variant = Ui.Button.Filled }
        |> Ui.Button.withDisabled Ui.Button.Disabled
        |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "ignores a view call that isn't building a Ui.Button.new" <|
            \() ->
                """module A exposing (other)
import Ui.Button
other btn = btn |> Ui.Button.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "resolves through an alias" <|
            \() ->
                """module A exposing (saveBtn)
import Ui.Button as B
saveBtn = B.new { label = "Save", variant = B.Filled } |> B.view
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "B.new"
                            }
                        ]
        ]
