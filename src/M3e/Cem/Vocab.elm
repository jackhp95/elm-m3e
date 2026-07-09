module M3e.Cem.Vocab exposing
    ( action, actionable, active, activeDate, alert, anchorOffset
    , animation, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered
    , checked, clearLabel, clearable, closeLabel, color, completed, confirmLabel
    , contained, contrast, current, date, density, detent, disableClose
    , disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete
    , dismissLabel, dismissible, dividers, download, duration, editable, elevated
    , emphasized, end, endDivider, endMode, extended, filled, filter
    , firstPageLabel, fitAnchorWidth, floatLabel, for, grade, handle, handleLabel
    , headerPosition, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker
    , hideSearchIcon, hideSelectionIndicator, hideSubscript, hideToggle, hideable, highlightMode, href
    , icons, indeterminate, inline, inset, insetEnd, insetStart, invalid
    , inward, itemLabel, itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel
    , length, level, linear, loaded, loading, loadingLabel, lowered
    , max, maxDate, maxDepth, maxRows, min, minDate, minRows
    , modal, mode, motion, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel
    , nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional
    , orientation, overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass
    , position, positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel
    , radius, range, rangeEnd, rangeStart, rel, removable, removeLabel
    , required, returnValue, scheme, scrollStrategy, secondary, selected, selectedIndex
    , shape, showDelay, showFirstLastButtons, size, start, startAt, startDivider
    , startMode, startView, state, step, stretch, strongFocus, submenu
    , target, term, thin, threshold, today, toggle, toggleDirection
    , togglePosition, touchGestures, type_, unbounded, variant, vertical, weight
    , width, wrap, wrapDetents, name, valueFloat, value, onChange
    , onOpening, onOpened, onClosing, onClosed, onClick, onBeforeinput, onInput
    , onBeforetoggle, onToggle, onValueChange, onQuery, onClear, onPage, onCancel
    , onRemove, onInvalid, onActiveChange, onHighlight, slotLeading, slotTitle, slotSubtitle
    , slotTrailing, slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader
    , slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter, slotCloseIcon
    , slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon, slotItems, slotLabel
    , slotPrefix, slotPrefixText, slotSuffix, slotSuffixText, slotHint, slotError, slotAvatar
    , slotRemoveIcon, slotInput, slotBadge, slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon
    , slotSubhead, slotClearIcon, slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon
    , slotArrow, slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon
    , slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon
    )

{-|
Shared middle vocabulary: the component-agnostic, phantom-gated attribute, event, and slot setters — ONE polymorphic function per name, each carrying an OPEN capability row so it type-checks against any component that admits it. The loose counterpart to the strict per-component modules.

@docs action, actionable, active, activeDate, alert, anchorOffset
@docs animation, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive
@docs centered, checked, clearLabel, clearable, closeLabel, color
@docs completed, confirmLabel, contained, contrast, current, date
@docs density, detent, disableClose, disableHighlight, disableHover, disablePagination
@docs disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible
@docs dividers, download, duration, editable, elevated, emphasized
@docs end, endDivider, endMode, extended, filled, filter
@docs firstPageLabel, fitAnchorWidth, floatLabel, for, grade, handle
@docs handleLabel, headerPosition, hideDelay, hideFriction, hideLoading, hideNoData
@docs hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript, hideToggle
@docs hideable, highlightMode, href, icons, indeterminate, inline
@docs inset, insetEnd, insetStart, invalid, inward, itemLabel
@docs itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel, length
@docs level, linear, loaded, loading, loadingLabel, lowered
@docs max, maxDate, maxDepth, maxRows, min, minDate
@docs minRows, modal, mode, motion, multi, nextMonthLabel
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
@docs type_, unbounded, variant, vertical, weight, width
@docs wrap, wrapDetents, name, valueFloat, value, onChange
@docs onOpening, onOpened, onClosing, onClosed, onClick, onBeforeinput
@docs onInput, onBeforetoggle, onToggle, onValueChange, onQuery, onClear
@docs onPage, onCancel, onRemove, onInvalid, onActiveChange, onHighlight
@docs slotLeading, slotTitle, slotSubtitle, slotTrailing, slotLeadingIcon, slotTrailingIcon
@docs slotIcon, slotLoading, slotNoData, slotHeader, slotSeparator, slotSelected
@docs slotSelectedIcon, slotContent, slotActions, slotFooter, slotCloseIcon, slotStart
@docs slotEnd, slotOverline, slotSupportingText, slotToggleIcon, slotItems, slotLabel
@docs slotPrefix, slotPrefixText, slotSuffix, slotSuffixText, slotHint, slotError
@docs slotAvatar, slotRemoveIcon, slotInput, slotBadge, slotFirstPageIcon, slotPreviousPageIcon
@docs slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon, slotOpenLeading, slotOpenTrailing
@docs slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow, slotValue, slotNextIcon
@docs slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon, slotEditIcon, slotErrorIcon
@docs slotStep, slotPanel, slotOpenToggleIcon
-}


import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Vocab
import M3e.Element
import M3e.Element.Internal
import M3e.Value


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> M3e.Cem.Attr.Attr { c | action : M3e.Value.Supported } msg
action =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool -> M3e.Cem.Attr.Attr { c | actionable : M3e.Value.Supported } msg
actionable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.actionable


{-| Whether the view is active. (default: `false`) -}
active : Bool -> M3e.Cem.Attr.Attr { c | active : M3e.Value.Supported } msg
active =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.active


{-| The active date. (default: `new Date()`) -}
activeDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
activeDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.activeDate


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> M3e.Cem.Attr.Attr { c | alert : M3e.Value.Supported } msg
alert =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float -> M3e.Cem.Attr.Attr { c | anchorOffset : M3e.Value.Supported } msg
anchorOffset =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.anchorOffset


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animation v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.animation
        (M3e.Value.toString v_)


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String -> M3e.Cem.Attr.Attr { c | ariaInvalid : M3e.Value.Supported } msg
ariaInvalid =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool -> M3e.Cem.Attr.Attr { c | autoActivate : M3e.Value.Supported } msg
autoActivate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue :
    Float -> M3e.Cem.Attr.Attr { c | bufferValue : M3e.Value.Supported } msg
bufferValue =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> M3e.Cem.Attr.Attr { c | cascade : M3e.Value.Supported } msg
cascade =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.cascade


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.centered


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
clearable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.color


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool -> M3e.Cem.Attr.Attr { c | completed : M3e.Value.Supported } msg
completed =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel :
    String -> M3e.Cem.Attr.Attr { c | confirmLabel : M3e.Value.Supported } msg
confirmLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool -> M3e.Cem.Attr.Attr { c | contained : M3e.Value.Supported } msg
contained =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.contained


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrast v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.contrast
        (M3e.Value.toString v_)


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
current v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.current
        (M3e.Value.toString v_)


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.date


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> M3e.Cem.Attr.Attr { c | density : M3e.Value.Supported } msg
density =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.density


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
detent =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.detent


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool -> M3e.Cem.Attr.Attr { c | disableClose : M3e.Value.Supported } msg
disableClose =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disableClose


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool -> M3e.Cem.Attr.Attr { c | disableHighlight : M3e.Value.Supported } msg
disableHighlight =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover :
    Bool -> M3e.Cem.Attr.Attr { c | disableHover : M3e.Value.Supported } msg
disableHover =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disableHover


