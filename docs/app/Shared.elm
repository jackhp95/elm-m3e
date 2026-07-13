module Shared exposing (Contrast, Data, Direction, Model, Msg, Scheme, componentCategories, template, NavComponent)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `M3e.AppBar`
top app bar, and an `M3e.DrawerContainer` holding the nav in the `start` slot
and the live theme controls in an `end`-slot settings drawer — cloning
matraic's shell. Every icon goes through `M3e.Icon`; every action through
`M3e.IconButton`; every theme control through `M3e.SegmentedButton`.

Migrated to the M3e API: the old hand `Theme.Scheme`/`Theme.Contrast`
unions are now local (the new `M3e.Theme` is token-driven), and every constructor
is `Module.view [attrs] [content]`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Doc.Data
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class)
import Html.Events
import Json.Decode as Decode
import Kit
import Kit.Surface as Surface
import M3e
import Markup.Aria as Aria
import Markup.Atoms
import Markup.Attributes as Attrs
import Markup.Element as Element exposing (Element)
import Markup.Html.Attr exposing (Attr)
import M3e.Native
import Markup.Node as Node
import M3e.Kind
import M3e.Token as Value exposing (Value)
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


{-| One drawer-nav component, derived from `data/reference.json`: the entries
that `config/categories.json` gives a category (so they appear in the drawer),
each carrying its editorial `label` and `category` for grouping.
-}
type alias NavComponent =
    { slug : String, label : String, category : String }


{-| The shared data every route sees: the derived component-nav list. Read once
from `reference.json` (the single source), so the drawer, the `/components/all`
grouping, and the home-page count can never drift from the catalogue again.
-}
type alias Data =
    { components : List NavComponent }


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
    Doc.Data.allComponents
        |> BackendTask.map
            (\components ->
                { components =
                    components
                        -- Only categorised entries are nav components; the rest
                        -- (base classes, sub-elements) stay out of the drawer.
                        |> List.filter (\c -> c.category /= "")
                        |> List.map (\c -> { slug = c.slug, label = c.label, category = c.category })
                        -- Sort by slug so each category's items render in the
                        -- same order the old hand-list did (it was slug-sorted).
                        |> List.sortBy .slug
                }
            )



-- VIEW


{-| Convenience alias: convert any `Element` to `Html`.
-}
toHtml : Element any msg -> Html msg
toHtml =
    Element.toNode >> Node.toHtml


schemeAttr : Scheme -> Attr { c | scheme : Value.Supported } msg
schemeAttr scheme =
    case scheme of
        Auto ->
            M3e.schemeAuto

        Light ->
            M3e.schemeLight

        Dark ->
            M3e.schemeDark


contrastAttr : Contrast -> Attr { c | contrast : Value.Supported } msg
contrastAttr contrast =
    case contrast of
        Standard ->
            M3e.contrastStandard

        Medium ->
            M3e.contrastMedium

        High ->
            M3e.contrastHigh


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
view sharedData page model toMsg pageView =
    let
        -- `themed` wraps content Elements in `<m3e-theme>` and does the single
        -- `Node.toHtml` conversion.
        themed : List (Element { html : M3e.Kind.Brand } msg) -> Html msg
        themed children =
            M3e.theme
                [ M3e.attrColor model.seed
                , schemeAttr model.scheme
                , contrastAttr model.contrast
                , M3e.attrDensity model.density

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
                    [ Seam.fromHtml skipLink
                    , Seam.fromHtml (Html.map toMsg appShellBar)
                    , Seam.fromHtml (drawerShell toMsg model page sharedData.components (List.map Node.toHtml pageView.body))
                    ]
                ]
            ]
    }


{-| A "Skip to main content" link — the first focusable element on the page, so
keyboard/AT users can jump the ~98-item nav and land on `#main-content` (the
`<main>` landmark `drawerShell` wraps the page body in). Visually hidden until
focused, then it surfaces as a floating chip.
-}
skipLink : Html msg
skipLink =
    Html.a
        [ Attr.href "#main-content"
        , class "sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:rounded-lg focus:bg-primary focus:px-4 focus:py-2 focus:text-on-primary focus:shadow-md-level2"
        ]
        [ Html.text "Skip to main content" ]


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


appShellBar : Html Msg
appShellBar =
    Html.header
        [ class "sticky top-0 z-30 border-b border-outline-variant bg-surface-container-low shadow-md-level1" ]
        [ M3e.appBar
            [ M3e.sizeSmall
            , Attrs.id "docs-app-bar"
            ]
            [ M3e.appBarSlotTitle (Kit.text "elm-m3e")
            , M3e.appBarSlotSubtitle (Kit.text "Material 3 Expressive for Elm")
            , M3e.appBarSlotLeading
                (Seam.recast
                    (Native.span [ Seam.asAttribute (class "flex items-center") ]
                        [ brandMark, menuButton ]
                    )
                )
            , M3e.appBarSlotTrailing (Seam.recast githubLink)
            , M3e.appBarSlotTrailing (Seam.recast settingsButton)
            ]
            |> toHtml
        ]


