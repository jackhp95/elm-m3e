module Theme exposing (Model, Msg(..), TypeScaleParam(..), capitalize, init, segmented, subscriptions, update, view)

import Dict exposing (Dict)
import HtmlIr.Element
import HtmlIr.Kind
import Json.Decode as Decode
import M3e exposing (Element)
import M3e.Attributes
import M3e.Button
import M3e.Events
import M3e.FormField
import M3e.Kind
import M3e.Values as Value exposing (Value)
import Theme.Fonts
import Theme.Icons exposing (IconStyle)
import Theme.Ports
import Theme.Presets exposing (Preset)
import Theme.Reel
import Theme.Scale as Scale exposing (ScaleConfig, ScaleMode)
import Theme.Tokens
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Button
import TypedHtml.Events
import TypedHtml.Grouping
import TypedHtml.Values


type alias Model =
    { scheme : Value Value.Scheme
    , seed : String
    , contrast : Value Value.Contrast
    , density : Float
    , motion : Value Value.Motion
    , displayFont : String
    , bodyFont : String
    , iconStyle : IconStyle
    , typeScale : ScaleConfig
    , shapeScale : ScaleConfig
    , colorOverrides : Dict String String
    , cssOverrides : Dict String String
    , activePresetId : Maybe String
    }


init : Model
init =
    { scheme = Value.auto
    , seed = "#6750A4"
    , contrast = Value.standard
    , density = 0
    , motion = Value.standard
    , displayFont = "Roboto"
    , bodyFont = "Roboto"
    , iconStyle = Theme.Icons.defaultStyle
    , typeScale = Scale.defaultConfig
    , shapeScale = Scale.defaultConfig
    , colorOverrides = Dict.empty
    , cssOverrides = Dict.empty
    , activePresetId = Nothing
    }


{-| `Msg(..)` is exposed (constructors, not opaque) because sibling
`Theme.Sections.*` modules (later tasks) need to construct these directly —
they're all in the same package, not external consumers, so this is a
deliberate, scoped exception to the usual Elm Model/Msg/update encapsulation
convention.
-}
type Msg
    = SetScheme (Value Value.Scheme)
    | SetSeed String
    | SetContrast (Value Value.Contrast)
    | SetDensity Float
    | SetMotion (Value Value.Motion)
    | SetDisplayFont String
    | SetBodyFont String
    | SetTypeScaleMode ScaleMode
    | SetTypeScaleParam TypeScaleParam Float
    | SetShapeScaleMode ScaleMode
    | SetShapeScaleParam TypeScaleParam Float
    | SetColorOverride String String
    | ResetColorOverride String
    | SetCssOverride String String
    | ApplyPreset Preset
    | ThemeStateLoaded Decode.Value
    | ResetAll


{-| Shared between type-scale and shape-scale param updates — both
`ScaleConfig`s expose the same 5 tunable fields.
-}
type TypeScaleParam
    = Factor
    | Ratio
    | Base
    | Bump
    | Exponent


