module ReviewConfig exposing (config)

{-| The elm-review configuration for the `m3e-builder` MISI component library.

The library lives in `src/Ui/*` and wraps the generated `vendor/elm-m3e/M3e/*`
bindings. This config is run from the repo root against the application
`elm.json` (whose `source-directories` are `src` + `vendor/elm-m3e`) with
`docs/node_modules/.bin/elm-review src --config review`.

See `review/README.md` for the rationale behind each rule and every relaxation.

-}

import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeLinks
import NoActionlessButton
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoProprietaryDsClasses
import NoRawAttributeInUi
import NoUntypedSlot
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import PreferBadgeCount
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    List.concat
        [ unused
        , common
        , docs
        , correctness
        , materialDiscipline
        ]


{-| `vendor/elm-m3e/` is generated. Style and documentation rules should not
gate on generated code; correctness rules (`Simplify`, `NoDebug.*`, and the
Material-discipline rules) still run on it.
-}
ignoreVendor : Rule -> Rule
ignoreVendor =
    Rule.ignoreErrorsForDirectories [ "vendor/elm-m3e/" ]



-- UNUSED ---------------------------------------------------------------------


unused : List Rule
unused =
    [ NoUnused.Variables.rule |> ignoreVendor
    , NoUnused.CustomTypeConstructors.rule [] |> ignoreVendor |> ignorePublicApi
    , NoUnused.CustomTypeConstructorArgs.rule |> ignoreVendor
    , NoUnused.Exports.rule |> ignoreVendor |> ignorePublicApi
    , NoUnused.Modules.rule |> ignoreVendor |> ignorePublicApi
    , NoUnused.Parameters.rule |> ignoreVendor
    , NoUnused.Patterns.rule |> ignoreVendor
    ]


{-| A published library's whole point is exports/modules/constructors that are
unused _by itself_ — every `M3e.*` value and every exposed `Variant(..)`-style
constructor exists for consumers we cannot see in this repo.

Reviewing the library in isolation (no docs app, no consuming app) makes
`NoUnused.Exports`, `NoUnused.Modules`, and `NoUnused.CustomTypeConstructors`
fire on the entire public API. We ignore `src/M3e/` for those rules so they
still catch genuinely-dead code in any non-public helper directories while
leaving the public surface alone. (`vendor/` is ignored too — generated
bindings are equally "unused-by-self".) See README §"Relaxed rules".

`NoMissingTypeExpose` is relaxed here for the same directory: each component's
`type alias Option msg = Internal.Option (Config msg) msg` deliberately keeps
`Config` private (the opaque-builder design, ADR 0006), which the rule reads as
a "private type used by an exposed type". Hiding `Config` is the point.

-}
ignorePublicApi : Rule -> Rule
ignorePublicApi =
    Rule.ignoreErrorsForDirectories [ "src/M3e/" ]



-- COMMON ---------------------------------------------------------------------


common : List Rule
common =
    [ NoExposingEverything.rule |> ignoreVendor
    , NoImportingEverything.rule [] |> ignoreVendor
    , NoMissingTypeAnnotation.rule |> ignoreVendor
    , NoMissingTypeAnnotationInLetIn.rule |> ignoreVendor
    , NoMissingTypeExpose.rule |> ignoreVendor |> ignorePublicApi
    , NoConfusingPrefixOperator.rule
    , NoPrematureLetComputation.rule
    ]



-- DOCS -----------------------------------------------------------------------


docs : List Rule
docs =
    [ Docs.ReviewAtDocs.rule |> ignoreVendor
    , Docs.ReviewLinksAndSections.rule |> ignoreVendor
    , Docs.UpToDateReadmeLinks.rule |> ignoreVendor
    ]



-- CORRECTNESS (run on vendor too) --------------------------------------------


correctness : List Rule
correctness =
    [ Simplify.rule Simplify.defaults
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    ]



-- MATERIAL DISCIPLINE (custom MISI rules) ------------------------------------


materialDiscipline : List Rule
materialDiscipline =
    [ PreferBadgeCount.rule
    , NoActionlessButton.rule
    , NoRawAttributeInUi.rule |> ignoreTests
    , NoProprietaryDsClasses.rule
    , NoUntypedSlot.rule |> ignoreTests
    ]


{-| Test modules are named `Ui.*Test` and legitimately reference raw slot/
attribute strings inside `elm-test` selectors (e.g.
`Selector.attribute (Attr.attribute "slot" "title")`), which the Material
rules would otherwise flag. They are not part of the published surface.
-}
ignoreTests : Rule -> Rule
ignoreTests =
    Rule.ignoreErrorsForDirectories [ "tests/" ]
