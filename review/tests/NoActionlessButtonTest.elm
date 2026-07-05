module NoActionlessButtonTest exposing (all)

import NoActionlessButton exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Button has no action and no explicit disabled state"


details : List String
details =
    [ "A button whose attribute list reaches the constructor without onClick, href, or toggle renders a well-typed but inert button — a degenerate state the loose attribute list permits."
    , "Add one of onClick / href / toggle, or make the inert state explicit with disabled / disabledInteractive."
    ]


all : Test
all =
    describe "NoActionlessButton"
        [ test "flags a barrel button with no action" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, variant)
import M3e.Value as Value

v =
    button [ variant Value.filled ] [ text "Save" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error { message = message, details = details, under = "button" }
                            |> Review.Test.atExactly { start = { row = 7, column = 5 }, end = { row = 7, column = 11 } }
                        ]
        , test "accepts a button with onClick" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, onClick)

v =
    button [ onClick Save ] [ text "Save" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "accepts a button made explicitly inert with disabled" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, disabled)

v =
    button [ disabled True ] [ text "Save" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "accepts the strict Button.view form with href" <|
            \() ->
                """module A exposing (v)

import M3e.Button as Button

v =
    Button.view [ Button.href "/docs" ] [ text "Docs" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "ignores non-button constructors" <|
            \() ->
                """module A exposing (v)

import M3e exposing (card, variant)
import M3e.Value as Value

v =
    card [ variant Value.filled ] [ text "hi" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "flags a button with an empty attribute list (#92)" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button)

v =
    button [] [ text "hi" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error { message = message, details = details, under = "button" }
                            |> Review.Test.atExactly { start = { row = 6, column = 5 }, end = { row = 6, column = 11 } }
                        ]
        , test "accepts a button made explicitly inert with disabledInteractive (#92)" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, disabledInteractive)

v =
    button [ disabledInteractive True ] [ text "hi" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
