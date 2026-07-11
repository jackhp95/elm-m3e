module M3e.Html.Shared exposing
    ( action, actionable, active, activeDate, alert, anchorOffset
    , animation, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive
    , centered, checked, clearLabel, clearable, closeLabel, color
    , completed, confirmLabel, contained, contrast, current, date
    , density, detent, detents, disableClose, disableHighlight, disableHover
    , disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel
    , dismissible, dividers, download, duration, editable, elevated
    , emphasized, end, endDivider, endMode, extended, filled
    , filter, firstPageLabel, fitAnchorWidth, floatLabel, for, grade
    , handle, handleLabel, headerPosition, hideDelay, hideFriction, hideLoading
    , hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript
    , hideToggle, hideable, highlightMode, href, icons, indeterminate
    , inline, inset, insetEnd, insetStart, invalid, inward
    , itemLabel, itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel
    , length, level, linear, loaded, loading, loadingLabel
    , lowered, tocIgnore, max, maxDate, maxDepth, maxRows
    , min, minDate, minRows, modal, mode, motion
    , multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate
    , noDataLabel, noFocusTrap, open, opticalSize, optional, orientation
    , overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass
    , position, positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel
    , previousYearLabel, radius, range, rangeEnd, rangeStart, rel
    , removable, removeLabel, required, returnValue, scheme, scrollStrategy
    , secondary, selected, selectedIndex, shape, showDelay, showFirstLastButtons
    , size, start, startAt, startDivider, startMode, startView
    , state, step, stretch, strongFocus, submenu, target
    , term, thin, threshold, today, toggle, toggleDirection
    , togglePosition, touchGestures, type_, unbounded, variant, vertical
    , weight, width, wrap, wrapDetents, name, valueFloat
    , value, onChange, onOpening, onOpened, onClosing, onClosed
    , onClick, onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange
    , onQuery, onClear, onPage, onCancel, onRemove, onInvalid
    , onActiveChange, onHighlight, slotLeading, slotTitle, slotSubtitle, slotTrailing
    , slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader
    , slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter
    , slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon
    , slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText
    , slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge
    , slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon
    , slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow
    , slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon
    , slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon
    )

{-| Shared middle vocabulary: the component-agnostic, phantom-gated attribute, event, and slot setters — ONE polymorphic function per name, each carrying an OPEN capability row so it type-checks against any component that admits it. The loose counterpart to the strict per-component modules.

@docs action, actionable, active, activeDate, alert, anchorOffset
@docs animation, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive
@docs centered, checked, clearLabel, clearable, closeLabel, color
@docs completed, confirmLabel, contained, contrast, current, date
@docs density, detent, detents, disableClose, disableHighlight, disableHover
@docs disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel
@docs dismissible, dividers, download, duration, editable, elevated
@docs emphasized, end, endDivider, endMode, extended, filled
@docs filter, firstPageLabel, fitAnchorWidth, floatLabel, for, grade
@docs handle, handleLabel, headerPosition, hideDelay, hideFriction, hideLoading
@docs hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript
@docs hideToggle, hideable, highlightMode, href, icons, indeterminate
@docs inline, inset, insetEnd, insetStart, invalid, inward
@docs itemLabel, itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel
@docs length, level, linear, loaded, loading, loadingLabel
@docs lowered, tocIgnore, max, maxDate, maxDepth, maxRows
@docs min, minDate, minRows, modal, mode, motion
@docs multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate
@docs noDataLabel, noFocusTrap, open, opticalSize, optional, orientation
@docs overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass
@docs position, positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel
@docs previousYearLabel, radius, range, rangeEnd, rangeStart, rel
@docs removable, removeLabel, required, returnValue, scheme, scrollStrategy
@docs secondary, selected, selectedIndex, shape, showDelay, showFirstLastButtons
@docs size, start, startAt, startDivider, startMode, startView
@docs state, step, stretch, strongFocus, submenu, target
@docs term, thin, threshold, today, toggle, toggleDirection
@docs togglePosition, touchGestures, type_, unbounded, variant, vertical
@docs weight, width, wrap, wrapDetents, name, valueFloat
@docs value, onChange, onOpening, onOpened, onClosing, onClosed
@docs onClick, onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange
@docs onQuery, onClear, onPage, onCancel, onRemove, onInvalid
@docs onActiveChange, onHighlight, slotLeading, slotTitle, slotSubtitle, slotTrailing
@docs slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader
@docs slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter
@docs slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon
@docs slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText
@docs slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge
@docs slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon
@docs slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow
@docs slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon
@docs slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon

-}

