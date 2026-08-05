module Shared exposing (Data, Model, Msg, NavComponent, componentCategories, template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `M3e.AppBar`
top app bar, and an `M3e.DrawerContainer` holding the nav in the `start` slot
and the live theme controls in an `end`-slot settings drawer — cloning
matraic's shell. Every icon goes through `M3e.Icon`; every action through
`M3e.IconButton`; every theme control through `M3e.SegmentedButton`.

The scheme/contrast/direction state is held as generated `Value` tokens — there is
no local shadow union — so `M3e.Theme` takes the model field directly and the
settings controls render from the generated `<enum>Values` lists. Every
constructor is `Module.view [attrs] [content]`.

-}

import BackendTask exposing (BackendTask)
import Browser.Events
import Doc.Data
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Json.Decode as Decode
import M3e exposing (Element)
import M3e.AppBar
import M3e.Attributes
import M3e.DrawerContainer
import M3e.Events
import M3e.FormField
import M3e.Icon
import M3e.Kind
import M3e.NavMenuItem
import M3e.Theme
import M3e.Values as Value exposing (Value)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Ports
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping
import TypedHtml.Sectioning
import TypedHtml.Values
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
    , scheme : Value Value.Scheme
    , seed : String
    , contrast : Value Value.Contrast
    , density : Float
    , dir : TypedHtml.Values.Value TypedHtml.Values.Dir
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
    | SetScheme (Value Value.Scheme)
    | SetSeed String
    | SetContrast (Value Value.Contrast)
    | SetDensity Float
    | SetDirection (TypedHtml.Values.Value TypedHtml.Values.Dir)


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
      , contrast = Value.standard
      , density = 0
      , dir = TypedHtml.Values.ltr
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
`index.ts` as `flags.scheme`), else **auto** — follow the OS light/dark setting.

The string↔token conversion is generated (`M3e.Values.schemeFromString`), so the
persisted strings and the DOM attribute values cannot drift apart.

-}
schemeFromFlags : Pages.Flags.Flags -> Value Value.Scheme
schemeFromFlags flags =
    case flags of
        Pages.Flags.BrowserFlags raw ->
            Decode.decodeValue (Decode.field "scheme" Decode.string) raw
                |> Result.toMaybe
                |> Maybe.andThen Value.schemeFromString
                |> Maybe.withDefault Value.auto

        Pages.Flags.PreRenderFlags ->
            Value.auto


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
            , Effect.fromCmd (Ports.storeScheme (Value.toString scheme))
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
        absolutePath : String
        absolutePath =
            UrlPath.toAbsolute page.path

        ( shellClass, children ) =
            if String.startsWith "/examples/" absolutePath then
                -- Individual example routes take the full viewport; they include their
                -- own m3e nav chrome, so skip the docs shell to avoid double-nav.
                -- `h-dvh overflow-y-auto` makes each example its OWN bounded scroll
                -- region: the document (html/body) is fixed + non-scrolling for the
                -- stable mobile URL bar, so a full-viewport example must scroll itself
                -- rather than the document, or tall demos would clip.
                -- `block` is load-bearing: `m3e-theme`'s shadow styles set
                -- `:host { display: contents }`, and this branch is otherwise the
                -- only one that never names a `display` value of its own (the
                -- docs-shell branch below wins the cascade with its `grid`). With
                -- no competing declaration, `:host` wins by default, the host stops
                -- generating a box, and `h-dvh`/`overflow-y-auto` become inert —
                -- `scrollHeight`/`clientHeight` both read 0 and nothing scrolls.
                ( "bg-surface text-on-surface block h-dvh overflow-y-auto"
                , View.body pageView
                )

            else
                -- Fixed-height, non-scrolling shell: `h-dvh` fits the stable
                -- visible viewport (see style.css app-shell note) and the
                -- `auto_1fr` rows pin the app bar while the 1fr content row
                -- (the drawer + its <main>) is the ONE scroll region — keeps
                -- the mobile URL bar from collapsing on scroll.
                ( "bg-surface text-on-surface grid h-dvh grid-rows-[auto_1fr] overflow-hidden"
                , [ skipLink
                  , M3e.mapMsg toMsg appShellBar
                  , drawerShell toMsg model page sharedData.components (View.body pageView)
                  ]
                )
    in
    { title = View.title pageView
    , body =
        [ M3e.theme
            [ M3e.Theme.color model.seed
            , M3e.Theme.scheme model.scheme
            , M3e.Theme.contrast model.contrast
            , M3e.Theme.density model.density
            , TypedHtml.Attributes.dir model.dir

            -- The m3e-theme element's `density` prop/attr is NON-reactive, so the
            -- control has no effect unless we drive `--md-sys-density-scale` (which
            -- the m3e components read via density.calc) ourselves. Elm can't set a
            -- CSS custom property directly — `style` uses `node.style[key]=…` which
            -- ignores `--vars`, and `attribute "style"` gets clobbered on re-render —
            -- so it goes through a Tailwind arbitrary-property CLASS instead.
            , TypedHtml.Attributes.class (shellClass ++ " " ++ densityClass model.density)
            ]
            -- `dir` is admissible directly on the `m3e-theme` host because `dir` is
            -- part of the open-row `_globals` axis (elm-cem, elm-typed-html), so the
            -- wrapper div that used to carry the shell classes and `dir` together is
            -- gone — both now live on the host itself.
            children
            |> M3e.toHtml
        ]
    }


