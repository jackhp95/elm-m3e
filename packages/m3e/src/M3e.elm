module M3e exposing
    ( tree, treeItem, toolbar, toc, tocItem, themeIcon
    , theme, textareaAutosize, tabs, tabPanel, tab, switch, stepperReset
    , stepperPrevious, stepperNext, step, stepPanel, stepper, splitPane, splitButton
    , snackbar, slider, sliderThumb, slideGroup, skeleton, shape, segmentedButton
    , buttonSegment, searchView, searchBar, radioGroup, radio, progressElementIndicatorBase, paginator
    , select, navRailToggle, navRail, navMenuItemGroup, navMenu, navMenuItem, navBar
    , navItem, menuItemRadio, menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger
    , menuItemElementBase, loadingIndicator, selectionList, listOption, actionList, expandableListItem, listAction
    , listItemButton, list, listItem, icon, heading, fabMenuTrigger, fabMenuItem
    , fabMenu, fab, accordion, expansionPanel, expansionHeader, drawerToggle, drawerContainer
    , divider, dialogTrigger, dialog, dialogAction, datepickerToggle, datepicker, contentPane
    , suggestionChip, inputChipSet, inputChip, filterChipSet, filterChip, chipSet, assistChip
    , chip, checkbox, card, calendar, yearView, multiYearView, monthView
    , tooltip, richTooltip, tooltipElementBase, richTooltipAction, buttonGroup, iconButton, button
    , breadcrumb, breadcrumbItem, breadcrumbItemButton, bottomSheetTrigger, bottomSheet, bottomSheetAction, badge
    , avatar, autocomplete, formField, optionPanel, floatingPanel, optgroup, option
    , focusTrap, appBar, textOverflow, textHighlight, stateLayer, slide, scrollContainer
    , ripple, pseudoRadio, pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase
    , attrAction, attrActionable, attrActive, attrActiveDate, attrAlert, attrAnchorOffset, ariaInvalid
    , attrAutoActivate, attrBufferValue, attrCascade, attrCaseSensitive, attrCentered, attrChecked, attrClearLabel
    , attrClearable, attrCloseLabel, attrColor, attrCompleted, attrConfirmLabel, attrContained, attrDate
    , attrDensity, attrDetent, attrDisableClose, attrDisableHighlight, attrDisableHover, attrDisableRestoreFocus, attrDisabled
    , attrDisabledInteractive, attrDiscrete, attrDismissLabel, attrDismissible, attrDownload, attrDuration, attrEditable
    , attrElevated, attrEmphasized, attrEnd, attrEndDivider, attrExtended, attrFilled, attrFirstPageLabel
    , attrFitAnchorWidth, attrFor, attrHandle, attrHandleLabel, attrHideDelay, attrHideFriction, attrHideLoading
    , attrHideNoData, attrHidePageSize, attrHideRequiredMarker, attrHideSearchIcon, attrHideSelectionIndicator, attrHideToggle, attrHideable
    , attrHref, attrIndeterminate, attrInline, attrInset, attrInsetEnd, attrInsetStart, attrInvalid
    , attrInward, attrItemLabel, attrItemsPerPageLabel, attrLabel, attrLabelled, attrLastPageLabel, attrLength
    , attrLevel, attrLinear, attrLoaded, attrLoading, attrLoadingLabel, attrLowered, attrMax
    , attrMaxDate, attrMaxDepth, attrMaxRows, attrMin, attrMinDate, attrMinRows, attrModal
    , attrMulti, attrNextMonthLabel, attrNextMultiYearLabel, attrNextPageLabel, attrNextYearLabel, attrNoAnimate, attrNoDataLabel
    , attrNoFocusTrap, attrOpen, attrOpticalSize, attrOptional, attrOvershootLimit, attrPageIndex, attrPageSizes
    , attrPanelClass, attrPreviousMonthLabel, attrPreviousMultiYearLabel, attrPreviousPageLabel, attrPreviousYearLabel, attrRadius, attrRange
    , attrRangeEnd, attrRangeStart, attrRel, attrRemovable, attrRemoveLabel, attrRequired, attrReturnValue
    , attrSecondary, attrSelected, attrSelectedIndex, attrShowDelay, attrShowFirstLastButtons, attrStart, attrStartAt
    , attrStartDivider, attrStep, attrStretch, attrStrongFocus, attrSubmenu, attrTarget, attrTerm
    , attrThin, attrThreshold, attrToday, attrToggle, attrUnbounded, attrVertical, attrWeight
    , attrWrap, attrWrapDetents, attrName, attrValueFloat, attrValue, animationNone, animationPulse
    , animationWave, contrastHigh, contrastMedium, contrastStandard, currentDate, currentLocation, currentPage
    , currentStep, currentTime, currentTrue, disablePaginationTrue, disablePaginationFalse, disablePaginationAuto, dividersAbove
    , dividersAboveBelow, dividersBelow, dividersNone, endModeAuto, endModeOver, endModePush, endModeSide
    , filterContains, filterEndsWith, filterNone, filterStartsWith, floatLabelAlways, floatLabelAuto, gradeHigh
    , gradeLow, gradeMedium, headerPositionAfter, headerPositionBefore, headerPositionAbove, headerPositionBelow, hideSubscriptAlways
    , hideSubscriptAuto, hideSubscriptNever, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth, iconsNone
    , iconsSelected, labelPositionBelow, labelPositionEnd, modeDocked, modeFullscreen, modeBuffer, modeDeterminate
    , modeIndeterminate, modeQuery, modeAuto, modeCompact, modeExpanded, modeContains, modeEndsWith
    , modeStartsWith, motionExpressive, motionStandard, orientationAuto, orientationHorizontal, orientationVertical, pageSizeAll
    , pageSizeVariantFilled, pageSizeVariantOutlined, positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore
    , positionBelow, positionBelowAfter, positionBelowBefore, positionXAfter, positionXBefore, positionYAbove, positionYBelow
    , schemeAuto, schemeDark, schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeAuto, shapeCircular
    , shapeRounded, shapeSquare, sizeExtraLarge, sizeExtraSmall, sizeLarge, sizeMedium, sizeSmall
    , startModeAuto, startModeOver, startModePush, startModeSide, startViewMonth, startViewMultiYear, startViewYear
    , stateContent, stateLoading, stateNoData, toggleDirectionHorizontal, toggleDirectionVertical, togglePositionAfter, togglePositionBefore
    , touchGesturesAuto, touchGesturesOff, touchGesturesOn, typeButton, typeReset, typeSubmit, variantContent
    , variantExpressive, variantFidelity, variantFruitSalad, variantMonochrome, variantNeutral, variantRainbow, variantTonalSpot
    , variantFlat, variantWavy, variantVibrant, variantContained, variantUncontained, variantSegmented, variantRounded
    , variantSharp, variantDisplay, variantHeadline, variantLabel, variantTitle, variantPrimary, variantPrimaryContainer
    , variantSecondary, variantSecondaryContainer, variantSurface, variantTertiary, variantTertiaryContainer, variantAuto, variantDocked
    , variantModal, variantConnected, variantStandard, variantElevated, variantText, variantTonal, variantFilled
    , variantOutlined, widthDefault, widthNarrow, widthWide, ariaLabel, ariaLabelledby, ariaDescribedby
    , ariaHidden, onChange, onOpening, onOpened, onClosing, onClosed, onClick
    , onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange, onQuery, onClear
    , onPage, onCancel, onRemove, onInvalid, onActiveChange, onHighlight, slotDefault
    , slotLeading, slotTitle, slotSubtitle, slotTrailing, slotLeadingIcon, slotTrailingIcon, slotIcon
    , slotLoading, slotNoData, slotHeader, slotSeparator, slotSelected, slotSelectedIcon, slotContent
    , slotActions, slotFooter, slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText
    , slotToggleIcon, slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText
    , slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge, slotFirstPageIcon
    , slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon, slotOpenLeading, slotOpenTrailing
    , slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow, slotValue, slotNextIcon, slotPrevIcon
    , slotLeadingButton, slotTrailingButton, slotDoneIcon, slotEditIcon, slotErrorIcon, slotStep, slotPanel
    , slotOpenToggleIcon, treeSlotDefault, treeItemSlotDefault, treeItemSlotLabel, treeItemSlotIcon, treeItemSlotSelectedIcon, treeItemSlotToggleIcon
    , treeItemSlotOpenToggleIcon, toolbarSlotDefault, tocSlotDefault, tocSlotOverline, tocSlotTitle, tocItemSlotDefault, themeSlotDefault
    , tabsSlotDefault, tabsSlotPanel, tabsSlotNextIcon, tabsSlotPrevIcon, tabPanelSlotDefault, tabSlotDefault, tabSlotIcon
    , stepperResetSlotDefault, stepperPreviousSlotDefault, stepperNextSlotDefault, stepSlotDefault, stepSlotIcon, stepSlotDoneIcon, stepSlotEditIcon
    , stepSlotErrorIcon, stepSlotHint, stepSlotError, stepPanelSlotDefault, stepPanelSlotActions, stepperSlotStep, stepperSlotPanel
    , splitPaneSlotStart, splitPaneSlotEnd, splitButtonSlotLeadingButton, splitButtonSlotTrailingButton, snackbarSlotDefault, snackbarSlotCloseIcon, sliderSlotDefault
    , slideGroupSlotDefault, slideGroupSlotNextIcon, slideGroupSlotPrevIcon, skeletonSlotDefault, shapeSlotDefault, segmentedButtonSlotDefault, buttonSegmentSlotDefault
    , buttonSegmentSlotIcon, searchViewSlotDefault, searchViewSlotInput, searchViewSlotOpenLeading, searchViewSlotOpenTrailing, searchViewSlotClosedLeading, searchViewSlotClosedTrailing
    , searchViewSlotSearchIcon, searchViewSlotCloseIcon, searchViewSlotClearIcon, searchBarSlotLeading, searchBarSlotInput, searchBarSlotTrailing, searchBarSlotClearIcon
    , radioGroupSlotDefault, paginatorSlotFirstPageIcon, paginatorSlotPreviousPageIcon, paginatorSlotNextPageIcon, paginatorSlotLastPageIcon, selectSlotDefault, selectSlotArrow
    , selectSlotValue, navRailToggleSlotDefault, navRailSlotDefault, navMenuItemGroupSlotLabel, navMenuItemGroupSlotDefault, navMenuSlotDefault, navMenuItemSlotDefault
    , navMenuItemSlotLabel, navMenuItemSlotIcon, navMenuItemSlotBadge, navMenuItemSlotSelectedIcon, navMenuItemSlotToggleIcon, navBarSlotDefault, navItemSlotDefault
    , navItemSlotIcon, navItemSlotSelectedIcon, menuItemRadioSlotDefault, menuItemRadioSlotIcon, menuItemRadioSlotTrailingIcon, menuItemGroupSlotDefault, menuItemCheckboxSlotDefault
    , menuItemCheckboxSlotIcon, menuItemCheckboxSlotTrailingIcon, menuSlotDefault, menuItemSlotDefault, menuItemSlotIcon, menuItemSlotTrailingIcon, menuTriggerSlotDefault
    , selectionListSlotDefault, listOptionSlotDefault, listOptionSlotLeading, listOptionSlotOverline, listOptionSlotSupportingText, listOptionSlotTrailing, actionListSlotDefault
    , expandableListItemSlotDefault, expandableListItemSlotLeading, expandableListItemSlotOverline, expandableListItemSlotSupportingText, expandableListItemSlotToggleIcon, expandableListItemSlotItems, listActionSlotDefault
    , listActionSlotLeading, listActionSlotOverline, listActionSlotSupportingText, listActionSlotTrailing, listItemButtonSlotDefault, listItemButtonSlotLeading, listItemButtonSlotOverline
    , listItemButtonSlotSupportingText, listItemButtonSlotTrailing, listSlotDefault, listItemSlotDefault, listItemSlotLeading, listItemSlotOverline, listItemSlotSupportingText
    , listItemSlotTrailing, headingSlotDefault, fabMenuTriggerSlotDefault, fabMenuSlotDefault, fabSlotDefault, fabSlotLabel, fabSlotCloseIcon
    , accordionSlotDefault, expansionPanelSlotDefault, expansionPanelSlotActions, expansionPanelSlotHeader, expansionPanelSlotToggleIcon, expansionHeaderSlotDefault, expansionHeaderSlotToggleIcon
    , drawerToggleSlotDefault, drawerContainerSlotDefault, drawerContainerSlotStart, drawerContainerSlotEnd, dialogTriggerSlotDefault, dialogSlotDefault, dialogSlotHeader
    , dialogSlotActions, dialogSlotCloseIcon, dialogActionSlotDefault, datepickerToggleSlotDefault, contentPaneSlotDefault, suggestionChipSlotDefault, suggestionChipSlotIcon
    , inputChipSetSlotDefault, inputChipSetSlotInput, inputChipSlotDefault, inputChipSlotAvatar, inputChipSlotIcon, inputChipSlotRemoveIcon, filterChipSetSlotDefault
    , filterChipSlotDefault, filterChipSlotIcon, filterChipSlotTrailingIcon, chipSetSlotDefault, assistChipSlotDefault, assistChipSlotIcon, chipSlotDefault
    , chipSlotIcon, chipSlotTrailingIcon, cardSlotDefault, cardSlotHeader, cardSlotContent, cardSlotActions, cardSlotFooter
    , calendarSlotHeader, tooltipSlotDefault, richTooltipSlotDefault, richTooltipSlotSubhead, richTooltipSlotActions, richTooltipActionSlotDefault, buttonGroupSlotDefault
    , iconButtonSlotDefault, iconButtonSlotSelected, buttonSlotDefault, buttonSlotIcon, buttonSlotSelected, buttonSlotSelectedIcon, buttonSlotTrailingIcon
    , breadcrumbSlotDefault, breadcrumbSlotSeparator, breadcrumbItemSlotDefault, breadcrumbItemSlotIcon, breadcrumbItemButtonSlotIcon, breadcrumbItemButtonSlotDefault, bottomSheetTriggerSlotDefault
    , bottomSheetSlotDefault, bottomSheetSlotHeader, bottomSheetActionSlotDefault, badgeSlotDefault, avatarSlotDefault, autocompleteSlotDefault, autocompleteSlotLoading
    , autocompleteSlotNoData, formFieldSlotDefault, formFieldSlotPrefix, formFieldSlotPrefixText, formFieldSlotLabel, formFieldSlotSuffix, formFieldSlotSuffixText
    , formFieldSlotHint, formFieldSlotError, optionPanelSlotDefault, optionPanelSlotNoData, optionPanelSlotLoading, floatingPanelSlotDefault, optgroupSlotDefault
    , optgroupSlotLabel, optionSlotDefault, focusTrapSlotDefault, appBarSlotLeading, appBarSlotTitle, appBarSlotSubtitle, appBarSlotTrailing
    , appBarSlotLeadingIcon, appBarSlotTrailingIcon, textOverflowSlotDefault, textHighlightSlotDefault, slideSlotDefault, scrollContainerSlotDefault, collapsibleSlotDefault
    )

