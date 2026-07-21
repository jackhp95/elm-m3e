module Route.Reference exposing (ActionData, Data, Model, Msg, route)

{-| Complete API reference for every M3e.\* module, extracted from the library
source at build time (scripts/extract-reference.mjs -> data/reference.json).
Accurate by construction — module overviews plus every exposed member's
signature and doc comment.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Doc
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import HtmlIr.Element as Element exposing (Element)
import Json.Decode as Decode
import Kit
import Layout
import M3e
import TypedHtml.Attributes as TA
import M3e.Attributes
import M3e.Card
import M3e.Heading
import M3e.Kind
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


type alias Member =
    { name : String, kind : String, signature : String, doc : String, role : String }


type alias Component =
    { name : String, moduleName : String, slug : String, overview : String, members : List Member }


type alias Data =
    List Component


type alias ActionData =
    {}


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.map5 Member
        (Decode.field "name" Decode.string)
        (Decode.field "kind" Decode.string)
        (Decode.field "signature" Decode.string)
        (Decode.field "doc" Decode.string)
        (Decode.oneOf [ Decode.field "role" Decode.string, Decode.succeed "" ])


componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map5 Component
        (Decode.field "name" Decode.string)
        (Decode.field "module" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.field "overview" Decode.string)
        (Decode.field "members" (Decode.list memberDecoder))


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
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
        , description = "Complete API reference for every elm-m3e M3e.* component module."
        , locale = Nothing
        , title = "elm-m3e · component reference"
        }
        |> Seo.website


pageHeading : Element { s | heading : M3e.Kind.Brand } admittedBy msg
pageHeading =
    M3e.heading
        [ M3e.Heading.variant Value.display
        , M3e.Heading.size Value.small
        , M3e.Attributes.level 1
        ]
        [ M3e.text "Component reference" ]


{-| The one-import barrel module (`module M3e`) is split out of the alphabetical
component list and pinned to the top: it is the form the Guide teaches
(`M3e.button`, `M3e.Attributes.variant Value.filled`, `M3e.slotIcon`, `TA.name`), so it earns
its own role-grouped section rather than sorting in among the components.
-}
splitBarrel : List Component -> ( Maybe Component, List Component )
splitBarrel components =
    ( List.filter (\c -> c.moduleName == "M3e") components |> List.head
    , List.filter (\c -> c.moduleName /= "M3e") components
    )


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    let
        ( barrel, componentModules ) =
            splitBarrel app.data
    in
    { title = "elm-m3e · component reference"
    , body =
        [ Element.toNode
            (Doc.pane
                [ pageHeading
                , Layout.div "mt-2 max-w-2xl"
                    [ Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Every "
                        , Native.node "code" [] [ Kit.text "M3e.*" ]
                        , Kit.text " module, its overview, and every exposed value — extracted from the library source at build time."
                        ]
                    ]
                , twoForms
                , case barrel of
                    Just b ->
                        barrelBlock b

                    Nothing ->
                        Kit.text ""
                , indexGrid componentModules
                , Layout.div "mt-12 space-y-12"
                    (List.map componentBlock componentModules)
                ]
            )
        ]
    }


{-| The one "two forms" explainer, shared vocabulary with the Guide: the
generic **barrel** teaching form vs the precise **specific-module** form.
Keeps the reference's terminology aligned with `/guide/the-layers` and
`/guide/strictness` so a reader never meets a fifth name for the same idea.
-}
twoForms : Element { s | html : M3e.Kind.Brand } admittedBy msg
twoForms =
    Layout.div "mt-8 max-w-2xl rounded-md-corner-medium bg-surface-container p-4 space-y-2"
        [ Kit.overline [ Kit.primary ] [ Kit.text "Two forms" ]
        , Layout.div "text-on-surface-variant" [ Doc.markdown twoFormsText ]
        ]


twoFormsText : String
twoFormsText =
    """Every component is reachable two ways — same output, different import and different strictness:

- The **barrel** (`import M3e`) — one import for everything. `M3e.button`, the shared `M3e.Attributes.variant Value.filled` / `M3e.slotIcon` / `TA.name` vocabulary. This is the form the [Guide](/guide/the-layers) teaches; it's the generic, easy form.
- The **component module** (`import M3e.Button`) — `M3e.Button.view` and its component-scoped `M3e.Button.variant` / slot setters. More precise: the compiler rejects a token or slot child that isn't valid for *that* component.

Neither is a layer on the [the layers](/guide/the-layers) and neither is one of the three [call-shapes](/guide/strictness) — those are separate axes. This is only *which import you reach through*. Start on the barrel; drop to a component module when you want the tighter types."""


