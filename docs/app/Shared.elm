module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `M3e.AppBar`
top app bar with the live theme controls in an outlined `M3e.Card` popover,
and a persistent left sidebar mirroring matraic's IA. Every icon goes
through `M3e.Icon`; every action through `M3e.IconButton`; every theme
toggle through `M3e.SegmentedButton`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class)
import Html.Events
import Json.Decode as Decode
import M3e.AppBar
import M3e.Card
import M3e.Heading
import M3e.Icon
import M3e.IconButton
import M3e.NavigationDrawer
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.SegmentedButton
import M3e.Theme as Theme
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Ports
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
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


{-| The Tailwind `md` breakpoint — kept in Elm only because the drawer's
`start` is a Lit JS property, not CSS state.

Hiding/showing chrome (the hamburger, the settings popover layout) is pure
Tailwind — `class "md:hidden"` etc. The hold-out is `m3e-drawer-container`:
its open state lives in a `@property({ type: Boolean, reflect: true }) start`
on the custom element, and the `.start` panel sits inside the element's
shadow DOM (no `::part` exposure). CSS can't reach in to flip it
responsively, so Elm has to know the viewport to set the initial value at
hydration and re-set it on the mobile↔desktop transition (`auto` mode
only autoCloses going side→over; never autoOpens going over→side).

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
      , scheme = schemeFromFlags flags
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
See `mdBreakpointPx` for why this can't be a pure-CSS concern.
-}
initialViewportWidth : Pages.Flags.Flags -> Int
initialViewportWidth flags =
    case flags of
        Pages.Flags.BrowserFlags raw ->
            Decode.decodeValue (Decode.field "width" Decode.int) raw
                |> Result.withDefault 1024

        Pages.Flags.PreRenderFlags ->
            1024


{-| The initial color scheme: the value persisted in `localStorage` (passed by
`index.ts` as `flags.scheme`), else **Auto** — follow the OS light/dark setting.
-}
schemeFromFlags : Pages.Flags.Flags -> Theme.Scheme
schemeFromFlags flags =
    case flags of
        Pages.Flags.BrowserFlags raw ->
            Decode.decodeValue (Decode.field "scheme" Decode.string) raw
                |> Result.toMaybe
                |> Maybe.andThen schemeFromString
                |> Maybe.withDefault Theme.Auto

        Pages.Flags.PreRenderFlags ->
            Theme.Auto


schemeToString : Theme.Scheme -> String
schemeToString scheme =
    case scheme of
        Theme.Auto ->
            "auto"

        Theme.Light ->
            "light"

        Theme.Dark ->
            "dark"


schemeFromString : String -> Maybe Theme.Scheme
schemeFromString s =
    case s of
        "auto" ->
            Just Theme.Auto

        "light" ->
            Just Theme.Light

        "dark" ->
            Just Theme.Dark

        _ ->
            Nothing


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
            ( { model | scheme = scheme }
            , Effect.fromCmd (Ports.storeScheme (schemeToString scheme))
            )

        SetSeed seed ->
            ( { model | seed = seed }, Effect.none )

        SetContrast contrast ->
            ( { model | contrast = contrast }, Effect.none )

        SetDensity density ->
            ( { model | density = density }, Effect.none )

        SetDirection dir ->
            ( { model | dir = dir }, Effect.none )


{-| Watch viewport width specifically to re-open the side drawer when the
user crosses from mobile to desktop. m3e-drawer-container's `mode=auto`
autoCloses going side→over (caught via the old `withOnChange`, now dropped),
but it doesn't autoOpen going over→side — so without this subscription, a
closed drawer on mobile stays closed (no sidebar) after resizing up.
-}
subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Browser.Events.onResize (\w _ -> ViewportResized w)


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()



-- VIEW


