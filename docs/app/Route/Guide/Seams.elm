module Route.Guide.Seams exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/seams`): escape the type system safely. Everything
you write on top of the library is userland; a seam is the single sanctioned,
contained, greppable crossing between raw HTML and the typed world. The running
settings pieces get wrapped in a custom two-column layout (a userland layout
seam), and a custom `text` seam shows the one-body-many-sites payoff. The seam
module is shown as code; the custom layout is live.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element as Element exposing (Element)
import Kit
import Layout
import M3e
import M3e.Button
import M3e.FormField
import M3e.Kind
import M3e.NavMenuItem
import M3e.Values as Value
import Native
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
        , description = "A seam is the one sanctioned, contained, greppable crossing between raw HTML and the library's typed world. Escape the types and keep the guarantees."
        , locale = Nothing
        , title = "Your own seam · elm-m3e"
        }
        |> Seo.website


saveButton : Element { s | button : M3e.Kind.Brand } admittedBy msg
saveButton =
    M3e.button [ M3e.Button.variant Value.filled ]
        [ M3e.Button.icon (M3e.icon [ Native.attribute "name" "save" ] [])
        , Kit.text "Save"
        ]


emailField : Element { s | formField : M3e.Kind.Brand } admittedBy msg
emailField =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ Native.label [ Native.attribute "for" "email-field" ] [ Kit.text "Email address" ]
        , Native.input
            [ Native.attribute "id" "email-field"
            , Native.attribute "type" "email"
            , Native.attribute "name" "email"
            ]
        ]


{-| A userland LAYOUT seam: a two-column grid at wide widths. `Layout.gridWith`
is itself userland — a plain wrapper over raw HTML that lives in the layout
module (a blessed seam location), so feature code names the layout instead of
sprinkling raw class strings around.
-}
twoColumn : Element { s | html : M3e.Kind.Brand } admittedBy msg
twoColumn =
    Layout.gridWith "grid grid-cols-1 gap-4 md:grid-cols-2"
        [ emailField, saveButton ]


{-| The `link` seam filling a _typed slot_. A nav-menu item's `label` slot
accepts the `text` and `link` kinds, so `Kit.link` (the feature-facing re-export
of the `link` seam) drops straight in as an `<a href>` label — no raw HTML, no
break-glass `recast`. The slot's phantom row admits exactly the kinds the design
system declared for it, and the seam produces one of them.
-}
linkNav : Element { s | navMenu : M3e.Kind.Brand } admittedBy msg
linkNav =
    M3e.navMenu []
        [ M3e.NavMenuItem.el { label = Kit.link "/guide/seams" [ Kit.text "Seams" ] } [] []
        , M3e.NavMenuItem.el { label = Kit.link "/guide/the-layers" [ Kit.text "The layers" ] } [] []
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Your own seam · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Your own seam — the one loud door out"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown userland
                        , Doc.showcase twoColumn
                        , Doc.code_ Doc.Elm seamCode
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown slotSeam
                        , Doc.showcase linkNav
                        , Doc.code_ Doc.Elm linkNavCode
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown payoff ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Everything you've written on top of the library so far is **userland** — your own code. Sooner or later you need something the library doesn't ship: a custom layout, your own text wrapper, a one-off raw-HTML escape. The instinct in most systems is to reach past the types and sprinkle raw HTML wherever. This library gives you one sanctioned door instead — a **seam**."""


userland : String
userland =
    """A seam is a *contained, greppable* crossing between raw HTML and the typed world. It lives only in a few blessed modules, so an escape is never scattered through feature code — it's always in a known place you can audit. Here the settings pieces are wrapped in a custom two-column layout at wide widths. The wrapper is a userland layout helper: raw classes live *inside* it, and feature code just names the layout."""


seamCode : String
seamCode =
    """-- a userland layout seam: raw classes contained in one named place
twoColumn =
    Layout.gridWith "grid grid-cols-1 gap-4 md:grid-cols-2"
        [ emailField, saveButton ]

-- a userland text seam: one body, every call site upgrades untouched
text : String -> Element { s | text : M3e.Kind.Brand } adm_ msg
text raw =
    -- swap this one body (e.g. run it through i18n) and every
    -- `text "…"` call site changes with it, no edits at the sites."""


slotSeam : String
slotSeam =
    """A seam isn't only for raw layout — it also fills the *typed slots* a component declares. A nav-menu item's `label` slot accepts the `text` **and** `link` kinds, so a nav item can be an ordinary `<a href>` link with no raw HTML at the call site. `Kit.link` is the feature-facing re-export of the `link` seam; it drops straight into the slot because the slot's phantom row admits exactly that kind."""


linkNavCode : String
linkNavCode =
    """-- the label slot admits { text : M3e.Kind.Brand, link : M3e.Kind.Brand }, so the
-- `link` seam fills it directly — a nav item that IS an anchor. The record
-- form (M3e.Record.NavMenuItem) enforces the required `label` at the type level.
linkNav =
    M3e.navMenu []
        [ NavMenuItem.view { label = Kit.link "/guide/seams" [ Kit.text "Seams" ] } [] []
        , NavMenuItem.view { label = Kit.link "/guide/the-layers" [ Kit.text "The layers" ] } [] []
        ]"""


payoff : String
payoff =
    """That containment is the feature. Change the one body of your `text` seam — pipe it through translation, say — and every call site upgrades without a single edit at the sites. And when the design system is *genuinely wrong* for a case, there's a break-glass override: a loud, audited signal that says "I'm stepping outside on purpose here," not a quiet hole. You escaped the types and **kept** the guarantees, because the escape is named, fenced, and greppable."""


recap : String
recap =
    """- Your code on top of the library is **userland**; a **seam** is the one sanctioned crossing to raw HTML.
- Seams live in a few blessed modules — contained and greppable, so every escape is auditable.
- One seam body ⇒ **every call site upgrades untouched** (e.g. wire `text` through i18n once).
- **Next: [The tooling refactors for you](/guide/tooling-refactors) →** the linter doesn't just flag escapes — it extracts and rewrites them *for* you."""
