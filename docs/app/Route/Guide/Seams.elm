module Route.Guide.Seams exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/seams`): a **seam** is the _practice_ of keeping the few places
you genuinely step outside the type system in one greppable userland module,
instead of scattering escapes through feature code. This docs app's own `Seam`
module is the running example: standard HTML stays typed (`TypedHtml`), most
"custom" content just fills a typed slot, and only the true escapes — a
third-party custom element, raw `Html` — go through the library's lint-fenced
doors. The two-column layout is live; the producers are shown as code.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element as Element exposing (Element)
import M3e
import M3e.Button
import M3e.FormField
import M3e.Icon
import M3e.Kind
import M3e.NavMenuItem
import M3e.Values as Value
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Seam
import Shared
import TypedHtml
import TypedHtml.Attributes
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
        , description = "A seam is the practice of corralling the few real escapes — raw Html, a custom element the types can't express — into one greppable module. Everything else stays typed."
        , locale = Nothing
        , title = "Your own seam · elm-m3e"
        }
        |> Seo.website


saveButton : Element { s | button : M3e.Kind.Brand } admittedBy msg
saveButton =
    M3e.button [ M3e.Button.variant Value.filled ]
        [ M3e.Button.icon (M3e.icon [ M3e.Icon.name "save" ] [])
        , M3e.text "Save"
        ]


emailField : Element { s | formField : M3e.Kind.Brand } admittedBy msg
emailField =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ M3e.FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for "email-field" ] [ M3e.text "Email address" ])
        , M3e.FormField.child
            (TypedHtml.input
                [ TypedHtml.Attributes.id "email-field"
                , TypedHtml.Attributes.type_ "email"
                , TypedHtml.Attributes.name "email"
                ]
                []
            )
        ]


{-| Userland layout — **not** a seam. Standard HTML is already typed, so a
two-column grid is a plain `TypedHtml.div` with a class attribute; the class
string is contained in one named producer instead of sprinkled at every call
site. No escape, no door.
-}
twoColumn =
    TypedHtml.div [ TypedHtml.Attributes.class "grid grid-cols-1 gap-4 md:grid-cols-2" ]
        [ emailField, saveButton ]


{-| A **genuine seam.** `<model-viewer>` is a third-party web component the typed
tree has no producer for, so building it means stepping outside: `Seam.node`
forges the custom tag and `Seam.attribute` sets its bespoke attributes. That
escape is exactly what a seam is _for_ — and it lives in one named userland
producer, contained and greppable, not scattered through feature code.
-}
modelViewer : Element { k | html : M3e.Kind.Brand } freeAdm msg
modelViewer =
    Seam.node "model-viewer"
        [ Seam.attribute "src" "/models/chair.glb"
        , Seam.attribute "camera-controls" ""
        , Seam.attribute "auto-rotate" ""
        , TypedHtml.Attributes.class "block h-48 w-full rounded-lg bg-surface-container"
        ]
        []


{-| A typed anchor filling a _typed slot_. A nav-menu item's `label` slot accepts
the `text` and `link` kinds, so `TypedHtml.a` drops straight in as an `<a href>`
label — no raw HTML, no seam, no break-glass `recast`. The slot's phantom row
admits exactly the kinds the design system declared for it.
-}
linkNav : Element { s | navMenu : M3e.Kind.Brand } admittedBy msg
linkNav =
    M3e.navMenu []
        [ M3e.NavMenuItem.el { label = TypedHtml.a [ TypedHtml.Attributes.href "/guide/seams" ] [ M3e.text "Seams" ] } [] []
        , M3e.NavMenuItem.el { label = TypedHtml.a [ TypedHtml.Attributes.href "/guide/the-layers" ] [ M3e.text "The surfaces" ] } [] []
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Your own seam · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ TypedHtml.div [ TypedHtml.Attributes.class "space-y-12" ]
                    [ TypedHtml.section [ TypedHtml.Attributes.class "space-y-4" ]
                        [ Doc.pageHeading "Your own seam — one place for your escapes"
                        , TypedHtml.div [ TypedHtml.Attributes.class "max-w-2xl text-on-surface-variant" ] [ Doc.markdown intro ]
                        ]
                    , TypedHtml.section [ TypedHtml.Attributes.class "space-y-4" ]
                        [ Doc.markdown userland
                        , Doc.showcase twoColumn
                        , Doc.code_ Doc.Elm seamCode
                        ]
                    , TypedHtml.section [ TypedHtml.Attributes.class "space-y-4" ]
                        [ Doc.markdown realSeam
                        , Doc.showcase modelViewer
                        , Doc.code_ Doc.Elm realSeamCode
                        ]
                    , TypedHtml.section [ TypedHtml.Attributes.class "space-y-4" ]
                        [ Doc.markdown slotSeam
                        , Doc.showcase linkNav
                        , Doc.code_ Doc.Elm linkNavCode
                        ]
                    , TypedHtml.section [ TypedHtml.Attributes.class "space-y-4" ]
                        [ Doc.markdown payoff ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Everything you write on top of the library is **userland** — your own code. Most of it needs no escape at all: standard HTML is already typed (`TypedHtml.div`, `TypedHtml.label`, …), and "custom" content usually just fills a component's *typed slot*. A **seam** isn't a library feature — it's the *practice* of keeping the handful of places you genuinely _do_ step outside the type system in **one greppable module**, so an escape is never scattered through feature code. This docs app does exactly that: everything below lives in one `Seam` module you can audit at a glance."""


userland : String
userland =
    """Start with what is **not** a seam. A two-column layout is standard HTML, and standard HTML is typed — a `TypedHtml.div` with a class attribute. Naming it in one userland producer keeps the class string in one place, but there is no escape here and nothing for the linter to fence. Reaching for a `Seam.*` layout wrapper would be the mistake: it drags plain typed markup through the seam for no reason."""


seamCode : String
seamCode =
    """-- NOT a seam: standard HTML is already typed, so layout is a plain div.
twoColumn =
    TypedHtml.div [ TypedHtml.Attributes.class "grid grid-cols-1 md:grid-cols-2" ]
        [ emailField, saveButton ]"""


realSeam : String
realSeam =
    """Now a **real** seam. `<model-viewer>` is a third-party web component — the typed tree has no producer for it, so building it means genuinely stepping outside: `Seam.node` forges the custom tag and `Seam.attribute` sets its bespoke attributes. This is what the seam is *for*. Because it lives in one named userland producer, the escape is contained, greppable, and lint-fenced — you stepped outside on purpose, in one auditable place, instead of sprinkling `node`/`attribute` calls through feature code."""


realSeamCode : String
realSeamCode =
    """-- a real seam: a custom element the types can't express, contained once.
modelViewer =
    Seam.node "model-viewer"
        [ Seam.attribute "src" "/models/chair.glb"
        , Seam.attribute "camera-controls" ""
        , TypedHtml.Attributes.class "block h-48 w-full rounded-lg"
        ]
        []"""


slotSeam : String
slotSeam =
    """Most "custom" content needs no escape at all — it fills the *typed slots* a component declares. A nav-menu item's `label` slot accepts the `text` **and** `link` kinds, so a nav item can be an ordinary `<a href>` with no raw HTML at the call site: `TypedHtml.a` produces the `link` kind, so it drops into the slot directly — no seam, no door, no break-glass `recast`. The slot's phantom row admits exactly the kinds the design system declared for it."""


linkNavCode : String
linkNavCode =
    """-- the label slot admits { text : M3e.Kind.Brand, link : M3e.Kind.Brand }, so a
-- typed `TypedHtml.a` fills it directly — a nav item that IS an anchor. The
-- required-record form (`M3e.NavMenuItem.el`) enforces the required `label`.
linkNav =
    M3e.navMenu []
        [ M3e.NavMenuItem.el { label = TypedHtml.a [ TypedHtml.Attributes.href "/guide/seams" ] [ M3e.text "Seams" ] } [] []
        , M3e.NavMenuItem.el { label = TypedHtml.a [ TypedHtml.Attributes.href "/guide/the-layers" ] [ M3e.text "The surfaces" ] } [] []
        ]"""


payoff : String
payoff =
    """That is the whole discipline: **type everything you can, seam only what you must, and keep the seams in one place.** Layout and text are typed producers. Slots take typed kinds. The genuine escapes — a custom element, raw `Html` via `fromHtml`, or the break-glass `recast` when the design system is truly wrong for a case — are named, lint-fenced, and corralled into your one `Seam` module. You escaped the types where you had to and **kept** the guarantees everywhere else, because every real escape is loud, contained, and greppable."""


recap : String
recap =
    """- A **seam** isn't a library feature — it's the *practice* of keeping the few real escapes (a custom element, raw `Html`, a `recast`) in **one greppable module**.
- Most userland is **not** a seam: standard HTML is typed (`TypedHtml`), and custom content usually fills a **typed slot** — no escape needed.
- The genuine escapes go through the library's lint-fenced doors — `Unsafe` (`fromHtml`/`recast`) and the `HtmlIr.Internal` forge (`node`/`attribute`) — and are named once so every use is auditable.
- **Next: [The tooling refactors for you](/guide/tooling-refactors) →** the linter doesn't just flag escapes — it extracts and rewrites them *for* you."""