setScaleParam : TypeScaleParam -> Float -> ScaleConfig -> ScaleConfig
setScaleParam param value config =
    case param of
        Factor ->
            { config | factor = value }

        Ratio ->
            { config | ratio = value }

        Base ->
            { config | base = value }

        Bump ->
            { config | bump = value }

        Exponent ->
            { config | exponent = value }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetScheme scheme ->
            persist { model | scheme = scheme, activePresetId = Nothing }

        SetSeed seed ->
            persist { model | seed = seed, activePresetId = Nothing }
                |> andSetFavicon seed

        SetContrast contrast ->
            persist { model | contrast = contrast, activePresetId = Nothing }

        SetDensity density ->
            persist { model | density = density }

        SetMotion motion ->
            persist { model | motion = motion }

        SetDisplayFont font ->
            persist { model | displayFont = font, activePresetId = Nothing }

        SetBodyFont font ->
            persist { model | bodyFont = font, activePresetId = Nothing }

        SetTypeScaleMode mode ->
            let
                newModel : Model
                newModel =
                    { model | typeScale = setScaleMode mode model.typeScale }
            in
            persist newModel |> andPushTypeScale newModel

        SetTypeScaleParam param value ->
            let
                newModel : Model
                newModel =
                    { model | typeScale = setScaleParam param value model.typeScale }
            in
            persist newModel |> andPushTypeScale newModel

        SetShapeScaleMode mode ->
            let
                newModel : Model
                newModel =
                    { model | shapeScale = setScaleMode mode model.shapeScale }
            in
            persist newModel |> andPushShapeScale newModel

        SetShapeScaleParam param value ->
            let
                newModel : Model
                newModel =
                    { model | shapeScale = setScaleParam param value model.shapeScale }
            in
            persist newModel |> andPushShapeScale newModel

        SetColorOverride cssVar value ->
            persist { model | colorOverrides = Dict.insert cssVar value model.colorOverrides }
                |> andThen (Theme.Ports.setCssOverride { property = cssVar, value = value })

        ResetColorOverride cssVar ->
            persist { model | colorOverrides = Dict.remove cssVar model.colorOverrides }
                |> andThen (Theme.Ports.setCssOverride { property = cssVar, value = "" })

        SetCssOverride cssVar value ->
            persist { model | cssOverrides = Dict.insert cssVar value model.cssOverrides }
                |> andThen (Theme.Ports.setCssOverride { property = cssVar, value = value })

        ApplyPreset preset ->
            let
                newModel : Model
                newModel =
                    applyPresetToModel preset model
            in
            ( newModel
            , Cmd.batch
                (Theme.Ports.setFaviconColor preset.seedColor
                    :: (preset.cssOverrides
                            |> List.map (\( k, v ) -> Theme.Ports.setCssOverride { property = k, value = v })
                       )
                    ++ [ storeState newModel
                       , loadFontCmd (fontsOf newModel)
                       , setIconVariantCmd newModel
                       ]
                )
            )

        ThemeStateLoaded value ->
            case Decode.decodeValue Theme.Ports.decoder value of
                Ok decoded ->
                    let
                        loaded : Model
                        loaded =
                            fromPersisted decoded
                    in
                    ( loaded
                    , Cmd.batch
                        (pushTypeScaleCmds loaded
                            ++ pushShapeScaleCmds loaded
                            ++ pushOverrideCmds loaded
                            ++ [ loadFontCmd (fontsOf loaded)
                               , setIconVariantCmd loaded
                               ]
                        )
                    )

                Err _ ->
                    ( model, Cmd.none )

        ResetAll ->
            persist init
                |> andThen
                    (Cmd.batch
                        (List.map (\( k, _ ) -> Theme.Ports.setCssOverride { property = k, value = "" })
                            (Dict.toList model.colorOverrides ++ Dict.toList model.cssOverrides)
                        )
                    )


{-| Apply a preset's fields to the model — the single, pure source of truth for
preset application. Both `ApplyPreset` (direct) and the `onPresetRequested` port
bridge in `Shared.elm` resolve to this function, ensuring they stay in sync.
-}
applyPresetToModel : Preset -> Model -> Model
applyPresetToModel preset model =
    { model
        | scheme = preset.scheme
        , seed = preset.seedColor
        , contrast = preset.contrast
        , displayFont = preset.displayFont
        , bodyFont = preset.bodyFont
        , iconStyle = preset.iconStyle
        , colorOverrides = Dict.fromList preset.cssOverrides
        , cssOverrides = Dict.empty
        , activePresetId = Just preset.id
    }


{-| Fire the `loadFonts` port for a display + body font pair. Takes just the two
font names (not a whole `Preset`) so both `ApplyPreset` (from a preset) and
`ThemeStateLoaded` (from the restored model, which has no preset) can share it.
-}
loadFontCmd : { displayFont : String, bodyFont : String } -> Cmd Msg
loadFontCmd fonts =
    case Theme.Fonts.googleFontsUrl [ fonts.displayFont, fonts.bodyFont ] of
        Just url ->
            Theme.Ports.loadFonts url

        Nothing ->
            Cmd.none


{-| The display/body font pair carried by a model, in the shape `loadFontCmd`
expects.
-}
fontsOf : Model -> { displayFont : String, bodyFont : String }
fontsOf model =
    { displayFont = model.displayFont, bodyFont = model.bodyFont }


{-| Fire the `setIconVariant` port with the model's active icon style, switching
every `<m3e-icon>` in the app to that Material Symbols optical variant (§D4).
-}
setIconVariantCmd : Model -> Cmd Msg
setIconVariantCmd model =
    Theme.Ports.setIconVariant (Theme.Icons.toString model.iconStyle)


persist : Model -> ( Model, Cmd Msg )
persist model =
    ( model, storeState model )