import Json.Decode
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Shared
import M3e.Token


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> M3e.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
action =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
actionable : Bool -> M3e.Html.Attr.Attr { c | actionable : M3e.Token.Supported } msg
actionable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.actionable


{-| Whether the view is active. (default: `false`)
-}
active : Bool -> M3e.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
active =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.active


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> M3e.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
activeDate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.activeDate


{-| Whether the dialog is an alert. (default: `false`)
-}
alert : Bool -> M3e.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
alert =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset : Float -> M3e.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
anchorOffset =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.anchorOffset


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    M3e.Token.Value
        { none : M3e.Token.Supported
        , pulse : M3e.Token.Supported
        , wave : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animation v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.animation
        (M3e.Token.toString v_)


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid : String -> M3e.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`)
-}
autoActivate : Bool -> M3e.Html.Attr.Attr { c | autoActivate : M3e.Token.Supported } msg
autoActivate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> M3e.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
bufferValue =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade : Bool -> M3e.Html.Attr.Attr { c | cascade : M3e.Token.Supported } msg
cascade =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.cascade


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> M3e.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
caseSensitive =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> M3e.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.centered


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> M3e.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> M3e.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> M3e.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.color


{-| Whether the step has been completed. (default: `false`)
-}
completed : Bool -> M3e.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
completed =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
confirmLabel : String -> M3e.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
confirmLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> M3e.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
contained =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.contained


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrast v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.contrast
        (M3e.Token.toString v_)


{-| Indicates the current item in the breadcrumb path.
-}
current :
    M3e.Token.Value
        { date : M3e.Token.Supported
        , location : M3e.Token.Supported
        , page : M3e.Token.Supported
        , step : M3e.Token.Supported
        , time : M3e.Token.Supported
        , true : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
current v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.current
        (M3e.Token.toString v_)


{-| The selected date. (default: `null`)
-}
date : String -> M3e.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.date


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> M3e.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
density =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.density


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> M3e.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.detent


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
detents : String -> M3e.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.detents


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose : Bool -> M3e.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
disableClose =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disableClose


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight :
    Bool
    -> M3e.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
disableHighlight =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> M3e.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
disableHover =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disableHover


{-| Whether scroll buttons are disabled.
-}
disablePagination :
    M3e.Token.Value
        { true : M3e.Token.Supported
        , false : M3e.Token.Supported
        , auto : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePagination v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.disablePagination
        (M3e.Token.toString v_)


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus :
    Bool
    -> M3e.Html.Attr.Attr { c | disableRestoreFocus : M3e.Token.Supported } msg
disableRestoreFocus =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    -> M3e.Html.Attr.Attr { c | disabledInteractive : M3e.Token.Supported } msg
disabledInteractive =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.disabledInteractive


{-| Whether to show tick marks. (default: `false`)
-}
discrete : Bool -> M3e.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
discrete =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
dismissLabel : String -> M3e.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
dismissLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> M3e.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.dismissible


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveBelow : M3e.Token.Supported
        , below : M3e.Token.Supported
        , none : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividers v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.dividers
        (M3e.Token.toString v_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> M3e.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
duration =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable : Bool -> M3e.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
editable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.editable


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> M3e.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
elevated =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> M3e.Html.Attr.Attr { c | emphasized : M3e.Token.Supported } msg
emphasized =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.emphasized


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> M3e.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
end =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> M3e.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
endDivider =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.endDivider


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endMode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.endMode
        (M3e.Token.toString v_)


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> M3e.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
extended =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.extended


{-| Whether the icon is filled. (default: `false`)
-}
filled : Bool -> M3e.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
filled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.filled


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , none : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filter v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.filter
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
firstPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth : Bool -> M3e.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
fitAnchorWidth =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.fitAnchorWidth


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel :
    M3e.Token.Value { always : M3e.Token.Supported, auto : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabel v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.floatLabel
        (M3e.Token.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.for


{-| The grade of the icon. (default: `"medium"`)
-}
grade :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , low : M3e.Token.Supported
        , medium : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
grade v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.grade
        (M3e.Token.toString v_)


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
handle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel : String -> M3e.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
handleLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.handleLabel


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , above : M3e.Token.Supported
        , below : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPosition v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.headerPosition
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> M3e.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction : Float -> M3e.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
hideFriction =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`)
-}
hideLoading : Bool -> M3e.Html.Attr.Attr { c | hideLoading : M3e.Token.Supported } msg
hideLoading =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
hideNoData : Bool -> M3e.Html.Attr.Attr { c | hideNoData : M3e.Token.Supported } msg
hideNoData =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideNoData


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize : Bool -> M3e.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
hidePageSize =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker :
    Bool
    -> M3e.Html.Attr.Attr { c | hideRequiredMarker : M3e.Token.Supported } msg
