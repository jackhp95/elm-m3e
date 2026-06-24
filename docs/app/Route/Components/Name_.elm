module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| Dynamic per-component documentation page, mirroring matraic's component
pages. One route per slug in `data/reference.json`: page title, intro prose,
import statement, live demo sections (Usage / Variants / etc.), and the
extracted API table.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, p, pre, section, text)
import Html.Attributes exposing (class)
import Json.Decode as Decode
import M3e.Shape
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.Avatar as Avatar
import Ui.Badge as Badge
import Ui.Button as Button
import Ui.Card as Card
import Ui.Divider as Divider
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.LoadingIndicator as LoadingIndicator
import Ui.Progress as Progress
import Ui.Shape as Shape
import Ui.Skeleton as Skeleton
import Ui.Snackbar as Snackbar
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    { name : String }


type alias Member =
    { name : String, kind : String, signature : String, doc : String }


type alias Component =
    { name : String, slug : String, overview : String, members : List Member }


type alias Data =
    Component


type alias ActionData =
    {}


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.map4 Member
        (Decode.field "name" Decode.string)
        (Decode.field "kind" Decode.string)
        (Decode.field "signature" Decode.string)
        (Decode.field "doc" Decode.string)


componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map4 Component
        (Decode.field "name" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.field "overview" Decode.string)
        (Decode.field "members" (Decode.list memberDecoder))


allComponents : BackendTask FatalError (List Component)
allComponents =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
        |> BackendTask.allowFatal


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.preRender
        { head = head
        , pages = pages
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


pages : BackendTask FatalError (List RouteParams)
pages =
    allComponents
        |> BackendTask.map (List.map (\c -> { name = c.slug }))


data : RouteParams -> BackendTask FatalError Data
data routeParams =
    allComponents
        |> BackendTask.andThen
            (\components ->
                case List.filter (\c -> c.slug == routeParams.name) components of
                    found :: _ ->
                        BackendTask.succeed found

                    [] ->
                        BackendTask.fail (FatalError.fromString ("No component for slug: " ++ routeParams.name))
            )


head : App Data ActionData RouteParams -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Ui." ++ app.data.name ++ " — Material 3 Expressive component for Elm."
        , locale = Nothing
        , title = "Ui." ++ app.data.name ++ " · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    let
        c =
            app.data
    in
    { title = "Ui." ++ c.name ++ " · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-10" ]
            [ headerBlock c
            , importBlock c
            , demoBlock c
            , apiBlock c
            ]
        ]
    }



-- HEADER + IMPORT + API ------------------------------------------------------


headerBlock : Component -> Html (PagesMsg Msg)
headerBlock c =
    section [ class "space-y-3" ]
        [ Heading.new
            |> Heading.withLevel 1
            |> Heading.withVariant Heading.Display
            |> Heading.withSize Heading.Small
            |> Heading.withContent (text ("Ui." ++ c.name))
            |> Heading.view
        , prose "max-w-2xl text-body-large text-on-surface-variant" c.overview
        ]


importBlock : Component -> Html msg
importBlock c =
    section [ class "space-y-3" ]
        [ sectionHeading "Import"
        , codeBlock ("import Ui." ++ c.name ++ " as " ++ c.name)
        ]


demoBlock : Component -> Html (PagesMsg Msg)
demoBlock c =
    let
        sections =
            demoSections c.slug
    in
    if List.isEmpty sections then
        text ""

    else
        div [ class "space-y-8" ] (List.map demoSection sections)


apiBlock : Component -> Html msg
apiBlock c =
    section [ class "space-y-4" ]
        [ sectionHeading "API"
        , div [ class "space-y-3" ] (List.map memberRow c.members)
        ]