storeState : Model -> Cmd Msg
storeState model =
    Theme.Ports.storeThemeState
        (Theme.Ports.encode
            { scheme = Value.toString model.scheme
            , seed = model.seed
            , contrast = Value.toString model.contrast
            , density = model.density
            , motion = Value.toString model.motion
            , displayFont = model.displayFont
            , bodyFont = model.bodyFont
            , iconStyle = Theme.Icons.toString model.iconStyle
            , typeScaleMode = Scale.modeToString model.typeScale.mode
            , typeScaleFactor = model.typeScale.factor
            , typeScaleRatio = model.typeScale.ratio
            , typeScaleBase = model.typeScale.base
            , typeScaleBump = model.typeScale.bump
            , typeScaleExponent = model.typeScale.exponent
            , shapeScaleMode = Scale.modeToString model.shapeScale.mode
            , shapeScaleFactor = model.shapeScale.factor
            , shapeScaleRatio = model.shapeScale.ratio
            , shapeScaleBase = model.shapeScale.base
            , shapeScaleBump = model.shapeScale.bump
            , shapeScaleExponent = model.shapeScale.exponent
            , colorOverrides = Dict.toList model.colorOverrides
            , cssOverrides = Dict.toList model.cssOverrides
            , activePresetId = model.activePresetId
            }
        )


andThen : Cmd Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andThen extraCmd ( model, cmd ) =
    ( model, Cmd.batch [ cmd, extraCmd ] )


andSetFavicon : String -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andSetFavicon seed =
    andThen (Theme.Ports.setFaviconColor seed)


setScaleMode : ScaleMode -> ScaleConfig -> ScaleConfig
setScaleMode mode config =
    { config | mode = mode }


pushTypeScaleCmds : Model -> List (Cmd Msg)
pushTypeScaleCmds model =
    Theme.Tokens.typescaleTokens
        |> List.map
            (\token ->
                Theme.Ports.setCssOverride
                    { property = token.cssVar
                    , value = String.fromFloat (Scale.compute model.typeScale token) ++ "rem"
                    }
            )


pushShapeScaleCmds : Model -> List (Cmd Msg)
pushShapeScaleCmds model =
    Theme.Tokens.shapeTokens
        |> List.map
            (\token ->
                Theme.Ports.setCssOverride
                    { property = token.cssVar
                    , value = String.fromFloat (Scale.compute model.shapeScale token) ++ "rem"
                    }
            )


pushOverrideCmds : Model -> List (Cmd Msg)
pushOverrideCmds model =
    (Dict.toList model.colorOverrides ++ Dict.toList model.cssOverrides)
        |> List.map (\( k, v ) -> Theme.Ports.setCssOverride { property = k, value = v })


andPushTypeScale : Model -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andPushTypeScale model ( m, cmd ) =
    ( m, Cmd.batch (cmd :: pushTypeScaleCmds model) )


andPushShapeScale : Model -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andPushShapeScale model ( m, cmd ) =
    ( m, Cmd.batch (cmd :: pushShapeScaleCmds model) )


fromPersisted :
    { scheme : String
    , seed : String
    , contrast : String
    , density : Float
    , motion : String
    , displayFont : String
    , bodyFont : String
    , iconStyle : String
    , typeScaleMode : String
    , typeScaleFactor : Float
    , typeScaleRatio : Float
    , typeScaleBase : Float
    , typeScaleBump : Float
    , typeScaleExponent : Float
    , shapeScaleMode : String
    , shapeScaleFactor : Float
    , shapeScaleRatio : Float
    , shapeScaleBase : Float
    , shapeScaleBump : Float
    , shapeScaleExponent : Float
    , colorOverrides : List ( String, String )
    , cssOverrides : List ( String, String )
    , activePresetId : Maybe String
    }
    -> Model
