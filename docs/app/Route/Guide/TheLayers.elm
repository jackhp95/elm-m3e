module Route.Guide.TheLayers exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/the-layers`): the orienting map. The same
component is offered as a the layers — safest and easiest at the top,
rawest at the bottom — and you descend one louder, named step only to escape.
The running example doesn't change; the same Save button is shown at the top
(live) and its descent is shown as code, with the "same string twice means you
dropped a layer" tell.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element exposing (Element)
import Kit
import Layout
import M3e
import M3e.Attributes
import M3e.Kind
import M3e.Values as Value
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
        , description = "The same component is a the layers — safe and easy at the top, raw at the bottom. You descend a named, louder step only to escape."
        , locale = Nothing
        , title = "The layer map · elm-m3e"
        }
        |> Seo.website


{-| The running Save button, expressed at the top layer — the one you use by
default. The chapter shows the lower layers as code (they return raw HTML, not a
slottable value), so the live demo is the top layer: this is the one you want.
-}
saveButton : Element { s | button : M3e.Kind.Brand } adm_ msg
saveButton =
    M3e.button [ M3e.Attributes.variant Value.filled ] [ Kit.text "Save" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "The layer map · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "The layer map"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown layers
                        , Doc.code_ Doc.NoLang layersDiagram
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown sameButton
                        , Doc.showcase saveButton
                        , Doc.code_ Doc.Elm descentCode
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown tell ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """One thesis organizes this whole library: **the correct way and the easy way are the same way — the top. You descend, loudly and on purpose, only to escape.** This chapter is the map that makes that concrete."""


layers : String
layers =
    """The same component is offered at several **forms**, stacked like layers on a layers. The top layer is the safest and the least typing; each layer down hands you more raw control and asks for more by hand. You spend almost all your time on the top layer. You step down only when you need to do something the top can't express — and it's always a *named, visible* step, never an accident."""


layersDiagram : String
layersDiagram =
    """M3e.*         the top layer — the one you use — typed, slot-safe, composes into other components
  ↓ (drop a layer to escape)
M3e.Html.*    the Html layer — typed attributes, plain Html children
  ↓
M3e.Raw.*     the raw layer — bare tags and attributes; no checking
  ↓
elm/html      plain Html — opaque"""


sameButton : String
sameButton =
    """Here is the running Save button at the top — the layer you'll use for essentially everything. It's a value that composes into a card, a list, anywhere a button belongs. The layers below it return plain HTML instead, so they can't drop into those slots; that loss of composability is exactly the cost of descending."""


descentCode : String
descentCode =
    """-- top: typed, slot-safe, composes anywhere a button fits
M3e.button [ M3e.Attributes.variant Value.filled ] [ Kit.text "Save" ]

-- one step down: attributes still typed, children raw, returns plain HTML
-- (reach for this only when you're already outside the typed tree)

-- the raw layer: a bare custom element with hand-written strings
-- (only when you need zero ceremony — and you own every string)"""


tell : String
tell =
    """There's a simple tell that you dropped a layer you didn't need to: **if you write the same string twice, on two different layers, to mean the same thing, you did it wrong.** Each layer reuses the one below it, so a name like `"variant"` is written exactly once, at the bottom, and travels upward for free. Seeing it spelled out by hand up top means you reached past the layer that already had it."""


recap : String
recap =
    """- The same component is a **the layers**: safe and easy at the top, raw at the bottom.
- You live on the top layer and descend — loudly, by name — only to escape; descending trades composability and safety for raw control.
- The tell that you over-descended: **the same string written twice on two layers.**
- **Next: [Your own seam](/guide/seams) →** when you *do* need to step off the layers, do it through the one sanctioned door."""