{-| A "Skip to main content" link — the first focusable element on the page, so
keyboard/AT users can jump the ~98-item nav and land on `#main-content` (the
`<main>` landmark `drawerShell` wraps the page body in). Visually hidden until
focused, then it surfaces as a floating chip.
-}
skipLink : Element { s | sharedText : M3e.Kind.Shared } adm_ msg
skipLink =
    TypedHtml.a
        [ TypedHtml.Attributes.href "#main-content"
        , TypedHtml.Attributes.class "sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:rounded-lg focus:bg-primary focus:px-4 focus:py-2 focus:text-on-primary focus:shadow-md-level2"
        ]
        [ M3e.text "Skip to main content" ]


normalizePath : String -> String
normalizePath path =
    if path /= "/" && String.endsWith "/" path then
        String.dropRight 1 path

    else
        path



-- TOP APP BAR


appShellBar : Element (TypedHtml.Sectioning.HeaderIs s) adm_ Msg
appShellBar =
    M3e.appBar
        [ M3e.AppBar.size Value.small
        , M3e.Attributes.id "docs-app-bar"
        ]
        [ M3e.AppBar.leading brandMark
        , M3e.AppBar.leading menuButton
        , M3e.AppBar.title (M3e.text "elm-m3e")
        , M3e.AppBar.subtitle (M3e.text "Material 3 Expressive for Elm")
        , M3e.AppBar.trailing githubLink
        , M3e.AppBar.trailing settingsButton
        ]


{-| The brand mark in the app bar: the real Material Symbols "palette" glyph,
rendered by the m3e `Icon` component from the self-hosted font. Hidden on mobile
(the drawer takes over there), shown from `md` up.
-}
brandMark : Element (M3e.Icon.Is s) admittedBy Msg
brandMark =
    -- Purely decorative brand glyph — hidden from assistive tech (aria-hidden)
    -- so it isn't announced alongside the adjacent "elm-m3e" title. Visibility
    -- and spacing ride on the icon itself; no wrapper needed.
    M3e.icon
        [ M3e.Icon.name "palette"
        , TypedHtml.Attributes.class "ms-2 me-1 hidden md:inline-flex"
        , Aria.hidden Aria.true
        ]
        []


