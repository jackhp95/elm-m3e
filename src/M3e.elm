module M3e exposing
    ( tree, treeItem, toolbar, toc, tocItem, themeIcon
    , theme, textareaAutosize, tabs, tabPanel, tab, switch
    , stepperReset, stepperPrevious, stepperNext, step, stepPanel, stepper
    , splitPane, splitButton, snackbar, slider, sliderThumb, slideGroup
    , skeleton, shape, segmentedButton, buttonSegment, searchView, searchBar
    , radioGroup, radio, paginator, select, navRailToggle, navRail
    , navMenuItemGroup, navMenu, navMenuItem, navBar, navItem, menuItemRadio
    , menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger, loadingIndicator
    , selectionList, listOption, actionList, expandableListItem, listAction, listItemButton
    , list, listItem, icon, heading, fabMenuTrigger, fabMenuItem
    , fabMenu, fab, accordion, expansionPanel, expansionHeader, drawerToggle
    , drawerContainer, divider, dialogTrigger, dialog, dialogAction, datepickerToggle
    , datepicker, contentPane, suggestionChip, inputChipSet, inputChip, filterChipSet
    , filterChip, chipSet, assistChip, chip, checkbox, card
    , calendar, yearView, multiYearView, monthView, tooltip, richTooltip
    , richTooltipAction, buttonGroup, iconButton, button, breadcrumb, breadcrumbItem
    , breadcrumbItemButton, bottomSheetTrigger, bottomSheet, bottomSheetAction, badge, avatar
    , autocomplete, formField, optionPanel, floatingPanel, optgroup, option
    , focusTrap, appBar, textOverflow, textHighlight, stateLayer, slide
    , scrollContainer, ripple, pseudoRadio, pseudoCheckbox, focusRing, elevation
    , collapsible, attrAction, attrActionable, attrActive, attrActiveDate, attrAlert
    , attrAnchorOffset, ariaInvalid, attrAutoActivate, attrBufferValue, attrCascade, attrCaseSensitive
    , attrCentered, attrChecked, attrClearLabel, attrClearable, attrCloseLabel, attrColor
    , attrCompleted, attrConfirmLabel, attrContained, attrDate, attrDensity, attrDetent
    , attrDetents, attrDisableClose, attrDisableHighlight, attrDisableHover, attrDisableRestoreFocus, attrDisabled
    , attrDisabledInteractive, attrDiscrete, attrDismissLabel, attrDismissible, attrDownload, attrDuration
    , attrEditable, attrElevated, attrEmphasized, attrEnd, attrEndDivider, attrExtended
    , attrFilled, attrFirstPageLabel, attrFitAnchorWidth, attrFor, attrHandle, attrHandleLabel
    , attrHideDelay, attrHideFriction, attrHideLoading, attrHideNoData, attrHidePageSize, attrHideRequiredMarker
    , attrHideSearchIcon, attrHideSelectionIndicator, attrHideToggle, attrHideable, attrHref, attrIndeterminate
    , attrInline, attrInset, attrInsetEnd, attrInsetStart, attrInvalid, attrInward
    , attrItemLabel, attrItemsPerPageLabel, attrLabel, attrLabelled, attrLastPageLabel, attrLength
    , attrLevel, attrLinear, attrLoaded, attrLoading, attrLoadingLabel, attrLowered
    , attrTocIgnore, attrMax, attrMaxDate, attrMaxDepth, attrMaxRows, attrMin
    , attrMinDate, attrMinRows, attrModal, attrMulti, attrNextMonthLabel, attrNextMultiYearLabel
    , attrNextPageLabel, attrNextYearLabel, attrNoAnimate, attrNoDataLabel, attrNoFocusTrap, attrOpen
    , attrOpticalSize, attrOptional, attrOvershootLimit, attrPageIndex, attrPageSizes, attrPanelClass
    , attrPreviousMonthLabel, attrPreviousMultiYearLabel, attrPreviousPageLabel, attrPreviousYearLabel, attrRadius, attrRange
    , attrRangeEnd, attrRangeStart, attrRel, attrRemovable, attrRemoveLabel, attrRequired
    , attrReturnValue, attrSecondary, attrSelected, attrSelectedIndex, attrShowDelay, attrShowFirstLastButtons
    , attrStart, attrStartAt, attrStartDivider, attrStep, attrStretch, attrStrongFocus
    , attrSubmenu, attrTarget, attrTerm, attrThin, attrThreshold, attrToday
    , attrToggle, attrUnbounded, attrVertical, attrWeight, attrWrap, attrWrapDetents
    , attrName, attrValueFloat, attrValue, animationNone, animationPulse, animationWave
    , contrastHigh, contrastMedium, contrastStandard, currentDate, currentLocation, currentPage
    , currentStep, currentTime, currentTrue, disablePaginationTrue, disablePaginationFalse, disablePaginationAuto
    , dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endModeAuto, endModeOver
    , endModePush, endModeSide, filterContains, filterEndsWith, filterNone, filterStartsWith
    , floatLabelAlways, floatLabelAuto, gradeHigh, gradeLow, gradeMedium, headerPositionAfter
    , headerPositionBefore, headerPositionAbove, headerPositionBelow, hideSubscriptAlways, hideSubscriptAuto, hideSubscriptNever
    , highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth, iconsNone, iconsSelected
    , labelPositionBelow, labelPositionEnd, modeAuto, modeDocked, modeFullscreen, modeBuffer
    , modeDeterminate, modeIndeterminate, modeQuery, modeCompact, modeExpanded, modeContains
    , modeEndsWith, modeStartsWith, motionExpressive, motionStandard, orientationAuto, orientationHorizontal
    , orientationVertical, pageSizeAll, pageSizeVariantFilled, pageSizeVariantOutlined, positionAbove, positionAfter
    , positionBefore, positionBelow, positionAboveAfter, positionAboveBefore, positionBelowAfter, positionBelowBefore
    , positionXAfter, positionXBefore, positionYAbove, positionYBelow, schemeAuto, schemeDark
    , schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeRounded, shapeSquare, shapeAuto
    , shapeCircular, sizeExtraLarge, sizeExtraSmall, sizeLarge, sizeMedium, sizeSmall
    , startModeAuto, startModeOver, startModePush, startModeSide, startViewMonth, startViewMultiYear
    , startViewYear, stateContent, stateLoading, stateNoData, toggleDirectionHorizontal, toggleDirectionVertical
    , togglePositionAfter, togglePositionBefore, touchGesturesAuto, touchGesturesOff, touchGesturesOn, typeButton
    , typeReset, typeSubmit, variantStandard, variantVibrant, variantContent, variantExpressive
    , variantFidelity, variantFruitSalad, variantMonochrome, variantNeutral, variantRainbow, variantTonalSpot
    , variantPrimary, variantSecondary, variantElevated, variantFilled, variantOutlined, variantTonal
    , variantFlat, variantWavy, variantContained, variantUncontained, variantSegmented, variantRounded
    , variantSharp, variantDisplay, variantHeadline, variantLabel, variantTitle, variantTertiary
    , variantPrimaryContainer, variantSecondaryContainer, variantSurface, variantTertiaryContainer, variantAuto, variantDocked
    , variantModal, variantConnected, variantText, widthDefault, widthNarrow, widthWide
    , ariaLabel, ariaLabelledby, ariaDescribedby, ariaHidden, id, for
    , class, style, onChange, onOpening, onOpened, onClosing
    , onClosed, onClick, onBeforeinput, onInput, onBeforetoggle, onToggle
    , onValueChange, onQuery, onClear, onPage, onCancel, onRemove
    , onInvalid, onActiveChange, onHighlight, slotLeading, slotTitle, slotSubtitle
    , slotTrailing, slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData
    , slotHeader, slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions
    , slotFooter, slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText
    , slotToggleIcon, slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix
    , slotSuffixText, slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput
    , slotBadge, slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead
    , slotClearIcon, slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon
    , slotArrow, slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton
    , slotDoneIcon, slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon
    , treeItemSlotLabel, treeItemSlotIcon, treeItemSlotSelectedIcon, treeItemSlotToggleIcon, treeItemSlotOpenToggleIcon, tocSlotOverline
    , tocSlotTitle, tabsSlotPanel, tabsSlotNextIcon, tabsSlotPrevIcon, tabSlotIcon, stepSlotIcon
    , stepSlotDoneIcon, stepSlotEditIcon, stepSlotErrorIcon, stepSlotHint, stepSlotError, stepPanelSlotActions
    , stepperSlotStep, stepperSlotPanel, splitPaneSlotStart, splitPaneSlotEnd, splitButtonSlotLeadingButton, splitButtonSlotTrailingButton
    , snackbarSlotCloseIcon, slideGroupSlotNextIcon, slideGroupSlotPrevIcon, buttonSegmentSlotIcon, searchViewSlotInput, searchViewSlotOpenLeading
    , searchViewSlotOpenTrailing, searchViewSlotClosedLeading, searchViewSlotClosedTrailing, searchViewSlotSearchIcon, searchViewSlotCloseIcon, searchViewSlotClearIcon
    , searchBarSlotLeading, searchBarSlotInput, searchBarSlotTrailing, searchBarSlotClearIcon, paginatorSlotFirstPageIcon, paginatorSlotPreviousPageIcon
    , paginatorSlotNextPageIcon, paginatorSlotLastPageIcon, selectSlotArrow, selectSlotValue, navMenuItemGroupSlotLabel, navMenuItemSlotLabel
    , navMenuItemSlotIcon, navMenuItemSlotBadge, navMenuItemSlotSelectedIcon, navMenuItemSlotToggleIcon, navItemSlotIcon, navItemSlotSelectedIcon
    , menuItemRadioSlotIcon, menuItemRadioSlotTrailingIcon, menuItemCheckboxSlotIcon, menuItemCheckboxSlotTrailingIcon, menuItemSlotIcon, menuItemSlotTrailingIcon
    , listOptionSlotLeading, listOptionSlotOverline, listOptionSlotSupportingText, listOptionSlotTrailing, expandableListItemSlotLeading, expandableListItemSlotOverline
    , expandableListItemSlotSupportingText, expandableListItemSlotToggleIcon, expandableListItemSlotItems, listActionSlotLeading, listActionSlotOverline, listActionSlotSupportingText
    , listActionSlotTrailing, listItemButtonSlotLeading, listItemButtonSlotOverline, listItemButtonSlotSupportingText, listItemButtonSlotTrailing, listItemSlotLeading
    , listItemSlotOverline, listItemSlotSupportingText, listItemSlotTrailing, fabMenuItemSlotIcon, fabSlotLabel, fabSlotCloseIcon
    , expansionPanelSlotActions, expansionPanelSlotHeader, expansionPanelSlotToggleIcon, expansionHeaderSlotToggleIcon, drawerContainerSlotStart, drawerContainerSlotEnd
    , dialogSlotHeader, dialogSlotActions, dialogSlotCloseIcon, suggestionChipSlotIcon, inputChipSetSlotInput, inputChipSlotAvatar
    , inputChipSlotIcon, inputChipSlotRemoveIcon, filterChipSlotIcon, filterChipSlotTrailingIcon, assistChipSlotIcon, chipSlotIcon
    , chipSlotTrailingIcon, cardSlotHeader, cardSlotContent, cardSlotActions, cardSlotFooter, calendarSlotHeader
    , richTooltipSlotSubhead, richTooltipSlotActions, iconButtonSlotSelected, buttonSlotIcon, buttonSlotSelected, buttonSlotSelectedIcon
    , buttonSlotTrailingIcon, breadcrumbSlotSeparator, breadcrumbItemSlotIcon, breadcrumbItemButtonSlotIcon, bottomSheetSlotHeader, autocompleteSlotLoading
    , autocompleteSlotNoData, formFieldSlotDefault, formFieldSlotPrefix, formFieldSlotPrefixText, formFieldSlotLabel, formFieldSlotSuffix
    , formFieldSlotSuffixText, formFieldSlotHint, formFieldSlotError, optionPanelSlotNoData, optionPanelSlotLoading, optgroupSlotLabel
    , appBarSlotLeading, appBarSlotTitle, appBarSlotSubtitle, appBarSlotTrailing, appBarSlotLeadingIcon, appBarSlotTrailingIcon
    , slotDefault, child, children, control, linear, circular
    )

