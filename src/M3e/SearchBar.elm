module M3e.SearchBar exposing
    ( view, el, build, toElement
    , Is, Attrs, ClearIconSlot, LeadingSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , clearLabel, clearable, onClear
    , clearIcon, input, leading, trailing
    , withClass, withClearIcon, withClearLabel, withClearable, withId, withInput, withOnClear, withSlot, withStyle
    )

{-| The `m3e-search-bar` component — strict per-component surface.

A bar that provides a prominent entry point for search.

@docs view, el, build, toElement
@docs Is, Attrs, ClearIconSlot, LeadingSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs clearLabel, clearable, onClear
@docs clearIcon, input, leading, trailing
@docs withClass, withClearIcon, withClearLabel, withClearable, withId, withInput, withOnClear, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-search-bar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | searchBar : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , clearLabel : Supported
    , clearable : Supported
    , id : Supported
    , onClear : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `clear-icon` slot admits.
-}
type alias ClearIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | searchBar : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.searchBar


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { input : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "input") (El.toNode required_.input)) :: children)


{-| See `M3e.Attributes.clearLabel`.
-}
clearLabel : String -> Attr { c | clearLabel : Supported } msg
clearLabel =
    A.clearLabel


{-| See `M3e.Attributes.clearable`.
-}
clearable : Bool -> Attr { c | clearable : Supported } msg
clearable =
    A.clearable


{-| See `M3e.Events.onClear`.
-}
onClear : msg -> Attr { c | onClear : Supported } msg
onClear =
    Ev.onClear


{-| Place an element into the named `clear-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
clearIcon : Element ClearIconSlot admittedBy msg -> Element free freeAdmittedBy msg
clearIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "clear-icon") (El.toNode element))


{-| Place an element into the named `input` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
input : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
input element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "input") (El.toNode element))


{-| Place an element into the named `leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading") (El.toNode element))


{-| Place an element into the named `trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing") (El.toNode element))


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
    , clearable : Available
    , id : Available
    , onClear : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { clearIcon : Available
    , input : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { input : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-search-bar" [] [ El.toNode (input required_.input) ]


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


{-| Pipe form of `clearable` — consumes its capability (write-once).
-}
withClearable : Bool -> Builder { a | clearable : Available } slotCaps msg -> Builder { a | clearable : Used } slotCaps msg
withClearable value_ =
    B.withAttribute (A.clearable value_)


{-| Pipe form of `onClear` — consumes its capability (write-once).
-}
withOnClear : msg -> Builder { a | onClear : Available } slotCaps msg -> Builder { a | onClear : Used } slotCaps msg
withOnClear value_ =
    B.withAttribute (Ev.onClear value_)


{-| Pipe form of the `clear-icon` slot — consumes its capability (write-once).
-}
withClearIcon : Element ClearIconSlot admittedBy msg -> Builder attrCaps { s | clearIcon : Available } msg -> Builder attrCaps { s | clearIcon : Used } msg
withClearIcon element =
    B.withChild (El.toNode (clearIcon element))


{-| Pipe form of the `input` slot — consumes its capability (write-once).
-}
withInput : Element childAccepts admittedBy msg -> Builder attrCaps { s | input : Available } msg -> Builder attrCaps { s | input : Used } msg
withInput element =
    B.withChild (El.toNode (input element))
