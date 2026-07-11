module Route.Roundtrip exposing (ActionData, Data, Model, Msg, route)

{-| Round-trip verification report (`data/roundtrip-report.json`). Renders a
per-form summary of the HTML → Elm → HTML round-trip harness plus every cell,
ranked deviations-first. An internal-facing transparency page — utilitarian by
design, no per-component doc shell.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Doc
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Json.Decode as Decode
import Kit
import Layout
import M3e
import M3e.Element as Element exposing (Element)
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


type alias SurfaceAgg =
    { total : Int
    , converted : Int
    , clean : Int
    , usedEscapeHatch : Int
    , roundtripMatched : Int
    , roundtripDeviated : Int
    , roundtripFunctionalMatched : Int
    , roundtripFunctionalDeviated : Int
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
    , functionalMatches : Maybe Bool
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
    Decode.map8 SurfaceAgg
        (Decode.field "total" Decode.int)
        (Decode.field "converted" Decode.int)
        (Decode.field "clean" Decode.int)
        (Decode.field "usedEscapeHatch" Decode.int)
        (Decode.field "roundtripMatched" Decode.int)
        (Decode.field "roundtripDeviated" Decode.int)
        (Decode.oneOf [ Decode.field "roundtripFunctionalMatched" Decode.int, Decode.succeed 0 ])
        (Decode.oneOf [ Decode.field "roundtripFunctionalDeviated" Decode.int, Decode.succeed 0 ])


type alias Roundtrip =
    { matches : Bool, functionalMatches : Bool, deviations : List Decode.Value }


roundtripDecoder : Decode.Decoder Roundtrip
roundtripDecoder =
    Decode.map3 Roundtrip
        (Decode.field "matches" Decode.bool)
        (Decode.oneOf [ Decode.field "functionalMatches" Decode.bool, Decode.field "matches" Decode.bool ])
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
            , functionalMatches = Maybe.map .functionalMatches rt
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


{-| Canonical form display order; anything unrecognised falls to the end.
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
        , description = "Round-trip verification report: HTML → Elm → HTML fidelity across every elm-m3e API."
        , locale = Nothing
        , title = "Round-trip report · elm-m3e"
        }
        |> Seo.website



-- RANKING


rankedCells : List Cell -> List Cell
rankedCells cells =
    let
        -- Rank on FUNCTIONAL deviations: true functional mismatches surface
        -- first, then escape-hatch users, then cosmetic-only deviations, then
        -- fully clean cells. A cosmetic-only-deviating cell (functionalMatches
        -- True, matches False) ranks below a genuine functional deviation.
        rank : Cell -> Int
        rank c =
            if c.functionalMatches == Just False then
                0

            else if c.charsInside > 0 then
                1

            else if c.matches == Just False then
                2

            else
                3
    in
    List.sortBy (\c -> ( rank c, negate c.charsInside )) cells



-- VIEW


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
            (Doc.pane
                [ pageHeading
                , Layout.div "mt-2 max-w-2xl"
                    [ Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Every example is converted from HTML to Elm and back to HTML. This page reports, per API, how many examples convert, stay clean of escape hatches, and survive the round-trip. A clean round-trip means no functional deviations — cosmetic differences (class/style, unreferenced ids, and typed-layer role/slot normalization) are recorded but not scored. Cells are ranked functional-deviations-first so real regressions surface at the top." ]
                    ]
                , surfaceLegend
                , summarySection app.data.perSurface
                , cellsSection app.data.cells
                ]
            )
        ]
    }


{-| Legend mapping this page's row names (top/mid/bottom/record/build/barrel) to
the Guide's vocabulary, so the form names aren't undefined jargon. The first
three are layers on the [the layers](/guide/the-layers); record/build are two of
the three [call-shapes](/guide/strictness); barrel is the one-import API the
Guide teaches (see the [reference](/reference)).
-}
surfaceLegend : Element { s | html : Supported } msg
surfaceLegend =
    Native.section
        [ Layout.class "mt-8 max-w-2xl rounded-md-corner-medium bg-surface-container p-4 space-y-2" ]
        [ Kit.overline [ Kit.primary ] [ Kit.text "What the form names mean" ]
        , Layout.div "text-on-surface-variant" [ Doc.markdown surfaceLegendText ]
        ]


