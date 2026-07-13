module Doc exposing (Lang(..), anchorPill, code_, elmSignature, markdown, message, pageHeading, pane, preBlock, rawPreview, recapBox, sectionHeading, showcase, userlandNote)

{-| Shared documentation-rendering helpers, lifted from the Styles/GettingStarted
routes so per-component Usage pages can reuse them.

This is also the docs app's designated **Seam adapter** (see `docs/DESIGN.md` §4): the doc
routes render syntax-highlighted code, Markdown, and small raw-HTML leaves that
have no typed M3e producer, so those raw-`Html`→`Element` crossings are
centralised here as named helpers (`rawPreview`, `markdown`, `code_`,
`elmSignature`, `anchorPill`, `preBlock`, `message`) instead of scattering
`Seam.fromHtml` through feature routes.

@docs Lang, anchorPill, code_, elmSignature, markdown, message, pageHeading, pane, preBlock, rawPreview, recapBox, sectionHeading, showcase, userlandNote

-}

import Doc.Fold as Fold
import Html exposing (Html, a, code, div, node, p, pre, text)
import Html.Attributes exposing (attribute, class, href)
import Kit
import Layout
import M3e
import M3e.Kind
import Markup.Atoms
import Markup.Element exposing (Element)
import Markdown.Parser
import Markdown.Renderer
import Seam
import SyntaxHighlight


{-| A matraic-style "showcase" card: live demo content in an outlined card.

Deliberately NOT an overflow container: making the card `overflow-x-auto` forces
`overflow-y: auto` (CSS spec), and m3e components' ~4px state-layer bleed then
trips a spurious vertical scrollbar. The inner preview (`rawPreview`) wraps its
items instead, so the card stays within `max-w-full` without clipping — a live
example's escaping menu/tooltip is free to overflow the card.

-}
showcase : Element { s | html : M3e.Kind.Brand } msg -> Element { r | card : M3e.Kind.Brand } msg
showcase content =
    M3e.card
        [ M3e.variantOutlined, Seam.asAttribute (class "max-w-full") ]
        [ M3e.cardSlotContent content ]


{-| Render a raw HTML string as live DOM. The embedded `<m3e-*>` custom elements
upgrade in place (they are registered globally via `@m3e/web/all` in `index.ts`),
inheriting the page's `<m3e-theme>` context — so the preview is live and themed.

Set via the `innerHTML` property (not children), so Elm's virtual DOM leaves the
injected subtree alone. Pre-render emits the empty wrapper; the content populates
on hydration.

-}
rawPreview : String -> Element { s | html : M3e.Kind.Brand } msg
rawPreview html =
    Seam.fromHtml
        (node "raw-html"
            [ attribute "content" html

            -- Plain block flow, matching matraic's `.showcase` (which sets no
            -- flex): each component uses its own `display`, so inline components
            -- (buttons/chips) flow and wrap while full-width components (linear
            -- progress, sliders, dividers, text fields) fill the row. No flex
            -- row — that collapses width-less components to min-content. No
            -- overflow clipping either: an escaping menu/tooltip must be free to
            -- leave the card, and `overflow-x-auto` would force a spurious
            -- vertical scrollbar off the ~4px state-layer bleed.
            , class "max-w-full py-2"
            ]
            []
        )


{-| A syntax-highlighted code block. `Elm` for example code, `NoLang` for raw HTML.
-}
type Lang
    = Elm
    | Json
    | Shell
    | Xml
    | NoLang


{-| -}
code_ : Lang -> String -> Element { s | html : M3e.Kind.Brand } msg
code_ lang s =
    let
        trimmed : String
        trimmed =
            String.trim s

        wrapperClass : String
        wrapperClass =
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-md leading-relaxed text-on-surface"
    in
    -- Auto-derived folding: the fold tree is computed from the raw
    -- string and highlighted per line, so we assemble nested `<details>`
    -- ourselves rather than emitting one flat highlighted block.
    Seam.fromHtml
        (div [ class wrapperClass ]
            [ Fold.viewWith (highlightLine lang) trimmed ]
        )


{-| Highlight a single code line, keeping the `.elmshN` token classes. Falls
back to plain text if the line doesn't tokenize (never crashes; per-line
highlighting can lose multi-line context, but example code rarely has it).
-}
highlightLine : Lang -> String -> Html msg
highlightLine lang line =
    let
        parsed : Result () SyntaxHighlight.HCode
        parsed =
            (case lang of
                Elm ->
                    SyntaxHighlight.elm line

                Json ->
                    SyntaxHighlight.json line

                Shell ->
                    SyntaxHighlight.noLang line

                Xml ->
                    SyntaxHighlight.xml line

                NoLang ->
                    SyntaxHighlight.noLang line
            )
                |> Result.mapError (always ())
    in
    case parsed of
        Ok highlighted ->
            SyntaxHighlight.toInlineHtml highlighted

        Err _ ->
            text line


{-| Render a Markdown string (component overviews, member docs) as live DOM.
Falls back to the raw text in a paragraph if parsing/rendering fails, so a
malformed doc-comment never blanks the page. The `doc-prose` wrapper carries
the prose spacing/typography from `style.css`.
-}
markdown : String -> Element { s | html : M3e.Kind.Brand } msg
markdown raw =
    Seam.fromHtml
        (div [ class "doc-prose" ] (markdownBody raw))


