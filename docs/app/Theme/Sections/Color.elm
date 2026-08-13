module Theme.Sections.Color exposing (view)

{-| The Color accordion section (§8): one CHIP per color token, grouped by
`Theme.Tokens.colorGroups` (37 tokens across 9 groups), laid out as a wrapping
cluster. Each chip is a native `<details>` disclosure — the `<summary>` is a
chip-like pill (a leading color-circle swatch + the role label), and expanding
it reveals the value-entry controls (hex text input, OS color picker, Unset).

Using `<details>`/`<summary>` keeps the open/closed state entirely in the DOM,
so there is NO new `Theme.Model` field and NO persisted-state change — only the
existing `colorOverrides` dict drives rendering.

The swatch is an INLINE-STYLED circle, NOT a nested `<m3e-theme>` avatar: the
chip `IconSlot` admits only `sharedIcon` kinds (`M3e/Internal/Types/Chip.elm`),
so the color-circle trick required here is a plain styled element. A SET chip
shows its literal override hex; an UNSET chip shows a neutral placeholder
(outline ring, transparent fill) — Elm cannot read the live computed CSS var
(`Shared.elm` CSS-var constraint), so no live-resolved color is possible.

Design note (friction-logged): the plan's §8 called for an `M3e.chip` with a
`menu` for value entry. The typed-HTML `<summary>` slot rejects branded chip
children (`SummaryContent` has no `chip` field) and `M3e.chip` carries no
`onClick` to act as its own trigger, and the `M3e.menu` family has no
declarative `open`/`for` anchor with any docs precedent. So this uses the
plan's pre-authorized fallback: a `<details>` disclosure with an inline
value-entry panel. The hex/OS-picker/unset ACTIONS are identical to the plan
(they reuse `SetColorOverride`/`ResetColorOverride`).

-}

import Dict
import M3e exposing (Element)
import M3e.Attributes
import M3e.Component.Icon
import Theme exposing (Msg(..))
import Theme.Tokens as Tokens exposing (ColorToken)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Details
import TypedHtml.Events
import TypedHtml.Grouping
import TypedHtml.Sectioning


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        (List.map (groupView model) Tokens.colorGroups)


groupView : Theme.Model -> ( String, List ColorToken ) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
groupView model ( groupName, tokens ) =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        [ TypedHtml.Sectioning.h3 [ TypedHtml.Attributes.class "text-on-surface-variant text-sm" ] [ M3e.text groupName ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-wrap gap-2" ]
            (List.map (tokenChip model) tokens)
        ]


{-| One color token, rendered as a `<details>` chip. The `<summary>` is the
clickable pill; the body holds the value-entry controls.
-}
tokenChip : Theme.Model -> ColorToken -> Element (TypedHtml.Details.DetailsIs s) admittedBy Msg
tokenChip model token =
    let
        current : Maybe String
        current =
            Dict.get token.cssVar model.colorOverrides

        isSet : Bool
        isSet =
            current /= Nothing

        inputId : String
        inputId =
            "color-" ++ token.cssVar

        -- Neutral placeholder for an UNset chip: outline ring, transparent fill
        -- (Elm can't read the live computed var). A set chip shows its literal
        -- override hex.
        swatch =
            TypedHtml.span
                [ TypedHtml.Attributes.class "size-4 rounded-full border border-outline shrink-0"
                , TypedHtml.Attributes.style "background-color" (Maybe.withDefault "transparent" current)
                ]
                []

        pillClass : String
        pillClass =
            if isSet then
                "flex items-center gap-2 rounded-full border border-outline bg-surface-container-high px-3 py-1.5 cursor-pointer select-none list-none"

            else
                "flex items-center gap-2 rounded-full border border-outline px-3 py-1.5 cursor-pointer select-none list-none"
    in
    TypedHtml.details [ TypedHtml.Attributes.class "inline-block" ]
        [ TypedHtml.summary [ TypedHtml.Attributes.class pillClass ]
            [ swatch
            , M3e.text token.role
            ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-2 mt-2 pl-1" ]
            [ TypedHtml.input
                [ TypedHtml.Attributes.type_ "text"
                , TypedHtml.Attributes.placeholder "#RRGGBB"
                , TypedHtml.Attributes.value (Maybe.withDefault "" current)
                , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
                , TypedHtml.Attributes.class "w-24 rounded border border-outline bg-transparent px-2 py-1 text-on-surface"
                , Aria.label ("Hex value for " ++ token.role)
                ]
                []
            , TypedHtml.label
                [ TypedHtml.Attributes.for inputId
                , TypedHtml.Attributes.class "cursor-pointer text-primary text-sm"
                ]
                [ M3e.text "Pick…"
                , TypedHtml.input
                    [ TypedHtml.Attributes.id inputId
                    , TypedHtml.Attributes.type_ "color"
                    , TypedHtml.Attributes.value (Maybe.withDefault "#000000" current)
                    , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
                    , TypedHtml.Attributes.class "sr-only"
                    ]
                    []
                ]
            , M3e.iconButton
                [ M3e.Attributes.disabled (not isSet)
                , Aria.label ("Unset " ++ token.role)
                , TypedHtml.Events.onClick (ResetColorOverride token.cssVar)
                ]
                [ M3e.icon [ M3e.Component.Icon.name "close" ] [] ]
            ]
        ]
