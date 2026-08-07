module Shared exposing (Data, Model, Msg, NavComponent, componentCategories, template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app. Navigation is split across
three surfaces:

  - **Top-level sections** (Getting Started, The Guide, Styles, Examples,
    Components) live in a persistent `M3e.NavRail` down the left edge on
    desktop, swapped for a fixed-bottom `M3e.NavBar` on mobile
    (`docsNavRail`/`docsNavBar`, Tailwind `md:` swap at 768px).
  - **The current section's page tree** lives in the `start` slot of an
    `M3e.DrawerContainer` below the app bar (`navMenu`), pinned open on
    desktop and toggled from the app bar's hamburger on narrow screens.
  - **The current page's table of contents** is opt-in (`View.withToc`) and
    lives in the same container's `end` slot (`tocPanel`), pinned open on
    wide screens and toggled from the app bar's "On this page" button
    otherwise.

Above them sits a real `M3e.AppBar` top app bar; the live theme controls are in
a settings bottom sheet toggled from it. Every icon goes through `M3e.Icon`;
every action through `M3e.IconButton`; every theme control through
`M3e.SegmentedButton`.

Both drawer panels' open state is genuinely model-owned (`treeOpen`/`tocOpen`)
rather than recomputed per render — see `drawerSideBreakpointPx` for why that
distinction is load-bearing.

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
import M3e.BottomSheet
import M3e.ContentPane
import M3e.DrawerContainer
import M3e.Events
import M3e.FormField
import M3e.Icon
import M3e.Kind
import M3e.NavItem
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
    , onPageChange = Just (\_ -> PageChanged)
    }



-- MODEL


type alias Model =
    { treeOpen : Bool
    , tocOpen : Bool
    , viewportWidth : Int
    , scheme : Value Value.Scheme
    , seed : String
    , contrast : Value Value.Contrast
    , density : Float
    , dir : TypedHtml.Values.Value TypedHtml.Values.Dir
    , settingsOpen : Bool
    }


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


{-| The width at or above which `DrawerContainer`'s `auto` mode keeps a panel
in `side` (pinned, content-shrinking) rather than `push`/`over` (overlaying,
scrim-dismissable).

**This number is not ours to pick.** It is `Breakpoint.Medium`'s
`(min-width: 960px)` in `@m3e/web/dist/core-layout.js`, which
`_updateMode` in `@m3e/web/dist/drawer-container.js` observes. Elm has to
mirror it because the panels' open state is a Lit property, not CSS state:
Elm decides whether a panel starts pinned open, and the element decides how a
pinned panel is drawn. Elm used to say 768 while the element said 960, and
every width in between was a trap: the element auto-CLOSED the panel and said
so via its `change` event, but Elm's open state was a formula
(`not (isMobile model) || model.showMenu`) that still evaluated to the same
constant `True`, so the virtual-DOM diff emitted no patch and the panel stayed
shut for good — no later tap and no later resize could reopen it.

Hence both halves of the fix: this constant matches the element's, AND the open
state is now a plain model field (`treeOpen`/`tocOpen`) rendered directly, so it
cannot collapse into a constant again.

This is deliberately NOT the Tailwind `md` breakpoint (768px), which
independently controls the `docsNavRail`/`docsNavBar` swap in pure CSS and
needs no Elm state at all.

-}
drawerSideBreakpointPx : Int
drawerSideBreakpointPx =
    960


{-| The width at or above which the TOC panel is ALSO pinned open beside the
tree, instead of being one-at-a-time with it.

Derived from the layout budget rather than from a Material breakpoint: the
rail is 96px and each drawer panel is `--m3e-drawer-container-width` = 17.5rem
= 280px (set in `drawerShell`), so both panels open costs 96 + 280 + 280 =
656px of chrome. At 1200px that still leaves ~544px of readable content; below
it, pinning both would crush the content pane to a single word per line (at
960px it would leave ~304px), so below this width `panelsExclusive` lets only
one panel be open at a time.

-}
tocPinBreakpointPx : Int
tocPinBreakpointPx =
    1200


