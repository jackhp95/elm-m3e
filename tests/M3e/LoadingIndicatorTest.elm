module M3e.LoadingIndicatorTest exposing (suite)

import Expect
import M3e.Element as Element
import M3e.LoadingIndicator as LoadingIndicator
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


nodeWith : List (LoadingIndicator.Option msg) -> Node msg
nodeWith opts =
    LoadingIndicator.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.LoadingIndicator — view-style port"
        [ test "renders <m3e-loading-indicator>" <|
            \_ ->
                nodeWith []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-loading-indicator")
        , test "loading indicator is a leaf — no children" <|
            \_ ->
                nodeWith []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "variant option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ LoadingIndicator.variant LoadingIndicator.Contained ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-loading-indicator")
        , test "uncontained variant does not crash" <|
            \_ ->
                nodeWith [ LoadingIndicator.variant LoadingIndicator.Uncontained ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-loading-indicator")
        ]