{-| The mobile hamburger. `md:hidden` rides on the icon button itself (the side
drawer is always visible on wider viewports), so no wrapper span is needed.
-}
menuButton : Element { s | iconButton : M3e.Kind.Brand } admittedBy Msg
menuButton =
    M3e.iconButton
        [ Aria.label "Toggle navigation", TypedHtml.Attributes.class "md:hidden", M3e.Events.onClick MenuClicked ]
        [ M3e.icon [ M3e.Icon.name "menu" ] [] ]


{-| The GitHub link. The mark is registered into `m3e-icon`'s own icon registry at
startup (`docs/gen/icons.js`, generated from `config/icons.json`), so this is an
ordinary typed icon — no raw SVG string and no `M3e.Unsafe` escape. Registry-rendered
icons are `<svg><path/></svg>` inside `m3e-icon`, so the mark still inherits the app
bar's on-surface foreground and adapts to light/dark.
-}
githubLink : Element { s | iconButton : M3e.Kind.Brand } admittedBy Msg
githubLink =
    M3e.iconButton
        [ Aria.label "GitHub repository"
        , M3e.Attributes.href "https://github.com/jackhp95/elm-m3e"
        , M3e.Attributes.target "_blank"
        , M3e.Attributes.rel "noreferrer noopener"
        ]
        [ M3e.icon [ M3e.Icon.name "github" ] [] ]


{-| The app-bar settings control: a plain icon button that flips `settingsOpen`,
which drives the end drawer's `open` state. (Was a Card popover trigger.)
-}
settingsButton : Element { s | iconButton : M3e.Kind.Brand } admittedBy Msg
settingsButton =
    M3e.iconButton
        [ Aria.label "Settings", M3e.Events.onClick ToggleSettings ]
        [ M3e.icon [ M3e.Icon.name "settings" ] [] ]



