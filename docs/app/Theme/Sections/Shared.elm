module Theme.Sections.Shared exposing (numberStepper, stepperControls)

{-| Widgets shared by the Typography and Shape accordion sections — both
drive a `Theme.Scale.ScaleConfig` through the same Linear/Modular/Bump/Power
mode-dependent set of numeric steppers, differing only in which `Msg`
constructor wraps the resulting `Theme.TypeScaleParam` (`SetTypeScaleParam`
for Typography, `SetShapeScaleParam` for Shape — both share the same
`Theme.TypeScaleParam` type).
-}

import M3e exposing (Element)
import M3e.Icon
import Theme exposing (TypeScaleParam)
import Theme.Scale as Scale exposing (ScaleConfig)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping


{-| Only the fields relevant to the active mode are meaningfully editable —
Linear uses `factor`, Modular uses `ratio`+`base`, Bump uses `bump`, Power
uses `exponent`+`base`.
-}
stepperControls : (TypeScaleParam -> Float -> msg) -> ScaleConfig -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
stepperControls toMsg config =
    case config.mode of
        Scale.Linear ->
            TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
                [ numberStepper "Factor" config.factor 0.05 (toMsg Theme.Factor) ]

        Scale.Modular ->
            TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
                [ numberStepper "Ratio" config.ratio 0.01 (toMsg Theme.Ratio)
                , numberStepper "Base (rem)" config.base 0.05 (toMsg Theme.Base)
                ]

        Scale.Bump ->
            TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
                [ numberStepper "Bump (rem)" config.bump 0.05 (toMsg Theme.Bump) ]

        Scale.Power ->
            TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
                [ numberStepper "Exponent" config.exponent 0.05 (toMsg Theme.Exponent)
                , numberStepper "Base (rem)" config.base 0.05 (toMsg Theme.Base)
                ]


numberStepper : String -> Float -> Float -> (Float -> msg) -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
numberStepper labelText current step_ toMsg =
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-1" ]
        [ M3e.text labelText
        , M3e.iconButton
            [ TypedHtml.Events.onClick (toMsg (current - step_))
            , Aria.label ("Decrease " ++ labelText)
            ]
            [ M3e.icon [ M3e.Icon.name "remove" ] [] ]
        , M3e.text (String.fromFloat current)
        , M3e.iconButton
            [ TypedHtml.Events.onClick (toMsg (current + step_))
            , Aria.label ("Increase " ++ labelText)
            ]
            [ M3e.icon [ M3e.Icon.name "add" ] [] ]
        ]