{-| Is the page tree pinned open at this width? Also the default it is restored
to on a route change or on growing past the breakpoint.
-}
treePinsOpen : Int -> Bool
treePinsOpen width =
    width >= drawerSideBreakpointPx


{-| Is the TOC pinned open at this width? (Only relevant on a page that opted
into a TOC — `drawerShell` still gates the `end` slot on non-empty entries.)
-}
tocPinsOpen : Int -> Bool
tocPinsOpen width =
    width >= tocPinBreakpointPx


{-| May only ONE of the two panels be open at this width?

Below `drawerSideBreakpointPx` this is forced on us: `DrawerContainer.willUpdate`
force-closes `start` when `end` opens (and vice versa) whenever the other panel
is not in `side` mode — and it does so WITHOUT dispatching a `change` event, so
Elm cannot learn about it after the fact and has to apply the same rule in its
own handlers or its model silently drifts from the element's.

Between `drawerSideBreakpointPx` and `tocPinBreakpointPx` the element would
happily hold both open, but there is not enough room for a readable content
column, so we enforce exclusivity ourselves. Elm being STRICTER than the
element is safe: it closes the other panel in the same update, so the element
never sees the both-open state it would have corrected.

-}
panelsExclusive : Int -> Bool
panelsExclusive width =
    not (tocPinsOpen width)


type Msg
    = ToggleTree
    | PageChanged
    | ToggleSettings
    | SettingsSheetClosed
    | DrawerChanged Bool Bool
    | ViewportResized Int
    | ToggleToc
    | CloseToc
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
    let
        width : Int
        width =
            initialViewportWidth flags
    in
    ( { treeOpen = treePinsOpen width
      , tocOpen = tocPinsOpen width
      , viewportWidth = width
      , scheme = schemeFromFlags flags
      , seed = "#6750A4"
      , contrast = Value.standard
      , density = 0
      , dir = TypedHtml.Values.ltr
      , settingsOpen = False
      }
    , Effect.none
    )


{-| Open or close the page tree, applying the tree/TOC mutual exclusion
`panelsExclusive` describes. Opening the tree can close the TOC; closing it
never touches the TOC.
-}
setTreeOpen : Bool -> Model -> Model
setTreeOpen open model =
    { model
        | treeOpen = open
        , tocOpen = model.tocOpen && not (open && panelsExclusive model.viewportWidth)
    }


{-| `setTreeOpen`'s mirror image for the TOC panel.
-}
setTocOpen : Bool -> Model -> Model
setTocOpen open model =
    { model
        | tocOpen = open
        , treeOpen = model.treeOpen && not (open && panelsExclusive model.viewportWidth)
    }