surfaceLegendText : String
surfaceLegendText =
    """Each row is one API **form**. The names come from two Guide axes plus the import axis:

| Row | What it is | Guide vocabulary |
| --- | --- | --- |
| **top** | `M3e.Button.view` — typed, slot-safe, composes anywhere. | the top layer of the [the layers](/guide/the-layers) |
| **mid** | `M3e.Html.*` — typed attributes, raw children. | the middle layer ([the layers](/guide/the-layers)) |
| **bottom** | `M3e.Raw.*` — bare tags and attributes. | the bottom layer ([the layers](/guide/the-layers)) |
| **record** | `M3e.Record.Button.view { … }` — required parts can't be forgotten. | the required-record [call-shape](/guide/strictness) |
| **build** | `M3e.Build.Button.button { … }` piped into `build` — one-only setters unwritable twice. | the pipeline [call-shape](/guide/strictness) |
| **barrel** | `M3e.button` — one import; the generic `M3e.variantFilled` / `M3e.slotIcon` vocabulary. | the one-import API the Guide teaches ([reference](/reference)) |

The three layers and the two call-shapes are *different axes*: a layer is how much the types check; a call-shape is what you're forced to supply. The barrel vs a specific `M3e.Button` module is a *third* axis — only which import you reach through."""


summarySection : List ( String, SurfaceAgg ) -> Element { s | html : Supported } msg
summarySection perSurface =
    Native.section
        [ Layout.class "mt-12 space-y-4" ]
        [ Native.node (Html.node "h2")
            []
            [ Kit.headline Value.small [] [ Kit.text "Per-form summary" ] ]
        , Layout.div "space-y-3"
            (List.map surfaceRow perSurface)
        ]


surfaceRow : ( String, SurfaceAgg ) -> Element { s | card : Supported } msg
surfaceRow ( name, agg ) =
    M3e.card
        [ M3e.variantOutlined ]
        [ M3e.cardSlotContent
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
                        (String.fromInt agg.roundtripFunctionalMatched
                            ++ " functional clean · "
                            ++ String.fromInt agg.roundtripFunctionalDeviated
                            ++ " functional deviated"
                        )
                    ]
                , Kit.body Value.small
                    [ Kit.onSurfaceVariant ]
                    [ Kit.text
                        ("(strict: "
                            ++ String.fromInt agg.roundtripMatched
                            ++ " matched · "
                            ++ String.fromInt agg.roundtripDeviated
                            ++ " deviated)"
                        )
                    ]
                ]
            )
        ]


cellsSection : List Cell -> Element { s | html : Supported } msg
cellsSection cells =
    Native.section
        [ Layout.class "mt-12 space-y-4" ]
        [ M3e.divider [] []
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
                case c.functionalMatches of
                    Just False ->
                        String.fromInt c.deviationCount ++ " deviation(s), functional"

                    Just True ->
                        if c.matches == Just False then
                            String.fromInt c.deviationCount ++ " cosmetic deviation(s)"

                        else
                            "round-trip matched"

                    Nothing ->
                        "round-trip not run"

        escapeText : String
        escapeText =
            "seam " ++ String.fromInt c.seam ++ " · native " ++ String.fromInt c.native ++ " · chars " ++ String.fromInt c.charsInside

        deviationColor : List Kit.TextColor
        deviationColor =
            if c.functionalMatches == Just False then
                [ Kit.error ]

            else
                [ Kit.onSurfaceVariant ]
    in
    M3e.card
        [ M3e.variantOutlined ]
        [ M3e.cardSlotContent
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