{-| The one-import barrel. Re-exposes every component constructor plus the whole shared attribute/event vocabulary, so `import M3e exposing (..)` gives you every constructor together with `disabled`/`variant`/`onClick`/… . Token values stay in `M3e.Token` (re-exposing hundreds here would bloat the namespace). Each constructor takes `[attributes] [content]`; reach for the per-component `M3e.<Component>` modules when you want the strict, component-scoped types.

@docs tree, treeItem, toolbar, toc, tocItem, themeIcon
@docs theme, textareaAutosize, tabs, tabPanel, tab, switch
@docs stepperReset, stepperPrevious, stepperNext, step, stepPanel, stepper
@docs splitPane, splitButton, snackbar, slider, sliderThumb, slideGroup
@docs skeleton, shape, segmentedButton, buttonSegment, searchView, searchBar
@docs radioGroup, radio, paginator, select, navRailToggle, navRail
@docs navMenuItemGroup, navMenu, navMenuItem, navBar, navItem, menuItemRadio
@docs menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger, loadingIndicator
@docs selectionList, listOption, actionList, expandableListItem, listAction, listItemButton
@docs list, listItem, icon, heading, fabMenuTrigger, fabMenuItem
@docs fabMenu, fab, accordion, expansionPanel, expansionHeader, drawerToggle
@docs drawerContainer, divider, dialogTrigger, dialog, dialogAction, datepickerToggle
@docs datepicker, contentPane, suggestionChip, inputChipSet, inputChip, filterChipSet
@docs filterChip, chipSet, assistChip, chip, checkbox, card
@docs calendar, yearView, multiYearView, monthView, tooltip, richTooltip
@docs richTooltipAction, buttonGroup, iconButton, button, breadcrumb, breadcrumbItem
@docs breadcrumbItemButton, bottomSheetTrigger, bottomSheet, bottomSheetAction, badge, avatar
@docs autocomplete, formField, optionPanel, floatingPanel, optgroup, option
@docs focusTrap, appBar, textOverflow, textHighlight, stateLayer, slide
@docs scrollContainer, ripple, pseudoRadio, pseudoCheckbox, focusRing, elevation
@docs collapsible, attrAction, attrActionable, attrActive, attrActiveDate, attrAlert
@docs attrAnchorOffset, ariaInvalid, attrAutoActivate, attrBufferValue, attrCascade, attrCaseSensitive
@docs attrCentered, attrChecked, attrClearLabel, attrClearable, attrCloseLabel, attrColor
@docs attrCompleted, attrConfirmLabel, attrContained, attrDate, attrDensity, attrDetent
@docs attrDetents, attrDisableClose, attrDisableHighlight, attrDisableHover, attrDisableRestoreFocus, attrDisabled
@docs attrDisabledInteractive, attrDiscrete, attrDismissLabel, attrDismissible, attrDownload, attrDuration
@docs attrEditable, attrElevated, attrEmphasized, attrEnd, attrEndDivider, attrExtended
@docs attrFilled, attrFirstPageLabel, attrFitAnchorWidth, attrFor, attrHandle, attrHandleLabel
@docs attrHideDelay, attrHideFriction, attrHideLoading, attrHideNoData, attrHidePageSize, attrHideRequiredMarker
@docs attrHideSearchIcon, attrHideSelectionIndicator, attrHideToggle, attrHideable, attrHref, attrIndeterminate
@docs attrInline, attrInset, attrInsetEnd, attrInsetStart, attrInvalid, attrInward
@docs attrItemLabel, attrItemsPerPageLabel, attrLabel, attrLabelled, attrLastPageLabel, attrLength
@docs attrLevel, attrLinear, attrLoaded, attrLoading, attrLoadingLabel, attrLowered
@docs attrTocIgnore, attrMax, attrMaxDate, attrMaxDepth, attrMaxRows, attrMin
@docs attrMinDate, attrMinRows, attrModal, attrMulti, attrNextMonthLabel, attrNextMultiYearLabel
@docs attrNextPageLabel, attrNextYearLabel, attrNoAnimate, attrNoDataLabel, attrNoFocusTrap, attrOpen
@docs attrOpticalSize, attrOptional, attrOvershootLimit, attrPageIndex, attrPageSizes, attrPanelClass
@docs attrPreviousMonthLabel, attrPreviousMultiYearLabel, attrPreviousPageLabel, attrPreviousYearLabel, attrRadius, attrRange
@docs attrRangeEnd, attrRangeStart, attrRel, attrRemovable, attrRemoveLabel, attrRequired
@docs attrReturnValue, attrSecondary, attrSelected, attrSelectedIndex, attrShowDelay, attrShowFirstLastButtons
@docs attrStart, attrStartAt, attrStartDivider, attrStep, attrStretch, attrStrongFocus
@docs attrSubmenu, attrTarget, attrTerm, attrThin, attrThreshold, attrToday
@docs attrToggle, attrUnbounded, attrVertical, attrWeight, attrWrap, attrWrapDetents
@docs attrName, attrValueFloat, attrValue, animationNone, animationPulse, animationWave
@docs contrastHigh, contrastMedium, contrastStandard, currentDate, currentLocation, currentPage
@docs currentStep, currentTime, currentTrue, disablePaginationTrue, disablePaginationFalse, disablePaginationAuto
@docs dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endModeAuto, endModeOver
@docs endModePush, endModeSide, filterContains, filterEndsWith, filterNone, filterStartsWith
@docs floatLabelAlways, floatLabelAuto, gradeHigh, gradeLow, gradeMedium, headerPositionAfter
@docs headerPositionBefore, headerPositionAbove, headerPositionBelow, hideSubscriptAlways, hideSubscriptAuto, hideSubscriptNever
@docs highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth, iconsNone, iconsSelected
@docs labelPositionBelow, labelPositionEnd, modeAuto, modeDocked, modeFullscreen, modeBuffer
@docs modeDeterminate, modeIndeterminate, modeQuery, modeCompact, modeExpanded, modeContains
@docs modeEndsWith, modeStartsWith, motionExpressive, motionStandard, orientationAuto, orientationHorizontal
@docs orientationVertical, pageSizeAll, pageSizeVariantFilled, pageSizeVariantOutlined, positionAbove, positionAfter
@docs positionBefore, positionBelow, positionAboveAfter, positionAboveBefore, positionBelowAfter, positionBelowBefore
@docs positionXAfter, positionXBefore, positionYAbove, positionYBelow, schemeAuto, schemeDark
@docs schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeRounded, shapeSquare, shapeAuto
@docs shapeCircular, sizeExtraLarge, sizeExtraSmall, sizeLarge, sizeMedium, sizeSmall
@docs startModeAuto, startModeOver, startModePush, startModeSide, startViewMonth, startViewMultiYear
@docs startViewYear, stateContent, stateLoading, stateNoData, toggleDirectionHorizontal, toggleDirectionVertical
@docs togglePositionAfter, togglePositionBefore, touchGesturesAuto, touchGesturesOff, touchGesturesOn, typeButton
@docs typeReset, typeSubmit, variantStandard, variantVibrant, variantContent, variantExpressive
@docs variantFidelity, variantFruitSalad, variantMonochrome, variantNeutral, variantRainbow, variantTonalSpot
@docs variantPrimary, variantSecondary, variantElevated, variantFilled, variantOutlined, variantTonal
@docs variantFlat, variantWavy, variantContained, variantUncontained, variantSegmented, variantRounded
@docs variantSharp, variantDisplay, variantHeadline, variantLabel, variantTitle, variantTertiary
@docs variantPrimaryContainer, variantSecondaryContainer, variantSurface, variantTertiaryContainer, variantAuto, variantDocked
@docs variantModal, variantConnected, variantText, widthDefault, widthNarrow, widthWide
@docs ariaLabel, ariaLabelledby, ariaDescribedby, ariaHidden, id, for
@docs class, style, onChange, onOpening, onOpened, onClosing
@docs onClosed, onClick, onBeforeinput, onInput, onBeforetoggle, onToggle
@docs onValueChange, onQuery, onClear, onPage, onCancel, onRemove
@docs onInvalid, onActiveChange, onHighlight, slotLeading, slotTitle, slotSubtitle
@docs slotTrailing, slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData
@docs slotHeader, slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions
@docs slotFooter, slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText
@docs slotToggleIcon, slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix
@docs slotSuffixText, slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput
@docs slotBadge, slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead
@docs slotClearIcon, slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon
@docs slotArrow, slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton
@docs slotDoneIcon, slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon
@docs treeItemSlotLabel, treeItemSlotIcon, treeItemSlotSelectedIcon, treeItemSlotToggleIcon, treeItemSlotOpenToggleIcon, tocSlotOverline
@docs tocSlotTitle, tabsSlotPanel, tabsSlotNextIcon, tabsSlotPrevIcon, tabSlotIcon, stepSlotIcon
@docs stepSlotDoneIcon, stepSlotEditIcon, stepSlotErrorIcon, stepSlotHint, stepSlotError, stepPanelSlotActions
@docs stepperSlotStep, stepperSlotPanel, splitPaneSlotStart, splitPaneSlotEnd, splitButtonSlotLeadingButton, splitButtonSlotTrailingButton
@docs snackbarSlotCloseIcon, slideGroupSlotNextIcon, slideGroupSlotPrevIcon, buttonSegmentSlotIcon, searchViewSlotInput, searchViewSlotOpenLeading
@docs searchViewSlotOpenTrailing, searchViewSlotClosedLeading, searchViewSlotClosedTrailing, searchViewSlotSearchIcon, searchViewSlotCloseIcon, searchViewSlotClearIcon
@docs searchBarSlotLeading, searchBarSlotInput, searchBarSlotTrailing, searchBarSlotClearIcon, paginatorSlotFirstPageIcon, paginatorSlotPreviousPageIcon
@docs paginatorSlotNextPageIcon, paginatorSlotLastPageIcon, selectSlotArrow, selectSlotValue, navMenuItemGroupSlotLabel, navMenuItemSlotLabel
@docs navMenuItemSlotIcon, navMenuItemSlotBadge, navMenuItemSlotSelectedIcon, navMenuItemSlotToggleIcon, navItemSlotIcon, navItemSlotSelectedIcon
@docs menuItemRadioSlotIcon, menuItemRadioSlotTrailingIcon, menuItemCheckboxSlotIcon, menuItemCheckboxSlotTrailingIcon, menuItemSlotIcon, menuItemSlotTrailingIcon
@docs listOptionSlotLeading, listOptionSlotOverline, listOptionSlotSupportingText, listOptionSlotTrailing, expandableListItemSlotLeading, expandableListItemSlotOverline
@docs expandableListItemSlotSupportingText, expandableListItemSlotToggleIcon, expandableListItemSlotItems, listActionSlotLeading, listActionSlotOverline, listActionSlotSupportingText
@docs listActionSlotTrailing, listItemButtonSlotLeading, listItemButtonSlotOverline, listItemButtonSlotSupportingText, listItemButtonSlotTrailing, listItemSlotLeading
@docs listItemSlotOverline, listItemSlotSupportingText, listItemSlotTrailing, fabMenuItemSlotIcon, fabSlotLabel, fabSlotCloseIcon
@docs expansionPanelSlotActions, expansionPanelSlotHeader, expansionPanelSlotToggleIcon, expansionHeaderSlotToggleIcon, drawerContainerSlotStart, drawerContainerSlotEnd
@docs dialogSlotHeader, dialogSlotActions, dialogSlotCloseIcon, suggestionChipSlotIcon, inputChipSetSlotInput, inputChipSlotAvatar
@docs inputChipSlotIcon, inputChipSlotRemoveIcon, filterChipSlotIcon, filterChipSlotTrailingIcon, assistChipSlotIcon, chipSlotIcon
@docs chipSlotTrailingIcon, cardSlotHeader, cardSlotContent, cardSlotActions, cardSlotFooter, calendarSlotHeader
@docs richTooltipSlotSubhead, richTooltipSlotActions, iconButtonSlotSelected, buttonSlotIcon, buttonSlotSelected, buttonSlotSelectedIcon
@docs buttonSlotTrailingIcon, breadcrumbSlotSeparator, breadcrumbItemSlotIcon, breadcrumbItemButtonSlotIcon, bottomSheetSlotHeader, autocompleteSlotLoading
@docs autocompleteSlotNoData, formFieldSlotDefault, formFieldSlotPrefix, formFieldSlotPrefixText, formFieldSlotLabel, formFieldSlotSuffix
@docs formFieldSlotSuffixText, formFieldSlotHint, formFieldSlotError, optionPanelSlotNoData, optionPanelSlotLoading, optgroupSlotLabel
@docs appBarSlotLeading, appBarSlotTitle, appBarSlotSubtitle, appBarSlotTrailing, appBarSlotLeadingIcon, appBarSlotTrailingIcon
@docs slotDefault, child, children, control, linear, circular

-}

import Json.Decode
import M3e.Accordion
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
import M3e.Checkbox
import M3e.Chip
import M3e.ChipSet
import M3e.Collapsible
import M3e.ContentPane
import M3e.Datepicker
import M3e.DatepickerToggle
import M3e.Dialog
import M3e.DialogAction
import M3e.DialogTrigger
import M3e.Divider
import M3e.DrawerContainer
import M3e.DrawerToggle
import M3e.Elevation
import M3e.ExpandableListItem
import M3e.ExpansionHeader
import M3e.ExpansionPanel
import M3e.Fab
import M3e.FabMenu
import M3e.FabMenuItem
import M3e.FabMenuTrigger
import M3e.FilterChip
import M3e.FilterChipSet
import M3e.FloatingPanel
import M3e.FocusRing
import M3e.FocusTrap
import M3e.FormField
import M3e.Heading
import M3e.Html.Shared
import M3e.Icon
import M3e.IconButton
import M3e.InputChip
import M3e.InputChipSet
import M3e.Kind
import M3e.List
import M3e.ListAction
import M3e.ListItem
import M3e.ListItemButton
import M3e.ListOption
import M3e.LoadingIndicator
import M3e.Menu
import M3e.MenuItem
import M3e.MenuItemCheckbox
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
import M3e.Progress
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
import M3e.StepperNext
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
import M3e.Token
import M3e.Toolbar
import M3e.Tooltip
import M3e.Tree
import M3e.TreeItem
import M3e.YearView
import Markup.Aria
import Markup.Attributes
import Markup.Element
import Markup.Html.Attr
import Markup.Kind


{-| See `M3e.Tree`.
-}
tree :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , cascade : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { treeItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | tree : M3e.Kind.Brand } msg
tree =
    M3e.Tree.view


{-| See `M3e.TreeItem`.
-}
treeItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , open : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { treeItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | treeItem : M3e.Kind.Brand } msg
treeItem =
    M3e.TreeItem.view


{-| See `M3e.Toolbar`.
-}
toolbar :
    List
        (Markup.Html.Attr.Attr
            { elevated : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | toolbar : M3e.Kind.Brand } msg
toolbar =
    M3e.Toolbar.view


{-| See `M3e.Toc`.
-}
toc :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , maxDepth : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | toc : M3e.Kind.Brand } msg
toc =
    M3e.Toc.view


{-| See `M3e.TocItem`.
-}
tocItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | tocItem : M3e.Kind.Brand } msg
tocItem =
    M3e.TocItem.view


{-| See `M3e.ThemeIcon`.
-}
themeIcon :
    List
        (Markup.Html.Attr.Attr
            { color : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | themeIcon : M3e.Kind.Brand } msg
themeIcon =
    M3e.ThemeIcon.view


{-| See `M3e.Theme`.
-}
theme :
    List
        (Markup.Html.Attr.Attr
            { color : M3e.Token.Supported
            , contrast : M3e.Token.Supported
            , density : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , strongFocus : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , motion : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | theme : M3e.Kind.Brand } msg
theme =
    M3e.Theme.view


{-| See `M3e.TextareaAutosize`.
-}
textareaAutosize :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , maxRows : M3e.Token.Supported
            , minRows : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | textareaAutosize : M3e.Kind.Brand } msg
textareaAutosize =
    M3e.TextareaAutosize.view


{-| See `M3e.Tabs`.
-}
tabs :
    List
        (Markup.Html.Attr.Attr
            { disablePagination : M3e.Token.Supported
            , headerPosition : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , stretch : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { tab : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | tabs : M3e.Kind.Brand } msg
tabs =
    M3e.Tabs.view


{-| See `M3e.TabPanel`.
-}
tabPanel :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | tabPanel : M3e.Kind.Brand } msg
tabPanel =
    M3e.TabPanel.view


{-| See `M3e.Tab`.
-}
tab :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | tab : M3e.Kind.Brand } msg
tab =
    M3e.Tab.view


{-| See `M3e.Switch`.
-}
switch :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , icons : M3e.Token.Supported
            , name : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | switch : M3e.Kind.Brand } msg
switch =
    M3e.Switch.view


{-| See `M3e.StepperReset`.
-}
stepperReset :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepperReset : M3e.Kind.Brand } msg
stepperReset =
    M3e.StepperReset.view


{-| See `M3e.StepperPrevious`.
-}
stepperPrevious :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepperPrevious : M3e.Kind.Brand } msg
stepperPrevious =
    M3e.StepperPrevious.view


{-| See `M3e.StepperNext`.
-}
stepperNext :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepperNext : M3e.Kind.Brand } msg
stepperNext =
    M3e.StepperNext.view


{-| See `M3e.Step`.
-}
step :
    List
        (Markup.Html.Attr.Attr
            { completed : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , editable : M3e.Token.Supported
            , for : M3e.Token.Supported
            , optional : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , invalid : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | step : M3e.Kind.Brand } msg
step =
    M3e.Step.view


{-| See `M3e.StepPanel`.
-}
stepPanel :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepPanel : M3e.Kind.Brand } msg
stepPanel =
    M3e.StepPanel.view


{-| See `M3e.Stepper`.
-}
stepper :
    List
        (Markup.Html.Attr.Attr
            { headerPosition : M3e.Token.Supported
            , labelPosition : M3e.Token.Supported
            , linear : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepper : M3e.Kind.Brand } msg
stepper =
    M3e.Stepper.view


{-| See `M3e.SplitPane`.
-}
splitPane :
    List
        (Markup.Html.Attr.Attr
            { detents : M3e.Token.Supported
            , label : M3e.Token.Supported
            , max : M3e.Token.Supported
            , min : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , overshootLimit : M3e.Token.Supported
            , step : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , wrapDetents : M3e.Token.Supported
            , name : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | splitPane : M3e.Kind.Brand } msg
splitPane =
    M3e.SplitPane.view


{-| See `M3e.SplitButton`.
-}
splitButton :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | splitButton : M3e.Kind.Brand } msg
splitButton =
    M3e.SplitButton.view


{-| See `M3e.Snackbar`.
-}
snackbar :
    List
        (Markup.Html.Attr.Attr
            { action : M3e.Token.Supported
            , closeLabel : M3e.Token.Supported
            , dismissible : M3e.Token.Supported
            , duration : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | snackbar : M3e.Kind.Brand } msg
snackbar =
    M3e.Snackbar.view


{-| See `M3e.Slider`.
-}
slider :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , discrete : M3e.Token.Supported
            , labelled : M3e.Token.Supported
            , max : M3e.Token.Supported
            , min : M3e.Token.Supported
            , step : M3e.Token.Supported
            , size : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | slider : M3e.Kind.Brand } msg
slider =
    M3e.Slider.view


{-| See `M3e.SliderThumb`.
-}
sliderThumb :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , onValueChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | sliderThumb : M3e.Kind.Brand } msg
sliderThumb =
    M3e.SliderThumb.view


{-| See `M3e.SlideGroup`.
-}
slideGroup :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , threshold : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | slideGroup : M3e.Kind.Brand } msg
slideGroup =
    M3e.SlideGroup.view


{-| See `M3e.Skeleton`.
-}
skeleton :
    List
        (Markup.Html.Attr.Attr
            { animation : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , loaded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | skeleton : M3e.Kind.Brand } msg
skeleton =
    M3e.Skeleton.view


{-| See `M3e.Shape`.
-}
shape :
    List
        (Markup.Html.Attr.Attr
            { nameEnum : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | shape : M3e.Kind.Brand } msg
shape =
    M3e.Shape.view


{-| See `M3e.SegmentedButton`.
-}
segmentedButton :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { buttonSegment : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | segmentedButton : M3e.Kind.Brand } msg
segmentedButton =
    M3e.SegmentedButton.view


{-| See `M3e.ButtonSegment`.
-}
buttonSegment :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | buttonSegment : M3e.Kind.Brand } msg
buttonSegment =
    M3e.ButtonSegment.view


{-| See `M3e.SearchView`.
-}
searchView :
    List
        (Markup.Html.Attr.Attr
            { contained : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , open : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , closeLabel : M3e.Token.Supported
            , hideSearchIcon : M3e.Token.Supported
            , onQuery : M3e.Token.Supported
            , onClear : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | searchView : M3e.Kind.Brand } msg
searchView =
    M3e.SearchView.view


{-| See `M3e.SearchBar`.
-}
searchBar :
    List
        (Markup.Html.Attr.Attr
            { clearable : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , onClear : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | searchBar : M3e.Kind.Brand } msg
searchBar =
    M3e.SearchBar.view


{-| See `M3e.RadioGroup`.
-}
radioGroup :
    List
        (Markup.Html.Attr.Attr
            { ariaInvalid : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | radioGroup : M3e.Kind.Brand } msg
radioGroup =
    M3e.RadioGroup.view


{-| See `M3e.Radio`.
-}
radio :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | radio : M3e.Kind.Brand } msg
radio =
    M3e.Radio.view


{-| See `M3e.Paginator`.
-}
paginator :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , firstPageLabel : M3e.Token.Supported
            , hidePageSize : M3e.Token.Supported
            , itemsPerPageLabel : M3e.Token.Supported
            , lastPageLabel : M3e.Token.Supported
            , length : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , pageIndex : M3e.Token.Supported
            , pageSize : M3e.Token.Supported
            , pageSizes : M3e.Token.Supported
            , pageSizeVariant : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , showFirstLastButtons : M3e.Token.Supported
            , onPage : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | paginator : M3e.Kind.Brand } msg
paginator =
    M3e.Paginator.view


{-| See `M3e.Select`.
-}
select :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , panelClass : M3e.Token.Supported
            , required : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { option : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | select : M3e.Kind.Brand } msg
select =
    M3e.Select.view


{-| See `M3e.NavRailToggle`.
-}
navRailToggle :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | navRailToggle : M3e.Kind.Brand } msg
navRailToggle =
    M3e.NavRailToggle.view


{-| See `M3e.NavRail`.
-}
navRail :
    List
        (Markup.Html.Attr.Attr
            { mode : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { navItem : M3e.Kind.Brand
                , iconButton : M3e.Kind.Brand
                , fab : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | navRail : M3e.Kind.Brand } msg
navRail =
    M3e.NavRail.view


{-| See `M3e.NavMenuItemGroup`.
-}
navMenuItemGroup :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { navMenuItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | navMenuItemGroup : M3e.Kind.Brand } msg
navMenuItemGroup =
    M3e.NavMenuItemGroup.view


{-| See `M3e.NavMenu`.
-}
navMenu :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { navMenuItem : M3e.Kind.Brand
                , navMenuItemGroup : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | navMenu : M3e.Kind.Brand } msg
navMenu =
    M3e.NavMenu.view


{-| See `M3e.NavMenuItem`.
-}
navMenuItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , open : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { navMenuItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | navMenuItem : M3e.Kind.Brand } msg
navMenuItem =
    M3e.NavMenuItem.view


{-| See `M3e.NavBar`.
-}
navBar :
    List
        (Markup.Html.Attr.Attr
            { mode : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { navItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | navBar : M3e.Kind.Brand } msg
navBar =
    M3e.NavBar.view


{-| See `M3e.NavItem`.
-}
navItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | navItem : M3e.Kind.Brand } msg
navItem =
    M3e.NavItem.view


{-| See `M3e.MenuItemRadio`.
-}
menuItemRadio :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | menuItemRadio : M3e.Kind.Brand } msg
menuItemRadio =
    M3e.MenuItemRadio.view


{-| See `M3e.MenuItemGroup`.
-}
menuItemGroup :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { menuItem : M3e.Kind.Brand
                , menuItemCheckbox : M3e.Kind.Brand
                , menuItemRadio : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | menuItemGroup : M3e.Kind.Brand } msg
menuItemGroup =
    M3e.MenuItemGroup.view


{-| See `M3e.MenuItemCheckbox`.
-}
menuItemCheckbox :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | menuItemCheckbox : M3e.Kind.Brand } msg
menuItemCheckbox =
    M3e.MenuItemCheckbox.view


{-| See `M3e.Menu`.
-}
menu :
    List
        (Markup.Html.Attr.Attr
            { positionX : M3e.Token.Supported
            , positionY : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , submenu : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { menuItem : M3e.Kind.Brand
                , menuItemCheckbox : M3e.Kind.Brand
                , menuItemRadio : M3e.Kind.Brand
                , menuItemGroup : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | menu : M3e.Kind.Brand } msg
menu =
    M3e.Menu.view


{-| See `M3e.MenuItem`.
-}
menuItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , dialogTrigger : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , menuTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | menuItem : M3e.Kind.Brand } msg
menuItem =
    M3e.MenuItem.view


{-| See `M3e.MenuTrigger`.
-}
menuTrigger :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | menuTrigger : M3e.Kind.Brand } msg
menuTrigger =
    M3e.MenuTrigger.view


{-| See `M3e.LoadingIndicator`.
-}
loadingIndicator :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | loadingIndicator : M3e.Kind.Brand } msg
loadingIndicator =
    M3e.LoadingIndicator.view


{-| See `M3e.SelectionList`.
-}
selectionList :
    List
        (Markup.Html.Attr.Attr
            { hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , name : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { listOption : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | selectionList : M3e.Kind.Brand } msg
selectionList =
    M3e.SelectionList.view


{-| See `M3e.ListOption`.
-}
listOption :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listOption : M3e.Kind.Brand } msg
listOption =
    M3e.ListOption.view


{-| See `M3e.ActionList`.
-}
actionList :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { listAction : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | actionList : M3e.Kind.Brand } msg
actionList =
    M3e.ActionList.view


{-| See `M3e.ExpandableListItem`.
-}
expandableListItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , open : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | expandableListItem : M3e.Kind.Brand } msg
expandableListItem =
    M3e.ExpandableListItem.view


{-| See `M3e.ListAction`.
-}
listAction :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , dialogTrigger : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , menuTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listAction : M3e.Kind.Brand } msg
listAction =
    M3e.ListAction.view


