module M3e.Html.Shared exposing
    ( action, actionable, active, activeDate, alert, anchorOffset
    , animation, autoActivate, bufferValue, cascade, caseSensitive, centered
    , checked, clearLabel, clearable, closeLabel, color, completed
    , confirmLabel, contained, contrast, current, date, density
    , detent, detents, disableClose, disableHighlight, disableHover, disablePagination
    , disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible
    , dividers, download, duration, editable, elevated, emphasized
    , end, endDivider, endMode, extended, filled, filter
    , firstPageLabel, fitAnchorWidth, floatLabel, for, grade, handle
    , handleLabel, headerPosition, hideDelay, hideFriction, hideLoading, hideNoData
    , hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript, hideToggle
    , hideable, highlightMode, href, icons, indeterminate, inline
    , inset, insetEnd, insetStart, invalid, inward, itemLabel
    , itemsPerPageLabel, label, labelPosition, labelled, lastPageLabel, length
    , level, linear, loaded, loading, loadingLabel, lowered
    , tocIgnore, max, maxDate, maxDepth, maxRows, min
    , minDate, minRows, modal, mode, motion, multi
    , nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel
    , noFocusTrap, open, opticalSize, optional, orientation, overshootLimit
    , pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass, position
    , positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel
    , radius, range, rangeEnd, rangeStart, rel, removable
    , removeLabel, required, returnValue, scheme, scrollStrategy, secondary
    , selected, selectedIndex, shape, showDelay, showFirstLastButtons, size
    , start, startAt, startDivider, startMode, startView, state
    , step, stretch, strongFocus, submenu, target, term
    , thin, threshold, today, toggle, toggleDirection, togglePosition
    , touchGestures, type_, unbounded, variant, vertical, weight
    , width, wrap, wrapDetents, name, valueFloat, value
    , onChange, onOpening, onOpened, onClosing, onClosed, onClick
    , onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange, onQuery
    , onClear, onPage, onCancel, onRemove, onInvalid, onActiveChange
    , onHighlight, slotLeading, slotTitle, slotSubtitle, slotTrailing, slotLeadingIcon
    , slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader, slotSeparator
    , slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter, slotCloseIcon
    , slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon, slotItems
    , slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText, slotHint
    , slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge, slotFirstPageIcon
    , slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon, slotOpenLeading
    , slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow, slotValue
    , slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon, slotEditIcon
    , slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon
    )

{-| Shared middle vocabulary: the component-agnostic, phantom-gated attribute, event, and slot setters — ONE polymorphic function per name, each carrying an OPEN capability row so it type-checks against any component that admits it. The loose counterpart to the strict per-component modules.

@docs action, actionable, active, activeDate, alert, anchorOffset
@docs animation, autoActivate, bufferValue, cascade, caseSensitive, centered
@docs checked, clearLabel, clearable, closeLabel, color, completed
@docs confirmLabel, contained, contrast, current, date, density
@docs detent, detents, disableClose, disableHighlight, disableHover, disablePagination
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
@docs tocIgnore, max, maxDate, maxDepth, maxRows, min
@docs minDate, minRows, modal, mode, motion, multi
@docs nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel
@docs noFocusTrap, open, opticalSize, optional, orientation, overshootLimit
@docs pageIndex, pageSize, pageSizeVariant, pageSizes, panelClass, position
@docs positionX, positionY, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel
@docs radius, range, rangeEnd, rangeStart, rel, removable
@docs removeLabel, required, returnValue, scheme, scrollStrategy, secondary
@docs selected, selectedIndex, shape, showDelay, showFirstLastButtons, size
@docs start, startAt, startDivider, startMode, startView, state
@docs step, stretch, strongFocus, submenu, target, term
@docs thin, threshold, today, toggle, toggleDirection, togglePosition
@docs touchGestures, type_, unbounded, variant, vertical, weight
@docs width, wrap, wrapDetents, name, valueFloat, value
@docs onChange, onOpening, onOpened, onClosing, onClosed, onClick
@docs onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange, onQuery
@docs onClear, onPage, onCancel, onRemove, onInvalid, onActiveChange
@docs onHighlight, slotLeading, slotTitle, slotSubtitle, slotTrailing, slotLeadingIcon
@docs slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader, slotSeparator
@docs slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter, slotCloseIcon
@docs slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon, slotItems
@docs slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText, slotHint
@docs slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge, slotFirstPageIcon
@docs slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon, slotOpenLeading
@docs slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow, slotValue
@docs slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon, slotEditIcon
@docs slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon

-}

