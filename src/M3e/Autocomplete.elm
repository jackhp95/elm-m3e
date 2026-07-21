module M3e.Autocomplete exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Filter, filter
    , autoActivate, caseSensitive, for, hideLoading, hideNoData, hideSelectionIndicator, loadingLabel, noDataLabel, panelClass, required, resultsLabel, onChange, onQuery, onToggle
    , loading, noData
    , withAriaLabel, withAutoActivate, withCaseSensitive, withChild, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withLoadingSlot, withNoData, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle
    )

{-| The `m3e-autocomplete` component — strict per-component surface.

Enhances a text input with suggested options.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Filter, filter
@docs autoActivate, caseSensitive, for, hideLoading, hideNoData, hideSelectionIndicator, loadingLabel, noDataLabel, panelClass, required, resultsLabel, onChange, onQuery, onToggle
@docs loading, noData
@docs withAriaLabel, withAutoActivate, withCaseSensitive, withChild, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withLoadingSlot, withNoData, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-autocomplete` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | autocomplete : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , autoActivate : Supported
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-autocomplete" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `filter`. Tokens come from `M3e.Values`.
-}
filter : Value Filter -> Attr { c | filter : Supported } msg
filter value_ =
    Ir.attribute "filter" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.autoActivate`.
-}
autoActivate : Bool -> Attr { c | autoActivate : Supported } msg
autoActivate =
    M3e.Attributes.autoActivate


{-| See `M3e.Attributes.caseSensitive`.
-}
caseSensitive : Bool -> Attr { c | caseSensitive : Supported } msg
caseSensitive =
    M3e.Attributes.caseSensitive


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    M3e.Attributes.for


{-| See `M3e.Attributes.hideLoading`.
-}
hideLoading : Bool -> Attr { c | hideLoading : Supported } msg
hideLoading =
    M3e.Attributes.hideLoading


{-| See `M3e.Attributes.hideNoData`.
-}
hideNoData : Bool -> Attr { c | hideNoData : Supported } msg
hideNoData =
    M3e.Attributes.hideNoData


{-| See `M3e.Attributes.hideSelectionIndicator`.
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    M3e.Attributes.hideSelectionIndicator


{-| See `M3e.Attributes.loadingLabel`.
-}
loadingLabel : String -> Attr { c | loadingLabel : Supported } msg
loadingLabel =
    M3e.Attributes.loadingLabel


{-| See `M3e.Attributes.noDataLabel`.
-}
noDataLabel : String -> Attr { c | noDataLabel : Supported } msg
noDataLabel =
    M3e.Attributes.noDataLabel


{-| See `M3e.Attributes.panelClass`.
-}
panelClass : String -> Attr { c | panelClass : Supported } msg
panelClass =
    M3e.Attributes.panelClass


{-| See `M3e.Attributes.required`.
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    M3e.Attributes.required


{-| See `M3e.Attributes.resultsLabel`.
-}
resultsLabel : String -> Attr { c | resultsLabel : Supported } msg
resultsLabel =
    M3e.Attributes.resultsLabel


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onQuery`.
-}
onQuery : msg -> Attr { c | onQuery : Supported } msg
onQuery =
    M3e.Events.onQuery


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    M3e.Events.onToggle


{-| Place an element into the named `loading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
loading : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
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
    { ariaLabel : Available
    , autoActivate : Available
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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-autocomplete" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `autoActivate` — consumes its capability (write-once).
-}
withAutoActivate : Bool -> Builder { a | autoActivate : Available } slotCaps msg -> Builder { a | autoActivate : Used } slotCaps msg
withAutoActivate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.autoActivate value_ :: b.attrs }


{-| Pipe form of `caseSensitive` — consumes its capability (write-once).
-}
withCaseSensitive : Bool -> Builder { a | caseSensitive : Available } slotCaps msg -> Builder { a | caseSensitive : Used } slotCaps msg
withCaseSensitive value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.caseSensitive value_ :: b.attrs }


{-| Pipe form of `filter` — consumes its capability (write-once).
-}
withFilter : Value Filter -> Builder { a | filter : Available } slotCaps msg -> Builder { a | filter : Used } slotCaps msg
withFilter value_ (Builder b) =
    Builder { b | attrs = filter value_ :: b.attrs }


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.for value_ :: b.attrs }


{-| Pipe form of `hideLoading` — consumes its capability (write-once).
-}
withHideLoading : Bool -> Builder { a | hideLoading : Available } slotCaps msg -> Builder { a | hideLoading : Used } slotCaps msg
withHideLoading value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideLoading value_ :: b.attrs }


{-| Pipe form of `hideNoData` — consumes its capability (write-once).
-}
withHideNoData : Bool -> Builder { a | hideNoData : Available } slotCaps msg -> Builder { a | hideNoData : Used } slotCaps msg
withHideNoData value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideNoData value_ :: b.attrs }


{-| Pipe form of `hideSelectionIndicator` — consumes its capability (write-once).
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg -> Builder { a | hideSelectionIndicator : Used } slotCaps msg
withHideSelectionIndicator value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideSelectionIndicator value_ :: b.attrs }


{-| Pipe form of `loading` — consumes its capability (write-once).
-}
withLoading : Bool -> Builder { a | loading : Available } slotCaps msg -> Builder { a | loading : Used } slotCaps msg
withLoading value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.loading value_ :: b.attrs }


{-| Pipe form of `loadingLabel` — consumes its capability (write-once).
-}
withLoadingLabel : String -> Builder { a | loadingLabel : Available } slotCaps msg -> Builder { a | loadingLabel : Used } slotCaps msg
withLoadingLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.loadingLabel value_ :: b.attrs }


{-| Pipe form of `noDataLabel` — consumes its capability (write-once).
-}
withNoDataLabel : String -> Builder { a | noDataLabel : Available } slotCaps msg -> Builder { a | noDataLabel : Used } slotCaps msg
withNoDataLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.noDataLabel value_ :: b.attrs }


{-| Pipe form of `panelClass` — consumes its capability (write-once).
-}
withPanelClass : String -> Builder { a | panelClass : Available } slotCaps msg -> Builder { a | panelClass : Used } slotCaps msg
withPanelClass value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.panelClass value_ :: b.attrs }


{-| Pipe form of `required` — consumes its capability (write-once).
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg -> Builder { a | required : Used } slotCaps msg
withRequired value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.required value_ :: b.attrs }


{-| Pipe form of `resultsLabel` — consumes its capability (write-once).
-}
withResultsLabel : String -> Builder { a | resultsLabel : Available } slotCaps msg -> Builder { a | resultsLabel : Used } slotCaps msg
withResultsLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.resultsLabel value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onQuery` — consumes its capability (write-once).
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg -> Builder { a | onQuery : Used } slotCaps msg
withOnQuery value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onQuery value_ :: b.attrs }


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onToggle value_ :: b.attrs }


{-| Pipe form of the `loading` slot — consumes its capability (write-once).
-}
withLoadingSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | loading : Available } msg -> Builder attrCaps { s | loading : Used } msg
withLoadingSlot element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (loading element) :: b.children }


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