{-| Convenience alias: convert any `Renderable` to `Html`.
-}
toHtml : Renderable any msg -> Html msg
toHtml =
    Renderable.toNode >> Node.toHtml


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
    let
        themed children =
            Theme.view
                { content = List.map Renderable.html children }
                [ Theme.seedColor model.seed
                , Theme.scheme model.scheme
                , Theme.contrast model.contrast
                , Theme.density model.density
                ]
                |> toHtml

        absolutePath =
            UrlPath.toAbsolute page.path
    in
    { title = pageView.title
    , body =
        if String.startsWith "/studies/" absolutePath then
            -- Individual study routes (`/studies/<slug>`) take the full
            -- viewport; they already include their own m3e nav chrome, so
            -- skip the docs shell to avoid double-nav.
            --
            -- Full-bleed: no outer gutter. These are app clones — their own
            -- internal layout (app bars, frames, content padding) owns the
            -- spacing, so the study content reaches the viewport edges like a
            -- real app rather than sitting inside a docs gutter.
            [ themed
                [ Html.div
                    [ class "min-h-screen bg-surface text-on-surface"
                    , attribute "dir" (directionAttr model.dir)
                    ]
                    pageView.body
                ]
            ]

        else
            [ themed
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
        [ M3e.AppBar.new
            |> M3e.AppBar.withId "docs-app-bar"
            |> M3e.AppBar.withSize M3e.AppBar.Small
            |> M3e.AppBar.withTitle
                (M3e.Heading.view { label = "elm-m3e", variant = M3e.Heading.Title } [])
            |> M3e.AppBar.withSubtitle
                (M3e.Heading.view { label = "Material 3 Expressive for Elm", variant = M3e.Heading.Label } [])
            |> M3e.AppBar.withLeading (menuButton model)
            |> M3e.AppBar.withTrailing
                [ schemeQuickToggle model
                , settingsTriggerElement model
                , githubLink
                ]
            |> M3e.AppBar.toNode
            |> Node.toHtml
        ]


{-| The mobile hamburger. Drives the drawer through `MenuClicked` → showMenu →
`drawerShell`'s `withOpen`, which emits `start` as an HTML attribute so
the drawer-container's CSS selectors actually react.

Why not `m3e-drawer-toggle`? Its `_toggleDrawer` does
`this.control.closest("m3e-drawer-container")` to find its target — our app
bar sits in a SIBLING of the drawer-container, not a descendant, so the
canonical toggle silently no-ops here. The Elm round-trip is the right call
until the shell layout puts the app bar inside the drawer.

Wrapped in a `span.md:hidden` so the button is invisible on wider viewports
(the side drawer is always visible there — no hamburger needed). Since
`M3e.IconButton` no longer accepts arbitrary HTML attributes, the class is
attached via `Renderable.element`.

-}
menuButton : Model -> M3e.AppBar.Leading Msg
menuButton _ =
    Renderable.element { tag = "span" }
        [ Node.rawAttr (class "md:hidden") ]
        [ Renderable.toNode
            (M3e.IconButton.view
                { icon = "menu", name = "Toggle navigation" }
                [ M3e.IconButton.onClick MenuClicked ]
            )
        ]


githubLink : M3e.AppBar.Trailing Msg
githubLink =
    M3e.IconButton.view
        { icon = "code", name = "GitHub repository" }
        [ M3e.IconButton.href "https://github.com/jackhp95/m3e-builder"
        , M3e.IconButton.target "_blank"
        , M3e.IconButton.rel "noreferrer noopener"
        ]


schemeQuickToggle : Model -> M3e.AppBar.Trailing Msg
schemeQuickToggle model =
    let
        ( next, iconName, iconLabel ) =
            case model.scheme of
                Theme.Light ->
                    ( Theme.Dark, "dark_mode", "Switch to dark mode" )

                Theme.Dark ->
                    ( Theme.Auto, "brightness_auto", "Use system color scheme" )

                Theme.Auto ->
                    ( Theme.Light, "light_mode", "Switch to light mode" )
    in
    M3e.IconButton.view { icon = iconName, name = iconLabel }
        [ M3e.IconButton.onClick (SetScheme next) ]



-- SETTINGS POPOVER (anchored to a relative-positioned wrapper)


{-| The trailing settings control: a `relative`-positioned wrapper (so the
popover can anchor) holding the trigger icon button and — when open — the
settings panel. Rendered as a single trailing slot item via `withTrailing`.
-}
settingsTriggerElement : Model -> M3e.AppBar.Trailing Msg
settingsTriggerElement model =
    Renderable.element { tag = "div" }
        [ Node.rawAttr (class "relative") ]
        [ Renderable.toNode
            (M3e.IconButton.view
                { icon = "tune", name = "Theme settings" }
                [ M3e.IconButton.onClick ToggleSettings ]
            )
        , if model.settingsOpen then
            Node.raw (settingsPanel model)

          else
            Node.raw (Html.text "")
        ]


settingsPanel : Model -> Html Msg
settingsPanel model =
    -- `fixed` anchors to the viewport. With `absolute`, the nearest positioned
    -- ancestor was the tiny icon-button-wrapper (~40px wide), which made
    -- `left-2 right-2` resolve to a 24px-wide column — the "narrow" complaint.
    Html.div [ class "fixed left-2 right-2 top-14 z-40 sm:left-auto sm:right-2 sm:w-72" ]
        [ M3e.Card.new
            |> M3e.Card.withVariant M3e.Card.Filled
            |> M3e.Card.withHeadline
                (M3e.Heading.view { label = "Theme settings", variant = M3e.Heading.Title } [])
            |> M3e.Card.withBody
                [ Renderable.html (settingsBody model) ]
            |> M3e.Card.toNode
            |> Node.toHtml
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
    M3e.SegmentedButton.view
        { segments =
            [ M3e.SegmentedButton.segment
                { label = "Light", checked = model.scheme == Theme.Light }
                [ M3e.SegmentedButton.segmentOnClick (SetScheme Theme.Light) ]
            , M3e.SegmentedButton.segment
                { label = "System", checked = model.scheme == Theme.Auto }
                [ M3e.SegmentedButton.segmentOnClick (SetScheme Theme.Auto) ]
            , M3e.SegmentedButton.segment
                { label = "Dark", checked = model.scheme == Theme.Dark }
                [ M3e.SegmentedButton.segmentOnClick (SetScheme Theme.Dark) ]
            ]
        }
        []
        |> toHtml


contrastSegmented : Model -> Html Msg
contrastSegmented model =
    M3e.SegmentedButton.view
        { segments =
            [ M3e.SegmentedButton.segment
                { label = "Standard", checked = model.contrast == Theme.Standard }
                [ M3e.SegmentedButton.segmentOnClick (SetContrast Theme.Standard) ]
            , M3e.SegmentedButton.segment
                { label = "Medium", checked = model.contrast == Theme.Medium }
                [ M3e.SegmentedButton.segmentOnClick (SetContrast Theme.Medium) ]
            , M3e.SegmentedButton.segment
                { label = "High", checked = model.contrast == Theme.High }
                [ M3e.SegmentedButton.segmentOnClick (SetContrast Theme.High) ]
            ]
        }
        []
        |> toHtml


seedColorInput : Model -> Html Msg
seedColorInput model =
    Html.div [ class "space-y-1.5" ]
        [ Html.label
            [ Attr.for "docs-seed", class "block text-label-md text-on-surface-variant" ]
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
            , Html.code [ class "text-body-sm text-on-surface-variant" ] [ Html.text model.seed ]
            ]
        ]


densitySegmented : Model -> Html Msg
densitySegmented model =
    M3e.SegmentedButton.view
        { segments =
            [ M3e.SegmentedButton.segment
                { label = "0", checked = model.density == 0 }
                [ M3e.SegmentedButton.segmentOnClick (SetDensity 0) ]
            , M3e.SegmentedButton.segment
                { label = "-1", checked = model.density == -1 }
                [ M3e.SegmentedButton.segmentOnClick (SetDensity -1) ]
            , M3e.SegmentedButton.segment
                { label = "-2", checked = model.density == -2 }
                [ M3e.SegmentedButton.segmentOnClick (SetDensity -2) ]
            , M3e.SegmentedButton.segment
                { label = "-3", checked = model.density == -3 }
                [ M3e.SegmentedButton.segmentOnClick (SetDensity -3) ]
            ]
        }
        []
        |> toHtml


directionSegmented : Model -> Html Msg
directionSegmented model =
    M3e.SegmentedButton.view
        { segments =
            [ M3e.SegmentedButton.segment
                { label = "LTR", checked = model.dir == Ltr }
                [ M3e.SegmentedButton.segmentOnClick (SetDirection Ltr) ]
            , M3e.SegmentedButton.segment
                { label = "RTL", checked = model.dir == Rtl }
                [ M3e.SegmentedButton.segmentOnClick (SetDirection Rtl) ]
            ]
        }
        []
        |> toHtml



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
`M3e.NavigationDrawer`) whose `start` panel is the hierarchical nav-menu and
whose content region holds the page body. The rounded floating content pane
and the panel chrome come from the primitive — no hand-styled surfaces.

The nav is pure `a[href]` links (no messages), so this is `Html msg`, letting
the page body keep its own message type without a `Html.map`.

NOTE: `M3e.NavigationDrawer` has no `withOnChange` option — the callback that
kept `model.showMenu` in sync with drawer-initiated closes is therefore
dropped. `showMenu` is still toggled by `MenuClicked` (hamburger) and reset
to `False` by `CloseMenu` (page navigation). The `toMsg` argument is retained
in the signature to avoid breaking the call-site in `view`.

-}
drawerShell : (Msg -> msg) -> Model -> { path : UrlPath, route : Maybe Route } -> List (Html msg) -> Html msg
drawerShell _ model page body =
    let
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    M3e.NavigationDrawer.view
        { entries = navEntries currentPath }
        [ M3e.NavigationDrawer.withId "docs-drawer"
        , M3e.NavigationDrawer.withMode M3e.NavigationDrawer.ModeAuto
        , M3e.NavigationDrawer.withOpen (not (isMobile model) || model.showMenu)
        , M3e.NavigationDrawer.content
            [ Html.div [ class "mx-auto max-w-5xl px-4 py-10 sm:px-6 md:px-12" ] body ]
        ]
        |> toHtml


