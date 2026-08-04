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
    [ -- Escapes stay corralled (docs/DESIGN.md §4, #81). The userland `Seam` module
      -- this rule used to fence is gone: the library now generates the escape
      -- surface itself, per brand, so the rule fences THAT instead. Anything not
      -- listed must compose out of typed producers.
      --
      -- Allowed holders, and why each earns it:
      --   `Doc` / `Doc.Slider` — the doc-rendering adapters. Markdown, syntax
      --     highlighting and a `<slide-panels>` custom element have no typed
      --     producer, and centralising them here is the whole point of the module.
      --   `Shared` — the app-shell root; raw `Html` chrome and the render exit.
      --   `View` — the page boundary. `View.body` is the app's single re-assertion
      --     of phantom rows onto an erased `Node` (see `View.elm`).
      --   `Route.Examples.Shop` — one `recast`, because `AppBar.TrailingSlot`
      --     genuinely does not admit a Badge. Documented at the call site.
      --   `Route.Guide.*` — pedagogical: these pages' teaching subject IS the
      --     escape surface, shown inline as live examples. Same spirit as the
      --     Guide barrel/setter exemptions in ReviewConfig.
      NoSeamOutsideAllowedModules.rule
        { seamModules =
            [ "M3e.Unsafe"
            , "M3e.Unsafe.Attributes"
            , "TypedHtml.Unsafe"
            , "TypedHtml.Unsafe.Attributes"
            ]
        , allowedModules =
            [ "Doc"
            , "Shared"
            , "View"
            , "Route.Examples.Shop"
            , "Route.Guide"
            ]
        }

    -- The opaque-IR `*.Internal` boundary (docs/DESIGN.md §4): only generated brand
    -- code may import an interior module. Userland has no business here at all now
    -- — the generated `*.Unsafe` modules are the sanctioned crossings, and they
    -- live inside the brand.
    , NoInternalImportOutsideAllowed.rule [ "M3e", "TypedHtml", "HtmlIr" ]
    ]
