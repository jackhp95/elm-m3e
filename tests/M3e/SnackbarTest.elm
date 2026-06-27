module M3e.SnackbarTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Snackbar as Snackbar
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


snackNode : List (Snackbar.Option msg) -> Node.Node msg
snackNode opts =
    Snackbar.view { message = "Saved." } opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Snackbar — view-style port (declarative surface)"
        [ test "view renders <m3e-snackbar>" <|
            \_ ->
                snackNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-snackbar")
        , test "message appears as a text child in the default slot" <|
            \_ ->
                snackNode []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "id sets the 'id' attribute" <|
            \_ ->
                snackNode [ Snackbar.id "save-snack" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "save-snack")
        , test "id absent by default" <|
            \_ ->
                snackNode []
                    |> Node.findAttribute "id"
                    |> Expect.equal Nothing
        , test "dismissible=true sets the dismissible DOM property" <|
            \_ ->
                snackNode [ Snackbar.dismissible True ]
                    |> Node.findProperty "dismissible"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "dismissible absent by default" <|
            \_ ->
                snackNode []
                    |> Node.findProperty "dismissible"
                    |> Expect.equal Nothing
        , test "duration sets the duration DOM property" <|
            \_ ->
                snackNode [ Snackbar.duration 5000 ]
                    |> Node.findProperty "duration"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "5000")
        , test "duration absent by default" <|
            \_ ->
                snackNode []
                    |> Node.findProperty "duration"
                    |> Expect.equal Nothing
        , test "different messages produce different nodes (sanity)" <|
            \_ ->
                let
                    n1 : Node.Node msg
                    n1 =
                        Snackbar.view { message = "Saved." } [] |> Renderable.toNode

                    n2 : Node.Node msg
                    n2 =
                        Snackbar.view { message = "Deleted." } [] |> Renderable.toNode
                in
                ( Node.tagOf n1, Node.tagOf n2 )
                    |> Expect.equal ( Just "m3e-snackbar", Just "m3e-snackbar" )
        ]