fromPersisted decoded =
    { scheme = Value.schemeFromString decoded.scheme |> Maybe.withDefault Value.auto
    , seed = decoded.seed
    , contrast = Value.contrastFromString decoded.contrast |> Maybe.withDefault Value.standard
    , density = decoded.density
    , motion = Value.motionFromString decoded.motion |> Maybe.withDefault Value.standard
    , displayFont = decoded.displayFont
    , bodyFont = decoded.bodyFont
    , iconStyle = Theme.Icons.fromString decoded.iconStyle
    , typeScale =
        { mode = Scale.modeFromString decoded.typeScaleMode |> Maybe.withDefault Scale.Linear
        , factor = decoded.typeScaleFactor
        , ratio = decoded.typeScaleRatio
        , base = decoded.typeScaleBase
        , bump = decoded.typeScaleBump
        , exponent = decoded.typeScaleExponent
        }
    , shapeScale =
        { mode = Scale.modeFromString decoded.shapeScaleMode |> Maybe.withDefault Scale.Linear
        , factor = decoded.shapeScaleFactor
        , ratio = decoded.shapeScaleRatio
        , base = decoded.shapeScaleBase
        , bump = decoded.shapeScaleBump
        , exponent = decoded.shapeScaleExponent
        }
    , colorOverrides = Dict.fromList decoded.colorOverrides
    , cssOverrides = Dict.fromList decoded.cssOverrides
    , activePresetId = decoded.activePresetId
    }


subscriptions : Sub Msg
subscriptions =
    Theme.Ports.readThemeState ThemeStateLoaded


{-| One segmented-button control: `SegmentedButton` holding `ButtonSegment`
children, each a checked/label/onClick triple. Ported from `Shared.elm` —
exposed here because `Theme.Sections.*` (later tasks) need it for the
Contrast/Motion segmented controls too.
-}
segmented : List ( String, Bool, Msg ) -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
segmented segments =
    M3e.segmentedButton []
        (List.map
            (\( lbl, isChecked, msg ) ->
                M3e.buttonSegment
                    [ M3e.Attributes.checked isChecked, M3e.Events.onClick msg ]
                    [ M3e.text lbl ]
            )
            segments
        )


{-| Upper-case the first character. Enum wire strings are lower-case; the
settings controls display them title-cased. Ported from `Shared.elm` —
exposed here because `Theme.Sections.*` (later tasks) need it too.
-}
capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s


{-| These controls compare tokens with `==`. A `Value` is opaque over a
`String`, so the comparison is on the underlying wire string — meaning
tokens from DIFFERENT enums that share a string would compare equal. Safe
here because each control only ever compares a field against its own enum's
values. Ported from `Shared.elm`.
-}
schemeSegmented : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
schemeSegmented model =
    segmented
        (Value.schemeValues
            |> List.sortBy schemeOrder
            |> List.map (\v -> ( schemeLabel v, model.scheme == v, SetScheme v ))
        )


{-| Display order — the neutral option sits between the two poles, which is
why this is not the generated list's alphabetical order. A value we have not
placed sorts last rather than disappearing.
-}
schemeOrder : Value Value.Scheme -> Int
schemeOrder v =
    case Value.toString v of
        "light" ->
            0

        "auto" ->
            1

        "dark" ->
            2

        _ ->
            3


{-| Editorial labels: `auto` reads as "System". Anything the manifest gains
that we have not named falls back to its wire string, so a new value shows
up VISIBLY mislabelled rather than silently missing from the drawer.
-}
schemeLabel : Value Value.Scheme -> String
schemeLabel v =
    case Value.toString v of
        "auto" ->
            "System"

        other ->
            capitalize other


{-| The source-color control, dogfooding the composition-text-field pattern
(`/guide/composition-text-field`): an outlined `FormField` whose label and
typed native `<input type=color>` are wired into one accessible control by a
single shared id (`"seed-color"`), with the live hex shown as the field
hint. Ported from `Shared.elm`.
-}
seedColorInput : Model -> Element { s | formField : M3e.Kind.Brand } admittedBy Msg
seedColorInput model =
    M3e.formField [ M3e.FormField.variant Value.outlined ]
        [ M3e.FormField.label
            (TypedHtml.label [ TypedHtml.Attributes.for "seed-color" ] [ M3e.text "Source color" ])
        , M3e.FormField.hint
            (M3e.heading
                [ M3e.Attributes.variant Value.label
                , M3e.Attributes.size Value.small
                , TypedHtml.Attributes.class "text-on-surface-variant"
                ]
                [ M3e.text model.seed ]
            )
        , TypedHtml.input
            [ TypedHtml.Attributes.id "seed-color"
            , TypedHtml.Attributes.type_ "color"
            , TypedHtml.Attributes.value model.seed
            , TypedHtml.Events.onInput SetSeed
            ]
            []
        ]