import Json.Decode
import M3e.Kind
import M3e.Raw.Shared
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> Markup.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
action =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
actionable : Bool -> Markup.Html.Attr.Attr { c | actionable : M3e.Token.Supported } msg
actionable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.actionable


{-| Whether the view is active. (default: `false`)
-}
active : Bool -> Markup.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
active =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.active


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Markup.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
activeDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.activeDate


{-| Whether the dialog is an alert. (default: `false`)
-}
alert : Bool -> Markup.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
alert =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset :
    Float
    -> Markup.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
anchorOffset =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.anchorOffset


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    M3e.Token.Value
        { none : M3e.Token.Supported
        , pulse : M3e.Token.Supported
        , wave : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animation v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.animation
        (M3e.Token.toString v_)


{-| Whether the first option should be automatically activated. (default: `false`)
-}
autoActivate : Bool -> Markup.Html.Attr.Attr { c | autoActivate : M3e.Token.Supported } msg
autoActivate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> Markup.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
bufferValue =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade : Bool -> Markup.Html.Attr.Attr { c | cascade : M3e.Token.Supported } msg
cascade =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.cascade


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive :
    Bool
    -> Markup.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
caseSensitive =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> Markup.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.centered


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> Markup.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> Markup.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.color


{-| Whether the step has been completed. (default: `false`)
-}
completed : Bool -> Markup.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
completed =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
confirmLabel :
    String
    -> Markup.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
confirmLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Markup.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
contained =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.contained


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrast v_ =
    Markup.Html.Attr.Internal.attribute
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
    -> Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
current v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.current
        (M3e.Token.toString v_)


{-| The selected date. (default: `null`)
-}
date : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.date


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> Markup.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
density =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.density


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Markup.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.detent


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
detents : String -> Markup.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.detents


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose : Bool -> Markup.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
disableClose =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disableClose


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight :
    Bool
    -> Markup.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
disableHighlight =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Markup.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
disableHover =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disableHover


{-| Whether scroll buttons are disabled.
-}
disablePagination :
    M3e.Token.Value
        { true : M3e.Token.Supported
        , false : M3e.Token.Supported
        , auto : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePagination v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.disablePagination
        (M3e.Token.toString v_)


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disableRestoreFocus : M3e.Token.Supported
            }
            msg
disableRestoreFocus =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
disabledInteractive =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.disabledInteractive


{-| Whether to show tick marks. (default: `false`)
-}
discrete : Bool -> Markup.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
discrete =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
dismissLabel :
    String
    -> Markup.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
dismissLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> Markup.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.dismissible


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveBelow : M3e.Token.Supported
        , below : M3e.Token.Supported
        , none : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividers v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.dividers
        (M3e.Token.toString v_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> Markup.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
duration =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable : Bool -> Markup.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
editable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.editable


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> Markup.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
elevated =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> Markup.Html.Attr.Attr { c | emphasized : M3e.Token.Supported } msg
emphasized =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.emphasized


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> Markup.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
end =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> Markup.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
endDivider =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.endDivider


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endMode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.endMode
        (M3e.Token.toString v_)


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Markup.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
extended =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.extended


{-| Whether the icon is filled. (default: `false`)
-}
filled : Bool -> Markup.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
filled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.filled


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , none : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filter v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.filter
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
firstPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth :
    Bool
    -> Markup.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
fitAnchorWidth =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.fitAnchorWidth


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel :
    M3e.Token.Value { always : M3e.Token.Supported, auto : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabel v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.floatLabel
        (M3e.Token.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.for


{-| The grade of the icon. (default: `"medium"`)
-}
grade :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , low : M3e.Token.Supported
        , medium : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
grade v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.grade
        (M3e.Token.toString v_)


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> Markup.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
handle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel :
    String
    -> Markup.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
handleLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.handleLabel


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , above : M3e.Token.Supported
        , below : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPosition v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.headerPosition
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Markup.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction :
    Float
    -> Markup.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
hideFriction =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`)
-}
hideLoading : Bool -> Markup.Html.Attr.Attr { c | hideLoading : M3e.Token.Supported } msg
hideLoading =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
hideNoData : Bool -> Markup.Html.Attr.Attr { c | hideNoData : M3e.Token.Supported } msg
hideNoData =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideNoData


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize : Bool -> Markup.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
hidePageSize =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideRequiredMarker : M3e.Token.Supported
            }
            msg
hideRequiredMarker =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon :
    Bool
    -> Markup.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
hideSearchIcon =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideSelectionIndicator


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript :
    M3e.Token.Value
        { always : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , never : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscript v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.hideSubscript
        (M3e.Token.toString v_)


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Markup.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable : Bool -> Markup.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
hideable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.hideable


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightMode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.highlightMode
        (M3e.Token.toString v_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.href


{-| The icons to present. (default: `"none"`)
-}
icons :
    M3e.Token.Value
        { both : M3e.Token.Supported
        , none : M3e.Token.Supported
        , selected : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
icons v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.icons
        (M3e.Token.toString v_)


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
inline : Bool -> Markup.Html.Attr.Attr { c | inline : M3e.Token.Supported } msg
inline =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> Markup.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
inset =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> Markup.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
insetEnd =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> Markup.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
insetStart =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.insetStart


{-| Whether the step has an error. (default: `false`)
-}
invalid : Bool -> Markup.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
invalid =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Markup.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
inward =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.inward


{-| The accessible label given to the item's internal button. (default: `""`)
-}
itemLabel : String -> Markup.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
itemLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
itemsPerPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> Markup.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.label


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition :
    M3e.Token.Value { below : M3e.Token.Supported, end : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPosition v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.labelPosition
        (M3e.Token.toString v_)


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled : Bool -> Markup.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
labelled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
lastPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length : Float -> Markup.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
length =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.length


{-| The accessibility level of the heading.
-}
level : Int -> Markup.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
level =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> Markup.Html.Attr.Attr { c | linear : M3e.Token.Supported } msg
linear =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> Markup.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
loaded =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.loaded


{-| Whether options are being loaded. (default: `false`)
-}
loading : Bool -> Markup.Html.Attr.Attr { c | loading : M3e.Token.Supported } msg
loading =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
loadingLabel :
    String
    -> Markup.Html.Attr.Attr { c | loadingLabel : M3e.Token.Supported } msg
loadingLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Markup.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
lowered =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.lowered


{-| Exclude this heading from the table of contents generated by an `m3e-toc` component. `m3e-toc-ignore` is a valueless presence marker the `m3e-toc` reads from heading elements; it is not an `m3e-heading` CEM attribute, so it is injected here as a heading-scoped synthetic capability.
-}
tocIgnore : Bool -> Markup.Html.Attr.Attr { c | tocIgnore : M3e.Token.Supported } msg
tocIgnore =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.tocIgnore


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
max : Float -> Markup.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.max


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.maxDate


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Markup.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
maxDepth =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows : Float -> Markup.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
maxRows =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
min : Float -> Markup.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.min


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows : Float -> Markup.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
minRows =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal : Bool -> Markup.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
modal =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.modal


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
    -> Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.mode
        (M3e.Token.toString v_)


{-| The motion scheme. (default: `"standard"`)
-}
motion :
    M3e.Token.Value
        { expressive : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motion v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.motion
        (M3e.Token.toString v_)


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | nextMultiYearLabel : M3e.Token.Supported
            }
            msg
nextMultiYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.nextYearLabel


{-| Whether to disable animation. (default: `false`)
-}
noAnimate : Bool -> Markup.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
noAnimate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
noDataLabel :
    String
    -> Markup.Html.Attr.Attr { c | noDataLabel : M3e.Token.Supported } msg
noDataLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap : Bool -> Markup.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
noFocusTrap =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.noFocusTrap


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> Markup.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
opticalSize =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.opticalSize


{-| Whether the step is optional. (default: `false`)
-}
optional : Bool -> Markup.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
optional =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.optional


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.orientation
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit :
    Float
    -> Markup.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex : Float -> Markup.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
pageIndex =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.pageIndex


{-| The number of items to display in a page. (default: `50`)
-}
pageSize :
    M3e.Token.Value { number : M3e.Token.Supported, all : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSize v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.pageSize
        (M3e.Token.toString v_)


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.pageSizeVariant
        (M3e.Token.toString v_)


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes : String -> Markup.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
pageSizes =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> Markup.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
panelClass =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.panelClass


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
    -> Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.position
        (M3e.Token.toString v_)


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionX v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.positionX
        (M3e.Token.toString v_)


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionY v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.positionY
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMonthLabel : M3e.Token.Supported
            }
            msg
previousMonthLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
previousMultiYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> Markup.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
radius =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.radius


{-| Whether a range of dates can be selected. (default: `false`)
-}
range : Bool -> Markup.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
range =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.range


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Markup.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Markup.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.rel


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> Markup.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
removable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel :
    String
    -> Markup.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
removeLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.removeLabel


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.required


{-| The value to return from the dialog. (default: `""`)
-}
returnValue :
    String
    -> Markup.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
returnValue =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.returnValue


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.scheme
        (M3e.Token.toString v_)


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    M3e.Token.Value
        { hide : M3e.Token.Supported
        , reposition : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategy v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.scrollStrategy
        (M3e.Token.toString v_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Markup.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
secondary =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.secondary


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.selected


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex :
    Float
    -> Markup.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
selectedIndex =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.selectedIndex


{-| The shape of the toolbar. (default: `"square"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , circular : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.shape
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Markup.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.showDelay


{-| Whether to show first/last buttons. (default: `false`)
-}
showFirstLastButtons :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | showFirstLastButtons : M3e.Token.Supported
            }
            msg
showFirstLastButtons =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.showFirstLastButtons


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
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.size
        (M3e.Token.toString v_)


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> Markup.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
start =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Markup.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> Markup.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
startDivider =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.startDivider


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startMode v_ =
    Markup.Html.Attr.Internal.attribute
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
    -> Markup.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startView v_ =
    Markup.Html.Attr.Internal.attribute
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
    -> Markup.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
state v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.state
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> Markup.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.step


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> Markup.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
stretch =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.stretch


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> Markup.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
strongFocus =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> Markup.Html.Attr.Attr { c | submenu : M3e.Token.Supported } msg
submenu =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.submenu


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.target


{-| The search term to highlight. (default: `""`)
-}
term : String -> Markup.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.term


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> Markup.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
thin =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
threshold : Float -> Markup.Html.Attr.Attr { c | threshold : M3e.Token.Supported } msg
threshold =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.threshold


{-| Today's date. (default: `new Date()`)
-}
today : String -> Markup.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
today =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> Markup.Html.Attr.Attr { c | toggle : M3e.Token.Supported } msg
toggle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.toggle


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.toggleDirection
        (M3e.Token.toString v_)


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition v_ =
    Markup.Html.Attr.Internal.attribute
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
    -> Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures v_ =
    Markup.Html.Attr.Internal.attribute
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
    -> Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.type_
        (M3e.Token.toString v_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> Markup.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
unbounded =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.unbounded


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
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.variant
        (M3e.Token.toString v_)


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : Int -> Markup.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
weight =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.weight


{-| The width of the button. (default: `"default"`)
-}
width :
    M3e.Token.Value
        { default : M3e.Token.Supported
        , narrow : M3e.Token.Supported
        , wide : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
width v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shared.width
        (M3e.Token.toString v_)


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap : Bool -> Markup.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
wrap =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.wrap


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents : Bool -> Markup.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
wrapDetents =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
valueFloat : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
valueFloat =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.valueFloat


{-| A string representing the value of the switch. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.value


{-| Listen for `change` events.
-}
onChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onChange


{-| Listen for `opening` events.
-}
onOpening :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onOpening


{-| Listen for `opened` events.
-}
onOpened :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onOpened


{-| Listen for `closing` events.
-}
onClosing :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onClosing


{-| Listen for `closed` events.
-}
onClosed :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onClosed


{-| Listen for `click` events.
-}
onClick :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onClick


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onInput


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onToggle


{-| Listen for `value-change` events.
-}
onValueChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onValueChange


{-| Listen for `query` events.
-}
onQuery :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onQuery


{-| Listen for `clear` events.
-}
onClear :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onClear


{-| Listen for `page` events.
-}
onPage :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onPage


{-| Listen for `cancel` events.
-}
onCancel :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onCancel


{-| Listen for `remove` events.
-}
onRemove :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onRemove


{-| Listen for `invalid` events.
-}
onInvalid :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onInvalid


{-| Listen for `active-change` events.
-}
onActiveChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onActiveChange


{-| Listen for `highlight` events.
-}
onHighlight :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Shared.onHighlight


{-| Place content in the `leading` slot: stamp `slot="leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeading`) form.
-}
slotLeading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , sharedText : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        , avatar : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotLeading =
    Markup.Element.Internal.placeSlot "leading"


{-| Place content in the `title` slot: stamp `slot="title"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTitle`) form.
-}
slotTitle :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotTitle =
    Markup.Element.Internal.placeSlot "title"


{-| Place content in the `subtitle` slot: stamp `slot="subtitle"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSubtitle`) form.
-}
slotSubtitle :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotSubtitle =
    Markup.Element.Internal.placeSlot "subtitle"


{-| Place content in the `trailing` slot: stamp `slot="trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailing`) form.
-}
slotTrailing :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , sharedText : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        , searchBar : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        , avatar : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotTrailing =
    Markup.Element.Internal.placeSlot "trailing"


{-| Place content in the `leading-icon` slot: stamp `slot="leading-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeadingIcon`) form.
-}
slotLeadingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLeadingIcon =
    Markup.Element.Internal.placeSlot "leading-icon"


{-| Place content in the `trailing-icon` slot: stamp `slot="trailing-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailingIcon`) form.
-}
slotTrailingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotTrailingIcon =
    Markup.Element.Internal.placeSlot "trailing-icon"


