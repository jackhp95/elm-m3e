module ValidEnumValueTest exposing (all)

import Review.Test
import Test exposing (Test, describe, test)
import ValidEnumValue exposing (rule)


{-| A tiny hand-written facts table: a Button whose `variant` accepts only filled/outlined.
-}
facts : List { component : String, module_ : String, enums : List ( String, List String ), requiredSlots : List String, multiSlots : List String }
facts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = [ ( "variant", [ "filled", "outlined" ] ) ]
      , requiredSlots = []
      , multiSlots = []
      }
    ]


message : String
message =
    "`circular` is not a valid value for this component"


all : Test
all =
    describe "ValidEnumValue"
        [ test "flags a barrel enum setter given a token the component rejects" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, variant)
import M3e.Value as Value

v =
    button [ variant Value.circular ] []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details =
                                [ "This component's enum only accepts: filled, outlined."
                                , "The loose top-layer vocabulary lets any token type-check; use one this component actually supports, or the component-module's strict setter (which rejects the wrong token at compile time)."
                                ]
                            , under = "Value.circular"
                            }
                        ]
        , test "accepts a token the component supports" <|
            \() ->
                """module A exposing (v)

import M3e exposing (button, variant)
import M3e.Value as Value

v =
    button [ variant Value.filled ] []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectNoErrors
        , test "ignores components with no facts" <|
            \() ->
                """module A exposing (v)

import M3e exposing (widget, variant)
import M3e.Value as Value

v =
    widget [ variant Value.circular ] []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectNoErrors
        , test "handles the component-module strict form (M3e.Button.view)" <|
            \() ->
                """module A exposing (v)

import M3e.Button as Button
import M3e.Value as Value

v =
    Button.view [ Button.variant Value.circular ] []
"""
                    |> Review.Test.run (rule facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details =
                                [ "This component's enum only accepts: filled, outlined."
                                , "The loose top-layer vocabulary lets any token type-check; use one this component actually supports, or the component-module's strict setter (which rejects the wrong token at compile time)."
                                ]
                            , under = "Value.circular"
                            }
                        ]
        ]
