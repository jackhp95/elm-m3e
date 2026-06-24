module Ui.ExtendedFabTest exposing (suite)

import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.ExtendedFab
import Ui.Icon


extendedFab : Ui.ExtendedFab.ExtendedFab msg
extendedFab =
    Ui.ExtendedFab.new
        { icon = Ui.Icon.material "edit"
        , label = "Compose"
        , variant = Ui.ExtendedFab.Primary
        }


suite : Test
suite =
    describe "Ui.ExtendedFab"
        [ test "label is projected into the m3e-fab label slot" <|
            \_ ->
                extendedFab
                    |> Ui.ExtendedFab.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "label") ]
                    |> Query.has [ Selector.text "Compose" ]
        , test "renders the extended attribute" <|
            \_ ->
                extendedFab
                    |> Ui.ExtendedFab.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-fab" ]
        ]