{-| Place content in the `icon` slot: stamp `slot="icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotIcon`) form.
-}
slotIcon :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , loadingIndicator : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotIcon =
    Markup.Element.Internal.placeSlot "icon"


{-| Place content in the `loading` slot: stamp `slot="loading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLoading`) form.
-}
slotLoading : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLoading =
    Markup.Element.Internal.placeSlot "loading"


{-| Place content in the `no-data` slot: stamp `slot="no-data"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNoData`) form.
-}
slotNoData : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotNoData =
    Markup.Element.Internal.placeSlot "no-data"


{-| Place content in the `header` slot: stamp `slot="header"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotHeader`) form.
-}
slotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotHeader =
    Markup.Element.Internal.placeSlot "header"


{-| Place content in the `separator` slot: stamp `slot="separator"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSeparator`) form.
-}
slotSeparator : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSeparator =
    Markup.Element.Internal.placeSlot "separator"


{-| Place content in the `selected` slot: stamp `slot="selected"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSelected`) form.
-}
slotSelected :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , sharedIcon : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
slotSelected =
    Markup.Element.Internal.placeSlot "selected"


{-| Place content in the `selected-icon` slot: stamp `slot="selected-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSelectedIcon`) form.
-}
slotSelectedIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSelectedIcon =
    Markup.Element.Internal.placeSlot "selected-icon"


