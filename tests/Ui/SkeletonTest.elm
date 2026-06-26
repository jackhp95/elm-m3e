module Ui.SkeletonTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import M3e.Skeleton
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Skeleton


suite : Test
suite =
    describe "Ui.Skeleton"
        [ test "withShape emits the shape attribute" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.withShape Ui.Skeleton.Circular
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-skeleton"
                        , Selector.attribute (Attr.attribute "shape" "circular")
                        ]
        , test "withAnimation emits the animation attribute" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.withAnimation Ui.Skeleton.Pulse
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-skeleton"
                        , Selector.attribute (Attr.attribute "animation" "pulse")
                        ]
        , test "withLoaded True emits the loaded property" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.withLoaded True
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-skeleton"
                        , Selector.attribute (M3e.Skeleton.loaded True)
                        ]
        , test "withContent projects children into the element's default slot" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.withContent
                        [ Html.div [ Attr.class "real-content" ] [ Html.text "loaded" ] ]
                    |> Ui.Skeleton.withLoaded True
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.class "real-content"
                        , Selector.text "loaded"
                        ]
        , test "defaults: no content children when withContent is unset" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Query.children []
                    |> Query.count (Expect.equal 0)
        , test "defaults: no shape/animation attributes when unset" <|
            \_ ->
                Ui.Skeleton.new
                    |> Ui.Skeleton.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.attribute (Attr.attribute "shape" "auto") ]
                            >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.attribute (Attr.attribute "animation" "wave") ]
                            >> Query.count (Expect.equal 0)
                        ]
        ]
