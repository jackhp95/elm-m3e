module Route.Roundtrip exposing (ActionData, Data, Model, Msg, route)

{-| Round-trip verification report (`data/roundtrip-report.json`). Renders a
per-surface summary of the HTML → Elm → HTML round-trip harness plus every cell,
ranked deviations-first. An internal-facing transparency page — utilitarian by
design, no per-component doc shell.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Json.Decode as Decode
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
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


type alias SurfaceAgg =
    { total : Int
    , converted : Int
    , clean : Int
    , usedEscapeHatch : Int
    , roundtripMatched : Int
    , roundtripDeviated : Int
    }


type alias Cell =
    { id : String
    , surface : String
    , title : String
    , converted : Bool
    , seam : Int
    , native : Int
    , charsInside : Int
    , matches : Maybe Bool
    , deviationCount : Int
    }


type alias Data =
    { perSurface : List ( String, SurfaceAgg )
    , cells : List Cell
    }


type alias ActionData =
    {}



-- DECODERS


surfaceAggDecoder : Decode.Decoder SurfaceAgg
surfaceAggDecoder =
    Decode.map6 SurfaceAgg
        (Decode.field "total" Decode.int)
        (Decode.field "converted" Decode.int)
        (Decode.field "clean" Decode.int)
        (Decode.field "usedEscapeHatch" Decode.int)
        (Decode.field "roundtripMatched" Decode.int)
        (Decode.field "roundtripDeviated" Decode.int)


type alias Roundtrip =
    { matches : Bool, deviations : List Decode.Value }


roundtripDecoder : Decode.Decoder Roundtrip
roundtripDecoder =
    Decode.map2 Roundtrip
        (Decode.field "matches" Decode.bool)
        (Decode.field "deviations" (Decode.list Decode.value))


cellDecoder : Decode.Decoder Cell
cellDecoder =
    Decode.map8
        (\id surface title converted seam native charsInside rt ->
            { id = id
            , surface = surface
            , title = title
            , converted = converted
            , seam = seam
            , native = native
            , charsInside = charsInside
            , matches = Maybe.map .matches rt
            , deviationCount =
                rt
                    |> Maybe.map (.deviations >> List.length)
                    |> Maybe.withDefault 0
            }
        )
        (Decode.field "id" Decode.string)
        (Decode.field "surface" Decode.string)
        (Decode.field "title" Decode.string)
        (Decode.field "converted" Decode.bool)
        (Decode.at [ "escapeHatch", "seam", "count" ] Decode.int)
        (Decode.at [ "escapeHatch", "native", "count" ] Decode.int)
        (Decode.at [ "escapeHatch", "charsInside" ] Decode.int)
        (Decode.field "roundtrip" (Decode.nullable roundtripDecoder))


{-| Canonical surface display order; anything unrecognised falls to the end.
-}
surfaceOrder : List String
surfaceOrder =
    [ "top", "mid", "bottom", "record", "build", "barrel" ]


orderSurfaces : List ( String, SurfaceAgg ) -> List ( String, SurfaceAgg )
orderSurfaces pairs =
    let
        rank : String -> Int
        rank name =
            case indexOf name surfaceOrder of
                Just i ->
                    i

                Nothing ->
                    List.length surfaceOrder
    in
    List.sortBy (\( name, _ ) -> rank name) pairs


indexOf : a -> List a -> Maybe Int
indexOf target xs =
    xs
        |> List.indexedMap Tuple.pair
        |> List.filter (\( _, x ) -> x == target)
        |> List.head
        |> Maybe.map Tuple.first


dataDecoder : Decode.Decoder Data
dataDecoder =
    Decode.map2 Data
        (Decode.field "perSurface" (Decode.keyValuePairs surfaceAggDecoder)
            |> Decode.map orderSurfaces
        )
        (Decode.field "cells" (Decode.list cellDecoder))



-- ROUTE


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.File.jsonFile dataDecoder "data/roundtrip-report.json"
        |> BackendTask.allowFatal


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
        , description = "Round-trip verification report: HTML → Elm → HTML fidelity across every elm-m3e API surface."
        , locale = Nothing
        , title = "Round-trip report · elm-m3e"
        }
        |> Seo.website



