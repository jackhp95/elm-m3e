module M3e.Cem.Attr.Internal exposing
    ( Attr(..)
    , attribute, toAttribute, forget, slot
    )

{-| The **unfenced** interior of [`M3e.Cem.Attr`](M3e-Cem-Attr): the opaque
`Attr` type _with its constructor_ plus the two free capability assertions —
[`attribute`](#attribute) (mints an `Attr` at any capability row from a raw
`Html.Attribute` constructor) and [`forget`](#forget) (erases the capability
row). Importable only by generated `M3e.*` code and a team's `Seam` module
(enforced by `NoInternalImportOutsideAllowed`). Userland builds attributes with
the generated typed setters, which carry a concrete capability. See ADR 0014 §2.

@docs Attr
@docs attribute, toAttribute, forget, slot

-}

import Html
import Html.Attributes
import M3e.Value exposing (Supported)


{-| A thunked `Html.Attribute` carrying a phantom `capability` row.
-}
type Attr capability msg
    = Attr (() -> Html.Attribute msg)


{-| Build an `Attr` from an `Html.Attribute` constructor and a value, deferring
the application until render. The `capability` row is free here — that is the
free assertion — so this lives out of `M3e.Cem.Attr`'s public surface.
-}
attribute : (a -> Html.Attribute msg) -> a -> Attr capability msg
attribute fn value =
    Attr (\() -> fn value)


{-| Force the thunk and produce the underlying `Html.Attribute`.
-}
toAttribute : Attr capability msg -> Html.Attribute msg
toAttribute (Attr run) =
    run ()


{-| Erase the capability row (used at the boundary where the concrete attribute
is handed to the bottom layer). Reassigns the phantom row freely, so it lives
here rather than in the public module.
-}
forget : Attr a msg -> Attr b msg
forget (Attr run) =
    Attr run


{-| The `slot=` attribute, placing content into a named DOM slot.
-}
slot : String -> Attr { c | slot : Supported } msg
slot =
    attribute (Html.Attributes.attribute "slot")
