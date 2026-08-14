module M3e.Family.List.Option exposing (el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, disabled, selected, value, defaultSelected, defaultValue, onBeforeinput, onInput, onChange, onClick, leading, overline, supportingText, trailing, child)

{-| `ListOption`, grouped under the **List** family as `Option`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ListOption`](M3e.Component.ListOption) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, disabled, selected, value, defaultSelected, defaultValue, onBeforeinput, onInput, onChange, onClick, leading, overline, supportingText, trailing, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.ListOption as Orig


{-| See [`M3e.Component.ListOption.el`](M3e.Component.ListOption#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ListOption.Is`](M3e.Component.ListOption#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ListOption.Attrs`](M3e.Component.ListOption#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ListOption.Content`](M3e.Component.ListOption#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ListOption.LeadingSlot`](M3e.Component.ListOption#LeadingSlot).
-}
type alias LeadingSlot =
    Orig.LeadingSlot


{-| See [`M3e.Component.ListOption.OverlineSlot`](M3e.Component.ListOption#OverlineSlot).
-}
type alias OverlineSlot =
    Orig.OverlineSlot


{-| See [`M3e.Component.ListOption.SupportingTextSlot`](M3e.Component.ListOption#SupportingTextSlot).
-}
type alias SupportingTextSlot =
    Orig.SupportingTextSlot


{-| See [`M3e.Component.ListOption.TrailingSlot`](M3e.Component.ListOption#TrailingSlot).
-}
type alias TrailingSlot =
    Orig.TrailingSlot


{-| See [`M3e.Component.ListOption.ChildAdmittedBy`](M3e.Component.ListOption#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ListOption.disabled`](M3e.Component.ListOption#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.ListOption.selected`](M3e.Component.ListOption#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.ListOption.value`](M3e.Component.ListOption#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.ListOption.defaultSelected`](M3e.Component.ListOption#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.ListOption.defaultValue`](M3e.Component.ListOption#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.ListOption.onBeforeinput`](M3e.Component.ListOption#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.ListOption.onInput`](M3e.Component.ListOption#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.ListOption.onChange`](M3e.Component.ListOption#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.ListOption.onClick`](M3e.Component.ListOption#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.ListOption.leading`](M3e.Component.ListOption#leading).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading =
    Orig.leading


{-| See [`M3e.Component.ListOption.overline`](M3e.Component.ListOption#overline).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline =
    Orig.overline


{-| See [`M3e.Component.ListOption.supportingText`](M3e.Component.ListOption#supportingText).
-}
supportingText : Element SupportingTextSlot admittedBy msg -> Element free freeAdmittedBy msg
supportingText =
    Orig.supportingText


{-| See [`M3e.Component.ListOption.trailing`](M3e.Component.ListOption#trailing).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing =
    Orig.trailing


{-| See [`M3e.Component.ListOption.child`](M3e.Component.ListOption#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