-- SETTINGS (end drawer content — cloned from matraic's #settings-drawer)


{-| The theme controls, rendered into the drawer-container's `end` slot. Built
from library components in the Element world: each control is a
an `M3e.heading` label + a control (segmented buttons, or a
[`FormField`](M3e-FormField) for the seed color). The container keeps its
`#settings-drawer` id (matraic's flex-column/gap/padding styling lives in
`style.css`) and the typed `role="complementary"` landmark via `Aria.role`. It
returns `Element`, so it enters the drawer's `end` slot directly (no
`M3e.Unsafe.fromHtml`).

All our richer controls are kept (scheme, contrast, seed color, density,
direction); only their LOCATION moved from the old Card popover into this end
drawer.

-}
settingsDrawerContent : Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
settingsDrawerContent model =
    TypedHtml.div
        [ TypedHtml.Attributes.id "settings-drawer"
        , Aria.role Aria.complementary
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


controlLabel : String -> Element { s | heading : M3e.Kind.Brand } admittedBy Msg
controlLabel lbl =
    M3e.heading
        [ M3e.Attributes.variant Value.label, M3e.Attributes.size Value.large, TypedHtml.Attributes.class "text-on-surface" ]
        [ M3e.text lbl ]


{-| One segmented-button control: `SegmentedButton` holding `ButtonSegment`
children, each a checked/label/onClick triple.
-}
segmented : List ( String, Bool, Msg ) -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
segmented segments =
    M3e.segmentedButton []
        (List.map
            (\( lbl, isChecked, msg ) ->
                M3e.buttonSegment
                    [ M3e.Attributes.checked isChecked, M3e.Events.onClick msg ]
                    [ M3e.text lbl ]
            )
            segments
        )


{-| Upper-case the first character. Enum wire strings are lower-case; the settings
controls display them title-cased.
-}
capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s


{-| These controls compare tokens with `==`. A `Value` is opaque over a `String`, so
the comparison is on the underlying wire string — meaning tokens from DIFFERENT enums
that share a string would compare equal. Safe here because each control only ever
compares a field against its own enum's values.
-}
schemeSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
schemeSegmented model =
    segmented
        (Value.schemeValues
            |> List.sortBy schemeOrder
            |> List.map (\v -> ( schemeLabel v, model.scheme == v, SetScheme v ))
        )


{-| Display order — the neutral option sits between the two poles, which is why this
is not the generated list's alphabetical order. A value we have not placed sorts last
rather than disappearing.
-}
schemeOrder : Value Value.Scheme -> Int
schemeOrder v =
    case Value.toString v of
        "light" ->
            0

        "auto" ->
            1

        "dark" ->
            2

        _ ->
            3


{-| Editorial labels: `auto` reads as "System". Anything the manifest gains that we
have not named falls back to its wire string, so a new value shows up VISIBLY
mislabelled rather than silently missing from the drawer.
-}
schemeLabel : Value Value.Scheme -> String
schemeLabel v =
    case Value.toString v of
        "auto" ->
            "System"

        other ->
            capitalize other


contrastSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
contrastSegmented model =
    segmented
        (Value.contrastValues
            |> List.sortBy contrastOrder
            |> List.map (\v -> ( capitalize (Value.toString v), model.contrast == v, SetContrast v ))
        )


{-| Display order — ascending intensity, which alphabetical order does not give.
-}
contrastOrder : Value Value.Contrast -> Int
contrastOrder v =
    case Value.toString v of
        "standard" ->
            0

        "medium" ->
            1

        "high" ->
            2

        _ ->
            3


{-| The source-color control, dogfooding the composition-text-field pattern
(`/guide/composition-text-field`): an outlined `FormField` whose label and typed
native `<input type=color>` are wired into one accessible control by a single
shared id (`"seed-color"`), with the live hex shown as the field hint. The
`#settings-drawer input[type="color"]` rule in `style.css` still rounds the
swatch. `onInput` is the typed `TypedHtml.Events.onInput`.
-}
seedColorInput : Model -> Element { s | formField : M3e.Kind.Brand } admittedBy Msg
seedColorInput model =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ M3e.FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for "seed-color" ] [ M3e.text "Source color" ])
        , M3e.FormField.hint
            (M3e.heading [ M3e.Attributes.variant Value.label, M3e.Attributes.size Value.small, TypedHtml.Attributes.class "text-on-surface-variant" ] [ M3e.text model.seed ])
        , TypedHtml.input
            [ TypedHtml.Attributes.id "seed-color"
            , TypedHtml.Attributes.type_ "color"
            , TypedHtml.Attributes.value model.seed
            , TypedHtml.Events.onInput SetSeed
            ]
            []
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


densitySegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
densitySegmented model =
    segmented
        [ ( "0", model.density == 0, SetDensity 0 )
        , ( "-1", model.density == -1, SetDensity -1 )
        , ( "-2", model.density == -2, SetDensity -2 )
        , ( "-3", model.density == -3, SetDensity -3 )
        ]


directionSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
directionSegmented model =
    segmented
        (TypedHtml.Values.dirValues
            -- `dir` admits auto|ltr|rtl. `auto` defers to the document/OS, which is
            -- already what the shell does when this control is untouched, so offering
            -- it would be a button that visibly does nothing. Filtered explicitly
            -- rather than hand-listing ltr/rtl, so a FOURTH value would still appear.
            |> List.filter (\v -> TypedHtml.Values.toString v /= "auto")
            |> List.map
                (\v ->
                    ( String.toUpper (TypedHtml.Values.toString v)
                    , model.dir == v
                    , SetDirection v
                    )
                )
        )



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
drawerShell :
    (Msg -> msg)
    -> Model
    -> { path : UrlPath, route : Maybe Route }
    -> List NavComponent
    -> List (Element childAccepts (TypedHtml.Sectioning.MainChildAdmittedBy childAdm) msg)
    -> Element (M3e.DrawerContainer.Is s) freeAdm msg
