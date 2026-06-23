module Ui.TextField exposing
    ( TextField, SingleLine, MultiLine
    , Variant(..)
    , text, password, multiline
    , withId, withPlaceholder, withHelp, withError
    , withRequired, withDisabled, withReadonly
    , withPrefix, withSuffix, withMaxLength
    , withPattern, withEmailValidator, withUrlValidator, withTelValidator
    , withAutosize, withRows
    , view
    )

{-| Typed builder for a text-input field. Mirrors the Material 3
[Text fields][m3] surface: a native `<input>` or `<textarea>` wrapped
in `<m3e-form-field>` chrome.

[m3]: https://m3.material.io/components/text-fields/overview


# Two kinds, gated by the type system

A text field is either single-line or multi-line; the kind is carried
as a phantom type tag on `TextField` so kind-specific modifiers fail at
compile time when applied to the wrong constructor.

  - **SingleLine** — `text` / `password`. Supports `withPattern`,
    `withEmailValidator` / `withUrlValidator` / `withTelValidator`.
  - **MultiLine** — `multiline`. Supports `withAutosize` / `withRows`.

Shared modifiers (label is required at construction; everything else
is optional) work on either kind:

    withId, withPlaceholder, withHelp, withError, withRequired,
    withDisabled, withReadonly, withPrefix, withSuffix, withMaxLength


# Choosing the right constructor

  - **`text`** — general single-line text entry (name, search query,
    free-form code, etc.). Pair with the typed validators (email/url/
    tel) or `withPattern` to constrain the value at the browser layer.
  - **`password`** — single-line text with masked entry. v1 does not
    yet expose m3e's visibility toggle; that's a planned follow-up.
  - **`multiline`** — long-form text (descriptions, notes). Use
    `withAutosize` to grow within bounds, or `withRows` for a fixed
    height.

The `variant` choice is content-tied and made by the caller — the
module does not auto-pick filled vs outlined:

  - **Filled** — Material's higher-emphasis default; works well on
    plain backgrounds and in dense forms.
  - **Outlined** — useful when filled containers would compete with
    surrounding content (cards, dense data grids, image-rich panels).


# Quick examples

A simple text field:

    Ui.TextField.text
        { label = "Supplier name"
        , value = state.supplierName
        , variant = Ui.TextField.Filled
        , onChange = SupplierNameChanged
        }
        |> Ui.TextField.withRequired True
        |> Ui.TextField.view

An email with native browser validation + help:

    Ui.TextField.text
        { label = "Work email"
        , value = state.email
        , variant = Ui.TextField.Outlined
        , onChange = EmailChanged
        }
        |> Ui.TextField.withEmailValidator
        |> Ui.TextField.withHelp (text "We'll only contact you about audits.")
        |> Ui.TextField.view

A password:

    Ui.TextField.password
        { label = "Password"
        , value = state.password
        , variant = Ui.TextField.Filled
        , onChange = PasswordChanged
        }
        |> Ui.TextField.withMaxLength 64
        |> Ui.TextField.view

A multi-line description that auto-grows between 3 and 8 rows:

    Ui.TextField.multiline
        { label = "Description"
        , value = state.description
        , variant = Ui.TextField.Outlined
        , onChange = DescriptionChanged
        }
        |> Ui.TextField.withAutosize { min = 3, max = 8 }
        |> Ui.TextField.view


# Type

@docs TextField, SingleLine, MultiLine


# Configuration

@docs Variant


# Constructors

@docs text, password, multiline


# Shared modifiers

@docs withId, withPlaceholder, withHelp, withError
@docs withRequired, withDisabled, withReadonly
@docs withPrefix, withSuffix, withMaxLength


# Single-line-only modifiers

@docs withPattern, withEmailValidator, withUrlValidator, withTelValidator


# Multi-line-only modifiers

@docs withAutosize, withRows


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import M3e.FormField
import M3e.TextareaAutosize



-- TYPES ------------------------------------------------------------------


{-| A text-input field, parameterized by its kind tag (`SingleLine` /
`MultiLine`) and the message type. Built via `text` / `password` /
`multiline` and configured with `with*` modifiers.
-}
type TextField kind msg
    = TextField (Config msg)


{-| Phantom tag for single-line text fields. Has no values; appears
only in the `TextField` type parameter.
-}
type SingleLine
    = SingleLinePhantomTag Never


{-| Phantom tag for multi-line text fields. Has no values; appears
only in the `TextField` type parameter.
-}
type MultiLine
    = MultiLinePhantomTag Never


type alias Config msg =
    { id : Maybe String
    , label : String
    , value : String
    , variant : Variant
    , onChange : String -> msg
    , kind : Kind
    , placeholder : Maybe String
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    , prefix : Maybe (Html msg)
    , suffix : Maybe (Html msg)
    , required : Bool
    , disabled : Bool
    , readonly : Bool
    , maxLength : Maybe Int

    -- Single-line-only:
    , inputType : InputType
    , pattern : Maybe String

    -- Multi-line-only:
    , rows : Maybe Int
    , autosize : Maybe { min : Int, max : Int }
    }


type Kind
    = KindSingleLine
    | KindMultiLine


type InputType
    = TypeText
    | TypePassword
    | TypeEmail
    | TypeUrl
    | TypeTel


{-| Container style for the field.

  - **Filled** — Material's higher-emphasis default.
  - **Outlined** — bordered; lower-emphasis. Better in dense layouts
    or on visually busy backgrounds.

-}
type Variant
    = Filled
    | Outlined



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a single-line text field for general-purpose text entry.
-}
text :
    { label : String, value : String, variant : Variant, onChange : String -> msg }
    -> TextField SingleLine msg