memberRow : Member -> Html msg
memberRow m =
    let
        sig =
            if m.kind == "type" then
                "type " ++ m.name

            else if m.signature == "" then
                m.name

            else
                m.name ++ " : " ++ m.signature
    in
    Card.new Card.Outlined
        |> Card.withBody
            (div []
                [ Html.pre [ class "overflow-x-auto text-body-small text-on-surface" ]
                    [ code [] [ text sig ] ]
                , if m.doc == "" then
                    text ""

                  else
                    prose "mt-2 text-body-small text-on-surface-variant" m.doc
                ]
            )
        |> Card.view



-- DEMO HELPERS ---------------------------------------------------------------


type alias DemoSection msg =
    { title : String, body : Html msg }


sectionHeading : String -> Html msg
sectionHeading label =
    Heading.new
        |> Heading.withLevel 2
        |> Heading.withVariant Heading.Headline
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text label)
        |> Heading.view


demoSection : DemoSection (PagesMsg Msg) -> Html (PagesMsg Msg)
demoSection ds =
    section [ class "space-y-3" ]
        [ sectionHeading ds.title
        , Card.new Card.Outlined
            |> Card.withBody (div [ class "flex flex-wrap items-center gap-4" ] [ ds.body ])
            |> Card.view
        ]


codeBlock : String -> Html msg
codeBlock s =
    pre [ class "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-small leading-relaxed text-on-surface" ]
        [ code [] [ text (String.trim s) ] ]


usage : Html msg -> DemoSection msg
usage body =
    { title = "Usage", body = body }


prose : String -> String -> Html msg
prose cls s =
    div [ class cls ]
        (s
            |> String.split "\n\n"
            |> List.filter (\para -> String.trim para /= "")
            |> List.map (\para -> p [ class "mt-2 first:mt-0 whitespace-pre-line" ] [ text para ])
        )


noOp : a -> PagesMsg Msg
noOp _ =
    PagesMsg.noOp



-- DEMOS PER COMPONENT --------------------------------------------------------