navEntries : String -> List (Renderable { navMenuItem : Supported } msg)
navEntries currentPath =
    List.map (sectionEntry currentPath) navSections
        ++ [ componentsEntry currentPath
           , groupEntry currentPath
                "menu_book"
                "Reference"
                [ ( "/reference", "Full API reference" ) ]
           ]


sectionEntry : String -> NavSection -> Renderable { navMenuItem : Supported } msg
sectionEntry currentPath section =
    groupEntry currentPath section.icon section.title section.items


componentsEntry : String -> Renderable { navMenuItem : Supported } msg
componentsEntry currentPath =
    groupEntry currentPath
        "grid_view"
        "Components"
        (List.map (\( slug, label ) -> ( "/components/" ++ slug, label )) componentList)


{-| One collapsible group, expanded when it contains the current route.
-}
groupEntry : String -> String -> String -> List ( String, String ) -> Renderable { navMenuItem : Supported } msg
groupEntry currentPath glyph title items =
    M3e.NavigationDrawer.group
        { label = title }
        (List.map (linkEntry currentPath) items)
        [ M3e.NavigationDrawer.groupIcon (M3e.Icon.view { name = glyph })
        , M3e.NavigationDrawer.groupOpen (List.any (\( path, _ ) -> path == currentPath) items)
        ]


linkEntry : String -> ( String, String ) -> Renderable { navMenuItem : Supported } msg
linkEntry currentPath ( path, label ) =
    M3e.NavigationDrawer.link
        { label = label, href = path }
        [ M3e.NavigationDrawer.linkSelected (path == currentPath) ]


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
