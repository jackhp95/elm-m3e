module Route.Guide.Strictness exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/strictness`): choose how strict your project is.
The compiler enforces kinds and valid tokens but deliberately leaves the softer
"did you fill the required slot?" loose for components that have nothing
required to forget. For a component that DOES have required parts (like
Button's content/action), its `el` is a required-record from the start — that
strictness is decided by the component, not opted into per call site. You dial
the rest up two ways: a linter that knows your components, and the
required-record shape itself, each promoting one advisory check to a compile
guarantee. The live demo stays the barrel Save button; the required-record
shape is shown as code with its real compiler output.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import M3e exposing (Element)
import M3e.Action
import M3e.Attributes
import M3e.Component.Button
import M3e.Kind
import M3e.Values as Value
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import TypedHtml
import TypedHtml.Attributes as TA
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
        , description = "Start easy and turn safety up by choice. A linter that knows your components, plus stricter call-shapes you opt into per component — no all-or-nothing."
        , locale = Nothing
        , title = "The strictness dial · elm-m3e"
        }
        |> Seo.website


{-| The running Save button, via the barrel's required-record `el` — Button
always demands its content/action, so there is no leaner form to fall back to.
-}
saveButton : Element { s | button : M3e.Kind.Brand } adm_ msg
saveButton =
    M3e.button { content = M3e.text "Save", action = M3e.Action.none }
        [ M3e.Attributes.variant Value.filled ]
        [ M3e.Component.Button.icon (M3e.icon [ TA.name "save" ] []) ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    View.fromElement "The strictness dial"
        (Doc.pane
            [ TypedHtml.div [ TA.class "space-y-12" ]
                [ TypedHtml.section [ TA.class "space-y-4" ]
                    [ Doc.pageHeading "The strictness dial"
                    , TypedHtml.div [ TA.class "max-w-2xl text-on-surface-variant" ] [ Doc.markdown intro ]
                    ]
                , TypedHtml.section [ TA.class "space-y-4" ]
                    [ Doc.markdown linter ]
                , TypedHtml.section [ TA.class "space-y-4" ]
                    [ Doc.markdown shapes
                    , Doc.showcase saveButton
                    , Doc.codeBlock Doc.Elm shapesCode
                    ]
                , TypedHtml.section [ TA.class "space-y-4" ]
                    [ Doc.markdown recordAha
                    , Doc.codeBlock Doc.NoLang recordError
                    ]
                , Doc.recapBox recap
                ]
            ]
        )


intro : String
intro =
    """The compiler holds a lot for you — kinds line up, and only real tokens exist. But it *deliberately* stays quiet about softer questions like "did you fill the slot this component needs?" on the standard surface, because forcing that on every call site would tax the easy path. Strictness here isn't all-or-nothing: **you start easy and turn it up where it's worth it** — project-wide with the linter, or per call site with a stricter surface.

A quick word on vocabulary, since it shows up below: a **surface** is one of a component's interchangeable call-shapes you'll map in full at [the surface map](/guide/the-layers), the **barrel** is the one-import `M3e` API, and a **component module** is a per-component import (`import M3e.Button`) with tighter, component-scoped types."""


linter : String
linter =
    """A linter that knows your components reads the same component list the API was generated from, so it can flag things the types leave loose: an enum token that type-checked through the shared `M3e.Attributes.*` vocabulary but isn't valid for *this* component, a required content slot you left empty, or a child placed in a slot the container doesn't declare (`Cem.ValidSlotKind`). These are **linter-guaranteed, not compiler-guaranteed** — the linter is a separate pass, so it only protects you if you **run elm-review in CI**. Run there, it catches the soft misses the compiler waves through on purpose. (One caveat worth naming: `Cem.ValidSlotKind` is `Lenient` by default and can't resolve a child's kind through a `List.map` or a let-binding, so it's a strong net, not an absolute one.)"""


shapes : String
shapes =
    """Every component ships exactly one `el` shape, and the library — not the call site — decides which: a component with nothing required (like AppBar) gets a bare `el`; a component that can't render without some part (like Button's content/action) gets a required-record `el`. They're **peers, not a ranking** — the shape just follows what the component actually needs:"""


shapesCode : String
shapesCode =
    """-- bare `el` (AppBar has nothing it can't do without) — everything optional
M3e.Component.AppBar.el [ M3e.Component.AppBar.size Value.medium ] [ M3e.Component.AppBar.title (M3e.text "Inbox") ]

-- required-record `el` (Button can't do without content/action) — the compiler DEMANDS the parts
M3e.Component.Button.el
    { content = M3e.text "Save", action = M3e.Action.none }
    []
    []"""


recordAha : String
recordAha =
    """Button's `el` is required-record from the start — there is no leaner form that lets you forget the action. Try leaving it out and the build stops, because the record spells out the parts a button can't render without."""


recordError : String
recordError =
    """The 1st argument to `el` is not what I expect:

4| M3e.Component.Button.el { content = M3e.text "Save" } [] []
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument is a record of type:

    { content : … }

But `el` needs the 1st argument to be:

    { action : Action { … } msg, content : … }"""


recap : String
recap =
    """- The compiler enforces **kinds and valid tokens**; it leaves softer checks loose for components with nothing required.
- **Project-wide:** a linter that knows your components (invalid token for *this* component, empty required slot, foreign slot child) — **linter-guaranteed, so run elm-review in CI**.
- **Per component:** the required-record `el` shape — chosen by the library, not opted into — promotes "don't forget the required parts" to a compile guarantee wherever it applies.
- **Next: [Accessibility you can't forget](/guide/accessible-by-construction) →** the one place strictness is not optional — an accessible name you cannot forget."""
