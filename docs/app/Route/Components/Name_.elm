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
import Html exposing (code, div, p, pre, text)
import Html.Attributes as Attr exposing (class)
import Json.Decode as Decode
import Layout
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
import M3e.Node as Node exposing (Node)
import M3e.Paginator as Paginator
import M3e.Progress as Progress
import M3e.RadioButton as RadioButton
import M3e.Element as Element exposing (Element)
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
        [ Layout.div "mx-auto max-w-4xl space-y-10"
            [ headerBlock c
            , importBlock c
            , demoBlock c
            , apiBlock c
            ]
        ]
    }



-- HEADER + IMPORT + API ------------------------------------------------------


headerBlock : Component -> Node (PagesMsg Msg)
headerBlock c =
    Layout.section "space-y-3"
        [ Heading.view { label = "M3e." ++ c.name, variant = Heading.Display }
            [ Heading.size Heading.Small, Heading.level 1 ]
            |> Element.toNode
        , Node.raw (prose "max-w-2xl text-body-lg text-on-surface-variant" c.overview)
        ]


importBlock : Component -> Node (PagesMsg Msg)
importBlock c =
    Layout.section "space-y-3"
        [ h2Heading "Import"
        , Node.raw (codeBlock ("import M3e." ++ c.name ++ " as " ++ c.name))
        ]


demoBlock : Component -> Node (PagesMsg Msg)
demoBlock c =
    let
        sections =
            demoSections c.slug
    in
    if List.isEmpty sections then
        Node.text ""

    else
        Layout.div "space-y-10" (List.map demoSection sections)


apiBlock : Component -> Node (PagesMsg Msg)
apiBlock c =
    Layout.section "space-y-4"
        [ h2Heading "API"
        , Layout.div "space-y-3" (List.map memberRow c.members)
        ]


memberRow : Member -> Node (PagesMsg Msg)
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
            [ Element.html
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
        |> Element.toNode



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
    { title : String, body : Node msg }


sub : String -> Node msg -> Sub msg
sub title body =
    { title = title, body = body }


usage : List (Sub (PagesMsg Msg)) -> DemoSection (PagesMsg Msg)
usage subs =
    { title = "Usage", subs = subs }


h2Heading : String -> Node (PagesMsg Msg)
h2Heading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.level 2, Heading.size Heading.Medium ]
        |> Element.toNode


h3Heading : String -> Node (PagesMsg Msg)
h3Heading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.level 3, Heading.size Heading.Small ]
        |> Element.toNode


demoSection : DemoSection (PagesMsg Msg) -> Node (PagesMsg Msg)
demoSection ds =
    Layout.section "space-y-4"
        (h2Heading ds.title :: List.map subView ds.subs)


subView : Sub (PagesMsg Msg) -> Node (PagesMsg Msg)
subView s =
    Layout.section "space-y-3"
        [ h3Heading s.title
        , Card.view
            [ Card.variant Card.Outlined
            , Card.body [ Element.fromNode (Layout.div "flex flex-wrap items-center gap-4" [ s.body ]) ]
            ]
            |> Element.toNode
        ]


codeBlock : String -> Html.Html msg
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
highlightedElm : String -> String -> Html.Html msg
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
prose : String -> String -> Html.Html msg
prose cls s =
    div [ class cls ] (renderMarkdown s)


{-| Render a doc-comment string as Markdown → HTML (inline code, reference
links, emphasis, lists, indented/fenced code blocks all become real elements).
Code blocks reuse the Elm `codeBlock` highlighter. Falls back to the plain
paragraph/indent-code rendering if the Markdown parser rejects the input.
-}
renderMarkdown : String -> List (Html.Html msg)
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


fallbackProse : String -> List (Html.Html msg)
fallbackProse s =
    s
        |> String.split "\n\n"
        |> List.filterMap classifyDocChunk
        |> List.map renderDocBlock


{-| Markdown renderer with M3 styling, built by overriding the default HTML
renderer. Inline code gets the surface-container chip; links the primary color;
code blocks the Elm syntax highlighter; lists and headings M3 typescale.
-}
docRenderer : Markdown.Renderer.Renderer (Html.Html msg)
docRenderer =
    let
        base : Markdown.Renderer.Renderer (Html.Html msg)
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


renderDocBlock : DocBlock -> Html.Html msg
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


headingDemo : Heading.Variant -> Heading.Size -> String -> Node (PagesMsg Msg)
headingDemo variant size label =
    Heading.view { label = label, variant = variant }
        [ Heading.size size ]
        |> Element.toNode


buttonRow : List (Node (PagesMsg Msg)) -> Node (PagesMsg Msg)
buttonRow children =
    Layout.div "flex flex-wrap items-center gap-2" children



-- DEMOS PER COMPONENT --------------------------------------------------------