text c =
    TextField (baseConfig c KindSingleLine TypeText)


{-| Construct a single-line password field. Renders the input with
`type=password` so the browser masks entered characters.

**Known gap (v1):** does not yet expose m3e's visibility toggle.

-}
password :
    { label : String, value : String, variant : Variant, onChange : String -> msg }
    -> TextField SingleLine msg
password c =
    TextField (baseConfig c KindSingleLine TypePassword)


{-| Construct a multi-line text field (renders a `<textarea>`).

Pair with `withAutosize` to grow within bounds, or with `withRows` for
a fixed height.

-}
multiline :
    { label : String, value : String, variant : Variant, onChange : String -> msg }
    -> TextField MultiLine msg
multiline c =
    TextField (baseConfig c KindMultiLine TypeText)


baseConfig :
    { label : String, value : String, variant : Variant, onChange : String -> msg }
    -> Kind
    -> InputType
    -> Config msg
baseConfig c kind inputType =
    { id = Nothing
    , label = c.label
    , value = c.value
    , variant = c.variant
    , onChange = c.onChange
    , kind = kind
    , placeholder = Nothing
    , help = Nothing
    , error = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , required = False
    , disabled = False
    , readonly = False
    , maxLength = Nothing
    , inputType = inputType
    , pattern = Nothing
    , rows = Nothing
    , autosize = Nothing
    }



-- SHARED MODIFIERS -------------------------------------------------------


{-| Set the `id` attribute on the underlying input. Useful for analytics
and for label-`for` association in custom layouts.
-}
withId : String -> TextField kind msg -> TextField kind msg
withId id (TextField cfg) =
    TextField { cfg | id = Just id }


{-| Set placeholder text shown when the field is empty.
-}
withPlaceholder : String -> TextField kind msg -> TextField kind msg
withPlaceholder placeholder (TextField cfg) =
    TextField { cfg | placeholder = Just placeholder }


{-| Set help text rendered beneath the field.
-}
withHelp : Html msg -> TextField kind msg -> TextField kind msg
withHelp help (TextField cfg) =
    TextField { cfg | help = Just help }


{-| Set an error message. When set, the field renders in its error
visual style and the error message replaces help text.
-}
withError : Html msg -> TextField kind msg -> TextField kind msg
withError error (TextField cfg) =
    TextField { cfg | error = Just error }


{-| Mark the field as required for form submission.
-}
withRequired : Bool -> TextField kind msg -> TextField kind msg
withRequired required (TextField cfg) =
    TextField { cfg | required = required }


{-| Mark the field as disabled — non-interactive.
-}
withDisabled : Bool -> TextField kind msg -> TextField kind msg
withDisabled disabled (TextField cfg) =
    TextField { cfg | disabled = disabled }


{-| Mark the field as read-only — the value is selectable but not
editable. Distinct from `withDisabled`, which is also non-focusable.
-}
withReadonly : Bool -> TextField kind msg -> TextField kind msg
withReadonly readonly (TextField cfg) =
    TextField { cfg | readonly = readonly }


{-| Add a prefix slot (e.g. a currency symbol).

    |> Ui.TextField.withPrefix (text "$")

-}
withPrefix : Html msg -> TextField kind msg -> TextField kind msg
withPrefix prefix (TextField cfg) =
    TextField { cfg | prefix = Just prefix }


{-| Add a suffix slot (e.g. a unit indicator).

    |> Ui.TextField.withSuffix (text "kg")

-}
withSuffix : Html msg -> TextField kind msg -> TextField kind msg
withSuffix suffix (TextField cfg) =
    TextField { cfg | suffix = Just suffix }


{-| Set a maximum length the browser will enforce.
-}
withMaxLength : Int -> TextField kind msg -> TextField kind msg
withMaxLength n (TextField cfg) =
    TextField { cfg | maxLength = Just n }



-- SINGLE-LINE-ONLY MODIFIERS ---------------------------------------------


{-| Constrain the input value to a regex pattern. Browser-level
validation only — combine with `withError` for application-level
validation feedback.

Single-line text fields only.

-}
withPattern : String -> TextField SingleLine msg -> TextField SingleLine msg
withPattern pattern (TextField cfg) =
    TextField { cfg | pattern = Just pattern }


{-| Render the input as `type=email` so the browser validates the
format and (on mobile) shows the email keyboard. Single-line only.
-}
withEmailValidator : TextField SingleLine msg -> TextField SingleLine msg
withEmailValidator (TextField cfg) =
    TextField { cfg | inputType = TypeEmail }


