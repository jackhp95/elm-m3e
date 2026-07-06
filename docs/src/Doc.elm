module Doc exposing (Lang(..), anchorPill, code_, elmSignature, markdown, message, preBlock, rawPreview, showcase)

{-| Shared documentation-rendering helpers, lifted from the Styles/GettingStarted
routes so per-component Usage pages can reuse them.

This is also the docs app's designated **Seam adapter** (ADR 0014 §2): the doc
routes render syntax-highlighted code, Markdown, and small raw-HTML leaves that
have no typed M3e producer, so those raw-`Html`→`Element` crossings are
centralised here as named helpers (`rawPreview`, `markdown`, `code_`,
`elmSignature`, `anchorPill`, `preBlock`, `message`) instead of scattering
`Seam.fromHtml` through feature routes.

@docs Lang, anchorPill, code_, elmSignature, markdown, message, preBlock, rawPreview, showcase

-}

import Html exposing (Html, a, code, div, node, p, pre, text)
import Html.Attributes exposing (attribute, class, href)
import M3e.Card as Card
import M3e.Element exposing (Element)
import M3e.Value as Value exposing (Supported)
import Markdown.Parser
import Markdown.Renderer
import Seam
import SyntaxHighlight


{-| A matraic-style "showcase" card: live demo content in an outlined card.
-}
showcase : Element { s | html : Supported } msg -> Element { r | card : Supported } msg
showcase content =
    Card.view
        [ Card.variant Value.outlined, Seam.asAttribute (class "max-w-full overflow-x-auto") ]
        [ Card.content content ]


{-| Render a raw HTML string as live DOM. The embedded `<m3e-*>` custom elements
upgrade in place (they are registered globally via `@m3e/web/all` in `index.ts`),
inheriting the page's `<m3e-theme>` context — so the preview is live and themed.

Set via the `innerHTML` property (not children), so Elm's virtual DOM leaves the
injected subtree alone. Pre-render emits the empty wrapper; the content populates
on hydration.

-}
rawPreview : String -> Element { s | html : Supported } msg
rawPreview html =
    Seam.fromHtml
        (node "raw-html"
            [ attribute "content" html
            , class "flex max-w-full flex-wrap items-center gap-3 overflow-x-auto"
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
code_ : Lang -> String -> Element { s | html : Supported } msg
code_ lang s =
    let
        trimmed : String
        trimmed =
            String.trim s

        wrapperClass : String
        wrapperClass =
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-md leading-relaxed text-on-surface"

        parsed : Result () SyntaxHighlight.HCode
        parsed =
            case lang of
                Elm ->
                    SyntaxHighlight.elm trimmed |> Result.mapError (always ())

                Json ->
                    SyntaxHighlight.json trimmed |> Result.mapError (always ())

                Shell ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())

                Xml ->
                    SyntaxHighlight.xml trimmed |> Result.mapError (always ())

                NoLang ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())
    in
    case parsed of
        Ok highlighted ->
            Seam.fromHtml
                (div [ class wrapperClass ]
                    [ SyntaxHighlight.toBlockHtml Nothing highlighted ]
                )

        Err _ ->
            Seam.fromHtml
                (pre [ class wrapperClass ]
                    [ code [] [ text trimmed ] ]
                )


{-| Render a Markdown string (component overviews, member docs) as live DOM.
Falls back to the raw text in a paragraph if parsing/rendering fails, so a
malformed doc-comment never blanks the page. The `doc-prose` wrapper carries
the prose spacing/typography from `style.css`.
-}
markdown : String -> Element { s | html : Supported } msg
markdown raw =
    Seam.fromHtml
        (div [ class "doc-prose" ] (markdownBody raw))


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


{-| A syntax-highlighted Elm type signature (for API member rows). Rendered as an
inline `<code>` block so it wraps within the list item; falls back to plain text
if it doesn't tokenize as Elm.
-}
elmSignature : String -> Element { s | html : Supported } msg
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
anchorPill : { href : String, label : String } -> Element { s | html : Supported } msg
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
preBlock : String -> Element { s | html : Supported } msg
preBlock s =
    Seam.fromHtml
        (pre [ class "overflow-x-auto" ]
            [ code [] [ text s ] ]
        )


{-| A minimal `<div><p>…</p></div>` text block, for framework surfaces (e.g. the
error page) that render a plain message with no typed M3e producer at hand.
-}
message : String -> Element { s | html : Supported } msg
message body =
    Seam.fromHtml
        (div [] [ p [] [ text body ] ])