{-| See `M3e.ListItemButton`.
-}
listItemButton :
    List
        (Markup.Html.Attr.Attr
            { href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listItemButton : M3e.Kind.Brand } msg
listItemButton =
    M3e.ListItemButton.view


{-| See `M3e.List`.
-}
list :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { listItem : M3e.Kind.Brand
                , listAction : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , listOption : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | list : M3e.Kind.Brand } msg
list =
    M3e.List.view


{-| See `M3e.ListItem`.
-}
listItem :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listItem : M3e.Kind.Brand } msg
listItem =
    M3e.ListItem.view


{-| See `M3e.Icon`.
-}
icon :
    List
        (Markup.Html.Attr.Attr
            { filled : M3e.Token.Supported
            , grade : M3e.Token.Supported
            , opticalSize : M3e.Token.Supported
            , name : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , weight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | icon : Markup.Kind.Shared } msg
icon =
    M3e.Icon.view


{-| See `M3e.Heading`.
-}
heading :
    List
        (Markup.Html.Attr.Attr
            { emphasized : M3e.Token.Supported
            , level : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , tocIgnore : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | heading : M3e.Kind.Brand } msg
heading =
    M3e.Heading.view


{-| See `M3e.FabMenuTrigger`.
-}
fabMenuTrigger :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | fabMenuTrigger : M3e.Kind.Brand } msg
fabMenuTrigger =
    M3e.FabMenuTrigger.view


{-| See `M3e.FabMenuItem`.
-}
fabMenuItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | fabMenuItem : M3e.Kind.Brand } msg
fabMenuItem =
    M3e.FabMenuItem.view


{-| See `M3e.FabMenu`.
-}
fabMenu :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { fabMenuItem : M3e.Kind.Brand
                , menuItem : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | fabMenu : M3e.Kind.Brand } msg
fabMenu =
    M3e.FabMenu.view


{-| See `M3e.Fab`.
-}
fab :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , extended : M3e.Token.Supported
            , href : M3e.Token.Supported
            , lowered : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , size : M3e.Token.Supported
            , target : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { icon : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | fab : M3e.Kind.Brand } msg
fab =
    M3e.Fab.view


{-| See `M3e.Accordion`.
-}
accordion :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { expansionPanel : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | accordion : M3e.Kind.Brand } msg
accordion =
    M3e.Accordion.view


{-| See `M3e.ExpansionPanel`.
-}
expansionPanel :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideToggle : M3e.Token.Supported
            , open : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | expansionPanel : M3e.Kind.Brand } msg
expansionPanel =
    M3e.ExpansionPanel.view


{-| See `M3e.ExpansionHeader`.
-}
expansionHeader :
    List
        (Markup.Html.Attr.Attr
            { hideToggle : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | expansionHeader : M3e.Kind.Brand } msg
expansionHeader =
    M3e.ExpansionHeader.view


{-| See `M3e.DrawerToggle`.
-}
drawerToggle :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | drawerToggle : M3e.Kind.Brand } msg
drawerToggle =
    M3e.DrawerToggle.view


{-| See `M3e.DrawerContainer`.
-}
drawerContainer :
    List
        (Markup.Html.Attr.Attr
            { end : M3e.Token.Supported
            , endMode : M3e.Token.Supported
            , endDivider : M3e.Token.Supported
            , start : M3e.Token.Supported
            , startMode : M3e.Token.Supported
            , startDivider : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | drawerContainer : M3e.Kind.Brand } msg
drawerContainer =
    M3e.DrawerContainer.view


{-| See `M3e.Divider`.
-}
divider :
    List
        (Markup.Html.Attr.Attr
            { inset : M3e.Token.Supported
            , insetStart : M3e.Token.Supported
            , insetEnd : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | divider : M3e.Kind.Brand } msg
divider =
    M3e.Divider.view


{-| See `M3e.DialogTrigger`.
-}
dialogTrigger :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | dialogTrigger : M3e.Kind.Brand } msg
dialogTrigger =
    M3e.DialogTrigger.view


{-| See `M3e.Dialog`.
-}
dialog :
    List
        (Markup.Html.Attr.Attr
            { alert : M3e.Token.Supported
            , closeLabel : M3e.Token.Supported
            , disableClose : M3e.Token.Supported
            , dismissible : M3e.Token.Supported
            , noFocusTrap : M3e.Token.Supported
            , open : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , onCancel : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | dialog : M3e.Kind.Brand } msg
dialog =
    M3e.Dialog.view


{-| See `M3e.DialogAction`.
-}
dialogAction :
    List
        (Markup.Html.Attr.Attr
            { returnValue : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | dialogAction : M3e.Kind.Brand } msg
dialogAction =
    M3e.DialogAction.view


{-| See `M3e.DatepickerToggle`.
-}
datepickerToggle :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | datepickerToggle : M3e.Kind.Brand } msg
datepickerToggle =
    M3e.DatepickerToggle.view


{-| See `M3e.Datepicker`.
-}
datepicker :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , clearable : M3e.Token.Supported
            , date : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , range : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , rangeStart : M3e.Token.Supported
            , startAt : M3e.Token.Supported
            , startView : M3e.Token.Supported
            , previousMonthLabel : M3e.Token.Supported
            , nextMonthLabel : M3e.Token.Supported
            , previousYearLabel : M3e.Token.Supported
            , nextYearLabel : M3e.Token.Supported
            , previousMultiYearLabel : M3e.Token.Supported
            , nextMultiYearLabel : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , confirmLabel : M3e.Token.Supported
            , dismissLabel : M3e.Token.Supported
            , label : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | datepicker : M3e.Kind.Brand } msg
datepicker =
    M3e.Datepicker.view


{-| See `M3e.ContentPane`.
-}
contentPane :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | contentPane : M3e.Kind.Brand } msg
contentPane =
    M3e.ContentPane.view


{-| See `M3e.SuggestionChip`.
-}
suggestionChip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | suggestionChip : M3e.Kind.Brand } msg
suggestionChip =
    M3e.SuggestionChip.view


{-| See `M3e.InputChipSet`.
-}
inputChipSet :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { inputChip : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | inputChipSet : M3e.Kind.Brand } msg
inputChipSet =
    M3e.InputChipSet.view


{-| See `M3e.InputChip`.
-}
inputChip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , removable : M3e.Token.Supported
            , removeLabel : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onRemove : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | inputChip : M3e.Kind.Brand } msg
inputChip =
    M3e.InputChip.view


{-| See `M3e.FilterChipSet`.
-}
filterChipSet :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { filterChip : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | filterChipSet : M3e.Kind.Brand } msg
filterChipSet =
    M3e.FilterChipSet.view


{-| See `M3e.FilterChip`.
-}
filterChip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | filterChip : M3e.Kind.Brand } msg
filterChip =
    M3e.FilterChip.view


