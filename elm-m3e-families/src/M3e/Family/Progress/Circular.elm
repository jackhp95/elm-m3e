module M3e.Family.Progress.Circular exposing (el, Is, Attrs, ChildAdmittedBy, Variant, variant, indeterminate, max, value, defaultValue, child)

{-| `CircularProgressIndicator`, grouped under the **Progress** family as `Circular`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.CircularProgressIndicator`](M3e.Component.CircularProgressIndicator) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Variant, variant, indeterminate, max, value, defaultValue, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.CircularProgressIndicator as Orig


{-| See [`M3e.Component.CircularProgressIndicator.el`](M3e.Component.CircularProgressIndicator#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.CircularProgressIndicator.Is`](M3e.Component.CircularProgressIndicator#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.CircularProgressIndicator.Attrs`](M3e.Component.CircularProgressIndicator#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.CircularProgressIndicator.ChildAdmittedBy`](M3e.Component.CircularProgressIndicator#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.CircularProgressIndicator.Variant`](M3e.Component.CircularProgressIndicator#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.CircularProgressIndicator.variant`](M3e.Component.CircularProgressIndicator#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.CircularProgressIndicator.indeterminate`](M3e.Component.CircularProgressIndicator#indeterminate).
-}
indeterminate : Bool -> Attr { c | indeterminate : Supported } msg
indeterminate =
    Orig.indeterminate


{-| See [`M3e.Component.CircularProgressIndicator.max`](M3e.Component.CircularProgressIndicator#max).
-}
max : Float -> Attr { c | max : Supported } msg
max =
    Orig.max


{-| See [`M3e.Component.CircularProgressIndicator.value`](M3e.Component.CircularProgressIndicator#value).
-}
value : Float -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.CircularProgressIndicator.defaultValue`](M3e.Component.CircularProgressIndicator#defaultValue).
-}
defaultValue : Float -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.CircularProgressIndicator.child`](M3e.Component.CircularProgressIndicator#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