indexGrid : List Component -> Element { s | html : M3e.Kind.Brand } admittedBy msg
indexGrid components =
    Layout.div "mt-8 flex flex-wrap gap-2"
        (List.map
            (\c ->
                Doc.anchorPill { href = "#" ++ c.slug, label = c.name }
            )
            components
        )


{-| The barrel section: its overview, then its members split into the four
name-keyed groups a reader scans for (constructors, `variant*` tokens, `slot*`
setters, `attr*`/other setters, `on*` events). Grouping by name prefix — not the
JSON `role` — is what makes the ~650-member barrel navigable.
-}
barrelBlock : Component -> Element { s | html : M3e.Kind.Brand } admittedBy msg
barrelBlock c =
    Native.section
        [ Native.attribute "id" c.slug, Layout.class "mt-12 scroll-mt-6 space-y-6" ]
        [ M3e.divider [] []
        , Native.node "h2"
            []
            [ Kit.headline Value.small
                []
                [ Native.node "code" [ Kit.tint [ Kit.primary ] ] [ Kit.text c.moduleName ]
                , Kit.text "  · the barrel"
                ]
            ]
        , prose "max-w-2xl" Value.large c.overview
        , barrelGroup "Component constructors" isBarrelConstructor c.members
        , barrelGroup "Variants" (isPrefixed "variant") c.members
        , barrelGroup "Slots" (isPrefixed "slot") c.members
        , barrelGroup "Attributes" (\m -> (isPrefixed "attr" m || isPrefixed "aria" m) && m.role /= "event") c.members
        , barrelGroup "Events" (\m -> m.role == "event") c.members
        ]


isPrefixed : String -> Member -> Bool
isPrefixed prefix m =
    String.startsWith prefix m.name


{-| A barrel constructor is anything that isn't a shared `variant*` / `slot*` /
`attr*` / `aria*` setter or an `on*` event — i.e. the actual `M3e.button`-style
component functions.
-}
isBarrelConstructor : Member -> Bool
isBarrelConstructor m =
    not
        (isPrefixed "variant" m
            || isPrefixed "slot" m
            || isPrefixed "attr" m
            || isPrefixed "aria" m
            || (m.role == "event")
        )


{-| One name-keyed subsection of the barrel; renders nothing when empty.
-}
barrelGroup : String -> (Member -> Bool) -> List Member -> Element { s | html : M3e.Kind.Brand } admittedBy msg
barrelGroup label pred members =
    case List.filter pred members of
        [] ->
            Layout.div "" []

        ms ->
            Native.section
                [ Layout.class "space-y-3" ]
                [ Native.node "h3"
                    []
                    [ Kit.title Value.medium [ Kit.onSurface ] [ Kit.text (label ++ " (" ++ String.fromInt (List.length ms) ++ ")") ] ]
                , Layout.div "space-y-3" (List.map memberRow ms)
                ]


componentBlock : Component -> Element { s | html : M3e.Kind.Brand } admittedBy msg
componentBlock c =
    Native.section
        [ Native.attribute "id" c.slug, Layout.class "scroll-mt-6 space-y-4" ]
        [ M3e.divider [] []
        , Native.node "h2"
            []
            [ Kit.headline Value.small
                []
                [ Native.node "code" [ Kit.tint [ Kit.primary ] ] [ Kit.text c.moduleName ] ]
            ]
        , prose "max-w-2xl" Value.large c.overview
        , Layout.div "space-y-3"
            (List.map memberRow c.members)
        ]


memberRow : Member -> Element { s | card : M3e.Kind.Brand } admittedBy msg
memberRow m =
    let
        sig : String
        sig =
            if m.kind == "type" then
                "type " ++ m.name

            else if m.signature == "" then
                m.name

            else
                m.name ++ " : " ++ m.signature
    in
    M3e.card
        [ M3e.Card.variant Value.outlined ]
        [ M3e.Card.content
            (Native.node "div"
                []
                [ Doc.preBlock sig
                , if m.doc == "" then
                    Kit.text ""

                  else
                    prose "mt-2" Value.medium m.doc
                ]
            )
        ]


{-| Render \\n\\n-separated text as body paragraphs at the given type-scale size.
-}
prose : String -> Kit.Size -> String -> Element { s | html : M3e.Kind.Brand } admittedBy msg
prose layoutCls size s =
    Layout.div layoutCls
        (s
            |> String.split "\n\n"
            |> List.filter (\para -> String.trim para /= "")
            |> List.map
                (\para ->
                    Native.p [ Layout.class "mt-2 first:mt-0 whitespace-pre-line" ]
                        [ Kit.body size [ Kit.onSurfaceVariant ] [ Kit.text para ] ]
                )
        )
