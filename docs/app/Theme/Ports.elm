port module Theme.Ports exposing
    ( storeThemeState, readThemeState
    , setCssOverride, setFaviconColor
    , encode, decoder
    )

{-| Client-side ports for the theme editor. Wired to the browser in
`index.ts`. Replaces `Ports.elm`'s old single `storeScheme` port.

@docs storeThemeState, readThemeState
@docs setCssOverride, setFaviconColor
@docs encode, decoder

-}

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


{-| One JSON blob covering every persisted field, written to one namespaced
localStorage key (`index.ts` picks the key name — this module only shapes
the payload). One blob, not many individual keys, because this Elm model is
the only consumer and there's no cross-tool format constraint pushing
toward many keys.
-}
port storeThemeState : Encode.Value -> Cmd msg


{-| On boot, `index.ts` reads localStorage and sends the stored blob back in
(or `Encode.null` if absent/private-mode) — `Theme.init` decodes it, falling
back to defaults on decode failure or absence.
-}
port readThemeState : (Decode.Value -> msg) -> Sub msg


{-| One raw `--{property}: {value}` write via `documentElement.style.setProperty`.
Used for every color-role override, every computed typescale/shape token, and
every Advanced-section control — none of these are expressible as an
`Ir.attribute`, per `Shared.elm`'s existing "Elm cannot set a CSS custom
property directly" comment.
-}
port setCssOverride : { property : String, value : String } -> Cmd msg


{-| Rewrites the favicon's fill to the live seed color. Shared with the
tangram-logo spec (specs/2026-08-08-tangram-logo-design.md, not this task's
concern to implement the JS side of — just declare the port).
-}
port setFaviconColor : String -> Cmd msg


{-| Encoder for the persisted blob. Keep in sync with `decoder` below and
with `Theme.Model`'s field list (a later task, Theme.elm) — this is the one
place both must agree.
-}
encode :
    { scheme : String
    , seed : String
    , contrast : String
    , density : Float
    , motion : String
    , displayFont : String
    , bodyFont : String
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
    -> Encode.Value
encode state =
    Encode.object
        [ ( "scheme", Encode.string state.scheme )
        , ( "seed", Encode.string state.seed )
        , ( "contrast", Encode.string state.contrast )
        , ( "density", Encode.float state.density )
        , ( "motion", Encode.string state.motion )
        , ( "displayFont", Encode.string state.displayFont )
        , ( "bodyFont", Encode.string state.bodyFont )
        , ( "typeScaleMode", Encode.string state.typeScaleMode )
        , ( "typeScaleFactor", Encode.float state.typeScaleFactor )
        , ( "typeScaleRatio", Encode.float state.typeScaleRatio )
        , ( "typeScaleBase", Encode.float state.typeScaleBase )
        , ( "typeScaleBump", Encode.float state.typeScaleBump )
        , ( "typeScaleExponent", Encode.float state.typeScaleExponent )
        , ( "shapeScaleMode", Encode.string state.shapeScaleMode )
        , ( "shapeScaleFactor", Encode.float state.shapeScaleFactor )
        , ( "shapeScaleRatio", Encode.float state.shapeScaleRatio )
        , ( "shapeScaleBase", Encode.float state.shapeScaleBase )
        , ( "shapeScaleBump", Encode.float state.shapeScaleBump )
        , ( "shapeScaleExponent", Encode.float state.shapeScaleExponent )
        , ( "colorOverrides", Encode.object (List.map (\( k, v ) -> ( k, Encode.string v )) state.colorOverrides) )
        , ( "cssOverrides", Encode.object (List.map (\( k, v ) -> ( k, Encode.string v )) state.cssOverrides) )
        , ( "activePresetId"
          , state.activePresetId |> Maybe.map Encode.string |> Maybe.withDefault Encode.null
          )
        ]


{-| `Decode.map2 (|>)` — chains an arbitrary number of field decoders onto a
record constructor without nesting `mapN` pyramids. No pipeline-decoder
helper existed anywhere else in this codebase, and this file is the only
consumer of a 21-field decoder, so a local 5-line helper beats adding
`NoRedInk/elm-json-decode-pipeline` as a dependency for one file.
-}
andMap : Decoder a -> Decoder (a -> b) -> Decoder b
andMap =
    Decode.map2 (|>)


{-| Decoder for the persisted blob. Keep in sync with `encode` above and
with `Theme.Model`'s field list (a later task, Theme.elm).
-}
decoder :
    Decoder
        { scheme : String
        , seed : String
        , contrast : String
        , density : Float
        , motion : String
        , displayFont : String
        , bodyFont : String
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
decoder =
    Decode.succeed
        (\scheme seed contrast density motion displayFont bodyFont typeScaleMode typeScaleFactor typeScaleRatio typeScaleBase typeScaleBump typeScaleExponent shapeScaleMode shapeScaleFactor shapeScaleRatio shapeScaleBase shapeScaleBump shapeScaleExponent colorOverrides cssOverrides activePresetId ->
            { scheme = scheme
            , seed = seed
            , contrast = contrast
            , density = density
            , motion = motion
            , displayFont = displayFont
            , bodyFont = bodyFont
            , typeScaleMode = typeScaleMode
            , typeScaleFactor = typeScaleFactor
            , typeScaleRatio = typeScaleRatio
            , typeScaleBase = typeScaleBase
            , typeScaleBump = typeScaleBump
            , typeScaleExponent = typeScaleExponent
            , shapeScaleMode = shapeScaleMode
            , shapeScaleFactor = shapeScaleFactor
            , shapeScaleRatio = shapeScaleRatio
            , shapeScaleBase = shapeScaleBase
            , shapeScaleBump = shapeScaleBump
            , shapeScaleExponent = shapeScaleExponent
            , colorOverrides = colorOverrides
            , cssOverrides = cssOverrides
            , activePresetId = activePresetId
            }
        )
        |> andMap (Decode.field "scheme" Decode.string)
        |> andMap (Decode.field "seed" Decode.string)
        |> andMap (Decode.field "contrast" Decode.string)
        |> andMap (Decode.field "density" Decode.float)
        |> andMap (Decode.field "motion" Decode.string)
        |> andMap (Decode.field "displayFont" Decode.string)
        |> andMap (Decode.field "bodyFont" Decode.string)
        |> andMap (Decode.field "typeScaleMode" Decode.string)
        |> andMap (Decode.field "typeScaleFactor" Decode.float)
        |> andMap (Decode.field "typeScaleRatio" Decode.float)
        |> andMap (Decode.field "typeScaleBase" Decode.float)
        |> andMap (Decode.field "typeScaleBump" Decode.float)
        |> andMap (Decode.field "typeScaleExponent" Decode.float)
        |> andMap (Decode.field "shapeScaleMode" Decode.string)
        |> andMap (Decode.field "shapeScaleFactor" Decode.float)
        |> andMap (Decode.field "shapeScaleRatio" Decode.float)
        |> andMap (Decode.field "shapeScaleBase" Decode.float)
        |> andMap (Decode.field "shapeScaleBump" Decode.float)
        |> andMap (Decode.field "shapeScaleExponent" Decode.float)
        |> andMap (Decode.field "colorOverrides" (Decode.keyValuePairs Decode.string))
        |> andMap (Decode.field "cssOverrides" (Decode.keyValuePairs Decode.string))
        |> andMap (Decode.field "activePresetId" (Decode.nullable Decode.string))
