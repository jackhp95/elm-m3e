module M3e.Cem.Html.Vocab exposing
    ( action, actionable, activeDate, alert, anchorOffset, animation
    , ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered, checked
    , clearLabel, clearable, closeLabel, color, completed, confirmLabel, contained
    , contrast, current, date, density, detent, disableClose, disableHighlight
    , disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel
    , dismissible, dividers, download, duration, editable, elevated, emphasized
    , end, endDivider, endMode, extended, filled, filter, firstPageLabel
    , fitAnchorWidth, floatLabel, for, grade, handle, handleLabel, headerPosition
    , hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon
    , hideSelectionIndicator, hideSubscript, hideToggle, hideable, highlightMode, href, icons
    , indeterminate, inline, inset, insetEnd, insetStart, invalid, inward
    , itemLabel, itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel, length
    , level, linear, loaded, loading, loadingLabel, lowered, max
    , maxDate, maxDepth, maxRows, min, minDate, minRows, modal
    , mode, motion, multi, name, nextMonthLabel, nextMultiYearLabel, nextPageLabel
    , nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional
    , orientation, overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass
    , position, positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel
    , radius, range, rangeEnd, rangeStart, rel, removable, removeLabel
    , required, returnValue, scheme, scrollStrategy, secondary, selected, selectedIndex
    , shape, showDelay, showFirstLastButtons, size, start, startAt, startDivider
    , startMode, startView, state, step, stretch, strongFocus, submenu
    , target, term, thin, threshold, today, toggle, toggleDirection
    , togglePosition, touchGestures, type_, unbounded, value, variant, vertical
    , weight, width, wrap, wrapDetents, onChange, onOpening, onOpened
    , onClosing, onClosed, onClick, onBeforeinput, onInput, onBeforetoggle, onToggle
    , onValueChange, onQuery, onClear, onPage, onCancel, onRemove, onInvalid
    , onActiveChange, onHighlight
    )

