module M3e.Attributes exposing
    ( class, id, slot, style
    , action, actionable, active, activeDate, alert, anchorOffset, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, completed, confirmLabel, contained, date, density, detent, detents, disableClose, disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible, download, duration, editable, elevated, emphasized, end, endDivider, extended, filled, firstPageLabel, fitAnchorWidth, for, handle, handleLabel, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideToggle, hideable, href, indeterminate, inline, inset, insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel, label, labelled, lastPageLabel, length, level, linear, loaded, loading, loadingLabel, lowered, max, maxDate, maxDepth, maxRows, min, minDate, minRows, modal, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional, overshootLimit, pageIndex, pageSize, pageSizes, panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius, range, rangeEnd, rangeStart, rel, removable, removeLabel, required, resultsLabel, returnValue, secondary, selected, selectedIndex, showDelay, showFirstLastButtons, start, startAt, startDivider, step, stretch, strongFocus, submenu, target, term, thin, threshold, tocIgnore, today, toggle, unbounded, value, valueformatter, vertical, weight, wrap, wrapDetents
    , animation, contrast, current, dividers, endMode, filter, floatLabel, grade, headerPosition, hideSubscript, highlightMode, icons, labelPosition, mode, motion, name, orientation, pageSizeVariant, position, positionX, positionY, scheme, scrollStrategy, shape, size, startMode, startView, state, toggleDirection, togglePosition, touchGestures, type_, variant, width
    )

