module Ui.Field exposing
    ( Field, Variant(..)
    , new
    , withLabelHtml, withVariant, withHint, withError
    , withPrefix, withSuffix, withHideRequiredMarker, withFloatAlways
    , withId, withAttributes
    , view
    )

{-| Typed builder for `<m3e-form-field>` — the Material 3 form-field chrome
(visible label, supporting text / error subscript, prefix / suffix, and the
filled / outlined container) wrapped around **one** control.

`Ui.Field` is a **composable**: the control is bare (a `<m3e-checkbox>`,
`<m3e-switch>`, a native `<input>`, …) and `Ui.Field` supplies the field
presentation around it. The toggle controls — `Ui.Switch`, `Ui.Checkbox`,
`Ui.RadioButton`, `Ui.Slider` — now render bare (their `label` is kept as an
`aria-label`); wrap one in `Ui.Field` when you want a _visible_ label plus
supporting/error text. This is deliberately the inverse of the old behavior
where each control wrapped _itself_ in a form-field — an outlined box around a
switch / checkbox / radio is not standard M3 (see `docs/research/api-friction-log.md`
F7). Controls now render bare by default; reach for `Ui.Field` only when you
genuinely want the labeled-field presentation (text fields always; toggles
rarely).

The `<m3e-form-field>` real surface (CEM): slots `prefix` / `prefix-text` /
`suffix` / `suffix-text` / `hint` / `error`, the **default slot is the
control**, and attributes `variant` (filled | outlined), `float-label`,
`hide-required-marker`, `hide-subscript`. There is **no `label` slot** in the
CEM; `m3e` ships a `<label slot="label" for="…">` in the default slot, which is
what this module emits (it trips the project's strict `validateMarkup` slot
rule but matches upstream).


# Association

The visible `<label for="…">` anchors to the control via a shared `id`. Pass
`withId` (and set the same id on the control via its `withId`), **or** rely on
the auto-derived slug: a control built with the same label text derives the
same `uif-…` id, so the association just works.


# Quick example

    Ui.Field.new "Email"
        |> Ui.Field.withVariant Ui.Field.Filled
        |> Ui.Field.withHint (text "We'll never share it.")
        |> Ui.Field.view
            (Html.input [ Attr.id "uif-email", Attr.type_ "email" ] [])

A toggle in a labeled field (rare — usually a bare control is correct):

    Ui.Field.new "Reduce motion"
        |> Ui.Field.view
            (Ui.Switch.new { label = "Reduce motion", checked = m.rm, onChange = Rm }
                |> Ui.Switch.view
            )


# Type

@docs Field, Variant


# Constructor

@docs new


# Modifiers

@docs withLabelHtml, withVariant, withHint, withError
@docs withPrefix, withSuffix, withHideRequiredMarker, withFloatAlways
@docs withId, withAttributes


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Cem.M3e.FormField



-- TYPES ------------------------------------------------------------------


{-| A form field, built with `new` and configured with `with*` modifiers,
then rendered around a control with `view`.
-}
type Field msg
    = Field (Config msg)


{-| The field's container appearance. Mirrors `m3e-form-field`'s `variant`
(default `Outlined`).
-}
type Variant
    = Filled
    | Outlined


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , labelText : String
    , labelHtml : Maybe (Html msg)
    , variant : Variant
    , hint : Maybe (Html msg)
    , error : Maybe (Html msg)
    , prefix : Maybe (Html msg)
    , suffix : Maybe (Html msg)
    , hideRequiredMarker : Bool
    , floatAlways : Bool
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a field with a visible text label. The label text also seeds the
auto-derived control `id` used for the `<label for>` association.
-}
new : String -> Field msg
new label =
    Field
        { id = Nothing
        , attributes = []
        , labelText = label
        , labelHtml = Nothing
        , variant = Outlined
        , hint = Nothing
        , error = Nothing
        , prefix = Nothing
        , suffix = Nothing
        , hideRequiredMarker = False
        , floatAlways = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Render rich label content instead of the plain text passed to `new`. The
text from `new` is still used to derive the association id.
-}
withLabelHtml : Html msg -> Field msg -> Field msg
withLabelHtml html (Field cfg) =
    Field { cfg | labelHtml = Just html }


{-| Set the container variant (filled / outlined). Default `Outlined`.
-}
withVariant : Variant -> Field msg -> Field msg
withVariant v (Field cfg) =
    Field { cfg | variant = v }


{-| Set the supporting (hint) text shown in the subscript (the `hint` slot) when
the control is valid. Suppressed when an error is present.
-}
withHint : Html msg -> Field msg -> Field msg
withHint html (Field cfg) =
    Field { cfg | hint = Just html }


