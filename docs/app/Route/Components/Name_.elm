module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| Dynamic per-component documentation page, mirroring matraic's component
pages. One route per slug in `data/reference.json`: page title, intro prose,
import statement, live demo sections (Usage with H3 sub-demos: Variants /
Shapes / Sizes / Icons / Toggle / Disabling / Links, etc.), and the
extracted API table.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, p, pre, section, text)
import Html.Attributes as Attr exposing (class)
import Json.Decode as Decode
import M3e.Shape
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import SyntaxHighlight
import Ui.AppBar as AppBar
import Ui.Avatar as Avatar
import Ui.Badge as Badge
import Ui.BottomSheet as BottomSheet
import Ui.Breadcrumb as Breadcrumb
import Ui.Button as Button
import Ui.ButtonGroup as ButtonGroup
import Ui.Calendar as Calendar
import Ui.Card as Card
import Ui.Checkbox as Checkbox
import Ui.Chip as Chip
import Ui.DatePicker as DatePicker
import Ui.Dialog as Dialog
import Ui.Disclosure as Disclosure
import Ui.Divider as Divider
import Ui.ExtendedFab as ExtendedFab
import Ui.Fab as Fab
import Ui.FabMenu as FabMenu
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.List as L
import Ui.LoadingIndicator as LoadingIndicator
import Ui.Menu as Menu
import Ui.NavigationBar as NavigationBar
import Ui.NavigationDrawer as NavigationDrawer
import Ui.NavigationRail as NavigationRail
import Ui.Paginator as Paginator
import Ui.Progress as Progress
import Ui.RadioButton as RadioButton
import Ui.ScrollContainer as ScrollContainer
import Ui.Search as Search
import Ui.SegmentedButton as SegmentedButton
import Ui.Select as Select
import Ui.Shape as Shape
import Ui.SideSheet as SideSheet
import Ui.Skeleton as Skeleton
import Ui.Slide as Slide
import Ui.Slider as Slider
import Ui.Snackbar as Snackbar
import Ui.SplitButton as SplitButton
import Ui.SplitPane as SplitPane
import Ui.Stepper as Stepper
import Ui.Switch as Switch
import Ui.Tabs as Tabs
import Ui.TextField as TextField
import Ui.TextHighlight as TextHighlight
import Ui.TimePicker as TimePicker
import Ui.Toc as Toc
import Ui.Toolbar as Toolbar
import Ui.Tooltip as Tooltip
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
        [ h2Heading "Import"
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


{-| A documentation section. `title` is the H2 heading (e.g. "Usage"). `subs`
are H3 sub-demos — each one a labelled live `Ui.*` composition — that match
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
    Heading.new
        |> Heading.withLevel 2
        |> Heading.withVariant Heading.Headline
        |> Heading.withSize Heading.Medium
        |> Heading.withContent (text label)
        |> Heading.view


h3Heading : String -> Html msg
h3Heading label =
    Heading.new
        |> Heading.withLevel 3
        |> Heading.withVariant Heading.Headline
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text label)
        |> Heading.view


demoSection : DemoSection (PagesMsg Msg) -> Html (PagesMsg Msg)
demoSection ds =
    section [ class "space-y-4" ]
        (h2Heading ds.title :: List.map subView ds.subs)


subView : Sub (PagesMsg Msg) -> Html (PagesMsg Msg)
subView s =
    section [ class "space-y-3" ]
        [ h3Heading s.title
        , Card.new Card.Outlined
            |> Card.withBody (div [ class "flex flex-wrap items-center gap-4" ] [ s.body ])
            |> Card.view
        ]


codeBlock : String -> Html msg
codeBlock s =
    let
        trimmed : String
        trimmed =
            String.trim s

        -- SyntaxHighlight.toBlockHtml emits its own <pre class="elmsh">, so we
        -- wrap it in a <div> (not <pre>) to keep the surface styling without
        -- emitting invalid pre-inside-pre markup.
        wrapperClass : String
        wrapperClass =
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-small leading-relaxed text-on-surface"
    in
    case SyntaxHighlight.elm trimmed of
        Ok highlighted ->
            div [ class wrapperClass ]
                [ SyntaxHighlight.toBlockHtml Nothing highlighted ]

        Err _ ->
            pre [ class wrapperClass ]
                [ code [] [ text trimmed ] ]


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


headingDemo : Heading.Variant -> Heading.Size -> String -> Html msg
headingDemo variant size label =
    Heading.new
        |> Heading.withVariant variant
        |> Heading.withSize size
        |> Heading.withContent (text label)
        |> Heading.view


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
                    (AppBar.new
                        |> AppBar.withTitle (Heading.title "Inbox")
                        |> AppBar.withLeadingIconButton
                            (IconButton.new { icon = Icon.material "menu", label = "Open menu", variant = IconButton.Standard })
                        |> AppBar.withTrailingIconButton
                            (IconButton.new { icon = Icon.material "search", label = "Search", variant = IconButton.Standard })
                        |> AppBar.withTrailingIconButton
                            (IconButton.new { icon = Icon.material "more_vert", label = "More", variant = IconButton.Standard })
                        |> AppBar.view
                    )
                , sub "Sizes"
                    (div [ class "w-full space-y-3" ]
                        [ AppBar.new |> AppBar.withTitle (Heading.title "Small") |> AppBar.withSize AppBar.Small |> AppBar.view
                        , AppBar.new |> AppBar.withTitle (Heading.title "Medium") |> AppBar.withSize AppBar.Medium |> AppBar.view
                        , AppBar.new |> AppBar.withTitle (Heading.title "Large") |> AppBar.withSize AppBar.Large |> AppBar.view
                        ]
                    )
                , sub "Centered title"
                    (AppBar.new
                        |> AppBar.withTitle (Heading.title "Profile")
                        |> AppBar.withCentered True
                        |> AppBar.withLeadingIconButton
                            (IconButton.new { icon = Icon.material "arrow_back", label = "Back", variant = IconButton.Standard })
                        |> AppBar.view
                    )
                ]
            ]

        "avatar" ->
            [ usage
                [ sub "Image"
                    (Avatar.image { url = "/avatar-sample.svg", alt = "Sample" } |> Avatar.view)
                , sub "Initials"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ Avatar.initials "Jane Reed" |> Avatar.view
                        , Avatar.initials "AB" |> Avatar.view
                        , Avatar.initials "Pat Lee" |> Avatar.view
                        ]
                    )
                ]
            ]

        "badge" ->
            [ usage
                [ sub "Dot"
                    (div [ class "relative" ]
                        [ Icon.material "notifications" |> Icon.view
                        , Badge.dot |> Badge.view
                        ]
                    )
                , sub "Count"
                    (div [ class "relative" ]
                        [ Icon.material "inbox" |> Icon.view
                        , Badge.count 5 |> Badge.view
                        ]
                    )
                , sub "Label"
                    (div [ class "relative" ]
                        [ Icon.material "shopping_bag" |> Icon.view
                        , Badge.label "New" |> Badge.view
                        ]
                    )
                ]
            ]

        "bottomsheet" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-medium text-on-surface-variant" ]
                            [ text "Bottom sheets render at the bottom of the viewport and are normally hidden until opened. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text " — see the Reply study for a working compose-mail bottom sheet."
                            ]
                        , BottomSheet.new { open = False, onClose = PagesMsg.noOp }
                            |> BottomSheet.view
                        ]
                    )
                ]
            ]

        "breadcrumb" ->
            [ usage
                [ sub "Basic"
                    (Breadcrumb.new
                        |> Breadcrumb.withItems
                            [ Breadcrumb.link "Home" "#"
                            , Breadcrumb.link "Components" "#"
                            , Breadcrumb.current "Breadcrumb"
                            ]
                        |> Breadcrumb.view
                    )
                ]
            ]

        "button" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ Button.new { label = "Elevated", variant = Button.Elevated } |> Button.view
                        , Button.new { label = "Filled", variant = Button.Filled } |> Button.view
                        , Button.new { label = "Tonal", variant = Button.Tonal } |> Button.view
                        , Button.new { label = "Outlined", variant = Button.Outlined } |> Button.view
                        , Button.new { label = "Text", variant = Button.Text } |> Button.view
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ Button.new { label = "Round", variant = Button.Filled } |> Button.withShape Button.Round |> Button.view
                        , Button.new { label = "Square", variant = Button.Filled } |> Button.withShape Button.Square |> Button.view
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ Button.new { label = "XS", variant = Button.Tonal } |> Button.withSize Button.ExtraSmall |> Button.view
                        , Button.new { label = "Small", variant = Button.Tonal } |> Button.withSize Button.Small |> Button.view
                        , Button.new { label = "Medium", variant = Button.Tonal } |> Button.withSize Button.Medium |> Button.view
                        , Button.new { label = "Large", variant = Button.Tonal } |> Button.withSize Button.Large |> Button.view
                        , Button.new { label = "XL", variant = Button.Tonal } |> Button.withSize Button.ExtraLarge |> Button.view
                        ]
                    )
                , sub "Icons"
                    (buttonRow
                        [ Button.new { label = "Send", variant = Button.Tonal }
                            |> Button.withLeadingIcon (Icon.material "send")
                            |> Button.view
                        , Button.new { label = "Open", variant = Button.Tonal }
                            |> Button.withTrailingIcon (Icon.material "open_in_new")
                            |> Button.view
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ Button.new { label = "Disabled", variant = Button.Filled } |> Button.withDisabled Button.Disabled |> Button.view
                        , Button.new { label = "Disabled (interactive)", variant = Button.Filled } |> Button.withDisabled Button.DisabledInteractive |> Button.view
                        ]
                    )
                , sub "Links"
                    (Button.new { label = "Visit Google", variant = Button.Tonal }
                        |> Button.withTrailingIcon (Icon.material "open_in_new")
                        |> Button.withHref "https://www.google.com"
                        |> Button.view
                    )
                ]
            ]

        "buttongroup" ->
            [ usage
                [ sub "Basic"
                    (ButtonGroup.new
                        [ Button.new { label = "One", variant = Button.Filled }
                        , Button.new { label = "Two", variant = Button.Filled }
                        , Button.new { label = "Three", variant = Button.Filled }
                        ]
                        |> ButtonGroup.view
                    )
                ]
            ]

        "calendar" ->
            [ usage
                [ sub "Single date"
                    (Calendar.new
                        |> Calendar.withDate "2026-06-24"
                        |> Calendar.withMinDate "2026-01-01"
                        |> Calendar.withMaxDate "2026-12-31"
                        |> Calendar.view
                    )
                ]
            ]

        "card" ->
            [ usage
                [ sub "Variants"
                    (div [ class "grid grid-cols-1 gap-4 sm:grid-cols-3 w-full" ]
                        [ Card.new Card.Elevated
                            |> Card.withHeadline (Heading.title "Elevated")
                            |> Card.withBody (text "Raised shadow surface, highest emphasis.")
                            |> Card.view
                        , Card.new Card.Filled
                            |> Card.withHeadline (Heading.title "Filled")
                            |> Card.withBody (text "Solid tonal surface, medium emphasis.")
                            |> Card.view
                        , Card.new Card.Outlined
                            |> Card.withHeadline (Heading.title "Outlined")
                            |> Card.withBody (text "Bordered, no fill, lowest emphasis.")
                            |> Card.view
                        ]
                    )
                , sub "Anatomy"
                    (Card.new Card.Outlined
                        |> Card.withHeadline (Heading.title "Compliance scorecard")
                        |> Card.withSubhead (Heading.label "Updated 2 hours ago")
                        |> Card.withBody (text "Supporting body text gives context to the headline.")
                        |> Card.withActions
                            [ Button.new { label = "Review", variant = Button.Filled }
                            , Button.new { label = "Dismiss", variant = Button.Text }
                            ]
                        |> Card.view
                    )
                ]
            ]

        "checkbox" ->
            [ usage
                [ sub "Basic"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Checkbox.boolean { label = "Unchecked", checked = False, onChange = noOp } |> Checkbox.view
                        , Checkbox.boolean { label = "Checked", checked = True, onChange = noOp } |> Checkbox.view
                        ]
                    )
                , sub "Indeterminate (tristate)"
                    (Checkbox.tristate { label = "Select all", state = Nothing, onChange = noOp }
                        |> Checkbox.view
                    )
                , sub "Required"
                    (Checkbox.boolean { label = "Accept terms", checked = False, onChange = noOp }
                        |> Checkbox.withRequired True
                        |> Checkbox.view
                    )
                , sub "Disabling"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Checkbox.boolean { label = "Disabled", checked = False, onChange = noOp }
                            |> Checkbox.withDisabled True
                            |> Checkbox.view
                        , Checkbox.boolean { label = "Disabled checked", checked = True, onChange = noOp }
                            |> Checkbox.withDisabled True
                            |> Checkbox.view
                        ]
                    )
                ]
            ]

        "chip" ->
            [ usage
                [ sub "Assist"
                    (Chip.assist { id = "demo-chip-assist", label = "Assist", onClick = PagesMsg.noOp } |> Chip.view)
                , sub "Suggestion"
                    (Chip.suggestion { id = "demo-chip-suggestion", label = "Suggestion", onClick = PagesMsg.noOp } |> Chip.view)
                , sub "Filter"
                    (Chip.filter { id = "demo-chip-filter", label = "Filter", onToggle = PagesMsg.noOp } |> Chip.view)
                , sub "Input"
                    (Chip.input { id = "demo-chip-input", label = "Input", onRemove = PagesMsg.noOp } |> Chip.view)
                ]
            ]

        "datepicker" ->
            [ usage
                [ sub "Basic"
                    (DatePicker.new (\_ -> PagesMsg.noOp) |> DatePicker.view)
                ]
            ]

        "dialog" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-medium text-on-surface-variant" ]
                            [ text "Dialogs render on top of the viewport and are normally hidden until opened. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text ". See the Reply study (archive confirm) or Shrine (product details) for live wiring."
                            ]
                        , Dialog.new { title = "Confirm deletion", open = False, onClose = PagesMsg.noOp }
                            |> Dialog.withBody (text "This action permanently removes the project and all of its files.")
                            |> Dialog.view
                        ]
                    )
                ]
            ]

        "disclosure" ->
            [ usage
                [ sub "Single panel"
                    (Disclosure.single
                        "demo-disclosure"
                        (text "Show more")
                        [ p [ class "text-body-medium" ] [ text "Expandable content lives here. Tap the headline to toggle." ] ]
                        |> Disclosure.view
                    )
                ]
            ]

        "divider" ->
            [ usage
                [ sub "Horizontal"
                    (Divider.new |> Divider.view)
                , sub "Inset start"
                    (Divider.new |> Divider.withInsetStart True |> Divider.view)
                ]
            ]

        "extendedfab" ->
            [ usage
                [ sub "Variants"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ ExtendedFab.new { icon = Icon.material "edit", label = "Primary", variant = ExtendedFab.Primary } |> ExtendedFab.view
                        , ExtendedFab.new { icon = Icon.material "edit", label = "Secondary", variant = ExtendedFab.Secondary } |> ExtendedFab.view
                        , ExtendedFab.new { icon = Icon.material "edit", label = "Tertiary", variant = ExtendedFab.Tertiary } |> ExtendedFab.view
                        , ExtendedFab.new { icon = Icon.material "edit", label = "Surface", variant = ExtendedFab.Surface } |> ExtendedFab.view
                        ]
                    )
                , sub "Lowered"
                    (ExtendedFab.new { icon = Icon.material "edit", label = "Lowered", variant = ExtendedFab.Primary }
                        |> ExtendedFab.withLowered True
                        |> ExtendedFab.view
                    )
                , sub "Disabled"
                    (ExtendedFab.new { icon = Icon.material "edit", label = "Disabled", variant = ExtendedFab.Primary }
                        |> ExtendedFab.withDisabled True
                        |> ExtendedFab.view
                    )
                ]
            ]

        "fab" ->
            [ usage
                [ sub "Variants"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Fab.new { icon = Icon.material "add", label = "Primary", variant = Fab.Primary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Secondary", variant = Fab.Secondary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Tertiary", variant = Fab.Tertiary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Surface", variant = Fab.Surface } |> Fab.view
                        ]
                    )
                , sub "Sizes"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Fab.new { icon = Icon.material "add", label = "Small", variant = Fab.Primary } |> Fab.withSize Fab.Small |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Medium", variant = Fab.Primary } |> Fab.withSize Fab.Medium |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Large", variant = Fab.Primary } |> Fab.withSize Fab.Large |> Fab.view
                        ]
                    )
                , sub "Lowered"
                    (Fab.new { icon = Icon.material "add", label = "Lowered", variant = Fab.Primary }
                        |> Fab.withLowered True
                        |> Fab.view
                    )
                , sub "Disabled"
                    (Fab.new { icon = Icon.material "add", label = "Disabled", variant = Fab.Primary }
                        |> Fab.withDisabled True
                        |> Fab.view
                    )
                ]
            ]

        "fabmenu" ->
            [ usage
                [ sub "Basic"
                    (FabMenu.new
                        { triggerIcon = Icon.material "menu"
                        , triggerLabel = "Open actions"
                        , variant = FabMenu.Primary
                        , items =
                            [ FabMenu.item { icon = Icon.material "edit", label = "Compose", onClick = PagesMsg.noOp }
                            , FabMenu.item { icon = Icon.material "image", label = "Add photo", onClick = PagesMsg.noOp }
                            , FabMenu.item { icon = Icon.material "videocam", label = "Record video", onClick = PagesMsg.noOp }
                            ]
                        }
                        |> FabMenu.view
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
                        [ Icon.material "home" |> Icon.view
                        , Icon.material "settings" |> Icon.view
                        , Icon.material "notifications" |> Icon.view
                        , Icon.material "search" |> Icon.view
                        ]
                    )
                , sub "Filled axis"
                    (div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.material "favorite" |> Icon.view
                        , Icon.material "favorite" |> Icon.withFilled True |> Icon.view
                        ]
                    )
                , sub "Weight axis"
                    (div [ class "flex flex-wrap items-center gap-4 text-3xl" ]
                        [ Icon.material "circle" |> Icon.withWeight Icon.Light |> Icon.view
                        , Icon.material "circle" |> Icon.withWeight Icon.Regular |> Icon.view
                        , Icon.material "circle" |> Icon.withWeight Icon.Medium |> Icon.view
                        , Icon.material "circle" |> Icon.withWeight Icon.Bold |> Icon.view
                        ]
                    )
                ]
            ]

        "iconbutton" ->
            [ usage
                [ sub "Variants"
                    (buttonRow
                        [ IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Standard } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Filled } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Tonal } |> IconButton.view
                        , IconButton.new { icon = Icon.material "favorite", label = "Like", variant = IconButton.Outlined } |> IconButton.view
                        ]
                    )
                , sub "Shapes"
                    (buttonRow
                        [ IconButton.new { icon = Icon.material "check", label = "Round", variant = IconButton.Filled } |> IconButton.withShape IconButton.Round |> IconButton.view
                        , IconButton.new { icon = Icon.material "check", label = "Square", variant = IconButton.Filled } |> IconButton.withShape IconButton.Square |> IconButton.view
                        ]
                    )
                , sub "Sizes"
                    (buttonRow
                        [ IconButton.new { icon = Icon.material "add", label = "XS", variant = IconButton.Tonal } |> IconButton.withSize IconButton.ExtraSmall |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "Small", variant = IconButton.Tonal } |> IconButton.withSize IconButton.Small |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "Medium", variant = IconButton.Tonal } |> IconButton.withSize IconButton.Medium |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "Large", variant = IconButton.Tonal } |> IconButton.withSize IconButton.Large |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "XL", variant = IconButton.Tonal } |> IconButton.withSize IconButton.ExtraLarge |> IconButton.view
                        ]
                    )
                , sub "Widths"
                    (buttonRow
                        [ IconButton.new { icon = Icon.material "add", label = "Narrow", variant = IconButton.Tonal } |> IconButton.withWidth IconButton.Narrow |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "Default", variant = IconButton.Tonal } |> IconButton.withWidth IconButton.Default |> IconButton.view
                        , IconButton.new { icon = Icon.material "add", label = "Wide", variant = IconButton.Tonal } |> IconButton.withWidth IconButton.Wide |> IconButton.view
                        ]
                    )
                , sub "Disabling"
                    (buttonRow
                        [ IconButton.new { icon = Icon.material "check", label = "Disabled", variant = IconButton.Filled } |> IconButton.withDisabled IconButton.Disabled |> IconButton.view
                        , IconButton.new { icon = Icon.material "check", label = "Disabled (interactive)", variant = IconButton.Filled } |> IconButton.withDisabled IconButton.DisabledInteractive |> IconButton.view
                        ]
                    )
                ]
            ]

        "list" ->
            [ usage
                [ sub "Basic"
                    (L.new
                        [ L.item "First item"
                        , L.item "Second item"
                        , L.item "Third item"
                        ]
                        |> L.view
                    )
                ]
            ]

        "loadingindicator" ->
            [ usage
                [ sub "Basic"
                    (LoadingIndicator.new |> LoadingIndicator.view)
                ]
            ]

        "menu" ->
            [ usage
                [ sub "Basic"
                    (Menu.new
                        [ Menu.item "Refresh" PagesMsg.noOp
                        , Menu.item "Settings" PagesMsg.noOp
                        , Menu.item "Sign out" PagesMsg.noOp
                        ]
                        |> Menu.view
                    )
                ]
            ]

        "navigationbar" ->
            [ usage
                [ sub "Basic"
                    (NavigationBar.new
                        { items =
                            [ NavigationBar.item { value = "home", icon = Icon.material "home" } |> NavigationBar.withItemLabel "Home"
                            , NavigationBar.item { value = "search", icon = Icon.material "search" } |> NavigationBar.withItemLabel "Search"
                            , NavigationBar.item { value = "saved", icon = Icon.material "bookmark" } |> NavigationBar.withItemLabel "Saved"
                            ]
                        , selected = Just "home"
                        , onChange = noOp
                        }
                        |> NavigationBar.view
                    )
                , sub "With badges"
                    (NavigationBar.new
                        { items =
                            [ NavigationBar.item { value = "inbox", icon = Icon.material "inbox" }
                                |> NavigationBar.withItemLabel "Inbox"
                                |> NavigationBar.withItemBadge "3"
                            , NavigationBar.item { value = "alerts", icon = Icon.material "notifications" }
                                |> NavigationBar.withItemLabel "Alerts"
                                |> NavigationBar.withItemBadge "12"
                            , NavigationBar.item { value = "profile", icon = Icon.material "person" }
                                |> NavigationBar.withItemLabel "Profile"
                            ]
                        , selected = Just "inbox"
                        , onChange = noOp
                        }
                        |> NavigationBar.view
                    )
                ]
            ]

        "navigationdrawer" ->
            [ usage
                [ sub "Side (non-modal)"
                    (NavigationDrawer.new
                        { items =
                            [ NavigationDrawer.item { value = "inbox", icon = Icon.material "inbox" } |> NavigationDrawer.withItemLabel "Inbox"
                            , NavigationDrawer.item { value = "starred", icon = Icon.material "star" } |> NavigationDrawer.withItemLabel "Starred"
                            , NavigationDrawer.item { value = "trash", icon = Icon.material "delete" } |> NavigationDrawer.withItemLabel "Trash"
                            ]
                        , selected = Just "inbox"
                        , onChange = noOp
                        }
                        |> NavigationDrawer.withModal False
                        |> NavigationDrawer.view
                    )
                ]
            ]

        "navigationrail" ->
            [ usage
                [ sub "Basic"
                    (NavigationRail.new
                        { items =
                            [ NavigationRail.item { value = "home", icon = Icon.material "home" } |> NavigationRail.withItemLabel "Home"
                            , NavigationRail.item { value = "search", icon = Icon.material "search" } |> NavigationRail.withItemLabel "Search"
                            , NavigationRail.item { value = "saved", icon = Icon.material "bookmark" } |> NavigationRail.withItemLabel "Saved"
                            ]
                        , selected = Just "home"
                        , onChange = noOp
                        }
                        |> NavigationRail.view
                    )
                ]
            ]

        "paginator" ->
            [ usage
                [ sub "Basic"
                    (Paginator.new
                        |> Paginator.withLength 53
                        |> Paginator.withDefaultPage 0
                        |> Paginator.view
                    )
                , sub "With first/last"
                    (Paginator.new
                        |> Paginator.withLength 200
                        |> Paginator.withDefaultPage 4
                        |> Paginator.withFirstLastButtons True
                        |> Paginator.view
                    )
                ]
            ]

        "progress" ->
            [ usage
                [ sub "Linear"
                    (Progress.linear 60 |> Progress.view)
                , sub "Circular"
                    (Progress.circular 40 |> Progress.view)
                , sub "Indeterminate"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Progress.indeterminate Progress.Linear |> Progress.view
                        , Progress.indeterminate Progress.Circular |> Progress.view
                        ]
                    )
                ]
            ]

        "radiobutton" ->
            [ usage
                [ sub "Basic"
                    (RadioButton.group
                        { label = "Billing cycle"
                        , options =
                            [ RadioButton.option { value = "monthly", label = "Monthly" }
                            , RadioButton.option { value = "yearly", label = "Yearly" }
                            ]
                        , selected = Just "monthly"
                        , onChange = noOp
                        }
                        |> RadioButton.view
                    )
                ]
            ]

        "scrollcontainer" ->
            [ usage
                [ sub "Top + bottom dividers"
                    (ScrollContainer.new
                        |> ScrollContainer.withDividers ScrollContainer.Both
                        |> ScrollContainer.view
                            [ div [ class "h-32 overflow-auto p-3 text-body-medium" ]
                                [ p [] [ text "Item 1" ]
                                , p [] [ text "Item 2" ]
                                , p [] [ text "Item 3" ]
                                , p [] [ text "Item 4" ]
                                , p [] [ text "Item 5" ]
                                , p [] [ text "Item 6" ]
                                , p [] [ text "Item 7" ]
                                ]
                            ]
                    )
                ]
            ]

        "search" ->
            [ usage
                [ sub "Bar"
                    (Search.bar
                        |> Search.withPlaceholder "Search the docs"
                        |> Search.view
                    )
                ]
            ]

        "segmentedbutton" ->
            [ usage
                [ sub "Single select"
                    (SegmentedButton.single
                        { label = "Layout"
                        , segments =
                            [ SegmentedButton.segment { value = "grid", label = "Grid" }
                            , SegmentedButton.segment { value = "list", label = "List" }
                            ]
                        , selected = Just "grid"
                        , onChange = noOp
                        }
                        |> SegmentedButton.view
                    )
                , sub "Multi select"
                    (SegmentedButton.multi
                        { label = "Days"
                        , segments =
                            [ SegmentedButton.segment { value = "wk", label = "Weekdays" }
                            , SegmentedButton.segment { value = "we", label = "Weekend" }
                            ]
                        , selected = [ "wk" ]
                        , onChange = noOp
                        }
                        |> SegmentedButton.view
                    )
                ]
            ]

        "select" ->
            [ usage
                [ sub "Single"
                    (Select.single
                        { label = "Sort by"
                        , options =
                            [ Select.option { value = "recent", label = "Most recent" }
                            , Select.option { value = "oldest", label = "Oldest" }
                            , Select.option { value = "name", label = "By name" }
                            ]
                        , selected = Just "recent"
                        , onChange = noOp
                        }
                        |> Select.view
                    )
                , sub "Multi"
                    (Select.multi
                        { label = "Categories"
                        , options =
                            [ Select.option { value = "news", label = "News" }
                            , Select.option { value = "blog", label = "Blog" }
                            , Select.option { value = "video", label = "Video" }
                            ]
                        , selected = [ "news", "blog" ]
                        , onChange = noOp
                        }
                        |> Select.view
                    )
                ]
            ]

        "shape" ->
            [ usage
                [ sub "Decorative shapes"
                    (div [ class "flex flex-wrap items-center gap-4" ]
                        [ Shape.new |> Shape.withName M3e.Shape.Circle |> Shape.withClass "block w-16 h-16 bg-primary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Flower |> Shape.withClass "block w-16 h-16 bg-secondary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Pill |> Shape.withClass "block w-24 h-16 bg-tertiary-container" |> Shape.view
                        , Shape.new |> Shape.withName M3e.Shape.Heart |> Shape.withClass "block w-16 h-16 bg-error-container" |> Shape.view
                        ]
                    )
                , sub "Corner-radius scale"
                    (div [ class "flex flex-wrap items-end gap-4" ]
                        [ Shape.new |> Shape.withClass "block w-16 h-16 bg-primary-container rounded-md-corner-none" |> Shape.view
                        , Shape.new |> Shape.withClass "block w-16 h-16 bg-primary-container rounded-md-corner-small" |> Shape.view
                        , Shape.new |> Shape.withClass "block w-16 h-16 bg-primary-container rounded-md-corner-medium" |> Shape.view
                        , Shape.new |> Shape.withClass "block w-16 h-16 bg-primary-container rounded-md-corner-large" |> Shape.view
                        , Shape.new |> Shape.withClass "block w-16 h-16 bg-primary-container rounded-full" |> Shape.view
                        ]
                    )
                ]
            ]

        "sidesheet" ->
            [ usage
                [ sub "Closed preview"
                    (div [ class "w-full space-y-3" ]
                        [ p [ class "text-body-medium text-on-surface-variant" ]
                            [ text "Side sheets anchor to the start or end edge of the viewport. The composition below has "
                            , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "open = False" ]
                            , text "; modality is opt-in. See Reply or Settings for live wiring."
                            ]
                        , SideSheet.new { open = False, onClose = PagesMsg.noOp }
                            |> SideSheet.view
                        ]
                    )
                ]
            ]

        "skeleton" ->
            [ usage
                [ sub "Lines + block"
                    (div [ class "flex w-full flex-col gap-2" ]
                        [ Skeleton.new |> Skeleton.withClass "h-5 w-2/3" |> Skeleton.view
                        , Skeleton.new |> Skeleton.withClass "h-5 w-1/2" |> Skeleton.view
                        , Skeleton.new |> Skeleton.withClass "h-32 w-full" |> Skeleton.view
                        ]
                    )
                ]
            ]

        "slide" ->
            [ usage
                [ sub "Basic"
                    (Slide.new |> Slide.withId "demo-slide" |> Slide.view)
                ]
            ]

        "slider" ->
            [ usage
                [ sub "Basic value"
                    (Slider.value { label = "Volume", value = 35, onChange = noOp } |> Slider.view)
                , sub "Range"
                    (Slider.range { label = "Price range", value = { start = 25, end = 75 }, onChange = noOp } |> Slider.view)
                , sub "Discrete (tick marks)"
                    (Slider.value { label = "Brightness", value = 60, onChange = noOp }
                        |> Slider.withStep 10
                        |> Slider.withDiscrete True
                        |> Slider.view
                    )
                , sub "Disabled"
                    (Slider.value { label = "Locked", value = 50, onChange = noOp }
                        |> Slider.withDisabled True
                        |> Slider.view
                    )
                ]
            ]

        "snackbar" ->
            [ usage
                [ sub "Basic"
                    (Snackbar.new "Message sent" |> Snackbar.view)
                ]
            ]

        "splitbutton" ->
            [ usage
                [ sub "Basic"
                    (SplitButton.new
                        { label = "Save"
                        , onPrimaryClick = PagesMsg.noOp
                        , onTriggerClick = PagesMsg.noOp
                        , trailingIcon = Icon.material "arrow_drop_down"
                        }
                        |> SplitButton.view
                    )
                ]
            ]

        "splitpane" ->
            [ usage
                [ sub "Horizontal"
                    (SplitPane.new
                        |> SplitPane.withStart [ p [ class "p-4 text-body-medium" ] [ text "Start pane" ] ]
                        |> SplitPane.withEnd [ p [ class "p-4 text-body-medium" ] [ text "End pane" ] ]
                        |> SplitPane.view
                    )
                ]
            ]

        "stepper" ->
            [ usage
                [ sub "Basic"
                    (Stepper.new
                        |> Stepper.withSteps
                            [ Stepper.step "demo-step-1" (text "Account") []
                            , Stepper.step "demo-step-2" (text "Profile") []
                            , Stepper.step "demo-step-3" (text "Confirm") []
                            ]
                        |> Stepper.view
                    )
                ]
            ]

        "switch" ->
            [ usage
                [ sub "Basic"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Switch.new { label = "Off", checked = False, onChange = noOp } |> Switch.view
                        , Switch.new { label = "On", checked = True, onChange = noOp } |> Switch.view
                        ]
                    )
                , sub "Handle icons"
                    (Switch.new { label = "Notifications", checked = True, onChange = noOp }
                        |> Switch.withHandleIcons True
                        |> Switch.view
                    )
                , sub "Disabled"
                    (div [ class "flex flex-wrap items-center gap-6" ]
                        [ Switch.new { label = "Off (disabled)", checked = False, onChange = noOp }
                            |> Switch.withDisabled True
                            |> Switch.view
                        , Switch.new { label = "On (disabled)", checked = True, onChange = noOp }
                            |> Switch.withDisabled True
                            |> Switch.view
                        ]
                    )
                ]
            ]

        "tabs" ->
            [ usage
                [ sub "Basic"
                    (Tabs.new
                        { tabs =
                            [ Tabs.tab { value = "overview", label = "Overview" }
                            , Tabs.tab { value = "specs", label = "Specs" }
                            , Tabs.tab { value = "reviews", label = "Reviews" }
                            ]
                        , selected = "overview"
                        , onChange = noOp
                        }
                        |> Tabs.view
                    )
                , sub "With icons + badges"
                    (Tabs.new
                        { tabs =
                            [ Tabs.tab { value = "inbox", label = "Inbox" }
                                |> Tabs.withTabIcon (Icon.material "inbox")
                                |> Tabs.withTabBadge "5"
                            , Tabs.tab { value = "sent", label = "Sent" }
                                |> Tabs.withTabIcon (Icon.material "send")
                            , Tabs.tab { value = "trash", label = "Trash" }
                                |> Tabs.withTabIcon (Icon.material "delete")
                            ]
                        , selected = "inbox"
                        , onChange = noOp
                        }
                        |> Tabs.view
                    )
                , sub "Stretched"
                    (Tabs.new
                        { tabs =
                            [ Tabs.tab { value = "day", label = "Day" }
                            , Tabs.tab { value = "week", label = "Week" }
                            , Tabs.tab { value = "month", label = "Month" }
                            ]
                        , selected = "week"
                        , onChange = noOp
                        }
                        |> Tabs.withStretch True
                        |> Tabs.view
                    )
                ]
            ]

        "textfield" ->
            [ usage
                [ sub "Variants"
                    (div [ class "w-full max-w-md space-y-4" ]
                        [ TextField.text { label = "Name (filled)", value = "", variant = TextField.Filled, onChange = noOp } |> TextField.view
                        , TextField.text { label = "Name (outlined)", value = "", variant = TextField.Outlined, onChange = noOp } |> TextField.view
                        ]
                    )
                , sub "Validators"
                    (div [ class "w-full max-w-md space-y-4" ]
                        [ TextField.text { label = "Email", value = "", variant = TextField.Outlined, onChange = noOp }
                            |> TextField.withEmailValidator
                            |> TextField.view
                        , TextField.text { label = "URL", value = "", variant = TextField.Outlined, onChange = noOp }
                            |> TextField.withUrlValidator
                            |> TextField.view
                        ]
                    )
                , sub "Multiline"
                    (TextField.multiline { label = "Notes", value = "", variant = TextField.Outlined, onChange = noOp }
                        |> TextField.withRows 3
                        |> TextField.view
                    )
                , sub "Prefix and suffix"
                    (TextField.text { label = "Price", value = "", variant = TextField.Outlined, onChange = noOp }
                        |> TextField.withPrefix (text "$")
                        |> TextField.withSuffix (text "USD")
                        |> TextField.view
                    )
                , sub "Disabled"
                    (TextField.text { label = "Locked", value = "Read-only value", variant = TextField.Outlined, onChange = noOp }
                        |> TextField.withDisabled True
                        |> TextField.view
                    )
                ]
            ]

        "texthighlight" ->
            [ usage
                [ sub "Highlight a term"
                    (TextHighlight.new
                        |> TextHighlight.withTerm "highlight"
                        |> TextHighlight.view
                            [ text "Ui.TextHighlight wraps any inline content and highlights every occurrence of a search term." ]
                    )
                ]
            ]

        "theme" ->
            [ usage
                [ sub "About"
                    (p [ class "text-body-medium" ]
                        [ text "Ui.Theme wraps "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "<m3e-theme>" ]
                        , text ". A single instance owns the dynamic-color scheme, contrast, density, and motion for its subtree — the docs shell mounts it once at the root, which you're inside now. Try the settings popover in the app bar."
                        ]
                    )
                ]
            ]

        "timepicker" ->
            [ usage
                [ sub "Basic"
                    (TimePicker.new { label = "Meeting time", value = "14:30", onChange = noOp }
                        |> TimePicker.view
                    )
                ]
            ]

        "toc" ->
            [ usage
                [ sub "Basic"
                    (Toc.new |> Toc.view)
                ]
            ]

        "toolbar" ->
            [ usage
                [ sub "Basic"
                    (Toolbar.new
                        [ Button.new { label = "Save", variant = Button.Filled }
                        , Button.new { label = "Discard", variant = Button.Text }
                        ]
                        |> Toolbar.view
                    )
                ]
            ]

        "tooltip" ->
            [ usage
                [ sub "Plain tooltip"
                    (div [ class "flex flex-wrap items-center gap-3" ]
                        [ Html.span [ Attr.id "tooltip-anchor-demo" ]
                            [ IconButton.new { icon = Icon.material "refresh", label = "Refresh", variant = IconButton.Tonal }
                                |> IconButton.view
                            ]
                        , Tooltip.plain { anchorId = "tooltip-anchor-demo", label = "Refresh data" }
                            |> Tooltip.view
                        ]
                    )
                ]
            ]

        _ ->
            []
