module M3e.Component.Autocomplete exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Filter, filter
    , autoActivate, caseSensitive, for, hideLoading, hideNoData, hideSelectionIndicator, loadingLabel, noDataLabel, panelClass, required, resultsLabel, onChange, onQuery, onToggle
    , loading, noData, child
    , withAutoActivate, withCaseSensitive, withChild, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withLoadingSlot, withNoData, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle
    )

{-| The `m3e-autocomplete` component — strict per-component surface.

Enhances a text input with suggested options.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Filter, filter
@docs autoActivate, caseSensitive, for, hideLoading, hideNoData, hideSelectionIndicator, loadingLabel, noDataLabel, panelClass, required, resultsLabel, onChange, onQuery, onToggle
@docs loading, noData, child
@docs withAutoActivate, withCaseSensitive, withChild, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withLoadingSlot, withNoData, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Autocomplete
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-autocomplete` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Autocomplete.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Autocomplete.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Autocomplete.Content


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Autocomplete.ChildAdmittedBy childAdm


{-| The `filter` values valid on this component (compile-tight narrowing).
-}
type alias Filter =
    M3e.Internal.Types.Autocomplete.Filter


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.autocomplete


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter : Value Filter -> Attr { c | filter : Supported } msg
filter value_ =
    Ir.attribute "filter" (Val.toString value_)


{-| See `M3e.Attributes.autoActivate`.
-}
autoActivate : Bool -> Attr { c | autoActivate : Supported } msg
autoActivate =
    A.autoActivate


{-| See `M3e.Attributes.caseSensitive`.
-}
caseSensitive : Bool -> Attr { c | caseSensitive : Supported } msg
caseSensitive =
    A.caseSensitive


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.hideLoading`.
-}
hideLoading : Bool -> Attr { c | hideLoading : Supported } msg
hideLoading =
    A.hideLoading


{-| See `M3e.Attributes.hideNoData`.
-}
hideNoData : Bool -> Attr { c | hideNoData : Supported } msg
hideNoData =
    A.hideNoData


{-| See `M3e.Attributes.hideSelectionIndicator`.
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    A.hideSelectionIndicator


{-| See `M3e.Attributes.loadingLabel`.
-}
loadingLabel : String -> Attr { c | loadingLabel : Supported } msg
loadingLabel =
    A.loadingLabel


{-| See `M3e.Attributes.noDataLabel`.
-}
noDataLabel : String -> Attr { c | noDataLabel : Supported } msg
noDataLabel =
    A.noDataLabel


{-| See `M3e.Attributes.panelClass`.
-}
panelClass : String -> Attr { c | panelClass : Supported } msg
panelClass =
    A.panelClass


{-| See `M3e.Attributes.required`.
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    A.required


{-| See `M3e.Attributes.resultsLabel`.
-}
resultsLabel : String -> Attr { c | resultsLabel : Supported } msg
resultsLabel =
    A.resultsLabel


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onQuery`.
-}
onQuery : msg -> Attr { c | onQuery : Supported } msg
onQuery =
    Ev.onQuery


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Ev.onToggle


{-| Place an element into the named `loading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
loading : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
loading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "loading") (El.toNode element))


{-| Place an element into the named `no-data` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
noData : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
noData element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "no-data") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Autocomplete.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Autocomplete.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Autocomplete.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-autocomplete" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `autoActivate` — consumes its capability (write-once).
-}
withAutoActivate : Bool -> Builder { a | autoActivate : Available } slotCaps msg kind -> Builder { a | autoActivate : Used } slotCaps msg kind
withAutoActivate value_ =
    B.withAttribute (A.autoActivate value_)


{-| Pipe form of `caseSensitive` — consumes its capability (write-once).
-}
withCaseSensitive : Bool -> Builder { a | caseSensitive : Available } slotCaps msg kind -> Builder { a | caseSensitive : Used } slotCaps msg kind
withCaseSensitive value_ =
    B.withAttribute (A.caseSensitive value_)


{-| Pipe form of `filter` — consumes its capability (write-once).
-}
withFilter : Value Filter -> Builder { a | filter : Available } slotCaps msg kind -> Builder { a | filter : Used } slotCaps msg kind
withFilter value_ =
    B.withAttribute (filter value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `hideLoading` — consumes its capability (write-once).
-}
withHideLoading : Bool -> Builder { a | hideLoading : Available } slotCaps msg kind -> Builder { a | hideLoading : Used } slotCaps msg kind
withHideLoading value_ =
    B.withAttribute (A.hideLoading value_)


{-| Pipe form of `hideNoData` — consumes its capability (write-once).
-}
withHideNoData : Bool -> Builder { a | hideNoData : Available } slotCaps msg kind -> Builder { a | hideNoData : Used } slotCaps msg kind
withHideNoData value_ =
    B.withAttribute (A.hideNoData value_)


{-| Pipe form of `hideSelectionIndicator` — consumes its capability (write-once).
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg kind -> Builder { a | hideSelectionIndicator : Used } slotCaps msg kind
withHideSelectionIndicator value_ =
    B.withAttribute (A.hideSelectionIndicator value_)


{-| Pipe form of `loading` — consumes its capability (write-once).
-}
withLoading : Bool -> Builder { a | loading : Available } slotCaps msg kind -> Builder { a | loading : Used } slotCaps msg kind
withLoading value_ =
    B.withAttribute (A.loading value_)


{-| Pipe form of `loadingLabel` — consumes its capability (write-once).
-}
withLoadingLabel : String -> Builder { a | loadingLabel : Available } slotCaps msg kind -> Builder { a | loadingLabel : Used } slotCaps msg kind
withLoadingLabel value_ =
    B.withAttribute (A.loadingLabel value_)


{-| Pipe form of `noDataLabel` — consumes its capability (write-once).
-}
withNoDataLabel : String -> Builder { a | noDataLabel : Available } slotCaps msg kind -> Builder { a | noDataLabel : Used } slotCaps msg kind
withNoDataLabel value_ =
    B.withAttribute (A.noDataLabel value_)


{-| Pipe form of `panelClass` — consumes its capability (write-once).
-}
withPanelClass : String -> Builder { a | panelClass : Available } slotCaps msg kind -> Builder { a | panelClass : Used } slotCaps msg kind
withPanelClass value_ =
    B.withAttribute (A.panelClass value_)


{-| Pipe form of `required` — consumes its capability (write-once).
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg kind -> Builder { a | required : Used } slotCaps msg kind
withRequired value_ =
    B.withAttribute (A.required value_)


{-| Pipe form of `resultsLabel` — consumes its capability (write-once).
-}
withResultsLabel : String -> Builder { a | resultsLabel : Available } slotCaps msg kind -> Builder { a | resultsLabel : Used } slotCaps msg kind
withResultsLabel value_ =
    B.withAttribute (A.resultsLabel value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onQuery` — consumes its capability (write-once).
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg kind -> Builder { a | onQuery : Used } slotCaps msg kind
withOnQuery value_ =
    B.withAttribute (Ev.onQuery value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)


{-| Pipe form of the `loading` slot — consumes its capability (write-once).
-}
withLoadingSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | loading : Available } msg kind -> Builder attrCaps { s | loading : Used } msg kind
withLoadingSlot element =
    B.withChild (El.toNode (loading element))


{-| Pipe form of the `no-data` slot — consumes its capability (write-once).
-}
withNoData : Element childAccepts admittedBy msg -> Builder attrCaps { s | noData : Available } msg kind -> Builder attrCaps { s | noData : Used } msg kind
withNoData element =
    B.withChild (El.toNode (noData element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