{-| The brand mark in the app bar: the real Material Symbols "palette" glyph,
rendered by the m3e `Icon` component from the self-hosted font. Hidden on mobile
(the drawer takes over there), shown from `md` up.
-}
brandMark : Element { html : M3e.Kind.Brand } Msg
brandMark =
    Native.span
        [ Seam.asAttribute (class "ms-2 me-1 hidden md:inline-flex")

        -- Purely decorative brand glyph — hide it from assistive tech so it
        -- isn't announced alongside the "elm-m3e" title next to it.
        , Seam.asAttribute (attribute "aria-hidden" "true")
        ]
        [ M3e.icon [ M3e.attrName "palette" ] [] ]


{-| The mobile hamburger. Wrapped in a `span.md:hidden` so it's invisible on wider
viewports (the side drawer is always visible there).
-}
menuButton : Element { html : M3e.Kind.Brand } Msg
menuButton =
    Native.span
        [ Seam.asAttribute (class "md:hidden") ]
        [ M3e.iconButton
            [ Aria.label "Toggle navigation", Native.onClick MenuClicked ]
            [ M3e.icon [ M3e.attrName "menu" ] [] ]
        ]


{-| The GitHub link. The GitHub mark is an inline `<svg fill="currentColor">`
(path copied verbatim from matraic's `docs/index.html`) so it inherits the app
bar's on-surface foreground and adapts to light/dark — a Material Symbol `code`
glyph was a stand-in. The SVG rides in via the docs' `raw-html` custom element
(same seam as `Doc.rawPreview`); parsed inside a `<template>` it lands in the SVG
namespace and renders as a real vector.
-}
githubLink : Element { iconButton : M3e.Kind.Brand } Msg
githubLink =
    M3e.iconButton
        [ Aria.label "GitHub repository"
        , M3e.attrHref "https://github.com/jackhp95/elm-m3e"
        , M3e.attrTarget "_blank"
        , M3e.attrRel "noreferrer noopener"
        ]
        [ Seam.fromHtml githubMark ]


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
settingsButton : Element { iconButton : M3e.Kind.Brand } Msg
settingsButton =
    M3e.iconButton
        [ Aria.label "Settings", Native.onClick ToggleSettings ]
        [ M3e.icon [ M3e.attrName "settings" ] [] ]



-- SETTINGS (end drawer content — cloned from matraic's #settings-drawer)


{-| The theme controls, rendered into the drawer-container's `end` slot. Built
from library components in the Element world: each control is a
[`Kit.labelText`](Kit#labelText) label + a control (segmented buttons, or a
[`FormField`](M3e-FormField) for the seed color). The container keeps its
`#settings-drawer` id (matraic's flex-column/gap/padding styling lives in
`style.css`) and the `role="complementary"` landmark, both crossed through the
one sanctioned `Seam.asAttribute`. It returns `Element`, so it enters the
drawer's `end` slot directly (no `Seam.fromHtml`).

All our richer controls are kept (scheme, contrast, seed color, density,
direction); only their LOCATION moved from the old Card popover into this end
drawer.

-}
settingsDrawerContent : Model -> Element { s | html : M3e.Kind.Brand } Msg
settingsDrawerContent model =
    Native.div
        [ Seam.asAttribute (Attr.id "settings-drawer")
        , Seam.asAttribute (attribute "role" "complementary")
        ]
        [ seedColorInput model
        , controlLabel "Color scheme"
        , schemeSegmented model
        , controlLabel "Contrast"
        , contrastSegmented model
        , controlLabel "Density"
        , densitySegmented model
        , controlLabel "Directionality"
        , directionSegmented model
        ]


controlLabel : String -> Element { s | html : M3e.Kind.Brand } Msg
controlLabel label =
    Kit.labelText Value.large [ Kit.onSurface ] [ Kit.text label ]


{-| One segmented-button control: `SegmentedButton` holding `ButtonSegment`
children, each a checked/label/onClick triple.
-}
segmented : List ( String, Bool, Msg ) -> Element { s | segmentedButton : M3e.Kind.Brand } Msg
segmented segments =
    M3e.segmentedButton []
        (List.map
            (\( label, checked, msg ) ->
                M3e.buttonSegment
                    [ M3e.attrChecked checked, Native.onClick msg ]
                    [ Markup.Atoms.text label ]
            )
            segments
        )


schemeSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } Msg
schemeSegmented model =
    segmented
        [ ( "Light", model.scheme == Light, SetScheme Light )
        , ( "System", model.scheme == Auto, SetScheme Auto )
        , ( "Dark", model.scheme == Dark, SetScheme Dark )
        ]


contrastSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } Msg
contrastSegmented model =
    segmented
        [ ( "Standard", model.contrast == Standard, SetContrast Standard )
        , ( "Medium", model.contrast == Medium, SetContrast Medium )
        , ( "High", model.contrast == High, SetContrast High )
        ]


