module Theme.Sections.Typography exposing (view)

{-| The Typography accordion section: display/body font pickers (real
`m3e-select`s), a Linear/Modular/Bump/Power scale-mode segmented control,
and per-mode numeric steppers.
-}

import Json.Decode as Decode
import M3e exposing (Attr, Element)
import M3e.Attributes
import M3e.Component.Option
import M3e.Component.Select
import M3e.Events
import Theme exposing (Msg(..))
import Theme.Fonts
import Theme.Sections.Shared as Shared
import TypedHtml
import TypedHtml.Attributes
import TypedHtml.Grouping


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ fontSelect "Display font" "display-font" model.displayFont SetDisplayFont
        , fontSelect "Body font" "body-font" model.bodyFont SetBodyFont
        , Shared.modeSegmented SetTypeScaleMode model.typeScale.mode
        , Shared.stepperControls SetTypeScaleParam model.typeScale
        ]


{-| One font picker, an `m3e-select` of `m3e-option`s drawn from
`Theme.Fonts.curatedFonts`. The selected family is read from the `change`
event's `target.value` via `M3e.Events.onChangeWith` (the select binding's
plain `onChange` carries no value). Picking a font fires `SetDisplayFont` /
`SetBodyFont`, which loads the webfont AND applies it globally.
-}
fontSelect : String -> String -> String -> (String -> Msg) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
fontSelect labelText idSuffix current toMsg =
    let
        inputId : String
        inputId =
            "font-select-" ++ idSuffix

        options : List (Element M3e.Component.Select.Content (M3e.Component.Select.ChildAdmittedBy childAdm) Msg)
        options =
            List.map
                (\font ->
                    M3e.Component.Option.component { content = M3e.text font } [ M3e.Component.Option.value font, M3e.Component.Option.selected (font == current) ] []
                )
                Theme.Fonts.curatedFonts

        selectAttrs : List (Attr M3e.Component.Select.Attrs Msg)
        selectAttrs =
            [ M3e.Attributes.id inputId
            , M3e.Events.onChangeWith
                (Decode.map toMsg (Decode.at [ "target", "value" ] Decode.string))
            ]
    in
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center justify-between gap-2" ]
        [ TypedHtml.label [ TypedHtml.Attributes.for inputId ] [ M3e.text labelText ]
        , case options of
            first :: rest ->
                M3e.Component.Select.component { content = first } selectAttrs rest

            [] ->
                -- Select's `el` is required-record (`content`, one Element); the
                -- curated font list is always non-empty, so this is unreachable.
                M3e.Component.Select.component { content = M3e.Component.Option.component { content = M3e.text "" } [] [] } selectAttrs []
        ]
