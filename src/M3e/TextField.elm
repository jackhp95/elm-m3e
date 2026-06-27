module M3e.TextField exposing
    ( view
    , Option
    , Variant(..), InputType(..)
    , id, value, placeholder, variant, inputType, disabled, required, readonly, onInput, prefix, suffix, hint, error, multiline, rows, autosize
    )

{-| `<m3e-form-field>` wrapping a native `<input>` or `<textarea>` — Material
3 text field with full form-field chrome.

Spec (per docs/CONVENTIONS.md):

  - Required: `{ label : String }`
  - Options: id, value, placeholder, variant, inputType, disabled, required,
    readonly, onInput, prefix, suffix, hint, error, multiline, rows, autosize
  - Properties: `value` (native input property, always drives display)
  - Events: `onInput` — native `input` event → String via `event.target.value`
  - Slots: `hint`, `error`, `prefix`, `suffix` (named slots on `m3e-form-field`)
  - Tag: `textField`

**Multiline / autosize (fixes bug #A6/#17):** when `multiline True` and
`autosize` are both set, the `<textarea id=tid>` and
`<m3e-textarea-autosize for=tid>` are rendered as **siblings** inside
`<m3e-form-field>` — NOT wrapping. The autosize element observes the textarea
via the `for` attribute rather than by wrapping it.

@docs view
@docs Option
@docs Variant, InputType
@docs id, value, placeholder, variant, inputType, disabled, required, readonly, onInput, prefix, suffix, hint, error, multiline, rows, autosize

-}

import Cem.M3e.FormField as CemFF
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES -----------------------------------------------------------------------


{-| Visual style of the field container.

  - `Filled` — higher-emphasis, floating label.
  - `Outlined` — bordered; useful in dense or visually busy layouts.

-}
type Variant
    = Filled
    | Outlined


{-| Input mode — maps to the native `<input type=…>` attribute for single-line
fields. Ignored for multiline (`<textarea>`).
-}
type InputType
    = Text
    | Password
    | Email
    | Url
    | Tel


{-| An option configuring the `<m3e-form-field>` text field.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { id : Maybe String
    , value : Maybe String
    , placeholder : Maybe String
    , variant : Maybe Variant
    , inputType : InputType
    , disabled : Bool
    , required : Bool
    , readonly : Bool
    , onInput : Maybe (String -> msg)
    , prefix : Maybe (Node msg)
    , suffix : Maybe (Node msg)
    , hint : Maybe (Node msg)
    , error : Maybe (Node msg)
    , multiline : Bool
    , rows : Maybe Int
    , autosize : Maybe { min : Int, max : Int }
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , value = Nothing
    , placeholder = Nothing
    , variant = Nothing
    , inputType = Text
    , disabled = False
    , required = False
    , readonly = False
    , onInput = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , hint = Nothing
    , error = Nothing
    , multiline = False
    , rows = Nothing
    , autosize = Nothing
    }



-- OPTION CONSTRUCTORS ---------------------------------------------------------


{-| Set the `id` attribute on the underlying `<input>` / `<textarea>` (and
the matching `for` on the `<label>` and any autosize sibling). Without this, an
id is derived from the label text.
-}
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Drive the input value (sets the DOM `value` property).
-}
value : String -> Option msg
value s =
    Internal.option (\c -> { c | value = Just s })


{-| Set the native `placeholder` attribute.
-}
placeholder : String -> Option msg
placeholder s =
    Internal.option (\c -> { c | placeholder = Just s })


{-| Choose `Filled` or `Outlined` appearance.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Choose the input type for single-line fields (`Text`, `Password`, …).
Has no effect on multiline fields (which always render `<textarea>`).
-}
inputType : InputType -> Option msg
inputType t =
    Internal.option (\c -> { c | inputType = t })


{-| Disable the field.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Mark the field as required for form validation.
-}
required : Bool -> Option msg
required b =
    Internal.option (\c -> { c | required = b })


{-| Make the field read-only (focusable but not editable).
-}
readonly : Bool -> Option msg
readonly b =
    Internal.option (\c -> { c | readonly = b })


{-| Handle the native `input` event. Receives the new value string.
-}
onInput : (String -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


{-| Content for the `prefix` slot of `<m3e-form-field>`, shown before the
control (e.g. a currency symbol). A slottable element — use `Element.text`
for a plain string, or `Element.element` for richer content.
-}
prefix : Element { element : Supported } msg -> Option msg
prefix r =
    Internal.option (\c -> { c | prefix = Just (Element.toNode r) })


{-| Content for the `suffix` slot of `<m3e-form-field>`, shown after the
control (e.g. a unit indicator). See [`prefix`](#prefix).
-}
suffix : Element { element : Supported } msg -> Option msg
suffix r =
    Internal.option (\c -> { c | suffix = Just (Element.toNode r) })


{-| Hint for the form-field's `hint` slot — shown while the field is valid.
Hidden when an error is also set (error takes precedence). See [`prefix`](#prefix).
-}
hint : Element { element : Supported } msg -> Option msg
hint r =
    Internal.option (\c -> { c | hint = Just (Element.toNode r) })


{-| Error for the form-field's `error` slot — shown while the field is invalid.
Takes precedence over `hint`. See [`prefix`](#prefix).
-}
error : Element { element : Supported } msg -> Option msg
error r =
    Internal.option (\c -> { c | error = Just (Element.toNode r) })


{-| Render a `<textarea>` instead of an `<input>` (multi-line text entry).
Pass `True` to activate.
-}
multiline : Bool -> Option msg
multiline b =
    Internal.option (\c -> { c | multiline = b })


{-| Set the native `rows` attribute on the `<textarea>` (fixed visible height).
Has no effect on single-line fields.
-}
rows : Int -> Option msg
rows n =
    Internal.option (\c -> { c | rows = Just n })


{-| Auto-resize the textarea between `min` and `max` rows as the user types.
Adds a sibling `<m3e-textarea-autosize for=id>` element — NOT wrapping the
textarea. Multi-line only.
-}
autosize : { min : Int, max : Int } -> Option msg
autosize bounds =
    Internal.option (\c -> { c | autosize = Just bounds })



-- VIEW ------------------------------------------------------------------------


{-| Render the text field.

    M3e.TextField.view { label = "Email" }
        [ M3e.TextField.variant M3e.TextField.Outlined
        , M3e.TextField.inputType M3e.TextField.Email
        , M3e.TextField.value model.email
        , M3e.TextField.onInput EmailChanged
        ]

For a multiline field that grows between 3 and 8 rows:

    M3e.TextField.view { label = "Description" }
        [ M3e.TextField.multiline True
        , M3e.TextField.value model.description
        , M3e.TextField.autosize { min = 3, max = 8 }
        , M3e.TextField.onInput DescriptionChanged
        ]

-}
view : { label : String } -> List (Option msg) -> Element { s | textField : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig

        fieldId : String
        fieldId =
            Maybe.withDefault (slugify req.label) c.id
    in
    Internal.fromNode
        (Node.element "m3e-form-field"
            (List.filterMap identity
                [ Maybe.map (\v -> Node.attribute "variant" (CemFF.variantToString (toCemVariant v))) c.variant
                ]
            )
            (List.filterMap identity
                [ Just
                    (Node.element "label"
                        [ Node.attribute "for" fieldId ]
                        [ Node.text req.label ]
                    )
                , Just (controlNode c fieldId)
                , -- Autosize sibling: ONLY for multiline + autosize (bug #A6/#17 fix)
                  if c.multiline then
                    Maybe.map (autosizeNode fieldId) c.autosize

                  else
                    Nothing
                , Maybe.map (Node.withSlot "prefix") c.prefix
                , Maybe.map (Node.withSlot "suffix") c.suffix
                , Maybe.map (Node.withSlot "hint") c.hint
                , Maybe.map (Node.withSlot "error") c.error
                ]
            )
        )



-- INTERNAL --------------------------------------------------------------------


controlNode : Config msg -> String -> Node msg
controlNode c fieldId =
    if c.multiline then
        Node.element "textarea"
            (sharedAttrs c fieldId
                ++ List.filterMap identity
                    [ Maybe.map (\n -> Node.property "rows" (Encode.int n)) c.rows
                    ]
            )
            []

    else
        Node.element "input"
            (Node.attribute "type" (inputTypeString c.inputType) :: sharedAttrs c fieldId)
            []


{-| Attributes shared between `<input>` and `<textarea>`.
-}
sharedAttrs : Config msg -> String -> List (Node.Attr msg)
sharedAttrs c fieldId =
    List.filterMap identity
        [ Just (Node.attribute "id" fieldId)
        , Maybe.map (\v -> Node.property "value" (Encode.string v)) c.value
        , Maybe.map (Node.attribute "placeholder") c.placeholder
        , if c.disabled then
            Just (Node.property "disabled" (Encode.bool True))

          else
            Nothing
        , if c.required then
            Just (Node.property "required" (Encode.bool True))

          else
            Nothing
        , if c.readonly then
            Just (Node.property "readOnly" (Encode.bool True))

          else
            Nothing
        , Maybe.map
            (\f ->
                Node.on "input"
                    (Decode.at [ "target", "value" ] Decode.string
                        |> Decode.map f
                    )
            )
            c.onInput
        ]


autosizeNode : String -> { min : Int, max : Int } -> Node msg
autosizeNode fieldId bounds =
    Node.element "m3e-textarea-autosize"
        [ Node.attribute "for" fieldId
        , Node.property "minRows" (Encode.float (toFloat bounds.min))
        , Node.property "maxRows" (Encode.float (toFloat bounds.max))
        ]
        []


{-| Derive a stable, collision-resistant id from the label text.
-}
slugify : String -> String
slugify =
    Internal.slugify "m3etf-"


{-| Translate the local `Variant` to its `Cem.M3e.FormField` counterpart.
-}
toCemVariant : Variant -> CemFF.Variant
toCemVariant v =
    case v of
        Filled ->
            CemFF.Filled

        Outlined ->
            CemFF.Outlined


inputTypeString : InputType -> String
inputTypeString t =
    case t of
        Text ->
            "text"

        Password ->
            "password"

        Email ->
            "email"

        Url ->
            "url"

        Tel ->
            "tel"
