module BuildShapeNegative exposing (main)

{-| Negative type-behavior test for ⑤ Build shape.

Each function below MUST FAIL to compile with a TYPE MISMATCH.
The harness runs elm make and expects failure (non-zero exit code).

Both failures appear in a single module so one compilation confirms
both type-level guarantees simultaneously.
-}

import Html
import M3e.Build.Divider as Divider
import M3e.Build.Select as Select
import Kit


{-| Double-apply of inset: TYPE MISMATCH between Available and Used.

The first call transitions `inset : Available` to `inset : Used`. The
second call requires `inset : Available` but sees `inset : Used` —
TYPE MISMATCH at the (|>) pipe.
-}
doubleInset =
    Divider.divider
        |> Divider.inset True
        |> Divider.inset False
        |> Divider.build


{-| Missing required-multi: TYPE MISMATCH between NotFilled and Filled.

Select.build requires `{ s | default : Filled }`. The seed starts with
`default : NotFilled` and no `Select.default` call was made — the row
does not satisfy the Filled constraint.
-}
missingRequiredMulti =
    Select.select
        |> Select.build


main : Html.Html msg
main =
    Html.text "BuildShapeNegative — should NOT compile"