drawerShell toMsg model page components body =
    let
        currentPath : String
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    M3e.drawerContainer
        [ M3e.Attributes.id "docs-drawer"
        , M3e.DrawerContainer.startMode Value.auto
        , M3e.Attributes.start (not (isMobile model) || model.showMenu)
        , M3e.DrawerContainer.endMode Value.auto
        , M3e.Attributes.end model.settingsOpen

        -- Sync our drawer booleans from the element's own `change` event (scrim
        -- click, Esc, breakpoint auto-close) so element-driven closes don't leave
        -- Elm's state stale (which would need a double-toggle to reopen). The
        -- Shared.Msg decoder is mapped to the outer msg via `toMsg`.
        , M3e.Events.onChangeWith (Decode.map toMsg drawerChangeDecoder)
        ]
        [ M3e.DrawerContainer.start
            -- Wrap the nav-menu in a native `<nav>` landmark so AT users can
            -- jump straight to navigation (and skip past it via the skip-link).
            (TypedHtml.nav
                [ Aria.label "Primary" ]
                [ navMenu components currentPath ]
            )
        , M3e.DrawerContainer.end
            (M3e.mapMsg toMsg (settingsDrawerContent model))

        -- The page body is the `<main>` landmark and the skip-link target.
        -- The ContentPane provides its own container padding; keep only a
        -- modest inline margin like matraic's #body (margin-inline: 1rem).
        , TypedHtml.main_
            [ TypedHtml.Attributes.id "main-content"
            , TypedHtml.Attributes.class "mx-auto w-full max-w-5xl px-2 py-2"
            ]
            body
        ]


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
navMenu : List NavComponent -> String -> Element { s | navMenu : M3e.Kind.Brand } admittedBy msg
navMenu components currentPath =
    M3e.navMenu []
        (List.map (\s -> navGroup currentPath s.icon s.title s.items) navSections
            ++ [ componentsGroup components currentPath
               , navGroup currentPath "menu_book" "Reference" [ ( "/guide/cheat-sheet", "Cheat sheet" ), ( "/guide/glossary", "Glossary" ), ( "/reference", "Full API reference" ), ( "/roundtrip", "Round-trip report" ) ]
               ]
        )


{-| The single top-level **Components** nav group — every component listed
alphabetically (by label), with no category sub-groups.
-}
componentsGroup : List NavComponent -> String -> Element { s | navMenuItem : M3e.Kind.Brand } admittedBy msg
componentsGroup components currentPath =
    M3e.navMenuItem
        (if String.startsWith "/components/" currentPath then
            [ M3e.Attributes.open True ]

         else
            []
        )
        (M3e.NavMenuItem.label (M3e.text "Components")
            :: M3e.NavMenuItem.icon (M3e.icon [ M3e.Icon.name "widgets" ] [])
            :: navLeaf currentPath ( "/components/all", "All components" )
            :: List.map
                (\c -> navLeaf currentPath ( "/components/" ++ c.slug, c.label ))
                (List.sortBy (\c -> String.toLower c.label) components)
        )


navGroup : String -> String -> String -> List ( String, String ) -> Element { s | navMenuItem : M3e.Kind.Brand } admittedBy msg
navGroup currentPath glyph grpTitle items =
    M3e.navMenuItem
        -- Only SET `open` when this group holds the current route. `open` is a
        -- controlled property, so setting it False pins the group closed and the
        -- user can't expand it; leaving it unset lets the component toggle freely.
        (if List.any (\( path, _ ) -> path == currentPath) items then
            [ M3e.Attributes.open True ]

         else
            []
        )
        (M3e.NavMenuItem.label (M3e.text grpTitle)
            :: M3e.NavMenuItem.icon (M3e.icon [ M3e.Icon.name glyph ] [])
            :: List.map (navLeaf currentPath) items
        )


navLeaf : String -> ( String, String ) -> Element { navMenuItem : M3e.Kind.Brand } admittedBy msg
navLeaf currentPath ( path, lbl ) =
    M3e.navMenuItem
        [ M3e.Attributes.selected (path == currentPath) ]
        [ M3e.NavMenuItem.label (TypedHtml.a [ TypedHtml.Attributes.href path ] [ M3e.text lbl ]) ]


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
