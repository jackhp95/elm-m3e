module M3e.Family.Progress.Loading exposing (el, Is, Attrs, ChildAdmittedBy, Variant, variant)

{-| `LoadingIndicator`, grouped under the **Progress** family as `Loading`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.LoadingIndicator`](M3e.Component.LoadingIndicator) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Variant, variant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.LoadingIndicator as Orig


{-| See [`M3e.Component.LoadingIndicator.el`](M3e.Component.LoadingIndicator#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.LoadingIndicator.Is`](M3e.Component.LoadingIndicator#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.LoadingIndicator.Attrs`](M3e.Component.LoadingIndicator#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.LoadingIndicator.ChildAdmittedBy`](M3e.Component.LoadingIndicator#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.LoadingIndicator.Variant`](M3e.Component.LoadingIndicator#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.LoadingIndicator.variant`](M3e.Component.LoadingIndicator#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant
