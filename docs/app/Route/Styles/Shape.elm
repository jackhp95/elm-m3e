module Route.Styles.Shape exposing (ActionData, Data, Model, Msg, route)

{-| **Shape** — the M3 Expressive shape system, re-authored on the M3e API
(opus). Two token families: the **corner-radius scale** (`--md-sys-shape-corner-*`,
the rounded rectangles every layer/form clips to) and the **named shapes**
(`M3e.Shape` clip paths). Shape **morphing** — one shape animating into another on
interaction — is the signature of M3 Expressive. Rendered live in the content-pane

  - card pattern.

-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element exposing (Element)
import Kit
import Kit.Surface as Surface
import Layout
import M3e
import M3e.Attributes
import M3e.Kind
import M3e.Shape as Shape
import M3e.Values as Value
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
        , description = "The M3 Expressive shape system: the corner-radius scale, named shapes, and shape morphing."
        , locale = Nothing
        , title = "Shape · elm-m3e"
        }
        |> Seo.website


{-| The canonical M3 corner-radius scale: `(rounded utility, label, rem value)`.
The rounded-md-corner-\* utilities resolve `--radius-md-corner-*` → the
`--md-sys-shape-corner-value-*` tokens (see `sys/shape.css`). Values are the token
literals — do not edit here without editing the token.
-}
cornerScale : List ( String, String, String )
cornerScale =
    [ ( "rounded-md-corner-none", "None", "0" )
    , ( "rounded-md-corner-extra-small", "Extra small", "0.25rem" )
    , ( "rounded-md-corner-small", "Small", "0.5rem" )
    , ( "rounded-md-corner-medium", "Medium", "0.75rem" )
    , ( "rounded-md-corner-large", "Large", "1rem" )
    , ( "rounded-md-corner-large-increased", "Large increased", "1.25rem" )
    , ( "rounded-md-corner-extra-large", "Extra large", "1.75rem" )
    , ( "rounded-md-corner-extra-large-increased", "Extra large increased", "2rem" )
    , ( "rounded-md-corner-extra-extra-large", "Extra extra large", "3rem" )
    , ( "rounded-md-corner-full", "Full", "624.9375rem" )
    ]


cornerSwatch : ( String, String, String ) -> Element { s | html : M3e.Kind.Brand } adm_ msg
cornerSwatch ( rounded, label, value ) =
    Layout.div "flex flex-col gap-2"
        [ Surface.view Surface.primaryContainer
            [ Layout.class (rounded ++ " h-20 w-full") ]
            []
        , Layout.div "flex flex-col"
            [ Kit.labelText Value.large [ Kit.onSurface ] [ Kit.text label ]
            , Kit.code Value.small [ Kit.onSurfaceVariant ] [ Kit.text value ]
            ]
        ]


{-| Named-shape swatches. Kept as a `(token, label)` list mapped through
`namedSwatch` so each token stays a variable at the `Shape.name` call site — the
tokens' open phantom rows unify into one wide record in the list literal, and
passing the token through (rather than a literal enum) keeps the barrel-flatten
rule from firing on a per-shape enum value.
-}
namedShapes : List (Element { s | html : M3e.Kind.Brand } adm_ msg)
namedShapes =
    -- The lambda is inlined (no top-level `namedSwatch` signature) on purpose:
    -- `Shape.name` wants a wide closed record, and the tokens' open phantom rows
    -- only unify into it under inference here inside `List.map`. Keeping the token
    -- a variable (not a literal enum) also keeps the barrel-flatten rule quiet.
    List.map
        (\( token, label ) ->
            Layout.div "flex flex-col items-center gap-2"
                [ Layout.div "contents" [ M3e.shape [ Shape.name token ] [] ]
                , Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text label ]
                ]
        )
        [ ( Value.circle, "Circle" )
        , ( Value.flower, "Flower" )
        , ( Value.heart, "Heart" )
        , ( Value.pill, "Pill" )
        , ( Value.diamond, "Diamond" )
        , ( Value.gem, "Gem" )
        , ( Value.sunny, "Sunny" )
        , ( Value.burst, "Burst" )
        , ( Value.hexagon, "Hexagon" )
        , ( Value.triangle, "Triangle" )
        , ( Value.oval, "Oval" )
        , ( Value.arch, "Arch" )
        ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.Attributes.variant Value.display, M3e.Attributes.size Value.small, M3e.Attributes.level 1 ]
        [ M3e.text "Shape" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Shape · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Material 3 has two shape families. The corner-radius scale rounds every rectangular surface (cards, buttons, sheets) via --md-sys-shape-corner-* tokens. The named shapes are M3 Expressive clip paths — circles, flowers, stars — for hero surfaces and emphasis. Shape morphing, one shape springing into another on press or selection, is the signature move of M3 Expressive." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Corner-radius scale"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Nine canonical sizes from none through extra-extra-large, plus full (a pill). Each swatch is a primary-container surface clipped with the matching rounded-md-corner-* utility; the caption is the token's rem value." ]
                        ]
                    , Doc.showcase
                        (Layout.div "grid grid-cols-2 gap-6 sm:grid-cols-3 lg:grid-cols-5"
                            (List.map cornerSwatch cornerScale)
                        )
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Named shapes"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "M3e.shape clips a filled tile to a named shape via Shape.name Value tokens — the same clip-path set Material uses for expressive surfaces." ]
                        ]
                    , Doc.showcase
                        (Layout.div "grid grid-cols-3 gap-6 sm:grid-cols-4 lg:grid-cols-6" namedShapes)
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Shape morphing"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "The defining M3 Expressive interaction: a shape animates between two states rather than snapping. Buttons carry a full set of morph tokens for exactly this — a round or square resting shape and a distinct pressed shape it springs to and back from." ]
                        ]
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ Native.node "li" []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "--md-sys-shape-corner-*" ]
                                , Kit.text " — the resting corner scale above."
                                ]
                            ]
                        , Native.node "li" []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "--m3e-button-*-shape-round / -shape-square" ]
                                , Kit.text " — a button's resting shape per size variant."
                                ]
                            ]
                        , Native.node "li" []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "--m3e-button-*-shape-pressed-morph" ]
                                , Kit.text " — the pressed shape it morphs to, then springs back on release."
                                ]
                            ]
                        ]
                    ]
                ]
            )
        ]
    }
