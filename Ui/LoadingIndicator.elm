module Ui.LoadingIndicator exposing
    ( LoadingIndicator
    , Variant(..)
    , new
    , withVariant
    , view
    )

{-| Typed builder for `<m3e-loading-indicator>` — a short-wait progress
spinner. Mirrors the Material 3 [Loading indicator][m3] surface.

[m3]: https://m3.material.io/components/loading-indicator/overview

Per Material spec (M3 Expressive update): "Recommended as a replacement
for indeterminate circular progress indicators" — use this for waits
under 5 seconds. For determinate progress, see `Ui.Progress`.


# Type

@docs LoadingIndicator


# Configuration

@docs Variant


# Constructor

@docs new


# Modifiers

@docs withVariant


# Render

@docs view

-}

import Html exposing (Html)
import M3e.LoadingIndicator


{-| A loading indicator.
-}
type LoadingIndicator msg
    = LoadingIndicator { variant : Variant }


{-| Variant — uncontained (inline) or contained (with surface).
-}
type Variant
    = Uncontained
    | Contained


{-| A loading indicator. Defaults to `Uncontained`.
-}
new : LoadingIndicator msg
new =
    LoadingIndicator { variant = Uncontained }


{-| Set the variant.
-}
withVariant : Variant -> LoadingIndicator msg -> LoadingIndicator msg
withVariant v (LoadingIndicator cfg) =
    LoadingIndicator { cfg | variant = v }


{-| Render the loading indicator.
-}
view : LoadingIndicator msg -> Html msg
view (LoadingIndicator cfg) =
    M3e.LoadingIndicator.component
        [ variantAttr cfg.variant ]
        []


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Uncontained ->
            M3e.LoadingIndicator.variantUncontained

        Contained ->
            M3e.LoadingIndicator.variantContained