{-| See `M3e.ChipSet`.
-}
chipSet :
    List
        (Markup.Html.Attr.Attr
            { vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { assistChip : M3e.Kind.Brand
                , chip : M3e.Kind.Brand
                , filterChip : M3e.Kind.Brand
                , inputChip : M3e.Kind.Brand
                , suggestionChip : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | chipSet : M3e.Kind.Brand } msg
chipSet =
    M3e.ChipSet.view


{-| See `M3e.AssistChip`.
-}
assistChip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | assistChip : M3e.Kind.Brand } msg
assistChip =
    M3e.AssistChip.view


{-| See `M3e.Chip`.
-}
chip :
    List
        (Markup.Html.Attr.Attr
            { value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | chip : M3e.Kind.Brand } msg
chip =
    M3e.Chip.view


{-| See `M3e.Checkbox`.
-}
checkbox :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onInvalid : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | checkbox : M3e.Kind.Brand } msg
checkbox =
    M3e.Checkbox.view


{-| See `M3e.Card`.
-}
card :
    List
        (Markup.Html.Attr.Attr
            { actionable : M3e.Token.Supported
            , inline : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , name : M3e.Token.Supported
            , value : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | card : M3e.Kind.Brand } msg
card =
    M3e.Card.view


{-| See `M3e.Calendar`.
-}
calendar :
    List
        (Markup.Html.Attr.Attr
            { date : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , rangeStart : M3e.Token.Supported
            , startAt : M3e.Token.Supported
            , startView : M3e.Token.Supported
            , previousMonthLabel : M3e.Token.Supported
            , nextMonthLabel : M3e.Token.Supported
            , previousYearLabel : M3e.Token.Supported
            , nextYearLabel : M3e.Token.Supported
            , previousMultiYearLabel : M3e.Token.Supported
            , nextMultiYearLabel : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | calendar : M3e.Kind.Brand } msg
calendar =
    M3e.Calendar.view


{-| See `M3e.YearView`.
-}
yearView :
    List
        (Markup.Html.Attr.Attr
            { active : M3e.Token.Supported
            , today : M3e.Token.Supported
            , date : M3e.Token.Supported
            , activeDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onActiveChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | yearView : M3e.Kind.Brand } msg
yearView =
    M3e.YearView.view


{-| See `M3e.MultiYearView`.
-}
multiYearView :
    List
        (Markup.Html.Attr.Attr
            { active : M3e.Token.Supported
            , today : M3e.Token.Supported
            , date : M3e.Token.Supported
            , activeDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onActiveChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | multiYearView : M3e.Kind.Brand } msg
multiYearView =
    M3e.MultiYearView.view


{-| See `M3e.MonthView`.
-}
monthView :
    List
        (Markup.Html.Attr.Attr
            { rangeStart : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , active : M3e.Token.Supported
            , today : M3e.Token.Supported
            , date : M3e.Token.Supported
            , activeDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onActiveChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | monthView : M3e.Kind.Brand } msg
monthView =
    M3e.MonthView.view


{-| See `M3e.Tooltip`.
-}
tooltip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , hideDelay : M3e.Token.Supported
            , position : M3e.Token.Supported
            , showDelay : M3e.Token.Supported
            , touchGestures : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | tooltip : M3e.Kind.Brand } msg
tooltip =
    M3e.Tooltip.view


{-| See `M3e.RichTooltip`.
-}
richTooltip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , hideDelay : M3e.Token.Supported
            , position : M3e.Token.Supported
            , showDelay : M3e.Token.Supported
            , touchGestures : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | richTooltip : M3e.Kind.Brand } msg
richTooltip =
    M3e.RichTooltip.view


{-| See `M3e.RichTooltipAction`.
-}
richTooltipAction :
    List
        (Markup.Html.Attr.Attr
            { disableRestoreFocus : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | richTooltipAction : M3e.Kind.Brand } msg
richTooltipAction =
    M3e.RichTooltipAction.view


{-| See `M3e.ButtonGroup`.
-}
buttonGroup :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { button : M3e.Kind.Brand
                , iconButton : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | buttonGroup : M3e.Kind.Brand } msg
buttonGroup =
    M3e.ButtonGroup.view


{-| See `M3e.IconButton`.
-}
iconButton :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , size : M3e.Token.Supported
            , target : M3e.Token.Supported
            , toggle : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , width : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { icon : Markup.Kind.Shared
                , menuTrigger : M3e.Kind.Brand
                , dialogTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperNext : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | iconButton : M3e.Kind.Brand } msg
iconButton =
    M3e.IconButton.view


{-| See `M3e.Button`.
-}
button :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , size : M3e.Token.Supported
            , target : M3e.Token.Supported
            , toggle : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , icon : Markup.Kind.Shared
                , menuTrigger : M3e.Kind.Brand
                , dialogTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperNext : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | button : M3e.Kind.Brand } msg
button =
    M3e.Button.view


{-| See `M3e.Breadcrumb`.
-}
breadcrumb :
    List
        (Markup.Html.Attr.Attr
            { wrap : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { breadcrumbItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | breadcrumb : M3e.Kind.Brand } msg
breadcrumb =
    M3e.Breadcrumb.view


{-| See `M3e.BreadcrumbItem`.
-}
breadcrumbItem :
    List
        (Markup.Html.Attr.Attr
            { itemLabel : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , current : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , download : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , icon : Markup.Kind.Shared
                }
                msg
            )
    -> Markup.Element.Element { s | breadcrumbItem : M3e.Kind.Brand } msg
breadcrumbItem =
    M3e.BreadcrumbItem.view


{-| See `M3e.BreadcrumbItemButton`.
-}
breadcrumbItemButton :
    List
        (Markup.Html.Attr.Attr
            { current : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , icon : Markup.Kind.Shared
                }
                msg
            )
    -> Markup.Element.Element { s | breadcrumbItemButton : M3e.Kind.Brand } msg
breadcrumbItemButton =
    M3e.BreadcrumbItemButton.view


{-| See `M3e.BottomSheetTrigger`.
-}
bottomSheetTrigger :
    List
        (Markup.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , secondary : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | bottomSheetTrigger : M3e.Kind.Brand } msg
bottomSheetTrigger =
    M3e.BottomSheetTrigger.view


{-| See `M3e.BottomSheet`.
-}
bottomSheet :
    List
        (Markup.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , detents : M3e.Token.Supported
            , handle : M3e.Token.Supported
            , handleLabel : M3e.Token.Supported
            , hideable : M3e.Token.Supported
            , hideFriction : M3e.Token.Supported
            , modal : M3e.Token.Supported
            , open : M3e.Token.Supported
            , overshootLimit : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onCancel : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | bottomSheet : M3e.Kind.Brand } msg
bottomSheet =
    M3e.BottomSheet.view


{-| See `M3e.BottomSheetAction`.
-}
bottomSheetAction :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | bottomSheetAction : M3e.Kind.Brand } msg
bottomSheetAction =
    M3e.BottomSheetAction.view


{-| See `M3e.Badge`.
-}
badge :
    List
        (Markup.Html.Attr.Attr
            { size : M3e.Token.Supported
            , position : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | badge : M3e.Kind.Brand } msg
badge =
    M3e.Badge.view


{-| See `M3e.Avatar`.
-}
avatar :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | avatar : M3e.Kind.Brand } msg
avatar =
    M3e.Avatar.view


{-| See `M3e.Autocomplete`.
-}
autocomplete :
    List
        (Markup.Html.Attr.Attr
            { autoActivate : M3e.Token.Supported
            , caseSensitive : M3e.Token.Supported
            , filter : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , hideLoading : M3e.Token.Supported
            , hideNoData : M3e.Token.Supported
            , loading : M3e.Token.Supported
            , loadingLabel : M3e.Token.Supported
            , noDataLabel : M3e.Token.Supported
            , panelClass : M3e.Token.Supported
            , required : M3e.Token.Supported
            , for : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onQuery : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { option : M3e.Kind.Brand
                , optgroup : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | autocomplete : M3e.Kind.Brand } msg
autocomplete =
    M3e.Autocomplete.view


{-| See `M3e.FormField`.
-}
formField :
    List
        (Markup.Html.Attr.Attr
            { floatLabel : M3e.Token.Supported
            , hideRequiredMarker : M3e.Token.Supported
            , hideSubscript : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | formField : M3e.Kind.Brand } msg
formField =
    M3e.FormField.view


{-| See `M3e.OptionPanel`.
-}
optionPanel :
    List
        (Markup.Html.Attr.Attr
            { state : M3e.Token.Supported
            , scrollStrategy : M3e.Token.Supported
            , fitAnchorWidth : M3e.Token.Supported
            , anchorOffset : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { option : M3e.Kind.Brand
                , optgroup : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | optionPanel : M3e.Kind.Brand } msg
optionPanel =
    M3e.OptionPanel.view


{-| See `M3e.FloatingPanel`.
-}
floatingPanel :
    List
        (Markup.Html.Attr.Attr
            { scrollStrategy : M3e.Token.Supported
            , fitAnchorWidth : M3e.Token.Supported
            , anchorOffset : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | floatingPanel : M3e.Kind.Brand } msg
floatingPanel =
    M3e.FloatingPanel.view


{-| See `M3e.Optgroup`.
-}
optgroup :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { option : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | optgroup : M3e.Kind.Brand } msg
optgroup =
    M3e.Optgroup.view


{-| See `M3e.Option`.
-}
option :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disableHighlight : M3e.Token.Supported
            , highlightMode : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , term : M3e.Token.Supported
            , value : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | option : M3e.Kind.Brand } msg
option =
    M3e.Option.view


{-| See `M3e.FocusTrap`.
-}
focusTrap :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | focusTrap : M3e.Kind.Brand } msg
focusTrap =
    M3e.FocusTrap.view


{-| See `M3e.AppBar`.
-}
appBar :
    List
        (Markup.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , for : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | appBar : M3e.Kind.Brand } msg
appBar =
    M3e.AppBar.view


{-| See `M3e.TextOverflow`.
-}
textOverflow :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | textOverflow : M3e.Kind.Brand } msg
textOverflow =
    M3e.TextOverflow.view


{-| See `M3e.TextHighlight`.
-}
textHighlight :
    List
        (Markup.Html.Attr.Attr
            { caseSensitive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , term : M3e.Token.Supported
            , onHighlight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | textHighlight : M3e.Kind.Brand } msg
textHighlight =
    M3e.TextHighlight.view


{-| See `M3e.StateLayer`.
-}
stateLayer :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disableHover : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stateLayer : M3e.Kind.Brand } msg
stateLayer =
    M3e.StateLayer.view


{-| See `M3e.Slide`.
-}
slide :
    List
        (Markup.Html.Attr.Attr
            { selectedIndex : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | slide : M3e.Kind.Brand } msg
slide =
    M3e.Slide.view


{-| See `M3e.ScrollContainer`.
-}
scrollContainer :
    List
        (Markup.Html.Attr.Attr
            { dividers : M3e.Token.Supported
            , thin : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | scrollContainer : M3e.Kind.Brand } msg
scrollContainer =
    M3e.ScrollContainer.view


{-| See `M3e.Ripple`.
-}
ripple :
    List
        (Markup.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , radius : M3e.Token.Supported
            , unbounded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | ripple : M3e.Kind.Brand } msg
ripple =
    M3e.Ripple.view


{-| See `M3e.PseudoRadio`.
-}
pseudoRadio :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | pseudoRadio : M3e.Kind.Brand } msg
pseudoRadio =
    M3e.PseudoRadio.view


{-| See `M3e.PseudoCheckbox`.
-}
pseudoCheckbox :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | pseudoCheckbox : M3e.Kind.Brand } msg
pseudoCheckbox =
    M3e.PseudoCheckbox.view


{-| See `M3e.FocusRing`.
-}
focusRing :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , inward : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | focusRing : M3e.Kind.Brand } msg
focusRing =
    M3e.FocusRing.view


{-| See `M3e.Elevation`.
-}
elevation :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , level : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | elevation : M3e.Kind.Brand } msg
elevation =
    M3e.Elevation.view


{-| See `M3e.Collapsible`.
-}
collapsible :
    List
        (Markup.Html.Attr.Attr
            { open : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , noAnimate : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | collapsible : M3e.Kind.Brand } msg
collapsible =
    M3e.Collapsible.view


{-| The label of the snackbar's action. (default: `""`)
-}
attrAction : String -> Markup.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
attrAction =
    M3e.Html.Shared.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
attrActionable : Bool -> Markup.Html.Attr.Attr { c | actionable : M3e.Token.Supported } msg
attrActionable =
    M3e.Html.Shared.actionable


{-| Whether the view is active. (default: `false`)
-}
attrActive : Bool -> Markup.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
attrActive =
    M3e.Html.Shared.active


{-| The active date. (default: `new Date()`)
-}
attrActiveDate : String -> Markup.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
attrActiveDate =
    M3e.Html.Shared.activeDate


{-| Whether the dialog is an alert. (default: `false`)
-}
attrAlert : Bool -> Markup.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
attrAlert =
    M3e.Html.Shared.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
attrAnchorOffset :
    Float
    -> Markup.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
attrAnchorOffset =
    M3e.Html.Shared.anchorOffset


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid :
    String
    -> Markup.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    M3e.Html.Shared.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`)
-}
attrAutoActivate : Bool -> Markup.Html.Attr.Attr { c | autoActivate : M3e.Token.Supported } msg
attrAutoActivate =
    M3e.Html.Shared.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
attrBufferValue : Float -> Markup.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
attrBufferValue =
    M3e.Html.Shared.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
attrCascade : Bool -> Markup.Html.Attr.Attr { c | cascade : M3e.Token.Supported } msg
attrCascade =
    M3e.Html.Shared.cascade


{-| Whether filtering is case sensitive. (default: `false`)
-}
attrCaseSensitive :
    Bool
    -> Markup.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
attrCaseSensitive =
    M3e.Html.Shared.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`)
-}
attrCentered : Bool -> Markup.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
attrCentered =
    M3e.Html.Shared.centered


{-| Whether the element is checked. (default: `false`)
-}
attrChecked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
attrChecked =
    M3e.Html.Shared.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
attrClearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
attrClearLabel =
    M3e.Html.Shared.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
attrClearable : Bool -> Markup.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
attrClearable =
    M3e.Html.Shared.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
attrCloseLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
attrCloseLabel =
    M3e.Html.Shared.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
attrColor : String -> Markup.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
attrColor =
    M3e.Html.Shared.color


{-| Whether the step has been completed. (default: `false`)
-}
attrCompleted : Bool -> Markup.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
attrCompleted =
    M3e.Html.Shared.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
attrConfirmLabel :
    String
    -> Markup.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
attrConfirmLabel =
    M3e.Html.Shared.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
attrContained : Bool -> Markup.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
attrContained =
    M3e.Html.Shared.contained


{-| The selected date. (default: `null`)
-}
attrDate : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
attrDate =
    M3e.Html.Shared.date


{-| The density scale (0, -1, -2). (default: `0`)
-}
attrDensity : Float -> Markup.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
attrDensity =
    M3e.Html.Shared.density


{-| The zero‑based index of the detent the sheet should open to.
-}
attrDetent : Float -> Markup.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
attrDetent =
    M3e.Html.Shared.detent


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
attrDetents : String -> Markup.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
attrDetents =
    M3e.Html.Shared.detents


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
attrDisableClose : Bool -> Markup.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
attrDisableClose =
    M3e.Html.Shared.disableClose


{-| Whether text highlighting is disabled. (default: `false`)
-}
attrDisableHighlight :
    Bool
    -> Markup.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
attrDisableHighlight =
    M3e.Html.Shared.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
attrDisableHover : Bool -> Markup.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
attrDisableHover =
    M3e.Html.Shared.disableHover


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
attrDisableRestoreFocus :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disableRestoreFocus : M3e.Token.Supported
            }
            msg
attrDisableRestoreFocus =
    M3e.Html.Shared.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`)
-}
attrDisabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
attrDisabled =
    M3e.Html.Shared.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
attrDisabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
attrDisabledInteractive =
    M3e.Html.Shared.disabledInteractive


{-| Whether to show tick marks. (default: `false`)
-}
attrDiscrete : Bool -> Markup.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
attrDiscrete =
    M3e.Html.Shared.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
attrDismissLabel :
    String
    -> Markup.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
attrDismissLabel =
    M3e.Html.Shared.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
attrDismissible : Bool -> Markup.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
attrDismissible =
    M3e.Html.Shared.dismissible


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
attrDownload : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
attrDownload =
    M3e.Html.Shared.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
attrDuration : Float -> Markup.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
attrDuration =
    M3e.Html.Shared.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
attrEditable : Bool -> Markup.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
attrEditable =
    M3e.Html.Shared.editable


{-| Whether the toolbar is elevated. (default: `false`)
-}
attrElevated : Bool -> Markup.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
attrElevated =
    M3e.Html.Shared.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
attrEmphasized : Bool -> Markup.Html.Attr.Attr { c | emphasized : M3e.Token.Supported } msg
attrEmphasized =
    M3e.Html.Shared.emphasized


{-| Whether the end drawer is open. (default: `false`)
-}
attrEnd : Bool -> Markup.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
attrEnd =
    M3e.Html.Shared.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
attrEndDivider : Bool -> Markup.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
attrEndDivider =
    M3e.Html.Shared.endDivider


{-| Whether the button is extended to show the label. (default: `false`)
-}
attrExtended : Bool -> Markup.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
attrExtended =
    M3e.Html.Shared.extended


{-| Whether the icon is filled. (default: `false`)
-}
attrFilled : Bool -> Markup.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
attrFilled =
    M3e.Html.Shared.filled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
attrFirstPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
attrFirstPageLabel =
    M3e.Html.Shared.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
attrFitAnchorWidth :
    Bool
    -> Markup.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
attrFitAnchorWidth =
    M3e.Html.Shared.fitAnchorWidth


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
attrFor : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
attrFor =
    M3e.Html.Shared.for


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
attrHandle : Bool -> Markup.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
attrHandle =
    M3e.Html.Shared.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
attrHandleLabel :
    String
    -> Markup.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
attrHandleLabel =
    M3e.Html.Shared.handleLabel


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
attrHideDelay : Float -> Markup.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
attrHideDelay =
    M3e.Html.Shared.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
attrHideFriction :
    Float
    -> Markup.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
attrHideFriction =
    M3e.Html.Shared.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`)
-}
attrHideLoading : Bool -> Markup.Html.Attr.Attr { c | hideLoading : M3e.Token.Supported } msg
attrHideLoading =
    M3e.Html.Shared.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
attrHideNoData : Bool -> Markup.Html.Attr.Attr { c | hideNoData : M3e.Token.Supported } msg
attrHideNoData =
    M3e.Html.Shared.hideNoData


{-| Whether to hide page size selection. (default: `false`)
-}
attrHidePageSize : Bool -> Markup.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
attrHidePageSize =
    M3e.Html.Shared.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`)
-}
attrHideRequiredMarker :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideRequiredMarker : M3e.Token.Supported
            }
            msg
attrHideRequiredMarker =
    M3e.Html.Shared.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`)
-}
attrHideSearchIcon :
    Bool
    -> Markup.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
attrHideSearchIcon =
    M3e.Html.Shared.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`)
-}
attrHideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
attrHideSelectionIndicator =
    M3e.Html.Shared.hideSelectionIndicator


{-| Whether to hide the expansion toggle. (default: `false`)
-}
attrHideToggle : Bool -> Markup.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
attrHideToggle =
    M3e.Html.Shared.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
attrHideable : Bool -> Markup.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
attrHideable =
    M3e.Html.Shared.hideable


{-| The URL to which the link button points. (default: `""`)
-}
attrHref : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
attrHref =
    M3e.Html.Shared.href


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
attrIndeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
attrIndeterminate =
    M3e.Html.Shared.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
attrInline : Bool -> Markup.Html.Attr.Attr { c | inline : M3e.Token.Supported } msg
attrInline =
    M3e.Html.Shared.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
attrInset : Bool -> Markup.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
attrInset =
    M3e.Html.Shared.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
attrInsetEnd : Bool -> Markup.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
attrInsetEnd =
    M3e.Html.Shared.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
attrInsetStart : Bool -> Markup.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
attrInsetStart =
    M3e.Html.Shared.insetStart


{-| Whether the step has an error. (default: `false`)
-}
attrInvalid : Bool -> Markup.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
attrInvalid =
    M3e.Html.Shared.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
attrInward : Bool -> Markup.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
attrInward =
    M3e.Html.Shared.inward


{-| The accessible label given to the item's internal button. (default: `""`)
-}
attrItemLabel : String -> Markup.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
attrItemLabel =
    M3e.Html.Shared.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
attrItemsPerPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
attrItemsPerPageLabel =
    M3e.Html.Shared.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
attrLabel : String -> Markup.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
attrLabel =
    M3e.Html.Shared.label


{-| Whether to show value labels when activated. (default: `false`)
-}
attrLabelled : Bool -> Markup.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
attrLabelled =
    M3e.Html.Shared.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
attrLastPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
attrLastPageLabel =
    M3e.Html.Shared.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
attrLength : Float -> Markup.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
attrLength =
    M3e.Html.Shared.length


{-| The accessibility level of the heading.
-}
attrLevel : Int -> Markup.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
attrLevel =
    M3e.Html.Shared.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
attrLinear : Bool -> Markup.Html.Attr.Attr { c | linear : M3e.Token.Supported } msg
attrLinear =
    M3e.Html.Shared.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
attrLoaded : Bool -> Markup.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
attrLoaded =
    M3e.Html.Shared.loaded


{-| Whether options are being loaded. (default: `false`)
-}
attrLoading : Bool -> Markup.Html.Attr.Attr { c | loading : M3e.Token.Supported } msg
attrLoading =
    M3e.Html.Shared.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
attrLoadingLabel :
    String
    -> Markup.Html.Attr.Attr { c | loadingLabel : M3e.Token.Supported } msg
attrLoadingLabel =
    M3e.Html.Shared.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`)
-}
attrLowered : Bool -> Markup.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
attrLowered =
    M3e.Html.Shared.lowered


{-| Exclude this heading from the table of contents generated by an `m3e-toc` component. `m3e-toc-ignore` is a valueless presence marker the `m3e-toc` reads from heading elements; it is not an `m3e-heading` CEM attribute, so it is injected here as a heading-scoped synthetic capability.
-}
attrTocIgnore : Bool -> Markup.Html.Attr.Attr { c | tocIgnore : M3e.Token.Supported } msg
attrTocIgnore =
    M3e.Html.Shared.tocIgnore


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
attrMax : Float -> Markup.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
attrMax =
    M3e.Html.Shared.max


{-| The maximum date that can be selected. (default: `null`)
-}
attrMaxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
attrMaxDate =
    M3e.Html.Shared.maxDate


{-| The maximum depth of the table of contents. (default: `2`)
-}
attrMaxDepth : Float -> Markup.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
attrMaxDepth =
    M3e.Html.Shared.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
attrMaxRows : Float -> Markup.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
attrMaxRows =
    M3e.Html.Shared.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
attrMin : Float -> Markup.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
attrMin =
    M3e.Html.Shared.min


{-| The minimum date that can be selected. (default: `null`)
-}
attrMinDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
attrMinDate =
    M3e.Html.Shared.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
attrMinRows : Float -> Markup.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
attrMinRows =
    M3e.Html.Shared.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
attrModal : Bool -> Markup.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
attrModal =
    M3e.Html.Shared.modal


{-| Whether multiple items can be selected. (default: `false`)
-}
attrMulti : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
attrMulti =
    M3e.Html.Shared.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
attrNextMonthLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
attrNextMonthLabel =
    M3e.Html.Shared.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
attrNextMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | nextMultiYearLabel : M3e.Token.Supported
            }
            msg
attrNextMultiYearLabel =
    M3e.Html.Shared.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
attrNextPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
attrNextPageLabel =
    M3e.Html.Shared.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
attrNextYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
attrNextYearLabel =
    M3e.Html.Shared.nextYearLabel


{-| Whether to disable animation. (default: `false`)
-}
attrNoAnimate : Bool -> Markup.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
attrNoAnimate =
    M3e.Html.Shared.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
attrNoDataLabel :
    String
    -> Markup.Html.Attr.Attr { c | noDataLabel : M3e.Token.Supported } msg
attrNoDataLabel =
    M3e.Html.Shared.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
attrNoFocusTrap : Bool -> Markup.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
attrNoFocusTrap =
    M3e.Html.Shared.noFocusTrap


{-| Whether the item is expanded. (default: `false`)
-}
attrOpen : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
attrOpen =
    M3e.Html.Shared.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
attrOpticalSize : Float -> Markup.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
attrOpticalSize =
    M3e.Html.Shared.opticalSize


{-| Whether the step is optional. (default: `false`)
-}
attrOptional : Bool -> Markup.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
attrOptional =
    M3e.Html.Shared.optional


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
attrOvershootLimit :
    Float
    -> Markup.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
attrOvershootLimit =
    M3e.Html.Shared.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
attrPageIndex : Float -> Markup.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
attrPageIndex =
    M3e.Html.Shared.pageIndex


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
attrPageSizes : String -> Markup.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
attrPageSizes =
    M3e.Html.Shared.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
attrPanelClass : String -> Markup.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
attrPanelClass =
    M3e.Html.Shared.panelClass


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
attrPreviousMonthLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMonthLabel : M3e.Token.Supported
            }
            msg
attrPreviousMonthLabel =
    M3e.Html.Shared.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
attrPreviousMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
attrPreviousMultiYearLabel =
    M3e.Html.Shared.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
attrPreviousPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
attrPreviousPageLabel =
    M3e.Html.Shared.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
attrPreviousYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
attrPreviousYearLabel =
    M3e.Html.Shared.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
attrRadius : Float -> Markup.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
attrRadius =
    M3e.Html.Shared.radius


{-| Whether a range of dates can be selected. (default: `false`)
-}
attrRange : Bool -> Markup.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
attrRange =
    M3e.Html.Shared.range


{-| End of a date range. (default: `null`)
-}
attrRangeEnd : String -> Markup.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
attrRangeEnd =
    M3e.Html.Shared.rangeEnd


