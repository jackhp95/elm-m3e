module Ui.TextField exposing
    ( TextField, SingleLine, MultiLine
    , Variant(..)
    , text, password, multiline
    , withAttributes
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


# Host attributes

@docs withAttributes


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

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.TextareaAutosize
import Ui.Field



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
    , attributes : List (Attribute msg)
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
    , attributes = []
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


{-| Append attributes to the underlying `<m3e-form-field>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> TextField kind msg -> TextField kind msg
withAttributes attributes (TextField cfg) =
    TextField { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying input. Useful for analytics
and for label-`for` association in custom layouts.
-}
withId : String -> TextField kind msg -> TextField kind msg
withId id (TextField cfg) =
    TextField { cfg | id = Just id }


{-| Set the native `placeholder` attribute on the `<input>`/`<textarea>`,
shown when the field is empty. Default: none.
-}
withPlaceholder : String -> TextField kind msg -> TextField kind msg
withPlaceholder placeholder (TextField cfg) =
    TextField { cfg | placeholder = Just placeholder }


{-| Set hint text for the form-field's `hint` slot, rendered in the
subscript beneath the control while it is valid. Hidden once `withError`
takes over (errors replace hints). Default: none.
-}
withHelp : Html msg -> TextField kind msg -> TextField kind msg
withHelp help (TextField cfg) =
    TextField { cfg | help = Just help }


{-| Set error content for the form-field's `error` slot. When set, the
field renders in its invalid visual style and the error replaces the
`hint`/help subscript. Default: none.
-}
withError : Html msg -> TextField kind msg -> TextField kind msg
withError error (TextField cfg) =
    TextField { cfg | error = Just error }


{-| Set the native `required` attribute, marking the field as required
for form submission. The form-field shows its required marker unless it
is hidden. Default: `False`.
-}
withRequired : Bool -> TextField kind msg -> TextField kind msg
withRequired required (TextField cfg) =
    TextField { cfg | required = required }


{-| Set the native `disabled` attribute — non-interactive and
non-focusable. Default: `False`.
-}
withDisabled : Bool -> TextField kind msg -> TextField kind msg
withDisabled disabled (TextField cfg) =
    TextField { cfg | disabled = disabled }


{-| Set the native `readonly` attribute — the value is focusable and
selectable but not editable. Distinct from `withDisabled`, which is also
non-focusable. Default: `False`.
-}
withReadonly : Bool -> TextField kind msg -> TextField kind msg
withReadonly readonly (TextField cfg) =
    TextField { cfg | readonly = readonly }


{-| Fill the form-field's `prefix` slot, rendered before the control
(e.g. a currency symbol). Default: none.

    |> Ui.TextField.withPrefix (text "$")

-}
withPrefix : Html msg -> TextField kind msg -> TextField kind msg
withPrefix prefix (TextField cfg) =
    TextField { cfg | prefix = Just prefix }


{-| Fill the form-field's `suffix` slot, rendered after the control
(e.g. a unit indicator). Default: none.

    |> Ui.TextField.withSuffix (text "kg")

-}
withSuffix : Html msg -> TextField kind msg -> TextField kind msg
withSuffix suffix (TextField cfg) =
    TextField { cfg | suffix = Just suffix }


{-| Set the native `maxlength` attribute — the maximum character count
the browser will accept. Default: unlimited.
-}
withMaxLength : Int -> TextField kind msg -> TextField kind msg
withMaxLength n (TextField cfg) =
    TextField { cfg | maxLength = Just n }



-- SINGLE-LINE-ONLY MODIFIERS ---------------------------------------------


{-| Set the native `pattern` attribute, constraining the input value to
a regex. Browser-level validation only — combine with `withError` for
application-level validation feedback. Single-line only. Default: none.
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


{-| Set the `<textarea>`'s native `rows` attribute (fixed visible
height). Multi-line only. Use this for a fixed height, or `withAutosize`
to grow with content. Default: the browser's intrinsic height.
-}
withRows : Int -> TextField MultiLine msg -> TextField MultiLine msg
withRows rows (TextField cfg) =
    TextField { cfg | rows = Just rows }



-- RENDER -----------------------------------------------------------------


{-| Render the text field (with its form-field chrome) to `Html`.
-}
view : TextField kind msg -> Html msg
view (TextField cfg) =
    Ui.Field.new cfg.label
        |> Ui.Field.withId (controlId cfg)
        |> Ui.Field.withVariant (toFieldVariant cfg.variant)
        |> maybeWith Ui.Field.withHint cfg.help
        |> maybeWith Ui.Field.withError cfg.error
        |> maybeWith Ui.Field.withPrefix cfg.prefix
        |> maybeWith Ui.Field.withSuffix cfg.suffix
        |> Ui.Field.withAttributes cfg.attributes
        |> Ui.Field.view (inputElement cfg)


maybeWith :
    (a -> Ui.Field.Field msg -> Ui.Field.Field msg)
    -> Maybe a
    -> Ui.Field.Field msg
    -> Ui.Field.Field msg
maybeWith f maybe field =
    case maybe of
        Just v ->
            f v field

        Nothing ->
            field


toFieldVariant : Variant -> Ui.Field.Variant
toFieldVariant v =
    case v of
        Filled ->
            Ui.Field.Filled

        Outlined ->
            Ui.Field.Outlined


controlId : Config msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.label


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
        [ Just (Attr.id (controlId cfg))
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
        [ Just (Attr.id (controlId cfg))
        , Just (Attr.value cfg.value)
        , Maybe.map Attr.placeholder cfg.placeholder
        , Maybe.map Attr.maxlength cfg.maxLength
        , Maybe.map (\n -> Attr.attribute "rows" (String.fromInt n)) cfg.rows
        , Just (Attr.required cfg.required)
        , Just (Attr.disabled cfg.disabled)
        , Just (Attr.readonly cfg.readonly)
        , Just (HtmlEvents.onInput cfg.onChange)
        ]


{-| Derive a stable, deterministic control id from the label text so the
`<label slot="label" for="...">` can anchor the control even when the
caller hasn't supplied an explicit `withId`.
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
