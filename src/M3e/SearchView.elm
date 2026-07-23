module M3e.SearchView exposing
    ( view, el, build, toElement
    , Is, Attrs, ClearIconSlot, CloseIconSlot, ClosedLeadingSlot, ClosedTrailingSlot, OpenLeadingSlot, OpenTrailingSlot, SearchIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Mode, mode
    , clearLabel, closeLabel, contained, hideSearchIcon, open, onQuery, onClear, onBeforetoggle, onToggle
    , clearIcon, closeIcon, closedLeading, closedTrailing, input, openLeading, openTrailing, searchIcon
    , withChild, withClass, withClearIcon, withClearLabel, withCloseIcon, withCloseLabel, withContained, withHideSearchIcon, withId, withInput, withMode, withOnBeforetoggle, withOnClear, withOnQuery, withOnToggle, withOpen, withSearchIcon, withSlot, withStyle
    )

{-| The `m3e-search-view` component — strict per-component surface.

A surface that presents suggestions and results for a search.

@docs view, el, build, toElement
@docs Is, Attrs, ClearIconSlot, CloseIconSlot, ClosedLeadingSlot, ClosedTrailingSlot, OpenLeadingSlot, OpenTrailingSlot, SearchIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Mode, mode
@docs clearLabel, closeLabel, contained, hideSearchIcon, open, onQuery, onClear, onBeforetoggle, onToggle
@docs clearIcon, closeIcon, closedLeading, closedTrailing, input, openLeading, openTrailing, searchIcon
@docs withChild, withClass, withClearIcon, withClearLabel, withCloseIcon, withCloseLabel, withContained, withHideSearchIcon, withId, withInput, withMode, withOnBeforetoggle, withOnClear, withOnQuery, withOnToggle, withOpen, withSearchIcon, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-search-view` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | searchView : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , clearLabel : Supported
    , closeLabel : Supported
    , contained : Supported
    , hideSearchIcon : Supported
    , id : Supported
    , mode : Supported
    , onBeforetoggle : Supported
    , onClear : Supported
    , onQuery : Supported
    , onToggle : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `clear-icon` slot admits.
-}
type alias ClearIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `close-icon` slot admits.
-}
type alias CloseIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `closed-leading` slot admits.
-}
type alias ClosedLeadingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `closed-trailing` slot admits.
-}
type alias ClosedTrailingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `open-leading` slot admits.
-}
type alias OpenLeadingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `open-trailing` slot admits.
-}
type alias OpenTrailingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `search-icon` slot admits.
-}
type alias SearchIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | searchView : Ctx }


{-| The `mode` values valid on this component (compile-tight narrowing).
-}
type alias Mode =
    { auto : Supported
    , docked : Supported
    , fullscreen : Supported
    }


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.searchView


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { input : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "input") (El.toNode required_.input)) :: children)


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode value_ =
    Ir.attribute "mode" (Val.toString value_)


{-| See `M3e.Attributes.clearLabel`.
-}
clearLabel : String -> Attr { c | clearLabel : Supported } msg
clearLabel =
    A.clearLabel


{-| See `M3e.Attributes.closeLabel`.
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    A.closeLabel


{-| See `M3e.Attributes.contained`.
-}
contained : Bool -> Attr { c | contained : Supported } msg
contained =
    A.contained


{-| See `M3e.Attributes.hideSearchIcon`.
-}
hideSearchIcon : Bool -> Attr { c | hideSearchIcon : Supported } msg
hideSearchIcon =
    A.hideSearchIcon


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    A.open


{-| See `M3e.Events.onQuery`.
-}
onQuery : msg -> Attr { c | onQuery : Supported } msg
onQuery =
    Ev.onQuery


{-| See `M3e.Events.onClear`.
-}
onClear : msg -> Attr { c | onClear : Supported } msg
onClear =
    Ev.onClear


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Ev.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Ev.onToggle


{-| Place an element into the named `clear-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
clearIcon : Element ClearIconSlot admittedBy msg -> Element free freeAdmittedBy msg
clearIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "clear-icon") (El.toNode element))


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (El.toNode element))


