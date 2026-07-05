module BuildShapeNegative exposing (main)

{-| Negative type-behavior test for ⑤ Build shape.

Each function below MUST FAIL to compile with a TYPE MISMATCH.

Coverage:
  - Double-apply of optional-singular attr (Available/Used).
  - Missing required-multi on the ROOT builder (attempting .build).
  - Wrong-kind child in a kinded slot.
-}

import Html
import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Radio as Radio
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as SelectSlots
import M3e.Value
import Kit


{-| Double-apply of variant: Available/Used mismatch.

The first call transitions `variant : Available` to `variant : Used`. The
second call requires `variant : Available` but sees `variant : Used` —
TYPE MISMATCH at the (|>) pipe.
-}
doubleVariant =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.variant M3e.Value.tonal    -- FAILURE
        |> Button.build


{-| Missing required-multi: TYPE MISMATCH between NotFilled and Filled.

Select.build requires `{ s | unnamed : Filled }`. The seed starts with
`unnamed : NotFilled` and no slot call was made — the row does not
satisfy the Filled constraint.
-}
missingRequiredMulti =
    Select.select
        |> Select.build    -- FAILURE: unnamed : NotFilled but .build wants Filled


{-| Wrong-kind child in kinded slot: Radio into Select's option-only slot.

SelectSlots.option demands a Builder whose kind tag includes `option`. Radio.radio
carries `radio` — TYPE MISMATCH on the Builder kind phantom.
-}
wrongKindChild =
    Select.select
        |> SelectSlots.option Radio.radio    -- FAILURE: Radio kind ≠ Option kind


main : Html.Html msg
main =
    Html.text "BuildShapeNegative — should NOT compile"