hideRequiredMarker =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon : Bool -> M3e.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
hideSearchIcon =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        M3e.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideSelectionIndicator


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript :
    M3e.Token.Value
        { always : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , never : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscript v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.hideSubscript
        (M3e.Token.toString v_)


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> M3e.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable : Bool -> M3e.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
hideable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.hideable


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightMode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.highlightMode
        (M3e.Token.toString v_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.href


{-| The icons to present. (default: `"none"`)
-}
icons :
    M3e.Token.Value
        { both : M3e.Token.Supported
        , none : M3e.Token.Supported
        , selected : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
icons v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.icons
        (M3e.Token.toString v_)


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
inline : Bool -> M3e.Html.Attr.Attr { c | inline : M3e.Token.Supported } msg
inline =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> M3e.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
inset =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> M3e.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
insetEnd =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> M3e.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
insetStart =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.insetStart


{-| Whether the step has an error. (default: `false`)
-}
invalid : Bool -> M3e.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
invalid =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> M3e.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
inward =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.inward


{-| The accessible label given to the item's internal button. (default: `""`)
-}
itemLabel : String -> M3e.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
itemLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
itemsPerPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> M3e.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.label


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition :
    M3e.Token.Value { below : M3e.Token.Supported, end : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPosition v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.labelPosition
        (M3e.Token.toString v_)


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled : Bool -> M3e.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
labelled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel : String -> M3e.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
lastPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length : Float -> M3e.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
length =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.length


{-| The accessibility level of the heading.
-}
level : Int -> M3e.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
level =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> M3e.Html.Attr.Attr { c | linear : M3e.Token.Supported } msg
linear =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> M3e.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
loaded =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.loaded


{-| Whether options are being loaded. (default: `false`)
-}
loading : Bool -> M3e.Html.Attr.Attr { c | loading : M3e.Token.Supported } msg
loading =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
loadingLabel : String -> M3e.Html.Attr.Attr { c | loadingLabel : M3e.Token.Supported } msg
loadingLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> M3e.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
lowered =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.lowered


{-| Exclude this heading from the table of contents generated by an `m3e-toc` component. `m3e-toc-ignore` is a valueless presence marker the `m3e-toc` reads from heading elements; it is not an `m3e-heading` CEM attribute, so it is injected here as a heading-scoped synthetic capability.
-}
tocIgnore : Bool -> M3e.Html.Attr.Attr { c | tocIgnore : M3e.Token.Supported } msg
tocIgnore =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.tocIgnore


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
max : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.max


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> M3e.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.maxDate


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> M3e.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
maxDepth =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows : Float -> M3e.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
maxRows =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
min : Float -> M3e.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.min


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> M3e.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows : Float -> M3e.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
minRows =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal : Bool -> M3e.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
modal =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.modal


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , fullscreen : M3e.Token.Supported
        , buffer : M3e.Token.Supported
        , determinate : M3e.Token.Supported
        , indeterminate : M3e.Token.Supported
        , query : M3e.Token.Supported
        , compact : M3e.Token.Supported
        , expanded : M3e.Token.Supported
        , contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.mode (M3e.Token.toString v_)


{-| The motion scheme. (default: `"standard"`)
-}
motion :
    M3e.Token.Value
        { expressive : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motion v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.motion
        (M3e.Token.toString v_)


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMultiYearLabel : M3e.Token.Supported } msg
nextMultiYearLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> M3e.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> M3e.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.nextYearLabel


{-| Whether to disable animation. (default: `false`)
-}
noAnimate : Bool -> M3e.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
noAnimate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
noDataLabel : String -> M3e.Html.Attr.Attr { c | noDataLabel : M3e.Token.Supported } msg
noDataLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap : Bool -> M3e.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
noFocusTrap =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.noFocusTrap


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> M3e.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
opticalSize =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.opticalSize


{-| Whether the step is optional. (default: `false`)
-}
optional : Bool -> M3e.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
optional =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.optional


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.orientation
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> M3e.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex : Float -> M3e.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
pageIndex =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.pageIndex


{-| The number of items to display in a page. (default: `50`)
-}
pageSize :
    M3e.Token.Value { number : M3e.Token.Supported, all : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSize v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.pageSize
        (M3e.Token.toString v_)


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.pageSizeVariant
        (M3e.Token.toString v_)


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes : String -> M3e.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
pageSizes =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> M3e.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
panelClass =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.panelClass


{-| The position of the tooltip. (default: `"below"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        , aboveAfter : M3e.Token.Supported
        , aboveBefore : M3e.Token.Supported
        , belowAfter : M3e.Token.Supported
        , belowBefore : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.position
        (M3e.Token.toString v_)


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionX v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.positionX
        (M3e.Token.toString v_)


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionY v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.positionY
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousMonthLabel : M3e.Token.Supported } msg
previousMonthLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        M3e.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
previousMultiYearLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> M3e.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
radius =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.radius


{-| Whether a range of dates can be selected. (default: `false`)
-}
range : Bool -> M3e.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
range =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.range


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> M3e.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> M3e.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.rel


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> M3e.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
removable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel : String -> M3e.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
removeLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.removeLabel


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> M3e.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.required


{-| The value to return from the dialog. (default: `""`)
-}
returnValue : String -> M3e.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
returnValue =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.returnValue


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.scheme
        (M3e.Token.toString v_)


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    M3e.Token.Value
        { hide : M3e.Token.Supported
        , reposition : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategy v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.scrollStrategy
        (M3e.Token.toString v_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> M3e.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
secondary =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.secondary


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.selected


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex : Float -> M3e.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
selectedIndex =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.selectedIndex


{-| The shape of the toolbar. (default: `"square"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , circular : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.shape
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> M3e.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.showDelay


{-| Whether to show first/last buttons. (default: `false`)
-}
showFirstLastButtons :
    Bool
    -> M3e.Html.Attr.Attr { c | showFirstLastButtons : M3e.Token.Supported } msg
showFirstLastButtons =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.showFirstLastButtons


{-| The size of the button. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.size (M3e.Token.toString v_)


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> M3e.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
start =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> M3e.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> M3e.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
startDivider =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.startDivider


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startMode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.startMode
        (M3e.Token.toString v_)


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    M3e.Token.Value
        { month : M3e.Token.Supported
        , multiYear : M3e.Token.Supported
        , year : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startView v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.startView
        (M3e.Token.toString v_)


{-| The state for which to present content. (default: `"content"`)
-}
state :
    M3e.Token.Value
        { content : M3e.Token.Supported
        , loading : M3e.Token.Supported
        , noData : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
state v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.state
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> M3e.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.step


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> M3e.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
stretch =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.stretch


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> M3e.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
strongFocus =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> M3e.Html.Attr.Attr { c | submenu : M3e.Token.Supported } msg
submenu =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.submenu


{-| The target of the link button. (default: `""`)
-}
target : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.target


{-| The search term to highlight. (default: `""`)
-}
term : String -> M3e.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.term


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> M3e.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
thin =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
threshold : Float -> M3e.Html.Attr.Attr { c | threshold : M3e.Token.Supported } msg
threshold =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.threshold


{-| Today's date. (default: `new Date()`)
-}
today : String -> M3e.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
today =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> M3e.Html.Attr.Attr { c | toggle : M3e.Token.Supported } msg
toggle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.toggle


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.toggleDirection
        (M3e.Token.toString v_)


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.togglePosition
        (M3e.Token.toString v_)


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.touchGestures
        (M3e.Token.toString v_)


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.type_
        (M3e.Token.toString v_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> M3e.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
unbounded =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.unbounded


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { standard : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        , content : M3e.Token.Supported
        , expressive : M3e.Token.Supported
        , fidelity : M3e.Token.Supported
        , fruitSalad : M3e.Token.Supported
        , monochrome : M3e.Token.Supported
        , neutral : M3e.Token.Supported
        , rainbow : M3e.Token.Supported
        , tonalSpot : M3e.Token.Supported
        , primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , elevated : M3e.Token.Supported
        , filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        , tonal : M3e.Token.Supported
        , flat : M3e.Token.Supported
        , wavy : M3e.Token.Supported
        , contained : M3e.Token.Supported
        , uncontained : M3e.Token.Supported
        , segmented : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , sharp : M3e.Token.Supported
        , display : M3e.Token.Supported
        , headline : M3e.Token.Supported
        , label : M3e.Token.Supported
        , title : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        , primaryContainer : M3e.Token.Supported
        , secondaryContainer : M3e.Token.Supported
        , surface : M3e.Token.Supported
        , tertiaryContainer : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , modal : M3e.Token.Supported
        , connected : M3e.Token.Supported
        , text : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.variant
        (M3e.Token.toString v_)


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : Int -> M3e.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
weight =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.weight


{-| The width of the button. (default: `"default"`)
-}
width :
    M3e.Token.Value
        { default : M3e.Token.Supported
        , narrow : M3e.Token.Supported
        , wide : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
width v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Shared.width
        (M3e.Token.toString v_)


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap : Bool -> M3e.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
wrap =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.wrap


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents : Bool -> M3e.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
wrapDetents =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
valueFloat : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
valueFloat =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.valueFloat


{-| A string representing the value of the switch. (default: `"on"`)
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.value


{-| Listen for `change` events.
-}
onChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onChange


{-| Listen for `opening` events.
-}
onOpening :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onOpening


{-| Listen for `opened` events.
-}
onOpened :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onOpened


{-| Listen for `closing` events.
-}
onClosing :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onClosing


{-| Listen for `closed` events.
-}
onClosed :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onClosed


{-| Listen for `click` events.
-}
onClick :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onClick


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onInput


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onToggle


{-| Listen for `value-change` events.
-}
onValueChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onValueChange


{-| Listen for `query` events.
-}
onQuery :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onQuery


{-| Listen for `clear` events.
-}
onClear :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onClear


{-| Listen for `page` events.
-}
onPage :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onPage


{-| Listen for `cancel` events.
-}
onCancel :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onCancel


{-| Listen for `remove` events.
-}
onRemove :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onRemove


{-| Listen for `invalid` events.
-}
onInvalid :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onInvalid


{-| Listen for `active-change` events.
-}
onActiveChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onActiveChange


{-| Listen for `highlight` events.
-}
onHighlight :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Shared.onHighlight


{-| Place content in the `leading` slot: stamp `slot="leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeading`) form.
-}
slotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        , button : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotLeading =
    M3e.Element.Internal.placeSlot "leading"


{-| Place content in the `title` slot: stamp `slot="title"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTitle`) form.
-}
slotTitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotTitle =
    M3e.Element.Internal.placeSlot "title"


{-| Place content in the `subtitle` slot: stamp `slot="subtitle"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSubtitle`) form.
-}
slotSubtitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSubtitle =
    M3e.Element.Internal.placeSlot "subtitle"


{-| Place content in the `trailing` slot: stamp `slot="trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailing`) form.
-}
slotTrailing :
    M3e.Element.Element
        { iconButton : M3e.Token.Supported
        , button : M3e.Token.Supported
        , searchBar : M3e.Token.Supported
        , html : M3e.Token.Supported
        , icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotTrailing =
    M3e.Element.Internal.placeSlot "trailing"


{-| Place content in the `leading-icon` slot: stamp `slot="leading-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeadingIcon`) form.
-}
slotLeadingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLeadingIcon =
    M3e.Element.Internal.placeSlot "leading-icon"


{-| Place content in the `trailing-icon` slot: stamp `slot="trailing-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailingIcon`) form.
-}
slotTrailingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotTrailingIcon =
    M3e.Element.Internal.placeSlot "trailing-icon"


{-| Place content in the `icon` slot: stamp `slot="icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotIcon`) form.
-}
slotIcon :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , loadingIndicator : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotIcon =
    M3e.Element.Internal.placeSlot "icon"


{-| Place content in the `loading` slot: stamp `slot="loading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLoading`) form.
-}
slotLoading : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLoading =
    M3e.Element.Internal.placeSlot "loading"


{-| Place content in the `no-data` slot: stamp `slot="no-data"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNoData`) form.
-}
slotNoData : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotNoData =
    M3e.Element.Internal.placeSlot "no-data"


{-| Place content in the `header` slot: stamp `slot="header"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotHeader`) form.
-}
slotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHeader =
    M3e.Element.Internal.placeSlot "header"


{-| Place content in the `separator` slot: stamp `slot="separator"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSeparator`) form.
-}
slotSeparator : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSeparator =
    M3e.Element.Internal.placeSlot "separator"


{-| Place content in the `selected` slot: stamp `slot="selected"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSelected`) form.
-}
slotSelected :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , icon : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSelected =
    M3e.Element.Internal.placeSlot "selected"


{-| Place content in the `selected-icon` slot: stamp `slot="selected-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSelectedIcon`) form.
-}
slotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSelectedIcon =
    M3e.Element.Internal.placeSlot "selected-icon"


{-| Place content in the `content` slot: stamp `slot="content"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotContent`) form.
-}
slotContent : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotContent =
    M3e.Element.Internal.placeSlot "content"


{-| Place content in the `actions` slot: stamp `slot="actions"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotActions`) form.
-}
slotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotActions =
    M3e.Element.Internal.placeSlot "actions"


