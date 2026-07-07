module Route.Concepts.TextField exposing (ActionData, Data, Model, Msg, route)

{-| A capstone recipe (`/concepts/text-field`) proving the ADR 0014 seam
architecture composes a real, accessible form control **with no raw HTML
through the seam**. A text field is not a missing component — it is
`M3e.FormField` + a typed native `<input>` + a seam-`text` label, wired by
`for=id`. The fields on the page are genuinely built through that composition,
shown beside their highlighted source.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.FormField as FormField
import M3e.Icon as Icon
import M3e.Native
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
        , description = "A text field is not a component — it composes from M3e.FormField, a typed native <input>, and a seam label wired by for=id."
        , locale = Nothing
        , title = "Text field by composition · elm-m3e"
        }
        |> Seo.website



-- THE COMPOSITION -------------------------------------------------------------


{-| A plain text field: an **outlined `M3e.FormField`** wrapping a seam-`text`
label (`Kit.text`) and a typed native `<input>` (`M3e.Native.input`).
`FormField.label id` stamps `for=id`; `FormField.child id` stamps `id=id` on the
control — so the two share one id and the field renders a real
`<label for=…>` ↔ `<input id=…>` association, no raw HTML through the seam.
-}
emailField : Element { s | formField : Supported } msg
emailField =
    FormField.view
        [ FormField.variant Value.outlined ]
        [ FormField.label "email-field"
            (M3e.Native.label [] [ Kit.text "Email address" ])
        , FormField.hint (Kit.text "We'll never share it.")
        , FormField.child "email-field"
            (M3e.Native.input
                [ M3e.Native.type_ "email"
                , M3e.Native.placeholder "you@example.com"
                , M3e.Native.name "email"
                ]
            )
        ]


{-| A search field: the same composition with a `type="search"` input and a
leading `search` icon in the field's `prefix` slot.
-}
searchField : Element { s | formField : Supported } msg
searchField =
    FormField.view
        [ FormField.variant Value.outlined, FormField.hideRequiredMarker True ]
        [ FormField.label "search-field"
            (M3e.Native.label [] [ Kit.text "Search docs" ])
        , FormField.prefix (Icon.view [ Icon.name "search" ] [])
        , FormField.child "search-field"
            (M3e.Native.input
                [ M3e.Native.type_ "search"
                , M3e.Native.placeholder "Search…"
                , M3e.Native.name "q"
                ]
            )
        ]



-- PAGE ------------------------------------------------------------------------


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


type alias Block msg =
    Element { html : Supported, heading : Supported, contentPane : Supported, formField : Supported, card : Supported } msg


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


section : String -> List (Block msg) -> Block msg
section title items =
    Layout.section "space-y-4" (heading2 title :: items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Text field by composition · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ heading1 "Text field by composition"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , section "A text field"
                        [ Doc.markdown textBody
                        , Doc.showcase (Layout.div "flex flex-col gap-4 max-w-sm" [ emailField ])
                        , Doc.code_ Doc.Elm emailSource
                        ]
                    , section "A search field"
                        [ Doc.markdown searchBody
                        , Doc.showcase (Layout.div "flex flex-col gap-4 max-w-sm" [ searchField ])
                        , Doc.code_ Doc.Elm searchSource
                        ]
                    , section "How the for=id wiring works"
                        [ Doc.markdown wiringBody
                        , Doc.code_ Doc.Elm wiringSource
                        ]
                    ]
                ]
            )
        ]
    }



-- PROSE -----------------------------------------------------------------------


intro : String
intro =
    """Issue #114 asked for a missing `M3e.TextField`. There isn't one — and there doesn't need to be. A text field is **resolved by composition**, not by a new component:

- **`M3e.Native.input`** is a *typed* native `<input>` (ADR 0014 §3, W4). Its attribute row is closed to the attrs HTML permits on an input — `type_`, `placeholder`, `value`, `name`, `checked`, … — so `M3e.Native.input [ M3e.Native.href "x" ]` is a compile error, not a raw-HTML escape.
- **`M3e.FormField`** supplies the Material chrome (label, hint/error subscript, prefix/suffix, outlined/filled variants) and the `for=id` ↔ `id=id` wiring (#11).
- **`Kit.text`** is the seam-`text` coupler for the label content (W3).

Put together, a text field is composable and typed end-to-end, with a real accessible label association and **no raw HTML crossing the seam**."""


textBody : String
textBody =
    """The field below is built through that composition — an outlined `FormField` holds a seam-`text` label, a `hint`, and a typed native `<input type="email">`. `FormField.label "email-field"` and `FormField.child "email-field"` share one id, so the rendered DOM carries a genuine `<label for="email-field">` bound to `<input id="email-field">`:"""


emailSource : String
emailSource =
    """import Kit
import M3e.FormField as FormField
import M3e.Native
import M3e.Value as Value


emailField : Element { s | formField : Supported } msg
emailField =
    FormField.view
        [ FormField.variant Value.outlined ]
        [ FormField.label "email-field"
            (M3e.Native.label [] [ Kit.text "Email address" ])
        , FormField.hint (Kit.text "We'll never share it.")
        , FormField.child "email-field"
            (M3e.Native.input
                [ M3e.Native.type_ "email"
                , M3e.Native.placeholder "you@example.com"
                , M3e.Native.name "email"
                ]
            )
        ]"""


searchBody : String
searchBody =
    """A search field is the *same* composition — swap `type="email"` for `type="search"` and drop a `search` icon into the field's `prefix` slot. No new component, no bespoke `SearchBar` forcing a raw `<input>` through the seam (the original #114 complaint):"""


searchSource : String
searchSource =
    """searchField : Element { s | formField : Supported } msg
searchField =
    FormField.view
        [ FormField.variant Value.outlined, FormField.hideRequiredMarker True ]
        [ FormField.label "search-field"
            (M3e.Native.label [] [ Kit.text "Search docs" ])
        , FormField.prefix (Icon.view [ Icon.name "search" ] [])
        , FormField.child "search-field"
            (M3e.Native.input
                [ M3e.Native.type_ "search"
                , M3e.Native.placeholder "Search…"
                , M3e.Native.name "q"
                ]
            )
        ]"""


wiringBody : String
wiringBody =
    """The label↔control association is not hand-rolled markup — it is stamped by the two `FormField` couplers, which take the id as their first argument (ADR 0010 R6):

- **`FormField.label id el`** places `el` in the `label` slot and stamps `for=id` onto it.
- **`FormField.child id el`** places `el` in the default (control) slot and stamps `id=id` onto it.

Pass the *same* id to both and the field is accessible by construction — the compiler tracks the kinds, `FormField` tracks the association. The `<input>` never needs its own `for`/`id` attributes in your source; the couplers wire them."""


wiringSource : String
wiringSource =
    """-- the couplers stamp the association from a shared id:
FormField.label : String -> Element any msg -> Content { r | label : Supported } msg
FormField.child : String -> Element any msg -> Content { r | default : Supported } msg

-- for=id  ← FormField.label "email-field" …
-- id=id   ← FormField.child "email-field" …
-- one id, one accessible <label for> ↔ <input id> pair, zero raw HTML."""