{-| Start of a date range. (default: `null`)
-}
attrRangeStart : String -> Markup.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
attrRangeStart =
    M3e.Html.Shared.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
attrRel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
attrRel =
    M3e.Html.Shared.rel


{-| Whether the chip is removable. (default: `false`)
-}
attrRemovable : Bool -> Markup.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
attrRemovable =
    M3e.Html.Shared.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
attrRemoveLabel :
    String
    -> Markup.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
attrRemoveLabel =
    M3e.Html.Shared.removeLabel


{-| Whether the element is required. (default: `false`)
-}
attrRequired : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
attrRequired =
    M3e.Html.Shared.required


{-| The value to return from the dialog. (default: `""`)
-}
attrReturnValue :
    String
    -> Markup.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
attrReturnValue =
    M3e.Html.Shared.returnValue


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
attrSecondary : Bool -> Markup.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
attrSecondary =
    M3e.Html.Shared.secondary


{-| Whether the item is selected. (default: `false`)
-}
attrSelected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
attrSelected =
    M3e.Html.Shared.selected


{-| The zero-based index of the visible item. (default: `null`)
-}
attrSelectedIndex :
    Float
    -> Markup.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
attrSelectedIndex =
    M3e.Html.Shared.selectedIndex


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
attrShowDelay : Float -> Markup.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
attrShowDelay =
    M3e.Html.Shared.showDelay


{-| Whether to show first/last buttons. (default: `false`)
-}
attrShowFirstLastButtons :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | showFirstLastButtons : M3e.Token.Supported
            }
            msg
attrShowFirstLastButtons =
    M3e.Html.Shared.showFirstLastButtons


{-| Whether the start drawer is open. (default: `false`)
-}
attrStart : Bool -> Markup.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
attrStart =
    M3e.Html.Shared.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
attrStartAt : String -> Markup.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
attrStartAt =
    M3e.Html.Shared.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
attrStartDivider : Bool -> Markup.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
attrStartDivider =
    M3e.Html.Shared.startDivider


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
attrStep : Float -> Markup.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
attrStep =
    M3e.Html.Shared.step


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
attrStretch : Bool -> Markup.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
attrStretch =
    M3e.Html.Shared.stretch


{-| Whether to enable strong focus indicators. (default: `false`)
-}
attrStrongFocus : Bool -> Markup.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
attrStrongFocus =
    M3e.Html.Shared.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
attrSubmenu : Bool -> Markup.Html.Attr.Attr { c | submenu : M3e.Token.Supported } msg
attrSubmenu =
    M3e.Html.Shared.submenu


{-| The target of the link button. (default: `""`)
-}
attrTarget : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
attrTarget =
    M3e.Html.Shared.target


{-| The search term to highlight. (default: `""`)
-}
attrTerm : String -> Markup.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
attrTerm =
    M3e.Html.Shared.term


{-| Whether to present thin scrollbars. (default: `false`)
-}
attrThin : Bool -> Markup.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
attrThin =
    M3e.Html.Shared.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
attrThreshold : Float -> Markup.Html.Attr.Attr { c | threshold : M3e.Token.Supported } msg
attrThreshold =
    M3e.Html.Shared.threshold


{-| Today's date. (default: `new Date()`)
-}
attrToday : String -> Markup.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
attrToday =
    M3e.Html.Shared.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
attrToggle : Bool -> Markup.Html.Attr.Attr { c | toggle : M3e.Token.Supported } msg
attrToggle =
    M3e.Html.Shared.toggle


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
attrUnbounded : Bool -> Markup.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
attrUnbounded =
    M3e.Html.Shared.unbounded


{-| Whether the element is oriented vertically. (default: `false`)
-}
attrVertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
attrVertical =
    M3e.Html.Shared.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
attrWeight : Int -> Markup.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
attrWeight =
    M3e.Html.Shared.weight


{-| Whether items wrap to a new line. (default: `false`)
-}
attrWrap : Bool -> Markup.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
attrWrap =
    M3e.Html.Shared.wrap


{-| Whether cycling through detents will wrap. (default: `false`)
-}
attrWrapDetents : Bool -> Markup.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
attrWrapDetents =
    M3e.Html.Shared.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
attrName : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
attrName =
    M3e.Html.Shared.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
attrValueFloat : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
attrValueFloat =
    M3e.Html.Shared.valueFloat


{-| A string representing the value of the switch. (default: `"on"`)
-}
attrValue : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
attrValue =
    M3e.Html.Shared.value


{-| Set `animation="none"`. See `M3e.Html.Shared.animation`.
-}
animationNone : Markup.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationNone =
    M3e.Html.Shared.animation M3e.Token.none


{-| Set `animation="pulse"`. See `M3e.Html.Shared.animation`.
-}
animationPulse : Markup.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationPulse =
    M3e.Html.Shared.animation M3e.Token.pulse


{-| Set `animation="wave"`. See `M3e.Html.Shared.animation`.
-}
animationWave : Markup.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationWave =
    M3e.Html.Shared.animation M3e.Token.wave


{-| Set `contrast="high"`. See `M3e.Html.Shared.contrast`.
-}
contrastHigh : Markup.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastHigh =
    M3e.Html.Shared.contrast M3e.Token.high


{-| Set `contrast="medium"`. See `M3e.Html.Shared.contrast`.
-}
contrastMedium : Markup.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastMedium =
    M3e.Html.Shared.contrast M3e.Token.medium


{-| Set `contrast="standard"`. See `M3e.Html.Shared.contrast`.
-}
contrastStandard : Markup.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastStandard =
    M3e.Html.Shared.contrast M3e.Token.standard


{-| Set `current="date"`. See `M3e.Html.Shared.current`.
-}
currentDate : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentDate =
    M3e.Html.Shared.current M3e.Token.date


{-| Set `current="location"`. See `M3e.Html.Shared.current`.
-}
currentLocation : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentLocation =
    M3e.Html.Shared.current M3e.Token.location


{-| Set `current="page"`. See `M3e.Html.Shared.current`.
-}
currentPage : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentPage =
    M3e.Html.Shared.current M3e.Token.page


{-| Set `current="step"`. See `M3e.Html.Shared.current`.
-}
currentStep : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentStep =
    M3e.Html.Shared.current M3e.Token.step


{-| Set `current="time"`. See `M3e.Html.Shared.current`.
-}
currentTime : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentTime =
    M3e.Html.Shared.current M3e.Token.time


{-| Set `current="true"`. See `M3e.Html.Shared.current`.
-}
currentTrue : Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentTrue =
    M3e.Html.Shared.current M3e.Token.true


{-| Set `disable-pagination="true"`. See `M3e.Html.Shared.disablePagination`.
-}
disablePaginationTrue : Markup.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationTrue =
    M3e.Html.Shared.disablePagination M3e.Token.true


{-| Set `disable-pagination="false"`. See `M3e.Html.Shared.disablePagination`.
-}
disablePaginationFalse : Markup.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationFalse =
    M3e.Html.Shared.disablePagination M3e.Token.false


{-| Set `disable-pagination="auto"`. See `M3e.Html.Shared.disablePagination`.
-}
disablePaginationAuto : Markup.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationAuto =
    M3e.Html.Shared.disablePagination M3e.Token.auto


{-| Set `dividers="above"`. See `M3e.Html.Shared.dividers`.
-}
dividersAbove : Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersAbove =
    M3e.Html.Shared.dividers M3e.Token.above


{-| Set `dividers="aboveBelow"`. See `M3e.Html.Shared.dividers`.
-}
dividersAboveBelow : Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersAboveBelow =
    M3e.Html.Shared.dividers M3e.Token.aboveBelow


{-| Set `dividers="below"`. See `M3e.Html.Shared.dividers`.
-}
dividersBelow : Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersBelow =
    M3e.Html.Shared.dividers M3e.Token.below


{-| Set `dividers="none"`. See `M3e.Html.Shared.dividers`.
-}
dividersNone : Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersNone =
    M3e.Html.Shared.dividers M3e.Token.none


{-| Set `end-mode="auto"`. See `M3e.Html.Shared.endMode`.
-}
endModeAuto : Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeAuto =
    M3e.Html.Shared.endMode M3e.Token.auto


{-| Set `end-mode="over"`. See `M3e.Html.Shared.endMode`.
-}
endModeOver : Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeOver =
    M3e.Html.Shared.endMode M3e.Token.over


{-| Set `end-mode="push"`. See `M3e.Html.Shared.endMode`.
-}
endModePush : Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModePush =
    M3e.Html.Shared.endMode M3e.Token.push


{-| Set `end-mode="side"`. See `M3e.Html.Shared.endMode`.
-}
endModeSide : Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeSide =
    M3e.Html.Shared.endMode M3e.Token.side


{-| Set `filter="contains"`. See `M3e.Html.Shared.filter`.
-}
filterContains : Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterContains =
    M3e.Html.Shared.filter M3e.Token.contains


{-| Set `filter="endsWith"`. See `M3e.Html.Shared.filter`.
-}
filterEndsWith : Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterEndsWith =
    M3e.Html.Shared.filter M3e.Token.endsWith


{-| Set `filter="none"`. See `M3e.Html.Shared.filter`.
-}
filterNone : Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterNone =
    M3e.Html.Shared.filter M3e.Token.none


{-| Set `filter="startsWith"`. See `M3e.Html.Shared.filter`.
-}
filterStartsWith : Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterStartsWith =
    M3e.Html.Shared.filter M3e.Token.startsWith


{-| Set `float-label="always"`. See `M3e.Html.Shared.floatLabel`.
-}
floatLabelAlways : Markup.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabelAlways =
    M3e.Html.Shared.floatLabel M3e.Token.always


{-| Set `float-label="auto"`. See `M3e.Html.Shared.floatLabel`.
-}
floatLabelAuto : Markup.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabelAuto =
    M3e.Html.Shared.floatLabel M3e.Token.auto


{-| Set `grade="high"`. See `M3e.Html.Shared.grade`.
-}
gradeHigh : Markup.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeHigh =
    M3e.Html.Shared.grade M3e.Token.high


{-| Set `grade="low"`. See `M3e.Html.Shared.grade`.
-}
gradeLow : Markup.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeLow =
    M3e.Html.Shared.grade M3e.Token.low


{-| Set `grade="medium"`. See `M3e.Html.Shared.grade`.
-}
gradeMedium : Markup.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeMedium =
    M3e.Html.Shared.grade M3e.Token.medium


{-| Set `header-position="after"`. See `M3e.Html.Shared.headerPosition`.
-}
headerPositionAfter : Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionAfter =
    M3e.Html.Shared.headerPosition M3e.Token.after


{-| Set `header-position="before"`. See `M3e.Html.Shared.headerPosition`.
-}
headerPositionBefore : Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionBefore =
    M3e.Html.Shared.headerPosition M3e.Token.before


{-| Set `header-position="above"`. See `M3e.Html.Shared.headerPosition`.
-}
headerPositionAbove : Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionAbove =
    M3e.Html.Shared.headerPosition M3e.Token.above


{-| Set `header-position="below"`. See `M3e.Html.Shared.headerPosition`.
-}
headerPositionBelow : Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionBelow =
    M3e.Html.Shared.headerPosition M3e.Token.below


{-| Set `hide-subscript="always"`. See `M3e.Html.Shared.hideSubscript`.
-}
hideSubscriptAlways : Markup.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptAlways =
    M3e.Html.Shared.hideSubscript M3e.Token.always


{-| Set `hide-subscript="auto"`. See `M3e.Html.Shared.hideSubscript`.
-}
hideSubscriptAuto : Markup.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptAuto =
    M3e.Html.Shared.hideSubscript M3e.Token.auto


{-| Set `hide-subscript="never"`. See `M3e.Html.Shared.hideSubscript`.
-}
hideSubscriptNever : Markup.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptNever =
    M3e.Html.Shared.hideSubscript M3e.Token.never


{-| Set `highlight-mode="contains"`. See `M3e.Html.Shared.highlightMode`.
-}
highlightModeContains : Markup.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeContains =
    M3e.Html.Shared.highlightMode M3e.Token.contains


{-| Set `highlight-mode="endsWith"`. See `M3e.Html.Shared.highlightMode`.
-}
highlightModeEndsWith : Markup.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeEndsWith =
    M3e.Html.Shared.highlightMode M3e.Token.endsWith


{-| Set `highlight-mode="startsWith"`. See `M3e.Html.Shared.highlightMode`.
-}
highlightModeStartsWith : Markup.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeStartsWith =
    M3e.Html.Shared.highlightMode M3e.Token.startsWith


{-| Set `icons="both"`. See `M3e.Html.Shared.icons`.
-}
iconsBoth : Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsBoth =
    M3e.Html.Shared.icons M3e.Token.both


{-| Set `icons="none"`. See `M3e.Html.Shared.icons`.
-}
iconsNone : Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsNone =
    M3e.Html.Shared.icons M3e.Token.none


{-| Set `icons="selected"`. See `M3e.Html.Shared.icons`.
-}
iconsSelected : Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsSelected =
    M3e.Html.Shared.icons M3e.Token.selected


{-| Set `label-position="below"`. See `M3e.Html.Shared.labelPosition`.
-}
labelPositionBelow : Markup.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPositionBelow =
    M3e.Html.Shared.labelPosition M3e.Token.below


{-| Set `label-position="end"`. See `M3e.Html.Shared.labelPosition`.
-}
labelPositionEnd : Markup.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPositionEnd =
    M3e.Html.Shared.labelPosition M3e.Token.end


{-| Set `mode="auto"`. See `M3e.Html.Shared.mode`.
-}
modeAuto : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeAuto =
    M3e.Html.Shared.mode M3e.Token.auto


{-| Set `mode="docked"`. See `M3e.Html.Shared.mode`.
-}
modeDocked : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeDocked =
    M3e.Html.Shared.mode M3e.Token.docked


{-| Set `mode="fullscreen"`. See `M3e.Html.Shared.mode`.
-}
modeFullscreen : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeFullscreen =
    M3e.Html.Shared.mode M3e.Token.fullscreen


{-| Set `mode="buffer"`. See `M3e.Html.Shared.mode`.
-}
modeBuffer : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeBuffer =
    M3e.Html.Shared.mode M3e.Token.buffer


{-| Set `mode="determinate"`. See `M3e.Html.Shared.mode`.
-}
modeDeterminate : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeDeterminate =
    M3e.Html.Shared.mode M3e.Token.determinate


{-| Set `mode="indeterminate"`. See `M3e.Html.Shared.mode`.
-}
modeIndeterminate : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeIndeterminate =
    M3e.Html.Shared.mode M3e.Token.indeterminate


{-| Set `mode="query"`. See `M3e.Html.Shared.mode`.
-}
modeQuery : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeQuery =
    M3e.Html.Shared.mode M3e.Token.query


{-| Set `mode="compact"`. See `M3e.Html.Shared.mode`.
-}
modeCompact : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeCompact =
    M3e.Html.Shared.mode M3e.Token.compact


{-| Set `mode="expanded"`. See `M3e.Html.Shared.mode`.
-}
modeExpanded : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeExpanded =
    M3e.Html.Shared.mode M3e.Token.expanded


{-| Set `mode="contains"`. See `M3e.Html.Shared.mode`.
-}
modeContains : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeContains =
    M3e.Html.Shared.mode M3e.Token.contains


{-| Set `mode="endsWith"`. See `M3e.Html.Shared.mode`.
-}
modeEndsWith : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeEndsWith =
    M3e.Html.Shared.mode M3e.Token.endsWith


{-| Set `mode="startsWith"`. See `M3e.Html.Shared.mode`.
-}
modeStartsWith : Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeStartsWith =
    M3e.Html.Shared.mode M3e.Token.startsWith


{-| Set `motion="expressive"`. See `M3e.Html.Shared.motion`.
-}
motionExpressive : Markup.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motionExpressive =
    M3e.Html.Shared.motion M3e.Token.expressive


{-| Set `motion="standard"`. See `M3e.Html.Shared.motion`.
-}
motionStandard : Markup.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motionStandard =
    M3e.Html.Shared.motion M3e.Token.standard


{-| Set `orientation="auto"`. See `M3e.Html.Shared.orientation`.
-}
orientationAuto : Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationAuto =
    M3e.Html.Shared.orientation M3e.Token.auto


{-| Set `orientation="horizontal"`. See `M3e.Html.Shared.orientation`.
-}
orientationHorizontal : Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationHorizontal =
    M3e.Html.Shared.orientation M3e.Token.horizontal


{-| Set `orientation="vertical"`. See `M3e.Html.Shared.orientation`.
-}
orientationVertical : Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationVertical =
    M3e.Html.Shared.orientation M3e.Token.vertical


{-| Set `page-size="all"`. See `M3e.Html.Shared.pageSize`.
-}
pageSizeAll : Markup.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSizeAll =
    M3e.Html.Shared.pageSize M3e.Token.all


{-| Set `page-size-variant="filled"`. See `M3e.Html.Shared.pageSizeVariant`.
-}
pageSizeVariantFilled : Markup.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariantFilled =
    M3e.Html.Shared.pageSizeVariant M3e.Token.filled


{-| Set `page-size-variant="outlined"`. See `M3e.Html.Shared.pageSizeVariant`.
-}
pageSizeVariantOutlined : Markup.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariantOutlined =
    M3e.Html.Shared.pageSizeVariant M3e.Token.outlined


{-| Set `position="above"`. See `M3e.Html.Shared.position`.
-}
positionAbove : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAbove =
    M3e.Html.Shared.position M3e.Token.above


{-| Set `position="after"`. See `M3e.Html.Shared.position`.
-}
positionAfter : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAfter =
    M3e.Html.Shared.position M3e.Token.after


{-| Set `position="before"`. See `M3e.Html.Shared.position`.
-}
positionBefore : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBefore =
    M3e.Html.Shared.position M3e.Token.before


{-| Set `position="below"`. See `M3e.Html.Shared.position`.
-}
positionBelow : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelow =
    M3e.Html.Shared.position M3e.Token.below


