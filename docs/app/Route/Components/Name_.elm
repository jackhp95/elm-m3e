module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| Dynamic per-component documentation page, mirroring matraic's component
pages. One route per slug in `data/reference.json`: page title, intro prose,
import statement, live demo sections (Usage with H3 sub-demos: Variants /
Shapes / Sizes / Icons / Toggle / Disabling / Links, etc.), and the
extracted API table.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Cem.M3e.Shape
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, p, pre, section, text)
import Html.Attributes as Attr exposing (class)
import Json.Decode as Decode
import M3e.AppBar as AppBar
import M3e.Avatar as Avatar
import M3e.Badge as Badge
import M3e.BottomSheet as BottomSheet
import M3e.Breadcrumb as Breadcrumb
import M3e.Button as Button
import M3e.ButtonGroup as ButtonGroup
import M3e.Calendar as Calendar
import M3e.Card as Card
import M3e.Checkbox as Checkbox
import M3e.Chip as Chip
import M3e.DatePicker as DatePicker
import M3e.Dialog as Dialog
import M3e.Disclosure as Disclosure
import M3e.Divider as Divider
import M3e.ExtendedFab as ExtendedFab
import M3e.Fab as Fab
import M3e.FabMenu as FabMenu
import M3e.Field as Field
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.Label as Label
import M3e.List as List_
import M3e.LoadingIndicator as LoadingIndicator
import M3e.Menu as Menu
import M3e.NavigationBar as NavigationBar
import M3e.NavigationDrawer as NavigationDrawer
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node
import M3e.Paginator as Paginator
import M3e.Progress as Progress
import M3e.RadioButton as RadioButton
import M3e.Renderable as Renderable exposing (Renderable)
import M3e.ScrollContainer as ScrollContainer
import M3e.Search as Search
import M3e.SegmentedButton as SegmentedButton
import M3e.Select as Select
import M3e.Shape as Shape
import M3e.SideSheet as SideSheet
import M3e.Skeleton as Skeleton
import M3e.Slide as Slide
import M3e.Slider as Slider
import M3e.Snackbar as Snackbar
import M3e.SplitButton as SplitButton
import M3e.SplitPane as SplitPane
import M3e.Stepper as Stepper
import M3e.Switch as Switch
import M3e.Tabs as Tabs
import M3e.Text as Text
import M3e.TextField as TextField
import M3e.TextHighlight as TextHighlight
import M3e.TimePicker as TimePicker
import M3e.Toc as Toc
import M3e.Toolbar as Toolbar
import M3e.Tooltip as Tooltip
import Markdown.Block as Block
import Markdown.Parser
import Markdown.Renderer
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import SyntaxHighlight
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
        , description = "M3e." ++ app.data.name ++ " — Material 3 Expressive component for Elm."
        , locale = Nothing
        , title = "M3e." ++ app.data.name ++ " · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    let
        c =
            app.data
    in
    { title = "M3e." ++ c.name ++ " · elm-m3e"
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
        [ Heading.view { label = "M3e." ++ c.name, variant = Heading.Display }
            [ Heading.size Heading.Small, Heading.level 1 ]
            |> toHtml
        , prose "max-w-2xl text-body-lg text-on-surface-variant" c.overview
        ]


importBlock : Component -> Html msg
importBlock c =
    section [ class "space-y-3" ]
        [ h2Heading "Import"
        , codeBlock ("import M3e." ++ c.name ++ " as " ++ c.name)
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
        div [ class "space-y-10" ] (List.map demoSection sections)


apiBlock : Component -> Html msg
apiBlock c =
    section [ class "space-y-4" ]
        [ h2Heading "API"
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
    Card.view
        [ Card.variant Card.Outlined
        , Card.body
            [ Renderable.html
                (div []
                    [ highlightedElm "overflow-x-auto text-body-sm text-on-surface" sig
                    , if m.doc == "" then
                        text ""

                      else
                        prose "mt-2 text-body-sm text-on-surface-variant" m.doc
                    ]
                )
            ]
        ]
        |> toHtml



-- DEMO HELPERS ---------------------------------------------------------------


{-| A documentation section. `title` is the H2 heading (e.g. "Usage"). `subs`
are H3 sub-demos — each one a labelled live `M3e.*` composition — that match
matraic's per-component layout (Variants / Shapes / Sizes / Icons / etc.).
-}
type alias DemoSection msg =
    { title : String
    , subs : List (Sub msg)
    }


{-| One H3 sub-demo within a `DemoSection`.
-}
type alias Sub msg =
    { title : String, body : Html msg }


sub : String -> Html msg -> Sub msg
sub title body =
    { title = title, body = body }


usage : List (Sub (PagesMsg Msg)) -> DemoSection (PagesMsg Msg)
usage subs =
    { title = "Usage", subs = subs }


h2Heading : String -> Html msg
h2Heading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.level 2, Heading.size Heading.Medium ]
        |> toHtml


h3Heading : String -> Html msg
h3Heading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.level 3, Heading.size Heading.Small ]
        |> toHtml


demoSection : DemoSection (PagesMsg Msg) -> Html (PagesMsg Msg)
demoSection ds =
    section [ class "space-y-4" ]
        (h2Heading ds.title :: List.map subView ds.subs)


subView : Sub (PagesMsg Msg) -> Html (PagesMsg Msg)
subView s =
    section [ class "space-y-3" ]
        [ h3Heading s.title
        , Card.view
            [ Card.variant Card.Outlined
            , Card.body [ Renderable.html (div [ class "flex flex-wrap items-center gap-4" ] [ s.body ]) ]
            ]
            |> toHtml
        ]


codeBlock : String -> Html msg
codeBlock s =
    highlightedElm
        "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-sm leading-relaxed text-on-surface"
        s


{-| Render an Elm snippet with `SyntaxHighlight` token colors, wrapped in a
`<div>` carrying `wrapperClass` for surface styling. `SyntaxHighlight.toBlockHtml`
emits its own `<pre class="elmsh">`, so we wrap in a `<div>` (not `<pre>`) to
avoid invalid pre-inside-pre markup. Falls back to a plain `<pre>` if the
lexer can't parse the input.
-}
highlightedElm : String -> String -> Html msg
highlightedElm wrapperClass s =
    let
        trimmed : String
        trimmed =
            String.trim s
    in
    case SyntaxHighlight.elm trimmed of
        Ok highlighted ->
            div [ class wrapperClass ]
                [ SyntaxHighlight.toBlockHtml Nothing highlighted ]

        Err _ ->
            pre [ class wrapperClass ]
                [ code [] [ text trimmed ] ]


{-| A block parsed out of a doc-comment string: either a prose paragraph or a
fenced/indented code snippet (rendered with Elm highlighting).
-}
type DocBlock
    = ProseBlock String
    | CodeDocBlock String


{-| Render a doc-comment string. Paragraphs are split on blank lines; any
paragraph whose every non-blank line is indented 4+ spaces (the Markdown
indented-code convention Elm doc comments use), or that is wrapped in \``fences, becomes a highlighted code card. The common leading indent is stripped
before highlighting. Everything else stays prose (`whitespace-pre-line\`), so
2-space Markdown bullet lists are left untouched.
-}
prose : String -> String -> Html msg
prose cls s =
    div [ class cls ] (renderMarkdown s)


{-| Render a doc-comment string as Markdown → HTML (inline code, reference
links, emphasis, lists, indented/fenced code blocks all become real elements).
Code blocks reuse the Elm `codeBlock` highlighter. Falls back to the plain
paragraph/indent-code rendering if the Markdown parser rejects the input.
-}
renderMarkdown : String -> List (Html msg)
renderMarkdown raw =
    case Markdown.Parser.parse raw of
        Ok blocks ->
            case Markdown.Renderer.render docRenderer blocks of
                Ok rendered ->
                    rendered

                Err _ ->
                    fallbackProse raw

        Err _ ->
            fallbackProse raw


fallbackProse : String -> List (Html msg)
fallbackProse s =
    s
        |> String.split "\n\n"
        |> List.filterMap classifyDocChunk
        |> List.map renderDocBlock


{-| Markdown renderer with M3 styling, built by overriding the default HTML
renderer. Inline code gets the surface-container chip; links the primary color;
code blocks the Elm syntax highlighter; lists and headings M3 typescale.
-}
docRenderer : Markdown.Renderer.Renderer (Html msg)
docRenderer =
    let
        base : Markdown.Renderer.Renderer (Html msg)
        base =
            Markdown.Renderer.defaultHtmlRenderer
    in
    { base
        | paragraph = p [ class "mt-3 first:mt-0" ]
        , codeSpan =
            \str ->
                code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text str ]
        , link =
            \{ destination } children ->
                Html.a
                    [ Attr.href destination
                    , class "text-primary underline underline-offset-2 hover:no-underline"
                    ]
                    children
        , codeBlock =
            \{ body } -> div [ class "mt-3 first:mt-0" ] [ codeBlock body ]
        , unorderedList =
            \items ->
                Html.ul [ class "mt-3 first:mt-0 list-disc space-y-1 pl-5" ]
                    (List.map
                        (\(Block.ListItem _ kids) ->
                            Html.li [ class "marker:text-on-surface-variant" ] kids
                        )
                        items
                    )
        , orderedList =
            \startIndex items ->
                Html.ol
                    [ class "mt-3 first:mt-0 list-decimal space-y-1 pl-5"
                    , Attr.start startIndex
                    ]
                    (List.map (Html.li [ class "marker:text-on-surface-variant" ]) items)
        , heading =
            \{ level, children } ->
                let
                    sizeClass : String
                    sizeClass =
                        case level of
                            Block.H1 ->
                                "text-title-lg"

                            Block.H2 ->
                                "text-title-md"

                            _ ->
                                "text-title-sm"
                in
                Html.div
                    [ class ("mt-4 first:mt-0 font-medium text-on-surface " ++ sizeClass) ]
                    children
    }


renderDocBlock : DocBlock -> Html msg
renderDocBlock block =
    case block of
        ProseBlock para ->
            p [ class "mt-2 first:mt-0 whitespace-pre-line" ] [ text para ]

        CodeDocBlock src ->
            div [ class "mt-2 first:mt-0" ] [ codeBlock src ]


classifyDocChunk : String -> Maybe DocBlock
classifyDocChunk chunk =
    let
        lines : List String
        lines =
            dropBlankEdges (String.lines chunk)

        nonBlank : List String
        nonBlank =
            List.filter (\l -> String.trim l /= "") lines
    in
    if List.isEmpty nonBlank then
        Nothing

    else if isFenced nonBlank then
        Just (CodeDocBlock (stripFences lines))

    else if List.all (String.startsWith "    ") nonBlank then
        Just (CodeDocBlock (stripCommonIndent lines))

    else
        Just (ProseBlock (String.join "\n" lines))


isFenced : List String -> Bool
isFenced nonBlank =
    case nonBlank of
        first :: _ ->
            String.startsWith "```" (String.trimLeft first)

        [] ->
            False


stripFences : List String -> String
stripFences lines =
    lines
        |> List.filter (\l -> not (String.startsWith "```" (String.trimLeft l)))
        |> String.join "\n"
        |> String.trim


stripCommonIndent : List String -> String
stripCommonIndent lines =
    let
        indentOf : String -> Int
        indentOf l =
            String.length l - String.length (String.trimLeft l)

        minIndent : Int
        minIndent =
            lines
                |> List.filter (\l -> String.trim l /= "")
                |> List.map indentOf
                |> List.minimum
                |> Maybe.withDefault 0
    in
    lines
        |> List.map (String.dropLeft minIndent)
        |> String.join "\n"
        |> String.trim


dropBlankEdges : List String -> List String
dropBlankEdges lines =
    lines
        |> dropWhileBlank
        |> List.reverse
        |> dropWhileBlank
        |> List.reverse


dropWhileBlank : List String -> List String
dropWhileBlank lines =
    case lines of
        l :: rest ->
            if String.trim l == "" then
                dropWhileBlank rest

            else
                lines

        [] ->
            []


noOp : a -> PagesMsg Msg
noOp _ =
    PagesMsg.noOp


{-| Convert any `Renderable` to `Html msg`.
-}
toHtml : Renderable any msg -> Html msg
toHtml r =
    r |> Renderable.toNode |> Node.toHtml


headingDemo : Heading.Variant -> Heading.Size -> String -> Html msg
headingDemo variant size label =
    Heading.view { label = label, variant = variant }
        [ Heading.size size ]
        |> toHtml


buttonRow : List (Html msg) -> Html msg
buttonRow children =
    div [ class "flex flex-wrap items-center gap-2" ] children



-- DEMOS PER COMPONENT --------------------------------------------------------


demoSections : String -> List (DemoSection (PagesMsg Msg))
demoSections slug =
    case slug of
        "appbar" ->
            [ usage
                [ sub "Basic"
                    (AppBar.view
                        [ AppBar.title (Heading.view { label = "Inbox", variant = Heading.Title } [])
                        , AppBar.leading (IconButton.view { icon = "menu", name = "Open menu" } [])
                        , AppBar.trailing
                            [ IconButton.view { icon = "search", name = "Search" } []
                            , IconButton.view { icon = "more_vert", name = "More" } []
                            ]
                        ]
                        |> Renderable.toNode
                        |> Node.toHtml
                    )
                , sub "Sizes"
                    (div [ class "w-full space-y-3" ]
                        [ AppBar.view [ AppBar.title (Heading.view { label = "Small", variant = Heading.Title } []), AppBar.size AppBar.Small ] |> Renderable.toNode |> Node.toHtml
                        , AppBar.view [ AppBar.title (Heading.view { label = "Medium", variant = Heading.Title } []), AppBar.size AppBar.Medium ] |> Renderable.toNode |> Node.toHtml
                        , AppBar.view [ AppBar.title (Heading.view { label = "Large", variant = Heading.Title } []), AppBar.size AppBar.Large ] |> Renderable.toNode |> Node.toHtml
                        ]
                    )
                , sub "Centered title"
                    (AppBar.view
                        [ AppBar.title (Heading.view { label = "Profile", variant = Heading.Title } [])
                        , AppBar.centered True
                        , AppBar.leading (IconButton.view { icon = "arrow_back", name = "Back" } [])
                        ]
                        |> Renderable.toNode
                        |> Node.toHtml
                    )
                ]
            ]

        "avatar" ->
            [ usage
                [ sub "Image"
                    (Avatar.view { alt = "Sample" } [ Avatar.image "/avatar-sample.svg" ] |> toHtml)
                , sub "Initials"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ Avatar.view { alt = "Jane Reed" } [ Avatar.initials "Jane Reed" ] |> toHtml
                        , Avatar.view { alt = "AB" } [ Avatar.initials "AB" ] |> toHtml
                        , Avatar.view { alt = "Pat Lee" } [ Avatar.initials "Pat Lee" ] |> toHtml
                        ]
                    )
                ]
            ]

        "badge" ->
            [ usage
                [ sub "Dot"
                    (div [ class "relative" ]
                        [ Icon.view { name = "notifications" } |> toHtml
                        , Badge.view [ Badge.dot ] |> toHtml
                        ]
                    )
                , sub "Count"
                    (div [ class "relative" ]
                        [ Icon.view { name = "inbox" } |> toHtml
                        , Badge.view [ Badge.count 5 ] |> toHtml
                        ]
                    )
                , sub "Label"
                    (div [ class "relative" ]
                        [ Icon.view { name = "shopping_bag" } |> toHtml
                        , Badge.view [ Badge.label "New" ] |> toHtml
                        ]
                    )
                ]
            ]

        "bottomsheet" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-md text-on-surface-variant" ]
                            [ text "Bottom sheets render at the bottom of the viewport and are normally hidden until opened. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text " — see the Reply study for a working compose-mail bottom sheet."
                            ]
                        , BottomSheet.view { content = [] }
                            [ BottomSheet.open False, BottomSheet.onClose PagesMsg.noOp ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "breadcrumb" ->
            [ usage
                [ sub "Basic"
                    (Breadcrumb.view
                        { items =
                            [ Breadcrumb.item { label = "Home" } [ Breadcrumb.itemHref "#" ]
                            , Breadcrumb.item { label = "Components" } [ Breadcrumb.itemHref "#" ]
                            , Breadcrumb.item { label = "Breadcrumb" } [ Breadcrumb.itemCurrent True ]
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "button" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ Button.view { label = "Elevated", variant = Button.Elevated } [] |> toHtml
                        , Button.view { label = "Filled", variant = Button.Filled } [] |> toHtml
                        , Button.view { label = "Tonal", variant = Button.Tonal } [] |> toHtml
                        , Button.view { label = "Outlined", variant = Button.Outlined } [] |> toHtml
                        , Button.view { label = "Text", variant = Button.Text } [] |> toHtml
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ Button.view { label = "Rounded", variant = Button.Filled } [ Button.shape Button.Rounded ] |> toHtml
                        , Button.view { label = "Square", variant = Button.Filled } [ Button.shape Button.Square ] |> toHtml
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ Button.view { label = "XS", variant = Button.Tonal } [ Button.size Button.ExtraSmall ] |> toHtml
                        , Button.view { label = "Small", variant = Button.Tonal } [ Button.size Button.Small ] |> toHtml
                        , Button.view { label = "Medium", variant = Button.Tonal } [ Button.size Button.Medium ] |> toHtml
                        , Button.view { label = "Large", variant = Button.Tonal } [ Button.size Button.Large ] |> toHtml
                        , Button.view { label = "XL", variant = Button.Tonal } [ Button.size Button.ExtraLarge ] |> toHtml
                        ]
                    )
                , sub "Icons"
                    (buttonRow
                        [ Button.view { label = "Send", variant = Button.Tonal }
                            [ Button.leadingIcon (Icon.view { name = "send" }) ]
                            |> toHtml
                        , Button.view { label = "Open", variant = Button.Tonal }
                            [ Button.trailingIcon (Icon.view { name = "open_in_new" }) ]
                            |> toHtml
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ Button.view { label = "Disabled", variant = Button.Filled } [ Button.disabled True ] |> toHtml
                        , Button.view { label = "Disabled (soft)", variant = Button.Filled } [ Button.disabled True ] |> toHtml
                        ]
                    )
                , sub "Links"
                    (Button.view { label = "Visit Google", variant = Button.Tonal }
                        [ Button.trailingIcon (Icon.view { name = "open_in_new" })
                        , Button.href "https://www.google.com"
                        ]
                        |> toHtml
                    )
                ]
            ]

        "buttongroup" ->
            [ usage
                [ sub "Basic"
                    (ButtonGroup.view
                        { buttons =
                            [ Button.view { label = "One", variant = Button.Filled } []
                            , Button.view { label = "Two", variant = Button.Filled } []
                            , Button.view { label = "Three", variant = Button.Filled } []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "calendar" ->
            [ usage
                [ sub "Single date"
                    (Calendar.view
                        [ Calendar.withDate "2026-06-24"
                        , Calendar.withMinDate "2026-01-01"
                        , Calendar.withMaxDate "2026-12-31"
                        ]
                        |> toHtml
                    )
                ]
            ]

        "card" ->
            [ usage
                [ sub "Variants"
                    (div [ class "grid grid-cols-1 gap-4 sm:grid-cols-3 w-full" ]
                        [ Card.view
                            [ Card.variant Card.Elevated
                            , Card.headline (Heading.view { label = "Elevated", variant = Heading.Title } [])
                            , Card.body [ Renderable.html (text "Raised shadow surface, highest emphasis.") ]
                            ]
                            |> toHtml
                        , Card.view
                            [ Card.variant Card.Filled
                            , Card.headline (Heading.view { label = "Filled", variant = Heading.Title } [])
                            , Card.body [ Renderable.html (text "Solid tonal surface, medium emphasis.") ]
                            ]
                            |> toHtml
                        , Card.view
                            [ Card.variant Card.Outlined
                            , Card.headline (Heading.view { label = "Outlined", variant = Heading.Title } [])
                            , Card.body [ Renderable.html (text "Bordered, no fill, lowest emphasis.") ]
                            ]
                            |> toHtml
                        ]
                    )
                , sub "Anatomy"
                    (Card.view
                        [ Card.variant Card.Outlined
                        , Card.headline (Heading.view { label = "Compliance scorecard", variant = Heading.Title } [])
                        , Card.subhead (Heading.view { label = "Updated 2 hours ago", variant = Heading.Label } [])
                        , Card.body [ Renderable.html (text "Supporting body text gives context to the headline.") ]
                        , Card.actions
                            [ Button.view { label = "Review", variant = Button.Filled } []
                            , Button.view { label = "Dismiss", variant = Button.Text } []
                            ]
                        ]
                        |> toHtml
                    )
                ]
            ]

        "checkbox" ->
            [ usage
                [ sub "Basic"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Checkbox.view { name = "Unchecked" } [ Checkbox.checked False, Checkbox.onChange noOp ] |> toHtml
                        , Checkbox.view { name = "Checked" } [ Checkbox.checked True, Checkbox.onChange noOp ] |> toHtml
                        ]
                    )
                , sub "Indeterminate (tristate)"
                    (Checkbox.view { name = "Select all" }
                        [ Checkbox.indeterminate True, Checkbox.onChange noOp ]
                        |> toHtml
                    )
                , sub "Disabling"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Checkbox.view { name = "Disabled" }
                            [ Checkbox.checked False, Checkbox.disabled True, Checkbox.onChange noOp ]
                            |> toHtml
                        , Checkbox.view { name = "Disabled checked" }
                            [ Checkbox.checked True, Checkbox.disabled True, Checkbox.onChange noOp ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "chip" ->
            [ usage
                [ sub "Assist"
                    (Chip.assist { label = "Assist", onClick = PagesMsg.noOp } [] |> toHtml)
                , sub "Suggestion"
                    (Chip.suggestion { label = "Suggestion", onClick = PagesMsg.noOp } [] |> toHtml)
                , sub "Filter"
                    (Chip.filter { label = "Filter", onToggle = PagesMsg.noOp } [] |> toHtml)
                , sub "Input"
                    (Chip.input { label = "Input", onRemove = PagesMsg.noOp } [] |> toHtml)
                ]
            ]

        "datepicker" ->
            [ usage
                [ sub "Basic"
                    (DatePicker.view [ DatePicker.onChange noOp ] |> toHtml)
                ]
            ]

        "dialog" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-md text-on-surface-variant" ]
                            [ text "Dialogs render on top of the viewport and are normally hidden until opened. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text ". See the Reply study (archive confirm) or Shrine (product details) for live wiring."
                            ]
                        , Dialog.view
                            { headline = "Confirm deletion"
                            , content = [ Renderable.html (text "This action permanently removes the project and all of its files.") ]
                            }
                            [ Dialog.open False, Dialog.onClose PagesMsg.noOp ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "disclosure" ->
            [ usage
                [ sub "Single panel"
                    (Disclosure.view
                        { sections =
                            [ Disclosure.section
                                { header = "Show more"
                                , content = [ Renderable.html (p [ class "text-body-md" ] [ text "Expandable content lives here. Tap the headline to toggle." ]) ]
                                }
                                []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "divider" ->
            [ usage
                [ sub "Horizontal"
                    (Divider.view [] |> toHtml)
                , sub "Inset start"
                    (Divider.view [ Divider.insetStart True ] |> toHtml)
                ]
            ]

        "extendedfab" ->
            [ usage
                [ sub "Variants"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ ExtendedFab.view { icon = "edit", label = "Primary", variant = ExtendedFab.Primary } [] |> toHtml
                        , ExtendedFab.view { icon = "edit", label = "Secondary", variant = ExtendedFab.Secondary } [] |> toHtml
                        , ExtendedFab.view { icon = "edit", label = "Tertiary", variant = ExtendedFab.Tertiary } [] |> toHtml
                        , ExtendedFab.view { icon = "edit", label = "Surface", variant = ExtendedFab.Surface } [] |> toHtml
                        ]
                    )
                , sub "Lowered"
                    (ExtendedFab.view { icon = "edit", label = "Lowered", variant = ExtendedFab.Primary }
                        [ ExtendedFab.lowered True ]
                        |> toHtml
                    )
                , sub "Disabled"
                    (ExtendedFab.view { icon = "edit", label = "Disabled", variant = ExtendedFab.Primary }
                        [ ExtendedFab.disabled True ]
                        |> toHtml
                    )
                ]
            ]

        "fab" ->
            [ usage
                [ sub "Variants"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Fab.view { icon = "add", name = "Primary" } [ Fab.variant Fab.Primary ] |> toHtml
                        , Fab.view { icon = "add", name = "Secondary" } [ Fab.variant Fab.Secondary ] |> toHtml
                        , Fab.view { icon = "add", name = "Tertiary" } [ Fab.variant Fab.Tertiary ] |> toHtml
                        , Fab.view { icon = "add", name = "Surface" } [ Fab.variant Fab.Surface ] |> toHtml
                        ]
                    )
                , sub "Sizes"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Fab.view { icon = "add", name = "Small" } [ Fab.variant Fab.Primary, Fab.size Fab.Small ] |> toHtml
                        , Fab.view { icon = "add", name = "Medium" } [ Fab.variant Fab.Primary, Fab.size Fab.Medium ] |> toHtml
                        , Fab.view { icon = "add", name = "Large" } [ Fab.variant Fab.Primary, Fab.size Fab.Large ] |> toHtml
                        ]
                    )
                , sub "Lowered"
                    (Fab.view { icon = "add", name = "Lowered" }
                        [ Fab.variant Fab.Primary, Fab.lowered True ]
                        |> toHtml
                    )
                , sub "Disabled"
                    (Fab.view { icon = "add", name = "Disabled" }
                        [ Fab.variant Fab.Primary, Fab.disabled True ]
                        |> toHtml
                    )
                ]
            ]

        "fabmenu" ->
            [ usage
                [ sub "Basic"
                    (FabMenu.view
                        { triggerIcon = "menu"
                        , name = "Open actions"
                        , items =
                            [ FabMenu.item { icon = "edit", label = "Compose", onClick = PagesMsg.noOp }
                            , FabMenu.item { icon = "image", label = "Add photo", onClick = PagesMsg.noOp }
                            , FabMenu.item { icon = "videocam", label = "Record video", onClick = PagesMsg.noOp }
                            ]
                        }
                        [ FabMenu.variant FabMenu.Primary ]
                        |> toHtml
                    )
                ]
            ]

        "heading" ->
            [ usage
                [ sub "Display"
                    (div [ class "w-full space-y-2" ]
                        [ headingDemo Heading.Display Heading.Large "Display Large"
                        , headingDemo Heading.Display Heading.Medium "Display Medium"
                        , headingDemo Heading.Display Heading.Small "Display Small"
                        ]
                    )
                , sub "Headline"
                    (div [ class "w-full space-y-2" ]
                        [ headingDemo Heading.Headline Heading.Large "Headline Large"
                        , headingDemo Heading.Headline Heading.Medium "Headline Medium"
                        , headingDemo Heading.Headline Heading.Small "Headline Small"
                        ]
                    )
                , sub "Title"
                    (div [ class "w-full space-y-2" ]
                        [ headingDemo Heading.Title Heading.Large "Title Large"
                        , headingDemo Heading.Title Heading.Medium "Title Medium"
                        , headingDemo Heading.Title Heading.Small "Title Small"
                        ]
                    )
                , sub "Label"
                    (div [ class "w-full space-y-2" ]
                        [ headingDemo Heading.Label Heading.Large "Label Large"
                        , headingDemo Heading.Label Heading.Medium "Label Medium"
                        , headingDemo Heading.Label Heading.Small "Label Small"
                        ]
                    )
                ]
            ]

        "icon" ->
            [ usage
                [ sub "Basic icons"
                    (div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.view { name = "home" } |> toHtml
                        , Icon.view { name = "settings" } |> toHtml
                        , Icon.view { name = "notifications" } |> toHtml
                        , Icon.view { name = "search" } |> toHtml
                        ]
                    )
                , sub "Filled axis"
                    (div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.view { name = "favorite" } |> toHtml
                        , Icon.view { name = "favorite" } |> toHtml
                        ]
                    )
                , sub "Weight axis"
                    (div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.view { name = "circle" } |> toHtml
                        , Icon.view { name = "circle" } |> toHtml
                        , Icon.view { name = "circle" } |> toHtml
                        , Icon.view { name = "circle" } |> toHtml
                        ]
                    )
                ]
            ]

        "iconbutton" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ IconButton.view { icon = "favorite", name = "Like (standard)" } [] |> toHtml
                        , IconButton.view { icon = "favorite", name = "Like (filled)" } [ IconButton.variant IconButton.Filled ] |> toHtml
                        , IconButton.view { icon = "favorite", name = "Like (tonal)" } [ IconButton.variant IconButton.Tonal ] |> toHtml
                        , IconButton.view { icon = "favorite", name = "Like (outlined)" } [ IconButton.variant IconButton.Outlined ] |> toHtml
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ IconButton.view { icon = "check", name = "Round" } [ IconButton.variant IconButton.Filled, IconButton.shape IconButton.Round ] |> toHtml
                        , IconButton.view { icon = "check", name = "Square" } [ IconButton.variant IconButton.Filled, IconButton.shape IconButton.Square ] |> toHtml
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ IconButton.view { icon = "add", name = "XS" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.ExtraSmall ] |> toHtml
                        , IconButton.view { icon = "add", name = "Small" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Small ] |> toHtml
                        , IconButton.view { icon = "add", name = "Medium" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Medium ] |> toHtml
                        , IconButton.view { icon = "add", name = "Large" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Large ] |> toHtml
                        , IconButton.view { icon = "add", name = "XL" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.ExtraLarge ] |> toHtml
                        ]
                    )
                , sub "Widths"
                    (buttonRow
                        [ IconButton.view { icon = "add", name = "Narrow" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Narrow ] |> toHtml
                        , IconButton.view { icon = "add", name = "Default" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Default ] |> toHtml
                        , IconButton.view { icon = "add", name = "Wide" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Wide ] |> toHtml
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ IconButton.view { icon = "check", name = "Disabled" } [ IconButton.variant IconButton.Filled, IconButton.disabled True ] |> toHtml
                        , IconButton.view { icon = "check", name = "Disabled (soft)" } [ IconButton.variant IconButton.Filled, IconButton.disabled True ] |> toHtml
                        ]
                    )
                ]
            ]

        "list" ->
            [ usage
                [ sub "Basic"
                    (List_.view
                        { items =
                            [ List_.item { headline = "First item" } []
                            , List_.item { headline = "Second item" } []
                            , List_.item { headline = "Third item" } []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "loadingindicator" ->
            [ usage
                [ sub "Basic"
                    (LoadingIndicator.view [] |> toHtml)
                ]
            ]

        "menu" ->
            [ usage
                [ sub "With trigger"
                    (div [ class "flex items-center gap-2" ]
                        [ IconButton.view { icon = "more_vert", name = "Open demo menu" }
                            [ IconButton.extraContent [ Menu.triggerFor "demo-menu" ] ]
                            |> toHtml
                        , Menu.view
                            { items =
                                [ Menu.item { label = "Refresh", action = Menu.Click PagesMsg.noOp } []
                                , Menu.item { label = "Settings", action = Menu.Click PagesMsg.noOp } []
                                , Menu.item { label = "Sign out", action = Menu.Click PagesMsg.noOp } []
                                ]
                            }
                            [ Menu.withId "demo-menu" ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "navigationbar" ->
            [ usage
                [ sub "Basic"
                    (NavigationBar.view
                        { items =
                            [ NavigationBar.item { icon = Icon.view { name = "home" }, label = "Home" }
                                [ NavigationBar.itemSelected True
                                ]
                            , NavigationBar.item { icon = Icon.view { name = "search" }, label = "Search" }
                                []
                            , NavigationBar.item { icon = Icon.view { name = "bookmark" }, label = "Saved" }
                                []
                            ]
                        }
                        []
                        |> toHtml
                    )
                , sub "With badges"
                    (NavigationBar.view
                        { items =
                            [ NavigationBar.item { icon = Icon.view { name = "inbox" }, label = "Inbox" }
                                [ NavigationBar.itemSelected True
                                , NavigationBar.itemBadge "3"
                                ]
                            , NavigationBar.item { icon = Icon.view { name = "notifications" }, label = "Alerts" }
                                [ NavigationBar.itemBadge "12"
                                ]
                            , NavigationBar.item { icon = Icon.view { name = "person" }, label = "Profile" }
                                []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "navigationdrawer" ->
            [ usage
                [ sub "Side (non-modal)"
                    (NavigationDrawer.view
                        { entries =
                            [ NavigationDrawer.link { label = "Inbox", href = "#" }
                                [ NavigationDrawer.linkSelected True
                                , NavigationDrawer.linkIcon (Icon.view { name = "inbox" })
                                ]
                            , NavigationDrawer.link { label = "Starred", href = "#" }
                                [ NavigationDrawer.linkIcon (Icon.view { name = "star" })
                                ]
                            , NavigationDrawer.link { label = "Trash", href = "#" }
                                [ NavigationDrawer.linkIcon (Icon.view { name = "delete" })
                                ]
                            ]
                        }
                        [ NavigationDrawer.withOpen True
                        , NavigationDrawer.withMode NavigationDrawer.ModeSide
                        ]
                        |> toHtml
                    )
                ]
            ]

        "navigationrail" ->
            [ usage
                [ sub "Basic"
                    (NavigationRail.view
                        { items =
                            [ NavigationRail.item { icon = Icon.view { name = "home" }, label = "Home" }
                                [ NavigationRail.itemSelected True
                                ]
                            , NavigationRail.item { icon = Icon.view { name = "search" }, label = "Search" }
                                []
                            , NavigationRail.item { icon = Icon.view { name = "bookmark" }, label = "Saved" }
                                []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "paginator" ->
            [ usage
                [ sub "Basic"
                    (Paginator.view { length = 53 }
                        [ Paginator.pageIndex 0 ]
                        |> toHtml
                    )
                , sub "With first/last"
                    (Paginator.view { length = 200 }
                        [ Paginator.pageIndex 4
                        , Paginator.showFirstLastButtons True
                        ]
                        |> toHtml
                    )
                ]
            ]

        "progress" ->
            [ usage
                [ sub "Linear"
                    (Progress.view { shape = Progress.Linear } [ Progress.value 60 ] |> toHtml)
                , sub "Circular"
                    (Progress.view { shape = Progress.Circular } [ Progress.value 40 ] |> toHtml)
                , sub "Indeterminate"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Progress.view { shape = Progress.Linear } [] |> toHtml
                        , Progress.view { shape = Progress.Circular } [] |> toHtml
                        ]
                    )
                ]
            ]

        "radiobutton" ->
            [ usage
                [ sub "Basic"
                    (RadioButton.view
                        { name = "Billing cycle"
                        , options =
                            [ { value = "monthly", label = "Monthly" }
                            , { value = "yearly", label = "Yearly" }
                            ]
                        , selected = Just "monthly"
                        }
                        [ RadioButton.onChange noOp ]
                        |> toHtml
                    )
                ]
            ]

        "scrollcontainer" ->
            [ usage
                [ sub "Top + bottom dividers"
                    (ScrollContainer.view
                        { content =
                            [ Renderable.html
                                (div [ class "h-32 overflow-auto p-3 text-body-md" ]
                                    [ p [] [ text "Item 1" ]
                                    , p [] [ text "Item 2" ]
                                    , p [] [ text "Item 3" ]
                                    , p [] [ text "Item 4" ]
                                    , p [] [ text "Item 5" ]
                                    , p [] [ text "Item 6" ]
                                    , p [] [ text "Item 7" ]
                                    ]
                                )
                            ]
                        }
                        [ ScrollContainer.dividers ScrollContainer.AboveBelow ]
                        |> toHtml
                    )
                ]
            ]

        "search" ->
            [ usage
                [ sub "Bar"
                    (Search.view { placeholder = "Search the docs" } [] |> toHtml)
                ]
            ]

        "segmentedbutton" ->
            [ usage
                [ sub "Single select"
                    (SegmentedButton.view
                        { segments =
                            [ SegmentedButton.segment { label = "Grid", checked = True } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            , SegmentedButton.segment { label = "List", checked = False } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            ]
                        }
                        []
                        |> toHtml
                    )
                , sub "Multi select"
                    (SegmentedButton.view
                        { segments =
                            [ SegmentedButton.segment { label = "Weekdays", checked = True } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            , SegmentedButton.segment { label = "Weekend", checked = False } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            ]
                        }
                        [ SegmentedButton.multi True ]
                        |> toHtml
                    )
                ]
            ]

        "select" ->
            [ usage
                [ sub "Single"
                    (Select.view { label = "Sort by" }
                        [ Select.withOptions
                            [ Select.option { value = "recent", label = "Most recent" } [ Select.optionSelected True ]
                            , Select.option { value = "oldest", label = "Oldest" } []
                            , Select.option { value = "name", label = "By name" } []
                            ]
                        , Select.onChange noOp
                        ]
                        |> toHtml
                    )
                , sub "Multi"
                    (Select.view { label = "Categories" }
                        [ Select.withOptions
                            [ Select.option { value = "news", label = "News" } [ Select.optionSelected True ]
                            , Select.option { value = "blog", label = "Blog" } [ Select.optionSelected True ]
                            , Select.option { value = "video", label = "Video" } []
                            ]
                        , Select.onChange noOp
                        , Select.withMulti True
                        ]
                        |> toHtml
                    )
                ]
            ]

        "shape" ->
            [ usage
                [ sub "Decorative shapes"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Circle ] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-secondary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Flower ] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-24 h-16 bg-tertiary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Pill ] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-error-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Heart ] |> toHtml
                        ]
                    )
                , sub "Corner-radius scale"
                    (div [ class "flex flex-wrap items-end gap-4" ]
                        [ Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-none" ] []) ] } [] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-small" ] []) ] } [] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-medium" ] []) ] } [] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-large" ] []) ] } [] |> toHtml
                        , Shape.view { content = [ Renderable.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-full" ] []) ] } [] |> toHtml
                        ]
                    )
                ]
            ]

        "sidesheet" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-md text-on-surface-variant" ]
                            [ text "Side sheets anchor to the start or end edge of the viewport. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text "; modality is opt-in. See Reply or Settings for live wiring."
                            ]
                        , SideSheet.view { content = [] }
                            [ SideSheet.open False, SideSheet.onClose PagesMsg.noOp ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "skeleton" ->
            [ usage
                [ sub "Lines + block"
                    (div [ class "flex w-full flex-col gap-2" ]
                        [ Skeleton.view { content = [ Renderable.html (Html.div [ class "h-5 w-2/3" ] []) ] } [] |> toHtml
                        , Skeleton.view { content = [ Renderable.html (Html.div [ class "h-5 w-1/2" ] []) ] } [] |> toHtml
                        , Skeleton.view { content = [ Renderable.html (Html.div [ class "h-32 w-full" ] []) ] } [] |> toHtml
                        ]
                    )
                , sub "Loaded (reveals content)"
                    (Skeleton.view
                        { content =
                            [ Renderable.html
                                (div [ class "rounded bg-surface-container p-3 text-body-md" ]
                                    [ text "Real content, revealed once loaded." ]
                                )
                            ]
                        }
                        [ Skeleton.loaded True ]
                        |> toHtml
                    )
                ]
            ]

        "slide" ->
            [ usage
                [ sub "Basic"
                    (Slide.view
                        { slides =
                            List.map
                                (\( label, swatch ) ->
                                    Slide.slide
                                        [ Renderable.html
                                            (div [ class ("flex h-24 w-40 shrink-0 items-center justify-center rounded-md-corner-large text-on-surface " ++ swatch) ]
                                                [ text label ]
                                            )
                                        ]
                                )
                                [ ( "Spring", "bg-tertiary-container" )
                                , ( "Summer", "bg-primary-container" )
                                , ( "Autumn", "bg-secondary-container" )
                                , ( "Winter", "bg-surface-container-high" )
                                ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "slider" ->
            [ usage
                [ sub "Basic value"
                    (Slider.view { name = "Volume" } [ Slider.value 35 ] |> toHtml)
                , sub "Discrete (tick marks)"
                    (Slider.view { name = "Brightness" }
                        [ Slider.value 60
                        , Slider.step 10
                        , Slider.discrete True
                        ]
                        |> toHtml
                    )
                , sub "Disabled"
                    (Slider.view { name = "Locked" }
                        [ Slider.value 50
                        , Slider.disabled True
                        ]
                        |> toHtml
                    )
                ]
            ]

        "snackbar" ->
            [ usage
                [ sub "Basic"
                    (Snackbar.view { message = "Message sent" } [] |> toHtml)
                ]
            ]

        "splitbutton" ->
            [ usage
                [ sub "Basic"
                    (SplitButton.view
                        { label = "Save"
                        , name = "More options"
                        , trailingIcon = "arrow_drop_down"
                        , onPrimaryClick = PagesMsg.noOp
                        , onTriggerClick = PagesMsg.noOp
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "splitpane" ->
            [ usage
                [ sub "Horizontal"
                    (SplitPane.view
                        { start = [ Renderable.html (p [ class "p-4 text-body-md" ] [ text "Start pane" ]) ]
                        , end = [ Renderable.html (p [ class "p-4 text-body-md" ] [ text "End pane" ]) ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "stepper" ->
            [ usage
                [ sub "Basic"
                    (Stepper.view
                        { steps =
                            [ Stepper.step { label = "Account" } [ Stepper.stepFor "demo-panel-1" ]
                            , Stepper.step { label = "Profile" } [ Stepper.stepFor "demo-panel-2" ]
                            , Stepper.step { label = "Confirm" } [ Stepper.stepFor "demo-panel-3" ]
                            ]
                        , panels =
                            [ Stepper.stepPanel { content = [] } [ Stepper.panelId "demo-panel-1" ]
                            , Stepper.stepPanel { content = [] } [ Stepper.panelId "demo-panel-2" ]
                            , Stepper.stepPanel { content = [] } [ Stepper.panelId "demo-panel-3" ]
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "switch" ->
            [ usage
                [ sub "Basic"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Switch.view { name = "Off" } [ Switch.checked False, Switch.onChange noOp ] |> toHtml
                        , Switch.view { name = "On" } [ Switch.checked True, Switch.onChange noOp ] |> toHtml
                        ]
                    )
                , sub "Handle icons"
                    (Switch.view { name = "Notifications" }
                        [ Switch.checked True
                        , Switch.handleIcons True
                        , Switch.onChange noOp
                        ]
                        |> toHtml
                    )
                , sub "Disabled"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Switch.view { name = "Off (disabled)" }
                            [ Switch.checked False, Switch.disabled True, Switch.onChange noOp ]
                            |> toHtml
                        , Switch.view { name = "On (disabled)" }
                            [ Switch.checked True, Switch.disabled True, Switch.onChange noOp ]
                            |> toHtml
                        ]
                    )
                ]
            ]

        "tabs" ->
            [ usage
                [ sub "Basic"
                    (Tabs.view
                        { tabs =
                            [ Tabs.tab { label = "Overview" } [ Tabs.tabSelected True, Tabs.tabFor "demo-tab-panel-overview" ]
                            , Tabs.tab { label = "Specs" } [ Tabs.tabFor "demo-tab-panel-specs" ]
                            , Tabs.tab { label = "Reviews" } [ Tabs.tabFor "demo-tab-panel-reviews" ]
                            ]
                        , panels =
                            [ Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-overview" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-specs" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-reviews" ]
                            ]
                        }
                        []
                        |> toHtml
                    )
                , sub "With icons"
                    (Tabs.view
                        { tabs =
                            [ Tabs.tab { label = "Inbox" } [ Tabs.tabSelected True, Tabs.tabFor "demo-tab-panel-inbox" ]
                            , Tabs.tab { label = "Sent" } [ Tabs.tabFor "demo-tab-panel-sent" ]
                            , Tabs.tab { label = "Trash" } [ Tabs.tabFor "demo-tab-panel-trash" ]
                            ]
                        , panels =
                            [ Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-inbox" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-sent" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-trash" ]
                            ]
                        }
                        []
                        |> toHtml
                    )
                , sub "Stretched"
                    (Tabs.view
                        { tabs =
                            [ Tabs.tab { label = "Day" } [ Tabs.tabSelected False, Tabs.tabFor "demo-tab-panel-day" ]
                            , Tabs.tab { label = "Week" } [ Tabs.tabSelected True, Tabs.tabFor "demo-tab-panel-week" ]
                            , Tabs.tab { label = "Month" } [ Tabs.tabFor "demo-tab-panel-month" ]
                            ]
                        , panels =
                            [ Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-day" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-week" ]
                            , Tabs.panel { content = [] } [ Tabs.panelId "demo-tab-panel-month" ]
                            ]
                        }
                        [ Tabs.stretch True ]
                        |> toHtml
                    )
                ]
            ]

        "textfield" ->
            [ usage
                [ sub "Variants"
                    (div [ class "w-full max-w-md space-y-4" ]
                        [ TextField.view { label = "Name (filled)" }
                            [ TextField.withVariant TextField.Filled
                            , TextField.withValue ""
                            , TextField.onInput noOp
                            ]
                            |> toHtml
                        , TextField.view { label = "Name (outlined)" }
                            [ TextField.withVariant TextField.Outlined
                            , TextField.withValue ""
                            , TextField.onInput noOp
                            ]
                            |> toHtml
                        ]
                    )
                , sub "Input types"
                    (div [ class "w-full max-w-md space-y-4" ]
                        [ TextField.view { label = "Email" }
                            [ TextField.withVariant TextField.Outlined
                            , TextField.withValue ""
                            , TextField.withInputType TextField.Email
                            , TextField.onInput noOp
                            ]
                            |> toHtml
                        , TextField.view { label = "URL" }
                            [ TextField.withVariant TextField.Outlined
                            , TextField.withValue ""
                            , TextField.withInputType TextField.Url
                            , TextField.onInput noOp
                            ]
                            |> toHtml
                        ]
                    )
                , sub "Multiline"
                    (TextField.view { label = "Notes" }
                        [ TextField.withVariant TextField.Outlined
                        , TextField.withValue ""
                        , TextField.onInput noOp
                        , TextField.multiline True
                        , TextField.withRows 3
                        ]
                        |> toHtml
                    )
                , sub "Prefix and suffix"
                    (TextField.view { label = "Price" }
                        [ TextField.withVariant TextField.Outlined
                        , TextField.withValue ""
                        , TextField.onInput noOp
                        , TextField.withPrefix (Html.text "$")
                        , TextField.withSuffix (Html.text "USD")
                        ]
                        |> toHtml
                    )
                , sub "Disabled"
                    (TextField.view { label = "Locked" }
                        [ TextField.withVariant TextField.Outlined
                        , TextField.withValue "Read-only value"
                        , TextField.onInput noOp
                        , TextField.withDisabled True
                        ]
                        |> toHtml
                    )
                ]
            ]

        "texthighlight" ->
            [ usage
                [ sub "Highlight a term"
                    (TextHighlight.view
                        { content =
                            [ Renderable.html
                                (text "M3e.TextHighlight wraps any inline content and highlights every occurrence of a search term.")
                            ]
                        }
                        [ TextHighlight.term "highlight" ]
                        |> toHtml
                    )
                ]
            ]

        "theme" ->
            [ usage
                [ sub "About"
                    (p [ class "text-body-md" ]
                        [ text "M3e.Theme wraps "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "<m3e-theme>" ]
                        , text ". A single instance owns the dynamic-color scheme, contrast, density, and motion for its subtree — the docs shell mounts it once at the root, which you're inside now. Try the settings popover in the app bar."
                        ]
                    )
                ]
            ]

        "timepicker" ->
            [ usage
                [ sub "Basic"
                    (TimePicker.view { label = "Meeting time" }
                        [ TimePicker.withValue "14:30"
                        , TimePicker.onChange noOp
                        ]
                        |> toHtml
                    )
                ]
            ]

        "toc" ->
            [ usage
                [ sub "Basic"
                    (div [ class "flex gap-6" ]
                        [ Toc.view { for = "toc-demo-content" } [ Toc.title "On this page" ] |> toHtml
                        , div [ Attr.id "toc-demo-content", class "min-w-0 flex-1 space-y-3" ]
                            [ Html.h2 [ Attr.id "toc-overview", class "text-title-md" ] [ text "Overview" ]
                            , p [ class "text-body-md text-on-surface-variant" ] [ text "The table of contents tracks the headings inside the referenced container." ]
                            , Html.h2 [ Attr.id "toc-usage", class "text-title-md" ] [ text "Usage" ]
                            , p [ class "text-body-md text-on-surface-variant" ] [ text "Point `for` at the id of the content element whose headings should be scanned." ]
                            , Html.h2 [ Attr.id "toc-api", class "text-title-md" ] [ text "API" ]
                            , p [ class "text-body-md text-on-surface-variant" ] [ text "The optional title and maxDepth options refine the rendered list." ]
                            ]
                        ]
                    )
                ]
            ]

        "toolbar" ->
            [ usage
                [ sub "Basic"
                    (Toolbar.view
                        { content =
                            [ Button.view { label = "Save", variant = Button.Filled } []
                            , Button.view { label = "Discard", variant = Button.Text } []
                            ]
                        }
                        []
                        |> toHtml
                    )
                ]
            ]

        "tooltip" ->
            [ usage
                [ sub "Plain tooltip"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ Html.span [ Attr.id "tooltip-anchor-demo" ]
                            [ IconButton.view { icon = "refresh", name = "Refresh" }
                                [ IconButton.variant IconButton.Tonal ]
                                |> toHtml
                            ]
                        , Tooltip.plain { anchorId = "tooltip-anchor-demo", label = "Refresh data" } []
                            |> toHtml
                        ]
                    )
                ]
            ]

        "field" ->
            [ usage
                [ sub "Switch in a labeled field"
                    (Field.view
                        { id = "field-reduce-motion"
                        , label = Label.fromHtml (Html.text "Reduce motion")
                        , control = Switch.view { name = "Reduce motion" } [ Switch.checked True ]
                        }
                        |> Node.toHtml
                    )
                , sub "Outlined variant with error"
                    (Field.view
                        { id = "field-project-name"
                        , label = Label.fromHtml (Html.text "Project name")
                        , control =
                            Renderable.element { tag = "input" }
                                [ Node.rawAttr (Attr.value "atlas") ]
                                []
                        }
                        |> Node.toHtml
                    )
                ]
            ]

        "text" ->
            [ usage
                [ sub "Body roles"
                    (div [ class "w-full space-y-2" ]
                        [ Text.bodyLarge "Body large — default running text." |> toHtml
                        , Text.bodyMedium "Body medium — secondary copy." |> toHtml
                        , Text.bodySmall "Body small — captions and footnotes." |> toHtml
                        ]
                    )
                , sub "Label roles"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Text.labelLarge "Label large" |> toHtml
                        , Text.labelMedium "Label medium" |> toHtml
                        , Text.labelSmall "Label small" |> toHtml
                        ]
                    )
                ]
            ]

        _ ->
            []