{-| Place content in the `footer` slot: stamp `slot="footer"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotFooter`) form.
-}
slotFooter : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotFooter =
    M3e.Element.Internal.placeSlot "footer"


{-| Place content in the `close-icon` slot: stamp `slot="close-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotCloseIcon`) form.
-}
slotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotCloseIcon =
    M3e.Element.Internal.placeSlot "close-icon"


{-| Place content in the `start` slot: stamp `slot="start"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotStart`) form.
-}
slotStart : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotStart =
    M3e.Element.Internal.placeSlot "start"


{-| Place content in the `end` slot: stamp `slot="end"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotEnd`) form.
-}
slotEnd : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotEnd =
    M3e.Element.Internal.placeSlot "end"


{-| Place content in the `overline` slot: stamp `slot="overline"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOverline`) form.
-}
slotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOverline =
    M3e.Element.Internal.placeSlot "overline"


{-| Place content in the `supporting-text` slot: stamp `slot="supporting-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSupportingText`) form.
-}
slotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSupportingText =
    M3e.Element.Internal.placeSlot "supporting-text"


{-| Place content in the `toggle-icon` slot: stamp `slot="toggle-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotToggleIcon`) form.
-}
slotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotToggleIcon =
    M3e.Element.Internal.placeSlot "toggle-icon"