{-| Set `position="aboveAfter"`. See `M3e.Html.Shared.position`.
-}
positionAboveAfter : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAboveAfter =
    M3e.Html.Shared.position M3e.Token.aboveAfter


{-| Set `position="aboveBefore"`. See `M3e.Html.Shared.position`.
-}
positionAboveBefore : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAboveBefore =
    M3e.Html.Shared.position M3e.Token.aboveBefore


{-| Set `position="belowAfter"`. See `M3e.Html.Shared.position`.
-}
positionBelowAfter : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelowAfter =
    M3e.Html.Shared.position M3e.Token.belowAfter


{-| Set `position="belowBefore"`. See `M3e.Html.Shared.position`.
-}
positionBelowBefore : Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelowBefore =
    M3e.Html.Shared.position M3e.Token.belowBefore


{-| Set `position-x="after"`. See `M3e.Html.Shared.positionX`.
-}
positionXAfter : Markup.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionXAfter =
    M3e.Html.Shared.positionX M3e.Token.after


{-| Set `position-x="before"`. See `M3e.Html.Shared.positionX`.
-}
positionXBefore : Markup.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionXBefore =
    M3e.Html.Shared.positionX M3e.Token.before


{-| Set `position-y="above"`. See `M3e.Html.Shared.positionY`.
-}
positionYAbove : Markup.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionYAbove =
    M3e.Html.Shared.positionY M3e.Token.above


{-| Set `position-y="below"`. See `M3e.Html.Shared.positionY`.
-}
positionYBelow : Markup.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionYBelow =
    M3e.Html.Shared.positionY M3e.Token.below


{-| Set `scheme="auto"`. See `M3e.Html.Shared.scheme`.
-}
schemeAuto : Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeAuto =
    M3e.Html.Shared.scheme M3e.Token.auto


{-| Set `scheme="dark"`. See `M3e.Html.Shared.scheme`.
-}
schemeDark : Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeDark =
    M3e.Html.Shared.scheme M3e.Token.dark


{-| Set `scheme="light"`. See `M3e.Html.Shared.scheme`.
-}
schemeLight : Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeLight =
    M3e.Html.Shared.scheme M3e.Token.light


{-| Set `scroll-strategy="hide"`. See `M3e.Html.Shared.scrollStrategy`.
-}
scrollStrategyHide : Markup.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategyHide =
    M3e.Html.Shared.scrollStrategy M3e.Token.hide


{-| Set `scroll-strategy="reposition"`. See `M3e.Html.Shared.scrollStrategy`.
-}
scrollStrategyReposition : Markup.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategyReposition =
    M3e.Html.Shared.scrollStrategy M3e.Token.reposition


{-| Set `shape="rounded"`. See `M3e.Html.Shared.shape`.
-}
shapeRounded : Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeRounded =
    M3e.Html.Shared.shape M3e.Token.rounded


{-| Set `shape="square"`. See `M3e.Html.Shared.shape`.
-}
shapeSquare : Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeSquare =
    M3e.Html.Shared.shape M3e.Token.square


{-| Set `shape="auto"`. See `M3e.Html.Shared.shape`.
-}
shapeAuto : Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeAuto =
    M3e.Html.Shared.shape M3e.Token.auto


{-| Set `shape="circular"`. See `M3e.Html.Shared.shape`.
-}
shapeCircular : Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeCircular =
    M3e.Html.Shared.shape M3e.Token.circular


{-| Set `size="extraLarge"`. See `M3e.Html.Shared.size`.
-}
sizeExtraLarge : Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeExtraLarge =
    M3e.Html.Shared.size M3e.Token.extraLarge


{-| Set `size="extraSmall"`. See `M3e.Html.Shared.size`.
-}
sizeExtraSmall : Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeExtraSmall =
    M3e.Html.Shared.size M3e.Token.extraSmall


{-| Set `size="large"`. See `M3e.Html.Shared.size`.
-}
sizeLarge : Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeLarge =
    M3e.Html.Shared.size M3e.Token.large


{-| Set `size="medium"`. See `M3e.Html.Shared.size`.
-}
sizeMedium : Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeMedium =
    M3e.Html.Shared.size M3e.Token.medium


{-| Set `size="small"`. See `M3e.Html.Shared.size`.
-}
sizeSmall : Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeSmall =
    M3e.Html.Shared.size M3e.Token.small


{-| Set `start-mode="auto"`. See `M3e.Html.Shared.startMode`.
-}
startModeAuto : Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeAuto =
    M3e.Html.Shared.startMode M3e.Token.auto


{-| Set `start-mode="over"`. See `M3e.Html.Shared.startMode`.
-}
startModeOver : Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeOver =
    M3e.Html.Shared.startMode M3e.Token.over


{-| Set `start-mode="push"`. See `M3e.Html.Shared.startMode`.
-}
startModePush : Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModePush =
    M3e.Html.Shared.startMode M3e.Token.push


{-| Set `start-mode="side"`. See `M3e.Html.Shared.startMode`.
-}
startModeSide : Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeSide =
    M3e.Html.Shared.startMode M3e.Token.side


{-| Set `start-view="month"`. See `M3e.Html.Shared.startView`.
-}
startViewMonth : Markup.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewMonth =
    M3e.Html.Shared.startView M3e.Token.month


{-| Set `start-view="multiYear"`. See `M3e.Html.Shared.startView`.
-}
startViewMultiYear : Markup.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewMultiYear =
    M3e.Html.Shared.startView M3e.Token.multiYear


{-| Set `start-view="year"`. See `M3e.Html.Shared.startView`.
-}
startViewYear : Markup.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewYear =
    M3e.Html.Shared.startView M3e.Token.year


{-| Set `state="content"`. See `M3e.Html.Shared.state`.
-}
stateContent : Markup.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateContent =
    M3e.Html.Shared.state M3e.Token.content


{-| Set `state="loading"`. See `M3e.Html.Shared.state`.
-}
stateLoading : Markup.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateLoading =
    M3e.Html.Shared.state M3e.Token.loading


{-| Set `state="noData"`. See `M3e.Html.Shared.state`.
-}
stateNoData : Markup.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateNoData =
    M3e.Html.Shared.state M3e.Token.noData


{-| Set `toggle-direction="horizontal"`. See `M3e.Html.Shared.toggleDirection`.
-}
toggleDirectionHorizontal : Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirectionHorizontal =
    M3e.Html.Shared.toggleDirection M3e.Token.horizontal


{-| Set `toggle-direction="vertical"`. See `M3e.Html.Shared.toggleDirection`.
-}
toggleDirectionVertical : Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirectionVertical =
    M3e.Html.Shared.toggleDirection M3e.Token.vertical


{-| Set `toggle-position="after"`. See `M3e.Html.Shared.togglePosition`.
-}
togglePositionAfter : Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePositionAfter =
    M3e.Html.Shared.togglePosition M3e.Token.after


{-| Set `toggle-position="before"`. See `M3e.Html.Shared.togglePosition`.
-}
togglePositionBefore : Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePositionBefore =
    M3e.Html.Shared.togglePosition M3e.Token.before


{-| Set `touch-gestures="auto"`. See `M3e.Html.Shared.touchGestures`.
-}
touchGesturesAuto : Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesAuto =
    M3e.Html.Shared.touchGestures M3e.Token.auto


{-| Set `touch-gestures="off"`. See `M3e.Html.Shared.touchGestures`.
-}
touchGesturesOff : Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesOff =
    M3e.Html.Shared.touchGestures M3e.Token.off


{-| Set `touch-gestures="on"`. See `M3e.Html.Shared.touchGestures`.
-}
touchGesturesOn : Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesOn =
    M3e.Html.Shared.touchGestures M3e.Token.on


{-| Set `type="button"`. See `M3e.Html.Shared.type`.
-}
typeButton : Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeButton =
    M3e.Html.Shared.type_ M3e.Token.button


{-| Set `type="reset"`. See `M3e.Html.Shared.type`.
-}
typeReset : Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeReset =
    M3e.Html.Shared.type_ M3e.Token.reset


{-| Set `type="submit"`. See `M3e.Html.Shared.type`.
-}
typeSubmit : Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeSubmit =
    M3e.Html.Shared.type_ M3e.Token.submit


{-| Set `variant="standard"`. See `M3e.Html.Shared.variant`.
-}
variantStandard : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantStandard =
    M3e.Html.Shared.variant M3e.Token.standard


{-| Set `variant="vibrant"`. See `M3e.Html.Shared.variant`.
-}
variantVibrant : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantVibrant =
    M3e.Html.Shared.variant M3e.Token.vibrant


{-| Set `variant="content"`. See `M3e.Html.Shared.variant`.
-}
variantContent : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantContent =
    M3e.Html.Shared.variant M3e.Token.content


{-| Set `variant="expressive"`. See `M3e.Html.Shared.variant`.
-}
variantExpressive : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantExpressive =
    M3e.Html.Shared.variant M3e.Token.expressive


{-| Set `variant="fidelity"`. See `M3e.Html.Shared.variant`.
-}
variantFidelity : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFidelity =
    M3e.Html.Shared.variant M3e.Token.fidelity


{-| Set `variant="fruitSalad"`. See `M3e.Html.Shared.variant`.
-}
variantFruitSalad : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFruitSalad =
    M3e.Html.Shared.variant M3e.Token.fruitSalad


{-| Set `variant="monochrome"`. See `M3e.Html.Shared.variant`.
-}
variantMonochrome : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantMonochrome =
    M3e.Html.Shared.variant M3e.Token.monochrome


{-| Set `variant="neutral"`. See `M3e.Html.Shared.variant`.
-}
variantNeutral : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantNeutral =
    M3e.Html.Shared.variant M3e.Token.neutral


{-| Set `variant="rainbow"`. See `M3e.Html.Shared.variant`.
-}
variantRainbow : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantRainbow =
    M3e.Html.Shared.variant M3e.Token.rainbow


{-| Set `variant="tonalSpot"`. See `M3e.Html.Shared.variant`.
-}
variantTonalSpot : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTonalSpot =
    M3e.Html.Shared.variant M3e.Token.tonalSpot


{-| Set `variant="primary"`. See `M3e.Html.Shared.variant`.
-}
variantPrimary : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantPrimary =
    M3e.Html.Shared.variant M3e.Token.primary


{-| Set `variant="secondary"`. See `M3e.Html.Shared.variant`.
-}
variantSecondary : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSecondary =
    M3e.Html.Shared.variant M3e.Token.secondary


{-| Set `variant="elevated"`. See `M3e.Html.Shared.variant`.
-}
variantElevated : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantElevated =
    M3e.Html.Shared.variant M3e.Token.elevated


{-| Set `variant="filled"`. See `M3e.Html.Shared.variant`.
-}
variantFilled : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFilled =
    M3e.Html.Shared.variant M3e.Token.filled


{-| Set `variant="outlined"`. See `M3e.Html.Shared.variant`.
-}
variantOutlined : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantOutlined =
    M3e.Html.Shared.variant M3e.Token.outlined


{-| Set `variant="tonal"`. See `M3e.Html.Shared.variant`.
-}
variantTonal : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTonal =
    M3e.Html.Shared.variant M3e.Token.tonal


{-| Set `variant="flat"`. See `M3e.Html.Shared.variant`.
-}
variantFlat : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFlat =
    M3e.Html.Shared.variant M3e.Token.flat


{-| Set `variant="wavy"`. See `M3e.Html.Shared.variant`.
-}
variantWavy : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantWavy =
    M3e.Html.Shared.variant M3e.Token.wavy


{-| Set `variant="contained"`. See `M3e.Html.Shared.variant`.
-}
variantContained : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantContained =
    M3e.Html.Shared.variant M3e.Token.contained


{-| Set `variant="uncontained"`. See `M3e.Html.Shared.variant`.
-}
variantUncontained : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantUncontained =
    M3e.Html.Shared.variant M3e.Token.uncontained


{-| Set `variant="segmented"`. See `M3e.Html.Shared.variant`.
-}
variantSegmented : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSegmented =
    M3e.Html.Shared.variant M3e.Token.segmented


{-| Set `variant="rounded"`. See `M3e.Html.Shared.variant`.
-}
variantRounded : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantRounded =
    M3e.Html.Shared.variant M3e.Token.rounded


{-| Set `variant="sharp"`. See `M3e.Html.Shared.variant`.
-}
variantSharp : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSharp =
    M3e.Html.Shared.variant M3e.Token.sharp


{-| Set `variant="display"`. See `M3e.Html.Shared.variant`.
-}
variantDisplay : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantDisplay =
    M3e.Html.Shared.variant M3e.Token.display


{-| Set `variant="headline"`. See `M3e.Html.Shared.variant`.
-}
variantHeadline : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantHeadline =
    M3e.Html.Shared.variant M3e.Token.headline


{-| Set `variant="label"`. See `M3e.Html.Shared.variant`.
-}
variantLabel : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantLabel =
    M3e.Html.Shared.variant M3e.Token.label


{-| Set `variant="title"`. See `M3e.Html.Shared.variant`.
-}
variantTitle : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTitle =
    M3e.Html.Shared.variant M3e.Token.title


{-| Set `variant="tertiary"`. See `M3e.Html.Shared.variant`.
-}
variantTertiary : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTertiary =
    M3e.Html.Shared.variant M3e.Token.tertiary


{-| Set `variant="primaryContainer"`. See `M3e.Html.Shared.variant`.
-}
variantPrimaryContainer : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantPrimaryContainer =
    M3e.Html.Shared.variant M3e.Token.primaryContainer


{-| Set `variant="secondaryContainer"`. See `M3e.Html.Shared.variant`.
-}
variantSecondaryContainer : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSecondaryContainer =
    M3e.Html.Shared.variant M3e.Token.secondaryContainer


{-| Set `variant="surface"`. See `M3e.Html.Shared.variant`.
-}
variantSurface : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSurface =
    M3e.Html.Shared.variant M3e.Token.surface


{-| Set `variant="tertiaryContainer"`. See `M3e.Html.Shared.variant`.
-}
variantTertiaryContainer : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTertiaryContainer =
    M3e.Html.Shared.variant M3e.Token.tertiaryContainer


{-| Set `variant="auto"`. See `M3e.Html.Shared.variant`.
-}
variantAuto : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantAuto =
    M3e.Html.Shared.variant M3e.Token.auto


{-| Set `variant="docked"`. See `M3e.Html.Shared.variant`.
-}
variantDocked : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantDocked =
    M3e.Html.Shared.variant M3e.Token.docked


{-| Set `variant="modal"`. See `M3e.Html.Shared.variant`.
-}
variantModal : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantModal =
    M3e.Html.Shared.variant M3e.Token.modal


{-| Set `variant="connected"`. See `M3e.Html.Shared.variant`.
-}
variantConnected : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantConnected =
    M3e.Html.Shared.variant M3e.Token.connected


{-| Set `variant="text"`. See `M3e.Html.Shared.variant`.
-}
variantText : Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantText =
    M3e.Html.Shared.variant M3e.Token.text


{-| Set `width="default"`. See `M3e.Html.Shared.width`.
-}
widthDefault : Markup.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthDefault =
    M3e.Html.Shared.width M3e.Token.default


{-| Set `width="narrow"`. See `M3e.Html.Shared.width`.
-}
widthNarrow : Markup.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthNarrow =
    M3e.Html.Shared.width M3e.Token.narrow


{-| Set `width="wide"`. See `M3e.Html.Shared.width`.
-}
widthWide : Markup.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthWide =
    M3e.Html.Shared.width M3e.Token.wide


