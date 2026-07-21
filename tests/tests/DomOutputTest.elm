module DomOutputTest exposing (suite)

{-| DOM-output shape tests (plan §3.2): render representative top-layer `M3e.*`
compositions through the single eager exit (`HtmlIr.Element.toNode` then
`HtmlIr.Node.toHtml`) and assert the shape of the emitted `Html`. Where
`IrCoreTest`/`NodeSlotTest` probe the hand-written IR-core reductions in
isolation, this suite pins the _public_ contract a screen author sees: the right
`<m3e-*>` custom-element tag, slot stamping on slotted children,
attribute/token emission, and — the class of bug a dom-diff ordering regression
would introduce — that children keep their authored order with no reordering,
dropping, or deduplication (IR faithfulness).

These assertions run against the barrel API exactly as the examples and the
`building-m3e-uis` skill teach it (`Kit.text` for slotted text, since text is a
userland seam, not a library value), so a regen that quietly changed a tag name,
dropped a slot stamp, or reordered children would fail here rather than only in
the Playwright runtime harness.

Ported to the phantom substrate: the retired `M3e.Element`/`M3e.Node` render
path is now `HtmlIr.Element.toNode |> HtmlIr.Node.toHtml`; attribute setters moved
to `M3e.Values` (variant tokens) and the per-component modules
(`M3e.Icon.name`, `M3e.Button.icon`, `M3e.ListItem.leading`); `aria-label` has no
typed setter, so it crosses the userland `Seam.asAttribute` boundary.

-}

import Expect
import Html.Attributes as HtmlAttr
import HtmlIr.Element as Element
import HtmlIr.Node as Node
import Kit
import M3e
import M3e.Button
import M3e.Icon
import M3e.ListItem
import M3e.Values as Value
import Seam
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


{-| The one render path a screen uses: IR `Element` -> `Node` -> `Html`, then
into a query. This is the only eager point, mirroring a `view` root. Rendered as
the query root so the top-level `<m3e-*>` tag is directly assertable.
-}
toQuery : Element.Element accepts admittedBy msg -> Query.Single msg
toQuery el =
    Element.toNode el
        |> Node.toHtml
        |> Query.fromHtml


suite : Test
suite =
    describe "DOM-output shape of representative compositions"
        [ describe "custom-element tag emission"
            [ test "M3e.button renders an <m3e-button>" <|
                \_ ->
                    M3e.button [] [ Kit.text "Save" ]
                        |> toQuery
                        |> Query.has [ Selector.tag "m3e-button" ]
            , test "M3e.iconButton renders an <m3e-icon-button> wrapping an <m3e-icon>" <|
                \_ ->
                    M3e.iconButton [ Seam.asAttribute (HtmlAttr.attribute "aria-label" "Back") ]
                        [ M3e.icon [ M3e.Icon.name "arrow_back" ] [] ]
                        |> toQuery
                        |> Expect.all
                            [ Query.has [ Selector.tag "m3e-icon-button" ]
                            , Query.findAll [ Selector.tag "m3e-icon" ] >> Query.count (Expect.equal 1)
                            ]
            ]
        , describe "attribute and token emission"
            [ test "a variant token becomes a variant= attribute on the host" <|
                \_ ->
                    M3e.button [ M3e.Button.variant Value.filled ] [ Kit.text "Go" ]
                        |> toQuery
                        |> Query.has
                            [ Selector.tag "m3e-button"
                            , Selector.attribute (HtmlAttr.attribute "variant" "filled")
                            ]
            , test "an aria-label setter becomes an aria-label attribute" <|
                \_ ->
                    M3e.iconButton [ Seam.asAttribute (HtmlAttr.attribute "aria-label" "Close") ]
                        [ M3e.icon [ M3e.Icon.name "close" ] [] ]
                        |> toQuery
                        |> Query.has
                            [ Selector.attribute (HtmlAttr.attribute "aria-label" "Close") ]
            , test "an icon's name setter becomes a name attribute" <|
                \_ ->
                    M3e.icon [ M3e.Icon.name "menu" ] []
                        |> toQuery
                        |> Query.has [ Selector.attribute (HtmlAttr.attribute "name" "menu") ]
            ]
        , describe "slot stamping on slotted children"
            [ test "M3e.Button.icon stamps slot=icon on the placed icon" <|
                \_ ->
                    M3e.button []
                        [ M3e.Button.icon (M3e.icon [ M3e.Icon.name "add" ] [])
                        , Kit.text "Add"
                        ]
                        |> toQuery
                        |> Query.find [ Selector.tag "m3e-icon" ]
                        |> Query.has [ Selector.attribute (HtmlAttr.attribute "slot" "icon") ]
            , test "M3e.ListItem.leading stamps slot=leading on the placed content" <|
                \_ ->
                    M3e.listItem []
                        [ M3e.ListItem.leading (M3e.icon [ M3e.Icon.name "star" ] [])
                        , Kit.text "Starred"
                        ]
                        |> toQuery
                        |> Query.find [ Selector.attribute (HtmlAttr.attribute "slot" "leading") ]
                        |> Query.has [ Selector.tag "m3e-icon" ]
            ]
        , describe "IR faithfulness — authored order preserved, no dedup"
            [ test "default-slot children keep their authored order" <|
                \_ ->
                    M3e.list []
                        [ M3e.listItem [] [ Kit.text "first" ]
                        , M3e.listItem [] [ Kit.text "second" ]
                        , M3e.listItem [] [ Kit.text "third" ]
                        ]
                        |> toQuery
                        |> Query.findAll [ Selector.tag "m3e-list-item" ]
                        |> Expect.all
                            [ Query.count (Expect.equal 3)
                            , Query.index 0 >> Query.has [ Selector.text "first" ]
                            , Query.index 1 >> Query.has [ Selector.text "second" ]
                            , Query.index 2 >> Query.has [ Selector.text "third" ]
                            ]
            , test "two like leading icons across rows are both emitted (no dedup of like children)" <|
                \_ ->
                    M3e.list []
                        [ M3e.listItem []
                            [ M3e.ListItem.leading (M3e.icon [ M3e.Icon.name "star" ] [])
                            , Kit.text "one"
                            ]
                        , M3e.listItem []
                            [ M3e.ListItem.leading (M3e.icon [ M3e.Icon.name "star" ] [])
                            , Kit.text "two"
                            ]
                        ]
                        |> toQuery
                        |> Query.findAll [ Selector.tag "m3e-icon" ]
                        |> Query.count (Expect.equal 2)
            ]
        ]
