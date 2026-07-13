module WS5Negative2 exposing (main)

{-| WS5 Phase-2 negative: Chip into a button slot without coercion → must fail
with TYPE MISMATCH.

M3e.Chip.view produces Element { s | chip : M3e.Kind.Brand }.
M3e.SplitButton.leadingButton requires Element { button : M3e.Kind.Brand }.
`chip` ≠ `button` (different record fields in the brand row) → TYPE MISMATCH.

This proves that dual-natured components (Chip) cannot enter brand-segregated
container slots without an explicit blessed coercion — which is scheduled for WS6.

-}

import Html
import M3e.Chip
import M3e.SplitButton


{-| A Chip element carries `{ chip : M3e.Kind.Brand }` in its output kind row.
SplitButton.leadingButton requires `{ button : M3e.Kind.Brand }`.
The `chip` field does not satisfy the `button` constraint → TYPE MISMATCH.
-}
chipIntoButtonSlot =
    M3e.SplitButton.view []
        [ M3e.SplitButton.leadingButton (M3e.Chip.view [] []) ]



-- FAILURE: chip : Brand ≠ button : Brand


main : Html.Html msg
main =
    Html.text "WS5Negative2 — should NOT compile"