{-| Place content in the `content` slot: stamp `slot="content"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotContent`) form.
-}
slotContent : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotContent =
    Markup.Element.Internal.placeSlot "content"


{-| Place content in the `actions` slot: stamp `slot="actions"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotActions`) form.
-}
slotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotActions =
    Markup.Element.Internal.placeSlot "actions"


{-| Place content in the `footer` slot: stamp `slot="footer"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotFooter`) form.
-}
slotFooter : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotFooter =
    Markup.Element.Internal.placeSlot "footer"


{-| Place content in the `close-icon` slot: stamp `slot="close-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotCloseIcon`) form.
-}
slotCloseIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotCloseIcon =
    Markup.Element.Internal.placeSlot "close-icon"


{-| Place content in the `start` slot: stamp `slot="start"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotStart`) form.
-}
slotStart : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotStart =
    Markup.Element.Internal.placeSlot "start"


{-| Place content in the `end` slot: stamp `slot="end"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotEnd`) form.
-}
slotEnd : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotEnd =
    Markup.Element.Internal.placeSlot "end"


{-| Place content in the `overline` slot: stamp `slot="overline"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOverline`) form.
-}
slotOverline :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOverline =
    Markup.Element.Internal.placeSlot "overline"


{-| Place content in the `supporting-text` slot: stamp `slot="supporting-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSupportingText`) form.
-}
slotSupportingText :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotSupportingText =
    Markup.Element.Internal.placeSlot "supporting-text"


