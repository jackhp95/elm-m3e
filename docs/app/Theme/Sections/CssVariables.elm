module Theme.Sections.CssVariables exposing (view)

{-| The CSS Variables accordion section (§11): the raw escape hatch. Renders the
non-color `@m3e/web` CSS custom properties (typescale, shape, motion, state) as their
own `m3e-form-field`s, organized into a NESTED `m3e-accordion` by the hierarchy
encoded in the variable names — so a visitor can collapse categories and jump between
them. Color tokens (`md-sys-color-*`) are intentionally excluded: they are managed by
the dedicated Color section, which owns `model.colorOverrides`. Keeping each token
under a single control prevents last-writer-wins conflicts on the shared CSS port.

Grouping: vars are clustered by their first three dash-segments (the Material
sys-category — `md-sys-typescale`, `md-sys-shape`, `md-sys-motion`, `md-sys-state`).
Within each group we compute the longest common segment-prefix and strip it from every
field's LABEL, so labels are short (`corner-value-medium`, `duration-short-1`, …).
Each category is an `m3e-expansion-panel` whose `m3e-heading` header names it; each
field's FULL `--<var>` name is kept as the form-field's supporting text (`hint` slot).

Typing sets the override (`SetCssOverride`, no validation); a trailing clear button
(shown only when overridden) reverts it (`UnsetCssOverride`). Elm cannot READ a live
computed CSS custom property, so an un-overridden field shows an empty input with a
"(default)" placeholder rather than the resolved default. Every write goes through
the `Theme.Ports.setCssOverride` port. Inputs use `field-sizing: content`.

-}

import Dict
import M3e exposing (Element)
import M3e.Action
import M3e.Attributes
import M3e.Component.FormField as FormField
import M3e.Component.Heading
import M3e.Component.Icon
import M3e.Component.IconButton
import M3e.Unsafe
import M3e.Values as Value
import Theme exposing (Msg(..))
import Theme.Tokens as Tokens
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Details
import TypedHtml.Events
import TypedHtml.Grouping


{-| The non-color CSS custom property names (without the `--` prefix): typescale,
shape, motion, and state tokens. Color tokens are excluded — the Color section owns
`model.colorOverrides` and writes those vars; including them here would create a
second, conflicting control for the same CSS custom property.
-}
knownVars : List String
knownVars =
    List.map .cssVar Tokens.typescaleTokens
        ++ List.map .cssVar Tokens.shapeTokens
        ++ List.map .cssVar Tokens.motionDurationTokens
        ++ List.map .cssVar Tokens.stateOpacityTokens


type alias VarGroup =
    { prefix : List String, vars : List String }


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ TypedHtml.p [ TypedHtml.Attributes.class "text-on-surface-variant text-sm" ]
            [ M3e.text "Non-color @m3e/web CSS custom properties (typescale, shape, motion, state), grouped by name hierarchy. Color tokens are in the Color section above. Type a value to override it; clear to revert. (Live default values aren't shown — Elm can't read computed CSS variables.)" ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col" ]
            (List.map (categoryDetails model) (groupVars knownVars))
        ]