{-| The source-color control, dogfooding the composition-text-field pattern
(`/guide/composition-text-field`): an outlined `FormField` whose label and typed
native `<input type=color>` are wired into one accessible control by a single
shared id (`"seed-color"`), with the live hex shown as the field hint. The
`#settings-drawer input[type="color"]` rule in `style.css` still rounds the
swatch. `onInput` crosses via the one sanctioned `Seam.asAttribute`.
-}
seedColorInput : Model -> Element { s | formField : M3e.Kind.Brand } Msg
seedColorInput model =
    M3e.formField [ M3e.variantOutlined ]
        [ M3e.formFieldSlotLabel "seed-color" (Native.label [] [ Kit.text "Source color" ])
        , M3e.formFieldSlotHint (Kit.code Value.small [ Kit.onSurfaceVariant ] [ Kit.text model.seed ])
        , M3e.formFieldSlotDefault "seed-color"
            (M3e.Native.input
                [ M3e.Native.type_ "color"
                , M3e.Native.value model.seed
                , Seam.asAttribute (Html.Events.onInput SetSeed)
                ]
            )
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


densitySegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } Msg
densitySegmented model =
    segmented
        [ ( "0", model.density == 0, SetDensity 0 )
        , ( "-1", model.density == -1, SetDensity -1 )
        , ( "-2", model.density == -2, SetDensity -2 )
        , ( "-3", model.density == -3, SetDensity -3 )
        ]


directionSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } Msg
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
            [ ( "/getting-started/installation", "Installation" )
            , ( "/getting-started/browser-support", "Browser Support" )
            ]
      }
    , { title = "The Guide"
      , icon = "auto_stories"
      , items =
            [ ( "/guide", "Start here" )
            , ( "/guide/first-component", "Your first component" )
            , ( "/guide/invalid-states", "Invalid states don't compile" )
            , ( "/guide/strictness", "The strictness dial" )
            , ( "/guide/accessible-by-construction", "Accessibility you can't forget" )
            , ( "/guide/accessibility", "Accessibility reference" )
            , ( "/guide/composition-text-field", "Composition, not injection" )
            , ( "/guide/theming", "Theming with tokens" )
            , ( "/guide/motion", "Motion" )
            , ( "/guide/generated-and-inspectable", "Generated & inspectable" )
            , ( "/guide/the-layers", "The layer map" )
            , ( "/guide/seams", "Your own seam" )
            , ( "/guide/tooling-refactors", "The tooling refactors for you" )
            , ( "/guide/troubleshooting", "Troubleshooting" )
            , ( "/guide/how-we-prove-it", "How we prove it" )
            ]
      }
    , { title = "Guide reference"
      , icon = "bookmark"
      , items =
            [ ( "/guide/cheat-sheet", "Cheat sheet" )
            , ( "/guide/glossary", "Glossary" )
            ]
      }
    , { title = "Styles"
      , icon = "palette"
      , items =
            [ ( "/styles/color", "Color" )
            , ( "/styles/typography", "Typography" )
            , ( "/styles/shape", "Shape" )
            , ( "/styles/elevation", "Elevation" )
            , ( "/styles/state-layers", "State Layers" )
            , ( "/styles/motion", "Motion" )
            , ( "/styles/density", "Density" )
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
            , ( "/examples/list-detail", "List-detail" )
            , ( "/examples/supporting-pane", "Supporting pane" )
            , ( "/examples/feed", "Feed" )
            ]
      }
    ]


