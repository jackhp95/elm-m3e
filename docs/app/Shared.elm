module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `Ui.AppBar`
top app bar with the live theme controls in an outlined `Ui.Card` popover,
and a persistent left sidebar mirroring matraic's IA. Every icon goes
through `Ui.Icon`; every action through `Ui.IconButton`; every theme
toggle through `Ui.SegmentedButton`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class, href)
import Html.Events
import Json.Decode as Decode
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Ui.AppBar as AppBar
import Ui.Card as Card
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.NavigationDrawer as NavigationDrawer
import Ui.SegmentedButton as SegmentedButton
import Ui.Theme as Theme
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just (\_ -> CloseMenu)
    }



-- MODEL


type alias Model =
    { showMenu : Bool
    , viewportWidth : Int
    , scheme : Theme.Scheme
    , seed : String
    , contrast : Theme.Contrast
    , density : Float
    , dir : Direction
    , settingsOpen : Bool
    }


{-| The Tailwind `md` breakpoint — drives the responsive nav-drawer mode and
the visibility of the hamburger / app-bar settings popover overflow.
-}
mdBreakpointPx : Int
mdBreakpointPx =
    768


isMobile : Model -> Bool
isMobile model =
    model.viewportWidth < mdBreakpointPx


{-| Text direction toggle (drives the `dir` attribute on the shell).
-}
type Direction
    = Ltr
    | Rtl


type alias Data =
    ()


type Msg
    = SharedMsg SharedMsg
    | MenuClicked
    | CloseMenu
    | MenuChanged Bool
    | ViewportResized Int
    | ToggleSettings
    | SetScheme Theme.Scheme
    | SetSeed String
    | SetContrast Theme.Contrast
    | SetDensity Float
    | SetDirection Direction


type SharedMsg
    = NoOp


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags _ =
    ( { showMenu = False
      , viewportWidth = initialViewportWidth flags
      , scheme = Theme.Light
      , seed = "#6750A4"
      , contrast = Theme.Standard
      , density = 0
      , dir = Ltr
      , settingsOpen = False
      }
    , Effect.none
    )


