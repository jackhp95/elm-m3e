module M3e.Family.BottomSheet exposing (BottomSheetIs, BottomSheetAttrs, BottomSheetChildAdmittedBy, ActionIs, ActionAttrs, ActionContent, ActionChildAdmittedBy, TriggerIs, TriggerAttrs, TriggerContent, TriggerChildAdmittedBy, bottomSheet, bottomSheetDetent, bottomSheetDetents, bottomSheetHandle, bottomSheetHandleLabel, bottomSheetHideFriction, bottomSheetHideable, bottomSheetModal, bottomSheetOpen, bottomSheetOvershootLimit, bottomSheetOnOpening, bottomSheetOnClosing, bottomSheetOnCancel, bottomSheetOnOpened, bottomSheetOnClosed, bottomSheetHeader, bottomSheetChild, action, actionChild, trigger, triggerDetent, triggerSecondary, triggerChild)

{-| The **BottomSheet** family — flat module re-exporting its member elements.

This is the **flat family module** for this family: one module carrying every
member element as an element-named constructor (delegating to that component's
`component` ctor), with element-prefixed type aliases and element-prefixed
typed helpers so members never collide. It re-exports:

[`M3e.Component.BottomSheet`](M3e.Component.BottomSheet) as `bottomSheet`, [`M3e.Component.BottomSheetAction`](M3e.Component.BottomSheetAction) as `action`, [`M3e.Component.BottomSheetTrigger`](M3e.Component.BottomSheetTrigger) as `trigger`.

Prefer whichever import reads best — the flat `M3e.Component.*` modules and
this family module are the same elements, same types.

@docs BottomSheetIs, BottomSheetAttrs, BottomSheetChildAdmittedBy, ActionIs, ActionAttrs, ActionContent, ActionChildAdmittedBy, TriggerIs, TriggerAttrs, TriggerContent, TriggerChildAdmittedBy, bottomSheet, bottomSheetDetent, bottomSheetDetents, bottomSheetHandle, bottomSheetHandleLabel, bottomSheetHideFriction, bottomSheetHideable, bottomSheetModal, bottomSheetOpen, bottomSheetOvershootLimit, bottomSheetOnOpening, bottomSheetOnClosing, bottomSheetOnCancel, bottomSheetOnOpened, bottomSheetOnClosed, bottomSheetHeader, bottomSheetChild, action, actionChild, trigger, triggerDetent, triggerSecondary, triggerChild

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.BottomSheet as BottomSheet_
import M3e.Component.BottomSheetAction as Action_
import M3e.Component.BottomSheetTrigger as Trigger_


{-| The `bottomSheet` element of this family — delegates to [`M3e.Component.BottomSheet.component`](M3e.Component.BottomSheet#component).
-}
bottomSheet :
    List (Attr BottomSheetAttrs msg)
    -> List (Element childAccepts (BottomSheetChildAdmittedBy childAdm) msg)
    -> Element (BottomSheetIs s) admittedBy msg
bottomSheet =
    BottomSheet_.component


{-| See [`M3e.Component.BottomSheet.Is`](M3e.Component.BottomSheet#Is).
-}
type alias BottomSheetIs s =
    BottomSheet_.Is s


{-| See [`M3e.Component.BottomSheet.Attrs`](M3e.Component.BottomSheet#Attrs).
-}
type alias BottomSheetAttrs =
    BottomSheet_.Attrs


{-| See [`M3e.Component.BottomSheet.ChildAdmittedBy`](M3e.Component.BottomSheet#ChildAdmittedBy).
-}
type alias BottomSheetChildAdmittedBy childAdm =
    BottomSheet_.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheet.detent`](M3e.Component.BottomSheet#detent).
-}
bottomSheetDetent : Float -> Attr { c | detent : Supported } msg
bottomSheetDetent =
    BottomSheet_.detent


{-| See [`M3e.Component.BottomSheet.detents`](M3e.Component.BottomSheet#detents).
-}
bottomSheetDetents : String -> Attr { c | detents : Supported } msg
bottomSheetDetents =
    BottomSheet_.detents


{-| See [`M3e.Component.BottomSheet.handle`](M3e.Component.BottomSheet#handle).
-}
bottomSheetHandle : Bool -> Attr { c | handle : Supported } msg
bottomSheetHandle =
    BottomSheet_.handle


{-| See [`M3e.Component.BottomSheet.handleLabel`](M3e.Component.BottomSheet#handleLabel).
-}
bottomSheetHandleLabel : String -> Attr { c | handleLabel : Supported } msg
bottomSheetHandleLabel =
    BottomSheet_.handleLabel


{-| See [`M3e.Component.BottomSheet.hideFriction`](M3e.Component.BottomSheet#hideFriction).
-}
bottomSheetHideFriction : Float -> Attr { c | hideFriction : Supported } msg
bottomSheetHideFriction =
    BottomSheet_.hideFriction


{-| See [`M3e.Component.BottomSheet.hideable`](M3e.Component.BottomSheet#hideable).
-}
bottomSheetHideable : Bool -> Attr { c | hideable : Supported } msg
bottomSheetHideable =
    BottomSheet_.hideable


{-| See [`M3e.Component.BottomSheet.modal`](M3e.Component.BottomSheet#modal).
-}
bottomSheetModal : Bool -> Attr { c | modal : Supported } msg
bottomSheetModal =
    BottomSheet_.modal


{-| See [`M3e.Component.BottomSheet.open`](M3e.Component.BottomSheet#open).
-}
bottomSheetOpen : Bool -> Attr { c | open : Supported } msg
bottomSheetOpen =
    BottomSheet_.open


{-| See [`M3e.Component.BottomSheet.overshootLimit`](M3e.Component.BottomSheet#overshootLimit).
-}
bottomSheetOvershootLimit : Float -> Attr { c | overshootLimit : Supported } msg
bottomSheetOvershootLimit =
    BottomSheet_.overshootLimit


{-| See [`M3e.Component.BottomSheet.onOpening`](M3e.Component.BottomSheet#onOpening).
-}
bottomSheetOnOpening : msg -> Attr { c | onOpening : Supported } msg
bottomSheetOnOpening =
    BottomSheet_.onOpening


{-| See [`M3e.Component.BottomSheet.onClosing`](M3e.Component.BottomSheet#onClosing).
-}
bottomSheetOnClosing : msg -> Attr { c | onClosing : Supported } msg
bottomSheetOnClosing =
    BottomSheet_.onClosing


{-| See [`M3e.Component.BottomSheet.onCancel`](M3e.Component.BottomSheet#onCancel).
-}
bottomSheetOnCancel : msg -> Attr { c | onCancel : Supported } msg
bottomSheetOnCancel =
    BottomSheet_.onCancel


{-| See [`M3e.Component.BottomSheet.onOpened`](M3e.Component.BottomSheet#onOpened).
-}
bottomSheetOnOpened : msg -> Attr { c | onOpened : Supported } msg
bottomSheetOnOpened =
    BottomSheet_.onOpened


{-| See [`M3e.Component.BottomSheet.onClosed`](M3e.Component.BottomSheet#onClosed).
-}
bottomSheetOnClosed : msg -> Attr { c | onClosed : Supported } msg
bottomSheetOnClosed =
    BottomSheet_.onClosed


{-| See [`M3e.Component.BottomSheet.header`](M3e.Component.BottomSheet#header).
-}
bottomSheetHeader : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
bottomSheetHeader =
    BottomSheet_.header


{-| See [`M3e.Component.BottomSheet.child`](M3e.Component.BottomSheet#child).
-}
bottomSheetChild : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
bottomSheetChild =
    BottomSheet_.child


{-| The `action` element of this family — delegates to [`M3e.Component.BottomSheetAction.component`](M3e.Component.BottomSheetAction#component).
-}
action :
    List (Attr ActionAttrs msg)
    -> List (Element ActionContent (ActionChildAdmittedBy childAdm) msg)
    -> Element (ActionIs s) admittedBy msg
action =
    Action_.component


{-| See [`M3e.Component.BottomSheetAction.Is`](M3e.Component.BottomSheetAction#Is).
-}
type alias ActionIs s =
    Action_.Is s


{-| See [`M3e.Component.BottomSheetAction.Attrs`](M3e.Component.BottomSheetAction#Attrs).
-}
type alias ActionAttrs =
    Action_.Attrs


{-| See [`M3e.Component.BottomSheetAction.Content`](M3e.Component.BottomSheetAction#Content).
-}
type alias ActionContent =
    Action_.Content


{-| See [`M3e.Component.BottomSheetAction.ChildAdmittedBy`](M3e.Component.BottomSheetAction#ChildAdmittedBy).
-}
type alias ActionChildAdmittedBy childAdm =
    Action_.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheetAction.child`](M3e.Component.BottomSheetAction#child).
-}
actionChild : Element ActionContent admittedBy msg -> Element free freeAdmittedBy msg
actionChild =
    Action_.child


{-| The `trigger` element of this family — delegates to [`M3e.Component.BottomSheetTrigger.component`](M3e.Component.BottomSheetTrigger#component).
-}
trigger :
    { for : String }
    -> List (Attr TriggerAttrs msg)
    -> List (Element TriggerContent (TriggerChildAdmittedBy childAdm) msg)
    -> Element (TriggerIs s) admittedBy msg
trigger =
    Trigger_.component


{-| See [`M3e.Component.BottomSheetTrigger.Is`](M3e.Component.BottomSheetTrigger#Is).
-}
type alias TriggerIs s =
    Trigger_.Is s


{-| See [`M3e.Component.BottomSheetTrigger.Attrs`](M3e.Component.BottomSheetTrigger#Attrs).
-}
type alias TriggerAttrs =
    Trigger_.Attrs


{-| See [`M3e.Component.BottomSheetTrigger.Content`](M3e.Component.BottomSheetTrigger#Content).
-}
type alias TriggerContent =
    Trigger_.Content


{-| See [`M3e.Component.BottomSheetTrigger.ChildAdmittedBy`](M3e.Component.BottomSheetTrigger#ChildAdmittedBy).
-}
type alias TriggerChildAdmittedBy childAdm =
    Trigger_.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheetTrigger.detent`](M3e.Component.BottomSheetTrigger#detent).
-}
triggerDetent : Float -> Attr { c | detent : Supported } msg
triggerDetent =
    Trigger_.detent


{-| See [`M3e.Component.BottomSheetTrigger.secondary`](M3e.Component.BottomSheetTrigger#secondary).
-}
triggerSecondary : Bool -> Attr { c | secondary : Supported } msg
triggerSecondary =
    Trigger_.secondary


{-| See [`M3e.Component.BottomSheetTrigger.child`](M3e.Component.BottomSheetTrigger#child).
-}
triggerChild : Element TriggerContent admittedBy msg -> Element free freeAdmittedBy msg
triggerChild =
    Trigger_.child
