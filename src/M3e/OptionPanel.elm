module M3e.OptionPanel exposing
    ( view, build, toElement
    , Is, Attrs, Content, LoadingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , ScrollStrategy, scrollStrategy, State, state
    , anchorOffset, fitAnchorWidth, onBeforetoggle, onToggle
    , loading, noData
    , withAnchorOffset, withAriaLabel, withChild, withClass, withFitAnchorWidth, withId, withNoData, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withState, withStyle
    )

{-| The `m3e-option-panel` component — strict per-component surface.

Presents a list of options on a temporary surface.

@docs view, build, toElement
@docs Is, Attrs, Content, LoadingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs ScrollStrategy, scrollStrategy, State, state
@docs anchorOffset, fitAnchorWidth, onBeforetoggle, onToggle
@docs loading, noData
@docs withAnchorOffset, withAriaLabel, withChild, withClass, withFitAnchorWidth, withId, withNoData, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withState, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-option-panel` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | optionPanel : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { anchorOffset : Supported
    , ariaLabel : Supported
    , class : Supported
    , fitAnchorWidth : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , scrollStrategy : Supported
    , slot : Supported
    , state : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { divider : Brand
    , optgroup : Brand
    , option : Brand
    }


{-| The kinds the `loading` slot admits.
-}
type alias LoadingSlot =
    { circularProgressIndicator : Brand
    , loadingIndicator : Brand
    , sharedText : Shared
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | optionPanel : Ctx }


{-| The `scrollStrategy` values valid on this component (compile-tight narrowing).
-}
type alias ScrollStrategy =
    { hide : Supported
    , reposition : Supported
    }


{-| The `state` values valid on this component (compile-tight narrowing).
-}
type alias State =
    { content : Supported
    , loading : Supported
    , noData : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-option-panel" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `scrollStrategy`. Tokens come from `M3e.Values`.
-}
scrollStrategy : Value ScrollStrategy -> Attr { c | scrollStrategy : Supported } msg
scrollStrategy value_ =
    Ir.attribute "scroll-strategy" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `state`. Tokens come from `M3e.Values`.
-}
state : Value State -> Attr { c | state : Supported } msg
state value_ =
    Ir.attribute "state" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.anchorOffset`.
-}
anchorOffset : Float -> Attr { c | anchorOffset : Supported } msg
anchorOffset =
    M3e.Attributes.anchorOffset


{-| See `M3e.Attributes.fitAnchorWidth`.
-}
fitAnchorWidth : Bool -> Attr { c | fitAnchorWidth : Supported } msg
fitAnchorWidth =
    M3e.Attributes.fitAnchorWidth


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    M3e.Events.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    M3e.Events.onToggle


{-| Place an element into the named `loading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
loading : Element LoadingSlot admittedBy msg -> Element free freeAdmittedBy msg
loading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "loading") (HtmlIr.Element.toNode element))


{-| Place an element into the named `no-data` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
noData : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
noData element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "no-data") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { anchorOffset : Available
    , ariaLabel : Available
    , class : Available
    , fitAnchorWidth : Available
    , id : Available
    , onBeforetoggle : Available
    , onToggle : Available
    , scrollStrategy : Available
    , slot : Available
    , state : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { noData : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-option-panel" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.class value_ :: b.attrs }


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.id value_ :: b.attrs }


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.slot value_ :: b.attrs }


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.style value_ :: b.attrs }


{-| Pipe form of `anchorOffset` — consumes its capability (write-once).
-}
withAnchorOffset : Float -> Builder { a | anchorOffset : Available } slotCaps msg -> Builder { a | anchorOffset : Used } slotCaps msg
withAnchorOffset value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.anchorOffset value_ :: b.attrs }


{-| Pipe form of `fitAnchorWidth` — consumes its capability (write-once).
-}
withFitAnchorWidth : Bool -> Builder { a | fitAnchorWidth : Available } slotCaps msg -> Builder { a | fitAnchorWidth : Used } slotCaps msg
withFitAnchorWidth value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.fitAnchorWidth value_ :: b.attrs }


{-| Pipe form of `scrollStrategy` — consumes its capability (write-once).
-}
withScrollStrategy : Value ScrollStrategy -> Builder { a | scrollStrategy : Available } slotCaps msg -> Builder { a | scrollStrategy : Used } slotCaps msg
withScrollStrategy value_ (Builder b) =
    Builder { b | attrs = scrollStrategy value_ :: b.attrs }


{-| Pipe form of `state` — consumes its capability (write-once).
-}
withState : Value State -> Builder { a | state : Available } slotCaps msg -> Builder { a | state : Used } slotCaps msg
withState value_ (Builder b) =
    Builder { b | attrs = state value_ :: b.attrs }


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforetoggle value_ :: b.attrs }


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onToggle value_ :: b.attrs }


{-| Pipe form of the `no-data` slot — consumes its capability (write-once).
-}
withNoData : Element childAccepts admittedBy msg -> Builder attrCaps { s | noData : Available } msg -> Builder attrCaps { s | noData : Used } msg
withNoData element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (noData element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
