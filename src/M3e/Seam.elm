module M3e.Seam exposing (Label, Link, Text)

{-| GENERATED — public **contract types** for the config-declared semantic
seams (ADR 0014 §1). Each names the phantom row a seam's content carries, so
a team's coupler in the designated `Seam` module can give its producer a
precise type. The matching **stampers** are crossings and live in the fenced
`M3e.Seam.Internal`. Do not edit by hand; regenerate via `bin/elm-cem.js`.

@docs Label, Link, Text
-}

import M3e.Seam.Internal as I


{-| Content admitted wherever the `label` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`. -}
type alias Label s msg =
    I.Label s msg


{-| Content admitted wherever the `link` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`. -}
type alias Link s msg =
    I.Link s msg


{-| Content admitted wherever the `text` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`. -}
type alias Text s msg =
    I.Text s msg
