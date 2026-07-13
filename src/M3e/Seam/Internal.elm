module M3e.Seam.Internal exposing (Label, Link, Text, label, link, text)

{-| The **stampers** for the library's semantic seams. Each stamper is a free
phantom re-stamp (`Element any msg` → the seam's contract row), so it is a
crossing and lives here, behind the `*.Internal` fence — importable only by
generated `M3e.*` code and a team's designated `Seam` module
(`NoInternalImportOutsideAllowed`). The public contract types are re-exposed
from `M3e.Seam`.

@docs Label, Link, Text, label, link, text

-}

import Markup.Element.Internal as Element exposing (Element)
import Markup.Kind


{-| Contract for the `label` seam: content admitted wherever the `label` slot kind
(`shared:label`) is accepted. Carries `Markup.Kind.Shared` so cross-library
atom producers satisfy it without a crossing.
-}
type alias Label s msg =
    Element { s | label : Markup.Kind.Shared } msg


{-| Re-stamp already-composed IR as `label`-kind content — a free phantom assertion (a crossing).
-}
label : Element any msg -> Label s msg
label =
    Element.toNode >> Element.fromNode


{-| Contract for the `link` seam: content admitted wherever the `link` slot kind
(`shared:link`) is accepted. Carries `Markup.Kind.Shared` so cross-library
atom producers satisfy it without a crossing.
-}
type alias Link s msg =
    Element { s | link : Markup.Kind.Shared } msg


{-| Re-stamp already-composed IR as `link`-kind content — a free phantom assertion (a crossing).
-}
link : Element any msg -> Link s msg
link =
    Element.toNode >> Element.fromNode


{-| Contract for the `text` seam: content admitted wherever the `text` slot kind
(`shared:text`) is accepted. Carries `Markup.Kind.Shared` so cross-library
atom producers satisfy it without a crossing.
-}
type alias Text s msg =
    Element { s | text : Markup.Kind.Shared } msg


{-| Re-stamp already-composed IR as `text`-kind content — a free phantom assertion (a crossing).
-}
text : Element any msg -> Text s msg
text =
    Element.toNode >> Element.fromNode