{-| Place content in the `items` slot: stamp `slot="items"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotItems`) form.
-}
slotItems : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotItems =
    M3e.Element.Internal.placeSlot "items"


{-| Place content in the `label` slot: stamp `slot="label"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLabel`) form.
-}
slotLabel : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLabel =
    M3e.Element.Internal.placeSlot "label"


{-| Place content in the `prefix` slot: stamp `slot="prefix"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrefix`) form.
-}
slotPrefix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefix =
    M3e.Element.Internal.placeSlot "prefix"


{-| Place content in the `prefix-text` slot: stamp `slot="prefix-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrefixText`) form.
-}
slotPrefixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefixText =
    M3e.Element.Internal.placeSlot "prefix-text"


{-| Place content in the `suffix` slot: stamp `slot="suffix"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSuffix`) form.
-}
slotSuffix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffix =
    M3e.Element.Internal.placeSlot "suffix"


{-| Place content in the `suffix-text` slot: stamp `slot="suffix-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSuffixText`) form.
-}
slotSuffixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffixText =
    M3e.Element.Internal.placeSlot "suffix-text"


{-| Place content in the `hint` slot: stamp `slot="hint"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotHint`) form.
-}
slotHint : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHint =
    M3e.Element.Internal.placeSlot "hint"


{-| Place content in the `error` slot: stamp `slot="error"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotError`) form.
-}
slotError : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotError =
    M3e.Element.Internal.placeSlot "error"