{-| The route content pane: the standard `M3e.contentPane` wrapper every docs
route hands to `Element.toNode` at its root.
-}
pane : List (Element { s | html : M3e.Kind.Brand } msg) -> Element { r | contentPane : M3e.Kind.Brand } msg
pane items =
    M3e.contentPane [] items


{-| A page's `<h1>`: display-small heading.
-}
pageHeading : String -> Element { s | heading : M3e.Kind.Brand } msg
pageHeading s =
    M3e.heading [ M3e.variantDisplay, M3e.sizeSmall, M3e.attrLevel 1 ] [ Markup.Atoms.text s ]


{-| A section's `<h2>`: headline-small heading.
-}
sectionHeading : String -> Element { s | heading : M3e.Kind.Brand } msg
sectionHeading s =
    M3e.heading [ M3e.variantHeadline, M3e.sizeSmall, M3e.attrLevel 2 ] [ Markup.Atoms.text s ]


{-| The chapter recap box: an "Recap" overline over rendered markdown, in a
tinted container.
-}
recapBox : String -> Element { s | html : M3e.Kind.Brand } msg
recapBox md =
    Layout.div "rounded-md-corner-medium bg-surface-container p-4 space-y-2"
        [ Kit.overline [ Kit.primary ] [ Kit.text "Recap" ]
        , Layout.div "text-on-surface-variant" [ markdown md ]
        ]


markdownBody : String -> List (Html msg)
markdownBody raw =
    let
        rendered : Result () (List (Html msg))
        rendered =
            Markdown.Parser.parse raw
                |> Result.mapError (always ())
                |> Result.andThen
                    (\blocks ->
                        Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer blocks
                            |> Result.mapError (always ())
                    )
    in
    case rendered of
        Ok html ->
            html

        Err _ ->
            [ p [] [ text (String.trim raw) ] ]


{-| A labelled callout box — an eyebrow label over Markdown body — for asides that
must not read as body prose (e.g. "these modules are yours to write"). The body is
full Markdown, so it can carry links and inline `code`. Styled with the same surface
tokens as the rest of the docs; a left accent bar marks it as a notice, not content.
-}
callout : String -> String -> Element { s | html : M3e.Kind.Brand } msg
callout label body =
    Seam.fromHtml
        (div
            [ class "rounded-md-corner-medium bg-surface-container border-l-4 border-primary p-4 space-y-2" ]
            [ div [ class "text-label-md text-primary uppercase tracking-wide" ] [ text label ]
            , div [ class "doc-prose text-on-surface-variant" ] (markdownBody body)
            ]
        )


{-| The shared "these are userland modules you write" callout, used everywhere an
example first leans on `Kit` / `Native` / `Layout` / `Seam`. These names are NOT in
the package's `exposed-modules`: they live in `docs/kit/` as copyable starters, so a
reader who pastes `Kit.text` into a fresh project must know to bring the module along.
One definition, so the framing can't drift between pages.
-}
userlandNote : Element { s | html : M3e.Kind.Brand } msg
userlandNote =
    callout "You write these"
        """`Kit`, `Native`, `Layout`, and `Seam` in these examples are **your own modules**, not part of the `elm-m3e` package — they won't resolve from a fresh install. The library ships the typed components (`M3e.*`); *you* supply the userland vocabulary that fills the gaps: `Kit.text` and typography, `Native` HTML producers, `Layout` wrappers, and the `Seam` escape hatch. Copy the paste-able starters from [`docs/kit/`](https://github.com/jackhp95/elm-m3e/tree/main/docs/kit) and adapt them, or write your own — see [Your own seam](/guide/seams)."""


{-| A syntax-highlighted Elm type signature (for API member rows). Rendered as an
inline `<code>` block so it wraps within the list item; falls back to plain text
if it doesn't tokenize as Elm.
-}
elmSignature : String -> Element { s | html : M3e.Kind.Brand } msg
elmSignature s =
    let
        trimmed : String
        trimmed =
            String.trim s
    in
    case SyntaxHighlight.elm trimmed of
        Ok highlighted ->
            Seam.fromHtml
                (div [ class "text-body-md leading-relaxed" ]
                    [ SyntaxHighlight.toInlineHtml highlighted ]
                )

        Err _ ->
            Seam.fromHtml
                (code [ class "text-body-md" ] [ text trimmed ])


{-| A rounded "pill" anchor for the reference index (a same-page `#slug` link
carrying the outline/hover chrome). Raw `<a>` because the library doesn't
opinionate plain navigation anchors.
-}
anchorPill : { href : String, label : String } -> Element { s | html : M3e.Kind.Brand } msg
anchorPill link =
    Seam.fromHtml
        (a
            [ href link.href
            , class "rounded-full border border-outline px-3 py-1 text-label-md text-on-surface-variant hover:bg-surface-container hover:text-on-surface no-underline"
            ]
            [ text link.label ]
        )


{-| A horizontally-scrollable `<pre><code>` block for a verbatim signature line.
-}
preBlock : String -> Element { s | html : M3e.Kind.Brand } msg
preBlock s =
    Seam.fromHtml
        (pre [ class "overflow-x-auto" ]
            [ code [] [ text s ] ]
        )


{-| A minimal `<div><p>…</p></div>` text block, for framework surfaces (e.g. the
error page) that render a plain message with no typed M3e producer at hand.
-}
message : String -> Element { s | html : M3e.Kind.Brand } msg
message body =
    Seam.fromHtml
        (div [] [ p [] [ text body ] ])
