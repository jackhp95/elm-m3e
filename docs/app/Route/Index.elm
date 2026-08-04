module Route.Index exposing (ActionData, Data, Model, Msg, route)

{-| Documentation home for `m3e-builder` / `elm-m3e` — the type-safe, MISI Elm
builder layer (`M3e.*`) over matraic's `@m3e/web` Material 3 Expressive web
components.

The app shell (`Shared.elm`) owns the `<m3e-theme>`, the top app bar, and the
sidebar nav, so this page is just the hero + highlights content.

-}

import BackendTask exposing (BackendTask)
import Doc
import Doc.Data
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import M3e exposing (Element)
import M3e.Attributes
import M3e.Button
import M3e.Card
import M3e.Heading
import M3e.Icon
import M3e.Kind
import M3e.Values as Value
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes as TA
import TypedHtml.Img
import TypedHtml.Sectioning
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { componentCount : Int }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    Doc.Data.allComponents
        |> BackendTask.map
            (\components ->
                { componentCount =
                    components |> List.filter (\c -> c.category /= "") |> List.length
                }
            )


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Type-safe Material 3 Expressive web components for Elm."
        , locale = Nothing
        , title = "elm-m3e · type-safe Material 3 Expressive for Elm"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    View.fromElement "elm-m3e · type-safe Material 3 Expressive for Elm"
        (Doc.pane
            [ hero
            , highlights app.data.componentCount
            , statusGrid
            ]
        )


hero : Element (TypedHtml.Sectioning.SectionIs s) adm_ msg
hero =
    TypedHtml.section [ TA.class "space-y-5" ]
        [ M3e.heading
            [ M3e.Heading.variant Value.display
            , M3e.Heading.size Value.small
            , M3e.Attributes.level 1
            ]
            [ M3e.text "Type-safe Material 3 Expressive for Elm" ]
        , TypedHtml.div [ TA.class "max-w-2xl" ]
            [ TypedHtml.p [ TA.class "text-body-lg text-on-surface-variant" ]
                [ M3e.text "Material 3 Expressive for Elm, over matraic's "
                , TypedHtml.code [] [ M3e.text "@m3e/web" ]
                , M3e.text " web components — where invalid UIs don't compile. Typed slots, enforced accessible names, and docs whose every example is machine-proven against the real components."
                ]
            ]
        , TypedHtml.div [ TA.class "flex flex-wrap items-center gap-3 pt-2" ]
            [ M3e.button [ M3e.Button.variant Value.filled, M3e.Button.href "/getting-started/installation" ] [ M3e.text "Get started" ]
            , M3e.button [ M3e.Button.variant Value.outlined, M3e.Button.href "/reference" ] [ M3e.text "Browse the API reference" ]
            ]
        , TypedHtml.div [ TA.class "space-y-2 pt-4" ]
            [ M3e.heading [ M3e.Attributes.variant Value.label, M3e.Attributes.size Value.small, TA.class "text-on-surface-variant" ] [ M3e.text "Live theme — try the ⚙ settings in the app bar" ]
            , TypedHtml.div [ TA.class "flex items-center gap-3" ]
                [ M3e.avatar [ Aria.label "Sample avatar" ] [ TypedHtml.Img.img [ TypedHtml.Img.src "/avatar-sample.svg" ] [] ]
                , TypedHtml.div [ TA.class "flex gap-3" ]
                    [ TypedHtml.div [ TA.class "bg-primary text-on-primary block w-10 h-10 rounded-md-corner-large" ] []
                    , TypedHtml.div [ TA.class "bg-tertiary-container text-on-tertiary-container block w-10 h-10 rounded-md-corner-extra-large" ] []
                    , TypedHtml.div [ TA.class "bg-secondary-container text-on-secondary-container block w-10 h-10 rounded-full" ] []
                    ]
                ]
            ]
        ]


{-| The "Why elm-m3e" highlight cards.
-}
highlights : Int -> Element (TypedHtml.Sectioning.SectionIs s) adm_ msg
highlights componentCount =
    TypedHtml.section [ TA.class "space-y-6" ]
        [ Doc.sectionHeading "Why elm-m3e"
        , TypedHtml.div [ TA.class "grid gap-4 sm:grid-cols-3" ]
            [ highlightCard "verified"
                "Type-safe slots"
                "Containers take typed children — an icon slot can only hold a M3e.Icon. Invalid compositions are compile errors — the wrong UI is never a value you can build."
            , highlightCard "category"
                "One import"
                (String.fromInt componentCount ++ " components behind a single import M3e — or component modules when you want tighter types.")
            , highlightCard "palette"
                "Real M3 tokens"
                "Dynamic color, shape, elevation, state layers, density, motion and the full type scale flow from a single <m3e-theme> — switch them live in the app bar."
            ]
        ]


highlightCard : String -> String -> String -> Element { s | card : M3e.Kind.Brand } admittedBy msg
highlightCard iconName cardTitle cardBody =
    M3e.card
        [ M3e.Card.variant Value.elevated ]
        [ M3e.Card.header (M3e.heading [ M3e.Heading.variant Value.title ] [ M3e.text cardTitle ])
        , M3e.Card.content
            (TypedHtml.div [ TA.class "flex gap-3" ]
                [ TypedHtml.div [ TA.class "shrink-0" ]
                    [ M3e.icon [ M3e.Icon.name iconName, TA.class "text-primary" ] [] ]
                , TypedHtml.p [ TA.class "text-body-lg text-on-surface" ] [ M3e.text cardBody ]
                ]
            )
        ]


statusGrid : Element (TypedHtml.Sectioning.SectionIs s) adm_ msg
statusGrid =
    TypedHtml.section [ TA.class "space-y-3" ]
        [ Doc.sectionHeading "Status"
        , TypedHtml.div [ TA.class "max-w-2xl" ]
            [ TypedHtml.p [ TA.class "text-body-lg text-on-surface-variant" ]
                [ M3e.text "Prerelease — breaking changes are embraced while the API settles. Every example in these docs is round-tripped against the real components; the "
                , TypedHtml.a [ TA.href "/roundtrip", TA.class "hover:underline text-primary" ] [ M3e.text "report" ]
                , M3e.text " shows the current score."
                ]
            ]
        ]