{-| Place content in the `toggle-icon` slot: stamp `slot="toggle-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotToggleIcon`) form.
-}
slotToggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotToggleIcon =
    Markup.Element.Internal.placeSlot "toggle-icon"


{-| Place content in the `items` slot: stamp `slot="items"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotItems`) form.
-}
slotItems : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotItems =
    Markup.Element.Internal.placeSlot "items"


{-| Place content in the `label` slot: stamp `slot="label"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLabel`) form.
-}
slotLabel : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLabel =
    Markup.Element.Internal.placeSlot "label"


{-| Place content in the `prefix` slot: stamp `slot="prefix"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrefix`) form.
-}
slotPrefix : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotPrefix =
    Markup.Element.Internal.placeSlot "prefix"


{-| Place content in the `prefix-text` slot: stamp `slot="prefix-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrefixText`) form.
-}
slotPrefixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotPrefixText =
    Markup.Element.Internal.placeSlot "prefix-text"


{-| Place content in the `suffix` slot: stamp `slot="suffix"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSuffix`) form.
-}
slotSuffix : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSuffix =
    Markup.Element.Internal.placeSlot "suffix"


{-| Place content in the `suffix-text` slot: stamp `slot="suffix-text"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSuffixText`) form.
-}
slotSuffixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSuffixText =
    Markup.Element.Internal.placeSlot "suffix-text"


