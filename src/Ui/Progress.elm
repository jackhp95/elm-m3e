module Ui.Progress exposing
    ( Progress, linear, circular, indeterminate
    , Shape(..)
    , withAttributes
    , withId, withMax
    , view
    )

{-| Typed builder for M3 progress indicators. Merges
`M3e.CircularProgressIndicator` and `M3e.LinearProgressIndicator` under
one type; `view` dispatches based on `Shape`.

Value presence is the determinant of determinate-vs-indeterminate: the
determinate constructors (`linear`/`circular`) require a value, and
`indeterminate` is the only no-value path. This makes the impossible
"determinate bar with no value" state (which rendered invisible) unrepresentable.

    Ui.Progress.linear 42
        |> Ui.Progress.withId "save-progress"
        |> Ui.Progress.view

    Ui.Progress.indeterminate Ui.Progress.Circular
        |> Ui.Progress.withId "loading"
        |> Ui.Progress.view


# Construction

@docs Progress, linear, circular, indeterminate


# Shape

@docs Shape


# Host attributes

@docs withAttributes


# Identity and values

@docs withId, withMax


# Render

@docs view


# Figma Code Connect

Bound to the determinate progress-indicator Figma component sets — one per
`Shape`. `entry=` names the value-carrying constructor (`linear`/`circular`),
each of which now takes the progress value as its single `Int` argument (the
generators synthesize a literal for it; the grammar has no numeric-value token,
so the Figma `Progress` axis stays unmapped). `withMax` carries runtime data,
not a design property, so it is unannotated. The Figma `Type`/`Thickness` axes
are intentionally unmapped (the Elm model doesn't express them, so the snippet
is the same across variants). The two **indeterminate** sets are intentionally
unbound: in Elm, indeterminate is value-absence on the `indeterminate`
constructor, not a distinct render path a Figma node can carry.

@figma-code-connect component=Linear entry=linear node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=58005-7997>
@figma-code-connect component=Circular entry=circular node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=58005-8459>

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.CircularProgressIndicator
import M3e.LinearProgressIndicator


{-| The progress indicator opaque type. Build via `linear`, `circular`, or
`indeterminate`.
-}
type Progress msg
    = Progress (Config msg)


{-| Progress indicator shape.
-}
type Shape
    = Linear
    | Circular


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , shape : Shape
    , value : Maybe Int
    , max : Int
    }


{-| A determinate linear bar showing `value` out of `withMax` (default 100).
-}
linear : Int -> Progress msg
linear value =
    Progress { id = Nothing, attributes = [], shape = Linear, value = Just value, max = 100 }


{-| A determinate circular indicator showing `value` out of `withMax` (default 100).
-}
circular : Int -> Progress msg
circular value =
    Progress { id = Nothing, attributes = [], shape = Circular, value = Just value, max = 100 }


{-| An indeterminate (animated, no value) indicator of the given `Shape`. The
only no-value path — determinate indicators always carry a value.
-}
indeterminate : Shape -> Progress msg
indeterminate shape =
    Progress { id = Nothing, attributes = [], shape = shape, value = Nothing, max = 100 }


{-| Append attributes to the rendered host — `<m3e-linear-progress>` for a
linear shape, `<m3e-circular-progress>` for a circular one. Structural
attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Progress msg -> Progress msg
withAttributes attributes (Progress cfg) =
    Progress { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Progress msg -> Progress msg
withId id (Progress cfg) =
    Progress { cfg | id = Just id }


{-| Set the maximum value the indicator measures against. Default 100.
-}
withMax : Int -> Progress msg -> Progress msg
withMax max (Progress cfg) =
    Progress { cfg | max = max }


{-| Render the progress indicator.
-}
view : Progress msg -> Html msg
view (Progress cfg) =
    case cfg.shape of
        Linear ->
            M3e.LinearProgressIndicator.component (cfg.attributes ++ attrsLinear cfg) []

        Circular ->
            M3e.CircularProgressIndicator.component (cfg.attributes ++ attrsCircular cfg) []


attrsLinear : Config msg -> List (Html.Attribute msg)
attrsLinear cfg =
    List.filterMap identity
        [ Maybe.map Attr.id cfg.id
        , Just (M3e.LinearProgressIndicator.maxAttr (toFloat cfg.max))
        , case cfg.value of
            Just v ->
                Just (M3e.LinearProgressIndicator.value (String.fromInt v))

            Nothing ->
                Just (M3e.LinearProgressIndicator.mode M3e.LinearProgressIndicator.Indeterminate)
        ]


attrsCircular : Config msg -> List (Html.Attribute msg)
attrsCircular cfg =
    List.filterMap identity
        [ Maybe.map Attr.id cfg.id
        , Just (M3e.CircularProgressIndicator.maxAttr (toFloat cfg.max))
        , case cfg.value of
            Just v ->
                Just (M3e.CircularProgressIndicator.value (String.fromInt v))

            Nothing ->
                Just (M3e.CircularProgressIndicator.indeterminate True)
        ]