{-| Place content in the `avatar` slot: stamp `slot="avatar"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotAvatar`) form.
-}
slotAvatar :
    M3e.Element.Element { avatar : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotAvatar =
    M3e.Element.Internal.placeSlot "avatar"


{-| Place content in the `remove-icon` slot: stamp `slot="remove-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotRemoveIcon`) form.
-}
slotRemoveIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotRemoveIcon =
    M3e.Element.Internal.placeSlot "remove-icon"


{-| Place content in the `input` slot: stamp `slot="input"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotInput`) form.
-}
slotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotInput =
    M3e.Element.Internal.placeSlot "input"


{-| Place content in the `badge` slot: stamp `slot="badge"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotBadge`) form.
-}
slotBadge :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , badge : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotBadge =
    M3e.Element.Internal.placeSlot "badge"


{-| Place content in the `first-page-icon` slot: stamp `slot="first-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotFirstPageIcon`) form.
-}
slotFirstPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotFirstPageIcon =
    M3e.Element.Internal.placeSlot "first-page-icon"


{-| Place content in the `previous-page-icon` slot: stamp `slot="previous-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPreviousPageIcon`) form.
-}
slotPreviousPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotPreviousPageIcon =
    M3e.Element.Internal.placeSlot "previous-page-icon"


{-| Place content in the `next-page-icon` slot: stamp `slot="next-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNextPageIcon`) form.
-}
slotNextPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotNextPageIcon =
    M3e.Element.Internal.placeSlot "next-page-icon"