{-| Set the error text shown in the subscript (the `error` slot) when the
control is invalid. Takes visual precedence over the hint.
-}
withError : Html msg -> Field msg -> Field msg
withError html (Field cfg) =
    Field { cfg | error = Just html }


{-| Render content before the control (the `prefix` slot).
-}
withPrefix : Html msg -> Field msg -> Field msg
withPrefix html (Field cfg) =
    Field { cfg | prefix = Just html }


{-| Render content after the control (the `suffix` slot).
-}
withSuffix : Html msg -> Field msg -> Field msg
withSuffix html (Field cfg) =
    Field { cfg | suffix = Just html }


{-| Hide the required marker that `m3e-form-field` shows for required controls
(maps to the `hide-required-marker` attribute; default shown, i.e. `False`).
-}
withHideRequiredMarker : Bool -> Field msg -> Field msg
withHideRequiredMarker b (Field cfg) =
    Field { cfg | hideRequiredMarker = b }


{-| Float the label always, rather than only when the control has content
(maps to the `float-label` attribute; default `"auto"`, which floats only when
necessary).
-}
withFloatAlways : Bool -> Field msg -> Field msg
withFloatAlways b (Field cfg) =
    Field { cfg | floatAlways = b }


{-| Set an explicit field/association `id`. Set the **same** id on the control
so the `<label for>` resolves. When omitted, the id is slugged from the label.
-}
withId : String -> Field msg -> Field msg
withId id (Field cfg) =
    Field { cfg | id = Just id }


{-| Append caller attributes to the host `m3e-form-field`. Structural
attributes (`variant`, etc.) are emitted **after** these, so callers can't
clobber them.
-}
withAttributes : List (Attribute msg) -> Field msg -> Field msg
withAttributes attrs (Field cfg) =
    Field { cfg | attributes = cfg.attributes ++ attrs }



-- RENDER -----------------------------------------------------------------


{-| Render the field chrome around a (bare) control. The control fills the
form-field's default slot.
-}
view : Html msg -> Field msg -> Html msg
view control (Field cfg) =
    Cem.M3e.FormField.component
        (cfg.attributes ++ structuralAttributes cfg)
        (List.concat
            [ [ labelElement cfg ]
            , slottedMaybe Cem.M3e.FormField.prefixSlot cfg.prefix
            , slottedMaybe Cem.M3e.FormField.suffixSlot cfg.suffix
            , [ control ]
            , subscriptElements cfg
            ]
        )


structuralAttributes : Config msg -> List (Attribute msg)
structuralAttributes cfg =
    List.filterMap identity
        [ Just (Cem.M3e.FormField.variant (toFormFieldVariant cfg.variant))
        , if cfg.hideRequiredMarker then
            Just (Cem.M3e.FormField.hideRequiredMarker True)

          else
            Nothing
        , if cfg.floatAlways then
            Just (Cem.M3e.FormField.floatLabel Cem.M3e.FormField.FloatLabelAlways)

          else
            Nothing
        ]


toFormFieldVariant : Variant -> Cem.M3e.FormField.Variant
toFormFieldVariant v =
    case v of
        Filled ->
            Cem.M3e.FormField.Filled

        Outlined ->
            Cem.M3e.FormField.Outlined


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        [ Attr.attribute "slot" "label"
        , Attr.for (controlId cfg)
        ]
        [ Maybe.withDefault (Html.text cfg.labelText) cfg.labelHtml ]


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    -- Error takes visual precedence over hint when both are set.
    case ( cfg.error, cfg.hint ) of
        ( Just err, _ ) ->
            [ Html.span [ Cem.M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just hint ) ->
            [ Html.span [ Cem.M3e.FormField.hintSlot ] [ hint ] ]

        ( Nothing, Nothing ) ->
            []


slottedMaybe : Attribute msg -> Maybe (Html msg) -> List (Html msg)
slottedMaybe slot maybe =
    case maybe of
        Just content ->
            [ Html.span [ slot ] [ content ] ]

        Nothing ->
            []


{-| The association id: the caller's `withId` if present, else a stable slug
derived from the label — matching the slug controls derive from the same
label, so `<label for>` resolves without explicit ids.
-}
controlId : Config msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.labelText


{-| Deterministic, override-friendly id derived from label text. MUST match the
`slugify` used by the controls (Switch / Checkbox / Slider / RadioButton) so
the auto-derived association works.
-}
slugify : String -> String
slugify label =
    let
        slug : String
        slug =
            label
                |> String.toLower
                |> String.toList
                |> List.map
                    (\c ->
                        if Char.isAlphaNum c then
                            c

                        else
                            '-'
                    )
                |> String.fromList
                |> String.split "-"
                |> List.filter (not << String.isEmpty)
                |> String.join "-"
    in
    "uif-" ++ slug
