module M3e exposing
    ( tree, treeItem, toolbar, toc, tocItem, themeIcon
    , theme, textareaAutosize, tabs, tabPanel, tab, switch, stepperReset
    , stepperPrevious, step, stepPanel, stepper, splitPane, splitButton, snackbar
    , slider, sliderThumb, slideGroup, skeleton, shape, segmentedButton, buttonSegment
    , searchView, searchBar, radioGroup, radio, progressElementIndicatorBase, paginator, select
    , navRailToggle, navRail, navMenuItemGroup, navMenu, navMenuItem, navBar, navItem
    , menuItemRadio, menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger, menuItemElementBase
    , loadingIndicator, selectionList, listOption, actionList, expandableListItem, listAction, listItemButton
    , list, listItem, icon, heading, fabMenuTrigger, fabMenu, fab
    , accordion, expansionPanel, expansionHeader, drawerToggle, drawerContainer, divider, dialogTrigger
    , dialog, dialogAction, datepickerToggle, datepicker, contentPane, suggestionChip, inputChipSet
    , inputChip, filterChipSet, filterChip, chipSet, assistChip, chip, checkbox
    , card, calendar, yearView, multiYearView, monthView, tooltip, richTooltip
    , tooltipElementBase, richTooltipAction, buttonGroup, iconButton, button, breadcrumb, breadcrumbItem
    , breadcrumbItemButton, bottomSheetTrigger, bottomSheet, bottomSheetAction, badge, avatar, autocomplete
    , formField, optionPanel, floatingPanel, optgroup, option, focusTrap, appBar
    , textOverflow, textHighlight, stateLayer, slide, scrollContainer, ripple, pseudoRadio
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, action, actionable
    , active, activeDate, alert, anchorOffset, animation, ariaInvalid, autoActivate
    , bufferValue, cascade, caseSensitive, centered, checked, clearLabel, clearable
    , closeLabel, color, completed, confirmLabel, contained, contrast, current
    , date, density, detent, disableClose, disableHighlight, disableHover, disablePagination
    , disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible, dividers
    , download, duration, editable, elevated, emphasized, end, endDivider
    , endMode, extended, filled, filter, firstPageLabel, fitAnchorWidth, floatLabel
    , for, grade, handle, handleLabel, headerPosition, hideDelay, hideFriction
    , hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript
    , hideToggle, hideable, highlightMode, href, icons, indeterminate, inline
    , inset, insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel
    , label, labelPosition, labelled, lastPageLabel, length, level, linear
    , loaded, loading, loadingLabel, lowered, max, maxDate, maxDepth
    , maxRows, min, minDate, minRows, modal, mode, motion
    , multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel
    , noFocusTrap, open, opticalSize, optional, orientation, overshootLimit, pageIndex
    , pageSize, pageSizeVariant, pageSizes, panelClass, position, positionX, positionY
    , previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius, range, rangeEnd
    , rangeStart, rel, removable, removeLabel, required, returnValue, scheme
    , scrollStrategy, secondary, selected, selectedIndex, shapeAttr, showDelay, showFirstLastButtons
    , size, start, startAt, startDivider, startMode, startView, state
    , stepAttr, stretch, strongFocus, submenu, target, term, thin
    , threshold, today, toggle, toggleDirection, togglePosition, touchGestures, type_
    , unbounded, variant, vertical, weight, width, wrap, wrapDetents
    , onChange, onOpening, onOpened, onClosing, onClosed, onClick, onBeforeinput
    , onInput, onBeforetoggle, onToggle, onValueChange, onQuery, onClear, onPage
    , onCancel, onRemove, onInvalid, onActiveChange, onHighlight
    )

{-|
The one-import barrel. Re-exposes every component constructor plus the whole shared attribute/event vocabulary, so `import M3e exposing (..)` gives you every constructor together with `disabled`/`variant`/`onClick`/… . Token values stay in `M3e.Value` (re-exposing hundreds here would bloat the namespace). Each constructor takes `[attributes] [content]`; reach for the per-component `M3e.<Component>` modules when you want the strict, component-scoped types.

@docs tree, treeItem, toolbar, toc, tocItem, themeIcon
@docs theme, textareaAutosize, tabs, tabPanel, tab, switch
@docs stepperReset, stepperPrevious, step, stepPanel, stepper, splitPane
@docs splitButton, snackbar, slider, sliderThumb, slideGroup, skeleton
@docs shape, segmentedButton, buttonSegment, searchView, searchBar, radioGroup
@docs radio, progressElementIndicatorBase, paginator, select, navRailToggle, navRail
@docs navMenuItemGroup, navMenu, navMenuItem, navBar, navItem, menuItemRadio
@docs menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger, menuItemElementBase
@docs loadingIndicator, selectionList, listOption, actionList, expandableListItem, listAction
@docs listItemButton, list, listItem, icon, heading, fabMenuTrigger
@docs fabMenu, fab, accordion, expansionPanel, expansionHeader, drawerToggle
@docs drawerContainer, divider, dialogTrigger, dialog, dialogAction, datepickerToggle
@docs datepicker, contentPane, suggestionChip, inputChipSet, inputChip, filterChipSet
@docs filterChip, chipSet, assistChip, chip, checkbox, card
@docs calendar, yearView, multiYearView, monthView, tooltip, richTooltip
@docs tooltipElementBase, richTooltipAction, buttonGroup, iconButton, button, breadcrumb
@docs breadcrumbItem, breadcrumbItemButton, bottomSheetTrigger, bottomSheet, bottomSheetAction, badge
@docs avatar, autocomplete, formField, optionPanel, floatingPanel, optgroup
@docs option, focusTrap, appBar, textOverflow, textHighlight, stateLayer
@docs slide, scrollContainer, ripple, pseudoRadio, pseudoCheckbox, focusRing
@docs elevation, collapsible, actionElementBase, action, actionable, active
@docs activeDate, alert, anchorOffset, animation, ariaInvalid, autoActivate
@docs bufferValue, cascade, caseSensitive, centered, checked, clearLabel
@docs clearable, closeLabel, color, completed, confirmLabel, contained
@docs contrast, current, date, density, detent, disableClose
@docs disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive
@docs discrete, dismissLabel, dismissible, dividers, download, duration
@docs editable, elevated, emphasized, end, endDivider, endMode
@docs extended, filled, filter, firstPageLabel, fitAnchorWidth, floatLabel
@docs for, grade, handle, handleLabel, headerPosition, hideDelay
@docs hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon
@docs hideSelectionIndicator, hideSubscript, hideToggle, hideable, highlightMode, href
@docs icons, indeterminate, inline, inset, insetEnd, insetStart
@docs invalid, inward, itemLabel, itemsPerPageLabel, label, labelPosition
@docs labelled, lastPageLabel, length, level, linear, loaded
@docs loading, loadingLabel, lowered, max, maxDate, maxDepth
@docs maxRows, min, minDate, minRows, modal, mode
@docs motion, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel
@docs noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional
@docs orientation, overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizes
@docs panelClass, position, positionX, positionY, previousMonthLabel, previousMultiYearLabel
@docs previousPageLabel, previousYearLabel, radius, range, rangeEnd, rangeStart
@docs rel, removable, removeLabel, required, returnValue, scheme
@docs scrollStrategy, secondary, selected, selectedIndex, shapeAttr, showDelay
@docs showFirstLastButtons, size, start, startAt, startDivider, startMode
@docs startView, state, stepAttr, stretch, strongFocus, submenu
@docs target, term, thin, threshold, today, toggle
@docs toggleDirection, togglePosition, touchGestures, type_, unbounded, variant
@docs vertical, weight, width, wrap, wrapDetents, onChange
@docs onOpening, onOpened, onClosing, onClosed, onClick, onBeforeinput
@docs onInput, onBeforetoggle, onToggle, onValueChange, onQuery, onClear
@docs onPage, onCancel, onRemove, onInvalid, onActiveChange, onHighlight
-}