{-| The whole below-app-bar shell: a side `m3e-drawer-container` whose `start`
panel is the hierarchical nav-menu and whose default content is the page body.
The nav is `NavItem` links inside `NavMenuItem` groups inside a `NavMenu`.
-}
drawerShell : (Msg -> msg) -> Model -> { path : UrlPath, route : Maybe Route } -> List NavComponent -> List (Html msg) -> Html msg
drawerShell toMsg model page components body =
    let
        currentPath : String
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    M3e.drawerContainer
        [ Attrs.id "docs-drawer"
        , M3e.startModeAuto
        , M3e.attrStart (not (isMobile model) || model.showMenu)
        , M3e.endModeAuto
        , M3e.attrEnd model.settingsOpen

        -- Sync our drawer booleans from the element's own `change` event (scrim
        -- click, Esc, breakpoint auto-close) so element-driven closes don't leave
        -- Elm's state stale (which would need a double-toggle to reopen). The
        -- Shared.Msg decoder is mapped to the outer msg via `toMsg`.
        , Seam.asAttribute (Html.Events.on "change" (Decode.map toMsg drawerChangeDecoder))
        ]
        [ M3e.drawerContainerSlotStart
            -- Wrap the nav-menu in a native `<nav>` landmark so AT users can
            -- jump straight to navigation (and skip past it via the skip-link).
            (Native.nav
                [ Seam.asAttribute (attribute "aria-label" "Primary") ]
                [ navMenu components currentPath ]
            )
        , M3e.drawerContainerSlotEnd
            (Element.map toMsg (settingsDrawerContent model))
        , Seam.fromHtml
            -- The page body is the `<main>` landmark and the skip-link target.
            -- The ContentPane provides its own container padding; keep only a
            -- modest inline margin like matraic's #body (margin-inline: 1rem).
            (Html.main_
                [ Attr.id "main-content"
                , class "mx-auto w-full max-w-5xl px-2 py-2"
                ]
                body
            )
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


{-| The docs sidebar nav, an `M3e.NavMenu` of nested `NavMenuItem` groups. Each
leaf's **label** is a real `a[href]` supplied through the `link` seam (see
`navLeaf`): `config/slots.json` declares `NavMenuItem.label`'s `link` kind, so a
link-kind label slots in cleanly and the item navigates like any anchor — no
`onClick` intercept. Groups (`navGroup`/`componentsGroup`) nest via each item's
child list; only the group on the current route is opened.
-}
navMenu : List NavComponent -> String -> Element { s | navMenu : M3e.Kind.Brand } msg
navMenu components currentPath =
    M3e.navMenu []
        (List.map (\s -> navGroup currentPath s.icon s.title s.items) navSections
            ++ [ componentsGroup components currentPath
               , navGroup currentPath "menu_book" "Reference" [ ( "/reference", "Full API reference" ), ( "/roundtrip", "Round-trip report" ) ]
               ]
        )


{-| The single top-level **Components** nav group. Its children are the per-category
subgroups (Actions, Selection, …), each of which expands to that category's component
links — so the sidebar carries one "Components" parent instead of seven sibling
category groups (#106).
-}
componentsGroup : List NavComponent -> String -> Element { s | navMenuItem : M3e.Kind.Brand } msg
componentsGroup components currentPath =
    M3e.navMenuItem
        (if String.startsWith "/components/" currentPath then
            [ M3e.attrOpen True ]

         else
            []
        )
        (M3e.navMenuItemSlotLabel (Markup.Atoms.text "Components")
            :: M3e.navMenuItemSlotIcon (M3e.icon [ M3e.attrName "widgets" ] [] |> Seam.recast)
            :: navLeaf currentPath ( "/components/all", "All components" )
            :: List.map
                (\( category, glyph ) ->
                    navGroup currentPath
                        glyph
                        category
                        (components
                            |> List.filter (\c -> c.category == category)
                            |> List.map (\c -> ( "/components/" ++ c.slug, c.label ))
                        )
                )
                componentCategories
        )


navGroup : String -> String -> String -> List ( String, String ) -> Element { s | navMenuItem : M3e.Kind.Brand } msg
navGroup currentPath glyph title items =
    M3e.navMenuItem
        -- Only SET `open` when this group holds the current route. `open` is a
        -- controlled property, so setting it False pins the group closed and the
        -- user can't expand it; leaving it unset lets the component toggle freely.
        (if List.any (\( path, _ ) -> path == currentPath) items then
            [ M3e.attrOpen True ]

         else
            []
        )
        (M3e.navMenuItemSlotLabel (Markup.Atoms.text title)
            :: M3e.navMenuItemSlotIcon (M3e.icon [ M3e.attrName glyph ] [] |> Seam.recast)
            :: List.map (navLeaf currentPath) items
        )


navLeaf : String -> ( String, String ) -> Element { navMenuItem : M3e.Kind.Brand } msg
navLeaf currentPath ( path, label ) =
    M3e.navMenuItem
        [ M3e.attrSelected (path == currentPath) ]
        [ M3e.navMenuItemSlotLabel (Kit.link path [ Kit.text label ] |> Seam.recast) ]


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
