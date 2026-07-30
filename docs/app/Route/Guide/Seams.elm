module Route.Guide.Seams exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/seams`): a **seam** is the _practice_ of keeping everything you
build on top of the library — your vocabulary, layout helpers, and raw-HTML
escapes — in one greppable userland module, instead of scattering it through
feature code. This docs app's own `Seam` module is the running example: standard
HTML stays typed (`TypedHtml`), and the genuine escapes go through the library's
two lint-fenced doors. The two-column layout is live; the producers are shown as code.
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
        , description = "A seam is the practice of corralling your userland — vocabulary, layout, and raw-HTML escapes — into one greppable module. Escape through the library's two lint-fenced doors and keep the guarantees."
        , locale = Nothing
        , title = "Your own seam · elm-m3e"
        }
        |> Seo.website


saveButton : Element { s | button : M3e.Kind.Brand } admittedBy msg
saveButton =
    M3e.button [ M3e.Button.variant Value.filled ]
        [ M3e.Button.icon (M3e.icon [ M3e.Icon.name "save" ] [])
        , Seam.text "Save"
        ]


emailField : Element { s | formField : M3e.Kind.Brand } admittedBy msg
emailField =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ M3e.FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for "email-field" ] [ Seam.text "Email address" ])
        , M3e.FormField.child
            (TypedHtml.input
                [ TypedHtml.Attributes.id "email-field"
                , TypedHtml.Attributes.type_ "email"
                , TypedHtml.Attributes.name "email"
                ]
                []
            )
        ]


{-| A userland layout producer: a two-column grid at wide widths. `Seam.div`
is a one-line wrapper over a typed `div` + a class attribute, kept in the app's
one `Seam` module, so feature code names the layout instead of sprinkling raw
class strings around.
-}
twoColumn : Element { s | html : M3e.Kind.Brand } admittedBy msg
twoColumn =
    Seam.div "grid grid-cols-1 gap-4 md:grid-cols-2"
        [ emailField, saveButton ]


{-| The `link` seam filling a _typed slot_. A nav-menu item's `label` slot
accepts the `text` and `link` kinds, so `Seam.link` (the feature-facing re-export
of the `link` seam) drops straight in as an `<a href>` label — no raw HTML, no
break-glass `recast`. The slot's phantom row admits exactly the kinds the design
system declared for it, and the seam produces one of them.
-}
linkNav : Element { s | navMenu : M3e.Kind.Brand } admittedBy msg
linkNav =
    M3e.navMenu []
        [ M3e.NavMenuItem.el { label = Seam.link "/guide/seams" [ Seam.text "Seams" ] } [] []
        , M3e.NavMenuItem.el { label = Seam.link "/guide/the-layers" [ Seam.text "The surfaces" ] } [] []
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Your own seam · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Seam.div "space-y-12"
                    [ Seam.section "space-y-4"
                        [ Doc.pageHeading "Your own seam — one place for your userland"
                        , Seam.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Seam.section "space-y-4"
                        [ Doc.markdown userland
                        , Doc.showcase twoColumn
                        , Doc.code_ Doc.Elm seamCode
                        ]
                    , Seam.section "space-y-4"
                        [ Doc.markdown slotSeam
                        , Doc.showcase linkNav
                        , Doc.code_ Doc.Elm linkNavCode
                        ]
                    , Seam.section "space-y-4"
                        [ Doc.markdown payoff ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Everything you've written on top of the library is **userland** — your own code. Standard HTML is already typed for you (`TypedHtml.div`, `TypedHtml.label`, …), and when you genuinely must step outside the type system the library gives you two loud, lint-fenced doors. A **seam** isn't a library feature — it's the *practice* of keeping all that userland (your vocabulary, your layout helpers, your escapes) in **one greppable module**, so an escape is never scattered through feature code. This docs app does exactly that: everything below lives in one `Seam` module you can audit at a glance."""


userland : String
userland =
    """The two doors, for when you must leave the typed tree: **`Unsafe`** lifts raw `Html` (`fromHtml`) or re-kinds an element to fit any slot (`recast`), and the raw forge **`HtmlIr.Internal`** forges custom tags and attributes (`element`, `attribute`, `on`). Both are fenced by elm-review, so a use outside a blessed module is a lint finding. Your seam module builds *on top* of them — named producers that contain each escape. Here the settings pieces sit in a two-column layout: `Seam.div` is a one-line userland helper over a typed `div`, so feature code names the layout instead of sprinkling raw class strings."""


seamCode : String
seamCode =
    """-- a userland layout producer: the class string contained in one named place
gridWith classes children =
    TypedHtml.div [ TypedHtml.Attributes.class classes ] children

-- a userland text producer: one body, every call site upgrades untouched
text : String -> Element { s | text : M3e.Kind.Brand } adm_ msg
text raw =
    -- swap this one body (e.g. run it through i18n) and every
    -- `Seam.text "…"` call site changes with it — no edits at the sites."""


slotSeam : String
slotSeam =
    """Most "custom" content needs no escape at all — it fills the *typed slots* a component declares. A nav-menu item's `label` slot accepts the `text` **and** `link` kinds, so a nav item can be an ordinary `<a href>` with no raw HTML at the call site. `Seam.link` is just a userland producer of the `link` kind; it drops into the slot because the slot's phantom row admits exactly that kind — no door, no `recast`."""


linkNavCode : String
linkNavCode =
    """-- the label slot admits { text : M3e.Kind.Brand, link : M3e.Kind.Brand }, so the
-- `link` seam fills it directly — a nav item that IS an anchor. The required-record
-- form (`M3e.NavMenuItem.el`) enforces the required `label` at the type level.
linkNav =
    M3e.navMenu []
        [ M3e.NavMenuItem.el { label = Seam.link "/guide/seams" [ Seam.text "Seams" ] } [] []
        , M3e.NavMenuItem.el { label = Seam.link "/guide/the-layers" [ Seam.text "The surfaces" ] } [] []
        ]"""


payoff : String
payoff =
    """That containment is the point. Change the one body of your `Seam.text` producer — pipe it through translation, say — and every call site upgrades without a single edit. And when the design system is *genuinely wrong* for a case, `Seam.recast` is the break-glass: a loud, lint-flagged signal that says "I'm stepping outside on purpose," not a quiet hole. You escaped the types and **kept** the guarantees, because every escape is named, fenced, and in one place."""


recap : String
recap =
    """- A **seam** isn't a library feature — it's the *practice* of keeping your userland (vocabulary, layout, escapes) in **one greppable module**.
- Standard HTML stays typed (`TypedHtml`); the only real escapes are the library's **two lint-fenced doors** — `Unsafe` (`fromHtml`/`recast`) and the `HtmlIr.Internal` forge.
- One producer body ⇒ **every call site upgrades untouched** (e.g. wire `Seam.text` through i18n once).
- **Next: [The tooling refactors for you](/guide/tooling-refactors) →** the linter doesn't just flag escapes — it extracts and rewrites them *for* you."""
