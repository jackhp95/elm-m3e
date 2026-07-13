module WS5Positive exposing (main)

{-| WS5 Phase-2 positive type-behavior tests.

Each function below MUST compile, proving that shared atoms flow into
curated (shared:text / shared:icon) M3e slots.

Coverage:

  - Markup.Atoms.text into Snackbar (curated shared:text slot) — ACCEPTED.
  - Markup.Atoms.text into Badge (curated shared:text slot) — ACCEPTED.
  - Markup.Atoms.text into Tooltip (curated shared:text slot) — ACCEPTED.

-}

import Html
import M3e.Badge
import M3e.Chip
import M3e.Snackbar
import M3e.Tooltip
import Markup.Atoms


{-| Shared text atom into Snackbar's curated unnamed slot (shared:text).
Snackbar.view :: List (Element { text : Markup.Kind.Shared } msg) → …
Markup.Atoms.text returns Element { s | text : Markup.Kind.Shared } msg → rows unify.
-}
snackbarAcceptsSharedText =
    M3e.Snackbar.view [] [ Markup.Atoms.text "Saved successfully" ]


{-| Shared text atom into Badge's curated unnamed slot (shared:text).
-}
badgeAcceptsSharedText =
    M3e.Badge.view [] [ Markup.Atoms.text "3" ]


{-| Shared text atom into Tooltip's curated unnamed slot (shared:text).
-}
tooltipAcceptsSharedText =
    M3e.Tooltip.view [] [ Markup.Atoms.text "More info" ]


main : Html.Html msg
main =
    Html.text "WS5Positive — positive compile check only"
