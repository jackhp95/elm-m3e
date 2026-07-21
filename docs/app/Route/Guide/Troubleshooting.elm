module Route.Guide.Troubleshooting exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/troubleshooting`): the safety net. A scannable
lookup of the common failures — kind mismatch, a class that renders nothing, an
enum token rejected at the loose layer, a missing accessible name, and the big
one: a green linter is not a green build. Each is cause → symptom → fix, with the
real message. Written to stand alone as a reference.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element exposing (Element)
import Layout
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
        , description = "Decode the common failures — kind mismatch, a class that renders nothing, an enum token rejected at the loose layer, a missing accessible name — and remember a green linter is not a green build."
        , locale = Nothing
        , title = "Troubleshooting · elm-m3e"
        }
        |> Seo.website


entry : String -> String -> Element { s | html : M3e.Kind.Brand } adm_ msg
entry prose code =
    Layout.section "space-y-3"
        [ Doc.markdown prose
        , Doc.code_ Doc.NoLang code
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Troubleshooting · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Troubleshooting"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , entry kindMismatch kindMismatchError
                    , entry deadClass deadClassNote
                    , entry looseEnum looseEnumNote
                    , entry missingName missingNameError
                    , Layout.section "space-y-4" [ Doc.markdown greenLint ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """A scannable field guide to the failures you'll actually hit, each as **cause → symptom → fix**. Skim for your symptom; every message here is real output."""


kindMismatch : String
kindMismatch =
    """### A slot won't accept your child

**Cause:** you put content of the wrong *kind* in a slot. **Symptom:** a type error naming the slot, with a record field that "doesn't match." **Fix:** give the slot the kind it accepts — the compiler usually guesses it for you (*"Maybe chip should be icon?"*)."""


kindMismatchError : String
kindMismatchError =
    """This `chip` call produces:
    Element { a | chip : M3e.Kind.Brand, icon : M3e.Kind.Brand, ... } adm_ msg
But `slotIcon` needs the 1st argument to be:
    Element { icon : M3e.Kind.Brand, loadingIndicator : M3e.Kind.Brand } adm_ msg
Hint: Maybe chip should be icon?"""


deadClass : String
deadClass =
    """### A class renders nothing

**Cause:** you wrote a proprietary design-system class (`ds-…` / `t-…`) that ships no CSS in this system, so it silently does nothing. **Symptom:** no error, no style — the element renders bare. **Fix:** the linter flags these dead classes; use a real style token or a seam instead. This is a correctness check, not a style opinion — the class simply has no effect."""


deadClassNote : String
deadClassNote =
    """NoProprietaryDsClasses: `class "ds-card"` renders nothing here —
this class ships no CSS in this system. Use a real token or a seam."""


looseEnum : String
looseEnum =
    """### An enum token type-checks but is rejected

**Cause:** at a looser layer, a token was accepted by the types but isn't valid for *this specific component*. **Symptom:** it compiles, but the linter flags it. **Fix:** use one of the component's real tokens. (At the top layer this can't happen — only the real tokens exist as names, e.g. `M3e.Attributes.variant Value.filled`.)"""


looseEnumNote : String
looseEnumNote =
    """ValidEnumValue: `wobbly` is not a valid `variant` for this component.
Valid tokens: elevated, filled, outlined, text, tonal."""


missingName : String
missingName =
    """### A control has no accessible name

**Cause:** an icon-only control with no visible text and no `aria-label`. **Symptom:** it compiles, but the linter refuses it. **Fix:** add the accessible name — `Aria.label "…"`."""


missingNameError : String
missingNameError =
    """MissingRequiredAttribute: Component `iconButton` requires attribute
`aria-label` but this call doesn't provide it.
Add `Aria.label "..."` to the attrs list."""


greenLint : String
greenLint =
    """### "The linter is clean but the app won't compile"

**Cause:** you're treating the linter as the build. It isn't. The linter catches the *soft* misses the compiler leaves loose on purpose; it does not replace the compiler. **Symptom:** `elm-review` passes, `elm make` fails. **Fix:** a real `elm make` is the authority — read its error (the earlier entries here are all `elm make` output). **A green linter is not a green build.**"""


recap : String
recap =
    """- **Kind mismatch:** give the slot the kind it accepts; the compiler often guesses the fix.
- **Dead class / rejected token / missing name:** the linter catches what types leave loose — read its message.
- **A green linter is not a green build** — `elm make` is the authority.
- **Next: [How we prove it](/guide/how-we-prove-it) →** why you can trust every example in these docs."""
