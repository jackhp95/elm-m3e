module Shared exposing (ApiLayer(..), Data, Model, Msg(..), SharedMsg(..), template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `M3e.AppBar`
top app bar with the live theme controls in an outlined `M3e.Card` popover,
and a persistent left sidebar mirroring matraic's IA. Every icon goes
through `M3e.Icon`; every action through `M3e.IconButton`; every theme
toggle through `M3e.SegmentedButton`.

Migrated to the Vocab API (2026-07-01): the old hand `Theme.Scheme`/`Theme.Contrast`
unions are now local (the new `M3e.Theme` is token-driven), and every constructor
is `Module.view [attrs] [content]`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Effect exposing (Effect)
import EscapeHatch
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class)
import Html.Events
import Json.Decode as Decode
import Kit
import M3e.AppBar as AppBar
import M3e.Aria as Aria
import M3e.ButtonSegment as ButtonSegment
import M3e.Card as Card
import M3e.DrawerContainer as DrawerContainer
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.NavMenu as NavMenu
import M3e.NavMenuItem as NavMenuItem
import M3e.Node as Node
import M3e.SegmentedButton as SegmentedButton
import M3e.Theme as Theme
import M3e.Value as Value exposing (Supported)
import Native
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Ports
import Route exposing (Route)
import Seam
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


{-| The color scheme toggle. The new `M3e.Theme` is token-driven (no `Theme.Scheme`
union), so this lives locally now; it maps to `Value.auto|light|dark`.
-}
type Scheme
    = Auto
    | Light
    | Dark


{-| The contrast toggle — local for the same reason; maps to `Value.standard|medium|high`.
-}
type Contrast
    = Standard
    | Medium
    | High


{-| Which API layer the per-component Usage code blocks are shown in: the strict
top (`M3e.*`), the loose middle (`M3e.Cem.*`), the bottom (`M3e.Cem.Html.*`), or
the raw `<m3e-*>` HTML. Every shipped example carries all four (they are verified
supersets of each other), so the toggle is never partial.
-}
type ApiLayer
    = LayerTop
    | LayerMiddle
    | LayerBottom
    | LayerRaw


type alias Model =
    { showMenu : Bool
    , viewportWidth : Int
    , scheme : Scheme
    , seed : String
    , contrast : Contrast
    , density : Float
    , dir : Direction
    , settingsOpen : Bool
    , apiLayer : ApiLayer
    }