{-|
The one-import barrel. Re-exposes every component constructor plus the whole shared attribute/event vocabulary, so `import M3e exposing (..)` gives you every constructor together with `disabled`/`variant`/`onClick`/… . Token values stay in `M3e.Value` (re-exposing hundreds here would bloat the namespace). Each constructor takes `[attributes] [content]`; reach for the per-component `M3e.<Component>` modules when you want the strict, component-scoped types.

@docs tree, treeItem, toolbar, toc, tocItem, themeIcon
@docs theme, textareaAutosize, tabs, tabPanel, tab, switch
@docs stepperReset, stepperPrevious, stepperNext, step, stepPanel, stepper
@docs splitPane, splitButton, snackbar, slider, sliderThumb, slideGroup
@docs skeleton, shape, segmentedButton, buttonSegment, searchView, searchBar
@docs radioGroup, radio, progressElementIndicatorBase, paginator, select, navRailToggle
@docs navRail, navMenuItemGroup, navMenu, navMenuItem, navBar, navItem
@docs menuItemRadio, menuItemGroup, menuItemCheckbox, menu, menuItem, menuTrigger
@docs menuItemElementBase, loadingIndicator, selectionList, listOption, actionList, expandableListItem
@docs listAction, listItemButton, list, listItem, icon, heading
@docs fabMenuTrigger, fabMenuItem, fabMenu, fab, accordion, expansionPanel
@docs expansionHeader, drawerToggle, drawerContainer, divider, dialogTrigger, dialog
@docs dialogAction, datepickerToggle, datepicker, contentPane, suggestionChip, inputChipSet
@docs inputChip, filterChipSet, filterChip, chipSet, assistChip, chip
@docs checkbox, card, calendar, yearView, multiYearView, monthView
@docs tooltip, richTooltip, tooltipElementBase, richTooltipAction, buttonGroup, iconButton
@docs button, breadcrumb, breadcrumbItem, breadcrumbItemButton, bottomSheetTrigger, bottomSheet
@docs bottomSheetAction, badge, avatar, autocomplete, formField, optionPanel
@docs floatingPanel, optgroup, option, focusTrap, appBar, textOverflow
@docs textHighlight, stateLayer, slide, scrollContainer, ripple, pseudoRadio
@docs pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, attrAction
@docs attrActionable, attrActive, attrActiveDate, attrAlert, attrAnchorOffset, ariaInvalid
@docs attrAutoActivate, attrBufferValue, attrCascade, attrCaseSensitive, attrCentered, attrChecked
@docs attrClearLabel, attrClearable, attrCloseLabel, attrColor, attrCompleted, attrConfirmLabel
@docs attrContained, attrDate, attrDensity, attrDetent, attrDisableClose, attrDisableHighlight
@docs attrDisableHover, attrDisableRestoreFocus, attrDisabled, attrDisabledInteractive, attrDiscrete, attrDismissLabel
@docs attrDismissible, attrDownload, attrDuration, attrEditable, attrElevated, attrEmphasized
@docs attrEnd, attrEndDivider, attrExtended, attrFilled, attrFirstPageLabel, attrFitAnchorWidth
@docs attrFor, attrHandle, attrHandleLabel, attrHideDelay, attrHideFriction, attrHideLoading
@docs attrHideNoData, attrHidePageSize, attrHideRequiredMarker, attrHideSearchIcon, attrHideSelectionIndicator, attrHideToggle
@docs attrHideable, attrHref, attrIndeterminate, attrInline, attrInset, attrInsetEnd
@docs attrInsetStart, attrInvalid, attrInward, attrItemLabel, attrItemsPerPageLabel, attrLabel
@docs attrLabelled, attrLastPageLabel, attrLength, attrLevel, attrLinear, attrLoaded
@docs attrLoading, attrLoadingLabel, attrLowered, attrMax, attrMaxDate, attrMaxDepth
@docs attrMaxRows, attrMin, attrMinDate, attrMinRows, attrModal, attrMulti
@docs attrNextMonthLabel, attrNextMultiYearLabel, attrNextPageLabel, attrNextYearLabel, attrNoAnimate, attrNoDataLabel
@docs attrNoFocusTrap, attrOpen, attrOpticalSize, attrOptional, attrOvershootLimit, attrPageIndex
@docs attrPageSizes, attrPanelClass, attrPreviousMonthLabel, attrPreviousMultiYearLabel, attrPreviousPageLabel, attrPreviousYearLabel
@docs attrRadius, attrRange, attrRangeEnd, attrRangeStart, attrRel, attrRemovable
@docs attrRemoveLabel, attrRequired, attrReturnValue, attrSecondary, attrSelected, attrSelectedIndex
@docs attrShowDelay, attrShowFirstLastButtons, attrStart, attrStartAt, attrStartDivider, attrStep
@docs attrStretch, attrStrongFocus, attrSubmenu, attrTarget, attrTerm, attrThin
@docs attrThreshold, attrToday, attrToggle, attrUnbounded, attrVertical, attrWeight
@docs attrWrap, attrWrapDetents, attrName, attrValueFloat, attrValue, animationNone
@docs animationPulse, animationWave, contrastHigh, contrastMedium, contrastStandard, currentDate
@docs currentLocation, currentPage, currentStep, currentTime, currentTrue, disablePaginationTrue
@docs disablePaginationFalse, disablePaginationAuto, dividersAbove, dividersAboveBelow, dividersBelow, dividersNone
@docs endModeAuto, endModeOver, endModePush, endModeSide, filterContains, filterEndsWith
@docs filterNone, filterStartsWith, floatLabelAlways, floatLabelAuto, gradeHigh, gradeLow
@docs gradeMedium, headerPositionAfter, headerPositionBefore, headerPositionAbove, headerPositionBelow, hideSubscriptAlways
@docs hideSubscriptAuto, hideSubscriptNever, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth
@docs iconsNone, iconsSelected, labelPositionBelow, labelPositionEnd, modeDocked, modeFullscreen
@docs modeBuffer, modeDeterminate, modeIndeterminate, modeQuery, modeAuto, modeCompact
@docs modeExpanded, modeContains, modeEndsWith, modeStartsWith, motionExpressive, motionStandard
@docs orientationAuto, orientationHorizontal, orientationVertical, pageSizeAll, pageSizeVariantFilled, pageSizeVariantOutlined
@docs positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore, positionBelow
@docs positionBelowAfter, positionBelowBefore, positionXAfter, positionXBefore, positionYAbove, positionYBelow
@docs schemeAuto, schemeDark, schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeAuto
@docs shapeCircular, shapeRounded, shapeSquare, sizeExtraLarge, sizeExtraSmall, sizeLarge
@docs sizeMedium, sizeSmall, startModeAuto, startModeOver, startModePush, startModeSide
@docs startViewMonth, startViewMultiYear, startViewYear, stateContent, stateLoading, stateNoData
@docs toggleDirectionHorizontal, toggleDirectionVertical, togglePositionAfter, togglePositionBefore, touchGesturesAuto, touchGesturesOff
@docs touchGesturesOn, typeButton, typeReset, typeSubmit, variantContent, variantExpressive
@docs variantFidelity, variantFruitSalad, variantMonochrome, variantNeutral, variantRainbow, variantTonalSpot
@docs variantFlat, variantWavy, variantVibrant, variantContained, variantUncontained, variantSegmented
@docs variantRounded, variantSharp, variantDisplay, variantHeadline, variantLabel, variantTitle
@docs variantPrimary, variantPrimaryContainer, variantSecondary, variantSecondaryContainer, variantSurface, variantTertiary
@docs variantTertiaryContainer, variantAuto, variantDocked, variantModal, variantConnected, variantStandard
@docs variantElevated, variantText, variantTonal, variantFilled, variantOutlined, widthDefault
@docs widthNarrow, widthWide, ariaLabel, ariaLabelledby, ariaDescribedby, ariaHidden
@docs onChange, onOpening, onOpened, onClosing, onClosed, onClick
@docs onBeforeinput, onInput, onBeforetoggle, onToggle, onValueChange, onQuery
@docs onClear, onPage, onCancel, onRemove, onInvalid, onActiveChange
@docs onHighlight, slotDefault, slotLeading, slotTitle, slotSubtitle, slotTrailing
@docs slotLeadingIcon, slotTrailingIcon, slotIcon, slotLoading, slotNoData, slotHeader
@docs slotSeparator, slotSelected, slotSelectedIcon, slotContent, slotActions, slotFooter
@docs slotCloseIcon, slotStart, slotEnd, slotOverline, slotSupportingText, slotToggleIcon
@docs slotItems, slotLabel, slotPrefix, slotPrefixText, slotSuffix, slotSuffixText
@docs slotHint, slotError, slotAvatar, slotRemoveIcon, slotInput, slotBadge
@docs slotFirstPageIcon, slotPreviousPageIcon, slotNextPageIcon, slotLastPageIcon, slotSubhead, slotClearIcon
@docs slotOpenLeading, slotOpenTrailing, slotClosedLeading, slotClosedTrailing, slotSearchIcon, slotArrow
@docs slotValue, slotNextIcon, slotPrevIcon, slotLeadingButton, slotTrailingButton, slotDoneIcon
@docs slotEditIcon, slotErrorIcon, slotStep, slotPanel, slotOpenToggleIcon, treeSlotDefault
@docs treeItemSlotDefault, treeItemSlotLabel, treeItemSlotIcon, treeItemSlotSelectedIcon, treeItemSlotToggleIcon, treeItemSlotOpenToggleIcon
@docs toolbarSlotDefault, tocSlotDefault, tocSlotOverline, tocSlotTitle, tocItemSlotDefault, themeSlotDefault
@docs tabsSlotDefault, tabsSlotPanel, tabsSlotNextIcon, tabsSlotPrevIcon, tabPanelSlotDefault, tabSlotDefault
@docs tabSlotIcon, stepperResetSlotDefault, stepperPreviousSlotDefault, stepperNextSlotDefault, stepSlotDefault, stepSlotIcon
@docs stepSlotDoneIcon, stepSlotEditIcon, stepSlotErrorIcon, stepSlotHint, stepSlotError, stepPanelSlotDefault
@docs stepPanelSlotActions, stepperSlotStep, stepperSlotPanel, splitPaneSlotStart, splitPaneSlotEnd, splitButtonSlotLeadingButton
@docs splitButtonSlotTrailingButton, snackbarSlotDefault, snackbarSlotCloseIcon, sliderSlotDefault, slideGroupSlotDefault, slideGroupSlotNextIcon
@docs slideGroupSlotPrevIcon, skeletonSlotDefault, shapeSlotDefault, segmentedButtonSlotDefault, buttonSegmentSlotDefault, buttonSegmentSlotIcon
@docs searchViewSlotDefault, searchViewSlotInput, searchViewSlotOpenLeading, searchViewSlotOpenTrailing, searchViewSlotClosedLeading, searchViewSlotClosedTrailing
@docs searchViewSlotSearchIcon, searchViewSlotCloseIcon, searchViewSlotClearIcon, searchBarSlotLeading, searchBarSlotInput, searchBarSlotTrailing
@docs searchBarSlotClearIcon, radioGroupSlotDefault, paginatorSlotFirstPageIcon, paginatorSlotPreviousPageIcon, paginatorSlotNextPageIcon, paginatorSlotLastPageIcon
@docs selectSlotDefault, selectSlotArrow, selectSlotValue, navRailToggleSlotDefault, navRailSlotDefault, navMenuItemGroupSlotLabel
@docs navMenuItemGroupSlotDefault, navMenuSlotDefault, navMenuItemSlotDefault, navMenuItemSlotLabel, navMenuItemSlotIcon, navMenuItemSlotBadge
@docs navMenuItemSlotSelectedIcon, navMenuItemSlotToggleIcon, navBarSlotDefault, navItemSlotDefault, navItemSlotIcon, navItemSlotSelectedIcon
@docs menuItemRadioSlotDefault, menuItemRadioSlotIcon, menuItemRadioSlotTrailingIcon, menuItemGroupSlotDefault, menuItemCheckboxSlotDefault, menuItemCheckboxSlotIcon
@docs menuItemCheckboxSlotTrailingIcon, menuSlotDefault, menuItemSlotDefault, menuItemSlotIcon, menuItemSlotTrailingIcon, menuTriggerSlotDefault
@docs selectionListSlotDefault, listOptionSlotDefault, listOptionSlotLeading, listOptionSlotOverline, listOptionSlotSupportingText, listOptionSlotTrailing
@docs actionListSlotDefault, expandableListItemSlotDefault, expandableListItemSlotLeading, expandableListItemSlotOverline, expandableListItemSlotSupportingText, expandableListItemSlotToggleIcon
@docs expandableListItemSlotItems, listActionSlotDefault, listActionSlotLeading, listActionSlotOverline, listActionSlotSupportingText, listActionSlotTrailing
@docs listItemButtonSlotDefault, listItemButtonSlotLeading, listItemButtonSlotOverline, listItemButtonSlotSupportingText, listItemButtonSlotTrailing, listSlotDefault
@docs listItemSlotDefault, listItemSlotLeading, listItemSlotOverline, listItemSlotSupportingText, listItemSlotTrailing, headingSlotDefault
@docs fabMenuTriggerSlotDefault, fabMenuSlotDefault, fabSlotDefault, fabSlotLabel, fabSlotCloseIcon, accordionSlotDefault
@docs expansionPanelSlotDefault, expansionPanelSlotActions, expansionPanelSlotHeader, expansionPanelSlotToggleIcon, expansionHeaderSlotDefault, expansionHeaderSlotToggleIcon
@docs drawerToggleSlotDefault, drawerContainerSlotDefault, drawerContainerSlotStart, drawerContainerSlotEnd, dialogTriggerSlotDefault, dialogSlotDefault
@docs dialogSlotHeader, dialogSlotActions, dialogSlotCloseIcon, dialogActionSlotDefault, datepickerToggleSlotDefault, contentPaneSlotDefault
@docs suggestionChipSlotDefault, suggestionChipSlotIcon, inputChipSetSlotDefault, inputChipSetSlotInput, inputChipSlotDefault, inputChipSlotAvatar
@docs inputChipSlotIcon, inputChipSlotRemoveIcon, filterChipSetSlotDefault, filterChipSlotDefault, filterChipSlotIcon, filterChipSlotTrailingIcon
@docs chipSetSlotDefault, assistChipSlotDefault, assistChipSlotIcon, chipSlotDefault, chipSlotIcon, chipSlotTrailingIcon
@docs cardSlotDefault, cardSlotHeader, cardSlotContent, cardSlotActions, cardSlotFooter, calendarSlotHeader
@docs tooltipSlotDefault, richTooltipSlotDefault, richTooltipSlotSubhead, richTooltipSlotActions, richTooltipActionSlotDefault, buttonGroupSlotDefault
@docs iconButtonSlotDefault, iconButtonSlotSelected, buttonSlotDefault, buttonSlotIcon, buttonSlotSelected, buttonSlotSelectedIcon
@docs buttonSlotTrailingIcon, breadcrumbSlotDefault, breadcrumbSlotSeparator, breadcrumbItemSlotDefault, breadcrumbItemSlotIcon, breadcrumbItemButtonSlotIcon
@docs breadcrumbItemButtonSlotDefault, bottomSheetTriggerSlotDefault, bottomSheetSlotDefault, bottomSheetSlotHeader, bottomSheetActionSlotDefault, badgeSlotDefault
@docs avatarSlotDefault, autocompleteSlotDefault, autocompleteSlotLoading, autocompleteSlotNoData, formFieldSlotDefault, formFieldSlotPrefix
@docs formFieldSlotPrefixText, formFieldSlotLabel, formFieldSlotSuffix, formFieldSlotSuffixText, formFieldSlotHint, formFieldSlotError
@docs optionPanelSlotDefault, optionPanelSlotNoData, optionPanelSlotLoading, floatingPanelSlotDefault, optgroupSlotDefault, optgroupSlotLabel
@docs optionSlotDefault, focusTrapSlotDefault, appBarSlotLeading, appBarSlotTitle, appBarSlotSubtitle, appBarSlotTrailing
@docs appBarSlotLeadingIcon, appBarSlotTrailingIcon, textOverflowSlotDefault, textHighlightSlotDefault, slideSlotDefault, scrollContainerSlotDefault
@docs collapsibleSlotDefault
-}


import Json.Decode
import M3e.Accordion
import M3e.ActionElementBase
import M3e.ActionList
import M3e.AppBar
import M3e.Aria
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
import M3e.FabMenuItem
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


