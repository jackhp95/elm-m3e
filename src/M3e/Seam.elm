module M3e.Seam exposing (Label, Link, Text)

{-| Public **contract types** for the library's semantic seams. Each names the
kind of content a seam carries — a text, a link, or a label — so your own
adapter in the designated `Seam` module can give what it produces a precise
type. The matching constructors live in `M3e.Seam.Internal`.

@docs Label, Link, Text

-}

import M3e.Seam.Internal as I


{-| Content admitted wherever the `label` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`.
-}
type alias Label s msg =
    I.Label s msg


{-| Content admitted wherever the `link` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`.
-}
type alias Link s msg =
    I.Link s msg


{-| Content admitted wherever the `text` seam kind is accepted. The matching stamper is a crossing in
`M3e.Seam.Internal`.
-}
type alias Text s msg =
    I.Text s msg
