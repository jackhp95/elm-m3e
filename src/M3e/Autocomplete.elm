module M3e.Autocomplete exposing
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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-autocomplete` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | autocomplete : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { autoActivate : Supported
    , caseSensitive : Supported
    , class : Supported
    , filter : Supported
    , for : Supported
    , hideLoading : Supported
    , hideNoData : Supported
    , hideSelectionIndicator : Supported
    , id : Supported
    , loading : Supported
    , loadingLabel : Supported
    , noDataLabel : Supported
    , onChange : Supported
    , onQuery : Supported
    , onToggle : Supported
    , panelClass : Supported
    , required : Supported
    , resultsLabel : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { optgroup : Brand
    , option : Brand
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | autocomplete : Ctx }


{-| The `filter` values valid on this component (compile-tight narrowing).
-}
type alias Filter =
    { contains : Supported
    , endsWith : Supported
    , none : Supported
    , startsWith : Supported
    }


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
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { autoActivate : Available
    , caseSensitive : Available
    , class : Available
    , filter : Available
    , for : Available
    , hideLoading : Available
    , hideNoData : Available
    , hideSelectionIndicator : Available
    , id : Available
    , loading : Available
    , loadingLabel : Available
    , noDataLabel : Available
    , onChange : Available
    , onQuery : Available
    , onToggle : Available
    , panelClass : Available
    , required : Available
    , resultsLabel : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { loading : Available
    , noData : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-autocomplete" [] []


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


{-| Pipe form of `autoActivate` — consumes its capability (write-once).
-}
withAutoActivate : Bool -> Builder { a | autoActivate : Available } slotCaps msg -> Builder { a | autoActivate : Used } slotCaps msg
withAutoActivate value_ =
    B.withAttribute (A.autoActivate value_)


{-| Pipe form of `caseSensitive` — consumes its capability (write-once).
-}
withCaseSensitive : Bool -> Builder { a | caseSensitive : Available } slotCaps msg -> Builder { a | caseSensitive : Used } slotCaps msg
withCaseSensitive value_ =
    B.withAttribute (A.caseSensitive value_)


{-| Pipe form of `filter` — consumes its capability (write-once).
-}
withFilter : Value Filter -> Builder { a | filter : Available } slotCaps msg -> Builder { a | filter : Used } slotCaps msg
withFilter value_ =
    B.withAttribute (filter value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `hideLoading` — consumes its capability (write-once).
-}
withHideLoading : Bool -> Builder { a | hideLoading : Available } slotCaps msg -> Builder { a | hideLoading : Used } slotCaps msg
withHideLoading value_ =
    B.withAttribute (A.hideLoading value_)


{-| Pipe form of `hideNoData` — consumes its capability (write-once).
-}
withHideNoData : Bool -> Builder { a | hideNoData : Available } slotCaps msg -> Builder { a | hideNoData : Used } slotCaps msg
withHideNoData value_ =
    B.withAttribute (A.hideNoData value_)


{-| Pipe form of `hideSelectionIndicator` — consumes its capability (write-once).
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg -> Builder { a | hideSelectionIndicator : Used } slotCaps msg
withHideSelectionIndicator value_ =
    B.withAttribute (A.hideSelectionIndicator value_)


{-| Pipe form of `loading` — consumes its capability (write-once).
-}
withLoading : Bool -> Builder { a | loading : Available } slotCaps msg -> Builder { a | loading : Used } slotCaps msg
withLoading value_ =
    B.withAttribute (A.loading value_)


{-| Pipe form of `loadingLabel` — consumes its capability (write-once).
-}
withLoadingLabel : String -> Builder { a | loadingLabel : Available } slotCaps msg -> Builder { a | loadingLabel : Used } slotCaps msg
withLoadingLabel value_ =
    B.withAttribute (A.loadingLabel value_)


{-| Pipe form of `noDataLabel` — consumes its capability (write-once).
-}
withNoDataLabel : String -> Builder { a | noDataLabel : Available } slotCaps msg -> Builder { a | noDataLabel : Used } slotCaps msg
withNoDataLabel value_ =
    B.withAttribute (A.noDataLabel value_)


{-| Pipe form of `panelClass` — consumes its capability (write-once).
-}
withPanelClass : String -> Builder { a | panelClass : Available } slotCaps msg -> Builder { a | panelClass : Used } slotCaps msg
withPanelClass value_ =
    B.withAttribute (A.panelClass value_)


{-| Pipe form of `required` — consumes its capability (write-once).
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg -> Builder { a | required : Used } slotCaps msg
withRequired value_ =
    B.withAttribute (A.required value_)


{-| Pipe form of `resultsLabel` — consumes its capability (write-once).
-}
withResultsLabel : String -> Builder { a | resultsLabel : Available } slotCaps msg -> Builder { a | resultsLabel : Used } slotCaps msg
withResultsLabel value_ =
    B.withAttribute (A.resultsLabel value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onQuery` — consumes its capability (write-once).
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg -> Builder { a | onQuery : Used } slotCaps msg
withOnQuery value_ =
    B.withAttribute (Ev.onQuery value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)


{-| Pipe form of the `loading` slot — consumes its capability (write-once).
-}
withLoadingSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | loading : Available } msg -> Builder attrCaps { s | loading : Used } msg
withLoadingSlot element =
    B.withChild (El.toNode (loading element))


{-| Pipe form of the `no-data` slot — consumes its capability (write-once).
-}
withNoData : Element childAccepts admittedBy msg -> Builder attrCaps { s | noData : Available } msg -> Builder attrCaps { s | noData : Used } msg
withNoData element =
    B.withChild (El.toNode (noData element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