import Json.Decode
import M3e.Accordion
import M3e.ActionElementBase
import M3e.ActionList
import M3e.AppBar
import M3e.AssistChip
import M3e.Autocomplete
import M3e.Avatar
import M3e.Badge
import M3e.BottomSheet
import M3e.BottomSheetAction
import M3e.BottomSheetTrigger
import M3e.Breadcrumb
import M3e.BreadcrumbItem
import M3e.BreadcrumbItemButton
import M3e.Button
import M3e.ButtonGroup
import M3e.ButtonSegment
import M3e.Calendar
import M3e.Card
import M3e.Cem.Attr
import M3e.Cem.Vocab
import M3e.Checkbox
import M3e.Chip
import M3e.ChipSet
import M3e.Collapsible
import M3e.Content
import M3e.ContentPane
import M3e.Datepicker
import M3e.DatepickerToggle
import M3e.Dialog
import M3e.DialogAction
import M3e.DialogTrigger
import M3e.Divider
import M3e.DrawerContainer
import M3e.DrawerToggle
import M3e.Element
import M3e.Elevation
import M3e.ExpandableListItem
import M3e.ExpansionHeader
import M3e.ExpansionPanel
import M3e.Fab
import M3e.FabMenu
import M3e.FabMenuTrigger
import M3e.FilterChip
import M3e.FilterChipSet
import M3e.FloatingPanel
import M3e.FocusRing
import M3e.FocusTrap
import M3e.FormField
import M3e.Heading
import M3e.Icon
import M3e.IconButton
import M3e.InputChip
import M3e.InputChipSet
import M3e.List
import M3e.ListAction
import M3e.ListItem
import M3e.ListItemButton
import M3e.ListOption
import M3e.LoadingIndicator
import M3e.Menu
import M3e.MenuItem
import M3e.MenuItemCheckbox
import M3e.MenuItemElementBase
import M3e.MenuItemGroup
import M3e.MenuItemRadio
import M3e.MenuTrigger
import M3e.MonthView
import M3e.MultiYearView
import M3e.NavBar
import M3e.NavItem
import M3e.NavMenu
import M3e.NavMenuItem
import M3e.NavMenuItemGroup
import M3e.NavRail
import M3e.NavRailToggle
import M3e.Optgroup
import M3e.Option
import M3e.OptionPanel
import M3e.Paginator
import M3e.ProgressElementIndicatorBase
import M3e.PseudoCheckbox
import M3e.PseudoRadio
import M3e.Radio
import M3e.RadioGroup
import M3e.RichTooltip
import M3e.RichTooltipAction
import M3e.Ripple
import M3e.ScrollContainer
import M3e.SearchBar
import M3e.SearchView
import M3e.SegmentedButton
import M3e.Select
import M3e.SelectionList
import M3e.Shape
import M3e.Skeleton
import M3e.Slide
import M3e.SlideGroup
import M3e.Slider
import M3e.SliderThumb
import M3e.Snackbar
import M3e.SplitButton
import M3e.SplitPane
import M3e.StateLayer
import M3e.Step
import M3e.StepPanel
import M3e.Stepper
import M3e.StepperPrevious
import M3e.StepperReset
import M3e.SuggestionChip
import M3e.Switch
import M3e.Tab
import M3e.TabPanel
import M3e.Tabs
import M3e.TextHighlight
import M3e.TextOverflow
import M3e.TextareaAutosize
import M3e.Theme
import M3e.ThemeIcon
import M3e.Toc
import M3e.TocItem
import M3e.Toolbar
import M3e.Tooltip
import M3e.TooltipElementBase
import M3e.Tree
import M3e.TreeItem
import M3e.Value
import M3e.YearView


{-| Convenience binding for the `M3e.Tree` element: `view` re-exposed from `M3e.Tree`. Import that module directly for the strict, component-scoped types. -}
tree :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , cascade : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tree : M3e.Value.Supported } msg
tree =
    M3e.Tree.view


{-| Convenience binding for the `M3e.TreeItem` element: `view` re-exposed from `M3e.TreeItem`. Import that module directly for the strict, component-scoped types. -}
treeItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , openToggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | treeItem : M3e.Value.Supported } msg
treeItem =
    M3e.TreeItem.view


{-| Convenience binding for the `M3e.Toolbar` element: `view` re-exposed from `M3e.Toolbar`. Import that module directly for the strict, component-scoped types. -}
toolbar :
    List (M3e.Cem.Attr.Attr { elevated : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | toolbar : M3e.Value.Supported } msg
toolbar =
    M3e.Toolbar.view


{-| Convenience binding for the `M3e.Toc` element: `view` re-exposed from `M3e.Toc`. Import that module directly for the strict, component-scoped types. -}
toc :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , maxDepth : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , title : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | toc : M3e.Value.Supported } msg
toc =
    M3e.Toc.view


{-| Convenience binding for the `M3e.TocItem` element: `view` re-exposed from `M3e.TocItem`. Import that module directly for the strict, component-scoped types. -}
tocItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tocItem : M3e.Value.Supported } msg
tocItem =
    M3e.TocItem.view


{-| Convenience binding for the `M3e.ThemeIcon` element: `view` re-exposed from `M3e.ThemeIcon`. Import that module directly for the strict, component-scoped types. -}
themeIcon :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | themeIcon : M3e.Value.Supported } msg
themeIcon =
    M3e.ThemeIcon.view


{-| Convenience binding for the `M3e.Theme` element: `view` re-exposed from `M3e.Theme`. Import that module directly for the strict, component-scoped types. -}
theme :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , contrast : M3e.Value.Supported
    , density : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , strongFocus : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , motion : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | theme : M3e.Value.Supported } msg
theme =
    M3e.Theme.view


{-| Convenience binding for the `M3e.TextareaAutosize` element: `view` re-exposed from `M3e.TextareaAutosize`. Import that module directly for the strict, component-scoped types. -}
textareaAutosize :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , maxRows : M3e.Value.Supported
    , minRows : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | textareaAutosize : M3e.Value.Supported } msg
textareaAutosize =
    M3e.TextareaAutosize.view


{-| Convenience binding for the `M3e.Tabs` element: `view` re-exposed from `M3e.Tabs`. Import that module directly for the strict, component-scoped types. -}
tabs :
    List (M3e.Cem.Attr.Attr { disablePagination : M3e.Value.Supported
    , headerPosition : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , stretch : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , panel : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | tabs : M3e.Value.Supported } msg
tabs =
    M3e.Tabs.view


{-| Convenience binding for the `M3e.TabPanel` element: `view` re-exposed from `M3e.TabPanel`. Import that module directly for the strict, component-scoped types. -}
tabPanel :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tabPanel : M3e.Value.Supported } msg
tabPanel =
    M3e.TabPanel.view


{-| Convenience binding for the `M3e.Tab` element: `view` re-exposed from `M3e.Tab`. Import that module directly for the strict, component-scoped types. -}
tab :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | tab : M3e.Value.Supported } msg
tab =
    M3e.Tab.view


{-| Convenience binding for the `M3e.Switch` element: `view` re-exposed from `M3e.Switch`. Import that module directly for the strict, component-scoped types. -}
switch :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , icons : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | switch : M3e.Value.Supported } msg
switch =
    M3e.Switch.view


{-| Convenience binding for the `M3e.StepperReset` element: `view` re-exposed from `M3e.StepperReset`. Import that module directly for the strict, component-scoped types. -}
stepperReset :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | stepperReset : M3e.Value.Supported } msg
stepperReset =
    M3e.StepperReset.view


{-| Convenience binding for the `M3e.StepperPrevious` element: `view` re-exposed from `M3e.StepperPrevious`. Import that module directly for the strict, component-scoped types. -}
stepperPrevious :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | stepperPrevious : M3e.Value.Supported } msg
stepperPrevious =
    M3e.StepperPrevious.view


{-| Convenience binding for the `M3e.Step` element: `view` re-exposed from `M3e.Step`. Import that module directly for the strict, component-scoped types. -}
step :
    List (M3e.Cem.Attr.Attr { completed : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , editable : M3e.Value.Supported
    , for : M3e.Value.Supported
    , optional : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , invalid : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , doneIcon : M3e.Value.Supported
    , editIcon : M3e.Value.Supported
    , errorIcon : M3e.Value.Supported
    , hint : M3e.Value.Supported
    , error : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | step : M3e.Value.Supported } msg
step =
    M3e.Step.view


{-| Convenience binding for the `M3e.StepPanel` element: `view` re-exposed from `M3e.StepPanel`. Import that module directly for the strict, component-scoped types. -}
stepPanel :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , actions : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | stepPanel : M3e.Value.Supported } msg
stepPanel =
    M3e.StepPanel.view