{-| Place content in the `last-page-icon` slot: stamp `slot="last-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLastPageIcon`) form.
-}
slotLastPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotLastPageIcon =
    M3e.Element.Internal.placeSlot "last-page-icon"


{-| Place content in the `subhead` slot: stamp `slot="subhead"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSubhead`) form.
-}
slotSubhead :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSubhead =
    M3e.Element.Internal.placeSlot "subhead"


{-| Place content in the `clear-icon` slot: stamp `slot="clear-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClearIcon`) form.
-}
slotClearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotClearIcon =
    M3e.Element.Internal.placeSlot "clear-icon"


{-| Place content in the `open-leading` slot: stamp `slot="open-leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenLeading`) form.
-}
slotOpenLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOpenLeading =
    M3e.Element.Internal.placeSlot "open-leading"


{-| Place content in the `open-trailing` slot: stamp `slot="open-trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenTrailing`) form.
-}
slotOpenTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOpenTrailing =
    M3e.Element.Internal.placeSlot "open-trailing"


{-| Place content in the `closed-leading` slot: stamp `slot="closed-leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClosedLeading`) form.
-}
slotClosedLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotClosedLeading =
    M3e.Element.Internal.placeSlot "closed-leading"


{-| Place content in the `closed-trailing` slot: stamp `slot="closed-trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClosedTrailing`) form.
-}
slotClosedTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotClosedTrailing =
    M3e.Element.Internal.placeSlot "closed-trailing"