{-| The canonical shared attribute vocabulary. Every setter is an open
producer (`{ c | attr : Supported }`); each element's closed `Attrs` row
decides admittance. Enum setters here close over the library-wide UNION of
values — cross-component misuse is caught by elm-review; reach for the
per-component setters (`M3e.<Component>.<attr>`) for compile-tight narrowing.

@docs class, id, slot, style
@docs action, actionable, active, activeDate, alert, anchorOffset, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, completed, confirmLabel, contained, date, density, detent, detents, disableClose, disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible, download, duration, editable, elevated, emphasized, end, endDivider, extended, filled, firstPageLabel, fitAnchorWidth, for, handle, handleLabel, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideToggle, hideable, href, indeterminate, inline, inset, insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel, label, labelled, lastPageLabel, length, level, linear, loaded, loading, loadingLabel, lowered, max, maxDate, maxDepth, maxRows, min, minDate, minRows, modal, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional, overshootLimit, pageIndex, pageSize, pageSizes, panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius, range, rangeEnd, rangeStart, rel, removable, removeLabel, required, resultsLabel, returnValue, secondary, selected, selectedIndex, showDelay, showFirstLastButtons, start, startAt, startDivider, step, stretch, strongFocus, submenu, target, term, thin, threshold, tocIgnore, today, toggle, unbounded, value, valueformatter, vertical, weight, wrap, wrapDetents
@docs animation, contrast, current, dividers, endMode, filter, floatLabel, grade, headerPosition, hideSubscript, highlightMode, icons, labelPosition, mode, motion, name, orientation, pageSizeVariant, position, positionX, positionY, scheme, scrollStrategy, shape, size, startMode, startView, state, toggleDirection, togglePosition, touchGestures, type_, variant, width

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value exposing (Value)
import Json.Encode
import M3e.Values


{-| The global `class` attribute.
-}
class : String -> Attr { c | class : Supported } msg
class =
    Ir.attribute "class"


{-| The global `id` attribute.
-}
id : String -> Attr { c | id : Supported } msg
id =
    Ir.attribute "id"


{-| The global `slot` attribute (named-slot placement by hand).
-}
slot : String -> Attr { c | slot : Supported } msg
slot =
    Ir.attribute "slot"


{-| The global `style` attribute (the full inline-style string).
-}
style : String -> Attr { c | style : Supported } msg
style =
    Ir.attribute "style"


{-| The shared `action` attribute.
-}
action : String -> Attr { c | action : Supported } msg
action =
    Ir.attribute "action"


{-| The shared `actionable` attribute.
-}
actionable : Bool -> Attr { c | actionable : Supported } msg
actionable value_ =
    Ir.property "actionable" (Json.Encode.bool value_)


{-| The shared `active` attribute.
-}
active : Bool -> Attr { c | active : Supported } msg
active value_ =
    Ir.property "active" (Json.Encode.bool value_)


{-| The shared `activeDate` attribute.
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    Ir.attribute "active-date"


{-| The shared `alert` attribute.
-}
alert : Bool -> Attr { c | alert : Supported } msg
alert value_ =
    Ir.property "alert" (Json.Encode.bool value_)


{-| The shared `anchorOffset` attribute.
-}
anchorOffset : Float -> Attr { c | anchorOffset : Supported } msg
anchorOffset value_ =
    Ir.property "anchorOffset" (Json.Encode.float value_)


{-| The shared `ariaInvalid` attribute.
-}
ariaInvalid : String -> Attr { c | ariaInvalid : Supported } msg
ariaInvalid =
    Ir.attribute "aria-invalid"


{-| The shared `autoActivate` attribute.
-}
autoActivate : Bool -> Attr { c | autoActivate : Supported } msg
autoActivate value_ =
    Ir.property "autoActivate" (Json.Encode.bool value_)


{-| The shared `bufferValue` attribute.
-}
bufferValue : Float -> Attr { c | bufferValue : Supported } msg
bufferValue value_ =
    Ir.property "bufferValue" (Json.Encode.float value_)


{-| The shared `cascade` attribute.
-}
cascade : Bool -> Attr { c | cascade : Supported } msg
cascade value_ =
    Ir.property "cascade" (Json.Encode.bool value_)


{-| The shared `caseSensitive` attribute.
-}
caseSensitive : Bool -> Attr { c | caseSensitive : Supported } msg
caseSensitive value_ =
    Ir.property "caseSensitive" (Json.Encode.bool value_)


{-| The shared `centered` attribute.
-}
centered : Bool -> Attr { c | centered : Supported } msg
centered value_ =
    Ir.property "centered" (Json.Encode.bool value_)


{-| The shared `checked` attribute.
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked value_ =
    Ir.property "checked" (Json.Encode.bool value_)


{-| The shared `clearLabel` attribute.
-}
clearLabel : String -> Attr { c | clearLabel : Supported } msg
clearLabel =
    Ir.attribute "clear-label"


{-| The shared `clearable` attribute.
-}
clearable : Bool -> Attr { c | clearable : Supported } msg
clearable value_ =
    Ir.property "clearable" (Json.Encode.bool value_)


{-| The shared `closeLabel` attribute.
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    Ir.attribute "close-label"


{-| The shared `color` attribute.
-}
color : String -> Attr { c | color : Supported } msg
color =
    Ir.attribute "color"


{-| The shared `completed` attribute.
-}
completed : Bool -> Attr { c | completed : Supported } msg
completed value_ =
    Ir.property "completed" (Json.Encode.bool value_)


{-| The shared `confirmLabel` attribute.
-}
confirmLabel : String -> Attr { c | confirmLabel : Supported } msg
confirmLabel =
    Ir.attribute "confirm-label"


{-| The shared `contained` attribute.
-}
contained : Bool -> Attr { c | contained : Supported } msg
contained value_ =
    Ir.property "contained" (Json.Encode.bool value_)


{-| The shared `date` attribute.
-}
date : String -> Attr { c | date : Supported } msg
date =
    Ir.attribute "date"


{-| The shared `density` attribute.
-}
density : Float -> Attr { c | density : Supported } msg
density value_ =
    Ir.property "density" (Json.Encode.float value_)


{-| The shared `detent` attribute.
-}
detent : Float -> Attr { c | detent : Supported } msg
detent value_ =
    Ir.property "detent" (Json.Encode.float value_)


{-| The shared `detents` attribute.
-}
detents : String -> Attr { c | detents : Supported } msg
detents =
    Ir.attribute "detents"


{-| The shared `disableClose` attribute.
-}
disableClose : Bool -> Attr { c | disableClose : Supported } msg
disableClose value_ =
    Ir.property "disableClose" (Json.Encode.bool value_)


{-| The shared `disableHighlight` attribute.
-}
disableHighlight : Bool -> Attr { c | disableHighlight : Supported } msg
disableHighlight value_ =
    Ir.property "disableHighlight" (Json.Encode.bool value_)


{-| The shared `disableHover` attribute.
-}
disableHover : Bool -> Attr { c | disableHover : Supported } msg
disableHover value_ =
    Ir.property "disableHover" (Json.Encode.bool value_)


{-| The shared `disablePagination` attribute.
-}
disablePagination : String -> Attr { c | disablePagination : Supported } msg
disablePagination =
    Ir.attribute "disable-pagination"


{-| The shared `disableRestoreFocus` attribute.
-}
disableRestoreFocus : Bool -> Attr { c | disableRestoreFocus : Supported } msg
disableRestoreFocus value_ =
    Ir.property "disableRestoreFocus" (Json.Encode.bool value_)


{-| The shared `disabled` attribute.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled value_ =
    Ir.property "disabled" (Json.Encode.bool value_)


{-| The shared `disabledInteractive` attribute.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive value_ =
    Ir.property "disabledInteractive" (Json.Encode.bool value_)


{-| The shared `discrete` attribute.
-}
discrete : Bool -> Attr { c | discrete : Supported } msg
discrete value_ =
    Ir.property "discrete" (Json.Encode.bool value_)


{-| The shared `dismissLabel` attribute.
-}
dismissLabel : String -> Attr { c | dismissLabel : Supported } msg
dismissLabel =
    Ir.attribute "dismiss-label"


{-| The shared `dismissible` attribute.
-}
dismissible : Bool -> Attr { c | dismissible : Supported } msg
dismissible value_ =
    Ir.property "dismissible" (Json.Encode.bool value_)


{-| The shared `download` attribute.
-}
download : String -> Attr { c | download : Supported } msg
download =
    Ir.attribute "download"


{-| The shared `duration` attribute.
-}
duration : Float -> Attr { c | duration : Supported } msg
duration value_ =
    Ir.property "duration" (Json.Encode.float value_)


{-| The shared `editable` attribute.
-}
editable : Bool -> Attr { c | editable : Supported } msg
editable value_ =
    Ir.property "editable" (Json.Encode.bool value_)


{-| The shared `elevated` attribute.
-}
elevated : Bool -> Attr { c | elevated : Supported } msg
elevated value_ =
    Ir.property "elevated" (Json.Encode.bool value_)


{-| The shared `emphasized` attribute.
-}
emphasized : Bool -> Attr { c | emphasized : Supported } msg
emphasized value_ =
    Ir.property "emphasized" (Json.Encode.bool value_)


{-| The shared `end` attribute.
-}
end : Bool -> Attr { c | end : Supported } msg
end value_ =
    Ir.property "end" (Json.Encode.bool value_)


{-| The shared `endDivider` attribute.
-}
endDivider : Bool -> Attr { c | endDivider : Supported } msg
endDivider value_ =
    Ir.property "endDivider" (Json.Encode.bool value_)


{-| The shared `extended` attribute.
-}
extended : Bool -> Attr { c | extended : Supported } msg
extended value_ =
    Ir.property "extended" (Json.Encode.bool value_)


{-| The shared `filled` attribute.
-}
filled : Bool -> Attr { c | filled : Supported } msg
filled value_ =
    Ir.property "filled" (Json.Encode.bool value_)


{-| The shared `firstPageLabel` attribute.
-}
firstPageLabel : String -> Attr { c | firstPageLabel : Supported } msg
firstPageLabel =
    Ir.attribute "first-page-label"


{-| The shared `fitAnchorWidth` attribute.
-}
fitAnchorWidth : Bool -> Attr { c | fitAnchorWidth : Supported } msg
fitAnchorWidth value_ =
    Ir.property "fitAnchorWidth" (Json.Encode.bool value_)


{-| The shared `for` attribute.
-}
for : String -> Attr { c | for : Supported } msg
for =
    Ir.attribute "for"


{-| The shared `handle` attribute.
-}
handle : Bool -> Attr { c | handle : Supported } msg
handle value_ =
    Ir.property "handle" (Json.Encode.bool value_)


{-| The shared `handleLabel` attribute.
-}
handleLabel : String -> Attr { c | handleLabel : Supported } msg
handleLabel =
    Ir.attribute "handle-label"


{-| The shared `hideDelay` attribute.
-}
hideDelay : Float -> Attr { c | hideDelay : Supported } msg
hideDelay value_ =
    Ir.property "hideDelay" (Json.Encode.float value_)


{-| The shared `hideFriction` attribute.
-}
hideFriction : Float -> Attr { c | hideFriction : Supported } msg
hideFriction value_ =
    Ir.property "hideFriction" (Json.Encode.float value_)


{-| The shared `hideLoading` attribute.
-}
hideLoading : Bool -> Attr { c | hideLoading : Supported } msg
hideLoading value_ =
    Ir.property "hideLoading" (Json.Encode.bool value_)


{-| The shared `hideNoData` attribute.
-}
hideNoData : Bool -> Attr { c | hideNoData : Supported } msg
hideNoData value_ =
    Ir.property "hideNoData" (Json.Encode.bool value_)


{-| The shared `hidePageSize` attribute.
-}
hidePageSize : Bool -> Attr { c | hidePageSize : Supported } msg
hidePageSize value_ =
    Ir.property "hidePageSize" (Json.Encode.bool value_)


{-| The shared `hideRequiredMarker` attribute.
-}
hideRequiredMarker : Bool -> Attr { c | hideRequiredMarker : Supported } msg
hideRequiredMarker value_ =
    Ir.property "hideRequiredMarker" (Json.Encode.bool value_)


{-| The shared `hideSearchIcon` attribute.
-}
hideSearchIcon : Bool -> Attr { c | hideSearchIcon : Supported } msg
hideSearchIcon value_ =
    Ir.property "hideSearchIcon" (Json.Encode.bool value_)


{-| The shared `hideSelectionIndicator` attribute.
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator value_ =
    Ir.property "hideSelectionIndicator" (Json.Encode.bool value_)


{-| The shared `hideToggle` attribute.
-}
hideToggle : Bool -> Attr { c | hideToggle : Supported } msg
hideToggle value_ =
    Ir.property "hideToggle" (Json.Encode.bool value_)


{-| The shared `hideable` attribute.
-}
hideable : Bool -> Attr { c | hideable : Supported } msg
hideable value_ =
    Ir.property "hideable" (Json.Encode.bool value_)


{-| The shared `href` attribute.
-}
href : String -> Attr { c | href : Supported } msg
href =
    Ir.attribute "href"


{-| The shared `indeterminate` attribute.
-}
indeterminate : Bool -> Attr { c | indeterminate : Supported } msg
indeterminate value_ =
    Ir.property "indeterminate" (Json.Encode.bool value_)


{-| The shared `inline` attribute.
-}
inline : Bool -> Attr { c | inline : Supported } msg
inline value_ =
    Ir.property "inline" (Json.Encode.bool value_)


{-| The shared `inset` attribute.
-}
inset : Bool -> Attr { c | inset : Supported } msg
inset value_ =
    Ir.property "inset" (Json.Encode.bool value_)


{-| The shared `insetEnd` attribute.
-}
insetEnd : Bool -> Attr { c | insetEnd : Supported } msg
insetEnd value_ =
    Ir.property "insetEnd" (Json.Encode.bool value_)


{-| The shared `insetStart` attribute.
-}
insetStart : Bool -> Attr { c | insetStart : Supported } msg
insetStart value_ =
    Ir.property "insetStart" (Json.Encode.bool value_)


{-| The shared `invalid` attribute.
-}
invalid : Bool -> Attr { c | invalid : Supported } msg
invalid value_ =
    Ir.property "invalid" (Json.Encode.bool value_)


{-| The shared `inward` attribute.
-}
inward : Bool -> Attr { c | inward : Supported } msg
inward value_ =
    Ir.property "inward" (Json.Encode.bool value_)


{-| The shared `itemLabel` attribute.
-}
itemLabel : String -> Attr { c | itemLabel : Supported } msg
itemLabel =
    Ir.attribute "item-label"


{-| The shared `itemsPerPageLabel` attribute.
-}
itemsPerPageLabel : String -> Attr { c | itemsPerPageLabel : Supported } msg
itemsPerPageLabel =
    Ir.attribute "items-per-page-label"


{-| The shared `label` attribute.
-}
label : String -> Attr { c | label : Supported } msg
label =
    Ir.attribute "label"


{-| The shared `labelled` attribute.
-}
labelled : Bool -> Attr { c | labelled : Supported } msg
labelled value_ =
    Ir.property "labelled" (Json.Encode.bool value_)


{-| The shared `lastPageLabel` attribute.
-}
lastPageLabel : String -> Attr { c | lastPageLabel : Supported } msg
lastPageLabel =
    Ir.attribute "last-page-label"


{-| The shared `length` attribute.
-}
length : Float -> Attr { c | length : Supported } msg
length value_ =
    Ir.property "length" (Json.Encode.float value_)


{-| The shared `level` attribute.
-}
level : Int -> Attr { c | level : Supported } msg
level value_ =
    Ir.property "level" (Json.Encode.int value_)


{-| The shared `linear` attribute.
-}
linear : Bool -> Attr { c | linear : Supported } msg
linear value_ =
    Ir.property "linear" (Json.Encode.bool value_)


{-| The shared `loaded` attribute.
-}
loaded : Bool -> Attr { c | loaded : Supported } msg
loaded value_ =
    Ir.property "loaded" (Json.Encode.bool value_)


{-| The shared `loading` attribute.
-}
loading : Bool -> Attr { c | loading : Supported } msg
loading value_ =
    Ir.property "loading" (Json.Encode.bool value_)


{-| The shared `loadingLabel` attribute.
-}
loadingLabel : String -> Attr { c | loadingLabel : Supported } msg
loadingLabel =
    Ir.attribute "loading-label"


{-| The shared `lowered` attribute.
-}
lowered : Bool -> Attr { c | lowered : Supported } msg
lowered value_ =
    Ir.property "lowered" (Json.Encode.bool value_)


{-| The shared `max` attribute.
-}
max : Float -> Attr { c | max : Supported } msg
max value_ =
    Ir.property "max" (Json.Encode.float value_)


{-| The shared `maxDate` attribute.
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Ir.attribute "max-date"


{-| The shared `maxDepth` attribute.
-}
maxDepth : Float -> Attr { c | maxDepth : Supported } msg
maxDepth value_ =
    Ir.property "maxDepth" (Json.Encode.float value_)


{-| The shared `maxRows` attribute.
-}
maxRows : Float -> Attr { c | maxRows : Supported } msg
maxRows value_ =
    Ir.property "maxRows" (Json.Encode.float value_)


{-| The shared `min` attribute.
-}
min : Float -> Attr { c | min : Supported } msg
min value_ =
    Ir.property "min" (Json.Encode.float value_)


{-| The shared `minDate` attribute.
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Ir.attribute "min-date"


{-| The shared `minRows` attribute.
-}
minRows : Float -> Attr { c | minRows : Supported } msg
minRows value_ =
    Ir.property "minRows" (Json.Encode.float value_)


{-| The shared `modal` attribute.
-}
modal : Bool -> Attr { c | modal : Supported } msg
modal value_ =
    Ir.property "modal" (Json.Encode.bool value_)


{-| The shared `multi` attribute.
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi value_ =
    Ir.property "multi" (Json.Encode.bool value_)


{-| The shared `nextMonthLabel` attribute.
-}
nextMonthLabel : String -> Attr { c | nextMonthLabel : Supported } msg
nextMonthLabel =
    Ir.attribute "next-month-label"


{-| The shared `nextMultiYearLabel` attribute.
-}
nextMultiYearLabel : String -> Attr { c | nextMultiYearLabel : Supported } msg
nextMultiYearLabel =
    Ir.attribute "next-multi-year-label"


{-| The shared `nextPageLabel` attribute.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    Ir.attribute "next-page-label"


{-| The shared `nextYearLabel` attribute.
-}
nextYearLabel : String -> Attr { c | nextYearLabel : Supported } msg
nextYearLabel =
    Ir.attribute "next-year-label"


{-| The shared `noAnimate` attribute.
-}
noAnimate : Bool -> Attr { c | noAnimate : Supported } msg
noAnimate value_ =
    Ir.property "noAnimate" (Json.Encode.bool value_)


{-| The shared `noDataLabel` attribute.
-}
noDataLabel : String -> Attr { c | noDataLabel : Supported } msg
noDataLabel =
    Ir.attribute "no-data-label"


{-| The shared `noFocusTrap` attribute.
-}
noFocusTrap : Bool -> Attr { c | noFocusTrap : Supported } msg
noFocusTrap value_ =
    Ir.property "noFocusTrap" (Json.Encode.bool value_)


{-| The shared `open` attribute.
-}
open : Bool -> Attr { c | open : Supported } msg
open value_ =
    Ir.property "open" (Json.Encode.bool value_)


{-| The shared `opticalSize` attribute.
-}
opticalSize : Float -> Attr { c | opticalSize : Supported } msg
opticalSize value_ =
    Ir.property "opticalSize" (Json.Encode.float value_)


{-| The shared `optional` attribute.
-}
optional : Bool -> Attr { c | optional : Supported } msg
optional value_ =
    Ir.property "optional" (Json.Encode.bool value_)


{-| The shared `overshootLimit` attribute.
-}
overshootLimit : Float -> Attr { c | overshootLimit : Supported } msg
overshootLimit value_ =
    Ir.property "overshootLimit" (Json.Encode.float value_)


{-| The shared `pageIndex` attribute.
-}
pageIndex : Float -> Attr { c | pageIndex : Supported } msg
pageIndex value_ =
    Ir.property "pageIndex" (Json.Encode.float value_)


{-| The shared `pageSize` attribute.
-}
pageSize : String -> Attr { c | pageSize : Supported } msg
pageSize =
    Ir.attribute "page-size"


{-| The shared `pageSizes` attribute.
-}
pageSizes : String -> Attr { c | pageSizes : Supported } msg
pageSizes =
    Ir.attribute "page-sizes"


{-| The shared `panelClass` attribute.
-}
panelClass : String -> Attr { c | panelClass : Supported } msg
panelClass =
    Ir.attribute "panel-class"


{-| The shared `previousMonthLabel` attribute.
-}
previousMonthLabel : String -> Attr { c | previousMonthLabel : Supported } msg
previousMonthLabel =
    Ir.attribute "previous-month-label"


{-| The shared `previousMultiYearLabel` attribute.
-}
previousMultiYearLabel : String -> Attr { c | previousMultiYearLabel : Supported } msg
previousMultiYearLabel =
    Ir.attribute "previous-multi-year-label"


{-| The shared `previousPageLabel` attribute.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    Ir.attribute "previous-page-label"


{-| The shared `previousYearLabel` attribute.
-}
previousYearLabel : String -> Attr { c | previousYearLabel : Supported } msg
previousYearLabel =
    Ir.attribute "previous-year-label"


{-| The shared `radius` attribute.
-}
radius : Float -> Attr { c | radius : Supported } msg
radius value_ =
    Ir.property "radius" (Json.Encode.float value_)


{-| The shared `range` attribute.
-}
range : Bool -> Attr { c | range : Supported } msg
range value_ =
    Ir.property "range" (Json.Encode.bool value_)


{-| The shared `rangeEnd` attribute.
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    Ir.attribute "range-end"


{-| The shared `rangeStart` attribute.
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    Ir.attribute "range-start"


{-| The shared `rel` attribute.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Ir.attribute "rel"


{-| The shared `removable` attribute.
-}
removable : Bool -> Attr { c | removable : Supported } msg
removable value_ =
    Ir.property "removable" (Json.Encode.bool value_)


{-| The shared `removeLabel` attribute.
-}
removeLabel : String -> Attr { c | removeLabel : Supported } msg
removeLabel =
    Ir.attribute "remove-label"


{-| The shared `required` attribute.
-}
required : Bool -> Attr { c | required : Supported } msg
required value_ =
    Ir.property "required" (Json.Encode.bool value_)


{-| The shared `resultsLabel` attribute.
-}
resultsLabel : String -> Attr { c | resultsLabel : Supported } msg
resultsLabel =
    Ir.attribute "results-label"


{-| The shared `returnValue` attribute.
-}
returnValue : String -> Attr { c | returnValue : Supported } msg
returnValue =
    Ir.attribute "return-value"


{-| The shared `secondary` attribute.
-}
secondary : Bool -> Attr { c | secondary : Supported } msg
secondary value_ =
    Ir.property "secondary" (Json.Encode.bool value_)


{-| The shared `selected` attribute.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected value_ =
    Ir.property "selected" (Json.Encode.bool value_)


{-| The shared `selectedIndex` attribute.
-}
selectedIndex : Float -> Attr { c | selectedIndex : Supported } msg
selectedIndex value_ =
    Ir.property "selectedIndex" (Json.Encode.float value_)


{-| The shared `showDelay` attribute.
-}
showDelay : Float -> Attr { c | showDelay : Supported } msg
showDelay value_ =
    Ir.property "showDelay" (Json.Encode.float value_)


{-| The shared `showFirstLastButtons` attribute.
-}
showFirstLastButtons : Bool -> Attr { c | showFirstLastButtons : Supported } msg
showFirstLastButtons value_ =
    Ir.property "showFirstLastButtons" (Json.Encode.bool value_)


{-| The shared `start` attribute.
-}
start : Bool -> Attr { c | start : Supported } msg
start value_ =
    Ir.property "start" (Json.Encode.bool value_)


{-| The shared `startAt` attribute.
-}
startAt : String -> Attr { c | startAt : Supported } msg
startAt =
    Ir.attribute "start-at"


{-| The shared `startDivider` attribute.
-}
startDivider : Bool -> Attr { c | startDivider : Supported } msg
startDivider value_ =
    Ir.property "startDivider" (Json.Encode.bool value_)


{-| The shared `step` attribute.
-}
step : Float -> Attr { c | step : Supported } msg
step value_ =
    Ir.property "step" (Json.Encode.float value_)


{-| The shared `stretch` attribute.
-}
stretch : Bool -> Attr { c | stretch : Supported } msg
stretch value_ =
    Ir.property "stretch" (Json.Encode.bool value_)


{-| The shared `strongFocus` attribute.
-}
strongFocus : Bool -> Attr { c | strongFocus : Supported } msg
strongFocus value_ =
    Ir.property "strongFocus" (Json.Encode.bool value_)


{-| The shared `submenu` attribute.
-}
submenu : Bool -> Attr { c | submenu : Supported } msg
submenu value_ =
    Ir.property "submenu" (Json.Encode.bool value_)


{-| The shared `target` attribute.
-}
target : String -> Attr { c | target : Supported } msg
target =
    Ir.attribute "target"


{-| The shared `term` attribute.
-}
term : String -> Attr { c | term : Supported } msg
term =
    Ir.attribute "term"


{-| The shared `thin` attribute.
-}
thin : Bool -> Attr { c | thin : Supported } msg
thin value_ =
    Ir.property "thin" (Json.Encode.bool value_)


{-| The shared `threshold` attribute.
-}
threshold : Float -> Attr { c | threshold : Supported } msg
threshold value_ =
    Ir.property "threshold" (Json.Encode.float value_)


{-| The shared `tocIgnore` attribute.
-}
tocIgnore : Bool -> Attr { c | tocIgnore : Supported } msg
tocIgnore value_ =
    if value_ then
        Ir.attribute "m3e-toc-ignore" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `today` attribute.
-}
today : String -> Attr { c | today : Supported } msg
today =
    Ir.attribute "today"


{-| The shared `toggle` attribute.
-}
toggle : Bool -> Attr { c | toggle : Supported } msg
toggle value_ =
    Ir.property "toggle" (Json.Encode.bool value_)


{-| The shared `unbounded` attribute.
-}
unbounded : Bool -> Attr { c | unbounded : Supported } msg
unbounded value_ =
    Ir.property "unbounded" (Json.Encode.bool value_)


{-| The shared `value` attribute.
-}
value : String -> Attr { c | value : Supported } msg
value =
    Ir.attribute "value"


{-| The shared `valueformatter` attribute.
-}
valueformatter : String -> Attr { c | valueformatter : Supported } msg
valueformatter =
    Ir.attribute "valueFormatter"


{-| The shared `vertical` attribute.
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical value_ =
    Ir.property "vertical" (Json.Encode.bool value_)


{-| The shared `weight` attribute.
-}
weight : Int -> Attr { c | weight : Supported } msg
weight value_ =
    Ir.property "weight" (Json.Encode.int value_)


{-| The shared `wrap` attribute.
-}
wrap : Bool -> Attr { c | wrap : Supported } msg
wrap value_ =
    Ir.property "wrap" (Json.Encode.bool value_)


{-| The shared `wrapDetents` attribute.
-}
wrapDetents : Bool -> Attr { c | wrapDetents : Supported } msg
wrapDetents value_ =
    Ir.property "wrapDetents" (Json.Encode.bool value_)


{-| The `animation` union setter.
-}
animation : Value M3e.Values.Animation -> Attr { c | animation : Supported } msg
animation value_ =
    Ir.attribute "animation" (HtmlIr.Value.toString value_)


{-| The `contrast` union setter.
-}
contrast : Value M3e.Values.Contrast -> Attr { c | contrast : Supported } msg
contrast value_ =
    Ir.attribute "contrast" (HtmlIr.Value.toString value_)


{-| The `current` union setter.
-}
current : Value M3e.Values.Current -> Attr { c | current : Supported } msg
current value_ =
    Ir.attribute "current" (HtmlIr.Value.toString value_)


{-| The `dividers` union setter.
-}
dividers : Value M3e.Values.Dividers -> Attr { c | dividers : Supported } msg
dividers value_ =
    Ir.attribute "dividers" (HtmlIr.Value.toString value_)


{-| The `endMode` union setter.
-}
endMode : Value M3e.Values.EndMode -> Attr { c | endMode : Supported } msg
endMode value_ =
    Ir.attribute "end-mode" (HtmlIr.Value.toString value_)


{-| The `filter` union setter.
-}
filter : Value M3e.Values.Filter -> Attr { c | filter : Supported } msg
filter value_ =
    Ir.attribute "filter" (HtmlIr.Value.toString value_)


{-| The `floatLabel` union setter.
-}
floatLabel : Value M3e.Values.FloatLabel -> Attr { c | floatLabel : Supported } msg
floatLabel value_ =
    Ir.attribute "float-label" (HtmlIr.Value.toString value_)


{-| The `grade` union setter.
-}
grade : Value M3e.Values.Grade -> Attr { c | grade : Supported } msg
grade value_ =
    Ir.attribute "grade" (HtmlIr.Value.toString value_)


{-| The `headerPosition` union setter.
-}
headerPosition : Value M3e.Values.HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition value_ =
    Ir.attribute "header-position" (HtmlIr.Value.toString value_)


{-| The `hideSubscript` union setter.
-}
hideSubscript : Value M3e.Values.HideSubscript -> Attr { c | hideSubscript : Supported } msg
hideSubscript value_ =
    Ir.attribute "hide-subscript" (HtmlIr.Value.toString value_)


{-| The `highlightMode` union setter.
-}
highlightMode : Value M3e.Values.HighlightMode -> Attr { c | highlightMode : Supported } msg
highlightMode value_ =
    Ir.attribute "highlight-mode" (HtmlIr.Value.toString value_)


{-| The `icons` union setter.
-}
icons : Value M3e.Values.Icons -> Attr { c | icons : Supported } msg
icons value_ =
    Ir.attribute "icons" (HtmlIr.Value.toString value_)


{-| The `labelPosition` union setter.
-}
labelPosition : Value M3e.Values.LabelPosition -> Attr { c | labelPosition : Supported } msg
labelPosition value_ =
    Ir.attribute "label-position" (HtmlIr.Value.toString value_)


{-| The `mode` union setter.
-}
mode : Value M3e.Values.Mode -> Attr { c | mode : Supported } msg
mode value_ =
    Ir.attribute "mode" (HtmlIr.Value.toString value_)


{-| The `motion` union setter.
-}
motion : Value M3e.Values.Motion -> Attr { c | motion : Supported } msg
motion value_ =
    Ir.attribute "motion" (HtmlIr.Value.toString value_)


{-| The `name` union setter.
-}
name : Value M3e.Values.Name -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" (HtmlIr.Value.toString value_)


{-| The `orientation` union setter.
-}
orientation : Value M3e.Values.Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (HtmlIr.Value.toString value_)


{-| The `pageSizeVariant` union setter.
-}
pageSizeVariant : Value M3e.Values.PageSizeVariant -> Attr { c | pageSizeVariant : Supported } msg
pageSizeVariant value_ =
    Ir.attribute "page-size-variant" (HtmlIr.Value.toString value_)


{-| The `position` union setter.
-}
position : Value M3e.Values.Position -> Attr { c | position : Supported } msg
position value_ =
    Ir.attribute "position" (HtmlIr.Value.toString value_)


{-| The `positionX` union setter.
-}
positionX : Value M3e.Values.PositionX -> Attr { c | positionX : Supported } msg
positionX value_ =
    Ir.attribute "position-x" (HtmlIr.Value.toString value_)


{-| The `positionY` union setter.
-}
positionY : Value M3e.Values.PositionY -> Attr { c | positionY : Supported } msg
positionY value_ =
    Ir.attribute "position-y" (HtmlIr.Value.toString value_)


{-| The `scheme` union setter.
-}
scheme : Value M3e.Values.Scheme -> Attr { c | scheme : Supported } msg
scheme value_ =
    Ir.attribute "scheme" (HtmlIr.Value.toString value_)


{-| The `scrollStrategy` union setter.
-}
scrollStrategy : Value M3e.Values.ScrollStrategy -> Attr { c | scrollStrategy : Supported } msg
scrollStrategy value_ =
    Ir.attribute "scroll-strategy" (HtmlIr.Value.toString value_)


{-| The `shape` union setter.
-}
shape : Value M3e.Values.Shape -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" (HtmlIr.Value.toString value_)


{-| The `size` union setter.
-}
size : Value M3e.Values.Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (HtmlIr.Value.toString value_)


{-| The `startMode` union setter.
-}
startMode : Value M3e.Values.StartMode -> Attr { c | startMode : Supported } msg
startMode value_ =
    Ir.attribute "start-mode" (HtmlIr.Value.toString value_)


{-| The `startView` union setter.
-}
startView : Value M3e.Values.StartView -> Attr { c | startView : Supported } msg
startView value_ =
    Ir.attribute "start-view" (HtmlIr.Value.toString value_)


{-| The `state` union setter.
-}
state : Value M3e.Values.State -> Attr { c | state : Supported } msg
state value_ =
    Ir.attribute "state" (HtmlIr.Value.toString value_)


{-| The `toggleDirection` union setter.
-}
toggleDirection : Value M3e.Values.ToggleDirection -> Attr { c | toggleDirection : Supported } msg
toggleDirection value_ =
    Ir.attribute "toggle-direction" (HtmlIr.Value.toString value_)


{-| The `togglePosition` union setter.
-}
togglePosition : Value M3e.Values.TogglePosition -> Attr { c | togglePosition : Supported } msg
togglePosition value_ =
    Ir.attribute "toggle-position" (HtmlIr.Value.toString value_)


{-| The `touchGestures` union setter.
-}
touchGestures : Value M3e.Values.TouchGestures -> Attr { c | touchGestures : Supported } msg
touchGestures value_ =
    Ir.attribute "touch-gestures" (HtmlIr.Value.toString value_)


{-| The `type_` union setter.
-}
type_ : Value M3e.Values.Type -> Attr { c | type_ : Supported } msg
type_ value_ =
    Ir.attribute "type" (HtmlIr.Value.toString value_)


{-| The `variant` union setter.
-}
variant : Value M3e.Values.Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| The `width` union setter.
-}
width : Value M3e.Values.Width -> Attr { c | width : Supported } msg
width value_ =
    Ir.attribute "width" (HtmlIr.Value.toString value_)
