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
import Html.Attributes as Attr exposing (class)
import Json.Decode as Decode
import M3e.Shape
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.AppBar as AppBar
import Ui.Avatar as Avatar
import Ui.Badge as Badge
import Ui.BottomSheet as BottomSheet
import Ui.Breadcrumb as Breadcrumb
import Ui.Button as Button
import Ui.ButtonGroup as ButtonGroup
import Ui.Calendar as Calendar
import Ui.Card as Card
import Ui.Carousel as Carousel
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
        "appbar" ->
            [ usage
                (AppBar.new "Inbox"
                    |> AppBar.withLeading
                        (IconButton.new { icon = Icon.material "menu", label = "Open menu", variant = IconButton.Standard }
                            |> IconButton.view
                        )
                    |> AppBar.withTrailing
                        [ IconButton.new { icon = Icon.material "search", label = "Search", variant = IconButton.Standard } |> IconButton.view
                        , IconButton.new { icon = Icon.material "more_vert", label = "More", variant = IconButton.Standard } |> IconButton.view
                        ]
                    |> AppBar.view
                )
            ]

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

        "bottomsheet" ->
            [ { title = "Inline preview"
              , body =
                    p [ class "text-body-medium text-on-surface-variant" ]
                        [ text "Bottom sheets render at the bottom of the viewport and are normally hidden until opened. In a real app, "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "Ui.BottomSheet.new { open, onClose }" ]
                        , text " is driven by app state with "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "withHeader/withBody/withActions" ]
                        , text ". See the Reply study for a working compose-mail bottom sheet."
                        ]
              }
            ]

        "breadcrumb" ->
            [ usage
                (Breadcrumb.new
                    |> Breadcrumb.withItems
                        [ Breadcrumb.link (text "Home") "#"
                        , Breadcrumb.link (text "Components") "#"
                        , Breadcrumb.current (text "Breadcrumb")
                        ]
                    |> Breadcrumb.view
                )
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

        "buttongroup" ->
            [ usage
                (ButtonGroup.new
                    [ Button.new { label = "One", variant = Button.Filled }
                    , Button.new { label = "Two", variant = Button.Filled }
                    , Button.new { label = "Three", variant = Button.Filled }
                    ]
                    |> ButtonGroup.view
                )
            ]

        "calendar" ->
            [ usage
                (Calendar.new
                    |> Calendar.withDate "2026-06-24"
                    |> Calendar.withMinDate "2026-01-01"
                    |> Calendar.withMaxDate "2026-12-31"
                    |> Calendar.view
                )
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

        "carousel" ->
            [ usage
                (Carousel.new
                    [ Shape.new |> Shape.withName M3e.Shape.Circle |> Shape.withClass "block h-32 w-48 bg-primary-container" |> Shape.view
                    , Shape.new |> Shape.withName M3e.Shape.Flower |> Shape.withClass "block h-32 w-48 bg-secondary-container" |> Shape.view
                    , Shape.new |> Shape.withName M3e.Shape.Pill |> Shape.withClass "block h-32 w-48 bg-tertiary-container" |> Shape.view
                    , Shape.new |> Shape.withName M3e.Shape.Heart |> Shape.withClass "block h-32 w-48 bg-primary-container" |> Shape.view
                    ]
                    |> Carousel.view
                )
            ]

        "checkbox" ->
            [ { title = "States"
              , body =
                    div [ class "flex flex-wrap items-center gap-6" ]
                        [ Checkbox.boolean { label = "Unchecked", checked = False, onChange = noOp }
                            |> Checkbox.view
                        , Checkbox.boolean { label = "Checked", checked = True, onChange = noOp }
                            |> Checkbox.view
                        ]
              }
            ]

        "chip" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-2" ]
                        [ Chip.assist { id = "demo-chip-assist", label = text "Assist", onClick = PagesMsg.noOp } |> Chip.view
                        , Chip.suggestion { id = "demo-chip-suggestion", label = text "Suggestion", onClick = PagesMsg.noOp } |> Chip.view
                        , Chip.filter { id = "demo-chip-filter", label = text "Filter", onToggle = PagesMsg.noOp } |> Chip.view
                        ]
              }
            ]

        "datepicker" ->
            [ usage
                (DatePicker.new (\_ -> PagesMsg.noOp)
                    |> DatePicker.view
                )
            ]

        "dialog" ->
            [ { title = "Inline preview"
              , body =
                    p [ class "text-body-medium text-on-surface-variant" ]
                        [ text "Dialogs render on top of the viewport and are normally hidden until opened. "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "Ui.Dialog.new { title, open, onClose }" ]
                        , text " supports "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "withBody" ]
                        , text " and "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "withActions" ]
                        , text ". See the Reply study (archive confirm) or Shrine (product details) for working examples."
                        ]
              }
            ]

        "disclosure" ->
            [ { title = "Single panel"
              , body =
                    Disclosure.single
                        "demo-disclosure"
                        (text "Show more")
                        [ p [ class "text-body-medium" ] [ text "Expandable content lives here. Tap the headline to toggle." ] ]
                        |> Disclosure.view
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

        "extendedfab" ->
            [ usage
                (ExtendedFab.new { icon = Icon.material "edit", label = "Compose", variant = ExtendedFab.Primary }
                    |> ExtendedFab.view
                )
            ]

        "fab" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-4" ]
                        [ Fab.new { icon = Icon.material "add", label = "Add", variant = Fab.Primary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Add", variant = Fab.Secondary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Add", variant = Fab.Tertiary } |> Fab.view
                        , Fab.new { icon = Icon.material "add", label = "Add", variant = Fab.Surface } |> Fab.view
                        ]
              }
            ]

        "fabmenu" ->
            [ usage
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

        "list" ->
            [ usage
                (L.new
                    [ L.item "First item"
                    , L.item "Second item"
                    , L.item "Third item"
                    ]
                    |> L.view
                )
            ]

        "loadingindicator" ->
            [ usage (LoadingIndicator.new |> LoadingIndicator.view) ]

        "menu" ->
            [ usage
                (Menu.new
                    [ Menu.item "Refresh" PagesMsg.noOp
                    , Menu.item "Settings" PagesMsg.noOp
                    , Menu.item "Sign out" PagesMsg.noOp
                    ]
                    |> Menu.view
                )
            ]

        "navigationbar" ->
            [ usage
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
            ]

        "navigationdrawer" ->
            [ usage
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

        "navigationrail" ->
            [ usage
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

        "paginator" ->
            [ usage
                (Paginator.new
                    |> Paginator.withLength 53
                    |> Paginator.withDefaultPage 0
                    |> Paginator.view
                )
            ]

        "progress" ->
            [ { title = "Variants"
              , body =
                    div [ class "flex flex-wrap items-center gap-6" ]
                        [ Progress.linear 60 |> Progress.view
                        , Progress.circular 40 |> Progress.view
                        ]
              }
            ]

        "scrollcontainer" ->
            [ usage
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

        "sidesheet" ->
            [ { title = "Inline preview"
              , body =
                    p [ class "text-body-medium text-on-surface-variant" ]
                        [ text "Side sheets anchor to the start or end edge of the viewport. "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "Ui.SideSheet.new { open, onClose }" ]
                        , text " supports "
                        , code [ class "rounded bg-surface-container px-1.5 py-0.5" ] [ text "withHeader/withBody/withActions" ]
                        , text "; modality is opt-in. See Reply or Settings for live wiring."
                        ]
              }
            ]

        "slide" ->
            [ usage
                (Slide.new
                    |> Slide.withId "demo-slide"
                    |> Slide.view
                )
            ]

        "splitbutton" ->
            [ usage
                (SplitButton.new
                    { label = "Save"
                    , onPrimaryClick = PagesMsg.noOp
                    , onTriggerClick = PagesMsg.noOp
                    , trailingIcon = Icon.material "arrow_drop_down"
                    }
                    |> SplitButton.view
                )
            ]

        "splitpane" ->
            [ usage
                (SplitPane.new
                    |> SplitPane.withStart
                        [ p [ class "p-4 text-body-medium" ] [ text "Start pane" ] ]
                    |> SplitPane.withEnd
                        [ p [ class "p-4 text-body-medium" ] [ text "End pane" ] ]
                    |> SplitPane.view
                )
            ]

        "stepper" ->
            [ usage
                (Stepper.new
                    |> Stepper.withSteps
                        [ Stepper.step "demo-step-1" (text "Account") []
                        , Stepper.step "demo-step-2" (text "Profile") []
                        , Stepper.step "demo-step-3" (text "Confirm") []
                        ]
                    |> Stepper.view
                )
            ]

        "radiobutton" ->
            [ usage
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

        "search" ->
            [ usage
                (Search.bar
                    |> Search.withPlaceholder "Search the docs"
                    |> Search.view
                )
            ]

        "segmentedbutton" ->
            [ usage
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
            ]

        "select" ->
            [ usage
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

        "slider" ->
            [ usage
                (Slider.value { label = "Volume", value = 35, onChange = noOp }
                    |> Slider.view
                )
            ]

        "snackbar" ->
            [ usage (Snackbar.new "Message sent" |> Snackbar.view) ]

        "switch" ->
            [ { title = "States"
              , body =
                    div [ class "flex flex-wrap items-center gap-6" ]
                        [ Switch.new { label = "Off", checked = False, onChange = noOp } |> Switch.view
                        , Switch.new { label = "On", checked = True, onChange = noOp } |> Switch.view
                        ]
              }
            ]

        "tabs" ->
            [ usage
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
            ]

        "textfield" ->
            [ { title = "Variants"
              , body =
                    div [ class "w-full max-w-md space-y-4" ]
                        [ TextField.text { label = "Name", value = "", variant = TextField.Filled, onChange = noOp } |> TextField.view
                        , TextField.text { label = "Email", value = "", variant = TextField.Outlined, onChange = noOp }
                            |> TextField.withEmailValidator
                            |> TextField.view
                        ]
              }
            ]

        "texthighlight" ->
            [ usage
                (TextHighlight.new
                    |> TextHighlight.withTerm "highlight"
                    |> TextHighlight.view
                        [ text "Ui.TextHighlight wraps any inline content and highlights every occurrence of a search term." ]
                )
            ]

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

        "timepicker" ->
            [ usage
                (TimePicker.new { label = "Meeting time", value = "14:30", onChange = noOp }
                    |> TimePicker.view
                )
            ]

        "toc" ->
            [ usage
                (Toc.new |> Toc.view)
            ]

        "toolbar" ->
            [ usage
                (Toolbar.new
                    [ Button.new { label = "Save", variant = Button.Filled }
                    , Button.new { label = "Discard", variant = Button.Text }
                    ]
                    |> Toolbar.view
                )
            ]

        "tooltip" ->
            [ { title = "Plain tooltip"
              , body =
                    div [ class "flex flex-wrap items-center gap-3" ]
                        [ Html.span [ Attr.id "tooltip-anchor-demo" ]
                            [ IconButton.new { icon = Icon.material "refresh", label = "Refresh", variant = IconButton.Tonal }
                                |> IconButton.view
                            ]
                        , Tooltip.plain { anchorId = "tooltip-anchor-demo", label = "Refresh data" }
                            |> Tooltip.view
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
