module M3e.Cem.Attr exposing
    ( Attr
    , attribute, toAttribute, forget, slot
    )

{-| A capability-typed attribute: a deferred `Html.Attribute` (thunked so it can
be carried through the typed layers without being applied) tagged with a
`capability` row recording which attribute a binding site admits. The generated
setters produce `Attr`s with a specific capability; [`forget`](#forget) erases it
at the boundary where the value is finally rendered.

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
the application until render.
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
is handed to the bottom layer).
-}
forget : Attr a msg -> Attr b msg
forget (Attr run) =
    Attr run


{-| The `slot=` attribute, placing content into a named DOM slot.
-}
slot : String -> Attr { c | slot : Supported } msg
slot =
    attribute (Html.Attributes.attribute "slot")