{-| Convenience binding for the `M3e.StepperNext` element: `view` re-exposed from `M3e.StepperNext`. Import that module directly for the strict, component-scoped types. -}
stepperNext :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | stepperNext : M3e.Value.Supported } msg
stepperNext =
    M3e.StepperNext.view


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
    , valueFloat : M3e.Value.Supported
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
    , valueFloat : M3e.Value.Supported
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
    List (M3e.Cem.Attr.Attr { nameEnum : M3e.Value.Supported
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
    List (M3e.Cem.Attr.Attr { valueFloat : M3e.Value.Supported
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


{-| Convenience binding for the `M3e.FabMenuItem` element: `view` re-exposed from `M3e.FabMenuItem`. Import that module directly for the strict, component-scoped types. -}
fabMenuItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | fabMenuItem : M3e.Value.Supported } msg
fabMenuItem =
    M3e.FabMenuItem.view


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
attrAction :
    String -> M3e.Cem.Attr.Attr { c | action : M3e.Value.Supported } msg
attrAction =
    M3e.Cem.Vocab.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
attrActionable :
    Bool -> M3e.Cem.Attr.Attr { c | actionable : M3e.Value.Supported } msg
attrActionable =
    M3e.Cem.Vocab.actionable


{-| Whether the view is active. (default: `false`) -}
attrActive : Bool -> M3e.Cem.Attr.Attr { c | active : M3e.Value.Supported } msg
attrActive =
    M3e.Cem.Vocab.active


{-| The active date. (default: `new Date()`) -}
attrActiveDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
attrActiveDate =
    M3e.Cem.Vocab.activeDate


{-| Whether the dialog is an alert. (default: `false`) -}
attrAlert : Bool -> M3e.Cem.Attr.Attr { c | alert : M3e.Value.Supported } msg
attrAlert =
    M3e.Cem.Vocab.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
attrAnchorOffset :
    Float -> M3e.Cem.Attr.Attr { c | anchorOffset : M3e.Value.Supported } msg
attrAnchorOffset =
    M3e.Cem.Vocab.anchorOffset


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String -> M3e.Cem.Attr.Attr { c | ariaInvalid : M3e.Value.Supported } msg
ariaInvalid =
    M3e.Cem.Vocab.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`) -}
attrAutoActivate :
    Bool -> M3e.Cem.Attr.Attr { c | autoActivate : M3e.Value.Supported } msg
attrAutoActivate =
    M3e.Cem.Vocab.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
attrBufferValue :
    Float -> M3e.Cem.Attr.Attr { c | bufferValue : M3e.Value.Supported } msg
attrBufferValue =
    M3e.Cem.Vocab.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
attrCascade :
    Bool -> M3e.Cem.Attr.Attr { c | cascade : M3e.Value.Supported } msg
attrCascade =
    M3e.Cem.Vocab.cascade


{-| Whether filtering is case sensitive. (default: `false`) -}
attrCaseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
attrCaseSensitive =
    M3e.Cem.Vocab.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`) -}
attrCentered :
    Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
attrCentered =
    M3e.Cem.Vocab.centered


{-| Whether the element is checked. (default: `false`) -}
attrChecked :
    Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
attrChecked =
    M3e.Cem.Vocab.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
attrClearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
attrClearLabel =
    M3e.Cem.Vocab.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
attrClearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
attrClearable =
    M3e.Cem.Vocab.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
attrCloseLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
attrCloseLabel =
    M3e.Cem.Vocab.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
attrColor : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
attrColor =
    M3e.Cem.Vocab.color


{-| Whether the step has been completed. (default: `false`) -}
attrCompleted :
    Bool -> M3e.Cem.Attr.Attr { c | completed : M3e.Value.Supported } msg
attrCompleted =
    M3e.Cem.Vocab.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
attrConfirmLabel :
    String -> M3e.Cem.Attr.Attr { c | confirmLabel : M3e.Value.Supported } msg
attrConfirmLabel =
    M3e.Cem.Vocab.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
attrContained :
    Bool -> M3e.Cem.Attr.Attr { c | contained : M3e.Value.Supported } msg
attrContained =
    M3e.Cem.Vocab.contained


{-| The selected date. (default: `null`) -}
attrDate : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
attrDate =
    M3e.Cem.Vocab.date


{-| The density scale (0, -1, -2). (default: `0`) -}
attrDensity :
    Float -> M3e.Cem.Attr.Attr { c | density : M3e.Value.Supported } msg
attrDensity =
    M3e.Cem.Vocab.density


{-| The zero‑based index of the detent the sheet should open to. -}
attrDetent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
attrDetent =
    M3e.Cem.Vocab.detent


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
attrDisableClose :
    Bool -> M3e.Cem.Attr.Attr { c | disableClose : M3e.Value.Supported } msg
attrDisableClose =
    M3e.Cem.Vocab.disableClose


{-| Whether text highlighting is disabled. (default: `false`) -}
attrDisableHighlight :
    Bool -> M3e.Cem.Attr.Attr { c | disableHighlight : M3e.Value.Supported } msg
attrDisableHighlight =
    M3e.Cem.Vocab.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
attrDisableHover :
    Bool -> M3e.Cem.Attr.Attr { c | disableHover : M3e.Value.Supported } msg
attrDisableHover =
    M3e.Cem.Vocab.disableHover


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
attrDisableRestoreFocus :
    Bool
    -> M3e.Cem.Attr.Attr { c | disableRestoreFocus : M3e.Value.Supported } msg
attrDisableRestoreFocus =
    M3e.Cem.Vocab.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`) -}
attrDisabled :
    Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
attrDisabled =
    M3e.Cem.Vocab.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
attrDisabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
attrDisabledInteractive =
    M3e.Cem.Vocab.disabledInteractive


{-| Whether to show tick marks. (default: `false`) -}
attrDiscrete :
    Bool -> M3e.Cem.Attr.Attr { c | discrete : M3e.Value.Supported } msg
attrDiscrete =
    M3e.Cem.Vocab.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
attrDismissLabel :
    String -> M3e.Cem.Attr.Attr { c | dismissLabel : M3e.Value.Supported } msg
attrDismissLabel =
    M3e.Cem.Vocab.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
attrDismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
attrDismissible =
    M3e.Cem.Vocab.dismissible


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
attrDownload :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
attrDownload =
    M3e.Cem.Vocab.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
attrDuration :
    Float -> M3e.Cem.Attr.Attr { c | duration : M3e.Value.Supported } msg
attrDuration =
    M3e.Cem.Vocab.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
attrEditable :
    Bool -> M3e.Cem.Attr.Attr { c | editable : M3e.Value.Supported } msg
attrEditable =
    M3e.Cem.Vocab.editable


{-| Whether the toolbar is elevated. (default: `false`) -}
attrElevated :
    Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
attrElevated =
    M3e.Cem.Vocab.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
attrEmphasized :
    Bool -> M3e.Cem.Attr.Attr { c | emphasized : M3e.Value.Supported } msg
attrEmphasized =
    M3e.Cem.Vocab.emphasized


{-| Whether the end drawer is open. (default: `false`) -}
attrEnd : Bool -> M3e.Cem.Attr.Attr { c | end : M3e.Value.Supported } msg
attrEnd =
    M3e.Cem.Vocab.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
attrEndDivider :
    Bool -> M3e.Cem.Attr.Attr { c | endDivider : M3e.Value.Supported } msg
attrEndDivider =
    M3e.Cem.Vocab.endDivider


{-| Whether the button is extended to show the label. (default: `false`) -}
attrExtended :
    Bool -> M3e.Cem.Attr.Attr { c | extended : M3e.Value.Supported } msg
attrExtended =
    M3e.Cem.Vocab.extended


{-| Whether the icon is filled. (default: `false`) -}
attrFilled : Bool -> M3e.Cem.Attr.Attr { c | filled : M3e.Value.Supported } msg
attrFilled =
    M3e.Cem.Vocab.filled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
attrFirstPageLabel :
    String -> M3e.Cem.Attr.Attr { c | firstPageLabel : M3e.Value.Supported } msg
attrFirstPageLabel =
    M3e.Cem.Vocab.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
attrFitAnchorWidth :
    Bool -> M3e.Cem.Attr.Attr { c | fitAnchorWidth : M3e.Value.Supported } msg
attrFitAnchorWidth =
    M3e.Cem.Vocab.fitAnchorWidth


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
attrFor : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
attrFor =
    M3e.Cem.Vocab.for


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
attrHandle : Bool -> M3e.Cem.Attr.Attr { c | handle : M3e.Value.Supported } msg
attrHandle =
    M3e.Cem.Vocab.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
attrHandleLabel :
    String -> M3e.Cem.Attr.Attr { c | handleLabel : M3e.Value.Supported } msg
attrHandleLabel =
    M3e.Cem.Vocab.handleLabel


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
attrHideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
attrHideDelay =
    M3e.Cem.Vocab.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
attrHideFriction :
    Float -> M3e.Cem.Attr.Attr { c | hideFriction : M3e.Value.Supported } msg
attrHideFriction =
    M3e.Cem.Vocab.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`) -}
attrHideLoading :
    Bool -> M3e.Cem.Attr.Attr { c | hideLoading : M3e.Value.Supported } msg
attrHideLoading =
    M3e.Cem.Vocab.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
attrHideNoData :
    Bool -> M3e.Cem.Attr.Attr { c | hideNoData : M3e.Value.Supported } msg
attrHideNoData =
    M3e.Cem.Vocab.hideNoData


{-| Whether to hide page size selection. (default: `false`) -}
attrHidePageSize :
    Bool -> M3e.Cem.Attr.Attr { c | hidePageSize : M3e.Value.Supported } msg
attrHidePageSize =
    M3e.Cem.Vocab.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`) -}
attrHideRequiredMarker :
    Bool
    -> M3e.Cem.Attr.Attr { c | hideRequiredMarker : M3e.Value.Supported } msg
attrHideRequiredMarker =
    M3e.Cem.Vocab.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`) -}
attrHideSearchIcon :
    Bool -> M3e.Cem.Attr.Attr { c | hideSearchIcon : M3e.Value.Supported } msg
attrHideSearchIcon =
    M3e.Cem.Vocab.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`) -}
attrHideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
attrHideSelectionIndicator =
    M3e.Cem.Vocab.hideSelectionIndicator


{-| Whether to hide the expansion toggle. (default: `false`) -}
attrHideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
attrHideToggle =
    M3e.Cem.Vocab.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
attrHideable :
    Bool -> M3e.Cem.Attr.Attr { c | hideable : M3e.Value.Supported } msg
attrHideable =
    M3e.Cem.Vocab.hideable


{-| The URL to which the link button points. (default: `""`) -}
attrHref : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
attrHref =
    M3e.Cem.Vocab.href


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
attrIndeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
attrIndeterminate =
    M3e.Cem.Vocab.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
attrInline : Bool -> M3e.Cem.Attr.Attr { c | inline : M3e.Value.Supported } msg
attrInline =
    M3e.Cem.Vocab.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
attrInset : Bool -> M3e.Cem.Attr.Attr { c | inset : M3e.Value.Supported } msg
attrInset =
    M3e.Cem.Vocab.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
attrInsetEnd :
    Bool -> M3e.Cem.Attr.Attr { c | insetEnd : M3e.Value.Supported } msg
attrInsetEnd =
    M3e.Cem.Vocab.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
attrInsetStart :
    Bool -> M3e.Cem.Attr.Attr { c | insetStart : M3e.Value.Supported } msg
attrInsetStart =
    M3e.Cem.Vocab.insetStart


{-| Whether the step has an error. (default: `false`) -}
attrInvalid :
    Bool -> M3e.Cem.Attr.Attr { c | invalid : M3e.Value.Supported } msg
attrInvalid =
    M3e.Cem.Vocab.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
attrInward : Bool -> M3e.Cem.Attr.Attr { c | inward : M3e.Value.Supported } msg
attrInward =
    M3e.Cem.Vocab.inward


{-| The accessible label given to the item's internal button. (default: `""`) -}
attrItemLabel :
    String -> M3e.Cem.Attr.Attr { c | itemLabel : M3e.Value.Supported } msg
attrItemLabel =
    M3e.Cem.Vocab.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`) -}
attrItemsPerPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | itemsPerPageLabel : M3e.Value.Supported } msg
attrItemsPerPageLabel =
    M3e.Cem.Vocab.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
attrLabel : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
attrLabel =
    M3e.Cem.Vocab.label


{-| Whether to show value labels when activated. (default: `false`) -}
attrLabelled :
    Bool -> M3e.Cem.Attr.Attr { c | labelled : M3e.Value.Supported } msg
attrLabelled =
    M3e.Cem.Vocab.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
attrLastPageLabel :
    String -> M3e.Cem.Attr.Attr { c | lastPageLabel : M3e.Value.Supported } msg
attrLastPageLabel =
    M3e.Cem.Vocab.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`) -}
attrLength : Float -> M3e.Cem.Attr.Attr { c | length : M3e.Value.Supported } msg
attrLength =
    M3e.Cem.Vocab.length


{-| The accessibility level of the heading. -}
attrLevel : Int -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
attrLevel =
    M3e.Cem.Vocab.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
attrLinear : Bool -> M3e.Cem.Attr.Attr { c | linear : M3e.Value.Supported } msg
attrLinear =
    M3e.Cem.Vocab.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
attrLoaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
attrLoaded =
    M3e.Cem.Vocab.loaded


{-| Whether options are being loaded. (default: `false`) -}
attrLoading :
    Bool -> M3e.Cem.Attr.Attr { c | loading : M3e.Value.Supported } msg
attrLoading =
    M3e.Cem.Vocab.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
attrLoadingLabel :
    String -> M3e.Cem.Attr.Attr { c | loadingLabel : M3e.Value.Supported } msg
attrLoadingLabel =
    M3e.Cem.Vocab.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`) -}
attrLowered :
    Bool -> M3e.Cem.Attr.Attr { c | lowered : M3e.Value.Supported } msg
attrLowered =
    M3e.Cem.Vocab.lowered


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
attrMax : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
attrMax =
    M3e.Cem.Vocab.max


{-| The maximum date that can be selected. (default: `null`) -}
attrMaxDate :
    String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
attrMaxDate =
    M3e.Cem.Vocab.maxDate


{-| The maximum depth of the table of contents. (default: `2`) -}
attrMaxDepth :
    Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
attrMaxDepth =
    M3e.Cem.Vocab.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
attrMaxRows :
    Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
attrMaxRows =
    M3e.Cem.Vocab.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
attrMin : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
attrMin =
    M3e.Cem.Vocab.min


{-| The minimum date that can be selected. (default: `null`) -}
attrMinDate :
    String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
attrMinDate =
    M3e.Cem.Vocab.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
attrMinRows :
    Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
attrMinRows =
    M3e.Cem.Vocab.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
attrModal : Bool -> M3e.Cem.Attr.Attr { c | modal : M3e.Value.Supported } msg
attrModal =
    M3e.Cem.Vocab.modal


{-| Whether multiple items can be selected. (default: `false`) -}
attrMulti : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
attrMulti =
    M3e.Cem.Vocab.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
attrNextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
attrNextMonthLabel =
    M3e.Cem.Vocab.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
attrNextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
attrNextMultiYearLabel =
    M3e.Cem.Vocab.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
attrNextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
attrNextPageLabel =
    M3e.Cem.Vocab.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
attrNextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
attrNextYearLabel =
    M3e.Cem.Vocab.nextYearLabel


{-| Whether to disable animation. (default: `false`) -}
attrNoAnimate :
    Bool -> M3e.Cem.Attr.Attr { c | noAnimate : M3e.Value.Supported } msg
attrNoAnimate =
    M3e.Cem.Vocab.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
attrNoDataLabel :
    String -> M3e.Cem.Attr.Attr { c | noDataLabel : M3e.Value.Supported } msg
attrNoDataLabel =
    M3e.Cem.Vocab.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
attrNoFocusTrap :
    Bool -> M3e.Cem.Attr.Attr { c | noFocusTrap : M3e.Value.Supported } msg
attrNoFocusTrap =
    M3e.Cem.Vocab.noFocusTrap


{-| Whether the item is expanded. (default: `false`) -}
attrOpen : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
attrOpen =
    M3e.Cem.Vocab.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
attrOpticalSize :
    Float -> M3e.Cem.Attr.Attr { c | opticalSize : M3e.Value.Supported } msg
attrOpticalSize =
    M3e.Cem.Vocab.opticalSize


{-| Whether the step is optional. (default: `false`) -}
attrOptional :
    Bool -> M3e.Cem.Attr.Attr { c | optional : M3e.Value.Supported } msg
attrOptional =
    M3e.Cem.Vocab.optional


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
attrOvershootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
attrOvershootLimit =
    M3e.Cem.Vocab.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
attrPageIndex :
    Float -> M3e.Cem.Attr.Attr { c | pageIndex : M3e.Value.Supported } msg
attrPageIndex =
    M3e.Cem.Vocab.pageIndex


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
attrPageSizes :
    String -> M3e.Cem.Attr.Attr { c | pageSizes : M3e.Value.Supported } msg
attrPageSizes =
    M3e.Cem.Vocab.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
attrPanelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
attrPanelClass =
    M3e.Cem.Vocab.panelClass


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
attrPreviousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
attrPreviousMonthLabel =
    M3e.Cem.Vocab.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
attrPreviousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
attrPreviousMultiYearLabel =
    M3e.Cem.Vocab.previousMultiYearLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
attrPreviousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
attrPreviousPageLabel =
    M3e.Cem.Vocab.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
attrPreviousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
attrPreviousYearLabel =
    M3e.Cem.Vocab.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`) -}
attrRadius : Float -> M3e.Cem.Attr.Attr { c | radius : M3e.Value.Supported } msg
attrRadius =
    M3e.Cem.Vocab.radius


{-| Whether a range of dates can be selected. (default: `false`) -}
attrRange : Bool -> M3e.Cem.Attr.Attr { c | range : M3e.Value.Supported } msg
attrRange =
    M3e.Cem.Vocab.range


{-| End of a date range. (default: `null`) -}
attrRangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
attrRangeEnd =
    M3e.Cem.Vocab.rangeEnd


{-| Start of a date range. (default: `null`) -}
attrRangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
attrRangeStart =
    M3e.Cem.Vocab.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
attrRel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
attrRel =
    M3e.Cem.Vocab.rel


{-| Whether the chip is removable. (default: `false`) -}
attrRemovable :
    Bool -> M3e.Cem.Attr.Attr { c | removable : M3e.Value.Supported } msg
attrRemovable =
    M3e.Cem.Vocab.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
attrRemoveLabel :
    String -> M3e.Cem.Attr.Attr { c | removeLabel : M3e.Value.Supported } msg
attrRemoveLabel =
    M3e.Cem.Vocab.removeLabel


{-| Whether the element is required. (default: `false`) -}
attrRequired :
    Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
attrRequired =
    M3e.Cem.Vocab.required


{-| The value to return from the dialog. (default: `""`) -}
attrReturnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
attrReturnValue =
    M3e.Cem.Vocab.returnValue


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
attrSecondary :
    Bool -> M3e.Cem.Attr.Attr { c | secondary : M3e.Value.Supported } msg
attrSecondary =
    M3e.Cem.Vocab.secondary


{-| Whether the item is selected. (default: `false`) -}
attrSelected :
    Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
attrSelected =
    M3e.Cem.Vocab.selected


{-| The zero-based index of the visible item. (default: `null`) -}
attrSelectedIndex :
    Float -> M3e.Cem.Attr.Attr { c | selectedIndex : M3e.Value.Supported } msg
attrSelectedIndex =
    M3e.Cem.Vocab.selectedIndex


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
attrShowDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
attrShowDelay =
    M3e.Cem.Vocab.showDelay


{-| Whether to show first/last buttons. (default: `false`) -}
attrShowFirstLastButtons :
    Bool
    -> M3e.Cem.Attr.Attr { c | showFirstLastButtons : M3e.Value.Supported } msg
attrShowFirstLastButtons =
    M3e.Cem.Vocab.showFirstLastButtons


{-| Whether the start drawer is open. (default: `false`) -}
attrStart : Bool -> M3e.Cem.Attr.Attr { c | start : M3e.Value.Supported } msg
attrStart =
    M3e.Cem.Vocab.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
attrStartAt :
    String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
attrStartAt =
    M3e.Cem.Vocab.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
attrStartDivider :
    Bool -> M3e.Cem.Attr.Attr { c | startDivider : M3e.Value.Supported } msg
attrStartDivider =
    M3e.Cem.Vocab.startDivider


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
attrStep : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
attrStep =
    M3e.Cem.Vocab.step


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
attrStretch :
    Bool -> M3e.Cem.Attr.Attr { c | stretch : M3e.Value.Supported } msg
attrStretch =
    M3e.Cem.Vocab.stretch


{-| Whether to enable strong focus indicators. (default: `false`) -}
attrStrongFocus :
    Bool -> M3e.Cem.Attr.Attr { c | strongFocus : M3e.Value.Supported } msg
attrStrongFocus =
    M3e.Cem.Vocab.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
attrSubmenu :
    Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
attrSubmenu =
    M3e.Cem.Vocab.submenu


{-| The target of the link button. (default: `""`) -}
attrTarget :
    String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
attrTarget =
    M3e.Cem.Vocab.target


{-| The search term to highlight. (default: `""`) -}
attrTerm : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
attrTerm =
    M3e.Cem.Vocab.term


{-| Whether to present thin scrollbars. (default: `false`) -}
attrThin : Bool -> M3e.Cem.Attr.Attr { c | thin : M3e.Value.Supported } msg
attrThin =
    M3e.Cem.Vocab.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
attrThreshold :
    Float -> M3e.Cem.Attr.Attr { c | threshold : M3e.Value.Supported } msg
attrThreshold =
    M3e.Cem.Vocab.threshold


{-| Today's date. (default: `new Date()`) -}
attrToday : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
attrToday =
    M3e.Cem.Vocab.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
attrToggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
attrToggle =
    M3e.Cem.Vocab.toggle


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
attrUnbounded :
    Bool -> M3e.Cem.Attr.Attr { c | unbounded : M3e.Value.Supported } msg
attrUnbounded =
    M3e.Cem.Vocab.unbounded


{-| Whether the element is oriented vertically. (default: `false`) -}
attrVertical :
    Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
attrVertical =
    M3e.Cem.Vocab.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
attrWeight : Int -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
attrWeight =
    M3e.Cem.Vocab.weight


{-| Whether items wrap to a new line. (default: `false`) -}
attrWrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
attrWrap =
    M3e.Cem.Vocab.wrap


{-| Whether cycling through detents will wrap. (default: `false`) -}
attrWrapDetents :
    Bool -> M3e.Cem.Attr.Attr { c | wrapDetents : M3e.Value.Supported } msg
attrWrapDetents =
    M3e.Cem.Vocab.wrapDetents


{-| The name that identifies the element when submitting the associated form. -}
attrName : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
attrName =
    M3e.Cem.Vocab.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
attrValueFloat :
    Float -> M3e.Cem.Attr.Attr { c | valueFloat : M3e.Value.Supported } msg
attrValueFloat =
    M3e.Cem.Vocab.valueFloat


{-| A string representing the value of the switch. (default: `"on"`) -}
attrValue : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
attrValue =
    M3e.Cem.Vocab.value


{-| Set `animation="none"` — the `none` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`) -}
animationNone : M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animationNone =
    M3e.Cem.Vocab.animation M3e.Value.none


{-| Set `animation="pulse"` — the `pulse` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`) -}
animationPulse : M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animationPulse =
    M3e.Cem.Vocab.animation M3e.Value.pulse


{-| Set `animation="wave"` — the `wave` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`) -}
animationWave : M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animationWave =
    M3e.Cem.Vocab.animation M3e.Value.wave


{-| Set `contrast="high"` — the `high` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`) -}
contrastHigh : M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrastHigh =
    M3e.Cem.Vocab.contrast M3e.Value.high


{-| Set `contrast="medium"` — the `medium` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`) -}
contrastMedium : M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrastMedium =
    M3e.Cem.Vocab.contrast M3e.Value.medium


{-| Set `contrast="standard"` — the `standard` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`) -}
contrastStandard : M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrastStandard =
    M3e.Cem.Vocab.contrast M3e.Value.standard


{-| Set `current="date"` — the `date` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentDate : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentDate =
    M3e.Cem.Vocab.current M3e.Value.date


{-| Set `current="location"` — the `location` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentLocation : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentLocation =
    M3e.Cem.Vocab.current M3e.Value.location


{-| Set `current="page"` — the `page` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentPage : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentPage =
    M3e.Cem.Vocab.current M3e.Value.page


{-| Set `current="step"` — the `step` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentStep : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentStep =
    M3e.Cem.Vocab.current M3e.Value.step


{-| Set `current="time"` — the `time` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentTime : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentTime =
    M3e.Cem.Vocab.current M3e.Value.time


{-| Set `current="true"` — the `true` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path. -}
currentTrue : M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
currentTrue =
    M3e.Cem.Vocab.current M3e.Value.true


{-| Set `disable-pagination="true"` — the `true` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled. -}
disablePaginationTrue :
    M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePaginationTrue =
    M3e.Cem.Vocab.disablePagination M3e.Value.true


{-| Set `disable-pagination="false"` — the `false` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled. -}
disablePaginationFalse :
    M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePaginationFalse =
    M3e.Cem.Vocab.disablePagination M3e.Value.false


{-| Set `disable-pagination="auto"` — the `auto` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled. -}
disablePaginationAuto :
    M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePaginationAuto =
    M3e.Cem.Vocab.disablePagination M3e.Value.auto


{-| Set `dividers="above"` — the `above` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividersAbove : M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividersAbove =
    M3e.Cem.Vocab.dividers M3e.Value.above


{-| Set `dividers="aboveBelow"` — the `aboveBelow` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividersAboveBelow :
    M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividersAboveBelow =
    M3e.Cem.Vocab.dividers M3e.Value.aboveBelow


{-| Set `dividers="below"` — the `below` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividersBelow : M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividersBelow =
    M3e.Cem.Vocab.dividers M3e.Value.below


{-| Set `dividers="none"` — the `none` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividersNone : M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividersNone =
    M3e.Cem.Vocab.dividers M3e.Value.none


{-| Set `end-mode="auto"` — the `auto` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`) -}
endModeAuto : M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endModeAuto =
    M3e.Cem.Vocab.endMode M3e.Value.auto


{-| Set `end-mode="over"` — the `over` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`) -}
endModeOver : M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endModeOver =
    M3e.Cem.Vocab.endMode M3e.Value.over


{-| Set `end-mode="push"` — the `push` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`) -}
endModePush : M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endModePush =
    M3e.Cem.Vocab.endMode M3e.Value.push


{-| Set `end-mode="side"` — the `side` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`) -}
endModeSide : M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endModeSide =
    M3e.Cem.Vocab.endMode M3e.Value.side


{-| Set `filter="contains"` — the `contains` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`) -}
filterContains : M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filterContains =
    M3e.Cem.Vocab.filter M3e.Value.contains


{-| Set `filter="endsWith"` — the `endsWith` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`) -}
filterEndsWith : M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filterEndsWith =
    M3e.Cem.Vocab.filter M3e.Value.endsWith


{-| Set `filter="none"` — the `none` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`) -}
filterNone : M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filterNone =
    M3e.Cem.Vocab.filter M3e.Value.none


{-| Set `filter="startsWith"` — the `startsWith` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`) -}
filterStartsWith : M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filterStartsWith =
    M3e.Cem.Vocab.filter M3e.Value.startsWith


{-| Set `float-label="always"` — the `always` value of the `floatLabel` attribute, baked as a constant. Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabelAlways :
    M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabelAlways =
    M3e.Cem.Vocab.floatLabel M3e.Value.always


{-| Set `float-label="auto"` — the `auto` value of the `floatLabel` attribute, baked as a constant. Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabelAuto : M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabelAuto =
    M3e.Cem.Vocab.floatLabel M3e.Value.auto


{-| Set `grade="high"` — the `high` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`) -}
gradeHigh : M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
gradeHigh =
    M3e.Cem.Vocab.grade M3e.Value.high


{-| Set `grade="low"` — the `low` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`) -}
gradeLow : M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
gradeLow =
    M3e.Cem.Vocab.grade M3e.Value.low


{-| Set `grade="medium"` — the `medium` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`) -}
gradeMedium : M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
gradeMedium =
    M3e.Cem.Vocab.grade M3e.Value.medium


{-| Set `header-position="after"` — the `after` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`) -}
headerPositionAfter :
    M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPositionAfter =
    M3e.Cem.Vocab.headerPosition M3e.Value.after


{-| Set `header-position="before"` — the `before` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`) -}
headerPositionBefore :
    M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPositionBefore =
    M3e.Cem.Vocab.headerPosition M3e.Value.before


{-| Set `header-position="above"` — the `above` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`) -}
headerPositionAbove :
    M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPositionAbove =
    M3e.Cem.Vocab.headerPosition M3e.Value.above


{-| Set `header-position="below"` — the `below` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`) -}
headerPositionBelow :
    M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPositionBelow =
    M3e.Cem.Vocab.headerPosition M3e.Value.below


{-| Set `hide-subscript="always"` — the `always` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscriptAlways :
    M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscriptAlways =
    M3e.Cem.Vocab.hideSubscript M3e.Value.always


{-| Set `hide-subscript="auto"` — the `auto` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscriptAuto :
    M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscriptAuto =
    M3e.Cem.Vocab.hideSubscript M3e.Value.auto


{-| Set `hide-subscript="never"` — the `never` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscriptNever :
    M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscriptNever =
    M3e.Cem.Vocab.hideSubscript M3e.Value.never


{-| Set `highlight-mode="contains"` — the `contains` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`) -}
highlightModeContains :
    M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightModeContains =
    M3e.Cem.Vocab.highlightMode M3e.Value.contains


{-| Set `highlight-mode="endsWith"` — the `endsWith` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`) -}
highlightModeEndsWith :
    M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightModeEndsWith =
    M3e.Cem.Vocab.highlightMode M3e.Value.endsWith


{-| Set `highlight-mode="startsWith"` — the `startsWith` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`) -}
highlightModeStartsWith :
    M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightModeStartsWith =
    M3e.Cem.Vocab.highlightMode M3e.Value.startsWith


{-| Set `icons="both"` — the `both` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`) -}
iconsBoth : M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
iconsBoth =
    M3e.Cem.Vocab.icons M3e.Value.both


{-| Set `icons="none"` — the `none` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`) -}
iconsNone : M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
iconsNone =
    M3e.Cem.Vocab.icons M3e.Value.none


{-| Set `icons="selected"` — the `selected` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`) -}
iconsSelected : M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
iconsSelected =
    M3e.Cem.Vocab.icons M3e.Value.selected


