module CodegenReviewConfig exposing (config)

{-| The **M3e-specific** rules that accompany the namespace-agnostic,
facts-driven set (which comes from the `jackhp95/elm-review-cem` package). These
encode M3e's own project boundaries and are not part of the generic package.

@docs config

-}

import NoInternalImportOutsideAllowed
import NoSeamOutsideAllowedModules
import Review.Rule exposing (Rule)


{-| The M3e-specific project-discipline rules.
-}
config : List Rule
config =
    [ -- One Seam boundary (docs/DESIGN.md §4, #81). Allowed holders: the reusable
      -- adapters (`Native`, `Layout`, `Kit`) and `Seam` itself, plus the docs
      -- app's own adapters — `Doc` (doc-rendering) and `Shared` (the app-shell
      -- root, already the sole holder of the `Node.toHtml` render exit). Prefixes,
      -- so `Kit` covers `Kit.Surface`/`Kit.Shape`. Feature routes are NOT listed.
      NoSeamOutsideAllowedModules.rule [ "Native", "Layout", "Kit", "Seam", "Doc", "Shared" ]

    -- The opaque-IR `*.Internal` boundary (docs/DESIGN.md §4): only generated `M3e.*`
    -- code and the modules that actually build the crossings (`Seam`, and the
    -- `Native`/`Layout`/`Kit` adapters) may import an interior module. The docs
    -- `Doc`/`Shared` adapters cross through `Seam`, so they need no Internal
    -- import and are deliberately absent here.
    , NoInternalImportOutsideAllowed.rule [ "M3e", "Native", "Layout", "Kit", "Seam" ]
    ]
