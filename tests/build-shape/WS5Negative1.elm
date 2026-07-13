module WS5Negative1 exposing (main)

{-| WS5 Phase-2 negative: foreign brand (M3e-branded component output) into a
curated shared-text slot → must fail with TYPE MISMATCH.

M3e.Button.view produces `{ s | button : M3e.Kind.Brand }` (the private brand).
Snackbar's unnamed slot requires `{ text : Markup.Kind.Shared }`.
button : M3e.Kind.Brand ≠ text : Markup.Kind.Shared → TYPE MISMATCH.

This proves that M3e-branded non-atom component output cannot silently enter an
atom-curated slot without an explicit coercion (which is WS6 territory).

Note: Kit.text now correctly produces `Markup.Kind.Shared` (it is a proper atom
seam), so it IS admissible in shared:text slots. This test uses a Button view
(a private-brand component) to demonstrate that non-atom content is still rejected.

-}

import Html
import M3e
import M3e.Snackbar


{-| M3e.button produces Element { s | button : M3e.Kind.Brand }.
Snackbar requires Element { text : Markup.Kind.Shared }.
button : M3e.Kind.Brand ≠ text : Markup.Kind.Shared → TYPE MISMATCH.
-}
foreignBrandIntoSharedSlot =
    M3e.Snackbar.view [] [ M3e.button [ M3e.variantFilled ] [] ]



-- FAILURE: button : M3e.Kind.Brand is not text : Markup.Kind.Shared


main : Html.Html msg
main =
    Html.text "WS5Negative1 — should NOT compile"
