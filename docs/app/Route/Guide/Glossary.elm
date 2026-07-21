module Route.Guide.Glossary exposing (ActionData, Data, Model, Msg, route)

{-| Guide · Glossary (`/guide/glossary`): the vocabulary spine. One canonical
place for the kept terms, each defined in plain words — the same glosses the
chapters use on first mention. Insider jargon is deliberately absent; this is
the reader's dictionary, not the maintainer's.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element
import Layout
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
        , description = "The Guide glossary: the thirteen kept terms — layer, form, facet, barrel, component module, generic/component setters, kind, slot, token, seam, component facts, manifest — each defined in plain words."
        , locale = Nothing
        , title = "Glossary · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Glossary · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.div "space-y-8"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Glossary"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown terms ]
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """The words this guide keeps, each defined once and used freely afterward. If a chapter uses one of these, this is what it means — no hidden second meaning."""


terms : String
terms =
    """| Term | What it means |
| --- | --- |
| **layer** | How raw you're willing to go. Three of them, one component: the **top layer** (`M3e.*` — typed, slot-safe, the default), the **Html layer** (`M3e.Html.*` — typed attributes, plain `Html` children), and the **raw layer** (`M3e.Raw.*` — plain elm/html). You drop a layer only to escape, and it's always a visible, named step. |
| **form** | How strict one call site is. The **standard** form (`M3e.button [ attrs ] [ content ]` — everything optional), the **Record** form (`M3e.Record.*` — required parts in a record the compiler demands), and the **Build** form (`M3e.Build.*` — a pipeline where a one-only setter can't be written twice). |
| **facet** | One of the five addressable points of the generated API — a distinct way to write the call. The five split along the **layer** and **form** axes: the raw and Html layers, plus the top layer's three forms (standard, Record, Build). |
| **barrel** | The one-import API of the top layer: `import M3e`, every component and setter in one place. |
| **component module** | The per-component import (`import M3e.Button`) — same components, tighter types. |
| **generic / component setters** | Two barrel dialects: `M3e.slotIcon` works on any component that has the slot; `M3e.buttonIcon`-style **component setters** are kind-precise. The linter can upgrade the former to the latter for you. |
| **kind** | The category a piece of content is — icon, text, button. |
| **slot** | A labeled place a component puts content; each slot declares the kinds it accepts. |
| **token** | An enum value that exists as a name (`M3e.Values.filled`) — invalid tokens aren't names at all. |
| **seam** | The one sanctioned crossing between raw HTML and the typed world, fenced into a few named modules. `Seam.recast` is its loud, greppable override for "the design system is wrong here." |
| **component facts** | The generated per-component list (required slots, valid tokens, required attributes) that the linter reads — the same list the API was generated from. |
| **manifest** | The components' machine-readable self-description that everything above is generated from. |"""
