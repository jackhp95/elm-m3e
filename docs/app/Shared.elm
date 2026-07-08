module Shared exposing (Contrast, Data, Direction, Model, Msg, Scheme, componentCategories, template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `M3e.AppBar`
top app bar, and an `M3e.DrawerContainer` holding the nav in the `start` slot
and the live theme controls in an `end`-slot settings drawer — cloning
matraic's shell. Every icon goes through `M3e.Icon`; every action through
`M3e.IconButton`; every theme control through `M3e.SegmentedButton`.

Migrated to the Vocab API (2026-07-01): the old hand `Theme.Scheme`/`Theme.Contrast`
unions are now local (the new `M3e.Theme` is token-driven), and every constructor
is `Module.view [attrs] [content]`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class)
import Html.Events
import Json.Decode as Decode
import Kit
import Kit.Surface as Surface
import M3e.Action as Action
import M3e.AppBar as AppBar
import M3e.Aria as Aria
import M3e.ButtonSegment as ButtonSegment
import M3e.DrawerContainer as DrawerContainer
import M3e.Element as Element exposing (Element)
import M3e.Icon as Icon
import M3e.NavMenu as NavMenu
import M3e.Node as Node
import M3e.Record.IconButton as IconButton
import M3e.Record.NavMenuItem as NavMenuItem
import M3e.SegmentedButton as SegmentedButton
import M3e.Theme as Theme
import M3e.Value as Value exposing (Supported, Value)
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


type alias Model =
    { showMenu : Bool
    , viewportWidth : Int
    , scheme : Scheme
    , seed : String
    , contrast : Contrast
    , density : Float
    , dir : Direction
    , settingsOpen : Bool
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
    = MenuClicked
    | CloseMenu
    | ViewportResized Int
    | ToggleSettings
    | DrawerChanged Bool Bool
    | SetScheme Scheme
    | SetSeed String
    | SetContrast Contrast
    | SetDensity Float
    | SetDirection Direction


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
        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )

        CloseMenu ->
            ( { model | showMenu = False }, Effect.none )

        ViewportResized w ->
            ( { model | viewportWidth = w }, Effect.none )

        ToggleSettings ->
            ( { model | settingsOpen = not model.settingsOpen }, Effect.none )

        -- The `<m3e-drawer-container>` `change` event reports the element's own
        -- open state (scrim click, Esc, breakpoint auto-close). Sync our booleans
        -- from it so an element-driven close can't desync Elm (which would need a
        -- double-toggle to reopen). `event.target.start`/`.end` are the reflected
        -- boolean properties read by `drawerChangeDecoder`.
        DrawerChanged startOpen endOpen ->
            ( { model | showMenu = startOpen, settingsOpen = endOpen }, Effect.none )

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


schemeToken : Scheme -> Value { a | auto : Supported, dark : Supported, light : Supported }
schemeToken scheme =
    case scheme of
        Auto ->
            Value.auto

        Light ->
            Value.light

        Dark ->
            Value.dark


