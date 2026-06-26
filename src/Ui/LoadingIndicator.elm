module Ui.LoadingIndicator exposing
    ( LoadingIndicator
    , Variant(..)
    , new
    , withAttributes
    , withVariant
    , view
    )

{-| Typed builder for `<m3e-loading-indicator>` — an expressive,
attention-grabbing animation that signals an activity is in progress and
mitigates perceived latency. Mirrors the Material 3 [Loading indicator][m3]
surface.

[m3]: https://m3.material.io/components/loading-indicator/overview

The indicator is always indeterminate, sized for a short wait.

    Ui.LoadingIndicator.new
        |> Ui.LoadingIndicator.withVariant Ui.LoadingIndicator.Contained
        |> Ui.LoadingIndicator.view

Within the "Feedback & status" family:

  - **`Ui.LoadingIndicator`** — the expressive spinner. Per the M3
    Expressive update, "recommended as a replacement for indeterminate
    circular progress indicators"; use it for waits under 5 seconds.
  - **`Ui.Progress`** — linear/circular bars for determinate progress (a
    known fraction), or a plainer indeterminate spinner.
  - **`Ui.Skeleton`** — a placeholder surface that mimics content layout
    while a whole region loads.


# Type

@docs LoadingIndicator


# Configuration

@docs Variant


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withVariant


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import M3e.LoadingIndicator


{-| A loading indicator, built with `new` and configured with `with*`
modifiers.
-}
type LoadingIndicator msg
    = LoadingIndicator (Config msg)


type alias Config msg =
    { attributes : List (Attribute msg)
    , variant : Variant
    }


{-| The indicator's appearance, mirroring the element's `variant` attribute
(default `Uncontained`). `Contained` adds a surface behind the animation for
extra contrast and context.
-}
type Variant
    = Uncontained
    | Contained


{-| A loading indicator. Defaults to `Uncontained`.
-}
new : LoadingIndicator msg
new =
    LoadingIndicator { attributes = [], variant = Uncontained }


{-| Append attributes to the underlying `<m3e-loading-indicator>` host element
— the escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> LoadingIndicator msg -> LoadingIndicator msg
withAttributes attributes (LoadingIndicator cfg) =
    LoadingIndicator { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the appearance variant. The element defaults to `Uncontained`; use
`Contained` to draw the animation on its own surface.
-}
withVariant : Variant -> LoadingIndicator msg -> LoadingIndicator msg
withVariant v (LoadingIndicator cfg) =
    LoadingIndicator { cfg | variant = v }


{-| Render the loading indicator.
-}
view : LoadingIndicator msg -> Html msg
view (LoadingIndicator cfg) =
    M3e.LoadingIndicator.component
        (cfg.attributes ++ [ variantAttr cfg.variant ])
        []


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Uncontained ->
            M3e.LoadingIndicator.variant M3e.LoadingIndicator.Uncontained

        Contained ->
            M3e.LoadingIndicator.variant M3e.LoadingIndicator.Contained