{-| Place content in the `hint` slot: stamp `slot="hint"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotHint`) form.
-}
slotHint : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotHint =
    Markup.Element.Internal.placeSlot "hint"


{-| Place content in the `error` slot: stamp `slot="error"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotError`) form.
-}
slotError : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotError =
    Markup.Element.Internal.placeSlot "error"


{-| Place content in the `avatar` slot: stamp `slot="avatar"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotAvatar`) form.
-}
slotAvatar :
    Markup.Element.Element { avatar : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotAvatar =
    Markup.Element.Internal.placeSlot "avatar"


{-| Place content in the `remove-icon` slot: stamp `slot="remove-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotRemoveIcon`) form.
-}
slotRemoveIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotRemoveIcon =
    Markup.Element.Internal.placeSlot "remove-icon"


{-| Place content in the `input` slot: stamp `slot="input"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotInput`) form.
-}
slotInput : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotInput =
    Markup.Element.Internal.placeSlot "input"


{-| Place content in the `badge` slot: stamp `slot="badge"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotBadge`) form.
-}
slotBadge :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , badge : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotBadge =
    Markup.Element.Internal.placeSlot "badge"


{-| Place content in the `first-page-icon` slot: stamp `slot="first-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotFirstPageIcon`) form.
-}
slotFirstPageIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotFirstPageIcon =
    Markup.Element.Internal.placeSlot "first-page-icon"


{-| Place content in the `previous-page-icon` slot: stamp `slot="previous-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPreviousPageIcon`) form.
-}
slotPreviousPageIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotPreviousPageIcon =
    Markup.Element.Internal.placeSlot "previous-page-icon"


{-| Place content in the `next-page-icon` slot: stamp `slot="next-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNextPageIcon`) form.
-}
slotNextPageIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotNextPageIcon =
    Markup.Element.Internal.placeSlot "next-page-icon"


{-| Place content in the `last-page-icon` slot: stamp `slot="last-page-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLastPageIcon`) form.
-}
slotLastPageIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotLastPageIcon =
    Markup.Element.Internal.placeSlot "last-page-icon"


{-| Place content in the `subhead` slot: stamp `slot="subhead"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSubhead`) form.
-}
slotSubhead :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSubhead =
    Markup.Element.Internal.placeSlot "subhead"


{-| Place content in the `clear-icon` slot: stamp `slot="clear-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClearIcon`) form.
-}
slotClearIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotClearIcon =
    Markup.Element.Internal.placeSlot "clear-icon"