{-| Render the input as `type=url`. Single-line only.
-}
withUrlValidator : TextField SingleLine msg -> TextField SingleLine msg
withUrlValidator (TextField cfg) =
    TextField { cfg | inputType = TypeUrl }


{-| Render the input as `type=tel`. Single-line only — primarily a
mobile keyboard hint; tel format varies too much per locale for
browser-level validation to be reliable.
-}
withTelValidator : TextField SingleLine msg -> TextField SingleLine msg
withTelValidator (TextField cfg) =
    TextField { cfg | inputType = TypeTel }



-- MULTI-LINE-ONLY MODIFIERS ----------------------------------------------


{-| Auto-grow the textarea between `min` and `max` lines as the user
types. Multi-line only.

    |> Ui.TextField.withAutosize { min = 3, max = 8 }

Wraps the textarea in `<m3e-textarea-autosize>`.

-}
withAutosize :
    { min : Int, max : Int }
    -> TextField MultiLine msg
    -> TextField MultiLine msg
withAutosize bounds (TextField cfg) =
    TextField { cfg | autosize = Just bounds }


{-| Set the textarea's `rows` attribute (fixed initial height).
Multi-line only.
-}
withRows : Int -> TextField MultiLine msg -> TextField MultiLine msg
withRows rows (TextField cfg) =
    TextField { cfg | rows = Just rows }



-- RENDER -----------------------------------------------------------------


{-| Render the text field (with its form-field chrome) to `Html`.
-}
view : TextField kind msg -> Html msg
view (TextField cfg) =
    M3e.FormField.component
        [ formFieldVariantAttr cfg.variant ]
        (List.concat
            [ [ labelElement cfg ]
            , prefixSlot cfg.prefix
            , [ inputElement cfg ]
            , suffixSlot cfg.suffix
            , subscriptElements cfg
            ]
        )


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            -- FormField has no label slot; the label is a default-slot child.
            [ Maybe.map Attr.for cfg.id
            ]
        )
        [ Html.text cfg.label ]


inputElement : Config msg -> Html msg
inputElement cfg =
    case cfg.kind of
        KindSingleLine ->
            Html.input (singleLineAttrs cfg) []

        KindMultiLine ->
            multilineElement cfg


singleLineAttrs : Config msg -> List (Html.Attribute msg)
singleLineAttrs cfg =
    List.filterMap identity
        [ Maybe.map Attr.id cfg.id
        , Just (Attr.type_ (inputTypeString cfg.inputType))
        , Just (Attr.value cfg.value)
        , Maybe.map Attr.placeholder cfg.placeholder
        , Maybe.map Attr.pattern cfg.pattern
        , Maybe.map Attr.maxlength cfg.maxLength
        , Just (Attr.required cfg.required)
        , Just (Attr.disabled cfg.disabled)
        , Just (Attr.readonly cfg.readonly)
        , Just (HtmlEvents.onInput cfg.onChange)
        ]


multilineElement : Config msg -> Html msg
multilineElement cfg =
    let
        textareaNode : Html msg
        textareaNode =
            Html.textarea (multilineAttrs cfg) []
    in
    case cfg.autosize of
        Nothing ->
            textareaNode

        Just bounds ->
            M3e.TextareaAutosize.component
                [ M3e.TextareaAutosize.minRows (toFloat bounds.min)
                , M3e.TextareaAutosize.maxRows (toFloat bounds.max)
                ]
                [ textareaNode ]


multilineAttrs : Config msg -> List (Html.Attribute msg)
multilineAttrs cfg =
    List.filterMap identity
        [ Maybe.map Attr.id cfg.id
        , Just (Attr.value cfg.value)
        , Maybe.map Attr.placeholder cfg.placeholder
        , Maybe.map Attr.maxlength cfg.maxLength
        , Maybe.map (\n -> Attr.attribute "rows" (String.fromInt n)) cfg.rows
        , Just (Attr.required cfg.required)
        , Just (Attr.disabled cfg.disabled)
        , Just (Attr.readonly cfg.readonly)
        , Just (HtmlEvents.onInput cfg.onChange)
        ]


prefixSlot : Maybe (Html msg) -> List (Html msg)
prefixSlot maybe =
    case maybe of
        Nothing ->
            []

        Just html ->
            [ Html.span [ M3e.FormField.prefixSlot ] [ html ] ]


suffixSlot : Maybe (Html msg) -> List (Html msg)
suffixSlot maybe =
    case maybe of
        Nothing ->
            []

        Just html ->
            [ Html.span [ M3e.FormField.suffixSlot ] [ html ] ]


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []


formFieldVariantAttr : Variant -> Html.Attribute msg
formFieldVariantAttr v =
    case v of
        Filled ->
            M3e.FormField.variant M3e.FormField.Filled

        Outlined ->
            M3e.FormField.variant M3e.FormField.Outlined


inputTypeString : InputType -> String
inputTypeString t =
    case t of
        TypeText ->
            "text"

        TypePassword ->
            "password"

        TypeEmail ->
            "email"

        TypeUrl ->
            "url"

        TypeTel ->
            "tel"