{-| Convenience binding for the `M3e.Stepper` element: `view` re-exposed from `M3e.Stepper`. Import that module directly for the strict, component-scoped types. -}
stepper :
    List (M3e.Cem.Attr.Attr { headerPosition : M3e.Value.Supported
    , labelPosition : M3e.Value.Supported
    , linear : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { step : M3e.Value.Supported
    , panel : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | stepper : M3e.Value.Supported } msg
stepper =
    M3e.Stepper.view


{-| Convenience binding for the `M3e.SplitPane` element: `view` re-exposed from `M3e.SplitPane`. Import that module directly for the strict, component-scoped types. -}
splitPane :
    List (M3e.Cem.Attr.Attr { label : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , step : M3e.Value.Supported
    , value : M3e.Value.Supported
    , wrapDetents : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | splitPane : M3e.Value.Supported } msg
splitPane =
    M3e.SplitPane.view


{-| Convenience binding for the `M3e.SplitButton` element: `view` re-exposed from `M3e.SplitButton`. Import that module directly for the strict, component-scoped types. -}
splitButton :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leadingButton : M3e.Value.Supported
    , trailingButton : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
splitButton =
    M3e.SplitButton.view


{-| Convenience binding for the `M3e.Snackbar` element: `view` re-exposed from `M3e.Snackbar`. Import that module directly for the strict, component-scoped types. -}
snackbar :
    List (M3e.Cem.Attr.Attr { action : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , duration : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | snackbar : M3e.Value.Supported } msg
snackbar =
    M3e.Snackbar.view


{-| Convenience binding for the `M3e.Slider` element: `view` re-exposed from `M3e.Slider`. Import that module directly for the strict, component-scoped types. -}
slider :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , discrete : M3e.Value.Supported
    , labelled : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , step : M3e.Value.Supported
    , size : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | slider : M3e.Value.Supported } msg
slider =
    M3e.Slider.view


{-| Convenience binding for the `M3e.SliderThumb` element: `view` re-exposed from `M3e.SliderThumb`. Import that module directly for the strict, component-scoped types. -}
sliderThumb :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onValueChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | sliderThumb : M3e.Value.Supported } msg
sliderThumb =
    M3e.SliderThumb.view


{-| Convenience binding for the `M3e.SlideGroup` element: `view` re-exposed from `M3e.SlideGroup`. Import that module directly for the strict, component-scoped types. -}
slideGroup :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , threshold : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | slideGroup : M3e.Value.Supported } msg
slideGroup =
    M3e.SlideGroup.view


{-| Convenience binding for the `M3e.Skeleton` element: `view` re-exposed from `M3e.Skeleton`. Import that module directly for the strict, component-scoped types. -}
skeleton :
    List (M3e.Cem.Attr.Attr { animation : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , loaded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | skeleton : M3e.Value.Supported } msg
skeleton =
    M3e.Skeleton.view


{-| Convenience binding for the `M3e.Shape` element: `view` re-exposed from `M3e.Shape`. Import that module directly for the strict, component-scoped types. -}
shape :
    List (M3e.Cem.Attr.Attr { name : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | shape : M3e.Value.Supported } msg
shape =
    M3e.Shape.view


{-| Convenience binding for the `M3e.SegmentedButton` element: `view` re-exposed from `M3e.SegmentedButton`. Import that module directly for the strict, component-scoped types. -}
segmentedButton :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | segmentedButton : M3e.Value.Supported } msg
segmentedButton =
    M3e.SegmentedButton.view


{-| Convenience binding for the `M3e.ButtonSegment` element: `view` re-exposed from `M3e.ButtonSegment`. Import that module directly for the strict, component-scoped types. -}
buttonSegment :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | buttonSegment : M3e.Value.Supported } msg
buttonSegment =
    M3e.ButtonSegment.view


{-| Convenience binding for the `M3e.SearchView` element: `view` re-exposed from `M3e.SearchView`. Import that module directly for the strict, component-scoped types. -}
searchView :
    List (M3e.Cem.Attr.Attr { contained : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , open : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , hideSearchIcon : M3e.Value.Supported
    , onQuery : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , input : M3e.Value.Supported
    , openLeading : M3e.Value.Supported
    , openTrailing : M3e.Value.Supported
    , closedLeading : M3e.Value.Supported
    , closedTrailing : M3e.Value.Supported
    , searchIcon : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchView : M3e.Value.Supported } msg
searchView =
    M3e.SearchView.view


{-| Convenience binding for the `M3e.SearchBar` element: `view` re-exposed from `M3e.SearchBar`. Import that module directly for the strict, component-scoped types. -}
searchBar :
    List (M3e.Cem.Attr.Attr { clearable : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , input : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchBar : M3e.Value.Supported } msg
searchBar =
    M3e.SearchBar.view


{-| Convenience binding for the `M3e.RadioGroup` element: `view` re-exposed from `M3e.RadioGroup`. Import that module directly for the strict, component-scoped types. -}
radioGroup :
    List (M3e.Cem.Attr.Attr { ariaInvalid : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | radioGroup : M3e.Value.Supported } msg
radioGroup =
    M3e.RadioGroup.view


{-| Convenience binding for the `M3e.Radio` element: `view` re-exposed from `M3e.Radio`. Import that module directly for the strict, component-scoped types. -}
radio :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | radio : M3e.Value.Supported } msg
radio =
    M3e.Radio.view


{-| Convenience binding for the `M3e.ProgressElementIndicatorBase` element: `view` re-exposed from `M3e.ProgressElementIndicatorBase`. Import that module directly for the strict, component-scoped types. -}
progressElementIndicatorBase :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , max : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s
        | progressElementIndicatorBase : M3e.Value.Supported
    } msg
progressElementIndicatorBase =
    M3e.ProgressElementIndicatorBase.view


{-| Convenience binding for the `M3e.Paginator` element: `view` re-exposed from `M3e.Paginator`. Import that module directly for the strict, component-scoped types. -}
paginator :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , firstPageLabel : M3e.Value.Supported
    , hidePageSize : M3e.Value.Supported
    , itemsPerPageLabel : M3e.Value.Supported
    , lastPageLabel : M3e.Value.Supported
    , length : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , pageIndex : M3e.Value.Supported
    , pageSize : M3e.Value.Supported
    , pageSizes : M3e.Value.Supported
    , pageSizeVariant : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , showFirstLastButtons : M3e.Value.Supported
    , onPage : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { firstPageIcon : M3e.Value.Supported
    , previousPageIcon : M3e.Value.Supported
    , nextPageIcon : M3e.Value.Supported
    , lastPageIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | paginator : M3e.Value.Supported } msg
paginator =
    M3e.Paginator.view


{-| Convenience binding for the `M3e.Select` element: `view` re-exposed from `M3e.Select`. Import that module directly for the strict, component-scoped types. -}
select :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , value : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | select : M3e.Value.Supported } msg
select =
    M3e.Select.view


{-| Convenience binding for the `M3e.NavRailToggle` element: `view` re-exposed from `M3e.NavRailToggle`. Import that module directly for the strict, component-scoped types. -}
navRailToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navRailToggle : M3e.Value.Supported } msg
navRailToggle =
    M3e.NavRailToggle.view


{-| Convenience binding for the `M3e.NavRail` element: `view` re-exposed from `M3e.NavRail`. Import that module directly for the strict, component-scoped types. -}
navRail :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navRail : M3e.Value.Supported } msg
navRail =
    M3e.NavRail.view


{-| Convenience binding for the `M3e.NavMenuItemGroup` element: `view` re-exposed from `M3e.NavMenuItemGroup`. Import that module directly for the strict, component-scoped types. -}
navMenuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { label : M3e.Value.Supported
    , default : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navMenuItemGroup : M3e.Value.Supported } msg
navMenuItemGroup =
    M3e.NavMenuItemGroup.view


{-| Convenience binding for the `M3e.NavMenu` element: `view` re-exposed from `M3e.NavMenu`. Import that module directly for the strict, component-scoped types. -}
navMenu :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navMenu : M3e.Value.Supported } msg
navMenu =
    M3e.NavMenu.view


{-| Convenience binding for the `M3e.NavMenuItem` element: `view` re-exposed from `M3e.NavMenuItem`. Import that module directly for the strict, component-scoped types. -}
navMenuItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , badge : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Value.Supported } msg
navMenuItem =
    M3e.NavMenuItem.view


{-| Convenience binding for the `M3e.NavBar` element: `view` re-exposed from `M3e.NavBar`. Import that module directly for the strict, component-scoped types. -}
navBar :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navBar : M3e.Value.Supported } msg
navBar =
    M3e.NavBar.view


{-| Convenience binding for the `M3e.NavItem` element: `view` re-exposed from `M3e.NavItem`. Import that module directly for the strict, component-scoped types. -}
navItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navItem : M3e.Value.Supported } msg
navItem =
    M3e.NavItem.view


{-| Convenience binding for the `M3e.MenuItemRadio` element: `view` re-exposed from `M3e.MenuItemRadio`. Import that module directly for the strict, component-scoped types. -}
menuItemRadio :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , checked : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItemRadio : M3e.Value.Supported } msg
menuItemRadio =
    M3e.MenuItemRadio.view


{-| Convenience binding for the `M3e.MenuItemGroup` element: `view` re-exposed from `M3e.MenuItemGroup`. Import that module directly for the strict, component-scoped types. -}
menuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | menuItemGroup : M3e.Value.Supported } msg
menuItemGroup =
    M3e.MenuItemGroup.view


{-| Convenience binding for the `M3e.MenuItemCheckbox` element: `view` re-exposed from `M3e.MenuItemCheckbox`. Import that module directly for the strict, component-scoped types. -}
menuItemCheckbox :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , checked : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItemCheckbox : M3e.Value.Supported } msg
menuItemCheckbox =
    M3e.MenuItemCheckbox.view


{-| Convenience binding for the `M3e.Menu` element: `view` re-exposed from `M3e.Menu`. Import that module directly for the strict, component-scoped types. -}
menu :
    List (M3e.Cem.Attr.Attr { positionX : M3e.Value.Supported
    , positionY : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , submenu : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | menu : M3e.Value.Supported } msg
menu =
    M3e.Menu.view


{-| Convenience binding for the `M3e.MenuItem` element: `view` re-exposed from `M3e.MenuItem`. Import that module directly for the strict, component-scoped types. -}
menuItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItem : M3e.Value.Supported } msg
menuItem =
    M3e.MenuItem.view


