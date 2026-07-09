module M3e.Seam.Internal exposing (Label, Link, Text, label, link, text)

{-| GENERATED — the **stampers** for the config-declared semantic seams
(ADR 0014 §1). Each stamper is a free phantom re-stamp (`Element any msg`
→ the seam's contract row), so it is a crossing and lives here, behind the
`*.Internal` fence — importable only by generated `M3e.*` code and a team's
designated `Seam` module (`NoInternalImportOutsideAllowed`). The public
contract types are re-exposed from `M3e.Seam`. Do not edit by hand;
regenerate via `bin/elm-cem.js`.

@docs Label, Link, Text, label, link, text
-}

import M3e.Element.Internal as Element exposing (Element)
import M3e.Value exposing (Supported)


{-| Contract for the `label` seam: content admitted wherever the `label` slot kind is accepted. -}
type alias Label s msg =
    Element { s | label : Supported } msg


{-| Re-stamp already-composed IR as `label`-kind content — a free phantom assertion (a crossing). -}
label : Element any msg -> Label s msg
label =
    Element.toNode >> Element.fromNode


{-| Contract for the `link` seam: content admitted wherever the `link` slot kind is accepted. -}
type alias Link s msg =
    Element { s | link : Supported } msg


{-| Re-stamp already-composed IR as `link`-kind content — a free phantom assertion (a crossing). -}
link : Element any msg -> Link s msg
link =
    Element.toNode >> Element.fromNode


{-| Contract for the `text` seam: content admitted wherever the `text` slot kind is accepted. -}
type alias Text s msg =
    Element { s | text : Supported } msg


{-| Re-stamp already-composed IR as `text`-kind content — a free phantom assertion (a crossing). -}
text : Element any msg -> Text s msg
text =
    Element.toNode >> Element.fromNode