demoSections : String -> List (DemoSection (PagesMsg Msg))
demoSections slug =
    case slug of
        "avatar" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-3" ]
                        [ Avatar.image { url = "/avatar-sample.svg", alt = "Sample" } |> Avatar.view
                        , Avatar.initials "Jane Reed" |> Avatar.view
                        , Avatar.initials "AB" |> Avatar.view
                        ]
              }
            ]

        "badge" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-6" ]
                        [ div [ class "relative" ] [ Icon.material "notifications" |> Icon.view, Badge.dot |> Badge.view ]
                        , div [ class "relative" ] [ Icon.material "inbox" |> Icon.view, Badge.count 5 |> Badge.view ]
                        , div [ class "relative" ] [ Icon.material "shopping_bag" |> Icon.view, Badge.label "New" |> Badge.view ]
                        ]
              }
            ]

        "button" ->
            [ usage (Button.new { label = "Press me", variant = Button.Filled } |> Button.view)
            , { title = "Variants"
              , body =
                    div [ class "flex flex-wrap gap-2" ]
                        [ Button.new { label = "Elevated", variant = Button.Elevated } |> Button.view
                        , Button.new { label = "Filled", variant = Button.Filled } |> Button.view
                        , Button.new { label = "Tonal", variant = Button.Tonal } |> Button.view
                        , Button.new { label = "Outlined", variant = Button.Outlined } |> Button.view
                        , Button.new { label = "Text", variant = Button.Text } |> Button.view
                        ]
              }
            , { title = "With icons"
              , body =
                    div [ class "flex flex-wrap gap-2" ]
                        [ Button.new { label = "Add", variant = Button.Filled }
                            |> Button.withLeadingIcon (Icon.material "add")
                            |> Button.view
                        , Button.new { label = "Open", variant = Button.Outlined }
                            |> Button.withTrailingIcon (Icon.material "open_in_new")
                            |> Button.view
                        ]
              }
            ]

        "card" ->
            [ { title = "Variants"
              , body =
                    div [ class "grid grid-cols-1 gap-4 sm:grid-cols-3 w-full" ]
                        [ Card.new Card.Elevated
                            |> Card.withHeadline "Elevated"
                            |> Card.withBody (text "Raised shadow surface, highest emphasis.")
                            |> Card.view
                        , Card.new Card.Filled
                            |> Card.withHeadline "Filled"
                            |> Card.withBody (text "Solid tonal surface, medium emphasis.")
                            |> Card.view
                        , Card.new Card.Outlined
                            |> Card.withHeadline "Outlined"
                            |> Card.withBody (text "Bordered, no fill, lowest emphasis.")
                            |> Card.view
                        ]
              }
            ]

        "divider" ->
            [ { title = "Orientations"
              , body =
                    div [ class "w-full space-y-4" ]
                        [ Divider.new |> Divider.view
                        , Divider.new |> Divider.withInsetStart True |> Divider.view
                        ]
              }
            ]

        "heading" ->
            [ { title = "Variants × sizes"
              , body =
                    div [ class "w-full space-y-2" ]
                        [ headingDemo Heading.Display Heading.Large "Display Large"
                        , headingDemo Heading.Headline Heading.Medium "Headline Medium"
                        , headingDemo Heading.Title Heading.Medium "Title Medium"
                        , headingDemo Heading.Label Heading.Large "Label Large"
                        ]
              }
            ]

        "icon" ->
            [ { title = "Material symbols"
              , body =
                    div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.material "home" |> Icon.view
                        , Icon.material "favorite" |> Icon.withFilled True |> Icon.view
                        , Icon.material "settings" |> Icon.view
                        , Icon.material "notifications" |> Icon.view
                        , Icon.material "search" |> Icon.view
                        ]
              }
            ]

        "iconbutton" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-2" ]
                        [ IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Standard } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Filled } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Tonal } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Outlined } |> IconButton.view
                        ]
              }
            ]

        "loadingindicator" ->
            [ usage (LoadingIndicator.new |> LoadingIndicator.view) ]

        "progress" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-6" ]
                        [ Progress.linear 60 |> Progress.view
                        , Progress.circular 40 |> Progress.view
                        ]
              }
            ]

        "shape" ->
            [ { title = "Decorative shapes"
              , body =
                    div [ class "flex flex-wrap items-center gap-4" ]
                        [ Shape.new |> Shape.withName M3e.Shape.Circle |> Shape.withClass "block w-16 h-16 bg-primary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Flower |> Shape.withClass "block w-16 h-16 bg-secondary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Pill |> Shape.withClass "block w-24 h-16 bg-tertiary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Heart |> Shape.withClass "block w-16 h-16 bg-error-container" |> Shape.view
                        ]
              }
            ]

        "skeleton" ->
            [ usage
                (div [ class "flex w-full flex-col gap-2" ]
                    [ Skeleton.new |> Skeleton.withClass "h-5 w-2/3" |> Skeleton.view
                    , Skeleton.new |> Skeleton.withClass "h-5 w-1/2" |> Skeleton.view
                    , Skeleton.new |> Skeleton.withClass "h-32 w-full" |> Skeleton.view
                    ]
                )
            ]

        "snackbar" ->
            [ usage (Snackbar.new "Message sent" |> Snackbar.view) ]

        "theme" ->
            [ { title = "About"
              , body =
                    p [ class "text-body-medium" ]
                        [ text "Ui.Theme wraps "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "<m3e-theme>" ]
                        , text ". A single instance owns the dynamic-color scheme, contrast, density, and motion for its subtree — the docs shell mounts it once at the root, which you're inside now. Try the settings popover in the app bar."
                        ]
              }
            ]

        _ ->
            []


headingDemo : Heading.Variant -> Heading.Size -> String -> Html msg
headingDemo variant size label =
    Heading.new
        |> Heading.withVariant variant
        |> Heading.withSize size
        |> Heading.withContent (text label)
        |> Heading.view