{-| Convenience binding for the `M3e.MenuTrigger` element: `view` re-exposed from `M3e.MenuTrigger`. Import that module directly for the strict, component-scoped types. -}
menuTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | menuTrigger : M3e.Value.Supported } msg
menuTrigger =
    M3e.MenuTrigger.view


{-| Convenience binding for the `M3e.MenuItemElementBase` element: `view` re-exposed from `M3e.MenuItemElementBase`. Import that module directly for the strict, component-scoped types. -}
menuItemElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | menuItemElementBase : M3e.Value.Supported } msg
menuItemElementBase =
    M3e.MenuItemElementBase.view


{-| Convenience binding for the `M3e.LoadingIndicator` element: `view` re-exposed from `M3e.LoadingIndicator`. Import that module directly for the strict, component-scoped types. -}
loadingIndicator :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Value.Supported } msg
loadingIndicator =
    M3e.LoadingIndicator.view


{-| Convenience binding for the `M3e.SelectionList` element: `view` re-exposed from `M3e.SelectionList`. Import that module directly for the strict, component-scoped types. -}
selectionList :
    List (M3e.Cem.Attr.Attr { hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | selectionList : M3e.Value.Supported } msg
selectionList =
    M3e.SelectionList.view


{-| Convenience binding for the `M3e.ListOption` element: `view` re-exposed from `M3e.ListOption`. Import that module directly for the strict, component-scoped types. -}
listOption :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listOption : M3e.Value.Supported } msg
listOption =
    M3e.ListOption.view


{-| Convenience binding for the `M3e.ActionList` element: `view` re-exposed from `M3e.ActionList`. Import that module directly for the strict, component-scoped types. -}
actionList :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | actionList : M3e.Value.Supported } msg
actionList =
    M3e.ActionList.view


{-| Convenience binding for the `M3e.ExpandableListItem` element: `view` re-exposed from `M3e.ExpandableListItem`. Import that module directly for the strict, component-scoped types. -}
expandableListItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , items : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | expandableListItem : M3e.Value.Supported } msg
expandableListItem =
    M3e.ExpandableListItem.view


{-| Convenience binding for the `M3e.ListAction` element: `view` re-exposed from `M3e.ListAction`. Import that module directly for the strict, component-scoped types. -}
listAction :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listAction : M3e.Value.Supported } msg
listAction =
    M3e.ListAction.view


{-| Convenience binding for the `M3e.ListItemButton` element: `view` re-exposed from `M3e.ListItemButton`. Import that module directly for the strict, component-scoped types. -}
listItemButton :
    List (M3e.Cem.Attr.Attr { href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listItemButton : M3e.Value.Supported } msg
listItemButton =
    M3e.ListItemButton.view


{-| Convenience binding for the `M3e.List` element: `view` re-exposed from `M3e.List`. Import that module directly for the strict, component-scoped types. -}
list :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | list : M3e.Value.Supported } msg
list =
    M3e.List.view


{-| Convenience binding for the `M3e.ListItem` element: `view` re-exposed from `M3e.ListItem`. Import that module directly for the strict, component-scoped types. -}
listItem :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listItem : M3e.Value.Supported } msg
listItem =
    M3e.ListItem.view


{-| Convenience binding for the `M3e.Icon` element: `view` re-exposed from `M3e.Icon`. Import that module directly for the strict, component-scoped types. -}
icon :
    List (M3e.Cem.Attr.Attr { filled : M3e.Value.Supported
    , grade : M3e.Value.Supported
    , opticalSize : M3e.Value.Supported
    , name : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , weight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | icon : M3e.Value.Supported } msg
icon =
    M3e.Icon.view


{-| Convenience binding for the `M3e.Heading` element: `view` re-exposed from `M3e.Heading`. Import that module directly for the strict, component-scoped types. -}
heading :
    List (M3e.Cem.Attr.Attr { emphasized : M3e.Value.Supported
    , level : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | heading : M3e.Value.Supported } msg
heading =
    M3e.Heading.view


{-| Convenience binding for the `M3e.FabMenuTrigger` element: `view` re-exposed from `M3e.FabMenuTrigger`. Import that module directly for the strict, component-scoped types. -}
fabMenuTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | fabMenuTrigger : M3e.Value.Supported } msg
fabMenuTrigger =
    M3e.FabMenuTrigger.view


{-| Convenience binding for the `M3e.FabMenu` element: `view` re-exposed from `M3e.FabMenu`. Import that module directly for the strict, component-scoped types. -}
fabMenu :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | fabMenu : M3e.Value.Supported } msg
fabMenu =
    M3e.FabMenu.view


{-| Convenience binding for the `M3e.Fab` element: `view` re-exposed from `M3e.Fab`. Import that module directly for the strict, component-scoped types. -}
fab :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , extended : M3e.Value.Supported
    , href : M3e.Value.Supported
    , lowered : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | fab : M3e.Value.Supported } msg
fab =
    M3e.Fab.view


{-| Convenience binding for the `M3e.Accordion` element: `view` re-exposed from `M3e.Accordion`. Import that module directly for the strict, component-scoped types. -}
accordion :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | accordion : M3e.Value.Supported } msg
accordion =
    M3e.Accordion.view


{-| Convenience binding for the `M3e.ExpansionPanel` element: `view` re-exposed from `M3e.ExpansionPanel`. Import that module directly for the strict, component-scoped types. -}
expansionPanel :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideToggle : M3e.Value.Supported
    , open : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , header : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | expansionPanel : M3e.Value.Supported } msg
expansionPanel =
    M3e.ExpansionPanel.view


{-| Convenience binding for the `M3e.ExpansionHeader` element: `view` re-exposed from `M3e.ExpansionHeader`. Import that module directly for the strict, component-scoped types. -}
expansionHeader :
    List (M3e.Cem.Attr.Attr { hideToggle : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | expansionHeader : M3e.Value.Supported } msg
expansionHeader =
    M3e.ExpansionHeader.view


{-| Convenience binding for the `M3e.DrawerToggle` element: `view` re-exposed from `M3e.DrawerToggle`. Import that module directly for the strict, component-scoped types. -}
drawerToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | drawerToggle : M3e.Value.Supported } msg
drawerToggle =
    M3e.DrawerToggle.view


{-| Convenience binding for the `M3e.DrawerContainer` element: `view` re-exposed from `M3e.DrawerContainer`. Import that module directly for the strict, component-scoped types. -}
drawerContainer :
    List (M3e.Cem.Attr.Attr { end : M3e.Value.Supported
    , endMode : M3e.Value.Supported
    , endDivider : M3e.Value.Supported
    , start : M3e.Value.Supported
    , startMode : M3e.Value.Supported
    , startDivider : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | drawerContainer : M3e.Value.Supported } msg
drawerContainer =
    M3e.DrawerContainer.view


{-| Convenience binding for the `M3e.Divider` element: `view` re-exposed from `M3e.Divider`. Import that module directly for the strict, component-scoped types. -}
divider :
    List (M3e.Cem.Attr.Attr { inset : M3e.Value.Supported
    , insetStart : M3e.Value.Supported
    , insetEnd : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | divider : M3e.Value.Supported } msg
divider =
    M3e.Divider.view


{-| Convenience binding for the `M3e.DialogTrigger` element: `view` re-exposed from `M3e.DialogTrigger`. Import that module directly for the strict, component-scoped types. -}
dialogTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | dialogTrigger : M3e.Value.Supported } msg
dialogTrigger =
    M3e.DialogTrigger.view


{-| Convenience binding for the `M3e.Dialog` element: `view` re-exposed from `M3e.Dialog`. Import that module directly for the strict, component-scoped types. -}
dialog :
    List (M3e.Cem.Attr.Attr { alert : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , disableClose : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , noFocusTrap : M3e.Value.Supported
    , open : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onCancel : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | dialog : M3e.Value.Supported } msg
dialog =
    M3e.Dialog.view


{-| Convenience binding for the `M3e.DialogAction` element: `view` re-exposed from `M3e.DialogAction`. Import that module directly for the strict, component-scoped types. -}
dialogAction :
    List (M3e.Cem.Attr.Attr { returnValue : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | dialogAction : M3e.Value.Supported } msg
dialogAction =
    M3e.DialogAction.view


{-| Convenience binding for the `M3e.DatepickerToggle` element: `view` re-exposed from `M3e.DatepickerToggle`. Import that module directly for the strict, component-scoped types. -}
datepickerToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | datepickerToggle : M3e.Value.Supported } msg
datepickerToggle =
    M3e.DatepickerToggle.view


{-| Convenience binding for the `M3e.Datepicker` element: `view` re-exposed from `M3e.Datepicker`. Import that module directly for the strict, component-scoped types. -}
datepicker :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , clearable : M3e.Value.Supported
    , date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , range : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , confirmLabel : M3e.Value.Supported
    , dismissLabel : M3e.Value.Supported
    , label : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | datepicker : M3e.Value.Supported } msg
datepicker =
    M3e.Datepicker.view


{-| Convenience binding for the `M3e.ContentPane` element: `view` re-exposed from `M3e.ContentPane`. Import that module directly for the strict, component-scoped types. -}
contentPane :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | contentPane : M3e.Value.Supported } msg
contentPane =
    M3e.ContentPane.view