{-| Record a new viewport width, re-pinning each panel to its default when — and
only when — the resize CROSSED that panel's breakpoint.

Crossing-only, rather than recomputing from the width every time, is what keeps
an explicit toggle sticky: a user who closes the pinned tree at 1440px keeps it
closed while nudging the window to 1500px. Crossing back up is what makes the
old "stuck closed forever" failure recoverable at all — the `subscriptions`
comment has always promised this; before, `ViewportResized` only stored the
width.

Both defaults are routed through `setTreeOpen`/`setTocOpen` so that widening
from mobile — where the user may have had the TOC open — into the 960-1199 band
cannot leave both panels open at once.

-}
resizeTo : Int -> Model -> Model
resizeTo width model =
    let
        resized : Model
        resized =
            { model | viewportWidth = width }

        afterTree : Model
        afterTree =
            if treePinsOpen width /= treePinsOpen model.viewportWidth then
                setTreeOpen (treePinsOpen width) resized

            else
                resized
    in
    if tocPinsOpen width /= tocPinsOpen model.viewportWidth then
        setTocOpen (tocPinsOpen width) afterTree

    else
        afterTree


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
        ToggleTree ->
            ( setTreeOpen (not model.treeOpen) model, Effect.none )

        -- A route change re-pins both panels to their width's default: closed
        -- on a narrow screen (so a mobile overlay can't survive the navigation
        -- it triggered), open where they belong pinned. `update` cannot see the
        -- INCOMING page's TOC entries, so `tocOpen` is set optimistically and
        -- `drawerShell` still gates the `end` slot on non-empty entries.
        PageChanged ->
            ( { model
                | treeOpen = treePinsOpen model.viewportWidth
                , tocOpen = tocPinsOpen model.viewportWidth
              }
            , Effect.none
            )

        ToggleSettings ->
            ( { model | settingsOpen = not model.settingsOpen }, Effect.none )

        -- The bottom sheet's own `closed` event fires on every element-driven
        -- close (swipe-down, scrim click) that never goes through `ToggleSettings`.
        -- Sync `settingsOpen` back to `False` here so it can't desync Elm (which
        -- would need a double-toggle of `settingsButton` to reopen).
        SettingsSheetClosed ->
            ( { model | settingsOpen = False }, Effect.none )

        -- The `<m3e-drawer-container>` `change` event reports the element's own
        -- `start`/`end` open state (scrim click, Esc, breakpoint auto-close — a
        -- scrim click closes BOTH sides in one event, per `_handleScrimClick` in
        -- `@m3e/web/dist/drawer-container.js`). Synced from both here so an
        -- element-driven close can't desync Elm (which would need a double-tap of
        -- `ToggleTree`/`ToggleToc` to reopen — the first tap would just be
        -- computing the state the element is already in). `event.target.start`/
        -- `.end` are the reflected boolean properties read by `drawerChangeDecoder`.
        --
        -- NOTE this is the element telling us what it already did, so it is the
        -- one place that assigns both fields raw, WITHOUT `setTreeOpen`'s
        -- exclusion rule: whatever combination the element reports is by
        -- definition the truth to sync to.
        DrawerChanged startOpen endOpen ->
            ( { model | treeOpen = startOpen, tocOpen = endOpen }, Effect.none )

        ViewportResized width ->
            ( resizeTo width model, Effect.none )

        ToggleToc ->
            ( setTocOpen (not model.tocOpen) model, Effect.none )

        -- Fired when a TOC jump-link is clicked. Below `drawerSideBreakpointPx`
        -- the panel is a `push`/`over` overlay that holds the content `inert`,
        -- so without this the user would land on the right heading but stay
        -- stuck behind the still-open panel. At or above it the panel is a
        -- `side` panel sitting BESIDE live content, so dismissing it would just
        -- be yanking the TOC away from someone using it — left alone there.
        CloseToc ->
            if treePinsOpen model.viewportWidth then
                ( model, Effect.none )

            else
                ( setTocOpen False model, Effect.none )

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


