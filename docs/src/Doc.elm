module Doc exposing (Lang(..), code_, rawPreview, showcase)

{-| Shared documentation-rendering helpers, lifted from the Styles/GettingStarted
routes so per-component Usage pages can reuse them.

@docs Lang, code_, rawPreview, showcase

-}

import EscapeHatch
import Html exposing (code, div, node, pre, text)
import Html.Attributes exposing (attribute, class)
import M3e.Card as Card
import M3e.Element exposing (Element)
import M3e.Value as Value exposing (Supported)
import SyntaxHighlight


{-| A matraic-style "showcase" card: live demo content in an outlined card.
-}
showcase : Element { s | html : Supported } msg -> Element { r | card : Supported } msg
showcase content =
    Card.view [ Card.variant Value.outlined ] [ Card.content content ]


{-| Render a raw HTML string as live DOM. The embedded `<m3e-*>` custom elements
upgrade in place (they are registered globally via `@m3e/web/all` in `index.ts`),
inheriting the page's `<m3e-theme>` context — so the preview is live and themed.

Set via the `innerHTML` property (not children), so Elm's virtual DOM leaves the
injected subtree alone. Pre-render emits the empty wrapper; the content populates
on hydration.

-}
rawPreview : String -> Element { s | html : Supported } msg
rawPreview html =
    EscapeHatch.fromHtml
        (node "raw-html"
            [ attribute "content" html
            , class "flex flex-wrap items-center gap-3"
            ]
            []
        )


{-| A syntax-highlighted code block. `Elm` for example code, `NoLang` for raw HTML.
-}
type Lang
    = Elm
    | Json
    | Shell
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
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-sm leading-relaxed text-on-surface"

        parsed : Result () SyntaxHighlight.HCode
        parsed =
            case lang of
                Elm ->
                    SyntaxHighlight.elm trimmed |> Result.mapError (always ())

                Json ->
                    SyntaxHighlight.json trimmed |> Result.mapError (always ())

                Shell ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())

                NoLang ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())
    in
    case parsed of
        Ok highlighted ->
            EscapeHatch.fromHtml
                (div [ class wrapperClass ]
                    [ SyntaxHighlight.toBlockHtml Nothing highlighted ]
                )

        Err _ ->
            EscapeHatch.fromHtml
                (pre [ class wrapperClass ]
                    [ code [] [ text trimmed ] ]
                )
