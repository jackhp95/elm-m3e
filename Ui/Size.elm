module Ui.Size exposing (Size(..), toString)

{-| Shared size tokens for `Ui.*` builders.

Components translate this to their underlying M3e atom's `size` attribute
string.

-}


type Size
    = Small
    | Medium
    | Large


toString : Size -> String
toString size =
    case size of
        Small ->
            "small"

        Medium ->
            "medium"

        Large ->
            "large"
