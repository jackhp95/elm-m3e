module TranslateToHtml exposing (rule)

{-| D6 codegen-aware translator — target ① `M3e.Cem.Html.<Comp>` (raw HTML).

Currently emits via whole-node Seam escape for all non-Html sources; Task
11–12 will replace with a dedicated Html emitter that converts enum tokens
back to string literals via `fact.enums`.

Opt-in per project:

    TranslateToHtml.rule M3e.Review.Facts.facts

@docs rule

-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Html }
