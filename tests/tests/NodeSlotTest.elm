module NodeSlotTest exposing (suite)

{-| Regression tests for issue #79: placing content into a named slot must not
silently drop the `slot=` attribute when the underlying node is a `Raw` escape
hatch (produced by `Seam.fromHtml`, or by `HtmlIr.Element.map`, which re-wraps
its result). Before the fix the `Raw` branch returned the node unchanged, so
escape-hatched or mapped content silently landed in the component's default slot
instead of the named slot it was assigned to.

Ported to the phantom substrate: `M3e.Element`/`M3e.Node`/`M3e.Element.Internal`
were retired in favour of `HtmlIr.*`. Named-slot placement is now the
`Seam.slot` primitive (which stamps `slot=` via `HtmlIr.Internal.addAttribute`,
promoting a `Raw`/`Text` leaf to a `<span>` rather than dropping the attribute).

-}

import Expect
import Html
import Html.Attributes as Attr
import HtmlIr.Element as Element
import HtmlIr.Node as Node
import Seam
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


{-| Render slot-tagged content down to Html so we can query it. `Seam.slot ""`
is the identity placement (no `slot=`); a named slot stamps `slot="name"`.
-}
renderSlotted : String -> Element.Element accepts admittedBy msg -> Html.Html msg
renderSlotted name el =
    Seam.slot name el
        |> Element.toNode
        |> Node.toHtml


suite : Test
suite =
    describe "issue #79 — named-slot survives on Raw nodes"
        [ test "Seam.fromHtml placed in a named slot renders slot=\"name\"" <|
            \_ ->
                renderSlotted "trailing"
                    (Seam.fromHtml (Html.span [] [ Html.text "hi" ]))
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "trailing") ]
        , test "Element.map'd content keeps its slot=\"name\"" <|
            \_ ->
                renderSlotted "leading"
                    (Element.map identity
                        (Seam.fromHtml (Html.span [] [ Html.text "mapped" ]))
                    )
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "leading") ]
        , test "the default (unnamed) slot adds no slot attribute" <|
            \_ ->
                renderSlotted ""
                    (Seam.fromHtml (Html.span [] [ Html.text "plain" ]))
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.attribute (Attr.attribute "slot" "") ]
        ]