demoSections : String -> List (DemoSection (PagesMsg Msg))
demoSections slug =
    case slug of
        "appbar" ->
            [ usage
                [ sub "Basic"
                    (AppBar.view
                        [ AppBar.title (Heading.view { label = "Inbox", variant = Heading.Title } [])
                        , AppBar.leading (IconButton.view { icon = "menu", ariaLabel = "Open menu" } [])
                        , AppBar.trailing
                            [ IconButton.view { icon = "search", ariaLabel = "Search" } []
                            , IconButton.view { icon = "more_vert", ariaLabel = "More" } []
                            ]
                        ]
                        |> Element.toNode
                    )
                , sub "Sizes"
                    (Layout.div "w-full space-y-3"
                        [ AppBar.view [ AppBar.title (Heading.view { label = "Small", variant = Heading.Title } []), AppBar.size AppBar.Small ] |> Element.toNode
                        , AppBar.view [ AppBar.title (Heading.view { label = "Medium", variant = Heading.Title } []), AppBar.size AppBar.Medium ] |> Element.toNode
                        , AppBar.view [ AppBar.title (Heading.view { label = "Large", variant = Heading.Title } []), AppBar.size AppBar.Large ] |> Element.toNode
                        ]
                    )
                , sub "Centered title"
                    (AppBar.view
                        [ AppBar.title (Heading.view { label = "Profile", variant = Heading.Title } [])
                        , AppBar.centered True
                        , AppBar.leading (IconButton.view { icon = "arrow_back", ariaLabel = "Back" } [])
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "avatar" ->
            [ usage
                [ sub "Image"
                    (Avatar.view { ariaLabel = "Sample" } [ Avatar.image "/avatar-sample.svg" ] |> Element.toNode)
                , sub "Initials"
                    (Layout.div "flex flex-wrap items-center gap-3"
                        [ Avatar.view { ariaLabel = "Jane Reed" } [ Avatar.initials "Jane Reed" ] |> Element.toNode
                        , Avatar.view { ariaLabel = "AB" } [ Avatar.initials "AB" ] |> Element.toNode
                        , Avatar.view { ariaLabel = "Pat Lee" } [ Avatar.initials "Pat Lee" ] |> Element.toNode
                        ]
                    )
                ]
            ]

        "badge" ->
            [ usage
                [ sub "Dot"
                    (Layout.div "relative"
                        [ Icon.view { name = "notifications" } |> Element.toNode
                        , Badge.view [ Badge.dot ] |> Element.toNode
                        ]
                    )
                , sub "Count"
                    (Layout.div "relative"
                        [ Icon.view { name = "inbox" } |> Element.toNode
                        , Badge.view [ Badge.count 5 ] |> Element.toNode
                        ]
                    )
                , sub "Label"
                    (Layout.div "relative"
                        [ Icon.view { name = "shopping_bag" } |> Element.toNode
                        , Badge.view [ Badge.label "New" ] |> Element.toNode
                        ]
                    )
                ]
            ]

        "bottomsheet" ->
            [ usage
                [ sub "Closed preview"
                    (Layout.div "w-full space-y-3"
                        [ Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "Bottom sheets render at the bottom of the viewport and are normally hidden until opened. The composition below has "
                                , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                                , text " — see the Reply study for a working compose-mail bottom sheet."
                                ]
                            )
                        , BottomSheet.view { content = [] }
                            [ BottomSheet.open False, BottomSheet.onClose PagesMsg.noOp ]
                            |> Element.toNode
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
                            , Breadcrumb.item { label = "Breadcrumb" } [ Breadcrumb.itemCurrent Breadcrumb.Page ]
                            ]
                        }
                        []
                        |> Element.toNode
                    )
                ]
            ]

        "button" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ Button.view { label = "Elevated", variant = Button.Elevated } [] |> Element.toNode
                        , Button.view { label = "Filled", variant = Button.Filled } [] |> Element.toNode
                        , Button.view { label = "Tonal", variant = Button.Tonal } [] |> Element.toNode
                        , Button.view { label = "Outlined", variant = Button.Outlined } [] |> Element.toNode
                        , Button.view { label = "Text", variant = Button.Text } [] |> Element.toNode
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ Button.view { label = "Rounded", variant = Button.Filled } [ Button.shape Button.Rounded ] |> Element.toNode
                        , Button.view { label = "Square", variant = Button.Filled } [ Button.shape Button.Square ] |> Element.toNode
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ Button.view { label = "XS", variant = Button.Tonal } [ Button.size Button.ExtraSmall ] |> Element.toNode
                        , Button.view { label = "Small", variant = Button.Tonal } [ Button.size Button.Small ] |> Element.toNode
                        , Button.view { label = "Medium", variant = Button.Tonal } [ Button.size Button.Medium ] |> Element.toNode
                        , Button.view { label = "Large", variant = Button.Tonal } [ Button.size Button.Large ] |> Element.toNode
                        , Button.view { label = "XL", variant = Button.Tonal } [ Button.size Button.ExtraLarge ] |> Element.toNode
                        ]
                    )
                , sub "Icons"
                    (buttonRow
                        [ Button.view { label = "Send", variant = Button.Tonal }
                            [ Button.leadingIcon (Icon.view { name = "send" }) ]
                            |> Element.toNode
                        , Button.view { label = "Open", variant = Button.Tonal }
                            [ Button.trailingIcon (Icon.view { name = "open_in_new" }) ]
                            |> Element.toNode
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ Button.view { label = "Disabled", variant = Button.Filled } [ Button.disabled True ] |> Element.toNode
                        , Button.view { label = "Disabled (soft)", variant = Button.Filled } [ Button.disabled True ] |> Element.toNode
                        ]
                    )
                , sub "Links"
                    (Button.view { label = "Visit Google", variant = Button.Tonal }
                        [ Button.trailingIcon (Icon.view { name = "open_in_new" })
                        , Button.href "https://www.google.com"
                        ]
                        |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "calendar" ->
            [ usage
                [ sub "Single date"
                    (Calendar.view
                        [ Calendar.date "2026-06-24"
                        , Calendar.minDate "2026-01-01"
                        , Calendar.maxDate "2026-12-31"
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "card" ->
            [ usage
                [ sub "Variants"
                    (Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-3 w-full"
                        [ Card.view
                            [ Card.variant Card.Elevated
                            , Card.headline (Heading.view { label = "Elevated", variant = Heading.Title } [])
                            , Card.body [ Element.html (text "Raised shadow surface, highest emphasis.") ]
                            ]
                            |> Element.toNode
                        , Card.view
                            [ Card.variant Card.Filled
                            , Card.headline (Heading.view { label = "Filled", variant = Heading.Title } [])
                            , Card.body [ Element.html (text "Solid tonal surface, medium emphasis.") ]
                            ]
                            |> Element.toNode
                        , Card.view
                            [ Card.variant Card.Outlined
                            , Card.headline (Heading.view { label = "Outlined", variant = Heading.Title } [])
                            , Card.body [ Element.html (text "Bordered, no fill, lowest emphasis.") ]
                            ]
                            |> Element.toNode
                        ]
                    )
                , sub "Anatomy"
                    (Card.view
                        [ Card.variant Card.Outlined
                        , Card.headline (Heading.view { label = "Compliance scorecard", variant = Heading.Title } [])
                        , Card.subhead (Heading.view { label = "Updated 2 hours ago", variant = Heading.Label } [])
                        , Card.body [ Element.html (text "Supporting body text gives context to the headline.") ]
                        , Card.actions
                            [ Button.view { label = "Review", variant = Button.Filled } []
                            , Button.view { label = "Dismiss", variant = Button.Text } []
                            ]
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "checkbox" ->
            [ usage
                [ sub "Basic"
                    (Layout.div "flex flex-wrap items-center gap-6"
                        [ Checkbox.view { ariaLabel = "Unchecked" } [ Checkbox.checked False, Checkbox.onChange noOp ] |> Element.toNode
                        , Checkbox.view { ariaLabel = "Checked" } [ Checkbox.checked True, Checkbox.onChange noOp ] |> Element.toNode
                        ]
                    )
                , sub "Indeterminate (tristate)"
                    (Checkbox.view { ariaLabel = "Select all" }
                        [ Checkbox.indeterminate True, Checkbox.onChange noOp ]
                        |> Element.toNode
                    )
                , sub "Disabling"
                    (Layout.div "flex flex-wrap items-center gap-6"
                        [ Checkbox.view { ariaLabel = "Disabled" }
                            [ Checkbox.checked False, Checkbox.disabled True, Checkbox.onChange noOp ]
                            |> Element.toNode
                        , Checkbox.view { ariaLabel = "Disabled checked" }
                            [ Checkbox.checked True, Checkbox.disabled True, Checkbox.onChange noOp ]
                            |> Element.toNode
                        ]
                    )
                ]
            ]

        "chip" ->
            [ usage
                [ sub "Assist"
                    (Chip.assist { label = "Assist", onClick = PagesMsg.noOp } [] |> Element.toNode)
                , sub "Suggestion"
                    (Chip.suggestion { label = "Suggestion", onClick = PagesMsg.noOp } [] |> Element.toNode)
                , sub "Filter"
                    (Chip.filter { label = "Filter", onToggle = PagesMsg.noOp } [] |> Element.toNode)
                , sub "Input"
                    (Chip.input { label = "Input", onRemove = PagesMsg.noOp } [] |> Element.toNode)
                ]
            ]

        "datepicker" ->
            [ usage
                [ sub "Basic"
                    (DatePicker.view [ DatePicker.onChange noOp ] |> Element.toNode)
                ]
            ]

        "dialog" ->
            [ usage
                [ sub "Closed preview"
                    (Layout.div "w-full space-y-3"
                        [ Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "Dialogs render on top of the viewport and are normally hidden until opened. The composition below has "
                                , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                                , text ". See the Reply study (archive confirm) or Shrine (product details) for live wiring."
                                ]
                            )
                        , Dialog.view
                            { headline = "Confirm deletion"
                            , content = [ Element.html (text "This action permanently removes the project and all of its files.") ]
                            }
                            [ Dialog.open False, Dialog.onClose PagesMsg.noOp ]
                            |> Element.toNode
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
                                , content = [ Element.html (p [ class "text-body-md" ] [ text "Expandable content lives here. Tap the headline to toggle." ]) ]
                                }
                                []
                            ]
                        }
                        []
                        |> Element.toNode
                    )
                ]
            ]

        "divider" ->
            [ usage
                [ sub "Horizontal"
                    (Divider.view [] |> Element.toNode)
                , sub "Inset start"
                    (Divider.view [ Divider.insetStart True ] |> Element.toNode)
                ]
            ]

        "extendedfab" ->
            [ usage
                [ sub "Variants"
                    (Layout.div "flex flex-wrap items-center gap-3"
                        [ ExtendedFab.view { icon = "edit", label = "Primary", variant = ExtendedFab.Primary } [] |> Element.toNode
                        , ExtendedFab.view { icon = "edit", label = "Secondary", variant = ExtendedFab.Secondary } [] |> Element.toNode
                        , ExtendedFab.view { icon = "edit", label = "Tertiary", variant = ExtendedFab.Tertiary } [] |> Element.toNode
                        , ExtendedFab.view { icon = "edit", label = "Surface", variant = ExtendedFab.Surface } [] |> Element.toNode
                        ]
                    )
                , sub "Lowered"
                    (ExtendedFab.view { icon = "edit", label = "Lowered", variant = ExtendedFab.Primary }
                        [ ExtendedFab.lowered True ]
                        |> Element.toNode
                    )
                , sub "Disabled"
                    (ExtendedFab.view { icon = "edit", label = "Disabled", variant = ExtendedFab.Primary }
                        [ ExtendedFab.disabled True ]
                        |> Element.toNode
                    )
                ]
            ]

        "fab" ->
            [ usage
                [ sub "Variants"
                    (Layout.div "flex flex-wrap items-center gap-4"
                        [ Fab.view { icon = "add", ariaLabel = "Primary" } [ Fab.variant Fab.Primary ] |> Element.toNode
                        , Fab.view { icon = "add", ariaLabel = "Secondary" } [ Fab.variant Fab.Secondary ] |> Element.toNode
                        , Fab.view { icon = "add", ariaLabel = "Tertiary" } [ Fab.variant Fab.Tertiary ] |> Element.toNode
                        , Fab.view { icon = "add", ariaLabel = "Surface" } [ Fab.variant Fab.Surface ] |> Element.toNode
                        ]
                    )
                , sub "Sizes"
                    (Layout.div "flex flex-wrap items-center gap-4"
                        [ Fab.view { icon = "add", ariaLabel = "Small" } [ Fab.variant Fab.Primary, Fab.size Fab.Small ] |> Element.toNode
                        , Fab.view { icon = "add", ariaLabel = "Medium" } [ Fab.variant Fab.Primary, Fab.size Fab.Medium ] |> Element.toNode
                        , Fab.view { icon = "add", ariaLabel = "Large" } [ Fab.variant Fab.Primary, Fab.size Fab.Large ] |> Element.toNode
                        ]
                    )
                , sub "Lowered"
                    (Fab.view { icon = "add", ariaLabel = "Lowered" }
                        [ Fab.variant Fab.Primary, Fab.lowered True ]
                        |> Element.toNode
                    )
                , sub "Disabled"
                    (Fab.view { icon = "add", ariaLabel = "Disabled" }
                        [ Fab.variant Fab.Primary, Fab.disabled True ]
                        |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "heading" ->
            [ usage
                [ sub "Display"
                    (Layout.div "w-full space-y-2"
                        [ headingDemo Heading.Display Heading.Large "Display Large"
                        , headingDemo Heading.Display Heading.Medium "Display Medium"
                        , headingDemo Heading.Display Heading.Small "Display Small"
                        ]
                    )
                , sub "Headline"
                    (Layout.div "w-full space-y-2"
                        [ headingDemo Heading.Headline Heading.Large "Headline Large"
                        , headingDemo Heading.Headline Heading.Medium "Headline Medium"
                        , headingDemo Heading.Headline Heading.Small "Headline Small"
                        ]
                    )
                , sub "Title"
                    (Layout.div "w-full space-y-2"
                        [ headingDemo Heading.Title Heading.Large "Title Large"
                        , headingDemo Heading.Title Heading.Medium "Title Medium"
                        , headingDemo Heading.Title Heading.Small "Title Small"
                        ]
                    )
                , sub "Label"
                    (Layout.div "w-full space-y-2"
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
                    (Layout.div "flex flex-wrap items-center gap-4 text-3xl"
                        [ Icon.view { name = "home" } |> Element.toNode
                        , Icon.view { name = "settings" } |> Element.toNode
                        , Icon.view { name = "notifications" } |> Element.toNode
                        , Icon.view { name = "search" } |> Element.toNode
                        ]
                    )
                , sub "Filled axis"
                    (Layout.div "flex flex-wrap items-center gap-4 text-3xl"
                        [ Icon.view { name = "favorite" } |> Element.toNode
                        , Icon.view { name = "favorite" } |> Element.toNode
                        ]
                    )
                , sub "Weight axis"
                    (Layout.div "flex flex-wrap items-center gap-4 text-3xl"
                        [ Icon.view { name = "circle" } |> Element.toNode
                        , Icon.view { name = "circle" } |> Element.toNode
                        , Icon.view { name = "circle" } |> Element.toNode
                        , Icon.view { name = "circle" } |> Element.toNode
                        ]
                    )
                ]
            ]

        "iconbutton" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ IconButton.view { icon = "favorite", ariaLabel = "Like (standard)" } [] |> Element.toNode
                        , IconButton.view { icon = "favorite", ariaLabel = "Like (filled)" } [ IconButton.variant IconButton.Filled ] |> Element.toNode
                        , IconButton.view { icon = "favorite", ariaLabel = "Like (tonal)" } [ IconButton.variant IconButton.Tonal ] |> Element.toNode
                        , IconButton.view { icon = "favorite", ariaLabel = "Like (outlined)" } [ IconButton.variant IconButton.Outlined ] |> Element.toNode
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ IconButton.view { icon = "check", ariaLabel = "Round" } [ IconButton.variant IconButton.Filled, IconButton.shape IconButton.Round ] |> Element.toNode
                        , IconButton.view { icon = "check", ariaLabel = "Square" } [ IconButton.variant IconButton.Filled, IconButton.shape IconButton.Square ] |> Element.toNode
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ IconButton.view { icon = "add", ariaLabel = "XS" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.ExtraSmall ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "Small" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Small ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "Medium" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Medium ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "Large" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.Large ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "XL" } [ IconButton.variant IconButton.Tonal, IconButton.size IconButton.ExtraLarge ] |> Element.toNode
                        ]
                    )
                , sub "Widths"
                    (buttonRow
                        [ IconButton.view { icon = "add", ariaLabel = "Narrow" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Narrow ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "Default" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Default ] |> Element.toNode
                        , IconButton.view { icon = "add", ariaLabel = "Wide" } [ IconButton.variant IconButton.Tonal, IconButton.width IconButton.Wide ] |> Element.toNode
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ IconButton.view { icon = "check", ariaLabel = "Disabled" } [ IconButton.variant IconButton.Filled, IconButton.disabled True ] |> Element.toNode
                        , IconButton.view { icon = "check", ariaLabel = "Disabled (soft)" } [ IconButton.variant IconButton.Filled, IconButton.disabled True ] |> Element.toNode
                        ]
                    )
                ]
            ]

        "list" ->
            [ usage
                [ sub "Basic"
                    (List_.list
                        { items =
                            [ List_.item { headline = "First item" } []
                            , List_.item { headline = "Second item" } []
                            , List_.item { headline = "Third item" } []
                            ]
                        }
                        []
                        |> Element.toNode
                    )
                ]
            ]

        "loadingindicator" ->
            [ usage
                [ sub "Basic"
                    (LoadingIndicator.view [] |> Element.toNode)
                ]
            ]

        "menu" ->
            [ usage
                [ sub "With trigger"
                    (Layout.div "flex items-center gap-2"
                        [ IconButton.view { icon = "more_vert", ariaLabel = "Open demo menu" }
                            [ IconButton.extraContent [ Menu.triggerFor "demo-menu" ] ]
                            |> Element.toNode
                        , Menu.view
                            { items =
                                [ Menu.item { label = "Refresh", action = Menu.Click PagesMsg.noOp } []
                                , Menu.item { label = "Settings", action = Menu.Click PagesMsg.noOp } []
                                , Menu.item { label = "Sign out", action = Menu.Click PagesMsg.noOp } []
                                ]
                            }
                            [ Menu.id "demo-menu" ]
                            |> Element.toNode
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
                        |> Element.toNode
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
                        |> Element.toNode
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
                        [ NavigationDrawer.open True
                        , NavigationDrawer.mode NavigationDrawer.ModeSide
                        ]
                        |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "paginator" ->
            [ usage
                [ sub "Basic"
                    (Paginator.view { length = 53 }
                        [ Paginator.pageIndex 0 ]
                        |> Element.toNode
                    )
                , sub "With first/last"
                    (Paginator.view { length = 200 }
                        [ Paginator.pageIndex 4
                        , Paginator.showFirstLastButtons True
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "progress" ->
            [ usage
                [ sub "Linear"
                    (Progress.view { shape = Progress.Linear } [ Progress.value 60 ] |> Element.toNode)
                , sub "Circular"
                    (Progress.view { shape = Progress.Circular } [ Progress.value 40 ] |> Element.toNode)
                , sub "Indeterminate"
                    (Layout.div "flex flex-wrap items-center gap-6"
                        [ Progress.view { shape = Progress.Linear } [] |> Element.toNode
                        , Progress.view { shape = Progress.Circular } [] |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "scrollcontainer" ->
            [ usage
                [ sub "Top + bottom dividers"
                    (ScrollContainer.view
                        { content =
                            [ Element.html
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
                        |> Element.toNode
                    )
                ]
            ]

        "search" ->
            [ usage
                [ sub "Bar"
                    (Search.view { placeholder = "Search the docs" } [] |> Element.toNode)
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
                        |> Element.toNode
                    )
                , sub "Multi select"
                    (SegmentedButton.view
                        { segments =
                            [ SegmentedButton.segment { label = "Weekdays", checked = True } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            , SegmentedButton.segment { label = "Weekend", checked = False } [ SegmentedButton.segmentOnClick PagesMsg.noOp ]
                            ]
                        }
                        [ SegmentedButton.multi True ]
                        |> Element.toNode
                    )
                ]
            ]

        "select" ->
            [ usage
                [ sub "Single"
                    (Select.view { label = "Sort by" }
                        [ Select.options
                            [ Select.option { value = "recent", label = "Most recent" } [ Select.optionSelected True ]
                            , Select.option { value = "oldest", label = "Oldest" } []
                            , Select.option { value = "name", label = "By name" } []
                            ]
                        , Select.onChange noOp
                        ]
                        |> Element.toNode
                    )
                , sub "Multi"
                    (Select.view { label = "Categories" }
                        [ Select.options
                            [ Select.option { value = "news", label = "News" } [ Select.optionSelected True ]
                            , Select.option { value = "blog", label = "Blog" } [ Select.optionSelected True ]
                            , Select.option { value = "video", label = "Video" } []
                            ]
                        , Select.onChange noOp
                        , Select.multi True
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "shape" ->
            [ usage
                [ sub "Decorative shapes"
                    (Layout.div "flex flex-wrap items-center gap-4"
                        [ Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Circle ] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-secondary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Flower ] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-24 h-16 bg-tertiary-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Pill ] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-error-container" ] []) ] } [ Shape.name Cem.M3e.Shape.Heart ] |> Element.toNode
                        ]
                    )
                , sub "Corner-radius scale"
                    (Layout.div "flex flex-wrap items-end gap-4"
                        [ Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-none" ] []) ] } [] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-small" ] []) ] } [] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-medium" ] []) ] } [] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-md-corner-large" ] []) ] } [] |> Element.toNode
                        , Shape.view { content = [ Element.html (Html.div [ class "block w-16 h-16 bg-primary-container rounded-full" ] []) ] } [] |> Element.toNode
                        ]
                    )
                ]
            ]

        "sidesheet" ->
            [ usage
                [ sub "Closed preview"
                    (Layout.div "w-full space-y-3"
                        [ Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "Side sheets anchor to the start or end edge of the viewport. The composition below has "
                                , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                                , text "; modality is opt-in. See Reply or Settings for live wiring."
                                ]
                            )
                        , SideSheet.view { content = [] }
                            [ SideSheet.open False, SideSheet.onClose PagesMsg.noOp ]
                            |> Element.toNode
                        ]
                    )
                ]
            ]

        "skeleton" ->
            [ usage
                [ sub "Lines + block"
                    (Layout.div "flex w-full flex-col gap-2"
                        [ Skeleton.view { content = [ Element.html (Html.div [ class "h-5 w-2/3" ] []) ] } [] |> Element.toNode
                        , Skeleton.view { content = [ Element.html (Html.div [ class "h-5 w-1/2" ] []) ] } [] |> Element.toNode
                        , Skeleton.view { content = [ Element.html (Html.div [ class "h-32 w-full" ] []) ] } [] |> Element.toNode
                        ]
                    )
                , sub "Loaded (reveals content)"
                    (Skeleton.view
                        { content =
                            [ Element.html
                                (div [ class "rounded bg-surface-container p-3 text-body-md" ]
                                    [ text "Real content, revealed once loaded." ]
                                )
                            ]
                        }
                        [ Skeleton.loaded True ]
                        |> Element.toNode
                    )
                ]
            ]

        "slide" ->
            [ usage
                [ sub "Basic"
                    (Slide.view
                        { items =
                            List.map
                                (\( label, swatch ) ->
                                    Element.html
                                        (div [ class ("flex h-24 w-40 shrink-0 items-center justify-center rounded-md-corner-large text-on-surface " ++ swatch) ]
                                            [ text label ]
                                        )
                                )
                                [ ( "Spring", "bg-tertiary-container" )
                                , ( "Summer", "bg-primary-container" )
                                , ( "Autumn", "bg-secondary-container" )
                                , ( "Winter", "bg-surface-container-high" )
                                ]
                        }
                        [ Slide.selectedIndex 0 ]
                        |> Element.toNode
                    )
                ]
            ]

        "slider" ->
            [ usage
                [ sub "Basic value"
                    (Slider.view { name = "Volume" } [ Slider.value 35 ] |> Element.toNode)
                , sub "Discrete (tick marks)"
                    (Slider.view { name = "Brightness" }
                        [ Slider.value 60
                        , Slider.step 10
                        , Slider.discrete True
                        ]
                        |> Element.toNode
                    )
                , sub "Disabled"
                    (Slider.view { name = "Locked" }
                        [ Slider.value 50
                        , Slider.disabled True
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "snackbar" ->
            [ usage
                [ sub "Basic"
                    (Snackbar.view { message = "Message sent" } [] |> Element.toNode)
                ]
            ]

        "splitbutton" ->
            [ usage
                [ sub "Basic"
                    (SplitButton.view
                        { label = "Save"
                        , name = "More options"
                        , trailingContent = [ Icon.view { name = "arrow_drop_down" } ]
                        , onPrimaryClick = PagesMsg.noOp
                        , onTriggerClick = PagesMsg.noOp
                        }
                        []
                        |> Element.toNode
                    )
                ]
            ]

        "splitpane" ->
            [ usage
                [ sub "Horizontal"
                    (SplitPane.view
                        { start = [ Element.html (p [ class "p-4 text-body-md" ] [ text "Start pane" ]) ]
                        , end = [ Element.html (p [ class "p-4 text-body-md" ] [ text "End pane" ]) ]
                        }
                        []
                        |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "switch" ->
            [ usage
                [ sub "Basic"
                    (Layout.div "flex flex-wrap items-center gap-6"
                        [ Switch.view { ariaLabel = "Off" } [ Switch.checked False, Switch.onChange noOp ] |> Element.toNode
                        , Switch.view { ariaLabel = "On" } [ Switch.checked True, Switch.onChange noOp ] |> Element.toNode
                        ]
                    )
                , sub "Handle icons"
                    (Switch.view { ariaLabel = "Notifications" }
                        [ Switch.checked True
                        , Switch.icons Switch.Both
                        , Switch.onChange noOp
                        ]
                        |> Element.toNode
                    )
                , sub "Disabled"
                    (Layout.div "flex flex-wrap items-center gap-6"
                        [ Switch.view { ariaLabel = "Off (disabled)" }
                            [ Switch.checked False, Switch.disabled True, Switch.onChange noOp ]
                            |> Element.toNode
                        , Switch.view { ariaLabel = "On (disabled)" }
                            [ Switch.checked True, Switch.disabled True, Switch.onChange noOp ]
                            |> Element.toNode
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
                        |> Element.toNode
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
                        |> Element.toNode
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
                        |> Element.toNode
                    )
                ]
            ]

        "textfield" ->
            [ usage
                [ sub "Variants"
                    (Layout.div "w-full max-w-md space-y-4"
                        [ TextField.view { label = "Name (filled)" }
                            [ TextField.variant TextField.Filled
                            , TextField.value ""
                            , TextField.onInput noOp
                            ]
                            |> Element.toNode
                        , TextField.view { label = "Name (outlined)" }
                            [ TextField.variant TextField.Outlined
                            , TextField.value ""
                            , TextField.onInput noOp
                            ]
                            |> Element.toNode
                        ]
                    )
                , sub "Input types"
                    (Layout.div "w-full max-w-md space-y-4"
                        [ TextField.view { label = "Email" }
                            [ TextField.variant TextField.Outlined
                            , TextField.value ""
                            , TextField.inputType TextField.Email
                            , TextField.onInput noOp
                            ]
                            |> Element.toNode
                        , TextField.view { label = "URL" }
                            [ TextField.variant TextField.Outlined
                            , TextField.value ""
                            , TextField.inputType TextField.Url
                            , TextField.onInput noOp
                            ]
                            |> Element.toNode
                        ]
                    )
                , sub "Multiline"
                    (TextField.view { label = "Notes" }
                        [ TextField.variant TextField.Outlined
                        , TextField.value ""
                        , TextField.onInput noOp
                        , TextField.multiline True
                        , TextField.rows 3
                        ]
                        |> Element.toNode
                    )
                , sub "Prefix and suffix"
                    (TextField.view { label = "Price" }
                        [ TextField.variant TextField.Outlined
                        , TextField.value ""
                        , TextField.onInput noOp
                        , TextField.prefix (Element.text "$")
                        , TextField.suffix (Element.text "USD")
                        ]
                        |> Element.toNode
                    )
                , sub "Disabled"
                    (TextField.view { label = "Locked" }
                        [ TextField.variant TextField.Outlined
                        , TextField.value "Read-only value"
                        , TextField.onInput noOp
                        , TextField.disabled True
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "texthighlight" ->
            [ usage
                [ sub "Highlight a term"
                    (TextHighlight.view
                        { content =
                            [ Element.html
                                (text "M3e.TextHighlight wraps any inline content and highlights every occurrence of a search term.")
                            ]
                        }
                        [ TextHighlight.term "highlight" ]
                        |> Element.toNode
                    )
                ]
            ]

        "theme" ->
            [ usage
                [ sub "About"
                    (Node.raw
                        (p [ class "text-body-md" ]
                            [ text "M3e.Theme wraps "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "<m3e-theme>" ]
                            , text ". A single instance owns the dynamic-color scheme, contrast, density, and motion for its subtree — the docs shell mounts it once at the root, which you're inside now. Try the settings popover in the app bar."
                            ]
                        )
                    )
                ]
            ]

        "timepicker" ->
            [ usage
                [ sub "Basic"
                    (TimePicker.view { label = "Meeting time" }
                        [ TimePicker.value "14:30"
                        , TimePicker.onChange noOp
                        ]
                        |> Element.toNode
                    )
                ]
            ]

        "toc" ->
            [ usage
                [ sub "Basic"
                    (Layout.div "flex gap-6"
                        [ Toc.view { for = "toc-demo-content" } [ Toc.title "On this page" ] |> Element.toNode
                        , Node.raw
                            (div [ Attr.id "toc-demo-content", class "min-w-0 flex-1 space-y-3" ]
                                [ Html.h2 [ Attr.id "toc-overview", class "text-title-md" ] [ text "Overview" ]
                                , p [ class "text-body-md text-on-surface-variant" ] [ text "The table of contents tracks the headings inside the referenced container." ]
                                , Html.h2 [ Attr.id "toc-usage", class "text-title-md" ] [ text "Usage" ]
                                , p [ class "text-body-md text-on-surface-variant" ] [ text "Point `for` at the id of the content element whose headings should be scanned." ]
                                , Html.h2 [ Attr.id "toc-api", class "text-title-md" ] [ text "API" ]
                                , p [ class "text-body-md text-on-surface-variant" ] [ text "The optional title and maxDepth options refine the rendered list." ]
                                ]
                            )
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
                        |> Element.toNode
                    )
                ]
            ]

        "tooltip" ->
            [ usage
                [ sub "Plain tooltip"
                    (Layout.div "flex flex-wrap items-center gap-3"
                        [ Node.element "span" [ Node.rawAttr (Attr.id "tooltip-anchor-demo") ]
                            [ IconButton.view { icon = "refresh", ariaLabel = "Refresh" }
                                [ IconButton.variant IconButton.Tonal ]
                                |> Element.toNode
                            ]
                        , Tooltip.plain { anchorId = "tooltip-anchor-demo", label = "Refresh data" } []
                            |> Element.toNode
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
                        , control = Switch.view { ariaLabel = "Reduce motion" } [ Switch.checked True ]
                        }
                    )
                , sub "Outlined variant with error"
                    (Field.view
                        { id = "field-project-name"
                        , label = Label.fromHtml (Html.text "Project name")
                        , control =
                            Element.element { tag = "input" }
                                [ Node.rawAttr (Attr.value "atlas") ]
                                []
                        }
                    )
                ]
            ]

        "text" ->
            [ usage
                [ sub "Body roles"
                    (Layout.div "w-full space-y-2"
                        [ Text.bodyLarge "Body large — default running text." |> Element.toNode
                        , Text.bodyMedium "Body medium — secondary copy." |> Element.toNode
                        , Text.bodySmall "Body small — captions and footnotes." |> Element.toNode
                        ]
                    )
                , sub "Label roles"
                    (Layout.div "flex flex-wrap items-center gap-4"
                        [ Text.labelLarge "Label large" |> Element.toNode
                        , Text.labelMedium "Label medium" |> Element.toNode
                        , Text.labelSmall "Label small" |> Element.toNode
                        ]
                    )
                ]
            ]

        _ ->
            []