{-| Place content in the `open-leading` slot: stamp `slot="open-leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenLeading`) form.
-}
slotOpenLeading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOpenLeading =
    Markup.Element.Internal.placeSlot "open-leading"


{-| Place content in the `open-trailing` slot: stamp `slot="open-trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenTrailing`) form.
-}
slotOpenTrailing :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOpenTrailing =
    Markup.Element.Internal.placeSlot "open-trailing"


{-| Place content in the `closed-leading` slot: stamp `slot="closed-leading"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClosedLeading`) form.
-}
slotClosedLeading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotClosedLeading =
    Markup.Element.Internal.placeSlot "closed-leading"


{-| Place content in the `closed-trailing` slot: stamp `slot="closed-trailing"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotClosedTrailing`) form.
-}
slotClosedTrailing :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotClosedTrailing =
    Markup.Element.Internal.placeSlot "closed-trailing"


{-| Place content in the `search-icon` slot: stamp `slot="search-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotSearchIcon`) form.
-}
slotSearchIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSearchIcon =
    Markup.Element.Internal.placeSlot "search-icon"


{-| Place content in the `arrow` slot: stamp `slot="arrow"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotArrow`) form.
-}
slotArrow :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotArrow =
    Markup.Element.Internal.placeSlot "arrow"


{-| Place content in the `value` slot: stamp `slot="value"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotValue`) form.
-}
slotValue : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotValue =
    Markup.Element.Internal.placeSlot "value"


{-| Place content in the `next-icon` slot: stamp `slot="next-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotNextIcon`) form.
-}
slotNextIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotNextIcon =
    Markup.Element.Internal.placeSlot "next-icon"


{-| Place content in the `prev-icon` slot: stamp `slot="prev-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPrevIcon`) form.
-}
slotPrevIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotPrevIcon =
    Markup.Element.Internal.placeSlot "prev-icon"


{-| Place content in the `leading-button` slot: stamp `slot="leading-button"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotLeadingButton`) form.
-}
slotLeadingButton :
    Markup.Element.Element { button : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotLeadingButton =
    Markup.Element.Internal.placeSlot "leading-button"


{-| Place content in the `trailing-button` slot: stamp `slot="trailing-button"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotTrailingButton`) form.
-}
slotTrailingButton :
    Markup.Element.Element { iconButton : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotTrailingButton =
    Markup.Element.Internal.placeSlot "trailing-button"


{-| Place content in the `done-icon` slot: stamp `slot="done-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotDoneIcon`) form.
-}
slotDoneIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotDoneIcon =
    Markup.Element.Internal.placeSlot "done-icon"


{-| Place content in the `edit-icon` slot: stamp `slot="edit-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotEditIcon`) form.
-}
slotEditIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotEditIcon =
    Markup.Element.Internal.placeSlot "edit-icon"


{-| Place content in the `error-icon` slot: stamp `slot="error-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotErrorIcon`) form.
-}
slotErrorIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotErrorIcon =
    Markup.Element.Internal.placeSlot "error-icon"


{-| Place content in the `step` slot: stamp `slot="step"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotStep`) form.
-}
slotStep :
    Markup.Element.Element { step : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotStep =
    Markup.Element.Internal.placeSlot "step"


{-| Place content in the `panel` slot: stamp `slot="panel"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotPanel`) form.
-}
slotPanel :
    Markup.Element.Element
        { stepPanel : M3e.Kind.Brand
        , tabPanel : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotPanel =
    Markup.Element.Internal.placeSlot "panel"


{-| Place content in the `open-toggle-icon` slot: stamp `slot="open-toggle-icon"` onto an element. The generalized INPUT row is the UNION of every component's kinds for this slot, so an element valid in SOME component's version of the slot type-checks here (one valid in none is a compile error); the free OUTPUT row composes into a container's `List Element`. Cross-component misuse is caught by the codegen-aware `Cem.ValidSlotKind` review rule, which also upgrades this to the kind-precise per-component / specific-barrel (`<component>SlotOpenToggleIcon`) form.
-}
slotOpenToggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotOpenToggleIcon =
    Markup.Element.Internal.placeSlot "open-toggle-icon"
