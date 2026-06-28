module M3e.LoadingIndicator exposing
    ( view
    , Option
    , variant
    )

{-| `<m3e-loading-indicator>` — an expressive, indeterminate spinner for short
waits.

Spec (per docs/CONVENTIONS.md):

  - Required: none — no accessible name required; the indicator is purely visual
  - Options: variant
  - Slots: none (leaf element)
  - Properties: none (no boolean DOM properties)
  - Attrs: variant — via Node.rawAttr (Cem uses Html.Attributes.attribute;
    opaque, no parent needs to introspect it)
  - Escape: none (leaf)
  - Tag: loadingIndicator

The indicator is always indeterminate. For a tracked task with a known
fraction, use `M3e.Progress`. For a content-placeholder shimmer, use
`M3e.Skeleton`.

@docs view
@docs Option
@docs variant

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| Visual style, mirroring the `m3e-loading-indicator` `variant` attribute
(`uncontained` or `contained`), supplied as shared [`M3e.Value`](M3e-Value)
tokens. Default `uncontained`.
-}
type alias Variants =
    Value
        { uncontained : Supported
        , contained : Supported
        }


{-| An option configuring the `<m3e-loading-indicator>` element.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the visual style. Default [`M3e.Value.uncontained`](M3e-Value#uncontained);
use [`M3e.Value.contained`](M3e-Value#contained) to place the animation on its
own surface.
-}
variant : Variants -> Option msg
variant x =
    Internal.option (\c -> { c | variant = x })


type alias Config =
    { variant : Variants }


{-| Build the `<m3e-loading-indicator>` IR node — an indeterminate spinner.
-}
view : List (Option msg) -> Element { s | loadingIndicator : Supported } msg
view opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { variant = Value.uncontained }
    in
    Internal.fromNode
        (Node.element "m3e-loading-indicator"
            [ Node.attribute "variant" (Value.toString c.variant) ]
            []
        )