{-|
Shared bottom vocabulary: every attribute (merged to one spec per name) and every event as raw, untyped `elm/html` setters. This is the single component-agnostic source the phantom middle vocab wraps — the rawest escape in the gradient.

@docs action, actionable, activeDate, alert, anchorOffset, animation
@docs ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered
@docs checked, clearLabel, clearable, closeLabel, color, completed
@docs confirmLabel, contained, contrast, current, date, density
@docs detent, disableClose, disableHighlight, disableHover, disablePagination, disableRestoreFocus
@docs disabled, disabledInteractive, discrete, dismissLabel, dismissible, dividers
@docs download, duration, editable, elevated, emphasized, end
@docs endDivider, endMode, extended, filled, filter, firstPageLabel
@docs fitAnchorWidth, floatLabel, for, grade, handle, handleLabel
@docs headerPosition, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize
@docs hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript, hideToggle, hideable
@docs highlightMode, href, icons, indeterminate, inline, inset
@docs insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel
@docs label, labelPosition, labelled, lastPageLabel, length, level
@docs linear, loaded, loading, loadingLabel, lowered, max
@docs maxDate, maxDepth, maxRows, min, minDate, minRows
@docs modal, mode, motion, multi, name, nextMonthLabel
@docs nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel, noFocusTrap
@docs open, opticalSize, optional, orientation, overshootLimit, pageIndex
@docs pageSize, pageSizeVariant, pageSizes, panelClass, position, positionX
@docs positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius
@docs range, rangeEnd, rangeStart, rel, removable, removeLabel
@docs required, returnValue, scheme, scrollStrategy, secondary, selected
@docs selectedIndex, shape, showDelay, showFirstLastButtons, size, start
@docs startAt, startDivider, startMode, startView, state, step
@docs stretch, strongFocus, submenu, target, term, thin
@docs threshold, today, toggle, toggleDirection, togglePosition, touchGestures
@docs type_, unbounded, value, variant, vertical, weight
@docs width, wrap, wrapDetents, onChange, onOpening, onOpened
@docs onClosing, onClosed, onClick, onBeforeinput, onInput, onBeforetoggle
@docs onToggle, onValueChange, onQuery, onClear, onPage, onCancel
@docs onRemove, onInvalid, onActiveChange, onHighlight
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> Html.Attribute msg
action =
    Html.Attributes.attribute "action"


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable : Bool -> Html.Attribute msg
actionable val_ =
    Html.Attributes.property "actionable" (Json.Encode.bool val_)


{-| The active date. (default: `new Date()`) -}
activeDate : String -> Html.Attribute msg
activeDate =
    Html.Attributes.attribute "active-date"


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> Html.Attribute msg
alert val_ =
    Html.Attributes.property "alert" (Json.Encode.bool val_)


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchorOffset" (Json.Encode.float val_)


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation : String -> Html.Attribute msg
animation =
    Html.Attributes.attribute "animation"


{-| Set the `aria-invalid` attribute. -}
ariaInvalid : String -> Html.Attribute msg
ariaInvalid =
    Html.Attributes.attribute "aria-invalid"


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate : Bool -> Html.Attribute msg
autoActivate val_ =
    Html.Attributes.property "autoActivate" (Json.Encode.bool val_)


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "bufferValue" (Json.Encode.float val_)


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    Html.Attributes.property "cascade" (Json.Encode.bool val_)


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "caseSensitive" (Json.Encode.bool val_)


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel =
    Html.Attributes.attribute "clear-label"


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> Html.Attribute msg
color =
    Html.Attributes.attribute "color"


{-| Whether the step has been completed. (default: `false`) -}
completed : Bool -> Html.Attribute msg
completed val_ =
    Html.Attributes.property "completed" (Json.Encode.bool val_)


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel : String -> Html.Attribute msg
confirmLabel =
    Html.Attributes.attribute "confirm-label"


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained : Bool -> Html.Attribute msg
contained val_ =
    Html.Attributes.property "contained" (Json.Encode.bool val_)


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast : String -> Html.Attribute msg
contrast =
    Html.Attributes.attribute "contrast"


{-| Indicates the current item in the breadcrumb path. -}
current : String -> Html.Attribute msg
current =
    Html.Attributes.attribute "current"


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date =
    Html.Attributes.attribute "date"


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    Html.Attributes.property "disableClose" (Json.Encode.bool val_)


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight : Bool -> Html.Attribute msg
disableHighlight val_ =
    Html.Attributes.property "disableHighlight" (Json.Encode.bool val_)


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Html.Attribute msg
disableHover val_ =
    Html.Attributes.property "disableHover" (Json.Encode.bool val_)


{-| Whether scroll buttons are disabled. -}
disablePagination : String -> Html.Attribute msg
disablePagination =
    Html.Attributes.attribute "disable-pagination"


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus : Bool -> Html.Attribute msg
disableRestoreFocus val_ =
    Html.Attributes.property "disableRestoreFocus" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> Html.Attribute msg
discrete val_ =
    Html.Attributes.property "discrete" (Json.Encode.bool val_)


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel : String -> Html.Attribute msg
dismissLabel =
    Html.Attributes.attribute "dismiss-label"


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers : String -> Html.Attribute msg
dividers =
    Html.Attributes.attribute "dividers"


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> Html.Attribute msg
duration val_ =
    Html.Attributes.property "duration" (Json.Encode.float val_)


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> Html.Attribute msg
editable val_ =
    Html.Attributes.property "editable" (Json.Encode.bool val_)


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    Html.Attributes.property "elevated" (Json.Encode.bool val_)


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> Html.Attribute msg
end val_ =
    Html.Attributes.property "end" (Json.Encode.bool val_)


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider : Bool -> Html.Attribute msg
endDivider val_ =
    Html.Attributes.property "endDivider" (Json.Encode.bool val_)


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode : String -> Html.Attribute msg
endMode =
    Html.Attributes.attribute "end-mode"


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> Html.Attribute msg
filled val_ =
    Html.Attributes.property "filled" (Json.Encode.bool val_)


{-| Mode in which to filter options. (default: `"contains"`) -}
filter : String -> Html.Attribute msg
filter =
    Html.Attributes.attribute "filter"


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel : String -> Html.Attribute msg
firstPageLabel =
    Html.Attributes.attribute "first-page-label"


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fitAnchorWidth" (Json.Encode.bool val_)


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel : String -> Html.Attribute msg
floatLabel =
    Html.Attributes.attribute "float-label"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The grade of the icon. (default: `"medium"`) -}
