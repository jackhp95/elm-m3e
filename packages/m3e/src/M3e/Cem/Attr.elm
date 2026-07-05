module M3e.Cem.Attr exposing
    ( Attr
    , toAttribute, slot
    )

{-| A capability-typed attribute: a deferred `Html.Attribute` (thunked so it can
be carried through the typed layers without being applied) tagged with a
`capability` row recording which attribute a binding site admits. The generated
setters produce `Attr`s with a specific capability.

The type is **opaque** and the two free capability assertions — `attribute`
(mint at any row) and `forget` (erase the row) — are _not_ re-exported here; they
live in [`M3e.Cem.Attr.Internal`](M3e-Cem-Attr-Internal), reachable only by
generated `M3e.*` code and a team's `Seam` module (ADR 0014 §2). The extraction
[`toAttribute`](#toAttribute) and the typed [`slot`](#slot) constructor stay
public.

@docs Attr
@docs toAttribute, slot

-}

import Html
import M3e.Cem.Attr.Internal as I
import M3e.Value exposing (Supported)


{-| A thunked `Html.Attribute` carrying a phantom `capability` row, opaque and
re-exported from [`M3e.Cem.Attr.Internal`](M3e-Cem-Attr-Internal).
-}
type alias Attr capability msg =
    I.Attr capability msg


{-| Force the thunk and produce the underlying `Html.Attribute`.
-}
toAttribute : Attr capability msg -> Html.Attribute msg
toAttribute =
    I.toAttribute


{-| The `slot=` attribute, placing content into a named DOM slot.
-}
slot : String -> Attr { c | slot : Supported } msg
slot =
    I.slot
