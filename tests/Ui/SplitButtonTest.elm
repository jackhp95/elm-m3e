module Ui.SplitButtonTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.SplitButton


type Msg
    = Primary
    | Trigger


splitButton : Ui.SplitButton.SplitButton Msg
splitButton =
    Ui.SplitButton.new
        { label = "Save"
        , onPrimaryClick = Primary
        , onTriggerClick = Trigger
        , trailingIcon = Ui.Icon.material "arrow_drop_down"
        }


suite : Test
suite =
    describe "Ui.SplitButton"
        [ test "primary button is projected into the leading-button slot" <|
            \_ ->
                splitButton
                    |> Ui.SplitButton.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "leading-button") ]
                    |> Query.has [ Selector.text "Save" ]
        , test "trigger button is projected into the trailing-button slot" <|
            \_ ->
                splitButton
                    |> Ui.SplitButton.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "trailing-button") ]
                    |> Query.count (Expect.equal 1)
        , test "the Outlined variant uses the typed variant binding (variant=outlined)" <|
            \_ ->
                splitButton
                    |> Ui.SplitButton.withVariant Ui.SplitButton.Outlined
                    |> Ui.SplitButton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-split-button"
                        , Selector.attribute (Attr.attribute "variant" "outlined")
                        ]
        , test "the trigger aria-label defaults to More actions" <|
            \_ ->
                splitButton
                    |> Ui.SplitButton.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "aria-label" "More actions") ]
        , test "withTriggerLabel overrides the trigger aria-label" <|
            \_ ->
                splitButton
                    |> Ui.SplitButton.withTriggerLabel "Save options"
                    |> Ui.SplitButton.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "aria-label" "Save options") ]
        ]
