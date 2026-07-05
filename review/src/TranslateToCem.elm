module TranslateToCem exposing (rule)

{-| D6 codegen-aware translator — target ② `M3e.Cem.<Comp>` (CEM-typed attrs,
Html children).

Currently emits via whole-node Seam escape for all non-Cem sources; Task
11–12 will replace with a dedicated Cem emitter.

Opt-in per project:

    TranslateToCem.rule M3e.Review.Facts.facts

@docs rule

-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Cem }
