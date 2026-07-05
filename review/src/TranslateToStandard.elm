module TranslateToStandard exposing (rule)

{-| D6 codegen-aware translator — target ③ `M3e.<Comp>` (Standard, the
double-list top shape). Rewrites call sites at any of the other four surfaces
(Html/Cem/Record/Build) to `M3e.<Comp>.view [ attrs ] [ content ]`. Residue
via `Seam.*`.

Opt-in per project: no rule enabled in `ReviewConfig.elm` by default. Enable
by adding to your review config:

    TranslateToStandard.rule M3e.Review.Facts.facts

Per spec 2026-07-05-codegen-aware-translator-design.md §3.

@docs rule

-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Standard }