{-| The Tailwind `md` breakpoint — kept in Elm only because the drawer's
`start` is a Lit JS property, not CSS state.
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
    | SetScheme Scheme
    | SetSeed String
    | SetContrast Contrast
    | SetDensity Float
    | SetDirection Direction
    | SetApiLayer ApiLayer


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
      , contrast = Standard
      , density = 0
      , dir = Ltr
      , settingsOpen = False
      , apiLayer = LayerTop
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


{-| The initial color scheme: the value persisted in `localStorage` (passed by
`index.ts` as `flags.scheme`), else **Auto** — follow the OS light/dark setting.
-}
schemeFromFlags : Pages.Flags.Flags -> Scheme
schemeFromFlags flags =
    case flags of
        Pages.Flags.BrowserFlags raw ->
            Decode.decodeValue (Decode.field "scheme" Decode.string) raw
                |> Result.toMaybe
                |> Maybe.andThen schemeFromString
                |> Maybe.withDefault Auto

        Pages.Flags.PreRenderFlags ->
            Auto


schemeToString : Scheme -> String
schemeToString scheme =
    case scheme of
        Auto ->
            "auto"

        Light ->
            "light"

        Dark ->
            "dark"


schemeFromString : String -> Maybe Scheme
schemeFromString s =
    case s of
        "auto" ->
            Just Auto

        "light" ->
            Just Light

        "dark" ->
            Just Dark

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

        SetApiLayer apiLayer ->
            ( { model | apiLayer = apiLayer }, Effect.none )


{-| Watch viewport width to re-open the side drawer when the user crosses from
mobile to desktop.
-}
subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Browser.Events.onResize (\w _ -> ViewportResized w)


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()



-- VIEW


{-| Convenience alias: convert any `Element` to `Html`.
-}
toHtml : Element any msg -> Html msg
toHtml =
    Element.toNode >> Node.toHtml


schemeToken : Scheme -> Value.Value { a | auto : Supported, dark : Supported, light : Supported }
schemeToken scheme =
    case scheme of
        Auto ->
            Value.auto

        Light ->
            Value.light

        Dark ->
            Value.dark


contrastToken : Contrast -> Value.Value { a | high : Supported, medium : Supported, standard : Supported }
contrastToken contrast =
    case contrast of
        Standard ->
            Value.standard

        Medium ->
            Value.medium

        High ->
            Value.high


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
        -- `themed` wraps content Elements in `<m3e-theme>` and does the single
        -- `Node.toHtml` conversion.
        themed : List (Element { html : Supported } msg) -> Html msg
        themed children =
            Theme.view
                [ Theme.color model.seed
                , Theme.scheme (schemeToken model.scheme)
                , Theme.contrast (contrastToken model.contrast)
                , Theme.density model.density
                ]
                (List.map Theme.child children)
                |> toHtml

        absolutePath =
            UrlPath.toAbsolute page.path
    in
    { title = pageView.title
    , body =
        if String.startsWith "/studies/" absolutePath then
            -- Individual study routes take the full viewport; they include their
            -- own m3e nav chrome, so skip the docs shell to avoid double-nav.
            [ themed
                [ Native.div
                    [ Seam.asAttribute (class "min-h-screen bg-surface text-on-surface")
                    , Seam.asAttribute (attribute "dir" (directionAttr model.dir))
                    ]
                    (List.map Element.fromNode pageView.body)
                ]
            ]

        else
            [ themed
                [ Native.div
                    [ Seam.asAttribute (class "grid h-screen grid-rows-[auto_1fr] bg-surface text-on-surface")
                    , Seam.asAttribute (attribute "dir" (directionAttr model.dir))
                    ]
                    [ EscapeHatch.fromHtml (Html.map toMsg (appShellBar model))
                    , EscapeHatch.fromHtml (drawerShell toMsg model page (List.map Node.toHtml pageView.body))
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
        [ AppBar.view
            [ AppBar.size Value.small
            , Seam.asAttribute (Attr.id "docs-app-bar")
            ]
            [ AppBar.title (Kit.text "elm-m3e")
            , AppBar.subtitle (Kit.text "Material 3 Expressive for Elm")
            , AppBar.leading (EscapeHatch.asElement (menuButton model))
            , AppBar.trailing (EscapeHatch.asElement (schemeQuickToggle model))
            , AppBar.trailing (EscapeHatch.asElement (settingsTriggerElement model))
            , AppBar.trailing (EscapeHatch.asElement githubLink)
            ]
            |> toHtml
        ]


{-| The mobile hamburger. Wrapped in a `span.md:hidden` so it's invisible on wider
viewports (the side drawer is always visible there).
-}
menuButton : Model -> Element { html : Supported } Msg
menuButton _ =
    Native.span
        [ Seam.asAttribute (class "md:hidden") ]
        [ IconButton.view
            { content = Icon.view [ Icon.name "menu" ] [] }
            [ Aria.label "Toggle navigation", IconButton.onClick MenuClicked ]
            []
        ]


githubLink : Element { iconButton : Supported } Msg
githubLink =
    IconButton.view
        { content = Icon.view [ Icon.name "code" ] [] }
        [ Aria.label "GitHub repository"
        , IconButton.href "https://github.com/jackhp95/elm-m3e"
        , IconButton.target "_blank"
        , IconButton.rel "noreferrer noopener"
        ]
        []


schemeQuickToggle : Model -> Element { iconButton : Supported } Msg
schemeQuickToggle model =
    let
        ( next, iconName, iconLabel ) =
            case model.scheme of
                Light ->
                    ( Dark, "dark_mode", "Switch to dark mode" )

                Dark ->
                    ( Auto, "brightness_auto", "Use system color scheme" )

                Auto ->
                    ( Light, "light_mode", "Switch to light mode" )
    in
    IconButton.view
        { content = Icon.view [ Icon.name iconName ] [] }
        [ Aria.label iconLabel, IconButton.onClick (SetScheme next) ]
        []



-- SETTINGS POPOVER (anchored to a relative-positioned wrapper)


{-| The trailing settings control: a `relative`-positioned wrapper holding the
trigger icon button and — when open — the settings panel.
-}
settingsTriggerElement : Model -> Element { html : Supported } Msg
settingsTriggerElement model =
    Native.div
        [ Seam.asAttribute (class "relative") ]
        [ IconButton.view
            { content = Icon.view [ Icon.name "tune" ] [] }
            [ Aria.label "Theme settings", IconButton.onClick ToggleSettings ]
            []
        , if model.settingsOpen then
            EscapeHatch.fromHtml (settingsPanel model)

          else
            EscapeHatch.fromHtml (Html.text "")
        ]


settingsPanel : Model -> Html Msg
settingsPanel model =
    Html.div [ class "fixed left-2 right-2 top-14 z-40 sm:left-auto sm:right-2 sm:w-72" ]
        [ Card.view
            [ Card.variant Value.filled ]
            [ Card.header
                (Heading.view { content = Kit.text "Theme settings" } [ Heading.variant Value.title ] [])
            , Card.content (EscapeHatch.fromHtml (settingsBody model))
            ]
            |> toHtml
        ]


settingsBody : Model -> Html Msg
settingsBody model =
    Html.div [ class "space-y-4" ]
        [ schemeSegmented model
        , contrastSegmented model
        , seedColorInput model
        , densitySegmented model
        , directionSegmented model
        , apiLayerSegmented model
        ]


{-| One segmented-button control: `SegmentedButton` holding `ButtonSegment`
children, each a checked/label/onClick triple.
-}
segmented : List ( String, Bool, Msg ) -> Html Msg
segmented segments =
    SegmentedButton.view []
        (List.map
            (\( label, checked, msg ) ->
                SegmentedButton.child
                    (ButtonSegment.view
                        [ ButtonSegment.checked checked, ButtonSegment.onClick msg ]
                        [ ButtonSegment.child (Kit.text label) ]
                    )
            )
            segments
        )
        |> toHtml


schemeSegmented : Model -> Html Msg
schemeSegmented model =
    segmented
        [ ( "Light", model.scheme == Light, SetScheme Light )
        , ( "System", model.scheme == Auto, SetScheme Auto )
        , ( "Dark", model.scheme == Dark, SetScheme Dark )
        ]


{-| Selects which API layer the per-component Usage code blocks display:
Top (`M3e.*`) / Middle (`M3e.Cem.*`) / Bottom (`M3e.Cem.Html.*`) / raw HTML.
-}
apiLayerSegmented : Model -> Html Msg
apiLayerSegmented model =
    segmented
        [ ( "Top", model.apiLayer == LayerTop, SetApiLayer LayerTop )
        , ( "Middle", model.apiLayer == LayerMiddle, SetApiLayer LayerMiddle )
        , ( "Bottom", model.apiLayer == LayerBottom, SetApiLayer LayerBottom )
        , ( "HTML", model.apiLayer == LayerRaw, SetApiLayer LayerRaw )
        ]


contrastSegmented : Model -> Html Msg
contrastSegmented model =
    segmented
        [ ( "Standard", model.contrast == Standard, SetContrast Standard )
        , ( "Medium", model.contrast == Medium, SetContrast Medium )
        , ( "High", model.contrast == High, SetContrast High )
        ]


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
            , Html.code [ class "text-body-md text-on-surface-variant" ] [ Html.text model.seed ]
            ]
        ]


densitySegmented : Model -> Html Msg
densitySegmented model =
    segmented
        [ ( "0", model.density == 0, SetDensity 0 )
        , ( "-1", model.density == -1, SetDensity -1 )
        , ( "-2", model.density == -2, SetDensity -2 )
        , ( "-3", model.density == -3, SetDensity -3 )
        ]


directionSegmented : Model -> Html Msg
directionSegmented model =
    segmented
        [ ( "LTR", model.dir == Ltr, SetDirection Ltr )
        , ( "RTL", model.dir == Rtl, SetDirection Rtl )
        ]



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


{-| The whole below-app-bar shell: a side `m3e-drawer-container` whose `start`
panel is the hierarchical nav-menu and whose default content is the page body.
The nav is `NavItem` links inside `NavMenuItem` groups inside a `NavMenu`.
-}
drawerShell : (Msg -> msg) -> Model -> { path : UrlPath, route : Maybe Route } -> List (Html msg) -> Html msg
drawerShell _ model page body =
    let
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    DrawerContainer.view
        [ Seam.asAttribute (Attr.id "docs-drawer")
        , DrawerContainer.startMode Value.auto
        , DrawerContainer.start (not (isMobile model) || model.showMenu)
        ]
        [ DrawerContainer.startSlot
            (navMenu currentPath)
        , DrawerContainer.child
            (Native.div
                -- the ContentPane provides its own container padding; keep only a
                -- modest inline margin like matraic's #body (margin-inline: 1rem).
                [ Seam.asAttribute (class "mx-auto w-full max-w-5xl px-2 py-2") ]
                (List.map EscapeHatch.fromHtml body)
            )
        ]
        |> toHtml


{-| TODO(migrate): the old nav used `NavigationDrawer.group`/`link`; the new
`M3e.NavMenu`/`NavMenuItem` hierarchy has a different (nested-item, not a[href])
model that needs a design decision. For now the nav is faithfully reproduced as
the "pure a[href] links" the old code documented, via the Native escape — a Seam
candidate to component-ify once the NavMenu model is settled.
-}
navMenu : String -> Element { s | navMenu : Supported } msg
navMenu currentPath =
    let
        groups =
            List.map (\s -> ( s.icon, s.title, s.items )) navSections
                ++ List.map
                    (\( category, glyph ) ->
                        ( glyph
                        , category
                        , componentList
                            |> List.filter (\( _, _, c ) -> c == category)
                            |> List.map (\( slug, label, _ ) -> ( "/components/" ++ slug, label ))
                        )
                    )
                    componentCategories
                ++ [ ( "menu_book", "Reference", [ ( "/reference", "Full API reference" ) ] )
                   ]
    in
    NavMenu.view []
        (NavMenu.children (List.map (\( glyph, title, items ) -> navGroup currentPath glyph title items) groups))


navGroup : String -> String -> String -> List ( String, String ) -> Element { navMenuItem : Supported, navMenuItemGroup : Supported, divider : Supported } msg
navGroup currentPath glyph title items =
    NavMenuItem.view
        { label = Kit.text title }
        -- Only SET `open` when this group holds the current route. `open` is a
        -- controlled property, so setting it False pins the group closed and the
        -- user can't expand it; leaving it unset lets the component toggle freely.
        (if List.any (\( path, _ ) -> path == currentPath) items then
            [ NavMenuItem.open True ]

         else
            []
        )
        (NavMenuItem.icon (Icon.view [ Icon.name glyph ] [])
            :: NavMenuItem.children (List.map (navLeaf currentPath) items)
        )


navLeaf : String -> ( String, String ) -> Element { navMenuItem : Supported } msg
navLeaf currentPath ( path, label ) =
    NavMenuItem.view
        { label = Kit.link path [ Kit.text label ] }
        [ NavMenuItem.selected (path == currentPath) ]
        []


{-| The component-nav categories, in display order, each paired with its Material
Symbol glyph. Mirrors the editorial taxonomy in `config/categories.json`.
-}
componentCategories : List ( String, String )
componentCategories =
    [ ( "Actions", "touch_app" )
    , ( "Communication", "notifications" )
    , ( "Containment", "widgets" )
    , ( "Navigation", "explore" )
    , ( "Selection", "checklist" )
    , ( "Text inputs", "edit" )
    , ( "Layout & style", "palette" )
    ]


{-| (slug, label, category) for every documented component, kept in sync with
`data/reference.json` (drives the dynamic `/components/:name` route) and grouped
in the drawer by `category` (see `componentCategories`).
-}
componentList : List ( String, String, String )
componentList =
    [ ( "appbar", "App Bar", "Navigation" )
    , ( "avatar", "Avatar", "Layout & style" )
    , ( "badge", "Badge", "Communication" )
    , ( "bottomsheet", "Bottom Sheet", "Containment" )
    , ( "breadcrumb", "Breadcrumb", "Navigation" )
    , ( "button", "Button", "Actions" )
    , ( "buttongroup", "Button Group", "Actions" )
    , ( "calendar", "Calendar", "Text inputs" )
    , ( "card", "Card", "Containment" )
    , ( "checkbox", "Checkbox", "Selection" )
    , ( "chip", "Chips", "Selection" )
    , ( "datepicker", "Date Picker", "Text inputs" )
    , ( "dialog", "Dialog", "Containment" )
    , ( "disclosure", "Disclosure", "Containment" )
    , ( "divider", "Divider", "Containment" )
    , ( "extendedfab", "Extended FAB", "Actions" )
    , ( "fab", "FAB", "Actions" )
    , ( "fabmenu", "FAB Menu", "Actions" )
    , ( "heading", "Heading", "Layout & style" )
    , ( "icon", "Icon", "Layout & style" )
    , ( "iconbutton", "Icon Button", "Actions" )
    , ( "list", "List", "Layout & style" )
    , ( "loadingindicator", "Loading Indicator", "Communication" )
    , ( "menu", "Menu", "Navigation" )
    , ( "navigationbar", "Navigation Bar", "Navigation" )
    , ( "navigationdrawer", "Navigation Drawer", "Navigation" )
    , ( "navigationrail", "Navigation Rail", "Navigation" )
    , ( "paginator", "Paginator", "Navigation" )
    , ( "progress", "Progress", "Communication" )
    , ( "radiobutton", "Radio Button", "Selection" )
    , ( "scrollcontainer", "Scroll Container", "Containment" )
    , ( "search", "Search", "Text inputs" )
    , ( "segmentedbutton", "Segmented Button", "Actions" )
    , ( "select", "Select", "Text inputs" )
    , ( "shape", "Shape", "Layout & style" )
    , ( "sidesheet", "Side Sheet", "Containment" )
    , ( "skeleton", "Skeleton", "Communication" )
    , ( "slide", "Slide Group", "Navigation" )
    , ( "slider", "Slider", "Selection" )
    , ( "snackbar", "Snackbar", "Communication" )
    , ( "splitbutton", "Split Button", "Actions" )
    , ( "splitpane", "Split Pane", "Containment" )
    , ( "stepper", "Stepper", "Navigation" )
    , ( "switch", "Switch", "Selection" )
    , ( "tabs", "Tabs", "Navigation" )
    , ( "textfield", "Text Field", "Text inputs" )
    , ( "texthighlight", "Text Highlight", "Layout & style" )
    , ( "theme", "Theme", "Layout & style" )
    , ( "timepicker", "Time Picker", "Text inputs" )
    , ( "toc", "TOC", "Navigation" )
    , ( "toolbar", "Toolbar", "Containment" )
    , ( "tooltip", "Tooltip", "Communication" )
    ]