grade : String -> Html.Attribute msg
grade =
    Html.Attributes.attribute "grade"


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> Html.Attribute msg
handle val_ =
    Html.Attributes.property "handle" (Json.Encode.bool val_)


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel : String -> Html.Attribute msg
handleLabel =
    Html.Attributes.attribute "handle-label"


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition : String -> Html.Attribute msg
headerPosition =
    Html.Attributes.attribute "header-position"


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction : Float -> Html.Attribute msg
hideFriction val_ =
    Html.Attributes.property "hideFriction" (Json.Encode.float val_)


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading : Bool -> Html.Attribute msg
hideLoading val_ =
    Html.Attributes.property "hideLoading" (Json.Encode.bool val_)


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData : Bool -> Html.Attribute msg
hideNoData val_ =
    Html.Attributes.property "hideNoData" (Json.Encode.bool val_)


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize : Bool -> Html.Attribute msg
hidePageSize val_ =
    Html.Attributes.property "hidePageSize" (Json.Encode.bool val_)


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker : Bool -> Html.Attribute msg
hideRequiredMarker val_ =
    Html.Attributes.property "hideRequiredMarker" (Json.Encode.bool val_)


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon : Bool -> Html.Attribute msg
hideSearchIcon val_ =
    Html.Attributes.property "hideSearchIcon" (Json.Encode.bool val_)


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hideSelectionIndicator" (Json.Encode.bool val_)


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript : String -> Html.Attribute msg
hideSubscript =
    Html.Attributes.attribute "hide-subscript"


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hideToggle" (Json.Encode.bool val_)


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> Html.Attribute msg
hideable val_ =
    Html.Attributes.property "hideable" (Json.Encode.bool val_)


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode : String -> Html.Attribute msg
highlightMode =
    Html.Attributes.attribute "highlight-mode"


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The icons to present. (default: `"none"`) -}
icons : String -> Html.Attribute msg
icons =
    Html.Attributes.attribute "icons"


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> Html.Attribute msg
inline val_ =
    Html.Attributes.property "inline" (Json.Encode.bool val_)


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> Html.Attribute msg
inset val_ =
    Html.Attributes.property "inset" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    Html.Attributes.property "insetEnd" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    Html.Attributes.property "insetStart" (Json.Encode.bool val_)


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> Html.Attribute msg
invalid val_ =
    Html.Attributes.property "invalid" (Json.Encode.bool val_)


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> Html.Attribute msg
inward val_ =
    Html.Attributes.property "inward" (Json.Encode.bool val_)


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel : String -> Html.Attribute msg
itemLabel =
    Html.Attributes.attribute "item-label"


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel : String -> Html.Attribute msg
itemsPerPageLabel =
    Html.Attributes.attribute "items-per-page-label"


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> Html.Attribute msg
label =
    Html.Attributes.attribute "label"


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition : String -> Html.Attribute msg
labelPosition =
    Html.Attributes.attribute "label-position"


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> Html.Attribute msg
labelled val_ =
    Html.Attributes.property "labelled" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel : String -> Html.Attribute msg
lastPageLabel =
    Html.Attributes.attribute "last-page-label"


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> Html.Attribute msg
length val_ =
    Html.Attributes.property "length" (Json.Encode.float val_)


{-| The accessibility level of the heading. -}
level : String -> Html.Attribute msg
level =
    Html.Attributes.attribute "level"


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> Html.Attribute msg
linear val_ =
    Html.Attributes.property "linear" (Json.Encode.bool val_)


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> Html.Attribute msg
loading val_ =
    Html.Attributes.property "loading" (Json.Encode.bool val_)


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel : String -> Html.Attribute msg
loadingLabel =
    Html.Attributes.attribute "loading-label"


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate =
    Html.Attributes.attribute "max-date"


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.property "maxDepth" (Json.Encode.float val_)


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> Html.Attribute msg
maxRows val_ =
    Html.Attributes.property "maxRows" (Json.Encode.float val_)


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> Html.Attribute msg
min val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate =
    Html.Attributes.attribute "min-date"


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> Html.Attribute msg
minRows val_ =
    Html.Attributes.property "minRows" (Json.Encode.float val_)


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> Html.Attribute msg
modal val_ =
    Html.Attributes.property "modal" (Json.Encode.bool val_)


