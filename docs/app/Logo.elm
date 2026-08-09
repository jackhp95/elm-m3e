module Logo exposing (Colors, defaultColors, invertedColors, view)

{-| The tangram mark — two triangles, theme-aware via `--md-sys-color-*`
custom properties. Used as the docs nav-rail's toggle icon (`Shared.elm`)
and as the source-of-truth SVG geometry the favicon generator
(`docs/scripts/icons-gen/tangram-favicon.mjs`) mirrors — keep the two
`d` attribute path strings below in sync with that script's `PATHS`
constant if this geometry ever changes; they can't literally share code
across the Elm/Node boundary.

Not routed through `M3e.Icon`'s named-icon registry — that registry is
built for single-color icon-font-style glyphs, not two independently
fillable paths. Not a generalized `M3e.Logo` library component — this stays
docs-app-scoped per the spec's non-goal (revisit if a second consumer
wants it).

-}

import HtmlIr.Element exposing (Element)
import M3e.Unsafe
import Svg
import Svg.Attributes as SvgAttr


{-| The two triangles' fill colors — `small` is the smaller triangle (the
second `<path>`, which draws the notch), `big` is the larger one (the first
`<path>`, the full corner-to-corner triangle).
-}
type alias Colors =
    { small : String, big : String }


{-| Collapsed/closed nav-rail state, and the favicon's default: both
triangles the same brand-primary color — the plain mark.
-}
defaultColors : Colors
defaultColors =
    { small = "var(--md-sys-color-primary)", big = "var(--md-sys-color-primary)" }


{-| Expanded/open nav-rail state: small triangle inverts to
`inverse-surface`, big triangle to `inverse-primary`, accenting the
"this closes it" affordance.
-}
invertedColors : Colors
invertedColors =
    { small = "var(--md-sys-color-inverse-surface)", big = "var(--md-sys-color-inverse-primary)" }


{-| `Element accepts admittedBy msg` via `M3e.Unsafe.fromHtml` — its FREE
rows mean this type-checks into any slot, including `M3e.Icon`'s
`sharedIcon` kind, without needing `M3e.Unsafe.recast` on top.
-}
view : Colors -> Element accepts admittedBy msg
view colors =
    M3e.Unsafe.fromHtml
        (Svg.svg
            [ SvgAttr.viewBox "0 0 566 566"
            , SvgAttr.fill "none"
            , SvgAttr.class "tangram-mark"
            ]
            [ Svg.path [ SvgAttr.fill colors.big, SvgAttr.d "m0 0 566 566H0z" ] []
            , Svg.path [ SvgAttr.fill colors.small, SvgAttr.d "M566 0v535L299 267.973z" ] []
            ]
        )