{-| Set `label-position="below"` — the `below` value of the `labelPosition` attribute, baked as a constant. The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPositionBelow :
    M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPositionBelow =
    M3e.Cem.Vocab.labelPosition M3e.Value.below


{-| Set `label-position="end"` — the `end` value of the `labelPosition` attribute, baked as a constant. The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPositionEnd :
    M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPositionEnd =
    M3e.Cem.Vocab.labelPosition M3e.Value.end


{-| Set `mode="docked"` — the `docked` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeDocked : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeDocked =
    M3e.Cem.Vocab.mode M3e.Value.docked


{-| Set `mode="fullscreen"` — the `fullscreen` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeFullscreen : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeFullscreen =
    M3e.Cem.Vocab.mode M3e.Value.fullscreen


{-| Set `mode="buffer"` — the `buffer` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeBuffer : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeBuffer =
    M3e.Cem.Vocab.mode M3e.Value.buffer


{-| Set `mode="determinate"` — the `determinate` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeDeterminate : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeDeterminate =
    M3e.Cem.Vocab.mode M3e.Value.determinate


{-| Set `mode="indeterminate"` — the `indeterminate` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeIndeterminate : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeIndeterminate =
    M3e.Cem.Vocab.mode M3e.Value.indeterminate


{-| Set `mode="query"` — the `query` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeQuery : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeQuery =
    M3e.Cem.Vocab.mode M3e.Value.query


{-| Set `mode="auto"` — the `auto` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeAuto : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeAuto =
    M3e.Cem.Vocab.mode M3e.Value.auto


{-| Set `mode="compact"` — the `compact` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeCompact : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeCompact =
    M3e.Cem.Vocab.mode M3e.Value.compact


{-| Set `mode="expanded"` — the `expanded` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeExpanded : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeExpanded =
    M3e.Cem.Vocab.mode M3e.Value.expanded


{-| Set `mode="contains"` — the `contains` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeContains : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeContains =
    M3e.Cem.Vocab.mode M3e.Value.contains


{-| Set `mode="endsWith"` — the `endsWith` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeEndsWith : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeEndsWith =
    M3e.Cem.Vocab.mode M3e.Value.endsWith


{-| Set `mode="startsWith"` — the `startsWith` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`) -}
modeStartsWith : M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
modeStartsWith =
    M3e.Cem.Vocab.mode M3e.Value.startsWith


{-| Set `motion="expressive"` — the `expressive` value of the `motion` attribute, baked as a constant. The motion scheme. (default: `"standard"`) -}
motionExpressive : M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motionExpressive =
    M3e.Cem.Vocab.motion M3e.Value.expressive


{-| Set `motion="standard"` — the `standard` value of the `motion` attribute, baked as a constant. The motion scheme. (default: `"standard"`) -}
motionStandard : M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motionStandard =
    M3e.Cem.Vocab.motion M3e.Value.standard


{-| Set `orientation="auto"` — the `auto` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`) -}
orientationAuto :
    M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientationAuto =
    M3e.Cem.Vocab.orientation M3e.Value.auto


{-| Set `orientation="horizontal"` — the `horizontal` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`) -}
orientationHorizontal :
    M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientationHorizontal =
    M3e.Cem.Vocab.orientation M3e.Value.horizontal


{-| Set `orientation="vertical"` — the `vertical` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`) -}
orientationVertical :
    M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientationVertical =
    M3e.Cem.Vocab.orientation M3e.Value.vertical


{-| Set `page-size="all"` — the `all` value of the `pageSize` attribute, baked as a constant. The number of items to display in a page. (default: `50`) -}
pageSizeAll : M3e.Cem.Attr.Attr { c | pageSize : M3e.Value.Supported } msg
pageSizeAll =
    M3e.Cem.Vocab.pageSize M3e.Value.all


{-| Set `page-size-variant="filled"` — the `filled` value of the `pageSizeVariant` attribute, baked as a constant. The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariantFilled :
    M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariantFilled =
    M3e.Cem.Vocab.pageSizeVariant M3e.Value.filled


{-| Set `page-size-variant="outlined"` — the `outlined` value of the `pageSizeVariant` attribute, baked as a constant. The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariantOutlined :
    M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariantOutlined =
    M3e.Cem.Vocab.pageSizeVariant M3e.Value.outlined


{-| Set `position="above"` — the `above` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionAbove : M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionAbove =
    M3e.Cem.Vocab.position M3e.Value.above


{-| Set `position="aboveAfter"` — the `aboveAfter` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionAboveAfter :
    M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionAboveAfter =
    M3e.Cem.Vocab.position M3e.Value.aboveAfter


{-| Set `position="aboveBefore"` — the `aboveBefore` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionAboveBefore :
    M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionAboveBefore =
    M3e.Cem.Vocab.position M3e.Value.aboveBefore


{-| Set `position="after"` — the `after` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionAfter : M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionAfter =
    M3e.Cem.Vocab.position M3e.Value.after


{-| Set `position="before"` — the `before` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionBefore : M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionBefore =
    M3e.Cem.Vocab.position M3e.Value.before


{-| Set `position="below"` — the `below` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionBelow : M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionBelow =
    M3e.Cem.Vocab.position M3e.Value.below


{-| Set `position="belowAfter"` — the `belowAfter` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionBelowAfter :
    M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionBelowAfter =
    M3e.Cem.Vocab.position M3e.Value.belowAfter


{-| Set `position="belowBefore"` — the `belowBefore` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`) -}
positionBelowBefore :
    M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
positionBelowBefore =
    M3e.Cem.Vocab.position M3e.Value.belowBefore


{-| Set `position-x="after"` — the `after` value of the `positionX` attribute, baked as a constant. The position of the menu, on the x-axis. (default: `"after"`) -}
positionXAfter : M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionXAfter =
    M3e.Cem.Vocab.positionX M3e.Value.after


{-| Set `position-x="before"` — the `before` value of the `positionX` attribute, baked as a constant. The position of the menu, on the x-axis. (default: `"after"`) -}
positionXBefore : M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionXBefore =
    M3e.Cem.Vocab.positionX M3e.Value.before


{-| Set `position-y="above"` — the `above` value of the `positionY` attribute, baked as a constant. The position of the menu, on the y-axis. (default: `"below"`) -}
positionYAbove : M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionYAbove =
    M3e.Cem.Vocab.positionY M3e.Value.above


{-| Set `position-y="below"` — the `below` value of the `positionY` attribute, baked as a constant. The position of the menu, on the y-axis. (default: `"below"`) -}
positionYBelow : M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionYBelow =
    M3e.Cem.Vocab.positionY M3e.Value.below


{-| Set `scheme="auto"` — the `auto` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`) -}
schemeAuto : M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
schemeAuto =
    M3e.Cem.Vocab.scheme M3e.Value.auto


{-| Set `scheme="dark"` — the `dark` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`) -}
schemeDark : M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
schemeDark =
    M3e.Cem.Vocab.scheme M3e.Value.dark


{-| Set `scheme="light"` — the `light` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`) -}
schemeLight : M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
schemeLight =
    M3e.Cem.Vocab.scheme M3e.Value.light


{-| Set `scroll-strategy="hide"` — the `hide` value of the `scrollStrategy` attribute, baked as a constant. The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategyHide :
    M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategyHide =
    M3e.Cem.Vocab.scrollStrategy M3e.Value.hide


{-| Set `scroll-strategy="reposition"` — the `reposition` value of the `scrollStrategy` attribute, baked as a constant. The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategyReposition :
    M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategyReposition =
    M3e.Cem.Vocab.scrollStrategy M3e.Value.reposition


{-| Set `shape="auto"` — the `auto` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`) -}
shapeAuto : M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shapeAuto =
    M3e.Cem.Vocab.shape M3e.Value.auto


{-| Set `shape="circular"` — the `circular` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`) -}
shapeCircular : M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shapeCircular =
    M3e.Cem.Vocab.shape M3e.Value.circular


{-| Set `shape="rounded"` — the `rounded` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`) -}
shapeRounded : M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shapeRounded =
    M3e.Cem.Vocab.shape M3e.Value.rounded


{-| Set `shape="square"` — the `square` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`) -}
shapeSquare : M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shapeSquare =
    M3e.Cem.Vocab.shape M3e.Value.square


{-| Set `size="extraLarge"` — the `extraLarge` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`) -}
sizeExtraLarge : M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
sizeExtraLarge =
    M3e.Cem.Vocab.size M3e.Value.extraLarge


{-| Set `size="extraSmall"` — the `extraSmall` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`) -}
sizeExtraSmall : M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
sizeExtraSmall =
    M3e.Cem.Vocab.size M3e.Value.extraSmall


{-| Set `size="large"` — the `large` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`) -}
sizeLarge : M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
sizeLarge =
    M3e.Cem.Vocab.size M3e.Value.large


{-| Set `size="medium"` — the `medium` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`) -}
sizeMedium : M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
sizeMedium =
    M3e.Cem.Vocab.size M3e.Value.medium


{-| Set `size="small"` — the `small` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`) -}
sizeSmall : M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
sizeSmall =
    M3e.Cem.Vocab.size M3e.Value.small


{-| Set `start-mode="auto"` — the `auto` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`) -}
startModeAuto : M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startModeAuto =
    M3e.Cem.Vocab.startMode M3e.Value.auto


{-| Set `start-mode="over"` — the `over` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`) -}
startModeOver : M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startModeOver =
    M3e.Cem.Vocab.startMode M3e.Value.over


{-| Set `start-mode="push"` — the `push` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`) -}
startModePush : M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startModePush =
    M3e.Cem.Vocab.startMode M3e.Value.push


{-| Set `start-mode="side"` — the `side` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`) -}
startModeSide : M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startModeSide =
    M3e.Cem.Vocab.startMode M3e.Value.side


{-| Set `start-view="month"` — the `month` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`) -}
startViewMonth : M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startViewMonth =
    M3e.Cem.Vocab.startView M3e.Value.month


{-| Set `start-view="multiYear"` — the `multiYear` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`) -}
startViewMultiYear :
    M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startViewMultiYear =
    M3e.Cem.Vocab.startView M3e.Value.multiYear


{-| Set `start-view="year"` — the `year` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`) -}
startViewYear : M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startViewYear =
    M3e.Cem.Vocab.startView M3e.Value.year


{-| Set `state="content"` — the `content` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`) -}
stateContent : M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
stateContent =
    M3e.Cem.Vocab.state M3e.Value.content


{-| Set `state="loading"` — the `loading` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`) -}
stateLoading : M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
stateLoading =
    M3e.Cem.Vocab.state M3e.Value.loading


{-| Set `state="noData"` — the `noData` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`) -}
stateNoData : M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
stateNoData =
    M3e.Cem.Vocab.state M3e.Value.noData


{-| Set `toggle-direction="horizontal"` — the `horizontal` value of the `toggleDirection` attribute, baked as a constant. The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirectionHorizontal :
    M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirectionHorizontal =
    M3e.Cem.Vocab.toggleDirection M3e.Value.horizontal


{-| Set `toggle-direction="vertical"` — the `vertical` value of the `toggleDirection` attribute, baked as a constant. The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirectionVertical :
    M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirectionVertical =
    M3e.Cem.Vocab.toggleDirection M3e.Value.vertical


{-| Set `toggle-position="after"` — the `after` value of the `togglePosition` attribute, baked as a constant. The position of the expansion toggle. (default: `"after"`) -}
togglePositionAfter :
    M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePositionAfter =
    M3e.Cem.Vocab.togglePosition M3e.Value.after


{-| Set `toggle-position="before"` — the `before` value of the `togglePosition` attribute, baked as a constant. The position of the expansion toggle. (default: `"after"`) -}
togglePositionBefore :
    M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePositionBefore =
    M3e.Cem.Vocab.togglePosition M3e.Value.before


{-| Set `touch-gestures="auto"` — the `auto` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGesturesAuto :
    M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGesturesAuto =
    M3e.Cem.Vocab.touchGestures M3e.Value.auto


{-| Set `touch-gestures="off"` — the `off` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGesturesOff :
    M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGesturesOff =
    M3e.Cem.Vocab.touchGestures M3e.Value.off


{-| Set `touch-gestures="on"` — the `on` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGesturesOn :
    M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGesturesOn =
    M3e.Cem.Vocab.touchGestures M3e.Value.on


{-| Set `type="button"` — the `button` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`) -}
typeButton : M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
typeButton =
    M3e.Cem.Vocab.type_ M3e.Value.button


{-| Set `type="reset"` — the `reset` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`) -}
typeReset : M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
typeReset =
    M3e.Cem.Vocab.type_ M3e.Value.reset


{-| Set `type="submit"` — the `submit` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`) -}
typeSubmit : M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
typeSubmit =
    M3e.Cem.Vocab.type_ M3e.Value.submit


{-| Set `variant="content"` — the `content` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantContent : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantContent =
    M3e.Cem.Vocab.variant M3e.Value.content


{-| Set `variant="expressive"` — the `expressive` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantExpressive : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantExpressive =
    M3e.Cem.Vocab.variant M3e.Value.expressive


{-| Set `variant="fidelity"` — the `fidelity` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantFidelity : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantFidelity =
    M3e.Cem.Vocab.variant M3e.Value.fidelity


{-| Set `variant="fruitSalad"` — the `fruitSalad` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantFruitSalad : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantFruitSalad =
    M3e.Cem.Vocab.variant M3e.Value.fruitSalad


{-| Set `variant="monochrome"` — the `monochrome` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantMonochrome : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantMonochrome =
    M3e.Cem.Vocab.variant M3e.Value.monochrome


{-| Set `variant="neutral"` — the `neutral` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantNeutral : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantNeutral =
    M3e.Cem.Vocab.variant M3e.Value.neutral


{-| Set `variant="rainbow"` — the `rainbow` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantRainbow : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantRainbow =
    M3e.Cem.Vocab.variant M3e.Value.rainbow


{-| Set `variant="tonalSpot"` — the `tonalSpot` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantTonalSpot : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantTonalSpot =
    M3e.Cem.Vocab.variant M3e.Value.tonalSpot


{-| Set `variant="flat"` — the `flat` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantFlat : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantFlat =
    M3e.Cem.Vocab.variant M3e.Value.flat


{-| Set `variant="wavy"` — the `wavy` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantWavy : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantWavy =
    M3e.Cem.Vocab.variant M3e.Value.wavy


{-| Set `variant="vibrant"` — the `vibrant` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantVibrant : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantVibrant =
    M3e.Cem.Vocab.variant M3e.Value.vibrant


{-| Set `variant="contained"` — the `contained` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantContained : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantContained =
    M3e.Cem.Vocab.variant M3e.Value.contained


{-| Set `variant="uncontained"` — the `uncontained` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantUncontained : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantUncontained =
    M3e.Cem.Vocab.variant M3e.Value.uncontained


{-| Set `variant="segmented"` — the `segmented` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantSegmented : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantSegmented =
    M3e.Cem.Vocab.variant M3e.Value.segmented


{-| Set `variant="rounded"` — the `rounded` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantRounded : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantRounded =
    M3e.Cem.Vocab.variant M3e.Value.rounded


{-| Set `variant="sharp"` — the `sharp` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantSharp : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantSharp =
    M3e.Cem.Vocab.variant M3e.Value.sharp


{-| Set `variant="display"` — the `display` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantDisplay : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantDisplay =
    M3e.Cem.Vocab.variant M3e.Value.display


{-| Set `variant="headline"` — the `headline` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantHeadline : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantHeadline =
    M3e.Cem.Vocab.variant M3e.Value.headline


{-| Set `variant="label"` — the `label` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantLabel : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantLabel =
    M3e.Cem.Vocab.variant M3e.Value.label


{-| Set `variant="title"` — the `title` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantTitle : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantTitle =
    M3e.Cem.Vocab.variant M3e.Value.title


{-| Set `variant="primary"` — the `primary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantPrimary : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantPrimary =
    M3e.Cem.Vocab.variant M3e.Value.primary


{-| Set `variant="primaryContainer"` — the `primaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantPrimaryContainer :
    M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantPrimaryContainer =
    M3e.Cem.Vocab.variant M3e.Value.primaryContainer


{-| Set `variant="secondary"` — the `secondary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantSecondary : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantSecondary =
    M3e.Cem.Vocab.variant M3e.Value.secondary


{-| Set `variant="secondaryContainer"` — the `secondaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantSecondaryContainer :
    M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantSecondaryContainer =
    M3e.Cem.Vocab.variant M3e.Value.secondaryContainer


{-| Set `variant="surface"` — the `surface` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantSurface : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantSurface =
    M3e.Cem.Vocab.variant M3e.Value.surface


{-| Set `variant="tertiary"` — the `tertiary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantTertiary : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantTertiary =
    M3e.Cem.Vocab.variant M3e.Value.tertiary


{-| Set `variant="tertiaryContainer"` — the `tertiaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantTertiaryContainer :
    M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantTertiaryContainer =
    M3e.Cem.Vocab.variant M3e.Value.tertiaryContainer


{-| Set `variant="auto"` — the `auto` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantAuto : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantAuto =
    M3e.Cem.Vocab.variant M3e.Value.auto


{-| Set `variant="docked"` — the `docked` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantDocked : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantDocked =
    M3e.Cem.Vocab.variant M3e.Value.docked


{-| Set `variant="modal"` — the `modal` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantModal : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantModal =
    M3e.Cem.Vocab.variant M3e.Value.modal


{-| Set `variant="connected"` — the `connected` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantConnected : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantConnected =
    M3e.Cem.Vocab.variant M3e.Value.connected


{-| Set `variant="standard"` — the `standard` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantStandard : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantStandard =
    M3e.Cem.Vocab.variant M3e.Value.standard


{-| Set `variant="elevated"` — the `elevated` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantElevated : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantElevated =
    M3e.Cem.Vocab.variant M3e.Value.elevated


{-| Set `variant="text"` — the `text` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantText : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantText =
    M3e.Cem.Vocab.variant M3e.Value.text


{-| Set `variant="tonal"` — the `tonal` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantTonal : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantTonal =
    M3e.Cem.Vocab.variant M3e.Value.tonal


{-| Set `variant="filled"` — the `filled` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantFilled : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantFilled =
    M3e.Cem.Vocab.variant M3e.Value.filled


{-| Set `variant="outlined"` — the `outlined` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`) -}
variantOutlined : M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variantOutlined =
    M3e.Cem.Vocab.variant M3e.Value.outlined


{-| Set `width="default"` — the `default` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`) -}
widthDefault : M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
widthDefault =
    M3e.Cem.Vocab.width M3e.Value.default


{-| Set `width="narrow"` — the `narrow` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`) -}
widthNarrow : M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
widthNarrow =
    M3e.Cem.Vocab.width M3e.Value.narrow


{-| Set `width="wide"` — the `wide` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`) -}
widthWide : M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
widthWide =
    M3e.Cem.Vocab.width M3e.Value.wide


{-| Set `aria-label` on any component (universal accessibility setter, re-exposed from `M3e.Aria`). -}
ariaLabel : String -> M3e.Cem.Attr.Attr capability msg
ariaLabel =
    M3e.Aria.label


{-| Set `aria-labelledby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`). -}
ariaLabelledby : String -> M3e.Cem.Attr.Attr capability msg
ariaLabelledby =
    M3e.Aria.labelledby


{-| Set `aria-describedby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`). -}
ariaDescribedby : String -> M3e.Cem.Attr.Attr capability msg
ariaDescribedby =
    M3e.Aria.describedby


{-| Set `aria-hidden` on any component (universal accessibility setter, re-exposed from `M3e.Aria`). -}
ariaHidden : String -> M3e.Cem.Attr.Attr capability msg
ariaHidden =
    M3e.Aria.hidden


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


{-| Place content in the `(default)` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotDefault`. -}
slotDefault :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
slotDefault =
    M3e.Cem.Vocab.slotDefault


{-| Place content in the `leading` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLeading`. -}
slotLeading :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
slotLeading =
    M3e.Cem.Vocab.slotLeading


{-| Place content in the `title` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotTitle`. -}
slotTitle :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
slotTitle =
    M3e.Cem.Vocab.slotTitle


{-| Place content in the `subtitle` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSubtitle`. -}
slotSubtitle :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | subtitle : M3e.Value.Supported } msg
slotSubtitle =
    M3e.Cem.Vocab.slotSubtitle


{-| Place content in the `trailing` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotTrailing`. -}
slotTrailing :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
slotTrailing =
    M3e.Cem.Vocab.slotTrailing


{-| Place content in the `leading-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLeadingIcon`. -}
slotLeadingIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | leadingIcon : M3e.Value.Supported } msg
slotLeadingIcon =
    M3e.Cem.Vocab.slotLeadingIcon


{-| Place content in the `trailing-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotTrailingIcon`. -}
slotTrailingIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
slotTrailingIcon =
    M3e.Cem.Vocab.slotTrailingIcon


{-| Place content in the `icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotIcon`. -}
slotIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
slotIcon =
    M3e.Cem.Vocab.slotIcon


{-| Place content in the `loading` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLoading`. -}
slotLoading :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
slotLoading =
    M3e.Cem.Vocab.slotLoading


{-| Place content in the `no-data` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotNoData`. -}
slotNoData :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
slotNoData =
    M3e.Cem.Vocab.slotNoData


{-| Place content in the `header` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotHeader`. -}
slotHeader :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
slotHeader =
    M3e.Cem.Vocab.slotHeader


{-| Place content in the `separator` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSeparator`. -}
slotSeparator :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | separator : M3e.Value.Supported } msg
slotSeparator =
    M3e.Cem.Vocab.slotSeparator


{-| Place content in the `selected` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSelected`. -}
slotSelected :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
slotSelected =
    M3e.Cem.Vocab.slotSelected


{-| Place content in the `selected-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSelectedIcon`. -}
slotSelectedIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
slotSelectedIcon =
    M3e.Cem.Vocab.slotSelectedIcon


{-| Place content in the `content` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotContent`. -}
slotContent :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | content : M3e.Value.Supported } msg
slotContent =
    M3e.Cem.Vocab.slotContent


{-| Place content in the `actions` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotActions`. -}
slotActions :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
slotActions =
    M3e.Cem.Vocab.slotActions


{-| Place content in the `footer` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotFooter`. -}
slotFooter :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | footer : M3e.Value.Supported } msg
slotFooter =
    M3e.Cem.Vocab.slotFooter


{-| Place content in the `close-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotCloseIcon`. -}
slotCloseIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
slotCloseIcon =
    M3e.Cem.Vocab.slotCloseIcon


{-| Place content in the `start` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotStart`. -}
slotStart :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
slotStart =
    M3e.Cem.Vocab.slotStart


{-| Place content in the `end` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotEnd`. -}
slotEnd :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
slotEnd =
    M3e.Cem.Vocab.slotEnd


{-| Place content in the `overline` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotOverline`. -}
slotOverline :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
slotOverline =
    M3e.Cem.Vocab.slotOverline


{-| Place content in the `supporting-text` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSupportingText`. -}
slotSupportingText :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
slotSupportingText =
    M3e.Cem.Vocab.slotSupportingText


{-| Place content in the `toggle-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotToggleIcon`. -}
slotToggleIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
slotToggleIcon =
    M3e.Cem.Vocab.slotToggleIcon


{-| Place content in the `items` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotItems`. -}
slotItems :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | items : M3e.Value.Supported } msg
slotItems =
    M3e.Cem.Vocab.slotItems


{-| Place content in the `label` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLabel`. -}
slotLabel :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
slotLabel =
    M3e.Cem.Vocab.slotLabel


{-| Place content in the `prefix` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotPrefix`. -}
slotPrefix :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | prefix : M3e.Value.Supported } msg
slotPrefix =
    M3e.Cem.Vocab.slotPrefix


{-| Place content in the `prefix-text` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotPrefixText`. -}
slotPrefixText :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | prefixText : M3e.Value.Supported } msg
slotPrefixText =
    M3e.Cem.Vocab.slotPrefixText


{-| Place content in the `suffix` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSuffix`. -}
slotSuffix :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | suffix : M3e.Value.Supported } msg
slotSuffix =
    M3e.Cem.Vocab.slotSuffix


{-| Place content in the `suffix-text` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSuffixText`. -}
slotSuffixText :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | suffixText : M3e.Value.Supported } msg
slotSuffixText =
    M3e.Cem.Vocab.slotSuffixText


{-| Place content in the `hint` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotHint`. -}
slotHint :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | hint : M3e.Value.Supported } msg
slotHint =
    M3e.Cem.Vocab.slotHint


{-| Place content in the `error` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotError`. -}
slotError :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | error : M3e.Value.Supported } msg
slotError =
    M3e.Cem.Vocab.slotError


{-| Place content in the `avatar` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotAvatar`. -}
slotAvatar :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | avatar : M3e.Value.Supported } msg
slotAvatar =
    M3e.Cem.Vocab.slotAvatar


{-| Place content in the `remove-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotRemoveIcon`. -}
slotRemoveIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | removeIcon : M3e.Value.Supported } msg
slotRemoveIcon =
    M3e.Cem.Vocab.slotRemoveIcon


{-| Place content in the `input` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotInput`. -}
slotInput :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
slotInput =
    M3e.Cem.Vocab.slotInput


{-| Place content in the `badge` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotBadge`. -}
slotBadge :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | badge : M3e.Value.Supported } msg
slotBadge =
    M3e.Cem.Vocab.slotBadge


{-| Place content in the `first-page-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotFirstPageIcon`. -}
slotFirstPageIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | firstPageIcon : M3e.Value.Supported } msg
slotFirstPageIcon =
    M3e.Cem.Vocab.slotFirstPageIcon


{-| Place content in the `previous-page-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotPreviousPageIcon`. -}
slotPreviousPageIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | previousPageIcon : M3e.Value.Supported } msg
slotPreviousPageIcon =
    M3e.Cem.Vocab.slotPreviousPageIcon


{-| Place content in the `next-page-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotNextPageIcon`. -}
slotNextPageIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | nextPageIcon : M3e.Value.Supported } msg
slotNextPageIcon =
    M3e.Cem.Vocab.slotNextPageIcon


{-| Place content in the `last-page-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLastPageIcon`. -}
slotLastPageIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | lastPageIcon : M3e.Value.Supported } msg
slotLastPageIcon =
    M3e.Cem.Vocab.slotLastPageIcon


{-| Place content in the `subhead` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSubhead`. -}
slotSubhead :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | subhead : M3e.Value.Supported } msg
slotSubhead =
    M3e.Cem.Vocab.slotSubhead


{-| Place content in the `clear-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotClearIcon`. -}
slotClearIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | clearIcon : M3e.Value.Supported } msg
slotClearIcon =
    M3e.Cem.Vocab.slotClearIcon


{-| Place content in the `open-leading` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotOpenLeading`. -}
slotOpenLeading :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | openLeading : M3e.Value.Supported } msg
slotOpenLeading =
    M3e.Cem.Vocab.slotOpenLeading


{-| Place content in the `open-trailing` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotOpenTrailing`. -}
slotOpenTrailing :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | openTrailing : M3e.Value.Supported } msg
slotOpenTrailing =
    M3e.Cem.Vocab.slotOpenTrailing


{-| Place content in the `closed-leading` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotClosedLeading`. -}
slotClosedLeading :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | closedLeading : M3e.Value.Supported } msg
slotClosedLeading =
    M3e.Cem.Vocab.slotClosedLeading


{-| Place content in the `closed-trailing` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotClosedTrailing`. -}
slotClosedTrailing :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | closedTrailing : M3e.Value.Supported } msg
slotClosedTrailing =
    M3e.Cem.Vocab.slotClosedTrailing


{-| Place content in the `search-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotSearchIcon`. -}
slotSearchIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | searchIcon : M3e.Value.Supported } msg
slotSearchIcon =
    M3e.Cem.Vocab.slotSearchIcon


{-| Place content in the `arrow` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotArrow`. -}
slotArrow :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | arrow : M3e.Value.Supported } msg
slotArrow =
    M3e.Cem.Vocab.slotArrow


{-| Place content in the `value` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotValue`. -}
slotValue :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | value : M3e.Value.Supported } msg
slotValue =
    M3e.Cem.Vocab.slotValue


{-| Place content in the `next-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotNextIcon`. -}
slotNextIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
slotNextIcon =
    M3e.Cem.Vocab.slotNextIcon


{-| Place content in the `prev-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotPrevIcon`. -}
slotPrevIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
slotPrevIcon =
    M3e.Cem.Vocab.slotPrevIcon


{-| Place content in the `leading-button` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotLeadingButton`. -}
slotLeadingButton :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | leadingButton : M3e.Value.Supported } msg
slotLeadingButton =
    M3e.Cem.Vocab.slotLeadingButton


{-| Place content in the `trailing-button` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotTrailingButton`. -}
slotTrailingButton :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | trailingButton : M3e.Value.Supported } msg
slotTrailingButton =
    M3e.Cem.Vocab.slotTrailingButton


{-| Place content in the `done-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotDoneIcon`. -}
slotDoneIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | doneIcon : M3e.Value.Supported } msg
slotDoneIcon =
    M3e.Cem.Vocab.slotDoneIcon


{-| Place content in the `edit-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotEditIcon`. -}
slotEditIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | editIcon : M3e.Value.Supported } msg
slotEditIcon =
    M3e.Cem.Vocab.slotEditIcon


{-| Place content in the `error-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotErrorIcon`. -}
slotErrorIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | errorIcon : M3e.Value.Supported } msg
slotErrorIcon =
    M3e.Cem.Vocab.slotErrorIcon


{-| Place content in the `step` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotStep`. -}
slotStep :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | step : M3e.Value.Supported } msg
slotStep =
    M3e.Cem.Vocab.slotStep


{-| Place content in the `panel` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotPanel`. -}
slotPanel :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
slotPanel =
    M3e.Cem.Vocab.slotPanel


{-| Place content in the `open-toggle-icon` slot (component-agnostic; element kind loose). The kind-safe per-component form is `<component>SlotOpenToggleIcon`. -}
slotOpenToggleIcon :
    M3e.Element.Element k msg
    -> M3e.Content.Content { r | openToggleIcon : M3e.Value.Supported } msg
slotOpenToggleIcon =
    M3e.Cem.Vocab.slotOpenToggleIcon


{-| Kind-safe `(default)` slot setter for `M3e.Tree`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
treeSlotDefault :
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
treeSlotDefault =
    M3e.Tree.child


{-| Kind-safe `(default)` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
treeItemSlotDefault :
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
treeItemSlotDefault =
    M3e.TreeItem.child


{-| Kind-safe `label` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
treeItemSlotLabel :
    M3e.Element.Element { text : M3e.Value.Supported
    , link : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
treeItemSlotLabel =
    M3e.TreeItem.label


{-| Kind-safe `icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
treeItemSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
treeItemSlotIcon =
    M3e.TreeItem.icon


{-| Kind-safe `selected-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`. -}
treeItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
treeItemSlotSelectedIcon =
    M3e.TreeItem.selectedIcon


{-| Kind-safe `toggle-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`. -}
treeItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
treeItemSlotToggleIcon =
    M3e.TreeItem.toggleIcon


{-| Kind-safe `open-toggle-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotOpenToggleIcon`. -}
treeItemSlotOpenToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | openToggleIcon : M3e.Value.Supported } msg
treeItemSlotOpenToggleIcon =
    M3e.TreeItem.openToggleIcon


{-| Kind-safe `(default)` slot setter for `M3e.Toolbar`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
toolbarSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
toolbarSlotDefault =
    M3e.Toolbar.child


{-| Kind-safe `(default)` slot setter for `M3e.Toc`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tocSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tocSlotDefault =
    M3e.Toc.child


{-| Kind-safe `overline` slot setter for `M3e.Toc`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
tocSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
tocSlotOverline =
    M3e.Toc.overline


{-| Kind-safe `title` slot setter for `M3e.Toc`, re-exposed flat. The loose, component-agnostic form is `slotTitle`. -}
tocSlotTitle :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
tocSlotTitle =
    M3e.Toc.title


{-| Kind-safe `(default)` slot setter for `M3e.TocItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tocItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tocItemSlotDefault =
    M3e.TocItem.child


{-| Kind-safe `(default)` slot setter for `M3e.Theme`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
themeSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
themeSlotDefault =
    M3e.Theme.child


{-| Kind-safe `(default)` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tabsSlotDefault :
    M3e.Element.Element { tab : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tabsSlotDefault =
    M3e.Tabs.child


{-| Kind-safe `panel` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotPanel`. -}
tabsSlotPanel :
    M3e.Element.Element { tabPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
tabsSlotPanel =
    M3e.Tabs.panel


{-| Kind-safe `next-icon` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotNextIcon`. -}
tabsSlotNextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
tabsSlotNextIcon =
    M3e.Tabs.nextIcon


{-| Kind-safe `prev-icon` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotPrevIcon`. -}
tabsSlotPrevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
tabsSlotPrevIcon =
    M3e.Tabs.prevIcon


{-| Kind-safe `(default)` slot setter for `M3e.TabPanel`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tabPanelSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tabPanelSlotDefault =
    M3e.TabPanel.child


{-| Kind-safe `(default)` slot setter for `M3e.Tab`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tabSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tabSlotDefault =
    M3e.Tab.child


{-| Kind-safe `icon` slot setter for `M3e.Tab`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
tabSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
tabSlotIcon =
    M3e.Tab.icon


{-| Kind-safe `(default)` slot setter for `M3e.StepperReset`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
stepperResetSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
stepperResetSlotDefault =
    M3e.StepperReset.child


{-| Kind-safe `(default)` slot setter for `M3e.StepperPrevious`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
stepperPreviousSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
stepperPreviousSlotDefault =
    M3e.StepperPrevious.child


{-| Kind-safe `(default)` slot setter for `M3e.StepperNext`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
stepperNextSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
stepperNextSlotDefault =
    M3e.StepperNext.child


{-| Kind-safe `(default)` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
stepSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
stepSlotDefault =
    M3e.Step.child


{-| Kind-safe `icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
stepSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
stepSlotIcon =
    M3e.Step.icon


{-| Kind-safe `done-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotDoneIcon`. -}
stepSlotDoneIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | doneIcon : M3e.Value.Supported } msg
stepSlotDoneIcon =
    M3e.Step.doneIcon


{-| Kind-safe `edit-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotEditIcon`. -}
stepSlotEditIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | editIcon : M3e.Value.Supported } msg
stepSlotEditIcon =
    M3e.Step.editIcon


{-| Kind-safe `error-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotErrorIcon`. -}
stepSlotErrorIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | errorIcon : M3e.Value.Supported } msg
stepSlotErrorIcon =
    M3e.Step.errorIcon


{-| Kind-safe `hint` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotHint`. -}
stepSlotHint :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | hint : M3e.Value.Supported } msg
stepSlotHint =
    M3e.Step.hint


{-| Kind-safe `error` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotError`. -}
stepSlotError :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | error : M3e.Value.Supported } msg
stepSlotError =
    M3e.Step.error


{-| Kind-safe `(default)` slot setter for `M3e.StepPanel`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
stepPanelSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
stepPanelSlotDefault =
    M3e.StepPanel.child


{-| Kind-safe `actions` slot setter for `M3e.StepPanel`, re-exposed flat. The loose, component-agnostic form is `slotActions`. -}
stepPanelSlotActions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
stepPanelSlotActions =
    M3e.StepPanel.actions


{-| Kind-safe `step` slot setter for `M3e.Stepper`, re-exposed flat. The loose, component-agnostic form is `slotStep`. -}
stepperSlotStep :
    M3e.Element.Element { step : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | step : M3e.Value.Supported } msg
stepperSlotStep =
    M3e.Stepper.step


{-| Kind-safe `panel` slot setter for `M3e.Stepper`, re-exposed flat. The loose, component-agnostic form is `slotPanel`. -}
stepperSlotPanel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
stepperSlotPanel =
    M3e.Stepper.panel


{-| Kind-safe `start` slot setter for `M3e.SplitPane`, re-exposed flat. The loose, component-agnostic form is `slotStart`. -}
splitPaneSlotStart :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
splitPaneSlotStart =
    M3e.SplitPane.start


{-| Kind-safe `end` slot setter for `M3e.SplitPane`, re-exposed flat. The loose, component-agnostic form is `slotEnd`. -}
splitPaneSlotEnd :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
splitPaneSlotEnd =
    M3e.SplitPane.end


{-| Kind-safe `leading-button` slot setter for `M3e.SplitButton`, re-exposed flat. The loose, component-agnostic form is `slotLeadingButton`. -}
splitButtonSlotLeadingButton :
    M3e.Element.Element { button : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | leadingButton : M3e.Value.Supported } msg
splitButtonSlotLeadingButton =
    M3e.SplitButton.leadingButton


{-| Kind-safe `trailing-button` slot setter for `M3e.SplitButton`, re-exposed flat. The loose, component-agnostic form is `slotTrailingButton`. -}
splitButtonSlotTrailingButton :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingButton : M3e.Value.Supported } msg
splitButtonSlotTrailingButton =
    M3e.SplitButton.trailingButton


{-| Kind-safe `(default)` slot setter for `M3e.Snackbar`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
snackbarSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
snackbarSlotDefault =
    M3e.Snackbar.child


{-| Kind-safe `close-icon` slot setter for `M3e.Snackbar`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`. -}
snackbarSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
snackbarSlotCloseIcon =
    M3e.Snackbar.closeIcon


{-| Kind-safe `(default)` slot setter for `M3e.Slider`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
sliderSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
sliderSlotDefault =
    M3e.Slider.child


{-| Kind-safe `(default)` slot setter for `M3e.SlideGroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
slideGroupSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
slideGroupSlotDefault =
    M3e.SlideGroup.child


{-| Kind-safe `next-icon` slot setter for `M3e.SlideGroup`, re-exposed flat. The loose, component-agnostic form is `slotNextIcon`. -}
slideGroupSlotNextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
slideGroupSlotNextIcon =
    M3e.SlideGroup.nextIcon


{-| Kind-safe `prev-icon` slot setter for `M3e.SlideGroup`, re-exposed flat. The loose, component-agnostic form is `slotPrevIcon`. -}
slideGroupSlotPrevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
slideGroupSlotPrevIcon =
    M3e.SlideGroup.prevIcon


{-| Kind-safe `(default)` slot setter for `M3e.Skeleton`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
skeletonSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
skeletonSlotDefault =
    M3e.Skeleton.child


{-| Kind-safe `(default)` slot setter for `M3e.Shape`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
shapeSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
shapeSlotDefault =
    M3e.Shape.child


{-| Kind-safe `(default)` slot setter for `M3e.SegmentedButton`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
segmentedButtonSlotDefault :
    M3e.Element.Element { buttonSegment : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
segmentedButtonSlotDefault =
    M3e.SegmentedButton.child


{-| Kind-safe `(default)` slot setter for `M3e.ButtonSegment`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
buttonSegmentSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
buttonSegmentSlotDefault =
    M3e.ButtonSegment.child


{-| Kind-safe `icon` slot setter for `M3e.ButtonSegment`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
buttonSegmentSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
buttonSegmentSlotIcon =
    M3e.ButtonSegment.icon


{-| Kind-safe `(default)` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
searchViewSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
searchViewSlotDefault =
    M3e.SearchView.child


{-| Kind-safe `input` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotInput`. -}
searchViewSlotInput :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
searchViewSlotInput =
    M3e.SearchView.input


{-| Kind-safe `open-leading` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotOpenLeading`. -}
searchViewSlotOpenLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | openLeading : M3e.Value.Supported } msg
searchViewSlotOpenLeading =
    M3e.SearchView.openLeading


{-| Kind-safe `open-trailing` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotOpenTrailing`. -}
searchViewSlotOpenTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | openTrailing : M3e.Value.Supported } msg
searchViewSlotOpenTrailing =
    M3e.SearchView.openTrailing


{-| Kind-safe `closed-leading` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClosedLeading`. -}
searchViewSlotClosedLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | closedLeading : M3e.Value.Supported } msg
searchViewSlotClosedLeading =
    M3e.SearchView.closedLeading


{-| Kind-safe `closed-trailing` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClosedTrailing`. -}
searchViewSlotClosedTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | closedTrailing : M3e.Value.Supported } msg
searchViewSlotClosedTrailing =
    M3e.SearchView.closedTrailing


{-| Kind-safe `search-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotSearchIcon`. -}
searchViewSlotSearchIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | searchIcon : M3e.Value.Supported } msg
searchViewSlotSearchIcon =
    M3e.SearchView.searchIcon


{-| Kind-safe `close-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`. -}
searchViewSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
searchViewSlotCloseIcon =
    M3e.SearchView.closeIcon


{-| Kind-safe `clear-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClearIcon`. -}
searchViewSlotClearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | clearIcon : M3e.Value.Supported } msg
searchViewSlotClearIcon =
    M3e.SearchView.clearIcon


{-| Kind-safe `leading` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
searchBarSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
searchBarSlotLeading =
    M3e.SearchBar.leading


{-| Kind-safe `input` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotInput`. -}
searchBarSlotInput :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
searchBarSlotInput =
    M3e.SearchBar.input


{-| Kind-safe `trailing` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
searchBarSlotTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
searchBarSlotTrailing =
    M3e.SearchBar.trailing


{-| Kind-safe `clear-icon` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotClearIcon`. -}
searchBarSlotClearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | clearIcon : M3e.Value.Supported } msg
searchBarSlotClearIcon =
    M3e.SearchBar.clearIcon


{-| Kind-safe `(default)` slot setter for `M3e.RadioGroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
radioGroupSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
radioGroupSlotDefault =
    M3e.RadioGroup.child


{-| Kind-safe `first-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotFirstPageIcon`. -}
paginatorSlotFirstPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | firstPageIcon : M3e.Value.Supported } msg
paginatorSlotFirstPageIcon =
    M3e.Paginator.firstPageIcon


{-| Kind-safe `previous-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotPreviousPageIcon`. -}
paginatorSlotPreviousPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | previousPageIcon : M3e.Value.Supported } msg
paginatorSlotPreviousPageIcon =
    M3e.Paginator.previousPageIcon


{-| Kind-safe `next-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotNextPageIcon`. -}
paginatorSlotNextPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextPageIcon : M3e.Value.Supported } msg
paginatorSlotNextPageIcon =
    M3e.Paginator.nextPageIcon


{-| Kind-safe `last-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotLastPageIcon`. -}
paginatorSlotLastPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | lastPageIcon : M3e.Value.Supported } msg
paginatorSlotLastPageIcon =
    M3e.Paginator.lastPageIcon


{-| Kind-safe `(default)` slot setter for `M3e.Select`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
selectSlotDefault :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
selectSlotDefault =
    M3e.Select.child


{-| Kind-safe `arrow` slot setter for `M3e.Select`, re-exposed flat. The loose, component-agnostic form is `slotArrow`. -}
selectSlotArrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | arrow : M3e.Value.Supported } msg
selectSlotArrow =
    M3e.Select.arrow


{-| Kind-safe `value` slot setter for `M3e.Select`, re-exposed flat. The loose, component-agnostic form is `slotValue`. -}
selectSlotValue :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | value : M3e.Value.Supported } msg
selectSlotValue =
    M3e.Select.value


{-| Kind-safe `(default)` slot setter for `M3e.NavRailToggle`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navRailToggleSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navRailToggleSlotDefault =
    M3e.NavRailToggle.child


{-| Kind-safe `(default)` slot setter for `M3e.NavRail`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navRailSlotDefault :
    M3e.Element.Element { navItem : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , fab : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navRailSlotDefault =
    M3e.NavRail.child


{-| Kind-safe `label` slot setter for `M3e.NavMenuItemGroup`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
navMenuItemGroupSlotLabel :
    M3e.Element.Element { text : M3e.Value.Supported
    , heading : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
navMenuItemGroupSlotLabel =
    M3e.NavMenuItemGroup.label


{-| Kind-safe `(default)` slot setter for `M3e.NavMenuItemGroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navMenuItemGroupSlotDefault :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navMenuItemGroupSlotDefault =
    M3e.NavMenuItemGroup.child


{-| Kind-safe `(default)` slot setter for `M3e.NavMenu`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navMenuSlotDefault :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported
    , navMenuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navMenuSlotDefault =
    M3e.NavMenu.child


{-| Kind-safe `(default)` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navMenuItemSlotDefault :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navMenuItemSlotDefault =
    M3e.NavMenuItem.child


{-| Kind-safe `label` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
navMenuItemSlotLabel :
    M3e.Element.Element { text : M3e.Value.Supported
    , link : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
navMenuItemSlotLabel =
    M3e.NavMenuItem.label


{-| Kind-safe `icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
navMenuItemSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
navMenuItemSlotIcon =
    M3e.NavMenuItem.icon


{-| Kind-safe `badge` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotBadge`. -}
navMenuItemSlotBadge :
    M3e.Element.Element { text : M3e.Value.Supported
    , badge : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | badge : M3e.Value.Supported } msg
navMenuItemSlotBadge =
    M3e.NavMenuItem.badge


{-| Kind-safe `selected-icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`. -}
navMenuItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
navMenuItemSlotSelectedIcon =
    M3e.NavMenuItem.selectedIcon


{-| Kind-safe `toggle-icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`. -}
navMenuItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
navMenuItemSlotToggleIcon =
    M3e.NavMenuItem.toggleIcon


{-| Kind-safe `(default)` slot setter for `M3e.NavBar`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navBarSlotDefault :
    M3e.Element.Element { navItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navBarSlotDefault =
    M3e.NavBar.child


{-| Kind-safe `(default)` slot setter for `M3e.NavItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
navItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
navItemSlotDefault =
    M3e.NavItem.child


{-| Kind-safe `icon` slot setter for `M3e.NavItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
navItemSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
navItemSlotIcon =
    M3e.NavItem.icon


{-| Kind-safe `selected-icon` slot setter for `M3e.NavItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`. -}
navItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
navItemSlotSelectedIcon =
    M3e.NavItem.selectedIcon


{-| Kind-safe `(default)` slot setter for `M3e.MenuItemRadio`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuItemRadioSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuItemRadioSlotDefault =
    M3e.MenuItemRadio.child


{-| Kind-safe `icon` slot setter for `M3e.MenuItemRadio`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
menuItemRadioSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
menuItemRadioSlotIcon =
    M3e.MenuItemRadio.icon


{-| Kind-safe `trailing-icon` slot setter for `M3e.MenuItemRadio`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
menuItemRadioSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
menuItemRadioSlotTrailingIcon =
    M3e.MenuItemRadio.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.MenuItemGroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuItemGroupSlotDefault :
    M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuItemGroupSlotDefault =
    M3e.MenuItemGroup.child


{-| Kind-safe `(default)` slot setter for `M3e.MenuItemCheckbox`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuItemCheckboxSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuItemCheckboxSlotDefault =
    M3e.MenuItemCheckbox.child


{-| Kind-safe `icon` slot setter for `M3e.MenuItemCheckbox`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
menuItemCheckboxSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
menuItemCheckboxSlotIcon =
    M3e.MenuItemCheckbox.icon


{-| Kind-safe `trailing-icon` slot setter for `M3e.MenuItemCheckbox`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
menuItemCheckboxSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
menuItemCheckboxSlotTrailingIcon =
    M3e.MenuItemCheckbox.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.Menu`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuSlotDefault :
    M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    , menuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuSlotDefault =
    M3e.Menu.child


{-| Kind-safe `(default)` slot setter for `M3e.MenuItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , dialogTrigger : M3e.Value.Supported
    , dialogAction : M3e.Value.Supported
    , menuTrigger : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    , bottomSheetTrigger : M3e.Value.Supported
    , bottomSheetAction : M3e.Value.Supported
    , stepperPrevious : M3e.Value.Supported
    , stepperReset : M3e.Value.Supported
    , richTooltipAction : M3e.Value.Supported
    , drawerToggle : M3e.Value.Supported
    , datepickerToggle : M3e.Value.Supported
    , navRailToggle : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuItemSlotDefault =
    M3e.MenuItem.child


{-| Kind-safe `icon` slot setter for `M3e.MenuItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
menuItemSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
menuItemSlotIcon =
    M3e.MenuItem.icon


{-| Kind-safe `trailing-icon` slot setter for `M3e.MenuItem`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
menuItemSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
menuItemSlotTrailingIcon =
    M3e.MenuItem.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.MenuTrigger`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
menuTriggerSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
menuTriggerSlotDefault =
    M3e.MenuTrigger.child


{-| Kind-safe `(default)` slot setter for `M3e.SelectionList`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
selectionListSlotDefault :
    M3e.Element.Element { listOption : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
selectionListSlotDefault =
    M3e.SelectionList.child


{-| Kind-safe `(default)` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
listOptionSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
listOptionSlotDefault =
    M3e.ListOption.child


{-| Kind-safe `leading` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
listOptionSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
listOptionSlotLeading =
    M3e.ListOption.leading


{-| Kind-safe `overline` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
listOptionSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
listOptionSlotOverline =
    M3e.ListOption.overline


{-| Kind-safe `supporting-text` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`. -}
listOptionSlotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
listOptionSlotSupportingText =
    M3e.ListOption.supportingText


{-| Kind-safe `trailing` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
listOptionSlotTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
listOptionSlotTrailing =
    M3e.ListOption.trailing


{-| Kind-safe `(default)` slot setter for `M3e.ActionList`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
actionListSlotDefault :
    M3e.Element.Element { listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
actionListSlotDefault =
    M3e.ActionList.child


{-| Kind-safe `(default)` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
expandableListItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
expandableListItemSlotDefault =
    M3e.ExpandableListItem.child


{-| Kind-safe `leading` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
expandableListItemSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
expandableListItemSlotLeading =
    M3e.ExpandableListItem.leading


{-| Kind-safe `overline` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
expandableListItemSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
expandableListItemSlotOverline =
    M3e.ExpandableListItem.overline


{-| Kind-safe `supporting-text` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`. -}
expandableListItemSlotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
expandableListItemSlotSupportingText =
    M3e.ExpandableListItem.supportingText


{-| Kind-safe `toggle-icon` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`. -}
expandableListItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
expandableListItemSlotToggleIcon =
    M3e.ExpandableListItem.toggleIcon


{-| Kind-safe `items` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotItems`. -}
expandableListItemSlotItems :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | items : M3e.Value.Supported } msg
expandableListItemSlotItems =
    M3e.ExpandableListItem.items


{-| Kind-safe `(default)` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
listActionSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , dialogTrigger : M3e.Value.Supported
    , dialogAction : M3e.Value.Supported
    , menuTrigger : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    , bottomSheetTrigger : M3e.Value.Supported
    , bottomSheetAction : M3e.Value.Supported
    , stepperPrevious : M3e.Value.Supported
    , stepperReset : M3e.Value.Supported
    , richTooltipAction : M3e.Value.Supported
    , drawerToggle : M3e.Value.Supported
    , datepickerToggle : M3e.Value.Supported
    , navRailToggle : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
listActionSlotDefault =
    M3e.ListAction.child


{-| Kind-safe `leading` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
listActionSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
listActionSlotLeading =
    M3e.ListAction.leading


{-| Kind-safe `overline` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
listActionSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
listActionSlotOverline =
    M3e.ListAction.overline


{-| Kind-safe `supporting-text` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`. -}
listActionSlotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
listActionSlotSupportingText =
    M3e.ListAction.supportingText


{-| Kind-safe `trailing` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
listActionSlotTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
listActionSlotTrailing =
    M3e.ListAction.trailing


{-| Kind-safe `(default)` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
listItemButtonSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
listItemButtonSlotDefault =
    M3e.ListItemButton.child


{-| Kind-safe `leading` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
listItemButtonSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
listItemButtonSlotLeading =
    M3e.ListItemButton.leading


{-| Kind-safe `overline` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
listItemButtonSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
listItemButtonSlotOverline =
    M3e.ListItemButton.overline


{-| Kind-safe `supporting-text` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`. -}
listItemButtonSlotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
listItemButtonSlotSupportingText =
    M3e.ListItemButton.supportingText


{-| Kind-safe `trailing` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
listItemButtonSlotTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
listItemButtonSlotTrailing =
    M3e.ListItemButton.trailing


{-| Kind-safe `(default)` slot setter for `M3e.List`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
listSlotDefault :
    M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
listSlotDefault =
    M3e.List.child


{-| Kind-safe `(default)` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
listItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
listItemSlotDefault =
    M3e.ListItem.child


{-| Kind-safe `leading` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
listItemSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
listItemSlotLeading =
    M3e.ListItem.leading


{-| Kind-safe `overline` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotOverline`. -}
listItemSlotOverline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
listItemSlotOverline =
    M3e.ListItem.overline


{-| Kind-safe `supporting-text` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`. -}
listItemSlotSupportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
listItemSlotSupportingText =
    M3e.ListItem.supportingText


{-| Kind-safe `trailing` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
listItemSlotTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
listItemSlotTrailing =
    M3e.ListItem.trailing


{-| Kind-safe `(default)` slot setter for `M3e.Heading`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
headingSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
headingSlotDefault =
    M3e.Heading.child


{-| Kind-safe `(default)` slot setter for `M3e.FabMenuTrigger`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
fabMenuTriggerSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
fabMenuTriggerSlotDefault =
    M3e.FabMenuTrigger.child


{-| Kind-safe `(default)` slot setter for `M3e.FabMenu`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
fabMenuSlotDefault :
    M3e.Element.Element { fabMenuItem : M3e.Value.Supported
    , menuItem : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
fabMenuSlotDefault =
    M3e.FabMenu.child


{-| Kind-safe `(default)` slot setter for `M3e.Fab`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
fabSlotDefault :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
fabSlotDefault =
    M3e.Fab.child


{-| Kind-safe `label` slot setter for `M3e.Fab`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
fabSlotLabel :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
fabSlotLabel =
    M3e.Fab.label


{-| Kind-safe `close-icon` slot setter for `M3e.Fab`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`. -}
fabSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
fabSlotCloseIcon =
    M3e.Fab.closeIcon


{-| Kind-safe `(default)` slot setter for `M3e.Accordion`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
accordionSlotDefault :
    M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
accordionSlotDefault =
    M3e.Accordion.child


{-| Kind-safe `(default)` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
expansionPanelSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
expansionPanelSlotDefault =
    M3e.ExpansionPanel.child


{-| Kind-safe `actions` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotActions`. -}
expansionPanelSlotActions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
expansionPanelSlotActions =
    M3e.ExpansionPanel.actions


{-| Kind-safe `header` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotHeader`. -}
expansionPanelSlotHeader :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
expansionPanelSlotHeader =
    M3e.ExpansionPanel.header


{-| Kind-safe `toggle-icon` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`. -}
expansionPanelSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
expansionPanelSlotToggleIcon =
    M3e.ExpansionPanel.toggleIcon


{-| Kind-safe `(default)` slot setter for `M3e.ExpansionHeader`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
expansionHeaderSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
expansionHeaderSlotDefault =
    M3e.ExpansionHeader.child


{-| Kind-safe `toggle-icon` slot setter for `M3e.ExpansionHeader`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`. -}
expansionHeaderSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
expansionHeaderSlotToggleIcon =
    M3e.ExpansionHeader.toggleIcon


{-| Kind-safe `(default)` slot setter for `M3e.DrawerToggle`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
drawerToggleSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
drawerToggleSlotDefault =
    M3e.DrawerToggle.child


{-| Kind-safe `(default)` slot setter for `M3e.DrawerContainer`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
drawerContainerSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
drawerContainerSlotDefault =
    M3e.DrawerContainer.child


{-| Kind-safe `start` slot setter for `M3e.DrawerContainer`, re-exposed flat. The loose, component-agnostic form is `slotStart`. -}
drawerContainerSlotStart :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
drawerContainerSlotStart =
    M3e.DrawerContainer.startSlot


{-| Kind-safe `end` slot setter for `M3e.DrawerContainer`, re-exposed flat. The loose, component-agnostic form is `slotEnd`. -}
drawerContainerSlotEnd :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
drawerContainerSlotEnd =
    M3e.DrawerContainer.endSlot


{-| Kind-safe `(default)` slot setter for `M3e.DialogTrigger`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
dialogTriggerSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
dialogTriggerSlotDefault =
    M3e.DialogTrigger.child


{-| Kind-safe `(default)` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
dialogSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
dialogSlotDefault =
    M3e.Dialog.child


{-| Kind-safe `header` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotHeader`. -}
dialogSlotHeader :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
dialogSlotHeader =
    M3e.Dialog.header


{-| Kind-safe `actions` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotActions`. -}
dialogSlotActions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
dialogSlotActions =
    M3e.Dialog.actions


{-| Kind-safe `close-icon` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`. -}
dialogSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
dialogSlotCloseIcon =
    M3e.Dialog.closeIcon


{-| Kind-safe `(default)` slot setter for `M3e.DialogAction`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
dialogActionSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
dialogActionSlotDefault =
    M3e.DialogAction.child


{-| Kind-safe `(default)` slot setter for `M3e.DatepickerToggle`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
datepickerToggleSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
datepickerToggleSlotDefault =
    M3e.DatepickerToggle.child


{-| Kind-safe `(default)` slot setter for `M3e.ContentPane`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
contentPaneSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
contentPaneSlotDefault =
    M3e.ContentPane.child


{-| Kind-safe `(default)` slot setter for `M3e.SuggestionChip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
suggestionChipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
suggestionChipSlotDefault =
    M3e.SuggestionChip.child


{-| Kind-safe `icon` slot setter for `M3e.SuggestionChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
suggestionChipSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
suggestionChipSlotIcon =
    M3e.SuggestionChip.icon


{-| Kind-safe `(default)` slot setter for `M3e.InputChipSet`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
inputChipSetSlotDefault :
    M3e.Element.Element { inputChip : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
inputChipSetSlotDefault =
    M3e.InputChipSet.child


{-| Kind-safe `input` slot setter for `M3e.InputChipSet`, re-exposed flat. The loose, component-agnostic form is `slotInput`. -}
inputChipSetSlotInput :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
inputChipSetSlotInput =
    M3e.InputChipSet.input


{-| Kind-safe `(default)` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
inputChipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
inputChipSlotDefault =
    M3e.InputChip.child


{-| Kind-safe `avatar` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotAvatar`. -}
inputChipSlotAvatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | avatar : M3e.Value.Supported } msg
inputChipSlotAvatar =
    M3e.InputChip.avatar


{-| Kind-safe `icon` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
inputChipSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
inputChipSlotIcon =
    M3e.InputChip.icon


{-| Kind-safe `remove-icon` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotRemoveIcon`. -}
inputChipSlotRemoveIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | removeIcon : M3e.Value.Supported } msg
inputChipSlotRemoveIcon =
    M3e.InputChip.removeIcon


{-| Kind-safe `(default)` slot setter for `M3e.FilterChipSet`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
filterChipSetSlotDefault :
    M3e.Element.Element { filterChip : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
filterChipSetSlotDefault =
    M3e.FilterChipSet.child


{-| Kind-safe `(default)` slot setter for `M3e.FilterChip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
filterChipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
filterChipSlotDefault =
    M3e.FilterChip.child


{-| Kind-safe `icon` slot setter for `M3e.FilterChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
filterChipSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
filterChipSlotIcon =
    M3e.FilterChip.icon


{-| Kind-safe `trailing-icon` slot setter for `M3e.FilterChip`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
filterChipSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
filterChipSlotTrailingIcon =
    M3e.FilterChip.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.ChipSet`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
chipSetSlotDefault :
    M3e.Element.Element { assistChip : M3e.Value.Supported
    , chip : M3e.Value.Supported
    , filterChip : M3e.Value.Supported
    , inputChip : M3e.Value.Supported
    , suggestionChip : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
chipSetSlotDefault =
    M3e.ChipSet.child


{-| Kind-safe `(default)` slot setter for `M3e.AssistChip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
assistChipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
assistChipSlotDefault =
    M3e.AssistChip.child


{-| Kind-safe `icon` slot setter for `M3e.AssistChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
assistChipSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
assistChipSlotIcon =
    M3e.AssistChip.icon


{-| Kind-safe `(default)` slot setter for `M3e.Chip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
chipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
chipSlotDefault =
    M3e.Chip.child


{-| Kind-safe `icon` slot setter for `M3e.Chip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
chipSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
chipSlotIcon =
    M3e.Chip.icon


{-| Kind-safe `trailing-icon` slot setter for `M3e.Chip`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
chipSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
chipSlotTrailingIcon =
    M3e.Chip.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
cardSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
cardSlotDefault =
    M3e.Card.child


{-| Kind-safe `header` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotHeader`. -}
cardSlotHeader :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
cardSlotHeader =
    M3e.Card.header


{-| Kind-safe `content` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotContent`. -}
cardSlotContent :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | content : M3e.Value.Supported } msg
cardSlotContent =
    M3e.Card.content


{-| Kind-safe `actions` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotActions`. -}
cardSlotActions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
cardSlotActions =
    M3e.Card.actions


{-| Kind-safe `footer` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotFooter`. -}
cardSlotFooter :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | footer : M3e.Value.Supported } msg
cardSlotFooter =
    M3e.Card.footer


{-| Kind-safe `header` slot setter for `M3e.Calendar`, re-exposed flat. The loose, component-agnostic form is `slotHeader`. -}
calendarSlotHeader :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
calendarSlotHeader =
    M3e.Calendar.header


{-| Kind-safe `(default)` slot setter for `M3e.Tooltip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
tooltipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
tooltipSlotDefault =
    M3e.Tooltip.child


{-| Kind-safe `(default)` slot setter for `M3e.RichTooltip`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
richTooltipSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
richTooltipSlotDefault =
    M3e.RichTooltip.child


{-| Kind-safe `subhead` slot setter for `M3e.RichTooltip`, re-exposed flat. The loose, component-agnostic form is `slotSubhead`. -}
richTooltipSlotSubhead :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | subhead : M3e.Value.Supported } msg
richTooltipSlotSubhead =
    M3e.RichTooltip.subhead


{-| Kind-safe `actions` slot setter for `M3e.RichTooltip`, re-exposed flat. The loose, component-agnostic form is `slotActions`. -}
richTooltipSlotActions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
richTooltipSlotActions =
    M3e.RichTooltip.actions


{-| Kind-safe `(default)` slot setter for `M3e.RichTooltipAction`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
richTooltipActionSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
richTooltipActionSlotDefault =
    M3e.RichTooltipAction.child


{-| Kind-safe `(default)` slot setter for `M3e.ButtonGroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
buttonGroupSlotDefault :
    M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
buttonGroupSlotDefault =
    M3e.ButtonGroup.child


{-| Kind-safe `(default)` slot setter for `M3e.IconButton`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
iconButtonSlotDefault :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
iconButtonSlotDefault =
    M3e.IconButton.child


{-| Kind-safe `selected` slot setter for `M3e.IconButton`, re-exposed flat. The loose, component-agnostic form is `slotSelected`. -}
iconButtonSlotSelected :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
iconButtonSlotSelected =
    M3e.IconButton.selectedSlot


{-| Kind-safe `(default)` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
buttonSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
buttonSlotDefault =
    M3e.Button.child


{-| Kind-safe `icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
buttonSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
buttonSlotIcon =
    M3e.Button.icon


{-| Kind-safe `selected` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotSelected`. -}
buttonSlotSelected :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
buttonSlotSelected =
    M3e.Button.selectedSlot


{-| Kind-safe `selected-icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`. -}
buttonSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
buttonSlotSelectedIcon =
    M3e.Button.selectedIcon


{-| Kind-safe `trailing-icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
buttonSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
buttonSlotTrailingIcon =
    M3e.Button.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.Breadcrumb`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
breadcrumbSlotDefault :
    M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
breadcrumbSlotDefault =
    M3e.Breadcrumb.child


{-| Kind-safe `separator` slot setter for `M3e.Breadcrumb`, re-exposed flat. The loose, component-agnostic form is `slotSeparator`. -}
breadcrumbSlotSeparator :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | separator : M3e.Value.Supported } msg
breadcrumbSlotSeparator =
    M3e.Breadcrumb.separator


{-| Kind-safe `(default)` slot setter for `M3e.BreadcrumbItem`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
breadcrumbItemSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
breadcrumbItemSlotDefault =
    M3e.BreadcrumbItem.child


{-| Kind-safe `icon` slot setter for `M3e.BreadcrumbItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
breadcrumbItemSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
breadcrumbItemSlotIcon =
    M3e.BreadcrumbItem.icon


{-| Kind-safe `icon` slot setter for `M3e.BreadcrumbItemButton`, re-exposed flat. The loose, component-agnostic form is `slotIcon`. -}
breadcrumbItemButtonSlotIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
breadcrumbItemButtonSlotIcon =
    M3e.BreadcrumbItemButton.icon


{-| Kind-safe `(default)` slot setter for `M3e.BreadcrumbItemButton`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
breadcrumbItemButtonSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
breadcrumbItemButtonSlotDefault =
    M3e.BreadcrumbItemButton.child


{-| Kind-safe `(default)` slot setter for `M3e.BottomSheetTrigger`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
bottomSheetTriggerSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
bottomSheetTriggerSlotDefault =
    M3e.BottomSheetTrigger.child


{-| Kind-safe `(default)` slot setter for `M3e.BottomSheet`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
bottomSheetSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
bottomSheetSlotDefault =
    M3e.BottomSheet.child


{-| Kind-safe `header` slot setter for `M3e.BottomSheet`, re-exposed flat. The loose, component-agnostic form is `slotHeader`. -}
bottomSheetSlotHeader :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
bottomSheetSlotHeader =
    M3e.BottomSheet.header


{-| Kind-safe `(default)` slot setter for `M3e.BottomSheetAction`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
bottomSheetActionSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
bottomSheetActionSlotDefault =
    M3e.BottomSheetAction.child


{-| Kind-safe `(default)` slot setter for `M3e.Badge`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
badgeSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
badgeSlotDefault =
    M3e.Badge.child


{-| Kind-safe `(default)` slot setter for `M3e.Avatar`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
avatarSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
avatarSlotDefault =
    M3e.Avatar.child


{-| Kind-safe `(default)` slot setter for `M3e.Autocomplete`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
autocompleteSlotDefault :
    M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
autocompleteSlotDefault =
    M3e.Autocomplete.child


{-| Kind-safe `loading` slot setter for `M3e.Autocomplete`, re-exposed flat. The loose, component-agnostic form is `slotLoading`. -}
autocompleteSlotLoading :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
autocompleteSlotLoading =
    M3e.Autocomplete.loadingSlot


{-| Kind-safe `no-data` slot setter for `M3e.Autocomplete`, re-exposed flat. The loose, component-agnostic form is `slotNoData`. -}
autocompleteSlotNoData :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
autocompleteSlotNoData =
    M3e.Autocomplete.noData


{-| Kind-safe `(default)` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
formFieldSlotDefault :
    String
    -> M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
formFieldSlotDefault =
    M3e.FormField.child


{-| Kind-safe `prefix` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotPrefix`. -}
formFieldSlotPrefix :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | prefix : M3e.Value.Supported } msg
formFieldSlotPrefix =
    M3e.FormField.prefix


{-| Kind-safe `prefix-text` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotPrefixText`. -}
formFieldSlotPrefixText :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | prefixText : M3e.Value.Supported } msg
formFieldSlotPrefixText =
    M3e.FormField.prefixText


{-| Kind-safe `label` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
formFieldSlotLabel :
    String
    -> M3e.Element.Element any msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
formFieldSlotLabel =
    M3e.FormField.label


{-| Kind-safe `suffix` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotSuffix`. -}
formFieldSlotSuffix :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | suffix : M3e.Value.Supported } msg
formFieldSlotSuffix =
    M3e.FormField.suffix


{-| Kind-safe `suffix-text` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotSuffixText`. -}
formFieldSlotSuffixText :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | suffixText : M3e.Value.Supported } msg
formFieldSlotSuffixText =
    M3e.FormField.suffixText


{-| Kind-safe `hint` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotHint`. -}
formFieldSlotHint :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | hint : M3e.Value.Supported } msg
formFieldSlotHint =
    M3e.FormField.hint


{-| Kind-safe `error` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotError`. -}
formFieldSlotError :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | error : M3e.Value.Supported } msg
formFieldSlotError =
    M3e.FormField.error


{-| Kind-safe `(default)` slot setter for `M3e.OptionPanel`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
optionPanelSlotDefault :
    M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
optionPanelSlotDefault =
    M3e.OptionPanel.child


{-| Kind-safe `no-data` slot setter for `M3e.OptionPanel`, re-exposed flat. The loose, component-agnostic form is `slotNoData`. -}
optionPanelSlotNoData :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
optionPanelSlotNoData =
    M3e.OptionPanel.noData


{-| Kind-safe `loading` slot setter for `M3e.OptionPanel`, re-exposed flat. The loose, component-agnostic form is `slotLoading`. -}
optionPanelSlotLoading :
    M3e.Element.Element { circularProgressIndicator : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    , text : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
optionPanelSlotLoading =
    M3e.OptionPanel.loading


{-| Kind-safe `(default)` slot setter for `M3e.FloatingPanel`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
floatingPanelSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
floatingPanelSlotDefault =
    M3e.FloatingPanel.child


{-| Kind-safe `(default)` slot setter for `M3e.Optgroup`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
optgroupSlotDefault :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
optgroupSlotDefault =
    M3e.Optgroup.child


{-| Kind-safe `label` slot setter for `M3e.Optgroup`, re-exposed flat. The loose, component-agnostic form is `slotLabel`. -}
optgroupSlotLabel :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
optgroupSlotLabel =
    M3e.Optgroup.label


{-| Kind-safe `(default)` slot setter for `M3e.Option`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
optionSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
optionSlotDefault =
    M3e.Option.child


{-| Kind-safe `(default)` slot setter for `M3e.FocusTrap`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
focusTrapSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
focusTrapSlotDefault =
    M3e.FocusTrap.child


{-| Kind-safe `leading` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotLeading`. -}
appBarSlotLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
appBarSlotLeading =
    M3e.AppBar.leading


{-| Kind-safe `title` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTitle`. -}
appBarSlotTitle :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
appBarSlotTitle =
    M3e.AppBar.title


{-| Kind-safe `subtitle` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotSubtitle`. -}
appBarSlotSubtitle :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | subtitle : M3e.Value.Supported } msg
appBarSlotSubtitle =
    M3e.AppBar.subtitle


{-| Kind-safe `trailing` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`. -}
appBarSlotTrailing :
    M3e.Element.Element { iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    , searchBar : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
appBarSlotTrailing =
    M3e.AppBar.trailing


{-| Kind-safe `leading-icon` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotLeadingIcon`. -}
appBarSlotLeadingIcon :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | leadingIcon : M3e.Value.Supported } msg
appBarSlotLeadingIcon =
    M3e.AppBar.leadingIcon


{-| Kind-safe `trailing-icon` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`. -}
appBarSlotTrailingIcon :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
appBarSlotTrailingIcon =
    M3e.AppBar.trailingIcon


{-| Kind-safe `(default)` slot setter for `M3e.TextOverflow`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
textOverflowSlotDefault :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
textOverflowSlotDefault =
    M3e.TextOverflow.child


{-| Kind-safe `(default)` slot setter for `M3e.TextHighlight`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
textHighlightSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
textHighlightSlotDefault =
    M3e.TextHighlight.child


{-| Kind-safe `(default)` slot setter for `M3e.Slide`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
slideSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
slideSlotDefault =
    M3e.Slide.child


{-| Kind-safe `(default)` slot setter for `M3e.ScrollContainer`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
scrollContainerSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
scrollContainerSlotDefault =
    M3e.ScrollContainer.child


{-| Kind-safe `(default)` slot setter for `M3e.Collapsible`, re-exposed flat. The loose, component-agnostic form is `slotDefault`. -}
collapsibleSlotDefault :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
collapsibleSlotDefault =
    M3e.Collapsible.child