{-| The behavior mode of the view. (default: `"docked"`) -}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| The motion scheme. (default: `"standard"`) -}
motion : String -> Html.Attribute msg
motion =
    Html.Attributes.attribute "motion"


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel =
    Html.Attributes.attribute "next-month-label"


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel =
    Html.Attributes.attribute "next-multi-year-label"


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel =
    Html.Attributes.attribute "next-page-label"


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel =
    Html.Attributes.attribute "next-year-label"


{-| Whether to disable animation. (default: `false`) -}
noAnimate : Bool -> Html.Attribute msg
noAnimate val_ =
    Html.Attributes.property "noAnimate" (Json.Encode.bool val_)


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel : String -> Html.Attribute msg
noDataLabel =
    Html.Attributes.attribute "no-data-label"


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    Html.Attributes.property "noFocusTrap" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "opticalSize" (Json.Encode.float val_)


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> Html.Attribute msg
optional val_ =
    Html.Attributes.property "optional" (Json.Encode.bool val_)


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshootLimit" (Json.Encode.float val_)


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex : Float -> Html.Attribute msg
pageIndex val_ =
    Html.Attributes.property "pageIndex" (Json.Encode.float val_)


{-| The number of items to display in a page. (default: `50`) -}
pageSize : String -> Html.Attribute msg
pageSize =
    Html.Attributes.attribute "page-size"


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant : String -> Html.Attribute msg
pageSizeVariant =
    Html.Attributes.attribute "page-size-variant"


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes : String -> Html.Attribute msg
pageSizes =
    Html.Attributes.attribute "page-sizes"


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass : String -> Html.Attribute msg
panelClass =
    Html.Attributes.attribute "panel-class"


{-| The position of the tooltip. (default: `"below"`) -}
position : String -> Html.Attribute msg
position =
    Html.Attributes.attribute "position"


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX : String -> Html.Attribute msg
positionX =
    Html.Attributes.attribute "position-x"


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY : String -> Html.Attribute msg
positionY =
    Html.Attributes.attribute "position-y"


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel =
    Html.Attributes.attribute "previous-month-label"


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel =
    Html.Attributes.attribute "previous-multi-year-label"


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel =
    Html.Attributes.attribute "previous-page-label"


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel =
    Html.Attributes.attribute "previous-year-label"


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> Html.Attribute msg
radius val_ =
    Html.Attributes.property "radius" (Json.Encode.float val_)


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> Html.Attribute msg
range val_ =
    Html.Attributes.property "range" (Json.Encode.bool val_)


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd =
    Html.Attributes.attribute "range-end"


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart =
    Html.Attributes.attribute "range-start"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| Whether the chip is removable. (default: `false`) -}
removable : Bool -> Html.Attribute msg
removable val_ =
    Html.Attributes.property "removable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel : String -> Html.Attribute msg
removeLabel =
    Html.Attributes.attribute "remove-label"


{-| Whether the element is required. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| The value to return from the dialog. (default: `""`) -}
returnValue : String -> Html.Attribute msg
returnValue =
    Html.Attributes.attribute "return-value"


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : String -> Html.Attribute msg
scheme =
    Html.Attributes.attribute "scheme"


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy : String -> Html.Attribute msg
scrollStrategy =
    Html.Attributes.attribute "scroll-strategy"


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    Html.Attributes.property "secondary" (Json.Encode.bool val_)


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex : Float -> Html.Attribute msg
selectedIndex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)


{-| The shape of the toolbar. (default: `"square"`) -}
shape : String -> Html.Attribute msg
shape =
    Html.Attributes.attribute "shape"


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons : Bool -> Html.Attribute msg
showFirstLastButtons val_ =
    Html.Attributes.property "showFirstLastButtons" (Json.Encode.bool val_)


