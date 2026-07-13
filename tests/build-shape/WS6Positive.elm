module WS6Positive exposing (main)

{-| WS6 Phase-4 positive type-behavior tests.

Each function below MUST compile, proving that the blessed coercion `M3e.Coerce.asButton`
lets a Chip element enter a button-kinded slot.

Coverage:

  - M3e.Coerce.asButton (M3e.Chip.view …) compiles — the blessed coercion works.
    A Chip carries `{ chip : M3e.Kind.Brand }`; asButton re-brands it to
    `{ button : M3e.Kind.Brand }`, which SplitButton.leadingButton accepts.

-}

import Html
import M3e.Chip
import M3e.Coerce
import M3e.Icon
import M3e.IconButton
import M3e.MenuTrigger
import M3e.SplitButton
import Markup.Atoms


{-| Chip → asButton → leadingButton slot.
Without M3e.Coerce.asButton this would fail with TYPE MISMATCH (see WS5Negative2).
With asButton the Chip element is re-branded from chip:Brand → button:Brand.
M3e.Chip.view takes List attrs → List (Element { text : Markup.Kind.Shared }) → Element { chip : Brand }.
-}
chipAsButtonIntoSplitButton =
    M3e.SplitButton.view []
        [ M3e.SplitButton.leadingButton
            (M3e.Coerce.asButton
                (M3e.Chip.view [] [ Markup.Atoms.text "Edit" ])
            )
        , M3e.SplitButton.trailingButton
            (M3e.IconButton.view []
                [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] []
                , M3e.MenuTrigger.view [ M3e.MenuTrigger.for "split-menu" ] []
                ]
            )
        ]


main : Html.Html msg
main =
    Html.text "WS6Positive — positive compile check only"