-- RANKING


rankedCells : List Cell -> List Cell
rankedCells cells =
    let
        rank : Cell -> Int
        rank c =
            if c.matches == Just False then
                0

            else if c.charsInside > 0 then
                1

            else
                2
    in
    List.sortBy (\c -> ( rank c, negate c.charsInside )) cells



-- VIEW


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] items


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Round-trip report" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    { title = "Round-trip report · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ pageHeading
                , Layout.div "mt-2 max-w-2xl"
                    [ Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Every example is converted from HTML to Elm and back to HTML. This page reports, per API surface, how many examples convert, stay clean of escape hatches, and survive the round-trip byte-for-byte. Cells are ranked deviations-first so regressions surface at the top." ]
                    ]
                , summarySection app.data.perSurface
                , cellsSection app.data.cells
                ]
            )
        ]
    }


summarySection : List ( String, SurfaceAgg ) -> Element { s | html : Supported } msg
summarySection perSurface =
    Native.section
        [ Layout.class "mt-12 space-y-4" ]
        [ Native.node (Html.node "h2")
            []
            [ Kit.headline Value.small [] [ Kit.text "Per-surface summary" ] ]
        , Layout.div "space-y-3"
            (List.map surfaceRow perSurface)
        ]


surfaceRow : ( String, SurfaceAgg ) -> Element { s | card : Supported } msg
surfaceRow ( name, agg ) =
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.content
            (Native.node (Html.node "div")
                [ Layout.class "space-y-1" ]
                [ Native.node (Html.node "div")
                    []
                    [ Kit.title Value.medium [ Kit.primary ] [ Kit.text name ] ]
                , Kit.body Value.medium
                    [ Kit.onSurfaceVariant ]
                    [ Kit.text
                        (String.fromInt agg.converted
                            ++ " / "
                            ++ String.fromInt agg.total
                            ++ " converted · "
                            ++ String.fromInt agg.clean
                            ++ " clean · "
                            ++ String.fromInt agg.usedEscapeHatch
                            ++ " used escape hatch"
                        )
                    ]
                , Kit.body Value.medium
                    []
                    [ Kit.text
                        (String.fromInt agg.roundtripMatched
                            ++ " round-trip matched · "
                            ++ String.fromInt agg.roundtripDeviated
                            ++ " deviated"
                        )
                    ]
                ]
            )
        ]


cellsSection : List Cell -> Element { s | html : Supported } msg
cellsSection cells =
    Native.section
        [ Layout.class "mt-12 space-y-4" ]
        [ Divider.view [] []
        , Native.node (Html.node "h2")
            []
            [ Kit.headline Value.small [] [ Kit.text "Cells (deviations first)" ] ]
        , Layout.div "space-y-3"
            (List.map cellRow (rankedCells cells))
        ]


cellRow : Cell -> Element { s | card : Supported } msg
cellRow c =
    let
        deviationText : String
        deviationText =
            if not c.converted then
                "not converted"

            else
                case c.matches of
                    Just True ->
                        "round-trip matched"

                    Just False ->
                        String.fromInt c.deviationCount ++ " deviation(s)"

                    Nothing ->
                        "round-trip not run"

        escapeText : String
        escapeText =
            "seam " ++ String.fromInt c.seam ++ " · native " ++ String.fromInt c.native ++ " · chars " ++ String.fromInt c.charsInside

        deviationColor : List Kit.TextColor
        deviationColor =
            if c.matches == Just False then
                [ Kit.error ]

            else
                [ Kit.onSurfaceVariant ]
    in
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.content
            (Native.node (Html.node "div")
                [ Layout.class "space-y-1" ]
                [ Native.node (Html.node "div")
                    []
                    [ Kit.title Value.medium
                        []
                        [ Native.node (Html.node "code") [] [ Kit.text c.id ] ]
                    ]
                , Kit.body Value.medium deviationColor [ Kit.text deviationText ]
                , Kit.body Value.small [ Kit.onSurfaceVariant ] [ Kit.text escapeText ]
                ]
            )
        ]