{-| The size of the button. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> Html.Attribute msg
start val_ =
    Html.Attributes.property "start" (Json.Encode.bool val_)


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt =
    Html.Attributes.attribute "start-at"


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider : Bool -> Html.Attribute msg
startDivider val_ =
    Html.Attributes.property "startDivider" (Json.Encode.bool val_)


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode : String -> Html.Attribute msg
startMode =
    Html.Attributes.attribute "start-mode"


{-| The initial view used to select a date. (default: `"month"`) -}
startView : String -> Html.Attribute msg
startView =
    Html.Attributes.attribute "start-view"


{-| The state for which to present content. (default: `"content"`) -}
state : String -> Html.Attribute msg
state =
    Html.Attributes.attribute "state"


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> Html.Attribute msg
stretch val_ =
    Html.Attributes.property "stretch" (Json.Encode.bool val_)


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strongFocus" (Json.Encode.bool val_)


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    Html.Attributes.property "submenu" (Json.Encode.bool val_)


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| The search term to highlight. (default: `""`) -}
term : String -> Html.Attribute msg
term =
    Html.Attributes.attribute "term"


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> Html.Attribute msg
thin val_ =
    Html.Attributes.property "thin" (Json.Encode.bool val_)


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold : Float -> Html.Attribute msg
threshold val_ =
    Html.Attributes.property "threshold" (Json.Encode.float val_)


{-| Today's date. (default: `new Date()`) -}
today : String -> Html.Attribute msg
today =
    Html.Attributes.attribute "today"


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    Html.Attributes.property "toggle" (Json.Encode.bool val_)


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : String -> Html.Attribute msg
toggleDirection =
    Html.Attributes.attribute "toggle-direction"


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : String -> Html.Attribute msg
togglePosition =
    Html.Attributes.attribute "toggle-position"


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : String -> Html.Attribute msg
touchGestures =
    Html.Attributes.attribute "touch-gestures"


{-| The type of the element. (default: `"button"`) -}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded : Bool -> Html.Attribute msg
unbounded val_ =
    Html.Attributes.property "unbounded" (Json.Encode.bool val_)


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> Html.Attribute msg
weight =
    Html.Attributes.attribute "weight"


{-| The width of the button. (default: `"default"`) -}
width : String -> Html.Attribute msg
width =
    Html.Attributes.attribute "width"


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> Html.Attribute msg
wrap val_ =
    Html.Attributes.property "wrap" (Json.Encode.bool val_)


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents : Bool -> Html.Attribute msg
wrapDetents val_ =
    Html.Attributes.property "wrapDetents" (Json.Encode.bool val_)


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `opening` events. -}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening =
    Html.Events.on "opening"


{-| Listen for `opened` events. -}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened =
    Html.Events.on "opened"


{-| Listen for `closing` events. -}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing =
    Html.Events.on "closing"


{-| Listen for `closed` events. -}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed =
    Html.Events.on "closed"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"


{-| Listen for `value-change` events. -}
onValueChange : Json.Decode.Decoder msg -> Html.Attribute msg
onValueChange =
    Html.Events.on "value-change"


{-| Listen for `query` events. -}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery =
    Html.Events.on "query"


{-| Listen for `clear` events. -}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear =
    Html.Events.on "clear"


{-| Listen for `page` events. -}
onPage : Json.Decode.Decoder msg -> Html.Attribute msg
onPage =
    Html.Events.on "page"


{-| Listen for `cancel` events. -}
onCancel : Json.Decode.Decoder msg -> Html.Attribute msg
onCancel =
    Html.Events.on "cancel"


{-| Listen for `remove` events. -}
onRemove : Json.Decode.Decoder msg -> Html.Attribute msg
onRemove =
    Html.Events.on "remove"


{-| Listen for `invalid` events. -}
onInvalid : Json.Decode.Decoder msg -> Html.Attribute msg
onInvalid =
    Html.Events.on "invalid"


{-| Listen for `active-change` events. -}
onActiveChange : Json.Decode.Decoder msg -> Html.Attribute msg
onActiveChange =
    Html.Events.on "active-change"


{-| Listen for `highlight` events. -}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight =
    Html.Events.on "highlight"