{-| Watch viewport width so `resizeTo` can re-pin the tree (and, past
`tocPinBreakpointPx`, the TOC) when the user crosses back up from a narrow
window to a wide one. Without this the panels the element auto-closed on the way
DOWN would stay closed on the way back up, since nothing else in the app ever
sets `treeOpen` without a deliberate tap.
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
    in
    { title = View.title pageView
    , body =
        [ M3e.theme
            [ M3e.Theme.color model.seed
            , M3e.Theme.scheme model.scheme
            , M3e.Theme.contrast model.contrast
            , M3e.Theme.density model.density
            , TypedHtml.Attributes.dir model.dir
            , TypedHtml.Attributes.class "background-color: var(--md-sys-color-primary);color: var(--md-sys-color-on-primary);"

            -- The m3e-theme element's `density` prop/attr is NON-reactive, so the
            -- control has no effect unless we drive `--md-sys-density-scale` (which
            -- the m3e components read via density.calc) ourselves. Elm can't set a
            -- CSS custom property directly — `style` uses `node.style[key]=…` which
            -- ignores `--vars`, and `attribute "style"` gets clobbered on re-render —
            -- so it goes through a Tailwind arbitrary-property CLASS instead.
            , TypedHtml.Attributes.class (densityClass model.density)
            ]
            -- `dir` is admissible directly on the `m3e-theme` host because `dir` is
            -- part of the open-row `_globals` axis (elm-cem, elm-typed-html), so the
            -- wrapper div that used to carry the shell classes and `dir` together is
            -- gone — both now live on the host itself.
            (if String.startsWith "/examples/" absolutePath then
                View.body pageView

             else
                [ skipLink
                , TypedHtml.div [ TypedHtml.Attributes.class "h-dvh flex flex-row" ]
                    [ docsNavRail page.path
                    , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-1 flex-col min-w-0" ]
                        [ M3e.mapMsg toMsg (appShellBar (View.toc pageView))
                        , drawerShell toMsg model page sharedData.components (View.toc pageView) (View.body pageView)
                        ]
                    , docsNavBar page.path
                    ]
                , M3e.mapMsg toMsg (settingsBottomSheet model)
                ]
            )
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


{-| The TOC toggle is gated on ONE thing only: whether the page has any TOC
entries. It used to be gated on viewport width as well, because the `end`
panel's visibility was a formula that ignored `tocOpen` on desktop — so the
button would have been a focusable no-op there. Now that `tocOpen` is the
single authority at every width, the button always does something visible:
below `tocPinBreakpointPx` it opens the panel (closing the tree), at or above
it collapses the pinned panel to give the content column its width back.
-}
appShellBar : List View.TocEntry -> Element (M3e.AppBar.Is s) admittedBy Msg
appShellBar tocEntries =
    M3e.appBar
        [ M3e.AppBar.size Value.small
        , M3e.Attributes.id "docs-app-bar"
        ]
        ([ M3e.AppBar.leading
            (M3e.iconButton [ Aria.label "Toggle navigation", M3e.Events.onClick ToggleTree ]
                [ M3e.icon [ M3e.Icon.name "menu" ] [] ]
            )
         , M3e.AppBar.title (M3e.text "elm-m3e")
         , M3e.AppBar.subtitle (M3e.text "Material 3 Expressive for Elm")
         ]
            ++ (if List.isEmpty tocEntries then
                    []

                else
                    [ M3e.AppBar.trailing
                        (M3e.iconButton [ Aria.label "On this page", M3e.Events.onClick ToggleToc ]
                            [ M3e.icon [ M3e.Icon.name "toc" ] [] ]
                        )
                    ]
               )
            ++ [ M3e.AppBar.trailing githubLink
               , M3e.AppBar.trailing settingsButton
               ]
        )


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
which drives the settings bottom sheet's `open` state. (Was a Card popover
trigger, then an end-drawer toggle; the icon is the standard overflow "more"
glyph rather than a gear, matching the sheet's move off the settings-specific
end drawer.)
-}
settingsButton : Element { s | iconButton : M3e.Kind.Brand } admittedBy Msg
settingsButton =
    M3e.iconButton
        [ Aria.label "Settings", M3e.Events.onClick ToggleSettings ]
        [ M3e.icon [ M3e.Icon.name "more_vert" ] [] ]



-- SETTINGS (bottom sheet — cloned from matraic's #settings-drawer, moved off the end drawer)


{-| The settings bottom sheet, toggled open/closed by `settingsButton` via
`model.settingsOpen`. `modal` scrims the page behind it (replacing the end
drawer's `Value.over` overlay behavior); `handle` + `hideable` let a swipe-down
dismiss it the same as clicking the trigger again — that path never goes
through `ToggleSettings`, so `onClosed` syncs `settingsOpen` back to `False`
(see the `SettingsSheetClosed` case in `update`).
-}
settingsBottomSheet : Model -> Element (M3e.BottomSheet.Is s) admittedBy Msg
settingsBottomSheet model =
    M3e.bottomSheet
        [ M3e.Attributes.id "settings-sheet"
        , M3e.BottomSheet.open model.settingsOpen
        , M3e.BottomSheet.handle True
        , M3e.BottomSheet.hideable True
        , M3e.BottomSheet.detents "half full"

        -- NOT `modal`: the library only excludes a trigger from its own
        -- click-outside dismissal when that trigger is wired through its
        -- dedicated `m3e-bottom-sheet-trigger` element (which registers via
        -- `attach()`); `M3e.BottomSheetTrigger`'s content model only admits
        -- `heading`/`sharedText`, not an icon, so it can't hold `settingsButton`'s
        -- glyph. Without that registration, `modal`'s document click-outside
        -- listener treats `settingsButton`'s own opening click as an outside
        -- click and closes the sheet in the same tick it opened — confirmed by
        -- capturing the actual WAAPI animations: every click produced an
        -- open-to-real-height call immediately followed by a close-to-0 call,
        -- non-deterministically racing on which one the final frame kept.
        -- Dropping `modal` removes that listener entirely; `hideable` + the
        -- drag handle still dismiss it, and `settingsButton`/`SettingsSheetClosed`
        -- still own open/close explicitly.
        , M3e.BottomSheet.onClosed SettingsSheetClosed
        ]
        [ settingsSheetContent model ]


{-| The theme controls, rendered into the settings bottom sheet. Built from
library components in the Element world: each control is an `M3e.heading`
label + a control (segmented buttons, or a [`FormField`](M3e-FormField) for
the seed color). The container keeps the typed `role="complementary"`
landmark via `Aria.role`.

All our richer controls are kept (scheme, contrast, seed color, density,
direction); only their LOCATION moved, first from the old Card popover into
an end drawer, and now from that end drawer into this bottom sheet.

-}
settingsSheetContent : Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
settingsSheetContent model =
    TypedHtml.div
        [ TypedHtml.Attributes.id "settings-sheet-content"
        , TypedHtml.Attributes.class "flex flex-col gap-2 py-4"
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
shared id (`"seed-color"`), with the live hex shown as the field hint.
`onInput` is the typed `TypedHtml.Events.onInput`.
-}
seedColorInput : Model -> Element { s | formField : M3e.Kind.Brand } admittedBy Msg
seedColorInput model =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ M3e.FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for "seed-color" ] [ M3e.text "Source color" ])
        , M3e.FormField.hint
            (M3e.heading
                [ M3e.Attributes.variant Value.label
                , M3e.Attributes.size Value.small
                , TypedHtml.Attributes.class "text-on-surface-variant"
                ]
                [ M3e.text model.seed ]
            )
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
            , ( "/guide/cheat-sheet", "Cheat sheet" )
            , ( "/guide/glossary", "Glossary" )
            , ( "/reference", "Full API reference" )
            , ( "/roundtrip", "Round-trip report" )
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


{-| The whole below-app-bar shell: an `m3e-drawer-container` whose `start` panel
is the current section's hierarchical nav-menu, whose `end` panel is the page's
opt-in TOC, and whose default content is the page body. The nav is `NavItem`
links inside `NavMenuItem` groups inside a `NavMenu`.

Both panels' `start`/`end` attributes render `model.treeOpen`/`model.tocOpen`
DIRECTLY. That directness is the fix for the dead-hamburger bug — see
`drawerSideBreakpointPx`. The only qualifier left on `end` is "does this page
have a TOC at all", which cannot collapse into a stuck constant because the TOC
toggle that drives `tocOpen` isn't rendered on a page with no entries either.

`--m3e-drawer-container-width` is narrowed from the library default (22.5rem =
360px) to 17.5rem = 280px, which is what keeps the content column readable once
the 96px rail is also on screen: 280px panels leave ~584px of content at 960px
with one panel open, and ~624px at 1280px with both. See
`tocPinBreakpointPx` for the rest of that budget.

The content pane carries `pb-20` below the Tailwind `md` breakpoint because
`docsNavBar` is `fixed ... bottom-0` there and would otherwise hide the last
~68px of every page behind itself.

-}
drawerShell :
    (Msg -> msg)
    -> Model
    -> { path : UrlPath, route : Maybe Route }
    -> List NavComponent
    -> List View.TocEntry
    -> List (Element childAccepts (M3e.ContentPane.ChildAdmittedBy childAdm) msg)
    -> Element (TypedHtml.Sectioning.MainIs s) admittedBy msg
drawerShell toMsg model page components tocEntries body =
    let
        currentPath : String
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    TypedHtml.main_
        [ TypedHtml.Attributes.id "main-content"
        , TypedHtml.Attributes.class "flex-auto relative mx-auto w-full h-0"
        ]
        [ M3e.drawerContainer
            [ M3e.Attributes.id "docs-drawer"
            , M3e.DrawerContainer.startMode Value.auto
            , M3e.Attributes.start model.treeOpen
            , M3e.DrawerContainer.endMode Value.auto
            , M3e.Attributes.end (model.tocOpen && not (List.isEmpty tocEntries))
            , M3e.Events.onChangeWith (Decode.map toMsg drawerChangeDecoder)
            , TypedHtml.Attributes.class "h-full w-full [--m3e-drawer-container-width:17.5rem]"
            ]
            [ M3e.DrawerContainer.start (navMenu components currentPath)
            , M3e.contentPane
                [ TypedHtml.Attributes.class "m3e-content-pane-container-color-surface-container-lowest"
                , TypedHtml.Attributes.class "overflow-y-auto mx-auto h-full w-full max-w-5xl pb-20 md:p-4 md:pt-1 md:pb-4"
                ]
                body
            , M3e.DrawerContainer.end (tocPanel toMsg tocEntries)
            ]
        ]


{-| The TOC drawer panel: a jump-link per `View.toc` entry. Empty `tocEntries`
means an empty panel, but the `end` attribute above is already `False` in
that case, so `auto`/`side` mode never shows it — this only renders when
there is something to show.

Each link also dispatches `CloseToc` on click — below
`drawerSideBreakpointPx` the `end` drawer is an
`over`/`push` overlay with the page content `inert` while open, so without this
the user would land on the right heading but be stuck behind the still-open
panel (having to dismiss it separately via the scrim). `update`'s `CloseToc`
case is a no-op above that width, where the panel is `side` and dismissing it
would just be taking the TOC away from someone reading it.

`pb-20` matches the content pane's: `docsNavBar` is fixed over the bottom of
the viewport on mobile and would otherwise sit on top of the last jump-links.

-}
tocPanel : (Msg -> msg) -> List View.TocEntry -> Element (TypedHtml.Sectioning.NavIs s) admittedBy msg
tocPanel toMsg tocEntries =
    TypedHtml.nav
        [ Aria.label "On this page", TypedHtml.Attributes.class "flex flex-col gap-2 p-4 pb-20 md:pb-4" ]
        (List.map
            (\entry ->
                TypedHtml.a
                    [ TypedHtml.Attributes.href ("#" ++ entry.id)
                    , TypedHtml.Events.onClick (toMsg CloseToc)
                    ]
                    [ M3e.text entry.label ]
            )
            tocEntries
        )


{-| Decode the `<m3e-drawer-container>` `change` event: `event.target.start`/
`.end` are the reflected boolean properties for the two drawers' open state.
Both are decoded together (not just `start`) because a single scrim click can
close BOTH sides in one `change` event (`_handleScrimClick` sets `this.start`
AND `this.end`, per `@m3e/web/dist/drawer-container.js`) — decoding only
`start` would leave `model.endOpen` desynced from the element after a scrim
dismiss. Change events bubbling up from inner components have a target
without these properties, so the decoder fails and Elm ignores them — exactly
what we want.
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
    M3e.navMenu [ Aria.label "Primary", TypedHtml.Attributes.class "primary-nav-drawer pb-20 md:pb-0" ]
        (List.map (\s -> navGroup currentPath s.icon s.title s.items) navSections
            ++ [ componentsGroup components currentPath ]
        )


{-| The top-level **Components** nav group, holding "All components" (pinned,
matching `/components/all`'s kitchen-sink page) plus one `navGroup` sub-group
per `componentCategories` entry — reusing `navGroup` unmodified, since a
category is exactly "a labelled group of navLeaf items", the same shape
`navGroup` already builds for Getting Started/Guide/Styles/Examples. Only the
category actually holding the current route auto-opens (`navGroup`'s own
`open`-when-current-route-matches logic), so navigating within Components
doesn't force all 7 categories open at once.
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
            :: List.map (categoryGroup components currentPath) componentCategories
        )


{-| One category sub-group within Components — its members, sorted
alphabetically by label (the same sort key the old flat list used, just
applied per-category instead of globally).
-}
categoryGroup : List NavComponent -> String -> ( String, String ) -> Element { s | navMenuItem : M3e.Kind.Brand } admittedBy msg
categoryGroup components currentPath ( category, glyph ) =
    navGroup currentPath
        glyph
        category
        (components
            |> List.filter (\c -> c.category == category)
            |> List.sortBy (\c -> String.toLower c.label)
            |> List.map (\c -> ( "/components/" ++ c.slug, c.label ))
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



-- TOP-LEVEL NAV RAIL / NAV BAR


{-| One of the 5 top-level sections the rail/bar switch between. `href` is
where clicking the section navigates to — the section's real landing page
(Guide, Examples) or, for the 3 sections with no landing page yet, its first
real child (see `specs/2026-08-06-nav-rail-migration-design.md`, "Decided
information architecture"). `prefix` is the first URL path segment that
belongs to this section, used only for highlighting which rail/bar item is
current — it is independent of `href` (e.g. Components' `href` is
`/components/button`, but ANY `/components/*` path is "current").
-}
type alias Section =
    { label : String
    , icon : String
    , href : String
    , prefix : String
    }


sections : List Section
sections =
    [ { label = "Getting Started", icon = "rocket_launch", href = "/getting-started/installation", prefix = "getting-started" }
    , { label = "The Guide", icon = "auto_stories", href = "/guide", prefix = "guide" }
    , { label = "Styles", icon = "palette", href = "/styles/color", prefix = "styles" }
    , { label = "Examples", icon = "auto_awesome", href = "/examples", prefix = "examples" }
    , { label = "Components", icon = "widgets", href = "/components/button", prefix = "components" }
    ]


{-| Is this section the one the given route belongs to? Matched on the FIRST
path segment only, so every `/components/*` route (not just `/components/button`
itself) highlights "Components". `UrlPath` is `List String` (`dillonkearns/elm-pages`),
so this is a plain `List.head` check — no string-prefix parsing.
-}
sectionIsCurrent : UrlPath -> Section -> Bool
sectionIsCurrent path section =
    List.head path == Just section.prefix


{-| One rail/bar destination — real `href`-based navigation via `m3e-nav-item`'s
`href` attribute (`config/slots.json`'s `NavItem.actionMap` maps it to elm-pages'
own link handling), not an `onClick`-driven `Msg`. Shared between `docsNavRail`
and `docsNavBar`: both `M3e.NavRail` and `M3e.NavBar` admit `navItem` children
(`config/slots.json`).
-}
railItem : UrlPath -> Section -> Element { s | navItem : M3e.Kind.Brand } admittedBy msg
railItem path section =
    M3e.navItem
        [ M3e.Attributes.href section.href
        , M3e.Attributes.selected (sectionIsCurrent path section)
        ]
        [ M3e.NavItem.icon (M3e.icon [ M3e.Icon.name section.icon ] [])
        , M3e.text section.label
        ]


{-| Desktop: a persistent full-height rail beside the app bar. Hidden below the
`md` breakpoint, where `docsNavBar` takes over — the same Tailwind-class swap
`Route/Examples/Shop.elm`'s own `navRail`/`navBar` pair already uses.
-}
docsNavRail : UrlPath -> Element { s | navRail : M3e.Kind.Brand } admittedBy msg
docsNavRail path =
    M3e.navRail
        [ Aria.label "Sections", TypedHtml.Attributes.class "hidden shrink-0 md:flex" ]
        (List.map (railItem path) sections)


{-| Mobile: a fixed bottom nav bar, replacing the rail below the `md` breakpoint.
-}
docsNavBar : UrlPath -> Element { s | navBar : M3e.Kind.Brand } admittedBy msg
docsNavBar path =
    M3e.navBar
        [ Aria.label "Sections", TypedHtml.Attributes.class "fixed inset-x-0 bottom-0 z-30 md:hidden" ]
        (List.map (railItem path) sections)
