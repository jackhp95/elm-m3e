module M3e.Family.Progress.Linear exposing (el, Is, Attrs, ChildAdmittedBy, Mode, mode, Variant, variant, bufferValue, max, value, defaultValue)

{-| `LinearProgressIndicator`, grouped under the **Progress** family as `Linear`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.LinearProgressIndicator`](M3e.Component.LinearProgressIndicator) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Mode, mode, Variant, variant, bufferValue, max, value, defaultValue

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.LinearProgressIndicator as Orig


{-| See [`M3e.Component.LinearProgressIndicator.el`](M3e.Component.LinearProgressIndicator#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.LinearProgressIndicator.Is`](M3e.Component.LinearProgressIndicator#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.LinearProgressIndicator.Attrs`](M3e.Component.LinearProgressIndicator#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.LinearProgressIndicator.ChildAdmittedBy`](M3e.Component.LinearProgressIndicator#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.LinearProgressIndicator.Mode`](M3e.Component.LinearProgressIndicator#Mode).
-}
type alias Mode =
    Orig.Mode


{-| See [`M3e.Component.LinearProgressIndicator.mode`](M3e.Component.LinearProgressIndicator#mode).
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode =
    Orig.mode


{-| See [`M3e.Component.LinearProgressIndicator.Variant`](M3e.Component.LinearProgressIndicator#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.LinearProgressIndicator.variant`](M3e.Component.LinearProgressIndicator#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.LinearProgressIndicator.bufferValue`](M3e.Component.LinearProgressIndicator#bufferValue).
-}
bufferValue : Float -> Attr { c | bufferValue : Supported } msg
bufferValue =
    Orig.bufferValue


{-| See [`M3e.Component.LinearProgressIndicator.max`](M3e.Component.LinearProgressIndicator#max).
-}
max : Float -> Attr { c | max : Supported } msg
max =
    Orig.max


{-| See [`M3e.Component.LinearProgressIndicator.value`](M3e.Component.LinearProgressIndicator#value).
-}
value : Float -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.LinearProgressIndicator.defaultValue`](M3e.Component.LinearProgressIndicator#defaultValue).
-}
defaultValue : Float -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue
