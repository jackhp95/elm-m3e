module Ui.Progress exposing
    ( Progress, linear, circular, indeterminate
    , Shape(..)
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

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.CircularProgressIndicator
import M3e.LinearProgressIndicator


type Progress msg
    = Progress Config


type Shape
    = Linear
    | Circular


type alias Config =
    { id : Maybe String
    , shape : Shape
    , value : Maybe Int
    , max : Int
    }


{-| A determinate linear bar showing `value` out of `withMax` (default 100).
-}
linear : Int -> Progress msg
linear value =
    Progress { id = Nothing, shape = Linear, value = Just value, max = 100 }


{-| A determinate circular indicator showing `value` out of `withMax` (default 100).
-}
circular : Int -> Progress msg
circular value =
    Progress { id = Nothing, shape = Circular, value = Just value, max = 100 }


{-| An indeterminate (animated, no value) indicator of the given `Shape`. The
only no-value path — determinate indicators always carry a value.
-}
indeterminate : Shape -> Progress msg
indeterminate shape =
    Progress { id = Nothing, shape = shape, value = Nothing, max = 100 }


withId : String -> Progress msg -> Progress msg
withId id (Progress cfg) =
    Progress { cfg | id = Just id }


withMax : Int -> Progress msg -> Progress msg
withMax max (Progress cfg) =
    Progress { cfg | max = max }


view : Progress msg -> Html msg
view (Progress cfg) =
    case cfg.shape of
        Linear ->
            M3e.LinearProgressIndicator.component (attrsLinear cfg) []

        Circular ->
            M3e.CircularProgressIndicator.component (attrsCircular cfg) []


attrsLinear : Config -> List (Html.Attribute msg)
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


attrsCircular : Config -> List (Html.Attribute msg)
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