{-| Place content in the `search-icon` slot: stamp `slot="search-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSearchIcon`) form.
-}
slotSearchIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSearchIcon =
    M3e.Element.Internal.placeSlot "search-icon"


{-| Place content in the `arrow` slot: stamp `slot="arrow"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotArrow`) form.
-}
slotArrow :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotArrow =
    M3e.Element.Internal.placeSlot "arrow"


{-| Place content in the `value` slot: stamp `slot="value"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotValue`) form.
-}
slotValue : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotValue =
    M3e.Element.Internal.placeSlot "value"


{-| Place content in the `next-icon` slot: stamp `slot="next-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNextIcon`) form.
-}
slotNextIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotNextIcon =
    M3e.Element.Internal.placeSlot "next-icon"


{-| Place content in the `prev-icon` slot: stamp `slot="prev-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrevIcon`) form.
-}
slotPrevIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotPrevIcon =
    M3e.Element.Internal.placeSlot "prev-icon"


{-| Place content in the `leading-button` slot: stamp `slot="leading-button"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeadingButton`) form.
-}
slotLeadingButton :
    M3e.Element.Element { button : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotLeadingButton =
    M3e.Element.Internal.placeSlot "leading-button"


{-| Place content in the `trailing-button` slot: stamp `slot="trailing-button"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailingButton`) form.
-}
slotTrailingButton :
    M3e.Element.Element { iconButton : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotTrailingButton =
    M3e.Element.Internal.placeSlot "trailing-button"


{-| Place content in the `done-icon` slot: stamp `slot="done-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotDoneIcon`) form.
-}
slotDoneIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotDoneIcon =
    M3e.Element.Internal.placeSlot "done-icon"


{-| Place content in the `edit-icon` slot: stamp `slot="edit-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotEditIcon`) form.
-}
slotEditIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotEditIcon =
    M3e.Element.Internal.placeSlot "edit-icon"


{-| Place content in the `error-icon` slot: stamp `slot="error-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotErrorIcon`) form.
-}
slotErrorIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotErrorIcon =
    M3e.Element.Internal.placeSlot "error-icon"


{-| Place content in the `step` slot: stamp `slot="step"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotStep`) form.
-}
slotStep :
    M3e.Element.Element { step : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotStep =
    M3e.Element.Internal.placeSlot "step"


{-| Place content in the `panel` slot: stamp `slot="panel"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPanel`) form.
-}
slotPanel :
    M3e.Element.Element
        { stepPanel : M3e.Token.Supported
        , tabPanel : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotPanel =
    M3e.Element.Internal.placeSlot "panel"


{-| Place content in the `open-toggle-icon` slot: stamp `slot="open-toggle-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenToggleIcon`) form.
-}
slotOpenToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotOpenToggleIcon =
    M3e.Element.Internal.placeSlot "open-toggle-icon"
