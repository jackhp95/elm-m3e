module BuildShapeTest exposing (main)

{-| Positive type-behavior test for ⑤ Build shape (crossbar redesign).

Each function below MUST compile. Failures indicate a broken safety guarantee.

Coverage:
  - Bare seed → build (no setters).
  - Optional-singular attr Available → Used, once.
  - Multiple distinct optional-singular attrs in sequence.
  - Kinded slot + leaf child, no .build on child.
  - Arbitrary slot + leaf child.
  - Arbitrary slot + heterogeneous leaf children.
  - Arbitrary slot + container child fully filled inline.
-}

import Html
import Kit
import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Divider as Divider
import M3e.Build.Option as Option
import M3e.Build.Radio as Radio
import M3e.Build.RadioGroup as RadioGroup
import M3e.Build.RadioGroup.Slots as RadioGroupSlots
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as SelectSlots
import M3e.Value


{-| Bare seed → build. -}
buttonBare =
    Button.button { content = Kit.text "Click me", action = M3e.Action.none }
        |> Button.build


{-| Optional-singular attr applied once. -}
buttonVariant =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.build


{-| A second distinct optional-singular attr applied independently. -}
buttonSize =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.size M3e.Value.small
        |> Button.build


{-| Kinded slot: Option into Select's default slot, no .build on Option. -}
selectWithOption =
    Select.select
        |> SelectSlots.option (Option.option { content = Kit.text "Option A" })
        |> SelectSlots.option (Option.option { content = Kit.text "Option B" })
        |> Select.build


{-| Arbitrary slot: Radio into RadioGroup, no .build on Radio. -}
radioGroupWithRadio =
    RadioGroup.radioGroup
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroup.build


{-| Arbitrary slot with heterogeneous leaf children. -}
radioGroupHeterogeneous =
    RadioGroup.radioGroup
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroupSlots.divider Divider.divider
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroup.build


{-| Arbitrary slot + container child fully filled inline. -}
radioGroupWithFilledSelect =
    RadioGroup.radioGroup
        |> RadioGroupSlots.select
            (Select.select
                |> SelectSlots.option (Option.option { content = Kit.text "Opt" })
            )
        |> RadioGroup.build


main : Html.Html msg
main =
    Html.text "BuildShapeTest — positive compile check only"
