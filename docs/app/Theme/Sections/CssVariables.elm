module Theme.Sections.CssVariables exposing (view)

{-| The CSS Variables accordion section (§11): a free-form escape hatch for poking
any `@m3e/web` CSS custom property. One row per currently-set arbitrary override
(from `model.cssOverrides`), plus an "add new" picker. Each row: the token name,
a freeform value input (`SetCssOverride`, no validation — the same permissiveness
the msg already allows), and a trailing X (`UnsetCssOverride`). Kept SEPARATE from
Advanced's 19 curated tokens (spec non-goal: not merged).

Elm cannot set a CSS custom property directly; every value write goes through the
`Theme.Ports.setCssOverride` port (via `SetCssOverride`).

-}

import Dict
import Json.Decode as Decode
import M3e exposing (Element)
import M3e.Attributes
import M3e.Component.Icon
import M3e.Component.Option
import M3e.Events
import Theme exposing (Msg(..))
import Theme.Tokens as Tokens
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping


{-| Known CSS custom property names offered in the picker — the union of the
token lists `Theme.Tokens` already exposes. The curated sections each own a
dedicated panel, but this escape hatch offers the full set so ANY known token
is reachable here too.
-}
knownVars : List ( String, String )
knownVars =
    (Tokens.colorGroups |> List.concatMap Tuple.second |> List.map (\t -> ( t.role, t.cssVar )))
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.typescaleTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.shapeTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.motionDurationTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.stateOpacityTokens


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ TypedHtml.p [ TypedHtml.Attributes.class "text-on-surface-variant text-sm" ]
            [ M3e.text "Set any @m3e/web CSS custom property directly. Pick a variable to add a row, type a value, or clear a row with the X." ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
            (List.map cssVarRow (Dict.toList model.cssOverrides))
        , addRow
        ]


cssVarRow : ( String, String ) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
cssVarRow ( cssVar, value ) =
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-2" ]
        [ TypedHtml.span [ TypedHtml.Attributes.class "font-mono text-sm text-on-surface-variant" ]
            [ M3e.text ("--" ++ cssVar) ]
        , TypedHtml.input
            [ TypedHtml.Attributes.type_ "text"
            , TypedHtml.Attributes.value value
            , TypedHtml.Events.onInput (SetCssOverride cssVar)
            , TypedHtml.Attributes.class "flex-1 rounded border border-outline bg-transparent px-2 py-1 text-on-surface"
            , Aria.label ("Value for " ++ cssVar)
            ]
            []
        , M3e.iconButton
            [ TypedHtml.Events.onClick (UnsetCssOverride cssVar)
            , Aria.label ("Remove override for " ++ cssVar)
            ]
            [ M3e.icon [ M3e.Component.Icon.name "close" ] [] ]
        ]


{-| The "add new" affordance: a select that, on pick, seeds a blank override for
the chosen var (`SetCssOverride cssVar ""` creates the Dict key so a `cssVarRow`
appears for it on the next render). The user then types the value there.
-}
addRow : Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
addRow =
    TypedHtml.div []
        [ M3e.select
            [ M3e.Attributes.id "css-var-add"
            , M3e.Events.onChangeWith
                (Decode.map (\v -> SetCssOverride v "") (Decode.at [ "target", "value" ] Decode.string))
            ]
            (M3e.option [ M3e.Component.Option.value "", M3e.Component.Option.selected True ] [ M3e.text "Add a variable…" ]
                :: List.map
                    (\( lbl, cssVar ) -> M3e.option [ M3e.Component.Option.value cssVar ] [ M3e.text lbl ])
                    knownVars
            )
        ]
