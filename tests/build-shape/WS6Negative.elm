module WS6Negative exposing (main)

{-| WS6 Phase-4 negative: arbitrary unblessed cross-brand (no recast, no coercion)
→ must fail with TYPE MISMATCH.

A Button element carries `{ button : M3e.Kind.Brand }`.
An Icon slot on Icon-Button requires `{ icon : M3e.Kind.Brand }`.
`button` ≠ `icon` (different record fields in the brand row) → TYPE MISMATCH.

There is no M3e.Coerce function for button→icon (it's not a blessed crossing),
and this test does NOT use recast. The only way to admit a Button into an icon
slot is through recast in an allowed seam module — not here in feature code.

This proves that without an explicit blessing (coercion or recast), arbitrary
cross-brand element usage is rejected by the Elm compiler.

-}

import Html
import M3e.Button
import M3e.IconButton


{-| A Button element carries `{ button : M3e.Kind.Brand }`.
IconButton's icon slot (if it has one) requires a different kind.
Since Button and icon have different kind field names, this crosses brands
without any coercion — TYPE MISMATCH.
-}
buttonIntoIconSlot =
    M3e.IconButton.view [] [ M3e.Button.view [] [] ]



-- FAILURE: button : Brand ≠ icon : Brand (or any icon-typed slot)


main : Html.Html msg
main =
    Html.text "WS6Negative — should NOT compile"