{-| One hierarchy category as a native `<details>` disclosure (NOT a nested
`m3e-expansion-panel`): the outer settings drawer is itself an `m3e-accordion`, and
nesting `m3e-expansion-panel`s inside it makes the outer accordion re-coordinate off
the inner panels' bubbling `toggle` events (and its panel query) — collapsing them a
tick after they open. A native `<details>` sidesteps that entirely while staying
collapsible; its `<summary>` carries the substantial `m3e-heading`.
-}
categoryDetails : Theme.Model -> VarGroup -> Element (TypedHtml.Details.DetailsIs s) admittedBy Msg
categoryDetails model group =
    TypedHtml.details [ TypedHtml.Attributes.class "border-b border-outline-variant" ]
        [ TypedHtml.summary [ TypedHtml.Attributes.class "cursor-pointer select-none list-none py-2" ]
            [ M3e.Unsafe.recast
                (M3e.Component.Heading.component { content = M3e.text (categoryLabel group) }
                    [ M3e.Attributes.variant Value.title
                    , M3e.Attributes.size Value.small
                    , M3e.Attributes.level 3
                    ]
                    []
                )
            ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2 pt-2 pb-3" ]
            (List.map (cssVarField model group.prefix) group.vars)
        ]


{-| A humanized heading for a group: the Material sys-category (the third dash
segment of the shared prefix), title-cased.
-}
categoryLabel : VarGroup -> String
categoryLabel group =
    group.prefix
        |> List.drop 2
        |> List.head
        |> Maybe.withDefault (String.join "-" group.prefix)
        |> Theme.capitalize


{-| One CSS custom property as a form field: short label (var name minus the group's
common prefix), the value input, the full `--<var>` name as supporting text (`hint`),
and a trailing clear button when overridden.
-}
cssVarField : Theme.Model -> List String -> String -> Element (FormField.Is s) admittedBy Msg
cssVarField model prefix cssVar =
    let
        current : Maybe String
        current =
            Dict.get cssVar model.cssOverrides

        fieldId : String
        fieldId =
            "cssvar-" ++ cssVar

        shortLabel : String
        shortLabel =
            String.split "-" cssVar
                |> List.drop (List.length prefix)
                |> String.join "-"
                |> (\s ->
                        if String.isEmpty s then
                            cssVar

                        else
                            s
                   )
    in
    M3e.formField [ M3e.Attributes.class "w-max max-w-full" ]
        (FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for fieldId ] [ M3e.text shortLabel ])
            :: FormField.hint
                (TypedHtml.span [ TypedHtml.Attributes.class "font-mono text-xs" ]
                    [ M3e.text ("--" ++ cssVar) ]
                )
            :: TypedHtml.input
                [ TypedHtml.Attributes.id fieldId
                , TypedHtml.Attributes.type_ "text"
                , TypedHtml.Attributes.value (Maybe.withDefault "" current)
                , TypedHtml.Attributes.placeholder "(default)"
                , TypedHtml.Attributes.class "field-sizing-content px-2"
                , TypedHtml.Events.onInput (SetCssOverride cssVar)
                , Aria.label ("Value for --" ++ cssVar)
                ]
                []
            :: (case current of
                    Just _ ->
                        [ FormField.suffix
                            (M3e.Component.IconButton.component
                                { content = M3e.icon [ M3e.Component.Icon.name "close" ] []
                                , ariaLabel = "Clear --" ++ cssVar
                                , action = M3e.Action.none
                                }
                                [ TypedHtml.Events.onClick (UnsetCssOverride cssVar) ]
                                []
                            )
                        ]

                    Nothing ->
                        []
               )
        )



-- HIERARCHY


{-| Cluster vars by their first three dash-segments (the sys-category), preserving
first-seen order, and compute each cluster's longest common segment-prefix.
-}
groupVars : List String -> List VarGroup
groupVars vars =
    let
        categoryOf : String -> String
        categoryOf v =
            String.split "-" v |> List.take 3 |> String.join "-"

        categories : List String
        categories =
            uniqueOrder (List.map categoryOf vars)
    in
    List.map
        (\cat ->
            let
                members : List String
                members =
                    List.filter (\v -> categoryOf v == cat) vars
            in
            { prefix = commonPrefix (List.map (String.split "-") members)
            , vars = members
            }
        )
        categories


{-| Dedupe preserving first-seen order (small lists, so O(n²) is fine).
-}
uniqueOrder : List String -> List String
uniqueOrder list =
    List.foldl
        (\x acc ->
            if List.member x acc then
                acc

            else
                acc ++ [ x ]
        )
        []
        list


{-| The longest common leading run of segments across every var in a group.
-}
commonPrefix : List (List String) -> List String
commonPrefix lists =
    case lists of
        [] ->
            []

        first :: rest ->
            List.foldl common2 first rest


common2 : List String -> List String -> List String
common2 a b =
    case ( a, b ) of
        ( x :: xs, y :: ys ) ->
            if x == y then
                x :: common2 xs ys

            else
                []

        _ ->
            []
