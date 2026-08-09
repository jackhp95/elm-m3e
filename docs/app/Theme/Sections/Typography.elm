module Theme.Sections.Typography exposing (view)

{-| The Typography accordion section: display/body font pickers, a
Linear/Modular/Bump/Power scale-mode segmented control, per-mode numeric
steppers, and a live 15-token size preview (`Theme.Tokens.typescaleTokens`).
-}

import M3e exposing (Element)
import M3e.Kind
import Theme exposing (Msg(..))
import Theme.Scale as Scale exposing (ScaleMode)
import Theme.Sections.Shared as Shared
import Theme.Tokens as Tokens
import TypedHtml
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping
import TypedHtml.Select


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ fontSelect "Display font" "display-font" model.displayFont SetDisplayFont
        , fontSelect "Body font" "body-font" model.bodyFont SetBodyFont
        , modeSegmented model.typeScale.mode
        , Shared.stepperControls SetTypeScaleParam model.typeScale
        , preview model
        ]


{-| Reuse a fixed font list rather than free text — matches the reference
site's `<select>`-based font picker. Exact list is a design call; start with
this set (common Google Fonts pairings) and let Jack extend it during manual
review.
-}
availableFonts : List String
availableFonts =
    [ "Roboto", "Roboto Flex", "Roboto Serif", "Roboto Mono", "Inter", "Newsreader", "Space Grotesk", "JetBrains Mono" ]


fontSelect : String -> String -> String -> (String -> Msg) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
fontSelect labelText idSuffix current toMsg =
    let
        inputId : String
        inputId =
            "font-select-" ++ idSuffix
    in
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-2" ]
        [ TypedHtml.label [ TypedHtml.Attributes.for inputId ] [ M3e.text labelText ]
        , TypedHtml.Select.select
            [ TypedHtml.Attributes.id inputId, TypedHtml.Events.onInput toMsg ]
            (List.map
                (\font ->
                    TypedHtml.Select.option
                        [ TypedHtml.Select.value font, TypedHtml.Select.selected (font == current) ]
                        [ M3e.text font ]
                )
                availableFonts
            )
        ]


{-| A `Theme.segmented` control (the shared segmented-button helper also used
for the Scheme control in `Theme.elm`) — its `ButtonSegment`s already carry
their own accessible name from the visible label text, matching the rest of
the app's convention for this control shape.
-}
modeSegmented : ScaleMode -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
modeSegmented current =
    Theme.segmented
        (List.map
            (\mode -> ( Scale.modeToString mode |> Theme.capitalize, mode == current, SetTypeScaleMode mode ))
            [ Scale.Linear, Scale.Modular, Scale.Bump, Scale.Power ]
        )


preview : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
preview model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        (List.map
            (\token ->
                TypedHtml.div
                    [ TypedHtml.Attributes.class ("[font-size:" ++ String.fromFloat (Scale.compute model.typeScale token) ++ "rem]") ]
                    [ M3e.text token.label ]
            )
            Tokens.typescaleTokens
        )
