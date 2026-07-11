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
import Html
import Kit
import Kit.Shape as Shape
import Kit.Surface as Surface
import Layout
import M3e
import M3e.Action as Action
import M3e.Element as Element exposing (Element)
import M3e.Record.Button as Button
import M3e.Record.Heading as Heading
import M3e.Token as Value exposing (Supported)
import Native
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
    { title = "elm-m3e · type-safe Material 3 Expressive for Elm"
    , body =
        [ Element.toNode
            (Doc.pane
                [ hero
                , highlights app.data.componentCount
                , statusGrid
                ]
            )
        ]
    }


hero : Element { s | html : Supported } msg
hero =
    Layout.section "space-y-5"
        [ Heading.view { content = Kit.text "Type-safe Material 3 Expressive for Elm" }
            [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
            []
        , Layout.div "max-w-2xl"
            [ Kit.paragraph Value.large
                [ Kit.onSurfaceVariant ]
                [ Kit.text "Material 3 Expressive for Elm, over matraic's "
                , Native.node (Html.node "code") [] [ Kit.text "@m3e/web" ]
                , Kit.text " web components — where invalid UIs don't compile. Typed slots, enforced accessible names, and docs whose every example is machine-proven against the real components."
                ]
            ]
        , Layout.div "flex flex-wrap items-center gap-3 pt-2"
            [ Button.view { content = Kit.text "Get started", action = Action.link "/getting-started/installation" } [ Button.variant Value.filled ] []
            , Button.view { content = Kit.text "Browse the API reference", action = Action.link "/reference" } [ Button.variant Value.outlined ] []
            ]
        , Layout.div "space-y-2 pt-4"
            [ Kit.labelText Value.small [ Kit.onSurfaceVariant ] [ Kit.text "Live theme — try the ⚙ settings in the app bar" ]
            , Layout.div "flex items-center gap-3"
                [ M3e.avatar [ M3e.ariaLabel "Sample avatar" ] [ Native.img [ Native.attribute "src" "/avatar-sample.svg" ] ]
                , Layout.div "flex gap-3"
                    [ Surface.view Surface.primary [ Layout.class "block w-10 h-10", Shape.corner Shape.large ] []
                    , Surface.view Surface.tertiaryContainer [ Layout.class "block w-10 h-10", Shape.corner Shape.extraLarge ] []
                    , Surface.view Surface.secondaryContainer [ Layout.class "block w-10 h-10", Shape.corner Shape.full ] []
                    ]
                ]
            ]
        ]


{-| The "Why elm-m3e" highlight cards. The component count is derived from the
single source of truth (`data/reference.json`, the same list that drives the
drawer and the `/components/:name` pages), so the hero, status card, and nav
stay in lockstep — hardcoding it is what let the home page drift (issue #188:
home said 53, the catalogue was 54).
-}
highlights : Int -> Element { s | html : Supported } msg
highlights componentCount =
    Layout.section "space-y-6"
        [ Doc.sectionHeading "Why elm-m3e"
        , Layout.div "grid gap-4 sm:grid-cols-3"
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


highlightCard : String -> String -> String -> Element { s | card : Supported } msg
highlightCard iconName title body =
    M3e.card
        [ M3e.variantElevated ]
        [ M3e.cardSlotHeader (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , M3e.cardSlotContent
            (Layout.div "flex gap-3"
                [ Layout.span "shrink-0"
                    [ Kit.colored [ Kit.primary ] [ M3e.icon [ M3e.attrName iconName ] [] ] ]
                , Kit.paragraph Value.large [ Kit.onSurface ] [ Kit.text body ]
                ]
            )
        ]


statusGrid : Element { s | html : Supported } msg
statusGrid =
    Layout.section "space-y-3"
        [ Doc.sectionHeading "Status"
        , Layout.div "max-w-2xl"
            [ Kit.paragraph Value.large
                [ Kit.onSurfaceVariant ]
                [ Kit.text "Prerelease — breaking changes are embraced while the API settles. Every example in these docs is round-tripped against the real components; the "
                , Kit.textLink "/roundtrip" [ Kit.primary ] [ Kit.text "report" ]
                , Kit.text " shows the current score."
                ]
            ]
        ]