{-| Convenience binding for the `M3e.SuggestionChip` element: `view` re-exposed from `M3e.SuggestionChip`. Import that module directly for the strict, component-scoped types. -}
suggestionChip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | suggestionChip : M3e.Value.Supported } msg
suggestionChip =
    M3e.SuggestionChip.view


{-| Convenience binding for the `M3e.InputChipSet` element: `view` re-exposed from `M3e.InputChipSet`. Import that module directly for the strict, component-scoped types. -}
inputChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , input : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChipSet : M3e.Value.Supported } msg
inputChipSet =
    M3e.InputChipSet.view


{-| Convenience binding for the `M3e.InputChip` element: `view` re-exposed from `M3e.InputChip`. Import that module directly for the strict, component-scoped types. -}
inputChip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , removable : M3e.Value.Supported
    , removeLabel : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onRemove : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , removeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Value.Supported } msg
inputChip =
    M3e.InputChip.view


{-| Convenience binding for the `M3e.FilterChipSet` element: `view` re-exposed from `M3e.FilterChipSet`. Import that module directly for the strict, component-scoped types. -}
filterChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | filterChipSet : M3e.Value.Supported } msg
filterChipSet =
    M3e.FilterChipSet.view


{-| Convenience binding for the `M3e.FilterChip` element: `view` re-exposed from `M3e.FilterChip`. Import that module directly for the strict, component-scoped types. -}
filterChip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | filterChip : M3e.Value.Supported } msg
filterChip =
    M3e.FilterChip.view


{-| Convenience binding for the `M3e.ChipSet` element: `view` re-exposed from `M3e.ChipSet`. Import that module directly for the strict, component-scoped types. -}
chipSet :
    List (M3e.Cem.Attr.Attr { vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | chipSet : M3e.Value.Supported } msg
chipSet =
    M3e.ChipSet.view


{-| Convenience binding for the `M3e.AssistChip` element: `view` re-exposed from `M3e.AssistChip`. Import that module directly for the strict, component-scoped types. -}
assistChip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | assistChip : M3e.Value.Supported } msg
assistChip =
    M3e.AssistChip.view


{-| Convenience binding for the `M3e.Chip` element: `view` re-exposed from `M3e.Chip`. Import that module directly for the strict, component-scoped types. -}
chip :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | chip : M3e.Value.Supported } msg
chip =
    M3e.Chip.view


{-| Convenience binding for the `M3e.Checkbox` element: `view` re-exposed from `M3e.Checkbox`. Import that module directly for the strict, component-scoped types. -}
checkbox :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onInvalid : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | checkbox : M3e.Value.Supported } msg
checkbox =
    M3e.Checkbox.view


