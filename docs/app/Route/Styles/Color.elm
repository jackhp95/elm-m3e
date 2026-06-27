module Route.Styles.Color exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, p, section, text)
import Html.Attributes exposing (class)
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Heading as Heading
import M3e.Node as Node
import M3e.Renderable as Renderable
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
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "The M3 color roles, rendered live from the dynamic scheme."
        , locale = Nothing
        , title = "Color · elm-m3e"
        }
        |> Seo.website


toHtml : Renderable.Renderable any msg -> Html msg
toHtml r =
    r |> Renderable.toNode |> Node.toHtml


{-| (label, bg utility, on-color utility) for each M3 color role pair.
-}
roles : List ( String, String, String )
roles =
    [ ( "Primary", "bg-primary", "text-on-primary" )
    , ( "On Primary Container", "bg-primary-container", "text-on-primary-container" )
    , ( "Secondary", "bg-secondary", "text-on-secondary" )
    , ( "Secondary Container", "bg-secondary-container", "text-on-secondary-container" )
    , ( "Tertiary", "bg-tertiary", "text-on-tertiary" )
    , ( "Tertiary Container", "bg-tertiary-container", "text-on-tertiary-container" )
    , ( "Error", "bg-error", "text-on-error" )
    , ( "Error Container", "bg-error-container", "text-on-error-container" )
    , ( "Surface", "bg-surface", "text-on-surface" )
    , ( "Surface Container", "bg-surface-container", "text-on-surface" )
    , ( "Surface Container High", "bg-surface-container-high", "text-on-surface" )
    , ( "Inverse Surface", "bg-inverse-surface", "text-inverse-on-surface" )
    ]


swatch : ( String, String, String ) -> Html msg
swatch ( label, bg, on ) =
    div [ class ("flex flex-col justify-between rounded-md-corner-medium border border-outline-variant p-4 min-h-24 " ++ bg ++ " " ++ on) ]
        [ Html.span [ class "text-label-lg font-medium" ] [ text label ]
        , code [ class "text-body-sm opacity-80" ] [ text bg ]
        ]


pageHeading : Html msg
pageHeading =
    Heading.view { label = "Color", variant = Heading.Display }
        [ Heading.size Heading.Small, Heading.level 1 ]
        |> toHtml


sectionHeading : String -> Html msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Small, Heading.level 2 ]
        |> toHtml


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Color · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                    [ text "Material 3 derives a full set of semantic color roles from a single source color via the dynamic-color engine in <m3e-theme>. Every role is a --md-sys-color-* token; the swatches below are live — change the source color, scheme, or contrast in the app bar settings and they re-derive." ]
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "Color roles"
                , div [ class "grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3" ]
                    (List.map swatch roles)
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "Dynamic color"
                , p [ class "max-w-2xl text-body-md text-on-surface-variant" ]
                    [ text "<m3e-theme> wraps Material's material-color-utilities to derive a full scheme from a seed at runtime. Swap the source color in the app bar to see every role above re-derive instantly." ]
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "Forced colors"
                , p [ class "max-w-2xl text-body-md text-on-surface-variant" ]
                    [ text "When the OS reports forced-colors (Windows High Contrast), components map their semantic roles onto the system palette automatically. No app changes required." ]
                , forcedColorsCard
                ]
            ]
        ]
    }


forcedColorsCard : Html msg
forcedColorsCard =
    Card.view
        [ Card.variant Card.Outlined
        , Card.headline (Heading.view { label = "Test it", variant = Heading.Title } [])
        , Card.body
            [ Renderable.html
                (text "Enable Windows High Contrast or `forced-colors: active` in dev tools. The swatches above stay legible because every role respects the forced palette.")
            ]
        ]
        |> Renderable.toNode
        |> Node.toHtml
