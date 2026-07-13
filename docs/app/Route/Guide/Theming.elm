module Route.Guide.Theming exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/theming`): theming an elm-m3e app the Material way —
one root `M3e.Theme` fed a seed color plus scheme / contrast / density, the
derived `--md-sys-*` token roles, dark and dynamic color as swaps not stylesheets,
a worked brand re-skin, and the layout-only Tailwind boundary. The governing
principle is "re-skin with tokens, don't restyle with class overrides", which the
`NoProprietaryDsClasses` rule enforces mechanically. Deep color-system theory
(tonal palettes, dynamic-color derivation) lives in the m3e-okf knowledge base;
this page is the Elm/`M3e.Theme` practice.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Layout
import Markup.Element as Element
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildNoState { view = view }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.svg" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Theme an elm-m3e app the Material way: one root M3e.Theme fed a seed color plus scheme, contrast, and density derives every --md-sys-* role. Re-skin with tokens, don't restyle with class overrides."
        , locale = Nothing
        , title = "Theming with tokens · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Theming with tokens · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Theming with tokens"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.sectionHeading "One theme at the root"
                        , Doc.markdown rootBody
                        , Doc.code_ Doc.Elm rootCode
                        , Doc.markdown rootNote
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.sectionHeading "Paint with roles, not hex"
                        , Doc.markdown rolesBody
                        , Doc.code_ Doc.Elm rolesCode
                        , Doc.markdown tokenFamilies
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.sectionHeading "Dark and dynamic color are swaps"
                        , Doc.markdown darkBody
                        , Doc.code_ Doc.Elm darkCode
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.sectionHeading "A brand re-skin, end to end"
                        , Doc.markdown reskinBody
                        , Doc.code_ Doc.Elm reskinCode
                        , Doc.markdown reskinNote
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.sectionHeading "The Tailwind bridge: layout only"
                        , Doc.markdown bridgeBody
                        , Doc.code_ Doc.Elm bridgeCode
                        ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Material 3 theming is *token-driven*. You do not hand-author a palette: you give the system a small number of inputs — one seed color, a scheme, a contrast, a density — and it derives the full set of color roles (primary, secondary, tertiary, their containers, the surface ramp, outline, error…) as `--md-sys-*` CSS custom properties. Every `@m3e/web` component reads those tokens, so styling the whole app is a matter of setting the inputs once and reaching for roles, never raw colors.

For the neutral *theory* — how dynamic color derives a tonal palette from a single seed, what the tonal system and the type scale are, why design tokens decouple intent from value — read the **m3e-okf knowledge base** (`github.com/jackhp95/m3e-okf`), pages `styles/color`, `styles/typography`, and `foundations/design-tokens`. This guide is the Elm-specific how-to: the `M3e.Theme` component and the practice that keeps a theme a theme."""


rootBody : String
rootBody =
    """Wrap the app — or any subtree — in `M3e.Theme.view`. It is a non-visual element: it emits no box of its own, it just publishes the derived token roles to everything nested inside it. The docs app themes once, at the root, in `docs/app/Shared.elm`:"""


rootCode : String
rootCode =
    """import M3e.Theme as Theme

Theme.view
    [ Theme.color model.seed                    -- the brand/seed color, e.g. "#4285F4"
    , Theme.scheme (schemeToken model.scheme)   -- M3e.Token.light | M3e.Token.dark
    , Theme.contrast (contrastToken model.contrast) -- standard | medium | high
    , Theme.density model.density               -- 0 (default) down to -3 (compact)
    ]
    [ appBody ]"""


rootNote : String
rootNote =
    """Those four inputs are the whole surface most apps need. `Theme` also carries `strongFocus` (strengthen the focus ring — an accessibility aid, see [Accessibility](/guide/accessible-by-construction)), `variant` (the dynamic-color scheme flavor), and `motion` (`M3e.Token.standard` for functional transitions, `M3e.Token.expressive` for spring-like emphasis — see [Motion](/guide/motion)). Set the theme once and inherit it; you rarely nest a second `Theme`, and when you do it is a deliberate island (a preview swatch, an inverted hero) — not a way to patch one component's color."""


rolesBody : String
rolesBody =
    """Inside a themed subtree, never paint with a hex value. Reach for the **role** the element plays. A primary action is `primary`; text on a surface is `onSurface`; de-emphasized text is `onSurfaceVariant`. The role keeps its contrast correct against whatever surface it sits on — automatically, and in both light and dark — because both sides of the pair (`surface`/`onSurface`) are derived together from the same seed. In the docs Kit these are helpers:"""


rolesCode : String
rolesCode =
    """-- A selected row is a surface-ROLE swap, not a background class:
Surface.view Surface.surfaceContainer [ … ] rows   -- container role, correct tint + elevation
Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text "Secondary text" ]
Kit.textLink href [ Kit.primary ] [ Kit.text "Primary action" ]

-- WRONG — a raw color, decoupled from the scheme, wrong in dark mode:
Layout.div "bg-[#4285F4] text-white" children"""


tokenFamilies : String
tokenFamilies =
    """**The `--md-sys-*` families.** A seed derives, per scheme, families like: `--md-sys-color-*` (the role palette — `primary`, `on-primary`, `primary-container`, the `surface`/`surface-container-*` ramp, `outline`, `error`, `scrim`, `surface-tint`), `--md-sys-typescale-*` (the type scale — display/headline/title/body/label at large/medium/small), `--md-sys-shape-corner-*` (the corner scale), `--md-sys-elevation-*`, `--md-sys-motion-*`, and `--md-sys-state-*`. You almost never write these names by hand — the Kit color/typography/shape helpers and the component variants resolve to them — but knowing the families is how you read a computed style and recognize what a component is honoring."""


darkBody : String
darkBody =
    """Dark mode is **not** a second stylesheet. It is one input flipped: `Theme.scheme` between `M3e.Token.light` and `M3e.Token.dark`. The docs app holds `scheme` in its `Shared.Model` and toggles it; the whole role palette re-derives for the new scheme and every component follows. Dynamic color is the same move on a different input: change `Theme.color` and the entire palette re-derives from the new seed — no per-role editing anywhere. Contrast is orthogonal (`standard` / `medium` / `high`) for readers who need it."""


darkCode : String
darkCode =
    """-- Light/dark is one input, held in the model and flipped:
Theme.scheme (if model.dark then M3e.Token.dark else M3e.Token.light)

-- Dynamic color is one input too — a new seed re-derives every role:
Theme.color model.brandSeed"""


reskinBody : String
reskinBody =
    """Put it together. Suppose a brand refresh: a new accent color, a slightly softer corner language, a touch more compactness. In a token-driven system that is a handful of `Theme` inputs and one shape default — not a sheet of overrides. Nothing in the views changes, because the views only ever named roles:"""


reskinCode : String
reskinCode =
    """-- Before: the default seed, standard density, default corners.
Theme.view
    [ Theme.color "#4285F4"
    , Theme.scheme M3e.Token.light
    , Theme.density 0
    ]
    [ appBody ]

-- After: a brand re-skin. New seed re-derives the ENTIRE palette;
-- density and corner language shift globally. appBody is untouched.
Theme.view
    [ Theme.color "#6750A4"          -- brand accent — every role re-derives
    , Theme.scheme M3e.Token.light
    , Theme.contrast M3e.Token.medium -- a touch more contrast for the new palette
    , Theme.density -1                -- slightly more compact
    ]
    [ appBody ]                        -- shapes: set the corner default in the Kit,
                                       -- e.g. Kit.Shape.corner Shape.large per surface"""


reskinNote : String
reskinNote =
    """That is the entire re-skin. Because every view named a role (`primary`, `onSurface`, `surfaceContainer`) and every corner came through `Kit.Shape`, the new seed and density reach every screen at once. There is nothing to find-and-replace, and no screen can drift from the brand because no screen ever hard-coded a brand value."""


bridgeBody : String
bridgeBody =
    """Utility CSS (Tailwind, in the docs app) is legitimate — for **layout only**: flex, grid, gap, padding, positioning, responsive visibility. It must never set a visual token. If you find yourself writing a class to change a color, a corner, or an elevation, the right move is a token: a color role, `Kit.Shape.corner`, or a `Theme` input. This boundary is enforced mechanically — the repo-local `NoProprietaryDsClasses` rule flags design-system class tokens in a `class` literal — and it is the same rule that keeps [layouts](/guide/composition-text-field) honest."""


bridgeCode : String
bridgeCode =
    """-- GOOD: layout via utility classes; surface + shape + color via Kit/components.
Surface.view Surface.surfaceContainer
    [ Shape.corner Shape.large, Layout.class "overflow-hidden flex flex-col" ]
    rows

-- WRONG: a class doing a visual (color/shape) job — flagged, and wrong in dark.
Native.div "rounded-3xl bg-primary-container p-4" rows"""


recap : String
recap =
    """- Theme **once, at the root**: `M3e.Theme.view` fed a **seed color plus scheme / contrast / density** derives every `--md-sys-*` role.
- **Paint with roles, not hex** — `primary`, `onSurface`, `surfaceContainer` keep contrast correct in light *and* dark automatically.
- **Dark = flip `scheme`; dynamic = swap `color`.** One input, whole palette re-derives — never a second stylesheet.
- A **brand re-skin is a few `Theme` inputs**, not a sheet of overrides — views untouched because they named roles.
- **Re-skin with tokens, don't restyle with classes** — Tailwind is layout-only, and `NoProprietaryDsClasses` makes it mechanical.
- Deep color-system theory lives in **m3e-okf** (`styles/color`, `foundations/design-tokens`); this page is the Elm practice."""
