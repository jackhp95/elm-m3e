module TranslateToRecord exposing (rule)

{-| D6 codegen-aware translator — target ④ `M3e.Record.<Comp>` (record +
double-list, compile-time required).

Currently emits via whole-node Seam escape for all non-Record sources; Task
11–12 will replace with a dedicated Record emitter that reconstructs the
required record from `requiredContent` + `requiredAction`.

Opt-in per project:

    TranslateToRecord.rule M3e.Review.Facts.facts

@docs rule

-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Record }
