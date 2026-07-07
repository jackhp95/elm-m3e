module Route.Concepts.Userland exposing (ActionData, Data, Model, Msg, route)

{-| A conceptual page (`/concepts/userland`): the governed seams userland gets to
extend, adapt, and escape the generated library — the single `Seam` boundary, the
`Kit` producers built on it, typed native HTML (`Native.*`), and the audited
escape hatch. Drawn from ADOPTION\_AND\_SLOTS.md §8 and `Seam.elm` (ADR 0014).
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
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
        , description = "Userland: the single Seam boundary, Kit producers, typed native HTML, and the audited stripPhantom escape hatch."
        , locale = Nothing
        , title = "Userland · elm-m3e"
        }
        |> Seo.website



-- PAGE CHROME -----------------------------------------------------------------


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] items


type alias Block msg =
    Element { html : Supported, heading : Supported, contentPane : Supported } msg


heading1 : String -> Block msg
heading1 s =
    Heading.view { content = Kit.text s }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


heading2 : String -> Block msg
heading2 s =
    Heading.view { content = Kit.text s }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
        []


lead : String -> Block msg
lead s =
    Layout.div "max-w-2xl"
        [ Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text s ] ]


section : String -> List (Block msg) -> Block msg
section title items =
    Layout.section "space-y-4" (heading2 title :: items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Userland · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ heading1 "Userland"
                        , lead intro
                        ]
                    , section "The seam"
                        [ Doc.markdown seamProse
                        , Doc.code_ Doc.Elm seamCode
                        ]
                    , section "Kit — your team's producers"
                        [ Doc.markdown kitProse
                        , Doc.code_ Doc.Elm kitCode
                        ]
                    , section "Typed native HTML"
                        [ Doc.markdown nativeProse
                        , Doc.code_ Doc.Elm nativeCode
                        ]
                    , section "The escape hatch"
                        [ Doc.markdown escapeProse
                        , Doc.code_ Doc.Elm escapeCode
                        ]
                    , section "The kind universe"
                        [ Doc.markdown universe ]
                    ]
                ]
            )
        ]
    }



-- PROSE -----------------------------------------------------------------------


intro : String
intro =
    "The library is generated and design-system-strict. Userland is everything you write on top of it — and rather than trapping you inside the types, the library hands userland a small, governed set of seams to extend, adapt, and escape without tearing a hole in the type system. The seams are loud, greppable, and fenced to a few blessed modules."


seamProse : String
seamProse =
    """`Seam` is the **single** sanctioned boundary between raw Elm `Html` and the phantom-typed M3e IR (ADR 0014). Every crossing throws away a guarantee, so seams live only in a few blessed adapter modules — `Native`, `Layout`, `Kit`, and each app's designated adapter (in these docs, `Doc`). The elm-review rule `NoSeamOutsideAllowedModules` keeps them fenced there; feature code never reaches for a seam directly.

The crossings split by what they do:

- **`fromHtml` / `asElement` / `asAttribute`** — lift raw `Html` (or a bare `Node`) into the typed IR, stamping whatever phantom row the call site needs.
- **`text` / `link` / `label`** — the *semantic seams*: typed holes the generator emits and your team fills with concrete producers.
- **`stripPhantom` / `forget`** — the loud, greppable "the design system is wrong here" break-glass, covered below."""


seamCode : String
seamCode =
    """fromHtml    : Html msg -> Element supported msg
asElement   : Node msg -> Element supported msg
asAttribute : Html.Attribute msg -> Attr capability msg

-- the semantic seams: typed holes the team fills
text  : String -> Text s msg
link  : String -> List (Element s msg) -> Link s msg
label : List (Element s msg) -> Label s msg"""


kitProse : String
kitProse =
    """`Kit` is this app's userland producer module, built entirely on the seams — and it is what renders the very page you're reading. `Kit.text` is the `text` seam filled with a plain text leaf; swap that one body for an i18n web component and every call site upgrades untouched. That is the whole point of a seam: the *type* is fixed and slot-safe, the *implementation* is yours.

`Kit.paragraph`, `Kit.body`, `Kit.tint`, `Kit.textLink` are ordinary couplers over the seam — precise, slot-safe types, none of them baked into the package. A team forking the library writes its own `Kit`."""


kitCode : String
kitCode =
    """-- Kit.text is the `text` seam, filled — nothing privileged about it:
text : String -> Text s msg
text s =
    Seam.text s

-- ordinary couplers give typed, slot-safe producers over the seam:
paragraph : Size -> List TextColor -> List (Element s msg) -> Element { k | html : Supported } msg

Kit.paragraph Value.large [ Kit.onSurfaceVariant ]
    [ Kit.text "This paragraph is a Kit producer." ]"""


nativeProse : String
nativeProse =
    """`Native` ships the HTML vocabulary as first-class IR `Element`s — `Native.div`, `Native.p`, `Native.a`, `Native.input`, … — so a team gets ordinary HTML **inside** the composition system instead of rolling its own escape. If the library didn't provide these, teams would, worse.

The key detail: their attribute list is the **typed middle-layer `Attr`**, not raw `Html.Attribute`. `Native.a` admits `href`; `Native.input` admits `type_` / `placeholder`; every tag admits `slot`. So you compose the same typed setters onto a plain `<div>` that you would onto an `<m3e-button>`. Non-semantic tags return `Element any` — the widest producer, fitting every slot; semantic tags stamp their real kind (`Native.a` is `link`, `Native.label` is `label`).

Teams wanting design-system purity opt into an elm-review rule that discourages native usage — the guardrail is opt-in, not baked in."""


nativeCode : String
nativeCode =
    """-- typed attrs in, children of any kind in, a slottable Element out:
Native.div
    [ Kit.tint [ Kit.primary ], Layout.class "flex gap-2" ]
    [ Kit.text "hello" ]

-- non-semantic tags go widest — Element any fits every slot:
Native.p : List (Attr c msg) -> List (Element s msg) -> Element any msg

-- a wrong attr is a compile error, not a raw-HTML escape:
Native.input [ Native.href "x" ]   -- ✗ input has no href"""


escapeProse : String
escapeProse =
    """When you must place a kind a slot forbids — you genuinely believe the design system is wrong — you do **not** convert the value. There is deliberately no `phantomA → phantomB` conversion function. Instead you reach for `Seam.stripPhantom`: it coerces the phantom kind row, it's trivial to `grep`, and the design-system team **audits** every use. They either fix the app's misuse or fix the generated binding — so the escape is a feedback signal, not just a hole.

Composition itself stays **add-only**: helpers like `withSlot` or `leadingIcon` only ever *add* a `slot=` association; they never strip or rewrite a kind (the mechanism is [Phantom rows](/concepts/phantom-rows)). `stripPhantom` is the pressure-release valve that keeps the rows strict without trapping users."""


escapeCode : String
escapeCode =
    """-- add-only: withSlot keeps the kind, just associates a slot
withSlot : String -> Element supported msg -> Element supported msg

-- the only escape is loud, greppable, and audited:
stripPhantom : Element a msg -> Element b msg
forget       : Attr a msg -> Attr b msg"""


universe : String
universe =
    """Put together, the kinds an element can be come from four sources, with the raw-`Html` escape implicit on every slot and `stripPhantom` as the explicit, audited override:

> **{ CEM component kinds } ∪ { `any` = open row } ∪ { native-HTML IR } ∪ { userland producers: `text`, `link`, … }**

That is the extensibility gradient: strict by default, open where you ask, and every opening visible in a `grep`."""
