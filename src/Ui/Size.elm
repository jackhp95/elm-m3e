module Ui.Size exposing (Size(..))

{-| A small shared size scale for `Ui.*` builders that expose one.

Each component maps a `Size` to its own element's size attribute; the
mapping lives in the component (different elements name their sizes
differently), so there is no stringly-typed conversion here.

@docs Size

-}


{-| A shared three-step size scale.
-}
type Size
    = Small
    | Medium
    | Large
