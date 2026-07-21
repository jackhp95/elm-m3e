module Route.Guide.ToolingRefactors exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/tooling-refactors`): the wow chapter. The linter
isn't only a catch-net — it _refactors for you_. Two moves: it extracts an
inline raw escape into a named seam and rewrites your call site; and it converts
your whole codebase to one approved form, routing anything the target can't
express through seams (which the boundary check then flags). Shown as real
before/after code, not invented.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Layout
import HtmlIr.Element
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
        , description = "The linter doesn't just flag — it extracts inline escapes into named seams and converts your codebase to one approved form, with autofix."
        , locale = Nothing
        , title = "The tooling refactors for you · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "The tooling refactors for you · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "The tooling refactors for you"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown extract
                        , Doc.code_ Doc.Elm extractBefore
                        , Doc.code_ Doc.Elm extractAfter
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown convert
                        , Doc.code_ Doc.Elm convertBefore
                        , Doc.code_ Doc.Elm convertAfter
                        , Doc.markdown pipeline
                        ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Everything so far had you *reading* the tooling's output — a compile error, a lint message. This chapter flips it: the linter **writes code for you**. It knows your components (it reads the same manifest the API was generated from), so it can not only flag a problem but apply the fix. Here are the two moves that matter."""


extract : String
extract =
    """**One — it extracts seams for you.** You inline a raw escape in a feature module — a stray class on an element. The linter flags it (escapes belong in the fenced seam modules), you run the autofix, and the tool *lifts it into a named seam function and rewrites the call site*. Free variables become arguments; duplicates collapse to one definition. Before:"""


extractBefore : String
extractBefore =
    """-- a raw escape inlined in a feature module (flagged: escapes are fenced)
row [ Seam.asAttribute (class "flex-auto") ] children"""


extractAfter : String
extractAfter =
    """-- after autofix: a named seam, and your call site rewritten to it
row [ flexAuto ] children

-- (lifted into the seam module for you)
flexAuto = Seam.asAttribute (class "flex-auto")"""


convert : String
convert =
    """**Two — it converts your codebase to one approved form.** Pin a canonical form and run the autofix; every call site is rewritten to it. This is real: these docs pin the specific-barrel form, and the linter rewrote every generic slot to its component-specific setter automatically. Before and after, from an actual autofix run:"""


convertBefore : String
convertBefore =
    """-- generic (loose) — what you might write, or teach
M3e.listItem [] [ M3e.slotLeading (M3e.icon [ M3e.attrName "star" ] []) ]"""


convertAfter : String
convertAfter =
    """-- after autofix: the component-specific, kind-precise setter
M3e.listItem [] [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName "star" ] []) ]"""


pipeline : String
pipeline =
    """Anything the target form can't express doesn't vanish — it falls out as **residue routed through a seam**, and the seam-boundary check flags that on the next pass. So the rules interplay as a pipeline: *convert → residue → flag → extract*. You didn't refactor; the linter did, and it converges. Discipline is maintained **for** you."""


recap : String
recap =
    """- The linter **applies fixes**, not just warnings — it knows your components.
- It **extracts inline escapes into named seams** and rewrites the call site (free vars → arguments, duplicates de-dup).
- It **converts your codebase to one approved form**; residue routes through seams and gets flagged next pass.
- **Next: [Troubleshooting](/guide/troubleshooting) →** when something does go wrong, how to read and rescue it."""