{-| Set `aria-label` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaLabel : String -> Markup.Html.Attr.Attr capability msg
ariaLabel =
    Markup.Aria.label


{-| Set `aria-labelledby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaLabelledby : String -> Markup.Html.Attr.Attr capability msg
ariaLabelledby =
    Markup.Aria.labelledby


{-| Set `aria-describedby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaDescribedby : String -> Markup.Html.Attr.Attr capability msg
ariaDescribedby =
    Markup.Aria.describedby


{-| Set `aria-hidden` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaHidden : String -> Markup.Html.Attr.Attr capability msg
ariaHidden =
    Markup.Aria.hidden


{-| Set the `id` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
id : String -> Markup.Html.Attr.Attr capability msg
id =
    Markup.Attributes.id


{-| Set the `for` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
for : String -> Markup.Html.Attr.Attr capability msg
for =
    Markup.Attributes.for


{-| Set the `class` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
class : String -> Markup.Html.Attr.Attr capability msg
class =
    Markup.Attributes.class


{-| Set the `style` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
style : List ( String, String ) -> Markup.Html.Attr.Attr capability msg
style =
    Markup.Attributes.style


{-| Listen for `change` events.
-}
onChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Shared.onChange


{-| Listen for `opening` events.
-}
onOpening :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.Shared.onOpening


{-| Listen for `opened` events.
-}
onOpened :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.Shared.onOpened


{-| Listen for `closing` events.
-}
onClosing :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.Shared.onClosing


{-| Listen for `closed` events.
-}
onClosed :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.Shared.onClosed


{-| Listen for `click` events.
-}
onClick :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Shared.onClick


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Shared.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Shared.onInput


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Shared.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Shared.onToggle


{-| Listen for `value-change` events.
-}
onValueChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    M3e.Html.Shared.onValueChange


{-| Listen for `query` events.
-}
onQuery :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    M3e.Html.Shared.onQuery


{-| Listen for `clear` events.
-}
onClear :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.Shared.onClear


{-| Listen for `page` events.
-}
onPage :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage =
    M3e.Html.Shared.onPage


{-| Listen for `cancel` events.
-}
onCancel :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    M3e.Html.Shared.onCancel


{-| Listen for `remove` events.
-}
onRemove :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove =
    M3e.Html.Shared.onRemove


{-| Listen for `invalid` events.
-}
onInvalid :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid =
    M3e.Html.Shared.onInvalid


{-| Listen for `active-change` events.
-}
onActiveChange :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange =
    M3e.Html.Shared.onActiveChange


{-| Listen for `highlight` events.
-}
onHighlight :
    Json.Decode.Decoder msg
    -> Markup.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight =
    M3e.Html.Shared.onHighlight


{-| Place content in the `leading` slot. See `M3e.Html.Shared.slotLeading`.
-}
slotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , text : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        , avatar : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotLeading =
    M3e.Html.Shared.slotLeading


{-| Place content in the `title` slot. See `M3e.Html.Shared.slotTitle`.
-}
slotTitle :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotTitle =
    M3e.Html.Shared.slotTitle


{-| Place content in the `subtitle` slot. See `M3e.Html.Shared.slotSubtitle`.
-}
slotSubtitle :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotSubtitle =
    M3e.Html.Shared.slotSubtitle


{-| Place content in the `trailing` slot. See `M3e.Html.Shared.slotTrailing`.
-}
slotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , text : Markup.Kind.Shared
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
    M3e.Html.Shared.slotTrailing


{-| Place content in the `leading-icon` slot. See `M3e.Html.Shared.slotLeadingIcon`.
-}
slotLeadingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLeadingIcon =
    M3e.Html.Shared.slotLeadingIcon


{-| Place content in the `trailing-icon` slot. See `M3e.Html.Shared.slotTrailingIcon`.
-}
slotTrailingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotTrailingIcon =
    M3e.Html.Shared.slotTrailingIcon


{-| Place content in the `icon` slot. See `M3e.Html.Shared.slotIcon`.
-}
slotIcon :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , loadingIndicator : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotIcon =
    M3e.Html.Shared.slotIcon


{-| Place content in the `loading` slot. See `M3e.Html.Shared.slotLoading`.
-}
slotLoading : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLoading =
    M3e.Html.Shared.slotLoading


{-| Place content in the `no-data` slot. See `M3e.Html.Shared.slotNoData`.
-}
slotNoData : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotNoData =
    M3e.Html.Shared.slotNoData


{-| Place content in the `header` slot. See `M3e.Html.Shared.slotHeader`.
-}
slotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotHeader =
    M3e.Html.Shared.slotHeader


{-| Place content in the `separator` slot. See `M3e.Html.Shared.slotSeparator`.
-}
slotSeparator : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSeparator =
    M3e.Html.Shared.slotSeparator


{-| Place content in the `selected` slot. See `M3e.Html.Shared.slotSelected`.
-}
slotSelected :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , icon : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
slotSelected =
    M3e.Html.Shared.slotSelected


{-| Place content in the `selected-icon` slot. See `M3e.Html.Shared.slotSelectedIcon`.
-}
slotSelectedIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSelectedIcon =
    M3e.Html.Shared.slotSelectedIcon


{-| Place content in the `content` slot. See `M3e.Html.Shared.slotContent`.
-}
slotContent : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotContent =
    M3e.Html.Shared.slotContent


{-| Place content in the `actions` slot. See `M3e.Html.Shared.slotActions`.
-}
slotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotActions =
    M3e.Html.Shared.slotActions


{-| Place content in the `footer` slot. See `M3e.Html.Shared.slotFooter`.
-}
slotFooter : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotFooter =
    M3e.Html.Shared.slotFooter


{-| Place content in the `close-icon` slot. See `M3e.Html.Shared.slotCloseIcon`.
-}
slotCloseIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotCloseIcon =
    M3e.Html.Shared.slotCloseIcon


{-| Place content in the `start` slot. See `M3e.Html.Shared.slotStart`.
-}
slotStart : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotStart =
    M3e.Html.Shared.slotStart


{-| Place content in the `end` slot. See `M3e.Html.Shared.slotEnd`.
-}
slotEnd : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotEnd =
    M3e.Html.Shared.slotEnd


{-| Place content in the `overline` slot. See `M3e.Html.Shared.slotOverline`.
-}
slotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOverline =
    M3e.Html.Shared.slotOverline


{-| Place content in the `supporting-text` slot. See `M3e.Html.Shared.slotSupportingText`.
-}
slotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotSupportingText =
    M3e.Html.Shared.slotSupportingText


{-| Place content in the `toggle-icon` slot. See `M3e.Html.Shared.slotToggleIcon`.
-}
slotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotToggleIcon =
    M3e.Html.Shared.slotToggleIcon


{-| Place content in the `items` slot. See `M3e.Html.Shared.slotItems`.
-}
slotItems : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotItems =
    M3e.Html.Shared.slotItems


{-| Place content in the `label` slot. See `M3e.Html.Shared.slotLabel`.
-}
slotLabel : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotLabel =
    M3e.Html.Shared.slotLabel


{-| Place content in the `prefix` slot. See `M3e.Html.Shared.slotPrefix`.
-}
slotPrefix : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotPrefix =
    M3e.Html.Shared.slotPrefix


{-| Place content in the `prefix-text` slot. See `M3e.Html.Shared.slotPrefixText`.
-}
slotPrefixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotPrefixText =
    M3e.Html.Shared.slotPrefixText


{-| Place content in the `suffix` slot. See `M3e.Html.Shared.slotSuffix`.
-}
slotSuffix : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSuffix =
    M3e.Html.Shared.slotSuffix


{-| Place content in the `suffix-text` slot. See `M3e.Html.Shared.slotSuffixText`.
-}
slotSuffixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotSuffixText =
    M3e.Html.Shared.slotSuffixText


{-| Place content in the `hint` slot. See `M3e.Html.Shared.slotHint`.
-}
slotHint : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotHint =
    M3e.Html.Shared.slotHint


{-| Place content in the `error` slot. See `M3e.Html.Shared.slotError`.
-}
slotError : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotError =
    M3e.Html.Shared.slotError


{-| Place content in the `avatar` slot. See `M3e.Html.Shared.slotAvatar`.
-}
slotAvatar :
    Markup.Element.Element { avatar : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotAvatar =
    M3e.Html.Shared.slotAvatar


{-| Place content in the `remove-icon` slot. See `M3e.Html.Shared.slotRemoveIcon`.
-}
slotRemoveIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotRemoveIcon =
    M3e.Html.Shared.slotRemoveIcon


{-| Place content in the `input` slot. See `M3e.Html.Shared.slotInput`.
-}
slotInput : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotInput =
    M3e.Html.Shared.slotInput


{-| Place content in the `badge` slot. See `M3e.Html.Shared.slotBadge`.
-}
slotBadge :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , badge : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotBadge =
    M3e.Html.Shared.slotBadge


{-| Place content in the `first-page-icon` slot. See `M3e.Html.Shared.slotFirstPageIcon`.
-}
slotFirstPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotFirstPageIcon =
    M3e.Html.Shared.slotFirstPageIcon


{-| Place content in the `previous-page-icon` slot. See `M3e.Html.Shared.slotPreviousPageIcon`.
-}
slotPreviousPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotPreviousPageIcon =
    M3e.Html.Shared.slotPreviousPageIcon


{-| Place content in the `next-page-icon` slot. See `M3e.Html.Shared.slotNextPageIcon`.
-}
slotNextPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotNextPageIcon =
    M3e.Html.Shared.slotNextPageIcon


{-| Place content in the `last-page-icon` slot. See `M3e.Html.Shared.slotLastPageIcon`.
-}
slotLastPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotLastPageIcon =
    M3e.Html.Shared.slotLastPageIcon


{-| Place content in the `subhead` slot. See `M3e.Html.Shared.slotSubhead`.
-}
slotSubhead :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSubhead =
    M3e.Html.Shared.slotSubhead


{-| Place content in the `clear-icon` slot. See `M3e.Html.Shared.slotClearIcon`.
-}
slotClearIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotClearIcon =
    M3e.Html.Shared.slotClearIcon


{-| Place content in the `open-leading` slot. See `M3e.Html.Shared.slotOpenLeading`.
-}
slotOpenLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOpenLeading =
    M3e.Html.Shared.slotOpenLeading


{-| Place content in the `open-trailing` slot. See `M3e.Html.Shared.slotOpenTrailing`.
-}
slotOpenTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotOpenTrailing =
    M3e.Html.Shared.slotOpenTrailing


{-| Place content in the `closed-leading` slot. See `M3e.Html.Shared.slotClosedLeading`.
-}
slotClosedLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotClosedLeading =
    M3e.Html.Shared.slotClosedLeading


{-| Place content in the `closed-trailing` slot. See `M3e.Html.Shared.slotClosedTrailing`.
-}
slotClosedTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotClosedTrailing =
    M3e.Html.Shared.slotClosedTrailing


{-| Place content in the `search-icon` slot. See `M3e.Html.Shared.slotSearchIcon`.
-}
slotSearchIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotSearchIcon =
    M3e.Html.Shared.slotSearchIcon


{-| Place content in the `arrow` slot. See `M3e.Html.Shared.slotArrow`.
-}
slotArrow :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotArrow =
    M3e.Html.Shared.slotArrow


{-| Place content in the `value` slot. See `M3e.Html.Shared.slotValue`.
-}
slotValue : Markup.Element.Element any msg -> Markup.Element.Element k msg
slotValue =
    M3e.Html.Shared.slotValue


{-| Place content in the `next-icon` slot. See `M3e.Html.Shared.slotNextIcon`.
-}
slotNextIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotNextIcon =
    M3e.Html.Shared.slotNextIcon


{-| Place content in the `prev-icon` slot. See `M3e.Html.Shared.slotPrevIcon`.
-}
slotPrevIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotPrevIcon =
    M3e.Html.Shared.slotPrevIcon


{-| Place content in the `leading-button` slot. See `M3e.Html.Shared.slotLeadingButton`.
-}
slotLeadingButton :
    Markup.Element.Element { button : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotLeadingButton =
    M3e.Html.Shared.slotLeadingButton


{-| Place content in the `trailing-button` slot. See `M3e.Html.Shared.slotTrailingButton`.
-}
slotTrailingButton :
    Markup.Element.Element { iconButton : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotTrailingButton =
    M3e.Html.Shared.slotTrailingButton


{-| Place content in the `done-icon` slot. See `M3e.Html.Shared.slotDoneIcon`.
-}
slotDoneIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotDoneIcon =
    M3e.Html.Shared.slotDoneIcon


{-| Place content in the `edit-icon` slot. See `M3e.Html.Shared.slotEditIcon`.
-}
slotEditIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotEditIcon =
    M3e.Html.Shared.slotEditIcon


{-| Place content in the `error-icon` slot. See `M3e.Html.Shared.slotErrorIcon`.
-}
slotErrorIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotErrorIcon =
    M3e.Html.Shared.slotErrorIcon


{-| Place content in the `step` slot. See `M3e.Html.Shared.slotStep`.
-}
slotStep :
    Markup.Element.Element { step : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
slotStep =
    M3e.Html.Shared.slotStep


{-| Place content in the `panel` slot. See `M3e.Html.Shared.slotPanel`.
-}
slotPanel :
    Markup.Element.Element
        { stepPanel : M3e.Kind.Brand
        , tabPanel : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
slotPanel =
    M3e.Html.Shared.slotPanel


{-| Place content in the `open-toggle-icon` slot. See `M3e.Html.Shared.slotOpenToggleIcon`.
-}
slotOpenToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slotOpenToggleIcon =
    M3e.Html.Shared.slotOpenToggleIcon


{-| See `M3e.TreeItem.label`.
-}
treeItemSlotLabel :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , link : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
treeItemSlotLabel =
    M3e.TreeItem.label


{-| See `M3e.TreeItem.icon`.
-}
treeItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
treeItemSlotIcon =
    M3e.TreeItem.icon


{-| See `M3e.TreeItem.selectedIcon`.
-}
treeItemSlotSelectedIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
treeItemSlotSelectedIcon =
    M3e.TreeItem.selectedIcon


{-| See `M3e.TreeItem.toggleIcon`.
-}
treeItemSlotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
treeItemSlotToggleIcon =
    M3e.TreeItem.toggleIcon


{-| See `M3e.TreeItem.openToggleIcon`.
-}
treeItemSlotOpenToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
treeItemSlotOpenToggleIcon =
    M3e.TreeItem.openToggleIcon


{-| See `M3e.Toc.overline`.
-}
tocSlotOverline :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
tocSlotOverline =
    M3e.Toc.overline


{-| See `M3e.Toc.title`.
-}
tocSlotTitle :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
tocSlotTitle =
    M3e.Toc.title


{-| See `M3e.Tabs.panel`.
-}
tabsSlotPanel :
    Markup.Element.Element { tabPanel : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
tabsSlotPanel =
    M3e.Tabs.panel


{-| See `M3e.Tabs.nextIcon`.
-}
tabsSlotNextIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
tabsSlotNextIcon =
    M3e.Tabs.nextIcon


{-| See `M3e.Tabs.prevIcon`.
-}
tabsSlotPrevIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
tabsSlotPrevIcon =
    M3e.Tabs.prevIcon


{-| See `M3e.Tab.icon`.
-}
tabSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
tabSlotIcon =
    M3e.Tab.icon


{-| See `M3e.Step.icon`.
-}
stepSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotIcon =
    M3e.Step.icon


{-| See `M3e.Step.doneIcon`.
-}
stepSlotDoneIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotDoneIcon =
    M3e.Step.doneIcon


{-| See `M3e.Step.editIcon`.
-}
stepSlotEditIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotEditIcon =
    M3e.Step.editIcon


{-| See `M3e.Step.errorIcon`.
-}
stepSlotErrorIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotErrorIcon =
    M3e.Step.errorIcon


{-| See `M3e.Step.hint`.
-}
stepSlotHint :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotHint =
    M3e.Step.hint


{-| See `M3e.Step.error`.
-}
stepSlotError :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
stepSlotError =
    M3e.Step.error


{-| See `M3e.StepPanel.actions`.
-}
stepPanelSlotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
stepPanelSlotActions =
    M3e.StepPanel.actions


{-| See `M3e.Stepper.step`.
-}
stepperSlotStep :
    Markup.Element.Element { step : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
stepperSlotStep =
    M3e.Stepper.step


{-| See `M3e.Stepper.panel`.
-}
stepperSlotPanel :
    Markup.Element.Element { stepPanel : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
stepperSlotPanel =
    M3e.Stepper.panel


{-| See `M3e.SplitPane.start`.
-}
splitPaneSlotStart : Markup.Element.Element any msg -> Markup.Element.Element k msg
splitPaneSlotStart =
    M3e.SplitPane.start


{-| See `M3e.SplitPane.end`.
-}
splitPaneSlotEnd : Markup.Element.Element any msg -> Markup.Element.Element k msg
splitPaneSlotEnd =
    M3e.SplitPane.end


{-| See `M3e.SplitButton.leadingButton`.
-}
splitButtonSlotLeadingButton :
    Markup.Element.Element { button : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
splitButtonSlotLeadingButton =
    M3e.SplitButton.leadingButton


{-| See `M3e.SplitButton.trailingButton`.
-}
splitButtonSlotTrailingButton :
    Markup.Element.Element { iconButton : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
splitButtonSlotTrailingButton =
    M3e.SplitButton.trailingButton


{-| See `M3e.Snackbar.closeIcon`.
-}
snackbarSlotCloseIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
snackbarSlotCloseIcon =
    M3e.Snackbar.closeIcon


{-| See `M3e.SlideGroup.nextIcon`.
-}
slideGroupSlotNextIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slideGroupSlotNextIcon =
    M3e.SlideGroup.nextIcon


{-| See `M3e.SlideGroup.prevIcon`.
-}
slideGroupSlotPrevIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
slideGroupSlotPrevIcon =
    M3e.SlideGroup.prevIcon


{-| See `M3e.ButtonSegment.icon`.
-}
buttonSegmentSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
buttonSegmentSlotIcon =
    M3e.ButtonSegment.icon


{-| See `M3e.SearchView.input`.
-}
searchViewSlotInput : Markup.Element.Element any msg -> Markup.Element.Element k msg
searchViewSlotInput =
    M3e.SearchView.input


{-| See `M3e.SearchView.openLeading`.
-}
searchViewSlotOpenLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchViewSlotOpenLeading =
    M3e.SearchView.openLeading


{-| See `M3e.SearchView.openTrailing`.
-}
searchViewSlotOpenTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchViewSlotOpenTrailing =
    M3e.SearchView.openTrailing


{-| See `M3e.SearchView.closedLeading`.
-}
searchViewSlotClosedLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchViewSlotClosedLeading =
    M3e.SearchView.closedLeading


{-| See `M3e.SearchView.closedTrailing`.
-}
searchViewSlotClosedTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchViewSlotClosedTrailing =
    M3e.SearchView.closedTrailing


{-| See `M3e.SearchView.searchIcon`.
-}
searchViewSlotSearchIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
searchViewSlotSearchIcon =
    M3e.SearchView.searchIcon


{-| See `M3e.SearchView.closeIcon`.
-}
searchViewSlotCloseIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
searchViewSlotCloseIcon =
    M3e.SearchView.closeIcon


{-| See `M3e.SearchView.clearIcon`.
-}
searchViewSlotClearIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
searchViewSlotClearIcon =
    M3e.SearchView.clearIcon


{-| See `M3e.SearchBar.leading`.
-}
searchBarSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchBarSlotLeading =
    M3e.SearchBar.leading


{-| See `M3e.SearchBar.input`.
-}
searchBarSlotInput : Markup.Element.Element any msg -> Markup.Element.Element k msg
searchBarSlotInput =
    M3e.SearchBar.input


{-| See `M3e.SearchBar.trailing`.
-}
searchBarSlotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
searchBarSlotTrailing =
    M3e.SearchBar.trailing


{-| See `M3e.SearchBar.clearIcon`.
-}
searchBarSlotClearIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
searchBarSlotClearIcon =
    M3e.SearchBar.clearIcon


{-| See `M3e.Paginator.firstPageIcon`.
-}
paginatorSlotFirstPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
paginatorSlotFirstPageIcon =
    M3e.Paginator.firstPageIcon


{-| See `M3e.Paginator.previousPageIcon`.
-}
paginatorSlotPreviousPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
paginatorSlotPreviousPageIcon =
    M3e.Paginator.previousPageIcon


{-| See `M3e.Paginator.nextPageIcon`.
-}
paginatorSlotNextPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
paginatorSlotNextPageIcon =
    M3e.Paginator.nextPageIcon


{-| See `M3e.Paginator.lastPageIcon`.
-}
paginatorSlotLastPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
paginatorSlotLastPageIcon =
    M3e.Paginator.lastPageIcon


{-| See `M3e.Select.arrow`.
-}
selectSlotArrow :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
selectSlotArrow =
    M3e.Select.arrow


{-| See `M3e.Select.value`.
-}
selectSlotValue : Markup.Element.Element any msg -> Markup.Element.Element k msg
selectSlotValue =
    M3e.Select.value


{-| See `M3e.NavMenuItemGroup.label`.
-}
navMenuItemGroupSlotLabel :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , heading : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
navMenuItemGroupSlotLabel =
    M3e.NavMenuItemGroup.label


{-| See `M3e.NavMenuItem.label`.
-}
navMenuItemSlotLabel :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , link : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
navMenuItemSlotLabel =
    M3e.NavMenuItem.label


{-| See `M3e.NavMenuItem.icon`.
-}
navMenuItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
navMenuItemSlotIcon =
    M3e.NavMenuItem.icon


{-| See `M3e.NavMenuItem.badge`.
-}
navMenuItemSlotBadge :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , badge : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
navMenuItemSlotBadge =
    M3e.NavMenuItem.badge


{-| See `M3e.NavMenuItem.selectedIcon`.
-}
navMenuItemSlotSelectedIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
navMenuItemSlotSelectedIcon =
    M3e.NavMenuItem.selectedIcon


{-| See `M3e.NavMenuItem.toggleIcon`.
-}
navMenuItemSlotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
navMenuItemSlotToggleIcon =
    M3e.NavMenuItem.toggleIcon


{-| See `M3e.NavItem.icon`.
-}
navItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
navItemSlotIcon =
    M3e.NavItem.icon


{-| See `M3e.NavItem.selectedIcon`.
-}
navItemSlotSelectedIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
navItemSlotSelectedIcon =
    M3e.NavItem.selectedIcon


{-| See `M3e.MenuItemRadio.icon`.
-}
menuItemRadioSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemRadioSlotIcon =
    M3e.MenuItemRadio.icon


{-| See `M3e.MenuItemRadio.trailingIcon`.
-}
menuItemRadioSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemRadioSlotTrailingIcon =
    M3e.MenuItemRadio.trailingIcon


{-| See `M3e.MenuItemCheckbox.icon`.
-}
menuItemCheckboxSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemCheckboxSlotIcon =
    M3e.MenuItemCheckbox.icon


{-| See `M3e.MenuItemCheckbox.trailingIcon`.
-}
menuItemCheckboxSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemCheckboxSlotTrailingIcon =
    M3e.MenuItemCheckbox.trailingIcon


{-| See `M3e.MenuItem.icon`.
-}
menuItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemSlotIcon =
    M3e.MenuItem.icon


{-| See `M3e.MenuItem.trailingIcon`.
-}
menuItemSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
menuItemSlotTrailingIcon =
    M3e.MenuItem.trailingIcon


{-| See `M3e.ListOption.leading`.
-}
listOptionSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listOptionSlotLeading =
    M3e.ListOption.leading


{-| See `M3e.ListOption.overline`.
-}
listOptionSlotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listOptionSlotOverline =
    M3e.ListOption.overline


{-| See `M3e.ListOption.supportingText`.
-}
listOptionSlotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listOptionSlotSupportingText =
    M3e.ListOption.supportingText


{-| See `M3e.ListOption.trailing`.
-}
listOptionSlotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listOptionSlotTrailing =
    M3e.ListOption.trailing


{-| See `M3e.ExpandableListItem.leading`.
-}
expandableListItemSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
expandableListItemSlotLeading =
    M3e.ExpandableListItem.leading


{-| See `M3e.ExpandableListItem.overline`.
-}
expandableListItemSlotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
expandableListItemSlotOverline =
    M3e.ExpandableListItem.overline


{-| See `M3e.ExpandableListItem.supportingText`.
-}
expandableListItemSlotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
expandableListItemSlotSupportingText =
    M3e.ExpandableListItem.supportingText


{-| See `M3e.ExpandableListItem.toggleIcon`.
-}
expandableListItemSlotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
expandableListItemSlotToggleIcon =
    M3e.ExpandableListItem.toggleIcon


{-| See `M3e.ExpandableListItem.items`.
-}
expandableListItemSlotItems : Markup.Element.Element any msg -> Markup.Element.Element k msg
expandableListItemSlotItems =
    M3e.ExpandableListItem.items


{-| See `M3e.ListAction.leading`.
-}
listActionSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listActionSlotLeading =
    M3e.ListAction.leading


{-| See `M3e.ListAction.overline`.
-}
listActionSlotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listActionSlotOverline =
    M3e.ListAction.overline


{-| See `M3e.ListAction.supportingText`.
-}
listActionSlotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listActionSlotSupportingText =
    M3e.ListAction.supportingText


{-| See `M3e.ListAction.trailing`.
-}
listActionSlotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listActionSlotTrailing =
    M3e.ListAction.trailing


{-| See `M3e.ListItemButton.leading`.
-}
listItemButtonSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemButtonSlotLeading =
    M3e.ListItemButton.leading


{-| See `M3e.ListItemButton.overline`.
-}
listItemButtonSlotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemButtonSlotOverline =
    M3e.ListItemButton.overline


{-| See `M3e.ListItemButton.supportingText`.
-}
listItemButtonSlotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemButtonSlotSupportingText =
    M3e.ListItemButton.supportingText


{-| See `M3e.ListItemButton.trailing`.
-}
listItemButtonSlotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemButtonSlotTrailing =
    M3e.ListItemButton.trailing


{-| See `M3e.ListItem.leading`.
-}
listItemSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemSlotLeading =
    M3e.ListItem.leading


{-| See `M3e.ListItem.overline`.
-}
listItemSlotOverline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemSlotOverline =
    M3e.ListItem.overline


{-| See `M3e.ListItem.supportingText`.
-}
listItemSlotSupportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemSlotSupportingText =
    M3e.ListItem.supportingText


{-| See `M3e.ListItem.trailing`.
-}
listItemSlotTrailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
listItemSlotTrailing =
    M3e.ListItem.trailing


{-| See `M3e.FabMenuItem.icon`.
-}
fabMenuItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
fabMenuItemSlotIcon =
    M3e.FabMenuItem.icon


{-| See `M3e.Fab.label`.
-}
fabSlotLabel :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
fabSlotLabel =
    M3e.Fab.label


{-| See `M3e.Fab.closeIcon`.
-}
fabSlotCloseIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
fabSlotCloseIcon =
    M3e.Fab.closeIcon


{-| See `M3e.ExpansionPanel.actions`.
-}
expansionPanelSlotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
expansionPanelSlotActions =
    M3e.ExpansionPanel.actions


{-| See `M3e.ExpansionPanel.header`.
-}
expansionPanelSlotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
expansionPanelSlotHeader =
    M3e.ExpansionPanel.header


{-| See `M3e.ExpansionPanel.toggleIcon`.
-}
expansionPanelSlotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
expansionPanelSlotToggleIcon =
    M3e.ExpansionPanel.toggleIcon


{-| See `M3e.ExpansionHeader.toggleIcon`.
-}
expansionHeaderSlotToggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
expansionHeaderSlotToggleIcon =
    M3e.ExpansionHeader.toggleIcon


{-| See `M3e.DrawerContainer.startSlot`.
-}
drawerContainerSlotStart : Markup.Element.Element any msg -> Markup.Element.Element k msg
drawerContainerSlotStart =
    M3e.DrawerContainer.startSlot


{-| See `M3e.DrawerContainer.endSlot`.
-}
drawerContainerSlotEnd : Markup.Element.Element any msg -> Markup.Element.Element k msg
drawerContainerSlotEnd =
    M3e.DrawerContainer.endSlot


{-| See `M3e.Dialog.header`.
-}
dialogSlotHeader :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
dialogSlotHeader =
    M3e.Dialog.header


{-| See `M3e.Dialog.actions`.
-}
dialogSlotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
dialogSlotActions =
    M3e.Dialog.actions


{-| See `M3e.Dialog.closeIcon`.
-}
dialogSlotCloseIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
dialogSlotCloseIcon =
    M3e.Dialog.closeIcon


{-| See `M3e.SuggestionChip.icon`.
-}
suggestionChipSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
suggestionChipSlotIcon =
    M3e.SuggestionChip.icon


{-| See `M3e.InputChipSet.input`.
-}
inputChipSetSlotInput : Markup.Element.Element any msg -> Markup.Element.Element k msg
inputChipSetSlotInput =
    M3e.InputChipSet.input


{-| See `M3e.InputChip.avatar`.
-}
inputChipSlotAvatar :
    Markup.Element.Element { avatar : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
inputChipSlotAvatar =
    M3e.InputChip.avatar


{-| See `M3e.InputChip.icon`.
-}
inputChipSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
inputChipSlotIcon =
    M3e.InputChip.icon


{-| See `M3e.InputChip.removeIcon`.
-}
inputChipSlotRemoveIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
inputChipSlotRemoveIcon =
    M3e.InputChip.removeIcon


{-| See `M3e.FilterChip.icon`.
-}
filterChipSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
filterChipSlotIcon =
    M3e.FilterChip.icon


{-| See `M3e.FilterChip.trailingIcon`.
-}
filterChipSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
filterChipSlotTrailingIcon =
    M3e.FilterChip.trailingIcon


{-| See `M3e.AssistChip.icon`.
-}
assistChipSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
assistChipSlotIcon =
    M3e.AssistChip.icon


{-| See `M3e.Chip.icon`.
-}
chipSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
chipSlotIcon =
    M3e.Chip.icon


{-| See `M3e.Chip.trailingIcon`.
-}
chipSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
chipSlotTrailingIcon =
    M3e.Chip.trailingIcon


{-| See `M3e.Card.header`.
-}
cardSlotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
cardSlotHeader =
    M3e.Card.header


{-| See `M3e.Card.content`.
-}
cardSlotContent : Markup.Element.Element any msg -> Markup.Element.Element k msg
cardSlotContent =
    M3e.Card.content


{-| See `M3e.Card.actions`.
-}
cardSlotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
cardSlotActions =
    M3e.Card.actions


{-| See `M3e.Card.footer`.
-}
cardSlotFooter : Markup.Element.Element any msg -> Markup.Element.Element k msg
cardSlotFooter =
    M3e.Card.footer


{-| See `M3e.Calendar.header`.
-}
calendarSlotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
calendarSlotHeader =
    M3e.Calendar.header


{-| See `M3e.RichTooltip.subhead`.
-}
richTooltipSlotSubhead :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
richTooltipSlotSubhead =
    M3e.RichTooltip.subhead


{-| See `M3e.RichTooltip.actions`.
-}
richTooltipSlotActions : Markup.Element.Element any msg -> Markup.Element.Element k msg
richTooltipSlotActions =
    M3e.RichTooltip.actions


{-| See `M3e.IconButton.selectedSlot`.
-}
iconButtonSlotSelected :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
iconButtonSlotSelected =
    M3e.IconButton.selectedSlot


{-| See `M3e.Button.icon`.
-}
buttonSlotIcon :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , loadingIndicator : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
buttonSlotIcon =
    M3e.Button.icon


{-| See `M3e.Button.selectedSlot`.
-}
buttonSlotSelected :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , icon : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
buttonSlotSelected =
    M3e.Button.selectedSlot


{-| See `M3e.Button.selectedIcon`.
-}
buttonSlotSelectedIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
buttonSlotSelectedIcon =
    M3e.Button.selectedIcon


{-| See `M3e.Button.trailingIcon`.
-}
buttonSlotTrailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
buttonSlotTrailingIcon =
    M3e.Button.trailingIcon


{-| See `M3e.Breadcrumb.separator`.
-}
breadcrumbSlotSeparator : Markup.Element.Element any msg -> Markup.Element.Element k msg
breadcrumbSlotSeparator =
    M3e.Breadcrumb.separator


{-| See `M3e.BreadcrumbItem.icon`.
-}
breadcrumbItemSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
breadcrumbItemSlotIcon =
    M3e.BreadcrumbItem.icon


{-| See `M3e.BreadcrumbItemButton.icon`.
-}
breadcrumbItemButtonSlotIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
breadcrumbItemButtonSlotIcon =
    M3e.BreadcrumbItemButton.icon


{-| See `M3e.BottomSheet.header`.
-}
bottomSheetSlotHeader : Markup.Element.Element any msg -> Markup.Element.Element k msg
bottomSheetSlotHeader =
    M3e.BottomSheet.header


{-| See `M3e.Autocomplete.loadingSlot`.
-}
autocompleteSlotLoading : Markup.Element.Element any msg -> Markup.Element.Element k msg
autocompleteSlotLoading =
    M3e.Autocomplete.loadingSlot


{-| See `M3e.Autocomplete.noData`.
-}
autocompleteSlotNoData : Markup.Element.Element any msg -> Markup.Element.Element k msg
autocompleteSlotNoData =
    M3e.Autocomplete.noData


{-| See `M3e.FormField.control`.
-}
formFieldSlotDefault : String -> Markup.Element.Element k msg -> Markup.Element.Element k msg
formFieldSlotDefault =
    M3e.FormField.control


{-| See `M3e.FormField.prefix`.
-}
formFieldSlotPrefix : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotPrefix =
    M3e.FormField.prefix


{-| See `M3e.FormField.prefixText`.
-}
formFieldSlotPrefixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotPrefixText =
    M3e.FormField.prefixText


{-| See `M3e.FormField.label`.
-}
formFieldSlotLabel : String -> Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotLabel =
    M3e.FormField.label


{-| See `M3e.FormField.suffix`.
-}
formFieldSlotSuffix : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotSuffix =
    M3e.FormField.suffix


{-| See `M3e.FormField.suffixText`.
-}
formFieldSlotSuffixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotSuffixText =
    M3e.FormField.suffixText


{-| See `M3e.FormField.hint`.
-}
formFieldSlotHint : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotHint =
    M3e.FormField.hint


{-| See `M3e.FormField.error`.
-}
formFieldSlotError : Markup.Element.Element any msg -> Markup.Element.Element k msg
formFieldSlotError =
    M3e.FormField.error


{-| See `M3e.OptionPanel.noData`.
-}
optionPanelSlotNoData : Markup.Element.Element any msg -> Markup.Element.Element k msg
optionPanelSlotNoData =
    M3e.OptionPanel.noData


{-| See `M3e.OptionPanel.loading`.
-}
optionPanelSlotLoading :
    Markup.Element.Element
        { circularProgressIndicator : M3e.Kind.Brand
        , loadingIndicator : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
optionPanelSlotLoading =
    M3e.OptionPanel.loading


{-| See `M3e.Optgroup.label`.
-}
optgroupSlotLabel :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
optgroupSlotLabel =
    M3e.Optgroup.label


{-| See `M3e.AppBar.leading`.
-}
appBarSlotLeading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
appBarSlotLeading =
    M3e.AppBar.leading


{-| See `M3e.AppBar.title`.
-}
appBarSlotTitle :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
appBarSlotTitle =
    M3e.AppBar.title


{-| See `M3e.AppBar.subtitle`.
-}
appBarSlotSubtitle :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
appBarSlotSubtitle =
    M3e.AppBar.subtitle


{-| See `M3e.AppBar.trailing`.
-}
appBarSlotTrailing :
    Markup.Element.Element
        { iconButton : M3e.Kind.Brand
        , button : M3e.Kind.Brand
        , searchBar : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
appBarSlotTrailing =
    M3e.AppBar.trailing


{-| See `M3e.AppBar.leadingIcon`.
-}
appBarSlotLeadingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
appBarSlotLeadingIcon =
    M3e.AppBar.leadingIcon


{-| See `M3e.AppBar.trailingIcon`.
-}
appBarSlotTrailingIcon : Markup.Element.Element any msg -> Markup.Element.Element k msg
appBarSlotTrailingIcon =
    M3e.AppBar.trailingIcon


{-| Place content in a component's default (unnamed) slot — the identity placement, since default-slot content is passed straight into the element's children (no `slot=` attribute). The component-agnostic form of a per-component default-slot setter.
-}
slotDefault : Markup.Element.Element k msg -> Markup.Element.Element k msg
slotDefault content =
    content


{-| Place content in a component's default (unnamed) slot — the identity placement, since default-slot content is passed straight into the element's children (no `slot=` attribute). The component-agnostic form of a per-component default-slot setter.
-}
child : Markup.Element.Element k msg -> Markup.Element.Element k msg
child content =
    content


{-| Place a list of elements in a component's default (unnamed) slot — the identity placement (default-slot content is passed straight into the element's children). The component-agnostic form of a per-component default-slot setter.
-}
children : List (Markup.Element.Element k msg) -> List (Markup.Element.Element k msg)
children content =
    content


{-| Place content in a control slot, stamping `id="<id>"` from the required `String` so the label and control are associated. The component-agnostic form of a per-component `control` slot setter.
-}
control : String -> Markup.Element.Element k msg -> Markup.Element.Element k msg
control =
    Markup.Element.withAttr "id"


{-| The `linear` variant constructor, re-exposed from `M3e.Progress`.
-}
linear :
    List
        (Markup.Html.Attr.Attr
            { bufferValue : M3e.Token.Supported
            , max : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element child msg)
    -> Markup.Element.Element { s | progress : M3e.Kind.Brand } msg
linear =
    M3e.Progress.linear


{-| The `circular` variant constructor, re-exposed from `M3e.Progress`.
-}
circular :
    List
        (Markup.Html.Attr.Attr
            { indeterminate : M3e.Token.Supported
            , max : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element child msg)
    -> Markup.Element.Element { s | progress : M3e.Kind.Brand } msg
circular =
    M3e.Progress.circular