{-| A compact strip of curated seed colors — a faster alternative to a full
preset: clicking a swatch fires `SetSeed hex` only, leaving scheme/contrast/
fonts untouched (unlike the reel's preset apply, which applies a whole preset).
-}
swatchStrip : Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
swatchStrip model =
    TypedHtml.div
        [ TypedHtml.Attributes.class "flex flex-wrap gap-1" ]
        (List.map (swatch model) curatedSwatchColors)


{-| ~20 curated hex colors for the quick-picker, chosen for hue spread across
the Material color wheel. Visual reference: beercss.com's `#themes3` popover
(a compact 2-row grid of ~20 round swatches). Exact hex values are a
design/visual call — a reasonable starting set, not pixel-matched.
-}
curatedSwatchColors : List String
curatedSwatchColors =
    [ "#6750A4"
    , "#B3261E"
    , "#7D5260"
    , "#006A6A"
    , "#984061"
    , "#8C4A2F"
    , "#5C6BC0"
    , "#00897B"
    , "#43A047"
    , "#FB8C00"
    , "#D81B60"
    , "#5E35B1"
    , "#3949AB"
    , "#00ACC1"
    , "#7CB342"
    , "#FDD835"
    , "#F4511E"
    , "#6D4C41"
    , "#546E7A"
    , "#8E24AA"
    ]


{-| Round swatch button. The fill color is set via a genuine inline `style`
attribute (`TypedHtml.Attributes.style "background-color" hex`), NOT a
Tailwind arbitrary-value class. Tailwind v4's JIT content-scanner only
generates CSS for class strings that appear complete and literal in source;
a runtime-concatenated `"[background-color:" ++ hex ++ "]"` class never
appears as a literal anywhere, so Tailwind emitted zero rules for any of the
20 curated colors (swatches rendered fully transparent). `background-color`
is an ordinary CSS property, so the `style`/`styleList` inline-style escape
hatch works here — unlike `Shared.densityClass`, which sets the CSS
_custom property_ `--md-sys-density-scale` and must stay on the
Tailwind-arbitrary-class convention because inline styles don't reliably
support custom properties in this codebase's style-dict encoding.
-}
swatch : Model -> String -> Element (TypedHtml.Button.Is s) admittedBy Msg
swatch model hex =
    TypedHtml.button
        [ TypedHtml.Events.onClick (SetSeed hex)
        , Aria.label ("Set seed color to " ++ hex)
        , TypedHtml.Attributes.class "size-8 rounded-full border-2"
        , TypedHtml.Attributes.style "background-color" hex
        , TypedHtml.Attributes.class
            (if model.seed == hex then
                "border-primary"

             else
                "border-transparent"
            )
        ]
        []


{-| `sections` is threaded in rather than imported here because each
`Theme.Sections.*` module imports `Theme` (for `Model`/`Msg`, per the note on
`Msg` above) — if `Theme.elm` also imported the section modules to build
their views itself, that would be an unresolvable Elm import cycle (Elm, unlike
some languages, rejects module cycles outright; there is no forward-declaration
escape hatch). The caller (the app-level `Shared.elm`, wired in the NEXT task)
sits above both `Theme` and `Theme.Sections.*` in the import graph, so it is
the natural place to call each section's `view model` and hand the results in
here.
-}
view :
    { dir : TypedHtml.Values.Value TypedHtml.Values.Dir
    , onSetDirection : TypedHtml.Values.Value TypedHtml.Values.Dir -> msg
    , sectionsEl : Element { cs | formField : M3e.Kind.Brand, segmentedButton : M3e.Kind.Brand, sharedFlow : HtmlIr.Kind.Shared, button : M3e.Kind.Brand } (TypedHtml.Grouping.DivChildAdmittedBy sectionAdm) msg
    }
    -> Model
    -> (Msg -> msg)
    -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
view { sectionsEl } model toMsg =
    TypedHtml.div
        [ TypedHtml.Attributes.class "flex flex-col gap-2 py-4"
        ]
        [ seedColorInput model |> HtmlIr.Element.map toMsg
        , schemeSegmented model |> HtmlIr.Element.map toMsg
        , Theme.Reel.view
            { presets = Theme.Presets.presets
            , activeId = model.activePresetId
            , onPick = \preset -> toMsg (ApplyPreset preset)
            }
        , swatchStrip model |> HtmlIr.Element.map toMsg
        , sectionsEl
        , resetAllButton |> HtmlIr.Element.map toMsg
        ]


resetAllButton : Element (M3e.Button.Is s) admittedBy Msg
resetAllButton =
    M3e.button
        [ TypedHtml.Events.onClick ResetAll ]
        [ M3e.text "Reset all" ]
