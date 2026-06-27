module ReviewConfig exposing (config)

{-| The elm-review configuration for the `m3e-builder` MISI component library
and the `docs/` application.

The library lives in `src/M3e/*`; the docs app lives in `docs/app/`. This
config is now run from `docs/` against `docs/elm.json` (whose source-dirs cover
`app`, `docs/src`, `.elm-pages`, `../src`, `../vendor/elm-m3e`) via:

    cd docs && node_modules /. bin / elm - review --config ../review --compiler node_modules/.bin/elm

See `review/README.md` for the rationale behind each rule and every relaxation.

-}

import CognitiveComplexity
import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeLinks
import NoActionlessButton
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoExposingEverything
import NoFunctionOutsideOfModules
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoModuleOnExposedNames
import NoPrematureLetComputation
import NoProprietaryDsClasses
import NoRawAttributeInUi
import NoRedundantlyQualifiedType
import NoSimpleLetBody
import NoUnnecessaryTrailingUnderscore
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
        , codeStyle
        , complexity
        , toHtmlGate
        ]


{-| `vendor/elm-m3e/` is generated. Style and documentation rules should not
gate on generated code; correctness rules (`Simplify`, `NoDebug.*`, and the
Material-discipline rules) still run on it.

Two path forms: `"vendor/elm-m3e/"` (from repo root) and
`"../vendor/elm-m3e/"` (from docs/ when docs/elm.json lists `../vendor/elm-m3e`
as a source directory).

-}
ignoreVendor : Rule -> Rule
ignoreVendor =
    Rule.ignoreErrorsForDirectories [ "vendor/elm-m3e/", "../vendor/elm-m3e/" ]


{-| `.elm-pages/` contains auto-generated routing and metadata. Treat it the
same as vendor — correctness rules still run, style rules do not.
-}
ignoreGenerated : Rule -> Rule
ignoreGenerated rule =
    rule
        |> Rule.ignoreErrorsForDirectories [ "vendor/elm-m3e/", "../vendor/elm-m3e/", ".elm-pages/" ]



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

Two path forms are listed: `"src/M3e/"` (when review runs from the repo root
against root elm.json) and `"../src/M3e/"` (when it runs from `docs/` against
docs/elm.json, which lists `../src` as a source directory). Both must be
present so that the ignore works regardless of working directory.

-}
ignorePublicApi : Rule -> Rule
ignorePublicApi =
    Rule.ignoreErrorsForDirectories [ "src/M3e/", "../src/M3e/" ]



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



-- CODE STYLE -----------------------------------------------------------------


{-| Code-style rules from `jfmengels/elm-review-code-style`.

  - `NoSimpleLetBody` — a let whose body is just a reference to its last
    binding is redundant; the binding can inline directly. Auto-fixable.
  - `NoUnnecessaryTrailingUnderscore` — trailing underscores on names that
    don't shadow anything are noise. Auto-fixable.
  - `NoRedundantlyQualifiedType` — `Set.Set`, `Dict.Dict` etc. can be written
    as just `Set`, `Dict` when the type is already in scope. Auto-fixable.

`NoModuleOnExposedNames` from `sparksp/elm-review-imports` — if a name is
already exposed on import, calling it via the module alias is redundant. Auto-fixable.

All four rules are ignored for generated dirs (vendor + .elm-pages).

-}
codeStyle : List Rule
codeStyle =
    [ NoSimpleLetBody.rule |> ignoreGenerated
    , NoUnnecessaryTrailingUnderscore.rule |> ignoreGenerated
    , NoRedundantlyQualifiedType.rule |> ignoreGenerated
    , NoModuleOnExposedNames.rule |> ignoreGenerated
    ]



-- COGNITIVE COMPLEXITY -------------------------------------------------------


{-| Flag functions with a cognitive complexity score above 15. Study routes
(Rally, Shrine, Crane, Name\_) are intentionally complex; their findings go
into the suppression baseline rather than forcing a refactor. Generated dirs
are ignored.
-}
complexity : List Rule
complexity =
    [ CognitiveComplexity.rule 15 |> ignoreGenerated
    ]



-- toHtml GATE ----------------------------------------------------------------


{-| `M3e.Node.toHtml` is the single escape hatch from the Node IR to Html. It
must only be called from `Shared` (the one place the app assembles a real
Html.Html tree) and from within `M3e.Node` itself (for the recursive traversal).

A violation here means a route or helper is bypassing the IR — that is a real
regression, not legacy debt, and must NOT be suppressed.

The test suite (which lives in `../tests/` relative to docs/elm.json) calls
`Node.toHtml` to produce `Html` values for assertion; those are acceptable.
Because the review is run from `docs/` the path prefix is `../tests/`.

-}
toHtmlGate : List Rule
toHtmlGate =
    [ NoFunctionOutsideOfModules.rule
        [ ( [ "M3e.Node.toHtml" ], [ "Shared", "M3e.Node" ] ) ]
        |> Rule.ignoreErrorsForDirectories [ "../tests/", "tests/" ]
    ]