{-| Read `flags.width` (passed by docs/index.ts on the client). Falls back to
a desktop-leaning width so server-rendered HTML defaults to the side drawer.
-}
initialViewportWidth : Pages.Flags.Flags -> Int
initialViewportWidth flags =
    case flags of
        Pages.Flags.BrowserFlags raw ->
            Decode.decodeValue (Decode.field "width" Decode.int) raw
                |> Result.withDefault 1024

        Pages.Flags.PreRenderFlags ->
            1024


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg _ ->
            ( model, Effect.none )

        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )

        CloseMenu ->
            ( { model | showMenu = False }, Effect.none )

        MenuChanged open ->
            ( { model | showMenu = open }, Effect.none )

        ViewportResized w ->
            ( { model | viewportWidth = w }, Effect.none )

        ToggleSettings ->
            ( { model | settingsOpen = not model.settingsOpen }, Effect.none )

        SetScheme scheme ->
            ( { model | scheme = scheme }, Effect.none )

        SetSeed seed ->
            ( { model | seed = seed }, Effect.none )

        SetContrast contrast ->
            ( { model | contrast = contrast }, Effect.none )

        SetDensity density ->
            ( { model | density = density }, Effect.none )

        SetDirection dir ->
            ( { model | dir = dir }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Browser.Events.onResize (\w _ -> ViewportResized w)


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()



-- VIEW


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view _ page model toMsg pageView =
    { title = pageView.title
    , body =
        [ Theme.new
            |> Theme.withSeedColor model.seed
            |> Theme.withScheme model.scheme
            |> Theme.withContrast model.contrast
            |> Theme.withDensity model.density
            |> Theme.view
                [ Html.div
                    [ class "grid h-screen grid-rows-[auto_1fr] bg-surface text-on-surface"
                    , attribute "dir" (directionAttr model.dir)
                    ]
                    [ Html.map toMsg (appShellBar model)
                    , drawerShell toMsg model page pageView.body
                    ]
                ]
        ]
    }


normalizePath : String -> String
normalizePath path =
    if path /= "/" && String.endsWith "/" path then
        String.dropRight 1 path

    else
        path


directionAttr : Direction -> String
directionAttr dir =
    case dir of
        Ltr ->
            "ltr"

        Rtl ->
            "rtl"



-- TOP APP BAR


appShellBar : Model -> Html Msg
appShellBar model =
    Html.header
        [ class "sticky top-0 z-30 border-b border-outline-variant bg-surface-container shadow-md-level1" ]
        [ AppBar.new "elm-m3e"
            |> AppBar.withSubtitle "Material 3 Expressive for Elm"
            |> AppBar.withId "docs-app-bar"
            |> AppBar.withSize AppBar.Small
            |> AppBar.withLeading (menuButton model)
            |> AppBar.withTrailing
                [ schemeQuickToggle model
                , settingsTrigger model
                , githubLink
                ]
            |> AppBar.view
        ]


{-| The mobile hamburger. Drives the drawer through `MenuClicked` → showMenu →
`drawerShell`'s `withOpen`, which now emits `start` as an HTML attribute so
the drawer-container's CSS selectors actually react.

Why not `m3e-drawer-toggle`? Its `_toggleDrawer` does
`this.control.closest("m3e-drawer-container")` to find its target — our app
bar sits in a SIBLING of the drawer-container, not a descendant, so the
canonical toggle silently no-ops here. The Elm round-trip is the right call
until the shell layout puts the app bar inside the drawer.

-}
menuButton : Model -> Html Msg
menuButton _ =
    IconButton.new
        { icon = Icon.material "menu"
        , label = "Toggle navigation"
        , variant = IconButton.Standard
        }
        |> IconButton.withOnClick MenuClicked
        |> IconButton.withAttributes [ class "md:hidden" ]
        |> IconButton.view


githubLink : Html Msg
githubLink =
    IconButton.new
        { icon = Icon.material "code"
        , label = "GitHub repository"
        , variant = IconButton.Standard
        }
        |> IconButton.withHref "https://github.com/jackhp95/m3e-builder"
        |> IconButton.withTarget "_blank"
        |> IconButton.withRel "noreferrer noopener"
        |> IconButton.view


schemeQuickToggle : Model -> Html Msg
schemeQuickToggle model =
    let
        ( next, iconName, label ) =
            case model.scheme of
                Theme.Light ->
                    ( Theme.Dark, "dark_mode", "Switch to dark mode" )

                Theme.Dark ->
                    ( Theme.Auto, "brightness_auto", "Use system color scheme" )

                Theme.Auto ->
                    ( Theme.Light, "light_mode", "Switch to light mode" )
    in
    IconButton.new
        { icon = Icon.material iconName
        , label = label
        , variant = IconButton.Standard
        }
        |> IconButton.withOnClick (SetScheme next)
        |> IconButton.view



-- SETTINGS POPOVER (anchored to a relative-positioned wrapper)


settingsTrigger : Model -> Html Msg
settingsTrigger model =
    Html.div [ class "relative" ]
        [ IconButton.new
            { icon = Icon.material "tune"
            , label = "Theme settings"
            , variant = IconButton.Standard
            }
            |> IconButton.withOnClick ToggleSettings
            |> IconButton.view
        , if model.settingsOpen then
            settingsPanel model

          else
            Html.text ""
        ]


settingsPanel : Model -> Html Msg
settingsPanel model =
    -- `fixed` anchors to the viewport. With `absolute`, the nearest positioned
    -- ancestor was the tiny icon-button-wrapper (~40px wide), which made
    -- `left-2 right-2` resolve to a 24px-wide column — the "narrow" complaint.
    Html.div [ class "fixed left-2 right-2 top-14 z-40 sm:left-auto sm:right-2 sm:w-72" ]
        [ Card.new Card.Filled
            |> Card.withHeadline (Heading.title "Theme settings")
            |> Card.withBody (settingsBody model)
            |> Card.view
        ]


settingsBody : Model -> Html Msg
settingsBody model =
    Html.div [ class "space-y-4" ]
        [ schemeSegmented model
        , contrastSegmented model
        , seedColorInput model
        , densitySegmented model
        , directionSegmented model
        ]


schemeSegmented : Model -> Html Msg
schemeSegmented model =
    SegmentedButton.single
        { label = "Color scheme"
        , segments =
            [ SegmentedButton.segment { value = Theme.Light, label = "Light" }
            , SegmentedButton.segment { value = Theme.Auto, label = "System" }
            , SegmentedButton.segment { value = Theme.Dark, label = "Dark" }
            ]
        , selected = Just model.scheme
        , onChange = SetScheme
        }
        |> SegmentedButton.withId "docs-scheme"
        |> SegmentedButton.view


contrastSegmented : Model -> Html Msg
contrastSegmented model =
    SegmentedButton.single
        { label = "Contrast"
        , segments =
            [ SegmentedButton.segment { value = Theme.Standard, label = "Standard" }
            , SegmentedButton.segment { value = Theme.Medium, label = "Medium" }
            , SegmentedButton.segment { value = Theme.High, label = "High" }
            ]
        , selected = Just model.contrast
        , onChange = SetContrast
        }
        |> SegmentedButton.withId "docs-contrast"
        |> SegmentedButton.view


seedColorInput : Model -> Html Msg
seedColorInput model =
    Html.div [ class "space-y-1.5" ]
        [ Html.label
            [ Attr.for "docs-seed", class "block text-label-medium text-on-surface-variant" ]
            [ Html.text "Source color" ]
        , Html.div [ class "flex items-center gap-3" ]
            [ Html.input
                [ Attr.type_ "color"
                , Attr.id "docs-seed"
                , Attr.value model.seed
                , Html.Events.onInput SetSeed
                , class "h-9 w-12 cursor-pointer rounded border border-outline-variant bg-transparent"
                , attribute "aria-label" "Source color"
                ]
                []
            , Html.code [ class "text-body-small text-on-surface-variant" ] [ Html.text model.seed ]
            ]
        ]


densitySegmented : Model -> Html Msg
densitySegmented model =
    SegmentedButton.single
        { label = "Density"
        , segments =
            [ SegmentedButton.segment { value = 0, label = "0" }
            , SegmentedButton.segment { value = -1, label = "-1" }
            , SegmentedButton.segment { value = -2, label = "-2" }
            , SegmentedButton.segment { value = -3, label = "-3" }
            ]
        , selected = Just model.density
        , onChange = SetDensity
        }
        |> SegmentedButton.withId "docs-density"
        |> SegmentedButton.view


directionSegmented : Model -> Html Msg
directionSegmented model =
    SegmentedButton.single
        { label = "Direction"
        , segments =
            [ SegmentedButton.segment { value = Ltr, label = "LTR" }
            , SegmentedButton.segment { value = Rtl, label = "RTL" }
            ]
        , selected = Just model.dir
        , onChange = SetDirection
        }
        |> SegmentedButton.withId "docs-direction"
        |> SegmentedButton.view



-- SIDEBAR NAVIGATION (matraic IA)


type alias NavSection =
    { title : String, icon : String, items : List ( String, String ) }


navSections : List NavSection
navSections =
    [ { title = "Getting Started"
      , icon = "rocket_launch"
      , items =
            [ ( "/getting-started/overview", "Overview" )
            , ( "/getting-started/installation", "Installation" )
            , ( "/getting-started/browser-support", "Browser Support" )
            ]
      }
    , { title = "Styles"
      , icon = "palette"
      , items =
            [ ( "/styles/color", "Color" )
            , ( "/styles/typography", "Typography" )
            , ( "/styles/density", "Density" )
            , ( "/styles/motion", "Motion" )
            , ( "/styles/shape", "Shape" )
            ]
      }
    , { title = "Studies"
      , icon = "auto_awesome"
      , items =
            [ ( "/studies", "Overview" )
            , ( "/studies/reply", "Reply" )
            , ( "/studies/shrine", "Shrine" )
            , ( "/studies/rally", "Rally" )
            , ( "/studies/crane", "Crane" )
            , ( "/studies/settings", "Settings" )
            ]
      }
    ]


{-| The whole below-app-bar shell: a side `m3e-drawer-container` (via
`Ui.NavigationDrawer`) whose `start` panel is the hierarchical nav-menu and
whose content region holds the page body. The rounded floating content pane
and the panel chrome come from the primitive — no hand-styled surfaces.

The nav is pure `a[href]` links (no messages), so this is `Html msg`, letting
the page body keep its own message type without a `Html.map`.

-}
drawerShell : (Msg -> msg) -> Model -> { path : UrlPath, route : Maybe Route } -> List (Html msg) -> Html msg
drawerShell toMsg model page body =
    let
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    NavigationDrawer.tree
        |> NavigationDrawer.withId "docs-drawer"
        |> NavigationDrawer.withMode NavigationDrawer.ModeAuto
        |> NavigationDrawer.withOpen (not (isMobile model) || model.showMenu)
        |> NavigationDrawer.withOnChange (\open -> toMsg (MenuChanged open))
        |> NavigationDrawer.withEntries (navEntries currentPath)
        |> NavigationDrawer.withContent
            [ Html.div [ class "mx-auto max-w-5xl px-6 py-10 md:px-12" ] body ]
        |> NavigationDrawer.view


navEntries : String -> List (NavigationDrawer.Entry msg)
navEntries currentPath =
    List.map (sectionEntry currentPath) navSections
        ++ [ componentsEntry currentPath
           , groupEntry currentPath
                "menu_book"
                "Reference"
                [ ( "/reference", "Full API reference" ) ]
           ]


sectionEntry : String -> NavSection -> NavigationDrawer.Entry msg
sectionEntry currentPath section =
    groupEntry currentPath section.icon section.title section.items


componentsEntry : String -> NavigationDrawer.Entry msg
componentsEntry currentPath =
    groupEntry currentPath
        "grid_view"
        "Components"
        (List.map (\( slug, label ) -> ( "/components/" ++ slug, label )) componentList)


{-| One collapsible group, expanded when it contains the current route.
-}
groupEntry : String -> String -> String -> List ( String, String ) -> NavigationDrawer.Entry msg
groupEntry currentPath glyph title items =
    NavigationDrawer.group title
        |> NavigationDrawer.withEntryIcon (Icon.material glyph)
        |> NavigationDrawer.withEntryOpen (List.any (\( path, _ ) -> path == currentPath) items)
        |> NavigationDrawer.withEntryChildren (List.map (linkEntry currentPath) items)


linkEntry : String -> ( String, String ) -> NavigationDrawer.Entry msg
linkEntry currentPath ( path, label ) =
    NavigationDrawer.link label
        |> NavigationDrawer.withEntryHref path
        |> NavigationDrawer.withEntrySelected (path == currentPath)


{-| (slug, label) for every documented component, kept in sync with
`data/reference.json` (drives the dynamic `/components/:name` route).
-}
componentList : List ( String, String )
componentList =
    [ ( "appbar", "App Bar" )
    , ( "avatar", "Avatar" )
    , ( "badge", "Badge" )
    , ( "bottomsheet", "Bottom Sheet" )
    , ( "breadcrumb", "Breadcrumb" )
    , ( "button", "Button" )
    , ( "buttongroup", "Button Group" )
    , ( "calendar", "Calendar" )
    , ( "card", "Card" )
    , ( "checkbox", "Checkbox" )
    , ( "chip", "Chips" )
    , ( "datepicker", "Date Picker" )
    , ( "dialog", "Dialog" )
    , ( "disclosure", "Disclosure" )
    , ( "divider", "Divider" )
    , ( "extendedfab", "Extended FAB" )
    , ( "fab", "FAB" )
    , ( "fabmenu", "FAB Menu" )
    , ( "heading", "Heading" )
    , ( "icon", "Icon" )
    , ( "iconbutton", "Icon Button" )
    , ( "list", "List" )
    , ( "loadingindicator", "Loading Indicator" )
    , ( "menu", "Menu" )
    , ( "navigationbar", "Navigation Bar" )
    , ( "navigationdrawer", "Navigation Drawer" )
    , ( "navigationrail", "Navigation Rail" )
    , ( "paginator", "Paginator" )
    , ( "progress", "Progress" )
    , ( "radiobutton", "Radio Button" )
    , ( "scrollcontainer", "Scroll Container" )
    , ( "search", "Search" )
    , ( "segmentedbutton", "Segmented Button" )
    , ( "select", "Select" )
    , ( "shape", "Shape" )
    , ( "sidesheet", "Side Sheet" )
    , ( "skeleton", "Skeleton" )
    , ( "slide", "Slide Group" )
    , ( "slider", "Slider" )
    , ( "snackbar", "Snackbar" )
    , ( "splitbutton", "Split Button" )
    , ( "splitpane", "Split Pane" )
    , ( "stepper", "Stepper" )
    , ( "switch", "Switch" )
    , ( "tabs", "Tabs" )
    , ( "textfield", "Text Field" )
    , ( "texthighlight", "Text Highlight" )
    , ( "theme", "Theme" )
    , ( "timepicker", "Time Picker" )
    , ( "toc", "TOC" )
    , ( "toolbar", "Toolbar" )
    , ( "tooltip", "Tooltip" )
    ]