contrastToken : Contrast -> Value { a | high : Supported, medium : Supported, standard : Supported }
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

                -- The m3e-theme element's `density` prop/attr is NON-reactive, so the
                -- control has no effect unless we drive `--md-sys-density-scale` (which
                -- the m3e components read via density.calc) ourselves. Elm can't set a
                -- CSS custom property directly — `style` uses `node.style[key]=…` which
                -- ignores `--vars`, and `attribute "style"` gets clobbered on re-render —
                -- so it goes through a Tailwind arbitrary-property CLASS instead.
                , Seam.asAttribute (class (densityClass model.density))
                ]
                children
                |> toHtml

        absolutePath : String
        absolutePath =
            UrlPath.toAbsolute page.path
    in
    { title = pageView.title
    , body =
        if String.startsWith "/examples/" absolutePath then
            -- Individual example routes take the full viewport; they include their
            -- own m3e nav chrome, so skip the docs shell to avoid double-nav.
            [ themed
                [ Surface.view Surface.surface
                    [ Seam.asAttribute (class "min-h-screen")
                    , Seam.asAttribute (attribute "dir" (directionAttr model.dir))
                    ]
                    (List.map Seam.asElement pageView.body)
                ]
            ]

        else
            [ themed
                [ Surface.view Surface.surface
                    [ Seam.asAttribute (class "grid h-screen grid-rows-[auto_1fr]")
                    , Seam.asAttribute (attribute "dir" (directionAttr model.dir))
                    ]
                    [ Seam.fromHtml (Html.map toMsg (appShellBar model))
                    , Seam.fromHtml (drawerShell toMsg model page (List.map Node.toHtml pageView.body))
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
        [ class "sticky top-0 z-30 border-b border-outline-variant bg-surface-container-low shadow-md-level1" ]
        [ AppBar.view
            [ AppBar.size Value.small
            , Seam.asAttribute (Attr.id "docs-app-bar")
            ]
            [ AppBar.title (Kit.text "elm-m3e")
            , AppBar.subtitle (Kit.text "Material 3 Expressive for Elm")
            , AppBar.leading
                (Seam.stripPhantom
                    (Native.span [ Seam.asAttribute (class "flex items-center") ]
                        [ brandMark, menuButton ]
                    )
                )
            , AppBar.trailing (Seam.stripPhantom githubLink)
            , AppBar.trailing (Seam.stripPhantom settingsButton)
            ]
            |> toHtml
        ]


{-| The brand mark in the app bar: the real Material Symbols "palette" glyph,
rendered by the m3e `Icon` component from the self-hosted font. Hidden on mobile
(the drawer takes over there), shown from `md` up.
-}
brandMark : Element { html : Supported } Msg
brandMark =
    Native.span
        [ Seam.asAttribute (class "ms-2 me-1 hidden md:inline-flex") ]
        [ Icon.view [ Icon.name "palette" ] [] ]


{-| The mobile hamburger. Wrapped in a `span.md:hidden` so it's invisible on wider
viewports (the side drawer is always visible there).
-}
menuButton : Element { html : Supported } Msg
menuButton =
    Native.span
        [ Seam.asAttribute (class "md:hidden") ]
        [ IconButton.view
            { content = Icon.view [ Icon.name "menu" ] []
            , action = Action.onClick MenuClicked
            }
            [ Aria.label "Toggle navigation" ]
            []
        ]


{-| The GitHub link. The GitHub mark is an inline `<svg fill="currentColor">`
(path copied verbatim from matraic's `docs/index.html`) so it inherits the app
bar's on-surface foreground and adapts to light/dark — a Material Symbol `code`
glyph was a stand-in. The SVG rides in via the docs' `raw-html` custom element
(same seam as `Doc.rawPreview`); parsed inside a `<template>` it lands in the SVG
namespace and renders as a real vector.
-}
githubLink : Element { iconButton : Supported } Msg
githubLink =
    IconButton.view
        { content = Seam.fromHtml githubMark
        , action =
            Action.linkWith
                { href = "https://github.com/jackhp95/elm-m3e"
                , target = Just "_blank"
                , rel = Just "noreferrer noopener"
                , download = Nothing
                }
        }
        [ Aria.label "GitHub repository" ]
        []


githubMark : Html msg
githubMark =
    Html.node "raw-html"
        [ attribute "content" githubMarkSvg
        , class "inline-flex"
        ]
        []


githubMarkSvg : String
githubMarkSvg =
    "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\" fill=\"currentColor\" width=\"24\" height=\"24\" aria-hidden=\"true\" style=\"display:block\"><path d=\"M216.5 362.5c-66-8-112.5-55.5-112.5-117 0-25 9-52 24-70-6.5-16.5-5.5-51.5 2-66 20-2.5 47 8 63 22.5 19-6 39-9 63.5-9s44.5 3 62.5 8.5c15.5-14 43-24.5 63-22 7 13.5 8 48.5 1.5 65.5 16 19 24.5 44.5 24.5 70.5 0 61.5-46.5 108-113.5 116.5 17 11 28.5 35 28.5 62.5l0 52C323 491.5 335.5 500 350.5 494 441 459.5 512 369 512 257 512 115.5 397 0 255.5 0S0 115.5 0 257c0 111 70.5 203 165.5 237.5 13.5 5 26.5-4 26.5-17.5l0-40c-7 3-16 5-24 5-33 0-52.5-18-66.5-51.5-5.5-13.5-11.5-21.5-23-23-6-.5-8-3-8-6 0-6 10-10.5 20-10.5 14.5 0 27 9 40 27.5 10 14.5 20.5 21 33 21s20.5-4.5 32-16c8.5-8.5 15-16 21-21z\"/></svg>"


{-| The app-bar settings control: a plain icon button that flips `settingsOpen`,
which drives the end drawer's `open` state. (Was a Card popover trigger.)
-}
settingsButton : Element { iconButton : Supported } Msg
settingsButton =
    IconButton.view
        { content = Icon.view [ Icon.name "settings" ] []
        , action = Action.onClick ToggleSettings
        }
        [ Aria.label "Settings" ]
        []



-- SETTINGS (end drawer content — cloned from matraic's #settings-drawer)


{-| The theme controls, rendered into the drawer-container's `end` slot. Styled
like matraic's `#settings-drawer` (flex column, row-gap, padding — see
`style.css`), each control preceded by a label. All our richer controls are kept
(scheme, contrast, seed color, density, direction); only their LOCATION moved
from the old Card popover into this end drawer.
-}
settingsDrawerContent : Model -> Html Msg
settingsDrawerContent model =
    Html.div
        [ Attr.id "settings-drawer", attribute "role" "complementary" ]
        [ controlLabel "Source color"
        , seedColorInput model
        , controlLabel "Color scheme"
        , schemeSegmented model
        , controlLabel "Contrast"
        , contrastSegmented model
        , controlLabel "Density"
        , densitySegmented model
        , controlLabel "Directionality"
        , directionSegmented model
        ]


controlLabel : String -> Html Msg
controlLabel label =
    Html.div [ class "text-label-lg font-medium text-on-surface" ] [ Html.text label ]


{-| One segmented-button control: `SegmentedButton` holding `ButtonSegment`
children, each a checked/label/onClick triple.
-}
segmented : List ( String, Bool, Msg ) -> Html Msg
segmented segments =
    SegmentedButton.view []
        (List.map
            (\( label, checked, msg ) ->
                ButtonSegment.view
                    [ ButtonSegment.checked checked, ButtonSegment.onClick msg ]
                    [ Kit.text label ]
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


contrastSegmented : Model -> Html Msg
contrastSegmented model =
    segmented
        [ ( "Standard", model.contrast == Standard, SetContrast Standard )
        , ( "Medium", model.contrast == Medium, SetContrast Medium )
        , ( "High", model.contrast == High, SetContrast High )
        ]


seedColorInput : Model -> Html Msg
seedColorInput model =
    Html.div [ class "flex items-center gap-3" ]
        [ Html.input
            [ Attr.type_ "color"
            , Attr.id "docs-seed"
            , Attr.value model.seed
            , Html.Events.onInput SetSeed
            , attribute "aria-label" "Source color"
            ]
            []
        , Html.code [ class "text-body-md text-on-surface-variant" ] [ Html.text model.seed ]
        ]


{-| Drive `--md-sys-density-scale` via a Tailwind arbitrary-property class — Elm
cannot set a CSS custom property directly. The three class strings are literals
so Tailwind's scanner (`@source "./app"` in style.css) emits all three rules.
-}
densityClass : Float -> String
densityClass d =
    if d <= -2 then
        "[--md-sys-density-scale:-2]"

    else if d <= -1 then
        "[--md-sys-density-scale:-1]"

    else
        "[--md-sys-density-scale:0]"


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
    , { title = "Concepts"
      , icon = "school"
      , items =
            [ ( "/concepts/layers", "The layers" )
            , ( "/concepts/userland", "Userland" )
            , ( "/concepts/phantom-rows", "Phantom rows" )
            , ( "/concepts/build", "The ⑤ Build pipeline" )
            , ( "/concepts/text-field", "Text field by composition" )
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
    , { title = "Examples"
      , icon = "auto_awesome"
      , items =
            [ ( "/examples", "Overview" )
            , ( "/examples/dashboard", "Dashboard" )
            , ( "/examples/shop", "Shop" )
            , ( "/examples/mail", "Mail" )
            , ( "/examples/travel", "Travel" )
            , ( "/examples/settings", "Settings" )
            ]
      }
    ]


{-| The whole below-app-bar shell: a side `m3e-drawer-container` whose `start`
panel is the hierarchical nav-menu and whose default content is the page body.
The nav is `NavItem` links inside `NavMenuItem` groups inside a `NavMenu`.
-}
drawerShell : (Msg -> msg) -> Model -> { path : UrlPath, route : Maybe Route } -> List (Html msg) -> Html msg
drawerShell toMsg model page body =
    let
        currentPath : String
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    DrawerContainer.view
        [ Seam.asAttribute (Attr.id "docs-drawer")
        , DrawerContainer.startMode Value.auto
        , DrawerContainer.start (not (isMobile model) || model.showMenu)
        , DrawerContainer.endMode Value.auto
        , DrawerContainer.end model.settingsOpen

        -- Sync our drawer booleans from the element's own `change` event (scrim
        -- click, Esc, breakpoint auto-close) so element-driven closes don't leave
        -- Elm's state stale (which would need a double-toggle to reopen). The
        -- Shared.Msg decoder is mapped to the outer msg via `toMsg`.
        , Seam.asAttribute (Html.Events.on "change" (Decode.map toMsg drawerChangeDecoder))
        ]
        [ DrawerContainer.startSlot
            (navMenu currentPath)
        , DrawerContainer.endSlot
            (Seam.fromHtml (Html.map toMsg (settingsDrawerContent model)))
        , Native.div
            -- the ContentPane provides its own container padding; keep only a
            -- modest inline margin like matraic's #body (margin-inline: 1rem).
            [ Seam.asAttribute (class "mx-auto w-full max-w-5xl px-2 py-2") ]
            (List.map Seam.fromHtml body)
        ]
        |> toHtml


{-| Decode the `<m3e-drawer-container>` `change` event: `event.target.start` and
`event.target.end` are the reflected boolean properties for each drawer's open
state. Change events bubbling up from inner components (e.g. the settings
segmented buttons) have a target without these properties, so the decoder fails
and Elm ignores them — exactly what we want.
-}
drawerChangeDecoder : Decode.Decoder Msg
drawerChangeDecoder =
    Decode.map2 DrawerChanged
        (Decode.at [ "target", "start" ] Decode.bool)
        (Decode.at [ "target", "end" ] Decode.bool)


{-| TODO(migrate): the old nav used `NavigationDrawer.group`/`link`; the new
`M3e.NavMenu`/`NavMenuItem` hierarchy has a different (nested-item, not a[href])
model that needs a design decision. For now the nav is faithfully reproduced as
the "pure a[href] links" the old code documented, via the Native escape — a Seam
candidate to component-ify once the NavMenu model is settled.
-}
navMenu : String -> Element { s | navMenu : Supported } msg
navMenu currentPath =
    NavMenu.view []
        (List.map (\s -> navGroup currentPath s.icon s.title s.items) navSections
            ++ [ componentsGroup currentPath
               , navGroup currentPath "menu_book" "Reference" [ ( "/reference", "Full API reference" ), ( "/roundtrip", "Round-trip report" ) ]
               ]
        )


{-| The single top-level **Components** nav group. Its children are the per-category
subgroups (Actions, Selection, …), each of which expands to that category's component
links — so the sidebar carries one "Components" parent instead of seven sibling
category groups (#106).
-}
componentsGroup : String -> Element { s | navMenuItem : Supported } msg
componentsGroup currentPath =
    NavMenuItem.view
        { label = Kit.text "Components" }
        (if String.startsWith "/components/" currentPath then
            [ NavMenuItem.open True ]

         else
            []
        )
        (NavMenuItem.icon (Icon.view [ Icon.name "widgets" ] [])
            :: navLeaf currentPath ( "/components/all", "All components" )
            :: List.map
                (\( category, glyph ) ->
                    navGroup currentPath
                        glyph
                        category
                        (componentList
                            |> List.filter (\( _, _, c ) -> c == category)
                            |> List.map (\( slug, label, _ ) -> ( "/components/" ++ slug, label ))
                        )
                )
                componentCategories
        )


navGroup : String -> String -> String -> List ( String, String ) -> Element { s | navMenuItem : Supported } msg
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
            :: List.map (navLeaf currentPath) items
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
    , ( "autocomplete", "Autocomplete", "Text inputs" )
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
    , ( "contentpane", "Content Pane", "Containment" )
    , ( "datepicker", "Date Picker", "Text inputs" )
    , ( "dialog", "Dialog", "Containment" )
    , ( "divider", "Divider", "Containment" )
    , ( "drawercontainer", "Navigation Drawer", "Navigation" )
    , ( "expansionpanel", "Expansion Panel", "Containment" )
    , ( "fab", "FAB", "Actions" )
    , ( "fabmenu", "FAB Menu", "Actions" )
    , ( "formfield", "Text Field", "Text inputs" )
    , ( "heading", "Heading", "Layout & style" )
    , ( "icon", "Icon", "Layout & style" )
    , ( "iconbutton", "Icon Button", "Actions" )
    , ( "list", "List", "Layout & style" )
    , ( "loadingindicator", "Loading Indicator", "Communication" )
    , ( "menu", "Menu", "Navigation" )
    , ( "navbar", "Navigation Bar", "Navigation" )
    , ( "navmenu", "Nav Menu", "Navigation" )
    , ( "navrail", "Navigation Rail", "Navigation" )
    , ( "paginator", "Paginator", "Navigation" )
    , ( "progress", "Progress", "Communication" )
    , ( "radiogroup", "Radio Button", "Selection" )
    , ( "scrollcontainer", "Scroll Container", "Containment" )
    , ( "searchbar", "Search", "Text inputs" )
    , ( "segmentedbutton", "Segmented Button", "Actions" )
    , ( "select", "Select", "Text inputs" )
    , ( "shape", "Shape", "Layout & style" )
    , ( "skeleton", "Skeleton", "Communication" )
    , ( "slidegroup", "Slide Group", "Navigation" )
    , ( "slider", "Slider", "Selection" )
    , ( "snackbar", "Snackbar", "Communication" )
    , ( "splitbutton", "Split Button", "Actions" )
    , ( "splitpane", "Split Pane", "Containment" )
    , ( "stepper", "Stepper", "Navigation" )
    , ( "switch", "Switch", "Selection" )
    , ( "tabs", "Tabs", "Navigation" )
    , ( "textareaautosize", "Textarea Autosize", "Text inputs" )
    , ( "texthighlight", "Text Highlight", "Layout & style" )
    , ( "theme", "Theme", "Layout & style" )
    , ( "toc", "TOC", "Navigation" )
    , ( "toolbar", "Toolbar", "Containment" )
    , ( "tooltip", "Tooltip", "Communication" )
    , ( "tree", "Tree", "Layout & style" )
    ]
