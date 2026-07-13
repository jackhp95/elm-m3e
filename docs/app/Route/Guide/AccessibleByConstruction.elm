module Route.Guide.AccessibleByConstruction exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/accessible-by-construction`): accessibility as
structure, not a checklist. An icon-only control has no visible text, so its
accessible name is required. The Aria setters are first-class on every
component, and the codegen-aware `missingRequiredAttribute` rule reads the
per-component facts and refuses a nameless control when elm-review runs in CI.
The running example gains an icon-only help button (labeled, live); the nameless
version is shown as code beside the rule's real output.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Layout
import M3e
import Markup.Element as Element exposing (Element)
import M3e.Kind
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
        , description = "An icon-only control's accessible name is required. The Aria setters are first-class, and the codegen-aware missingRequiredAttribute linter rule refuses a nameless control when elm-review runs in CI."
        , locale = Nothing
        , title = "Accessibility you can't forget · elm-m3e"
        }
        |> Seo.website


{-| An icon-only help button — WITH its accessible name. This is the version
you should ship and it renders. The nameless version is shown only as code,
beside the real output of the `missingRequiredAttribute` rule.
-}
helpButton : Element { s | iconButton : M3e.Kind.Brand } msg
helpButton =
    M3e.iconButton [ M3e.ariaLabel "Help" ]
        [ M3e.icon [ M3e.attrName "help" ] [] ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Accessibility you can't forget · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Accessibility you can't forget"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown labeled
                        , Doc.showcase helpButton
                        , Doc.code_ Doc.Elm labeledCode
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown nameless
                        , Doc.code_ Doc.Elm namelessCode
                        , Doc.code_ Doc.NoLang linterText
                        , Doc.markdown wiring
                        ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Accessibility here is built into the shape of the components, not bolted on as a checklist at the end. The clearest case: a control with no visible text. Our settings panel needs a small **help** button that's just an icon. A sighted user sees a "?"; a screen-reader user needs a name to read. So that name is **required** — and the accessible-name attributes (`M3e.ariaLabel`, `labelledby`, `describedby`) are first-class setters on every component, right where you'd reach for them."""


labeled : String
labeled =
    """Add the help button *with* its accessible name and it's fine — this renders, and it announces itself as "Help":"""


labeledCode : String
labeledCode =
    """M3e.iconButton [ M3e.ariaLabel "Help" ]
    [ M3e.icon [ M3e.attrName "help" ] [] ]"""


nameless : String
nameless =
    """Now drop the name. The component list the API was generated from records that an icon button **requires** an accessible name — and the codegen-aware `missingRequiredAttribute` rule reads that same list, so in a project that runs elm-review this does not pass CI. The message below is the rule's real output:"""


namelessCode : String
namelessCode =
    """M3e.iconButton []
    [ M3e.icon [ M3e.attrName "help" ] [] ]"""


linterText : String
linterText =
    """MissingRequiredAttribute: Component `iconButton` requires attribute `aria-label`
but this call doesn't provide it

The Material 3 spec (and accessibility guidance) treats `aria-label` as required
for iconButton.

Add `M3e.Aria.label "..."` to the attrs list."""


wiring : String
wiring =
    """This is "accessible by construction" in practice: the requirement lives in the component's own definition — the same facts file the rest of the linter reads — so CI refuses the unlabeled control instead of a human having to remember. It is a linter guarantee, not a compiler one, so it protects you when elm-review runs in CI. And when a control has a visible label — like the text fields we build next — the label and input are wired from one shared id, so you never hand-type a matching `for`/`id` pair."""


recap : String
recap =
    """- An icon-only control has no visible text, so its **accessible name is required**.
- The Aria setters are **first-class**, and `missingRequiredAttribute` **refuses a nameless control in CI** — a linter guarantee, so run elm-review there.
- Visible labels are **wired to their input for you** from one shared id — no hand-typed `for`/`id`.
- **Next: [Composition, not injection](/guide/composition-text-field) →** build a text field that doesn't exist as a component — by composition."""
