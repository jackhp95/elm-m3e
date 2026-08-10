module Cem.Facts exposing (Facet(..), Fact)

{-| Minimal facts types used by the generated `M3e.Review.Facts` module.

This lives in-repo so editor tooling can type-check `src/` without requiring the
unpublished `elm-cem-facts` package.

-}


type Facet
    = Standard
    | Record
    | Build


type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    , attrRewrites : List ( String, String )
    , slotRewrites : List ( String, String )
    , slotKinds : List ( String, List String )
    , slotUpgrades : List ( String, String )
    , groupConstructors : List String
    , facets : List Facet
    , requiredAttrs : List String
    , actionMap : List ( String, String )
    , usesAction : Bool
    }
