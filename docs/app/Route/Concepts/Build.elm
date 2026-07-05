module Route.Concepts.Build exposing (ActionData, Data, Model, Msg, route)

{-| A canonical **⑤ Build shape** example (`/concepts/build`): the phantom-typed
`M3e.Build.<Comp>` pipeline — seed a `Builder`, apply setters with `|>`, finish
with `build` to get a slottable `Element`. The button on the page is genuinely
constructed through that pipeline, shown beside its highlighted source.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.Action as Action
import M3e.Build.Button as Button
import M3e.Build.Button.Slots as ButtonSlots
import M3e.Build.Icon as Icon
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildNoState { view = view }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.svg" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "The ⑤ Build shape: a phantom-typed M3e.Build.* seed → setters → build pipeline."
        , locale = Nothing
        , title = "The ⑤ Build pipeline · elm-m3e"
        }
        |> Seo.website


{-| The canonical pipeline: seed `Button.button` with its required content +
action, set `variant`, nest an icon child via the `Slots` setter, and `build`
into a slottable `Element`.
-}
saveButton : Element { button : Supported } msg
saveButton =
    Button.button
        { content = Kit.text "Save"
        , action = Action.link "#"
        }
        |> Button.variant Value.filled
        |> ButtonSlots.iconIcon (Icon.icon |> Icon.name "save")
        |> Button.build


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


heading1 : String -> Element { s | heading : Supported } msg
heading1 s =
    Heading.view { content = Kit.text s }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "The ⑤ Build pipeline · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-10"
                    [ Layout.section "space-y-4"
                        [ heading1 "The ⑤ Build pipeline"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-3"
                        [ Doc.markdown body
                        , Doc.showcase (Layout.div "flex flex-wrap items-center gap-3" [ saveButton ])
                        , Doc.code_ Doc.Elm source
                        ]
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Beyond the four `M3e` / `M3e.Cem` / `M3e.Cem.Html` / raw-HTML layers, each component also ships a fifth, **⑤ Build**, shape: a phantom-typed *pipeline* under `M3e.Build.*`. You **seed** a `Builder`, apply **setters** with `|>`, and finish with **`build`** to get the same slottable `Element` the top layer produces.

Capabilities ride the builder's rows as `Available → Used`, so each optional setter can be applied at most once, and `build` works over whatever subset you set — the pipeline is order-free and the compiler tracks what you've touched."""


body : String
body =
    """The button below is built through the pipeline — seed `Button.button`, set the `variant`, nest an `Icon` builder into the `icon` slot via the `Slots` setter, then `build`:"""


source : String
source =
    """import M3e.Action as Action
import M3e.Build.Button as Button
import M3e.Build.Button.Slots as ButtonSlots
import M3e.Build.Icon as Icon
import M3e.Value as Value


saveButton : Element { button : Supported } msg
saveButton =
    Button.button
        { content = Kit.text "Save"
        , action = Action.link "#"
        }
        |> Button.variant Value.filled
        |> ButtonSlots.iconIcon (Icon.icon |> Icon.name "save")
        |> Button.build"""
