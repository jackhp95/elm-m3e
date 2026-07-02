module NodeSlotTest exposing (suite)

{-| Regression tests for issue #79: `Node.addAttr` must not silently drop the
`slot=` attribute when the underlying node is a `Raw` escape hatch (produced by
`EscapeHatch.fromHtml` / `Seam.fromHtml`, or by `Element.map` / `Node.map`, which
re-wrap their result as `Raw`). Before the fix the `Raw` branch returned the node
unchanged, so escape-hatched or mapped content silently landed in the component's
default slot instead of the named slot it was assigned to.
-}

import EscapeHatch
import Expect
import Html
import Html.Attributes as Attr
import M3e.Content as Content
import M3e.Element as Element
import M3e.Node as Node
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


{-| Render slot-tagged content down to Html so we can query it. -}
renderSlotted : String -> Element.Element supported msg -> Html.Html msg
renderSlotted name el =
    Content.slot name el
        |> Content.toNode
        |> Node.toHtml


suite : Test
suite =
    describe "issue #79 — named-slot survives on Raw nodes"
        [ test "EscapeHatch.fromHtml placed in a named slot renders slot=\"name\"" <|
            \_ ->
                renderSlotted "trailing"
                    (EscapeHatch.fromHtml (Html.span [] [ Html.text "hi" ]))
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "trailing") ]
        , test "Element.map'd content keeps its slot=\"name\"" <|
            \_ ->
                renderSlotted "leading"
                    (Element.map identity
                        (EscapeHatch.fromHtml (Html.span [] [ Html.text "mapped" ]))
                    )
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "leading") ]
        , test "the default (unnamed) slot adds no slot attribute" <|
            \_ ->
                renderSlotted ""
                    (EscapeHatch.fromHtml (Html.span [] [ Html.text "plain" ]))
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.attribute (Attr.attribute "slot" "") ]
        ]