{-| Convenience binding for the `M3e.Card` element: `view` re-exposed from `M3e.Card`. Import that module directly for the strict, component-scoped types. -}
card :
    List (M3e.Cem.Attr.Attr { actionable : M3e.Value.Supported
    , inline : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    , content : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , footer : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | card : M3e.Value.Supported } msg
card =
    M3e.Card.view


{-| Convenience binding for the `M3e.Calendar` element: `view` re-exposed from `M3e.Calendar`. Import that module directly for the strict, component-scoped types. -}
calendar :
    List (M3e.Cem.Attr.Attr { date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { header : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | calendar : M3e.Value.Supported } msg
calendar =
    M3e.Calendar.view


{-| Convenience binding for the `M3e.YearView` element: `view` re-exposed from `M3e.YearView`. Import that module directly for the strict, component-scoped types. -}
yearView :
    List (M3e.Cem.Attr.Attr { active : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | yearView : M3e.Value.Supported } msg
yearView =
    M3e.YearView.view


{-| Convenience binding for the `M3e.MultiYearView` element: `view` re-exposed from `M3e.MultiYearView`. Import that module directly for the strict, component-scoped types. -}
multiYearView :
    List (M3e.Cem.Attr.Attr { active : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | multiYearView : M3e.Value.Supported } msg
multiYearView =
    M3e.MultiYearView.view


{-| Convenience binding for the `M3e.MonthView` element: `view` re-exposed from `M3e.MonthView`. Import that module directly for the strict, component-scoped types. -}
monthView :
    List (M3e.Cem.Attr.Attr { rangeStart : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , active : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | monthView : M3e.Value.Supported } msg
monthView =
    M3e.MonthView.view


{-| Convenience binding for the `M3e.Tooltip` element: `view` re-exposed from `M3e.Tooltip`. Import that module directly for the strict, component-scoped types. -}
tooltip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tooltip : M3e.Value.Supported } msg
tooltip =
    M3e.Tooltip.view


{-| Convenience binding for the `M3e.RichTooltip` element: `view` re-exposed from `M3e.RichTooltip`. Import that module directly for the strict, component-scoped types. -}
richTooltip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , subhead : M3e.Value.Supported
    , actions : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | richTooltip : M3e.Value.Supported } msg
richTooltip =
    M3e.RichTooltip.view


{-| Convenience binding for the `M3e.TooltipElementBase` element: `view` re-exposed from `M3e.TooltipElementBase`. Import that module directly for the strict, component-scoped types. -}
tooltipElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | tooltipElementBase : M3e.Value.Supported } msg
tooltipElementBase =
    M3e.TooltipElementBase.view


{-| Convenience binding for the `M3e.RichTooltipAction` element: `view` re-exposed from `M3e.RichTooltipAction`. Import that module directly for the strict, component-scoped types. -}
richTooltipAction :
    List (M3e.Cem.Attr.Attr { disableRestoreFocus : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Value.Supported } msg
richTooltipAction =
    M3e.RichTooltipAction.view


{-| Convenience binding for the `M3e.ButtonGroup` element: `view` re-exposed from `M3e.ButtonGroup`. Import that module directly for the strict, component-scoped types. -}
buttonGroup :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | buttonGroup : M3e.Value.Supported } msg
buttonGroup =
    M3e.ButtonGroup.view


{-| Convenience binding for the `M3e.IconButton` element: `view` re-exposed from `M3e.IconButton`. Import that module directly for the strict, component-scoped types. -}
iconButton :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , width : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , selected : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | iconButton : M3e.Value.Supported } msg
iconButton =
    M3e.IconButton.view


{-| Convenience binding for the `M3e.Button` element: `view` re-exposed from `M3e.Button`. Import that module directly for the strict, component-scoped types. -}
button :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | button : M3e.Value.Supported } msg
button =
    M3e.Button.view


{-| Convenience binding for the `M3e.Breadcrumb` element: `view` re-exposed from `M3e.Breadcrumb`. Import that module directly for the strict, component-scoped types. -}
breadcrumb :
    List (M3e.Cem.Attr.Attr { wrap : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , separator : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | breadcrumb : M3e.Value.Supported } msg
breadcrumb =
    M3e.Breadcrumb.view


{-| Convenience binding for the `M3e.BreadcrumbItem` element: `view` re-exposed from `M3e.BreadcrumbItem`. Import that module directly for the strict, component-scoped types. -}
breadcrumbItem :
    List (M3e.Cem.Attr.Attr { itemLabel : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , current : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , download : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | breadcrumbItem : M3e.Value.Supported } msg
breadcrumbItem =
    M3e.BreadcrumbItem.view


{-| Convenience binding for the `M3e.BreadcrumbItemButton` element: `view` re-exposed from `M3e.BreadcrumbItemButton`. Import that module directly for the strict, component-scoped types. -}
breadcrumbItemButton :
    List (M3e.Cem.Attr.Attr { current : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , default : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s
        | breadcrumbItemButton : M3e.Value.Supported
    } msg
breadcrumbItemButton =
    M3e.BreadcrumbItemButton.view


{-| Convenience binding for the `M3e.BottomSheetTrigger` element: `view` re-exposed from `M3e.BottomSheetTrigger`. Import that module directly for the strict, component-scoped types. -}
bottomSheetTrigger :
    List (M3e.Cem.Attr.Attr { detent : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetTrigger : M3e.Value.Supported } msg
bottomSheetTrigger =
    M3e.BottomSheetTrigger.view


{-| Convenience binding for the `M3e.BottomSheet` element: `view` re-exposed from `M3e.BottomSheet`. Import that module directly for the strict, component-scoped types. -}
bottomSheet :
    List (M3e.Cem.Attr.Attr { detent : M3e.Value.Supported
    , handle : M3e.Value.Supported
    , handleLabel : M3e.Value.Supported
    , hideable : M3e.Value.Supported
    , hideFriction : M3e.Value.Supported
    , modal : M3e.Value.Supported
    , open : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onCancel : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | bottomSheet : M3e.Value.Supported } msg
bottomSheet =
    M3e.BottomSheet.view


{-| Convenience binding for the `M3e.BottomSheetAction` element: `view` re-exposed from `M3e.BottomSheetAction`. Import that module directly for the strict, component-scoped types. -}
bottomSheetAction :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetAction : M3e.Value.Supported } msg
bottomSheetAction =
    M3e.BottomSheetAction.view


{-| Convenience binding for the `M3e.Badge` element: `view` re-exposed from `M3e.Badge`. Import that module directly for the strict, component-scoped types. -}
badge :
    List (M3e.Cem.Attr.Attr { size : M3e.Value.Supported
    , position : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | badge : M3e.Value.Supported } msg
badge =
    M3e.Badge.view


{-| Convenience binding for the `M3e.Avatar` element: `view` re-exposed from `M3e.Avatar`. Import that module directly for the strict, component-scoped types. -}
avatar :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | avatar : M3e.Value.Supported } msg
avatar =
    M3e.Avatar.view


{-| Convenience binding for the `M3e.Autocomplete` element: `view` re-exposed from `M3e.Autocomplete`. Import that module directly for the strict, component-scoped types. -}
autocomplete :
    List (M3e.Cem.Attr.Attr { autoActivate : M3e.Value.Supported
    , caseSensitive : M3e.Value.Supported
    , filter : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , hideLoading : M3e.Value.Supported
    , hideNoData : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , loadingLabel : M3e.Value.Supported
    , noDataLabel : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , for : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onQuery : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | autocomplete : M3e.Value.Supported } msg
autocomplete =
    M3e.Autocomplete.view


{-| Convenience binding for the `M3e.FormField` element: `view` re-exposed from `M3e.FormField`. Import that module directly for the strict, component-scoped types. -}
formField :
    List (M3e.Cem.Attr.Attr { floatLabel : M3e.Value.Supported
    , hideRequiredMarker : M3e.Value.Supported
    , hideSubscript : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , prefix : M3e.Value.Supported
    , prefixText : M3e.Value.Supported
    , label : M3e.Value.Supported
    , suffix : M3e.Value.Supported
    , suffixText : M3e.Value.Supported
    , hint : M3e.Value.Supported
    , error : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | formField : M3e.Value.Supported } msg
formField =
    M3e.FormField.view


{-| Convenience binding for the `M3e.OptionPanel` element: `view` re-exposed from `M3e.OptionPanel`. Import that module directly for the strict, component-scoped types. -}
optionPanel :
    List (M3e.Cem.Attr.Attr { state : M3e.Value.Supported
    , scrollStrategy : M3e.Value.Supported
    , fitAnchorWidth : M3e.Value.Supported
    , anchorOffset : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , noData : M3e.Value.Supported
    , loading : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | optionPanel : M3e.Value.Supported } msg
optionPanel =
    M3e.OptionPanel.view


{-| Convenience binding for the `M3e.FloatingPanel` element: `view` re-exposed from `M3e.FloatingPanel`. Import that module directly for the strict, component-scoped types. -}
floatingPanel :
    List (M3e.Cem.Attr.Attr { scrollStrategy : M3e.Value.Supported
    , fitAnchorWidth : M3e.Value.Supported
    , anchorOffset : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | floatingPanel : M3e.Value.Supported } msg
floatingPanel =
    M3e.FloatingPanel.view


{-| Convenience binding for the `M3e.Optgroup` element: `view` re-exposed from `M3e.Optgroup`. Import that module directly for the strict, component-scoped types. -}
optgroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | optgroup : M3e.Value.Supported } msg
optgroup =
    M3e.Optgroup.view


{-| Convenience binding for the `M3e.Option` element: `view` re-exposed from `M3e.Option`. Import that module directly for the strict, component-scoped types. -}
option :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHighlight : M3e.Value.Supported
    , highlightMode : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , term : M3e.Value.Supported
    , value : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | option : M3e.Value.Supported } msg
option =
    M3e.Option.view


{-| Convenience binding for the `M3e.FocusTrap` element: `view` re-exposed from `M3e.FocusTrap`. Import that module directly for the strict, component-scoped types. -}
focusTrap :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | focusTrap : M3e.Value.Supported } msg
focusTrap =
    M3e.FocusTrap.view


{-| Convenience binding for the `M3e.AppBar` element: `view` re-exposed from `M3e.AppBar`. Import that module directly for the strict, component-scoped types. -}
appBar :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , for : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , title : M3e.Value.Supported
    , subtitle : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    , leadingIcon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | appBar : M3e.Value.Supported } msg
appBar =
    M3e.AppBar.view


{-| Convenience binding for the `M3e.TextOverflow` element: `view` re-exposed from `M3e.TextOverflow`. Import that module directly for the strict, component-scoped types. -}
textOverflow :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | textOverflow : M3e.Value.Supported } msg
textOverflow =
    M3e.TextOverflow.view


{-| Convenience binding for the `M3e.TextHighlight` element: `view` re-exposed from `M3e.TextHighlight`. Import that module directly for the strict, component-scoped types. -}
textHighlight :
    List (M3e.Cem.Attr.Attr { caseSensitive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , term : M3e.Value.Supported
    , onHighlight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | textHighlight : M3e.Value.Supported } msg
textHighlight =
    M3e.TextHighlight.view


{-| Convenience binding for the `M3e.StateLayer` element: `view` re-exposed from `M3e.StateLayer`. Import that module directly for the strict, component-scoped types. -}
stateLayer :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHover : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | stateLayer : M3e.Value.Supported } msg
stateLayer =
    M3e.StateLayer.view


{-| Convenience binding for the `M3e.Slide` element: `view` re-exposed from `M3e.Slide`. Import that module directly for the strict, component-scoped types. -}
slide :
    List (M3e.Cem.Attr.Attr { selectedIndex : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | slide : M3e.Value.Supported } msg
slide =
    M3e.Slide.view


{-| Convenience binding for the `M3e.ScrollContainer` element: `view` re-exposed from `M3e.ScrollContainer`. Import that module directly for the strict, component-scoped types. -}
scrollContainer :
    List (M3e.Cem.Attr.Attr { dividers : M3e.Value.Supported
    , thin : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | scrollContainer : M3e.Value.Supported } msg
scrollContainer =
    M3e.ScrollContainer.view


{-| Convenience binding for the `M3e.Ripple` element: `view` re-exposed from `M3e.Ripple`. Import that module directly for the strict, component-scoped types. -}
ripple :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , radius : M3e.Value.Supported
    , unbounded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | ripple : M3e.Value.Supported } msg
ripple =
    M3e.Ripple.view


{-| Convenience binding for the `M3e.PseudoRadio` element: `view` re-exposed from `M3e.PseudoRadio`. Import that module directly for the strict, component-scoped types. -}
pseudoRadio :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | pseudoRadio : M3e.Value.Supported } msg
pseudoRadio =
    M3e.PseudoRadio.view


{-| Convenience binding for the `M3e.PseudoCheckbox` element: `view` re-exposed from `M3e.PseudoCheckbox`. Import that module directly for the strict, component-scoped types. -}
pseudoCheckbox :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | pseudoCheckbox : M3e.Value.Supported } msg
pseudoCheckbox =
    M3e.PseudoCheckbox.view


{-| Convenience binding for the `M3e.FocusRing` element: `view` re-exposed from `M3e.FocusRing`. Import that module directly for the strict, component-scoped types. -}
focusRing :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , inward : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | focusRing : M3e.Value.Supported } msg
focusRing =
    M3e.FocusRing.view


{-| Convenience binding for the `M3e.Elevation` element: `view` re-exposed from `M3e.Elevation`. Import that module directly for the strict, component-scoped types. -}
elevation :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , level : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | elevation : M3e.Value.Supported } msg
elevation =
    M3e.Elevation.view


{-| Convenience binding for the `M3e.Collapsible` element: `view` re-exposed from `M3e.Collapsible`. Import that module directly for the strict, component-scoped types. -}
collapsible :
    List (M3e.Cem.Attr.Attr { open : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , noAnimate : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | collapsible : M3e.Value.Supported } msg
collapsible =
    M3e.Collapsible.view


{-| Convenience binding for the `M3e.ActionElementBase` element: `view` re-exposed from `M3e.ActionElementBase`. Import that module directly for the strict, component-scoped types. -}
actionElementBase :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | actionElementBase : M3e.Value.Supported } msg
actionElementBase =
    M3e.ActionElementBase.view


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> M3e.Cem.Attr.Attr { c | action : M3e.Value.Supported } msg
action =
    M3e.Cem.Vocab.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool -> M3e.Cem.Attr.Attr { c | actionable : M3e.Value.Supported } msg
actionable =
    M3e.Cem.Vocab.actionable


{-| Whether the view is active. (default: `false`) -}
active : Bool -> M3e.Cem.Attr.Attr { c | active : M3e.Value.Supported } msg
active =
    M3e.Cem.Vocab.active


{-| The active date. (default: `new Date()`) -}
activeDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
activeDate =
    M3e.Cem.Vocab.activeDate


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> M3e.Cem.Attr.Attr { c | alert : M3e.Value.Supported } msg
alert =
    M3e.Cem.Vocab.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float -> M3e.Cem.Attr.Attr { c | anchorOffset : M3e.Value.Supported } msg
anchorOffset =
    M3e.Cem.Vocab.anchorOffset


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animation =
    M3e.Cem.Vocab.animation


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String -> M3e.Cem.Attr.Attr { c | ariaInvalid : M3e.Value.Supported } msg
ariaInvalid =
    M3e.Cem.Vocab.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool -> M3e.Cem.Attr.Attr { c | autoActivate : M3e.Value.Supported } msg
autoActivate =
    M3e.Cem.Vocab.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue :
    Float -> M3e.Cem.Attr.Attr { c | bufferValue : M3e.Value.Supported } msg
bufferValue =
    M3e.Cem.Vocab.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> M3e.Cem.Attr.Attr { c | cascade : M3e.Value.Supported } msg
cascade =
    M3e.Cem.Vocab.cascade


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.Vocab.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.Vocab.centered


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Vocab.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.Vocab.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
clearable =
    M3e.Cem.Vocab.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Vocab.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.Vocab.color


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool -> M3e.Cem.Attr.Attr { c | completed : M3e.Value.Supported } msg
completed =
    M3e.Cem.Vocab.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel :
    String -> M3e.Cem.Attr.Attr { c | confirmLabel : M3e.Value.Supported } msg
confirmLabel =
    M3e.Cem.Vocab.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool -> M3e.Cem.Attr.Attr { c | contained : M3e.Value.Supported } msg
contained =
    M3e.Cem.Vocab.contained


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrast =
    M3e.Cem.Vocab.contrast


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
current =
    M3e.Cem.Vocab.current


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Vocab.date


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> M3e.Cem.Attr.Attr { c | density : M3e.Value.Supported } msg
density =
    M3e.Cem.Vocab.density


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
detent =
    M3e.Cem.Vocab.detent


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool -> M3e.Cem.Attr.Attr { c | disableClose : M3e.Value.Supported } msg
disableClose =
    M3e.Cem.Vocab.disableClose


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool -> M3e.Cem.Attr.Attr { c | disableHighlight : M3e.Value.Supported } msg
disableHighlight =
    M3e.Cem.Vocab.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover :
    Bool -> M3e.Cem.Attr.Attr { c | disableHover : M3e.Value.Supported } msg
disableHover =
    M3e.Cem.Vocab.disableHover


{-| Whether scroll buttons are disabled. -}
disablePagination :
    String
    -> M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePagination =
    M3e.Cem.Vocab.disablePagination


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus :
    Bool
    -> M3e.Cem.Attr.Attr { c | disableRestoreFocus : M3e.Value.Supported } msg
disableRestoreFocus =
    M3e.Cem.Vocab.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Vocab.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Vocab.disabledInteractive


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> M3e.Cem.Attr.Attr { c | discrete : M3e.Value.Supported } msg
discrete =
    M3e.Cem.Vocab.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel :
    String -> M3e.Cem.Attr.Attr { c | dismissLabel : M3e.Value.Supported } msg
dismissLabel =
    M3e.Cem.Vocab.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Vocab.dismissible


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividers =
    M3e.Cem.Vocab.dividers


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Vocab.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> M3e.Cem.Attr.Attr { c | duration : M3e.Value.Supported } msg
duration =
    M3e.Cem.Vocab.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> M3e.Cem.Attr.Attr { c | editable : M3e.Value.Supported } msg
editable =
    M3e.Cem.Vocab.editable


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
elevated =
    M3e.Cem.Vocab.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool -> M3e.Cem.Attr.Attr { c | emphasized : M3e.Value.Supported } msg
emphasized =
    M3e.Cem.Vocab.emphasized


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> M3e.Cem.Attr.Attr { c | end : M3e.Value.Supported } msg
end =
    M3e.Cem.Vocab.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider :
    Bool -> M3e.Cem.Attr.Attr { c | endDivider : M3e.Value.Supported } msg
endDivider =
    M3e.Cem.Vocab.endDivider


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endMode =
    M3e.Cem.Vocab.endMode


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> M3e.Cem.Attr.Attr { c | extended : M3e.Value.Supported } msg
extended =
    M3e.Cem.Vocab.extended


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> M3e.Cem.Attr.Attr { c | filled : M3e.Value.Supported } msg
filled =
    M3e.Cem.Vocab.filled


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filter =
    M3e.Cem.Vocab.filter


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel :
    String -> M3e.Cem.Attr.Attr { c | firstPageLabel : M3e.Value.Supported } msg
firstPageLabel =
    M3e.Cem.Vocab.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool -> M3e.Cem.Attr.Attr { c | fitAnchorWidth : M3e.Value.Supported } msg
fitAnchorWidth =
    M3e.Cem.Vocab.fitAnchorWidth


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabel =
    M3e.Cem.Vocab.floatLabel


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Vocab.for


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
grade =
    M3e.Cem.Vocab.grade


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Cem.Attr.Attr { c | handle : M3e.Value.Supported } msg
handle =
    M3e.Cem.Vocab.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel :
    String -> M3e.Cem.Attr.Attr { c | handleLabel : M3e.Value.Supported } msg
handleLabel =
    M3e.Cem.Vocab.handleLabel


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , above : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPosition =
    M3e.Cem.Vocab.headerPosition


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Vocab.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction :
    Float -> M3e.Cem.Attr.Attr { c | hideFriction : M3e.Value.Supported } msg
hideFriction =
    M3e.Cem.Vocab.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool -> M3e.Cem.Attr.Attr { c | hideLoading : M3e.Value.Supported } msg
hideLoading =
    M3e.Cem.Vocab.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool -> M3e.Cem.Attr.Attr { c | hideNoData : M3e.Value.Supported } msg
hideNoData =
    M3e.Cem.Vocab.hideNoData


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize :
    Bool -> M3e.Cem.Attr.Attr { c | hidePageSize : M3e.Value.Supported } msg
hidePageSize =
    M3e.Cem.Vocab.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> M3e.Cem.Attr.Attr { c | hideRequiredMarker : M3e.Value.Supported } msg
hideRequiredMarker =
    M3e.Cem.Vocab.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool -> M3e.Cem.Attr.Attr { c | hideSearchIcon : M3e.Value.Supported } msg
hideSearchIcon =
    M3e.Cem.Vocab.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Vocab.hideSelectionIndicator


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscript =
    M3e.Cem.Vocab.hideSubscript


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.Vocab.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> M3e.Cem.Attr.Attr { c | hideable : M3e.Value.Supported } msg
hideable =
    M3e.Cem.Vocab.hideable


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightMode =
    M3e.Cem.Vocab.highlightMode


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Vocab.href


{-| The icons to present. (default: `"none"`) -}
icons :
    M3e.Value.Value { both : M3e.Value.Supported
    , none : M3e.Value.Supported
    , selected : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
icons =
    M3e.Cem.Vocab.icons


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.Vocab.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> M3e.Cem.Attr.Attr { c | inline : M3e.Value.Supported } msg
inline =
    M3e.Cem.Vocab.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> M3e.Cem.Attr.Attr { c | inset : M3e.Value.Supported } msg
inset =
    M3e.Cem.Vocab.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> M3e.Cem.Attr.Attr { c | insetEnd : M3e.Value.Supported } msg
insetEnd =
    M3e.Cem.Vocab.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool -> M3e.Cem.Attr.Attr { c | insetStart : M3e.Value.Supported } msg
insetStart =
    M3e.Cem.Vocab.insetStart


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> M3e.Cem.Attr.Attr { c | invalid : M3e.Value.Supported } msg
invalid =
    M3e.Cem.Vocab.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> M3e.Cem.Attr.Attr { c | inward : M3e.Value.Supported } msg
inward =
    M3e.Cem.Vocab.inward


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel :
    String -> M3e.Cem.Attr.Attr { c | itemLabel : M3e.Value.Supported } msg
itemLabel =
    M3e.Cem.Vocab.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | itemsPerPageLabel : M3e.Value.Supported } msg
itemsPerPageLabel =
    M3e.Cem.Vocab.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
label =
    M3e.Cem.Vocab.label


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPosition =
    M3e.Cem.Vocab.labelPosition


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> M3e.Cem.Attr.Attr { c | labelled : M3e.Value.Supported } msg
labelled =
    M3e.Cem.Vocab.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel :
    String -> M3e.Cem.Attr.Attr { c | lastPageLabel : M3e.Value.Supported } msg
lastPageLabel =
    M3e.Cem.Vocab.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> M3e.Cem.Attr.Attr { c | length : M3e.Value.Supported } msg
length =
    M3e.Cem.Vocab.length


{-| The accessibility level of the heading. -}
level : String -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Vocab.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> M3e.Cem.Attr.Attr { c | linear : M3e.Value.Supported } msg
linear =
    M3e.Cem.Vocab.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
loaded =
    M3e.Cem.Vocab.loaded


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> M3e.Cem.Attr.Attr { c | loading : M3e.Value.Supported } msg
loading =
    M3e.Cem.Vocab.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String -> M3e.Cem.Attr.Attr { c | loadingLabel : M3e.Value.Supported } msg
loadingLabel =
    M3e.Cem.Vocab.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> M3e.Cem.Attr.Attr { c | lowered : M3e.Value.Supported } msg
lowered =
    M3e.Cem.Vocab.lowered


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Vocab.max


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Vocab.maxDate


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
maxDepth =
    M3e.Cem.Vocab.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
maxRows =
    M3e.Cem.Vocab.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
min =
    M3e.Cem.Vocab.min


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Vocab.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
minRows =
    M3e.Cem.Vocab.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> M3e.Cem.Attr.Attr { c | modal : M3e.Value.Supported } msg
modal =
    M3e.Cem.Vocab.modal


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
mode =
    M3e.Cem.Vocab.mode


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motion =
    M3e.Cem.Vocab.motion


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Vocab.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
nextMonthLabel =
    M3e.Cem.Vocab.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
nextMultiYearLabel =
    M3e.Cem.Vocab.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Vocab.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
nextYearLabel =
    M3e.Cem.Vocab.nextYearLabel


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool -> M3e.Cem.Attr.Attr { c | noAnimate : M3e.Value.Supported } msg
noAnimate =
    M3e.Cem.Vocab.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String -> M3e.Cem.Attr.Attr { c | noDataLabel : M3e.Value.Supported } msg
noDataLabel =
    M3e.Cem.Vocab.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool -> M3e.Cem.Attr.Attr { c | noFocusTrap : M3e.Value.Supported } msg
noFocusTrap =
    M3e.Cem.Vocab.noFocusTrap


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Vocab.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float -> M3e.Cem.Attr.Attr { c | opticalSize : M3e.Value.Supported } msg
opticalSize =
    M3e.Cem.Vocab.opticalSize


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> M3e.Cem.Attr.Attr { c | optional : M3e.Value.Supported } msg
optional =
    M3e.Cem.Vocab.optional


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.Vocab.orientation


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.Vocab.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex :
    Float -> M3e.Cem.Attr.Attr { c | pageIndex : M3e.Value.Supported } msg
pageIndex =
    M3e.Cem.Vocab.pageIndex


{-| The number of items to display in a page. (default: `50`) -}
pageSize :
    M3e.Value.Value { number : M3e.Value.Supported, all : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | pageSize : M3e.Value.Supported } msg
pageSize =
    M3e.Cem.Vocab.pageSize


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariant =
    M3e.Cem.Vocab.pageSizeVariant


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes :
    String -> M3e.Cem.Attr.Attr { c | pageSizes : M3e.Value.Supported } msg
pageSizes =
    M3e.Cem.Vocab.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
panelClass =
    M3e.Cem.Vocab.panelClass


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
position =
    M3e.Cem.Vocab.position


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionX =
    M3e.Cem.Vocab.positionX


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionY =
    M3e.Cem.Vocab.positionY


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
previousMonthLabel =
    M3e.Cem.Vocab.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
previousMultiYearLabel =
    M3e.Cem.Vocab.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Vocab.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
previousYearLabel =
    M3e.Cem.Vocab.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> M3e.Cem.Attr.Attr { c | radius : M3e.Value.Supported } msg
radius =
    M3e.Cem.Vocab.radius


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> M3e.Cem.Attr.Attr { c | range : M3e.Value.Supported } msg
range =
    M3e.Cem.Vocab.range


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Vocab.rangeEnd


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Vocab.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Vocab.rel


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool -> M3e.Cem.Attr.Attr { c | removable : M3e.Value.Supported } msg
removable =
    M3e.Cem.Vocab.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String -> M3e.Cem.Attr.Attr { c | removeLabel : M3e.Value.Supported } msg
removeLabel =
    M3e.Cem.Vocab.removeLabel


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Vocab.required


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
returnValue =
    M3e.Cem.Vocab.returnValue


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme =
    M3e.Cem.Vocab.scheme


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategy =
    M3e.Cem.Vocab.scrollStrategy


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary :
    Bool -> M3e.Cem.Attr.Attr { c | secondary : M3e.Value.Supported } msg
secondary =
    M3e.Cem.Vocab.secondary


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Vocab.selected


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float -> M3e.Cem.Attr.Attr { c | selectedIndex : M3e.Value.Supported } msg
selectedIndex =
    M3e.Cem.Vocab.selectedIndex


{-| The shape of the toolbar. (default: `"square"`) -}
shapeAttr :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shapeAttr =
    M3e.Cem.Vocab.shape


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Vocab.showDelay


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons :
    Bool
    -> M3e.Cem.Attr.Attr { c | showFirstLastButtons : M3e.Value.Supported } msg
showFirstLastButtons =
    M3e.Cem.Vocab.showFirstLastButtons


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Vocab.size


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> M3e.Cem.Attr.Attr { c | start : M3e.Value.Supported } msg
start =
    M3e.Cem.Vocab.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
startAt =
    M3e.Cem.Vocab.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider :
    Bool -> M3e.Cem.Attr.Attr { c | startDivider : M3e.Value.Supported } msg
startDivider =
    M3e.Cem.Vocab.startDivider


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startMode =
    M3e.Cem.Vocab.startMode


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startView =
    M3e.Cem.Vocab.startView


{-| The state for which to present content. (default: `"content"`) -}
state :
    M3e.Value.Value { content : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
state =
    M3e.Cem.Vocab.state


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
stepAttr : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
stepAttr =
    M3e.Cem.Vocab.step


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> M3e.Cem.Attr.Attr { c | stretch : M3e.Value.Supported } msg
stretch =
    M3e.Cem.Vocab.stretch


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool -> M3e.Cem.Attr.Attr { c | strongFocus : M3e.Value.Supported } msg
strongFocus =
    M3e.Cem.Vocab.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
submenu =
    M3e.Cem.Vocab.submenu


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Vocab.target


{-| The search term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.Vocab.term


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> M3e.Cem.Attr.Attr { c | thin : M3e.Value.Supported } msg
thin =
    M3e.Cem.Vocab.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float -> M3e.Cem.Attr.Attr { c | threshold : M3e.Value.Supported } msg
threshold =
    M3e.Cem.Vocab.threshold


{-| Today's date. (default: `new Date()`) -}
today : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
today =
    M3e.Cem.Vocab.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
toggle =
    M3e.Cem.Vocab.toggle


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection =
    M3e.Cem.Vocab.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition =
    M3e.Cem.Vocab.togglePosition


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures =
    M3e.Cem.Vocab.touchGestures


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.Vocab.type_


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool -> M3e.Cem.Attr.Attr { c | unbounded : M3e.Value.Supported } msg
unbounded =
    M3e.Cem.Vocab.unbounded


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
variant =
    M3e.Cem.Vocab.variant


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Vocab.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
weight =
    M3e.Cem.Vocab.weight


{-| The width of the button. (default: `"default"`) -}
width :
    M3e.Value.Value { default : M3e.Value.Supported
    , narrow : M3e.Value.Supported
    , wide : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
width =
    M3e.Cem.Vocab.width


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
wrap =
    M3e.Cem.Vocab.wrap


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool -> M3e.Cem.Attr.Attr { c | wrapDetents : M3e.Value.Supported } msg
wrapDetents =
    M3e.Cem.Vocab.wrapDetents


{-| Listen for `change` events. -}
onChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Vocab.onChange


{-| Listen for `opening` events. -}
onOpening :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.Vocab.onOpening


{-| Listen for `opened` events. -}
onOpened :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.Vocab.onOpened


{-| Listen for `closing` events. -}
onClosing :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.Vocab.onClosing


{-| Listen for `closed` events. -}
onClosed :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.Vocab.onClosed


{-| Listen for `click` events. -}
onClick :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Vocab.onClick


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Vocab.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Vocab.onInput


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.Vocab.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Vocab.onToggle


{-| Listen for `value-change` events. -}
onValueChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onValueChange : M3e.Value.Supported } msg
onValueChange =
    M3e.Cem.Vocab.onValueChange


{-| Listen for `query` events. -}
onQuery :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery =
    M3e.Cem.Vocab.onQuery


{-| Listen for `clear` events. -}
onClear :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear =
    M3e.Cem.Vocab.onClear


{-| Listen for `page` events. -}
onPage :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onPage : M3e.Value.Supported } msg
onPage =
    M3e.Cem.Vocab.onPage


{-| Listen for `cancel` events. -}
onCancel :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel =
    M3e.Cem.Vocab.onCancel


{-| Listen for `remove` events. -}
onRemove :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onRemove : M3e.Value.Supported } msg
onRemove =
    M3e.Cem.Vocab.onRemove


{-| Listen for `invalid` events. -}
onInvalid :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onInvalid : M3e.Value.Supported } msg
onInvalid =
    M3e.Cem.Vocab.onInvalid


{-| Listen for `active-change` events. -}
onActiveChange :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onActiveChange : M3e.Value.Supported } msg
onActiveChange =
    M3e.Cem.Vocab.onActiveChange


{-| Listen for `highlight` events. -}
onHighlight :
    Json.Decode.Decoder msg
    -> M3e.Cem.Attr.Attr { c | onHighlight : M3e.Value.Supported } msg
onHighlight =
    M3e.Cem.Vocab.onHighlight