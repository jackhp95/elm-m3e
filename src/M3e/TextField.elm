module M3e.TextField exposing
    ( InputType(..)
    , Option
    , Variant(..)
    , autosize
    , disabled
    , error
    , hint
    , id
    , inputType
    , multiline
    , onInput
    , placeholder
    , prefix
    , readonly
    , required
    , rows
    , suffix
    , value
    , variant
    , view
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

-}

import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



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
    , prefix : Maybe (Html msg)
    , suffix : Maybe (Html msg)
    , hint : Maybe (Html msg)
    , error : Maybe (Html msg)
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
control (e.g. a currency symbol). Wrapped in `<span slot="prefix">`.
-}
prefix : Html msg -> Option msg
prefix h =
    Internal.option (\c -> { c | prefix = Just h })


{-| Content for the `suffix` slot of `<m3e-form-field>`, shown after the
control (e.g. a unit indicator). Wrapped in `<span slot="suffix">`.
-}
suffix : Html msg -> Option msg
suffix h =
    Internal.option (\c -> { c | suffix = Just h })


{-| Hint text for the form-field's `hint` slot — shown while the field is
valid. Hidden when an error is also set (error takes precedence).
-}
hint : Html msg -> Option msg
hint h =
    Internal.option (\c -> { c | hint = Just h })


{-| Error text for the form-field's `error` slot — shown while the field is
invalid. Takes precedence over `hint`.
-}
error : Html msg -> Option msg
error h =
    Internal.option (\c -> { c | error = Just h })


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
view : { label : String } -> List (Option msg) -> Renderable { s | textField : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultConfig

        fieldId =
            Maybe.withDefault (slugify req.label) c.id
    in
    Internal.fromNode
        (Node.element "m3e-form-field"
            (List.filterMap identity
                [ Maybe.map (\v -> Node.attribute "variant" (variantString v)) c.variant
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
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "prefix" ] [ Node.raw h ])
                    c.prefix
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "suffix" ] [ Node.raw h ])
                    c.suffix
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "hint" ] [ Node.raw h ])
                    c.hint
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "error" ] [ Node.raw h ])
                    c.error
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
        , Node.property "min-rows" (Encode.float (toFloat bounds.min))
        , Node.property "max-rows" (Encode.float (toFloat bounds.max))
        ]
        []


{-| Derive a stable, collision-resistant id from the label text.
-}
slugify : String -> String
slugify label =
    let
        slug =
            label
                |> String.toLower
                |> String.toList
                |> List.map
                    (\ch ->
                        if Char.isAlphaNum ch then
                            ch

                        else
                            '-'
                    )
                |> String.fromList
                |> String.split "-"
                |> List.filter (not << String.isEmpty)
                |> String.join "-"
    in
    "m3etf-" ++ slug


variantString : Variant -> String
variantString v =
    case v of
        Filled ->
            "filled"

        Outlined ->
            "outlined"


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
