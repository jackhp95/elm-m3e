module M3e.LoadingIndicator exposing
    ( Variant(..), Option
    , view
    , variant
    )

{-| `<m3e-loading-indicator>` — an expressive, indeterminate spinner for short
waits.

Spec (per docs/CONVENTIONS.md):

  - Required:   none — no accessible name required; the indicator is purely visual
  - Options:    variant
  - Slots:      none (leaf element)
  - Properties: none (no boolean DOM properties)
  - Attrs:      variant — via Node.rawAttr (Cem uses Html.Attributes.attribute;
                opaque, no parent needs to introspect it)
  - Escape:     none (leaf)
  - Tag:        loadingIndicator

The indicator is always indeterminate. For a tracked task with a known
fraction, use `M3e.Progress`. For a content-placeholder shimmer, use
`M3e.Skeleton`.

-}

import Cem.M3e.LoadingIndicator as Cem
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


{-| Visual style, mirroring the `m3e-loading-indicator` `variant` attribute.
Default `Uncontained`.
-}
type Variant
    = Uncontained
    | Contained


type alias Option msg =
    Internal.Option Config msg


{-| Set the visual style. Default `Uncontained`; use `Contained` to place the
animation on its own surface.
-}
variant : Variant -> Option msg
variant x =
    Internal.option (\c -> { c | variant = x })


type alias Config =
    { variant : Variant }


view : List (Option msg) -> Renderable { s | loadingIndicator : Supported } msg
view opts =
    let
        c =
            Internal.applyOptions opts { variant = Uncontained }
    in
    Internal.fromNode
        (Node.element "m3e-loading-indicator"
            [ Node.rawAttr (Cem.variant (toCemVariant c.variant)) ]
            []
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Uncontained ->
            Cem.Uncontained

        Contained ->
            Cem.Contained