{-| Whether scroll buttons are disabled. -}
disablePagination :
    M3e.Value.Value { true : M3e.Value.Supported
    , false : M3e.Value.Supported
    , auto : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePagination v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.disablePagination
        (M3e.Value.toString v_)


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus :
    Bool
    -> M3e.Cem.Attr.Attr { c | disableRestoreFocus : M3e.Value.Supported } msg
disableRestoreFocus =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.disabledInteractive


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> M3e.Cem.Attr.Attr { c | discrete : M3e.Value.Supported } msg
discrete =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel :
    String -> M3e.Cem.Attr.Attr { c | dismissLabel : M3e.Value.Supported } msg
dismissLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.dismissible


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividers v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.dividers
        (M3e.Value.toString v_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> M3e.Cem.Attr.Attr { c | duration : M3e.Value.Supported } msg
duration =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> M3e.Cem.Attr.Attr { c | editable : M3e.Value.Supported } msg
editable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.editable


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
elevated =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool -> M3e.Cem.Attr.Attr { c | emphasized : M3e.Value.Supported } msg
emphasized =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.emphasized


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> M3e.Cem.Attr.Attr { c | end : M3e.Value.Supported } msg
end =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider :
    Bool -> M3e.Cem.Attr.Attr { c | endDivider : M3e.Value.Supported } msg
endDivider =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.endDivider


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endMode v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.endMode
        (M3e.Value.toString v_)


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> M3e.Cem.Attr.Attr { c | extended : M3e.Value.Supported } msg
extended =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.extended


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> M3e.Cem.Attr.Attr { c | filled : M3e.Value.Supported } msg
filled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.filled


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filter v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.filter
        (M3e.Value.toString v_)


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel :
    String -> M3e.Cem.Attr.Attr { c | firstPageLabel : M3e.Value.Supported } msg
firstPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool -> M3e.Cem.Attr.Attr { c | fitAnchorWidth : M3e.Value.Supported } msg
fitAnchorWidth =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.fitAnchorWidth


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabel v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.floatLabel
        (M3e.Value.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.for


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
grade v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.grade
        (M3e.Value.toString v_)


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Cem.Attr.Attr { c | handle : M3e.Value.Supported } msg
handle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel :
    String -> M3e.Cem.Attr.Attr { c | handleLabel : M3e.Value.Supported } msg
handleLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.handleLabel


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , above : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPosition v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.headerPosition
        (M3e.Value.toString v_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction :
    Float -> M3e.Cem.Attr.Attr { c | hideFriction : M3e.Value.Supported } msg
hideFriction =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool -> M3e.Cem.Attr.Attr { c | hideLoading : M3e.Value.Supported } msg
hideLoading =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool -> M3e.Cem.Attr.Attr { c | hideNoData : M3e.Value.Supported } msg
hideNoData =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideNoData


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize :
    Bool -> M3e.Cem.Attr.Attr { c | hidePageSize : M3e.Value.Supported } msg
hidePageSize =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> M3e.Cem.Attr.Attr { c | hideRequiredMarker : M3e.Value.Supported } msg
hideRequiredMarker =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool -> M3e.Cem.Attr.Attr { c | hideSearchIcon : M3e.Value.Supported } msg
hideSearchIcon =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideSelectionIndicator


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscript v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.hideSubscript
        (M3e.Value.toString v_)


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> M3e.Cem.Attr.Attr { c | hideable : M3e.Value.Supported } msg
hideable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.hideable


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightMode v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.highlightMode
        (M3e.Value.toString v_)


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.href


{-| The icons to present. (default: `"none"`) -}
icons :
    M3e.Value.Value { both : M3e.Value.Supported
    , none : M3e.Value.Supported
    , selected : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
icons v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.icons
        (M3e.Value.toString v_)


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> M3e.Cem.Attr.Attr { c | inline : M3e.Value.Supported } msg
inline =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> M3e.Cem.Attr.Attr { c | inset : M3e.Value.Supported } msg
inset =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> M3e.Cem.Attr.Attr { c | insetEnd : M3e.Value.Supported } msg
insetEnd =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool -> M3e.Cem.Attr.Attr { c | insetStart : M3e.Value.Supported } msg
insetStart =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.insetStart


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> M3e.Cem.Attr.Attr { c | invalid : M3e.Value.Supported } msg
invalid =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> M3e.Cem.Attr.Attr { c | inward : M3e.Value.Supported } msg
inward =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.inward


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel :
    String -> M3e.Cem.Attr.Attr { c | itemLabel : M3e.Value.Supported } msg
itemLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | itemsPerPageLabel : M3e.Value.Supported } msg
itemsPerPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
label =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.label


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPosition v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.labelPosition
        (M3e.Value.toString v_)


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> M3e.Cem.Attr.Attr { c | labelled : M3e.Value.Supported } msg
labelled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel :
    String -> M3e.Cem.Attr.Attr { c | lastPageLabel : M3e.Value.Supported } msg
lastPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> M3e.Cem.Attr.Attr { c | length : M3e.Value.Supported } msg
length =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.length


{-| The accessibility level of the heading. -}
level : Int -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> M3e.Cem.Attr.Attr { c | linear : M3e.Value.Supported } msg
linear =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
loaded =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.loaded


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> M3e.Cem.Attr.Attr { c | loading : M3e.Value.Supported } msg
loading =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String -> M3e.Cem.Attr.Attr { c | loadingLabel : M3e.Value.Supported } msg
loadingLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> M3e.Cem.Attr.Attr { c | lowered : M3e.Value.Supported } msg
lowered =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.lowered


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.max


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.maxDate


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
maxDepth =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
maxRows =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
min =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.min


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
minRows =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> M3e.Cem.Attr.Attr { c | modal : M3e.Value.Supported } msg
modal =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.modal


{-| The behavior mode of the view. (default: `"docked"`) -}
mode :
    M3e.Value.Value { docked : M3e.Value.Supported
    , fullscreen : M3e.Value.Supported
    , buffer : M3e.Value.Supported
    , determinate : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , query : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    , contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.mode
        (M3e.Value.toString v_)


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motion v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.motion
        (M3e.Value.toString v_)


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
nextMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
nextMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
nextYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.nextYearLabel


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool -> M3e.Cem.Attr.Attr { c | noAnimate : M3e.Value.Supported } msg
noAnimate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String -> M3e.Cem.Attr.Attr { c | noDataLabel : M3e.Value.Supported } msg
noDataLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool -> M3e.Cem.Attr.Attr { c | noFocusTrap : M3e.Value.Supported } msg
noFocusTrap =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.noFocusTrap


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float -> M3e.Cem.Attr.Attr { c | opticalSize : M3e.Value.Supported } msg
opticalSize =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.opticalSize


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> M3e.Cem.Attr.Attr { c | optional : M3e.Value.Supported } msg
optional =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.optional


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.orientation
        (M3e.Value.toString v_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex :
    Float -> M3e.Cem.Attr.Attr { c | pageIndex : M3e.Value.Supported } msg
pageIndex =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.pageIndex


{-| The number of items to display in a page. (default: `50`) -}
pageSize :
    M3e.Value.Value { number : M3e.Value.Supported, all : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | pageSize : M3e.Value.Supported } msg
pageSize v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.pageSize
        (M3e.Value.toString v_)


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.pageSizeVariant
        (M3e.Value.toString v_)


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes :
    String -> M3e.Cem.Attr.Attr { c | pageSizes : M3e.Value.Supported } msg
pageSizes =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
panelClass =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.panelClass


{-| The position of the tooltip. (default: `"below"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.position
        (M3e.Value.toString v_)


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionX v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.positionX
        (M3e.Value.toString v_)


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionY v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.positionY
        (M3e.Value.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
previousMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
previousMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
previousYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> M3e.Cem.Attr.Attr { c | radius : M3e.Value.Supported } msg
radius =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.radius


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> M3e.Cem.Attr.Attr { c | range : M3e.Value.Supported } msg
range =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.range


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.rangeEnd


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.rel


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool -> M3e.Cem.Attr.Attr { c | removable : M3e.Value.Supported } msg
removable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String -> M3e.Cem.Attr.Attr { c | removeLabel : M3e.Value.Supported } msg
removeLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.removeLabel


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.required


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
returnValue =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.returnValue


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.scheme
        (M3e.Value.toString v_)


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategy v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.scrollStrategy
        (M3e.Value.toString v_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary :
    Bool -> M3e.Cem.Attr.Attr { c | secondary : M3e.Value.Supported } msg
secondary =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.secondary


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.selected


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float -> M3e.Cem.Attr.Attr { c | selectedIndex : M3e.Value.Supported } msg
selectedIndex =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.selectedIndex


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.shape
        (M3e.Value.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.showDelay


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons :
    Bool
    -> M3e.Cem.Attr.Attr { c | showFirstLastButtons : M3e.Value.Supported } msg
showFirstLastButtons =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.showFirstLastButtons


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.size
        (M3e.Value.toString v_)


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> M3e.Cem.Attr.Attr { c | start : M3e.Value.Supported } msg
start =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
startAt =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider :
    Bool -> M3e.Cem.Attr.Attr { c | startDivider : M3e.Value.Supported } msg
startDivider =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.startDivider


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startMode v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.startMode
        (M3e.Value.toString v_)


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startView v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.startView
        (M3e.Value.toString v_)


{-| The state for which to present content. (default: `"content"`) -}
state :
    M3e.Value.Value { content : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
state v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.state
        (M3e.Value.toString v_)


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
step =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.step


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> M3e.Cem.Attr.Attr { c | stretch : M3e.Value.Supported } msg
stretch =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.stretch


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool -> M3e.Cem.Attr.Attr { c | strongFocus : M3e.Value.Supported } msg
strongFocus =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
submenu =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.submenu


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.target


{-| The search term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.term


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> M3e.Cem.Attr.Attr { c | thin : M3e.Value.Supported } msg
thin =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float -> M3e.Cem.Attr.Attr { c | threshold : M3e.Value.Supported } msg
threshold =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.threshold


{-| Today's date. (default: `new Date()`) -}
today : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
today =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
toggle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.toggle


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.toggleDirection
        (M3e.Value.toString v_)


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.togglePosition
        (M3e.Value.toString v_)


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.touchGestures
        (M3e.Value.toString v_)


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.type_
        (M3e.Value.toString v_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool -> M3e.Cem.Attr.Attr { c | unbounded : M3e.Value.Supported } msg
unbounded =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.unbounded


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { content : M3e.Value.Supported
    , expressive : M3e.Value.Supported
    , fidelity : M3e.Value.Supported
    , fruitSalad : M3e.Value.Supported
    , monochrome : M3e.Value.Supported
    , neutral : M3e.Value.Supported
    , rainbow : M3e.Value.Supported
    , tonalSpot : M3e.Value.Supported
    , flat : M3e.Value.Supported
    , wavy : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    , contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    , segmented : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , sharp : M3e.Value.Supported
    , display : M3e.Value.Supported
    , headline : M3e.Value.Supported
    , label : M3e.Value.Supported
    , title : M3e.Value.Supported
    , primary : M3e.Value.Supported
    , primaryContainer : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , secondaryContainer : M3e.Value.Supported
    , surface : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    , tertiaryContainer : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , modal : M3e.Value.Supported
    , connected : M3e.Value.Supported
    , standard : M3e.Value.Supported
    , elevated : M3e.Value.Supported
    , text : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.variant
        (M3e.Value.toString v_)


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : Int -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
weight =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.weight


{-| The width of the button. (default: `"default"`) -}
width :
    M3e.Value.Value { default : M3e.Value.Supported
    , narrow : M3e.Value.Supported
    , wide : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
width v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Vocab.width
        (M3e.Value.toString v_)


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
wrap =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.wrap


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool -> M3e.Cem.Attr.Attr { c | wrapDetents : M3e.Value.Supported } msg
wrapDetents =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.wrapDetents


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
valueFloat :
    Float -> M3e.Cem.Attr.Attr { c | valueFloat : M3e.Value.Supported } msg
valueFloat =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.valueFloat


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.value


{-| Listen for `change` events. -}
onChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onChange


{-| Listen for `opening` events. -}
onOpening :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onOpening


{-| Listen for `opened` events. -}
onOpened :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onOpened


{-| Listen for `closing` events. -}
onClosing :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onClosing


{-| Listen for `closed` events. -}
onClosed :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onClosed


{-| Listen for `click` events. -}
onClick :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onClick


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onInput


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onToggle


{-| Listen for `value-change` events. -}
onValueChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onValueChange : M3e.Value.Supported } msg
onValueChange =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onValueChange


{-| Listen for `query` events. -}
onQuery :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onQuery


{-| Listen for `clear` events. -}
onClear :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onClear


{-| Listen for `page` events. -}
onPage :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onPage : M3e.Value.Supported } msg
onPage =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onPage


{-| Listen for `cancel` events. -}
onCancel :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onCancel


{-| Listen for `remove` events. -}
onRemove :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onRemove : M3e.Value.Supported } msg
onRemove =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onRemove


{-| Listen for `invalid` events. -}
onInvalid :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onInvalid : M3e.Value.Supported } msg
onInvalid =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onInvalid


{-| Listen for `active-change` events. -}
onActiveChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onActiveChange : M3e.Value.Supported } msg
onActiveChange =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onActiveChange


{-| Listen for `highlight` events. -}
onHighlight :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onHighlight : M3e.Value.Supported } msg
onHighlight =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Vocab.onHighlight


{-| Place content in the `leading` slot: stamp `slot="leading"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotLeading =
    M3e.Element.Internal.placeSlot "leading"


{-| Place content in the `title` slot: stamp `slot="title"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotTitle :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotTitle =
    M3e.Element.Internal.placeSlot "title"


{-| Place content in the `subtitle` slot: stamp `slot="subtitle"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSubtitle :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotSubtitle =
    M3e.Element.Internal.placeSlot "subtitle"


{-| Place content in the `trailing` slot: stamp `slot="trailing"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotTrailing :
    M3e.Element.Element { iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    , searchBar : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotTrailing =
    M3e.Element.Internal.placeSlot "trailing"


{-| Place content in the `leading-icon` slot: stamp `slot="leading-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLeadingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLeadingIcon =
    M3e.Element.Internal.placeSlot "leading-icon"


{-| Place content in the `trailing-icon` slot: stamp `slot="trailing-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotTrailingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotTrailingIcon =
    M3e.Element.Internal.placeSlot "trailing-icon"


{-| Place content in the `icon` slot: stamp `slot="icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotIcon =
    M3e.Element.Internal.placeSlot "icon"


{-| Place content in the `loading` slot: stamp `slot="loading"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLoading : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLoading =
    M3e.Element.Internal.placeSlot "loading"


{-| Place content in the `no-data` slot: stamp `slot="no-data"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotNoData : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotNoData =
    M3e.Element.Internal.placeSlot "no-data"


{-| Place content in the `header` slot: stamp `slot="header"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHeader =
    M3e.Element.Internal.placeSlot "header"


{-| Place content in the `separator` slot: stamp `slot="separator"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSeparator : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSeparator =
    M3e.Element.Internal.placeSlot "separator"


{-| Place content in the `selected` slot: stamp `slot="selected"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSelected :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotSelected =
    M3e.Element.Internal.placeSlot "selected"


{-| Place content in the `selected-icon` slot: stamp `slot="selected-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSelectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotSelectedIcon =
    M3e.Element.Internal.placeSlot "selected-icon"


{-| Place content in the `content` slot: stamp `slot="content"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotContent : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotContent =
    M3e.Element.Internal.placeSlot "content"


{-| Place content in the `actions` slot: stamp `slot="actions"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotActions =
    M3e.Element.Internal.placeSlot "actions"


{-| Place content in the `footer` slot: stamp `slot="footer"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotFooter : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotFooter =
    M3e.Element.Internal.placeSlot "footer"


{-| Place content in the `close-icon` slot: stamp `slot="close-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotCloseIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotCloseIcon =
    M3e.Element.Internal.placeSlot "close-icon"


{-| Place content in the `start` slot: stamp `slot="start"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotStart : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotStart =
    M3e.Element.Internal.placeSlot "start"


{-| Place content in the `end` slot: stamp `slot="end"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotEnd : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotEnd =
    M3e.Element.Internal.placeSlot "end"


{-| Place content in the `overline` slot: stamp `slot="overline"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotOverline =
    M3e.Element.Internal.placeSlot "overline"


{-| Place content in the `supporting-text` slot: stamp `slot="supporting-text"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotSupportingText =
    M3e.Element.Internal.placeSlot "supporting-text"


{-| Place content in the `toggle-icon` slot: stamp `slot="toggle-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotToggleIcon =
    M3e.Element.Internal.placeSlot "toggle-icon"


{-| Place content in the `items` slot: stamp `slot="items"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotItems : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotItems =
    M3e.Element.Internal.placeSlot "items"


{-| Place content in the `label` slot: stamp `slot="label"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLabel :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotLabel =
    M3e.Element.Internal.placeSlot "label"


{-| Place content in the `prefix` slot: stamp `slot="prefix"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotPrefix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefix =
    M3e.Element.Internal.placeSlot "prefix"


{-| Place content in the `prefix-text` slot: stamp `slot="prefix-text"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotPrefixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefixText =
    M3e.Element.Internal.placeSlot "prefix-text"


{-| Place content in the `suffix` slot: stamp `slot="suffix"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSuffix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffix =
    M3e.Element.Internal.placeSlot "suffix"


{-| Place content in the `suffix-text` slot: stamp `slot="suffix-text"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSuffixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffixText =
    M3e.Element.Internal.placeSlot "suffix-text"


{-| Place content in the `hint` slot: stamp `slot="hint"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotHint : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHint =
    M3e.Element.Internal.placeSlot "hint"


{-| Place content in the `error` slot: stamp `slot="error"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotError : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotError =
    M3e.Element.Internal.placeSlot "error"


{-| Place content in the `avatar` slot: stamp `slot="avatar"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotAvatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotAvatar =
    M3e.Element.Internal.placeSlot "avatar"


{-| Place content in the `remove-icon` slot: stamp `slot="remove-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotRemoveIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotRemoveIcon =
    M3e.Element.Internal.placeSlot "remove-icon"


{-| Place content in the `input` slot: stamp `slot="input"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotInput =
    M3e.Element.Internal.placeSlot "input"


{-| Place content in the `badge` slot: stamp `slot="badge"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotBadge :
    M3e.Element.Element { text : M3e.Value.Supported
    , badge : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotBadge =
    M3e.Element.Internal.placeSlot "badge"


{-| Place content in the `first-page-icon` slot: stamp `slot="first-page-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotFirstPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotFirstPageIcon =
    M3e.Element.Internal.placeSlot "first-page-icon"


{-| Place content in the `previous-page-icon` slot: stamp `slot="previous-page-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotPreviousPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotPreviousPageIcon =
    M3e.Element.Internal.placeSlot "previous-page-icon"


{-| Place content in the `next-page-icon` slot: stamp `slot="next-page-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotNextPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotNextPageIcon =
    M3e.Element.Internal.placeSlot "next-page-icon"


{-| Place content in the `last-page-icon` slot: stamp `slot="last-page-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLastPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotLastPageIcon =
    M3e.Element.Internal.placeSlot "last-page-icon"


{-| Place content in the `subhead` slot: stamp `slot="subhead"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSubhead :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotSubhead =
    M3e.Element.Internal.placeSlot "subhead"


{-| Place content in the `clear-icon` slot: stamp `slot="clear-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotClearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotClearIcon =
    M3e.Element.Internal.placeSlot "clear-icon"


{-| Place content in the `open-leading` slot: stamp `slot="open-leading"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotOpenLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotOpenLeading =
    M3e.Element.Internal.placeSlot "open-leading"


{-| Place content in the `open-trailing` slot: stamp `slot="open-trailing"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotOpenTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotOpenTrailing =
    M3e.Element.Internal.placeSlot "open-trailing"


{-| Place content in the `closed-leading` slot: stamp `slot="closed-leading"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotClosedLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotClosedLeading =
    M3e.Element.Internal.placeSlot "closed-leading"


{-| Place content in the `closed-trailing` slot: stamp `slot="closed-trailing"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotClosedTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
slotClosedTrailing =
    M3e.Element.Internal.placeSlot "closed-trailing"


{-| Place content in the `search-icon` slot: stamp `slot="search-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotSearchIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotSearchIcon =
    M3e.Element.Internal.placeSlot "search-icon"


{-| Place content in the `arrow` slot: stamp `slot="arrow"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotArrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotArrow =
    M3e.Element.Internal.placeSlot "arrow"


{-| Place content in the `value` slot: stamp `slot="value"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotValue : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotValue =
    M3e.Element.Internal.placeSlot "value"


{-| Place content in the `next-icon` slot: stamp `slot="next-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotNextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotNextIcon =
    M3e.Element.Internal.placeSlot "next-icon"


{-| Place content in the `prev-icon` slot: stamp `slot="prev-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotPrevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotPrevIcon =
    M3e.Element.Internal.placeSlot "prev-icon"


{-| Place content in the `leading-button` slot: stamp `slot="leading-button"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotLeadingButton :
    M3e.Element.Element { button : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotLeadingButton =
    M3e.Element.Internal.placeSlot "leading-button"


{-| Place content in the `trailing-button` slot: stamp `slot="trailing-button"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotTrailingButton :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotTrailingButton =
    M3e.Element.Internal.placeSlot "trailing-button"


{-| Place content in the `done-icon` slot: stamp `slot="done-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotDoneIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotDoneIcon =
    M3e.Element.Internal.placeSlot "done-icon"


{-| Place content in the `edit-icon` slot: stamp `slot="edit-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotEditIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotEditIcon =
    M3e.Element.Internal.placeSlot "edit-icon"


{-| Place content in the `error-icon` slot: stamp `slot="error-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotErrorIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotErrorIcon =
    M3e.Element.Internal.placeSlot "error-icon"


{-| Place content in the `step` slot: stamp `slot="step"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotStep :
    M3e.Element.Element { step : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotStep =
    M3e.Element.Internal.placeSlot "step"


{-| Place content in the `panel` slot: stamp `slot="panel"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotPanel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotPanel =
    M3e.Element.Internal.placeSlot "panel"


{-| Place content in the `open-toggle-icon` slot: stamp `slot="open-toggle-icon"` onto an element (kind-guided INPUT, free output row). Component-agnostic; cross-component slot misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule. -}
slotOpenToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
slotOpenToggleIcon =
    M3e.Element.Internal.placeSlot "open-toggle-icon"