{-| Place an element into the named `closed-leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closedLeading : Element ClosedLeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
closedLeading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "closed-leading") (El.toNode element))


{-| Place an element into the named `closed-trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closedTrailing : Element ClosedTrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
closedTrailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "closed-trailing") (El.toNode element))


{-| Place an element into the named `input` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
input : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
input element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "input") (El.toNode element))


{-| Place an element into the named `open-leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
openLeading : Element OpenLeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
openLeading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "open-leading") (El.toNode element))


{-| Place an element into the named `open-trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
openTrailing : Element OpenTrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
openTrailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "open-trailing") (El.toNode element))


{-| Place an element into the named `search-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
searchIcon : Element SearchIconSlot admittedBy msg -> Element free freeAdmittedBy msg
searchIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "search-icon") (El.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , clearLabel : Available
    , closeLabel : Available
    , contained : Available
    , hideSearchIcon : Available
    , id : Available
    , mode : Available
    , onBeforetoggle : Available
    , onClear : Available
    , onQuery : Available
    , onToggle : Available
    , open : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { clearIcon : Available
    , closeIcon : Available
    , input : Available
    , searchIcon : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { input : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-search-view" [] [ El.toNode (input required_.input) ]


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ =
    B.withAttribute (A.style value_)


{-| Pipe form of `clearLabel` — consumes its capability (write-once).
-}
withClearLabel : String -> Builder { a | clearLabel : Available } slotCaps msg -> Builder { a | clearLabel : Used } slotCaps msg
withClearLabel value_ =
    B.withAttribute (A.clearLabel value_)


{-| Pipe form of `closeLabel` — consumes its capability (write-once).
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg -> Builder { a | closeLabel : Used } slotCaps msg
withCloseLabel value_ =
    B.withAttribute (A.closeLabel value_)


{-| Pipe form of `contained` — consumes its capability (write-once).
-}
withContained : Bool -> Builder { a | contained : Available } slotCaps msg -> Builder { a | contained : Used } slotCaps msg
withContained value_ =
    B.withAttribute (A.contained value_)


{-| Pipe form of `hideSearchIcon` — consumes its capability (write-once).
-}
withHideSearchIcon : Bool -> Builder { a | hideSearchIcon : Available } slotCaps msg -> Builder { a | hideSearchIcon : Used } slotCaps msg
withHideSearchIcon value_ =
    B.withAttribute (A.hideSearchIcon value_)


{-| Pipe form of `mode` — consumes its capability (write-once).
-}
withMode : Value Mode -> Builder { a | mode : Available } slotCaps msg -> Builder { a | mode : Used } slotCaps msg
withMode value_ =
    B.withAttribute (mode value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `onQuery` — consumes its capability (write-once).
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg -> Builder { a | onQuery : Used } slotCaps msg
withOnQuery value_ =
    B.withAttribute (Ev.onQuery value_)


{-| Pipe form of `onClear` — consumes its capability (write-once).
-}
withOnClear : msg -> Builder { a | onClear : Available } slotCaps msg -> Builder { a | onClear : Used } slotCaps msg
withOnClear value_ =
    B.withAttribute (Ev.onClear value_)


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ =
    B.withAttribute (Ev.onBeforetoggle value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)


{-| Pipe form of the `clear-icon` slot — consumes its capability (write-once).
-}
withClearIcon : Element ClearIconSlot admittedBy msg -> Builder attrCaps { s | clearIcon : Available } msg -> Builder attrCaps { s | clearIcon : Used } msg
withClearIcon element =
    B.withChild (El.toNode (clearIcon element))


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg -> Builder attrCaps { s | closeIcon : Used } msg
withCloseIcon element =
    B.withChild (El.toNode (closeIcon element))


{-| Pipe form of the `input` slot — consumes its capability (write-once).
-}
withInput : Element childAccepts admittedBy msg -> Builder attrCaps { s | input : Available } msg -> Builder attrCaps { s | input : Used } msg
withInput element =
    B.withChild (El.toNode (input element))


{-| Pipe form of the `search-icon` slot — consumes its capability (write-once).
-}
withSearchIcon : Element SearchIconSlot admittedBy msg -> Builder attrCaps { s | searchIcon : Available } msg -> Builder attrCaps { s | searchIcon : Used } msg
withSearchIcon element =
    B.withChild (El.toNode (searchIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
