module BuildShapeTest exposing (main)

{-| Positive type-behavior test for ⑤ Build shape.

Each function below MUST compile. If any of them fails to compile, the
Build shape's type-safety guarantee is broken.

Components used:
  - Divider   — SlotCaps = {} so build works without slot args; has
                optional-singular attr setters (inset, vertical, etc.).
  - Select    — has a required-multi default slot (NotFilled → Filled ratchet)
                and optional-singular slot caps (arrow, value).
  - Option    — SlotCaps = {} so build works; produces Element { option : … }
                which satisfies Select.default's slot constraint.
-}

import Html
import M3e.Build.Divider as Divider
import M3e.Build.Option as Option
import M3e.Build.Select as Select
import Kit


{-| Bare seed → build (no optional setters applied).

Proves build works when all optional attrs are skipped.
-}
dividerBare =
    Divider.divider
        |> Divider.build


{-| Optional-singular attr setter applied once — should compile.

Proves the Available → Used transition allows a single application.
-}
dividerWithInset =
    Divider.divider
        |> Divider.inset True
        |> Divider.build


{-| Multiple distinct optional-singular attrs applied — should compile.

Proves independent optional-singular fields can all be set in sequence.
-}
dividerFullyConfigured =
    Divider.divider
        |> Divider.inset True
        |> Divider.vertical True
        |> Divider.build


{-| Required-multi ratchet: exactly one child in Select.

Proves the NotFilled → Filled transition satisfies build's { default : Filled }
constraint. Option.SlotCaps = {} so Option.build works on a bare seed.
-}
selectWithOneOption =
    Select.select
        |> Select.default
            (Option.option { content = Kit.text "Option 1" }
                |> Option.build
            )
        |> Select.build


{-| Required-multi ratchet: multiple children in Select.

Proves the Filled → Filled pass-through works on subsequent calls, and that
build still accepts the fully-filled builder.
-}
selectWithMultipleOptions =
    Select.select
        |> Select.default
            (Option.option { content = Kit.text "Option 1" }
                |> Option.build
            )
        |> Select.default
            (Option.option { content = Kit.text "Option 2" }
                |> Option.build
            )
        |> Select.build


main : Html.Html msg
main =
    Html.text "BuildShapeTest — positive compile check only"
