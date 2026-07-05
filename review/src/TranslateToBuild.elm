module TranslateToBuild exposing (rule)

{-| D6 codegen-aware translator — target ⑤ `M3e.Build.<Comp>` (phantom-typed
pipeline; dup-singular structurally unwritable).

Currently emits via whole-node Seam escape for all non-Build sources; Task
11–12 will replace with a dedicated Build emitter (seed + setter pipeline +
`|> build`). Note: ⑤ has no attr-list seam, so any dynamic-tail or
lossy-token piece necessarily triggers whole-node escape.

Opt-in per project:

    TranslateToBuild.rule M3e.Review.Facts.facts

@docs rule

-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Build }
