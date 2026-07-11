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
import M3e.Aria
import M3e.AssistChip
import M3e.Attributes
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
import M3e.Html.Attr
import M3e.Html.Shared
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


{-| Convenience binding for the `M3e.Tree` element: `view` re-exposed from `M3e.Tree`. Import that module directly for the strict, component-scoped types.
-}
tree :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , cascade : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { treeItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tree : M3e.Token.Supported } msg
tree =
    M3e.Tree.view


{-| Convenience binding for the `M3e.TreeItem` element: `view` re-exposed from `M3e.TreeItem`. Import that module directly for the strict, component-scoped types.
-}
treeItem :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { treeItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | treeItem : M3e.Token.Supported } msg
treeItem =
    M3e.TreeItem.view


{-| Convenience binding for the `M3e.Toolbar` element: `view` re-exposed from `M3e.Toolbar`. Import that module directly for the strict, component-scoped types.
-}
toolbar :
    List
        (M3e.Html.Attr.Attr
            { elevated : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | toolbar : M3e.Token.Supported } msg
toolbar =
    M3e.Toolbar.view


{-| Convenience binding for the `M3e.Toc` element: `view` re-exposed from `M3e.Toc`. Import that module directly for the strict, component-scoped types.
-}
toc :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , maxDepth : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | toc : M3e.Token.Supported } msg
toc =
    M3e.Toc.view


{-| Convenience binding for the `M3e.TocItem` element: `view` re-exposed from `M3e.TocItem`. Import that module directly for the strict, component-scoped types.
-}
tocItem :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tocItem : M3e.Token.Supported } msg
tocItem =
    M3e.TocItem.view


{-| Convenience binding for the `M3e.ThemeIcon` element: `view` re-exposed from `M3e.ThemeIcon`. Import that module directly for the strict, component-scoped types.
-}
themeIcon :
    List
        (M3e.Html.Attr.Attr
            { color : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | themeIcon : M3e.Token.Supported } msg
themeIcon =
    M3e.ThemeIcon.view


{-| Convenience binding for the `M3e.Theme` element: `view` re-exposed from `M3e.Theme`. Import that module directly for the strict, component-scoped types.
-}
theme :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | theme : M3e.Token.Supported } msg
theme =
    M3e.Theme.view


{-| Convenience binding for the `M3e.TextareaAutosize` element: `view` re-exposed from `M3e.TextareaAutosize`. Import that module directly for the strict, component-scoped types.
-}
textareaAutosize :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , maxRows : M3e.Token.Supported
            , minRows : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | textareaAutosize : M3e.Token.Supported } msg
textareaAutosize =
    M3e.TextareaAutosize.view


{-| Convenience binding for the `M3e.Tabs` element: `view` re-exposed from `M3e.Tabs`. Import that module directly for the strict, component-scoped types.
-}
tabs :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { tab : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tabs : M3e.Token.Supported } msg
tabs =
    M3e.Tabs.view


{-| Convenience binding for the `M3e.TabPanel` element: `view` re-exposed from `M3e.TabPanel`. Import that module directly for the strict, component-scoped types.
-}
tabPanel :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | tabPanel : M3e.Token.Supported } msg
tabPanel =
    M3e.TabPanel.view


{-| Convenience binding for the `M3e.Tab` element: `view` re-exposed from `M3e.Tab`. Import that module directly for the strict, component-scoped types.
-}
tab :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tab : M3e.Token.Supported } msg
tab =
    M3e.Tab.view


{-| Convenience binding for the `M3e.Switch` element: `view` re-exposed from `M3e.Switch`. Import that module directly for the strict, component-scoped types.
-}
switch :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | switch : M3e.Token.Supported } msg
switch =
    M3e.Switch.view


{-| Convenience binding for the `M3e.StepperReset` element: `view` re-exposed from `M3e.StepperReset`. Import that module directly for the strict, component-scoped types.
-}
stepperReset :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepperReset : M3e.Token.Supported } msg
stepperReset =
    M3e.StepperReset.view


{-| Convenience binding for the `M3e.StepperPrevious` element: `view` re-exposed from `M3e.StepperPrevious`. Import that module directly for the strict, component-scoped types.
-}
stepperPrevious :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepperPrevious : M3e.Token.Supported } msg
stepperPrevious =
    M3e.StepperPrevious.view


{-| Convenience binding for the `M3e.StepperNext` element: `view` re-exposed from `M3e.StepperNext`. Import that module directly for the strict, component-scoped types.
-}
stepperNext :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepperNext : M3e.Token.Supported } msg
stepperNext =
    M3e.StepperNext.view


{-| Convenience binding for the `M3e.Step` element: `view` re-exposed from `M3e.Step`. Import that module directly for the strict, component-scoped types.
-}
step :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | step : M3e.Token.Supported } msg
step =
    M3e.Step.view


{-| Convenience binding for the `M3e.StepPanel` element: `view` re-exposed from `M3e.StepPanel`. Import that module directly for the strict, component-scoped types.
-}
stepPanel :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepPanel : M3e.Token.Supported } msg
stepPanel =
    M3e.StepPanel.view


{-| Convenience binding for the `M3e.Stepper` element: `view` re-exposed from `M3e.Stepper`. Import that module directly for the strict, component-scoped types.
-}
stepper :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepper : M3e.Token.Supported } msg
stepper =
    M3e.Stepper.view


{-| Convenience binding for the `M3e.SplitPane` element: `view` re-exposed from `M3e.SplitPane`. Import that module directly for the strict, component-scoped types.
-}
splitPane :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitPane : M3e.Token.Supported } msg
splitPane =
    M3e.SplitPane.view


{-| Convenience binding for the `M3e.SplitButton` element: `view` re-exposed from `M3e.SplitButton`. Import that module directly for the strict, component-scoped types.
-}
splitButton :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitButton : M3e.Token.Supported } msg
splitButton =
    M3e.SplitButton.view


{-| Convenience binding for the `M3e.Snackbar` element: `view` re-exposed from `M3e.Snackbar`. Import that module directly for the strict, component-scoped types.
-}
snackbar :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | snackbar : M3e.Token.Supported } msg
snackbar =
    M3e.Snackbar.view


{-| Convenience binding for the `M3e.Slider` element: `view` re-exposed from `M3e.Slider`. Import that module directly for the strict, component-scoped types.
-}
slider :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slider : M3e.Token.Supported } msg
slider =
    M3e.Slider.view


{-| Convenience binding for the `M3e.SliderThumb` element: `view` re-exposed from `M3e.SliderThumb`. Import that module directly for the strict, component-scoped types.
-}
sliderThumb :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | sliderThumb : M3e.Token.Supported } msg
sliderThumb =
    M3e.SliderThumb.view


{-| Convenience binding for the `M3e.SlideGroup` element: `view` re-exposed from `M3e.SlideGroup`. Import that module directly for the strict, component-scoped types.
-}
slideGroup :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , threshold : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slideGroup : M3e.Token.Supported } msg
slideGroup =
    M3e.SlideGroup.view


{-| Convenience binding for the `M3e.Skeleton` element: `view` re-exposed from `M3e.Skeleton`. Import that module directly for the strict, component-scoped types.
-}
skeleton :
    List
        (M3e.Html.Attr.Attr
            { animation : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , loaded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | skeleton : M3e.Token.Supported } msg
skeleton =
    M3e.Skeleton.view


{-| Convenience binding for the `M3e.Shape` element: `view` re-exposed from `M3e.Shape`. Import that module directly for the strict, component-scoped types.
-}
shape :
    List
        (M3e.Html.Attr.Attr
            { nameEnum : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | shape : M3e.Token.Supported } msg
shape =
    M3e.Shape.view


{-| Convenience binding for the `M3e.SegmentedButton` element: `view` re-exposed from `M3e.SegmentedButton`. Import that module directly for the strict, component-scoped types.
-}
segmentedButton :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { buttonSegment : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | segmentedButton : M3e.Token.Supported } msg
segmentedButton =
    M3e.SegmentedButton.view


{-| Convenience binding for the `M3e.ButtonSegment` element: `view` re-exposed from `M3e.ButtonSegment`. Import that module directly for the strict, component-scoped types.
-}
buttonSegment :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | buttonSegment : M3e.Token.Supported } msg
buttonSegment =
    M3e.ButtonSegment.view


{-| Convenience binding for the `M3e.SearchView` element: `view` re-exposed from `M3e.SearchView`. Import that module directly for the strict, component-scoped types.
-}
searchView :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchView : M3e.Token.Supported } msg
searchView =
    M3e.SearchView.view


{-| Convenience binding for the `M3e.SearchBar` element: `view` re-exposed from `M3e.SearchBar`. Import that module directly for the strict, component-scoped types.
-}
searchBar :
    List
        (M3e.Html.Attr.Attr
            { clearable : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , onClear : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchBar : M3e.Token.Supported } msg
searchBar =
    M3e.SearchBar.view


{-| Convenience binding for the `M3e.RadioGroup` element: `view` re-exposed from `M3e.RadioGroup`. Import that module directly for the strict, component-scoped types.
-}
radioGroup :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | radioGroup : M3e.Token.Supported } msg
radioGroup =
    M3e.RadioGroup.view


{-| Convenience binding for the `M3e.Radio` element: `view` re-exposed from `M3e.Radio`. Import that module directly for the strict, component-scoped types.
-}
radio :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | radio : M3e.Token.Supported } msg
radio =
    M3e.Radio.view


{-| Convenience binding for the `M3e.Paginator` element: `view` re-exposed from `M3e.Paginator`. Import that module directly for the strict, component-scoped types.
-}
paginator :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | paginator : M3e.Token.Supported } msg
paginator =
    M3e.Paginator.view


{-| Convenience binding for the `M3e.Select` element: `view` re-exposed from `M3e.Select`. Import that module directly for the strict, component-scoped types.
-}
select :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { option : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | select : M3e.Token.Supported } msg
select =
    M3e.Select.view


{-| Convenience binding for the `M3e.NavRailToggle` element: `view` re-exposed from `M3e.NavRailToggle`. Import that module directly for the strict, component-scoped types.
-}
navRailToggle :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | navRailToggle : M3e.Token.Supported } msg
navRailToggle =
    M3e.NavRailToggle.view


{-| Convenience binding for the `M3e.NavRail` element: `view` re-exposed from `M3e.NavRail`. Import that module directly for the strict, component-scoped types.
-}
navRail :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { navItem : M3e.Token.Supported
                , iconButton : M3e.Token.Supported
                , fab : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | navRail : M3e.Token.Supported } msg
navRail =
    M3e.NavRail.view


{-| Convenience binding for the `M3e.NavMenuItemGroup` element: `view` re-exposed from `M3e.NavMenuItemGroup`. Import that module directly for the strict, component-scoped types.
-}
navMenuItemGroup :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element { navMenuItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | navMenuItemGroup : M3e.Token.Supported } msg
navMenuItemGroup =
    M3e.NavMenuItemGroup.view


{-| Convenience binding for the `M3e.NavMenu` element: `view` re-exposed from `M3e.NavMenu`. Import that module directly for the strict, component-scoped types.
-}
navMenu :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (M3e.Element.Element
                { navMenuItem : M3e.Token.Supported
                , navMenuItemGroup : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | navMenu : M3e.Token.Supported } msg
navMenu =
    M3e.NavMenu.view


{-| Convenience binding for the `M3e.NavMenuItem` element: `view` re-exposed from `M3e.NavMenuItem`. Import that module directly for the strict, component-scoped types.
-}
navMenuItem :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { navMenuItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Token.Supported } msg
navMenuItem =
    M3e.NavMenuItem.view


{-| Convenience binding for the `M3e.NavBar` element: `view` re-exposed from `M3e.NavBar`. Import that module directly for the strict, component-scoped types.
-}
navBar :
    List
        (M3e.Html.Attr.Attr
            { mode : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { navItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | navBar : M3e.Token.Supported } msg
navBar =
    M3e.NavBar.view


{-| Convenience binding for the `M3e.NavItem` element: `view` re-exposed from `M3e.NavItem`. Import that module directly for the strict, component-scoped types.
-}
navItem :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | navItem : M3e.Token.Supported } msg
navItem =
    M3e.NavItem.view


{-| Convenience binding for the `M3e.MenuItemRadio` element: `view` re-exposed from `M3e.MenuItemRadio`. Import that module directly for the strict, component-scoped types.
-}
menuItemRadio :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | menuItemRadio : M3e.Token.Supported } msg
menuItemRadio =
    M3e.MenuItemRadio.view


{-| Convenience binding for the `M3e.MenuItemGroup` element: `view` re-exposed from `M3e.MenuItemGroup`. Import that module directly for the strict, component-scoped types.
-}
menuItemGroup :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (M3e.Element.Element
                { menuItem : M3e.Token.Supported
                , menuItemCheckbox : M3e.Token.Supported
                , menuItemRadio : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | menuItemGroup : M3e.Token.Supported } msg
menuItemGroup =
    M3e.MenuItemGroup.view


{-| Convenience binding for the `M3e.MenuItemCheckbox` element: `view` re-exposed from `M3e.MenuItemCheckbox`. Import that module directly for the strict, component-scoped types.
-}
menuItemCheckbox :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | menuItemCheckbox : M3e.Token.Supported } msg
menuItemCheckbox =
    M3e.MenuItemCheckbox.view


{-| Convenience binding for the `M3e.Menu` element: `view` re-exposed from `M3e.Menu`. Import that module directly for the strict, component-scoped types.
-}
menu :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { menuItem : M3e.Token.Supported
                , menuItemCheckbox : M3e.Token.Supported
                , menuItemRadio : M3e.Token.Supported
                , menuItemGroup : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | menu : M3e.Token.Supported } msg
menu =
    M3e.Menu.view


{-| Convenience binding for the `M3e.MenuItem` element: `view` re-exposed from `M3e.MenuItem`. Import that module directly for the strict, component-scoped types.
-}
menuItem :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , dialogTrigger : M3e.Token.Supported
                , dialogAction : M3e.Token.Supported
                , menuTrigger : M3e.Token.Supported
                , fabMenuTrigger : M3e.Token.Supported
                , bottomSheetTrigger : M3e.Token.Supported
                , bottomSheetAction : M3e.Token.Supported
                , stepperPrevious : M3e.Token.Supported
                , stepperReset : M3e.Token.Supported
                , richTooltipAction : M3e.Token.Supported
                , drawerToggle : M3e.Token.Supported
                , datepickerToggle : M3e.Token.Supported
                , navRailToggle : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | menuItem : M3e.Token.Supported } msg
menuItem =
    M3e.MenuItem.view


{-| Convenience binding for the `M3e.MenuTrigger` element: `view` re-exposed from `M3e.MenuTrigger`. Import that module directly for the strict, component-scoped types.
-}
menuTrigger :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | menuTrigger : M3e.Token.Supported } msg
menuTrigger =
    M3e.MenuTrigger.view


{-| Convenience binding for the `M3e.LoadingIndicator` element: `view` re-exposed from `M3e.LoadingIndicator`. Import that module directly for the strict, component-scoped types.
-}
loadingIndicator :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Token.Supported } msg
loadingIndicator =
    M3e.LoadingIndicator.view


{-| Convenience binding for the `M3e.SelectionList` element: `view` re-exposed from `M3e.SelectionList`. Import that module directly for the strict, component-scoped types.
-}
selectionList :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { listOption : M3e.Token.Supported
                , expandableListItem : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | selectionList : M3e.Token.Supported } msg
selectionList =
    M3e.SelectionList.view


{-| Convenience binding for the `M3e.ListOption` element: `view` re-exposed from `M3e.ListOption`. Import that module directly for the strict, component-scoped types.
-}
listOption :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listOption : M3e.Token.Supported } msg
listOption =
    M3e.ListOption.view


{-| Convenience binding for the `M3e.ActionList` element: `view` re-exposed from `M3e.ActionList`. Import that module directly for the strict, component-scoped types.
-}
actionList :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { listAction : M3e.Token.Supported
                , expandableListItem : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | actionList : M3e.Token.Supported } msg
actionList =
    M3e.ActionList.view


{-| Convenience binding for the `M3e.ExpandableListItem` element: `view` re-exposed from `M3e.ExpandableListItem`. Import that module directly for the strict, component-scoped types.
-}
expandableListItem :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | expandableListItem : M3e.Token.Supported } msg
expandableListItem =
    M3e.ExpandableListItem.view


{-| Convenience binding for the `M3e.ListAction` element: `view` re-exposed from `M3e.ListAction`. Import that module directly for the strict, component-scoped types.
-}
listAction :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , dialogTrigger : M3e.Token.Supported
                , dialogAction : M3e.Token.Supported
                , menuTrigger : M3e.Token.Supported
                , fabMenuTrigger : M3e.Token.Supported
                , bottomSheetTrigger : M3e.Token.Supported
                , bottomSheetAction : M3e.Token.Supported
                , stepperPrevious : M3e.Token.Supported
                , stepperReset : M3e.Token.Supported
                , richTooltipAction : M3e.Token.Supported
                , drawerToggle : M3e.Token.Supported
                , datepickerToggle : M3e.Token.Supported
                , navRailToggle : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listAction : M3e.Token.Supported } msg
listAction =
    M3e.ListAction.view


{-| Convenience binding for the `M3e.ListItemButton` element: `view` re-exposed from `M3e.ListItemButton`. Import that module directly for the strict, component-scoped types.
-}
listItemButton :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listItemButton : M3e.Token.Supported } msg
listItemButton =
    M3e.ListItemButton.view


{-| Convenience binding for the `M3e.List` element: `view` re-exposed from `M3e.List`. Import that module directly for the strict, component-scoped types.
-}
list :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { listItem : M3e.Token.Supported
                , listAction : M3e.Token.Supported
                , expandableListItem : M3e.Token.Supported
                , listOption : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | list : M3e.Token.Supported } msg
list =
    M3e.List.view


{-| Convenience binding for the `M3e.ListItem` element: `view` re-exposed from `M3e.ListItem`. Import that module directly for the strict, component-scoped types.
-}
listItem :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listItem : M3e.Token.Supported } msg
listItem =
    M3e.ListItem.view


{-| Convenience binding for the `M3e.Icon` element: `view` re-exposed from `M3e.Icon`. Import that module directly for the strict, component-scoped types.
-}
icon :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | icon : M3e.Token.Supported } msg
icon =
    M3e.Icon.view


{-| Convenience binding for the `M3e.Heading` element: `view` re-exposed from `M3e.Heading`. Import that module directly for the strict, component-scoped types.
-}
heading :
    List
        (M3e.Html.Attr.Attr
            { emphasized : M3e.Token.Supported
            , level : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , tocIgnore : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | heading : M3e.Token.Supported } msg
heading =
    M3e.Heading.view


{-| Convenience binding for the `M3e.FabMenuTrigger` element: `view` re-exposed from `M3e.FabMenuTrigger`. Import that module directly for the strict, component-scoped types.
-}
fabMenuTrigger :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | fabMenuTrigger : M3e.Token.Supported } msg
fabMenuTrigger =
    M3e.FabMenuTrigger.view


{-| Convenience binding for the `M3e.FabMenuItem` element: `view` re-exposed from `M3e.FabMenuItem`. Import that module directly for the strict, component-scoped types.
-}
fabMenuItem :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | fabMenuItem : M3e.Token.Supported } msg
fabMenuItem =
    M3e.FabMenuItem.view


{-| Convenience binding for the `M3e.FabMenu` element: `view` re-exposed from `M3e.FabMenu`. Import that module directly for the strict, component-scoped types.
-}
fabMenu :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { fabMenuItem : M3e.Token.Supported
                , menuItem : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | fabMenu : M3e.Token.Supported } msg
fabMenu =
    M3e.FabMenu.view


{-| Convenience binding for the `M3e.Fab` element: `view` re-exposed from `M3e.Fab`. Import that module directly for the strict, component-scoped types.
-}
fab :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { icon : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | fab : M3e.Token.Supported } msg
fab =
    M3e.Fab.view


{-| Convenience binding for the `M3e.Accordion` element: `view` re-exposed from `M3e.Accordion`. Import that module directly for the strict, component-scoped types.
-}
accordion :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { expansionPanel : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | accordion : M3e.Token.Supported } msg
accordion =
    M3e.Accordion.view


{-| Convenience binding for the `M3e.ExpansionPanel` element: `view` re-exposed from `M3e.ExpansionPanel`. Import that module directly for the strict, component-scoped types.
-}
expansionPanel :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | expansionPanel : M3e.Token.Supported } msg
expansionPanel =
    M3e.ExpansionPanel.view


{-| Convenience binding for the `M3e.ExpansionHeader` element: `view` re-exposed from `M3e.ExpansionHeader`. Import that module directly for the strict, component-scoped types.
-}
expansionHeader :
    List
        (M3e.Html.Attr.Attr
            { hideToggle : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | expansionHeader : M3e.Token.Supported } msg
expansionHeader =
    M3e.ExpansionHeader.view


{-| Convenience binding for the `M3e.DrawerToggle` element: `view` re-exposed from `M3e.DrawerToggle`. Import that module directly for the strict, component-scoped types.
-}
drawerToggle :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | drawerToggle : M3e.Token.Supported } msg
drawerToggle =
    M3e.DrawerToggle.view


{-| Convenience binding for the `M3e.DrawerContainer` element: `view` re-exposed from `M3e.DrawerContainer`. Import that module directly for the strict, component-scoped types.
-}
drawerContainer :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | drawerContainer : M3e.Token.Supported } msg
drawerContainer =
    M3e.DrawerContainer.view


{-| Convenience binding for the `M3e.Divider` element: `view` re-exposed from `M3e.Divider`. Import that module directly for the strict, component-scoped types.
-}
divider :
    List
        (M3e.Html.Attr.Attr
            { inset : M3e.Token.Supported
            , insetStart : M3e.Token.Supported
            , insetEnd : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | divider : M3e.Token.Supported } msg
divider =
    M3e.Divider.view


{-| Convenience binding for the `M3e.DialogTrigger` element: `view` re-exposed from `M3e.DialogTrigger`. Import that module directly for the strict, component-scoped types.
-}
dialogTrigger :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialogTrigger : M3e.Token.Supported } msg
dialogTrigger =
    M3e.DialogTrigger.view


{-| Convenience binding for the `M3e.Dialog` element: `view` re-exposed from `M3e.Dialog`. Import that module directly for the strict, component-scoped types.
-}
dialog :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialog : M3e.Token.Supported } msg
dialog =
    M3e.Dialog.view


{-| Convenience binding for the `M3e.DialogAction` element: `view` re-exposed from `M3e.DialogAction`. Import that module directly for the strict, component-scoped types.
-}
dialogAction :
    List
        (M3e.Html.Attr.Attr
            { returnValue : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialogAction : M3e.Token.Supported } msg
dialogAction =
    M3e.DialogAction.view


{-| Convenience binding for the `M3e.DatepickerToggle` element: `view` re-exposed from `M3e.DatepickerToggle`. Import that module directly for the strict, component-scoped types.
-}
datepickerToggle :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | datepickerToggle : M3e.Token.Supported } msg
datepickerToggle =
    M3e.DatepickerToggle.view


{-| Convenience binding for the `M3e.Datepicker` element: `view` re-exposed from `M3e.Datepicker`. Import that module directly for the strict, component-scoped types.
-}
datepicker :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | datepicker : M3e.Token.Supported } msg
datepicker =
    M3e.Datepicker.view


{-| Convenience binding for the `M3e.ContentPane` element: `view` re-exposed from `M3e.ContentPane`. Import that module directly for the strict, component-scoped types.
-}
contentPane :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | contentPane : M3e.Token.Supported } msg
contentPane =
    M3e.ContentPane.view


{-| Convenience binding for the `M3e.SuggestionChip` element: `view` re-exposed from `M3e.SuggestionChip`. Import that module directly for the strict, component-scoped types.
-}
suggestionChip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | suggestionChip : M3e.Token.Supported } msg
suggestionChip =
    M3e.SuggestionChip.view


{-| Convenience binding for the `M3e.InputChipSet` element: `view` re-exposed from `M3e.InputChipSet`. Import that module directly for the strict, component-scoped types.
-}
inputChipSet :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { inputChip : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | inputChipSet : M3e.Token.Supported } msg
inputChipSet =
    M3e.InputChipSet.view


{-| Convenience binding for the `M3e.InputChip` element: `view` re-exposed from `M3e.InputChip`. Import that module directly for the strict, component-scoped types.
-}
inputChip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Token.Supported } msg
inputChip =
    M3e.InputChip.view


{-| Convenience binding for the `M3e.FilterChipSet` element: `view` re-exposed from `M3e.FilterChipSet`. Import that module directly for the strict, component-scoped types.
-}
filterChipSet :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { filterChip : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | filterChipSet : M3e.Token.Supported } msg
filterChipSet =
    M3e.FilterChipSet.view


{-| Convenience binding for the `M3e.FilterChip` element: `view` re-exposed from `M3e.FilterChip`. Import that module directly for the strict, component-scoped types.
-}
filterChip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | filterChip : M3e.Token.Supported } msg
filterChip =
    M3e.FilterChip.view


{-| Convenience binding for the `M3e.ChipSet` element: `view` re-exposed from `M3e.ChipSet`. Import that module directly for the strict, component-scoped types.
-}
chipSet :
    List
        (M3e.Html.Attr.Attr
            { vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { assistChip : M3e.Token.Supported
                , chip : M3e.Token.Supported
                , filterChip : M3e.Token.Supported
                , inputChip : M3e.Token.Supported
                , suggestionChip : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | chipSet : M3e.Token.Supported } msg
chipSet =
    M3e.ChipSet.view


{-| Convenience binding for the `M3e.AssistChip` element: `view` re-exposed from `M3e.AssistChip`. Import that module directly for the strict, component-scoped types.
-}
assistChip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | assistChip : M3e.Token.Supported } msg
assistChip =
    M3e.AssistChip.view


{-| Convenience binding for the `M3e.Chip` element: `view` re-exposed from `M3e.Chip`. Import that module directly for the strict, component-scoped types.
-}
chip :
    List
        (M3e.Html.Attr.Attr
            { value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | chip : M3e.Token.Supported } msg
chip =
    M3e.Chip.view


{-| Convenience binding for the `M3e.Checkbox` element: `view` re-exposed from `M3e.Checkbox`. Import that module directly for the strict, component-scoped types.
-}
checkbox :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | checkbox : M3e.Token.Supported } msg
checkbox =
    M3e.Checkbox.view


{-| Convenience binding for the `M3e.Card` element: `view` re-exposed from `M3e.Card`. Import that module directly for the strict, component-scoped types.
-}
card :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | card : M3e.Token.Supported } msg
card =
    M3e.Card.view


{-| Convenience binding for the `M3e.Calendar` element: `view` re-exposed from `M3e.Calendar`. Import that module directly for the strict, component-scoped types.
-}
calendar :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | calendar : M3e.Token.Supported } msg
calendar =
    M3e.Calendar.view


{-| Convenience binding for the `M3e.YearView` element: `view` re-exposed from `M3e.YearView`. Import that module directly for the strict, component-scoped types.
-}
yearView :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | yearView : M3e.Token.Supported } msg
yearView =
    M3e.YearView.view


{-| Convenience binding for the `M3e.MultiYearView` element: `view` re-exposed from `M3e.MultiYearView`. Import that module directly for the strict, component-scoped types.
-}
multiYearView :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | multiYearView : M3e.Token.Supported } msg
multiYearView =
    M3e.MultiYearView.view


{-| Convenience binding for the `M3e.MonthView` element: `view` re-exposed from `M3e.MonthView`. Import that module directly for the strict, component-scoped types.
-}
monthView :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | monthView : M3e.Token.Supported } msg
monthView =
    M3e.MonthView.view


{-| Convenience binding for the `M3e.Tooltip` element: `view` re-exposed from `M3e.Tooltip`. Import that module directly for the strict, component-scoped types.
-}
tooltip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tooltip : M3e.Token.Supported } msg
tooltip =
    M3e.Tooltip.view


{-| Convenience binding for the `M3e.RichTooltip` element: `view` re-exposed from `M3e.RichTooltip`. Import that module directly for the strict, component-scoped types.
-}
richTooltip :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | richTooltip : M3e.Token.Supported } msg
richTooltip =
    M3e.RichTooltip.view


{-| Convenience binding for the `M3e.RichTooltipAction` element: `view` re-exposed from `M3e.RichTooltipAction`. Import that module directly for the strict, component-scoped types.
-}
richTooltipAction :
    List
        (M3e.Html.Attr.Attr
            { disableRestoreFocus : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Token.Supported } msg
richTooltipAction =
    M3e.RichTooltipAction.view


{-| Convenience binding for the `M3e.ButtonGroup` element: `view` re-exposed from `M3e.ButtonGroup`. Import that module directly for the strict, component-scoped types.
-}
buttonGroup :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { button : M3e.Token.Supported
                , iconButton : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | buttonGroup : M3e.Token.Supported } msg
buttonGroup =
    M3e.ButtonGroup.view


{-| Convenience binding for the `M3e.IconButton` element: `view` re-exposed from `M3e.IconButton`. Import that module directly for the strict, component-scoped types.
-}
iconButton :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { icon : M3e.Token.Supported
                , menuTrigger : M3e.Token.Supported
                , dialogTrigger : M3e.Token.Supported
                , fabMenuTrigger : M3e.Token.Supported
                , bottomSheetTrigger : M3e.Token.Supported
                , navRailToggle : M3e.Token.Supported
                , drawerToggle : M3e.Token.Supported
                , datepickerToggle : M3e.Token.Supported
                , dialogAction : M3e.Token.Supported
                , bottomSheetAction : M3e.Token.Supported
                , richTooltipAction : M3e.Token.Supported
                , stepperReset : M3e.Token.Supported
                , stepperPrevious : M3e.Token.Supported
                , stepperNext : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | iconButton : M3e.Token.Supported } msg
iconButton =
    M3e.IconButton.view


{-| Convenience binding for the `M3e.Button` element: `view` re-exposed from `M3e.Button`. Import that module directly for the strict, component-scoped types.
-}
button :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , icon : M3e.Token.Supported
                , menuTrigger : M3e.Token.Supported
                , dialogTrigger : M3e.Token.Supported
                , fabMenuTrigger : M3e.Token.Supported
                , bottomSheetTrigger : M3e.Token.Supported
                , navRailToggle : M3e.Token.Supported
                , drawerToggle : M3e.Token.Supported
                , datepickerToggle : M3e.Token.Supported
                , dialogAction : M3e.Token.Supported
                , bottomSheetAction : M3e.Token.Supported
                , richTooltipAction : M3e.Token.Supported
                , stepperReset : M3e.Token.Supported
                , stepperPrevious : M3e.Token.Supported
                , stepperNext : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | button : M3e.Token.Supported } msg
button =
    M3e.Button.view


{-| Convenience binding for the `M3e.Breadcrumb` element: `view` re-exposed from `M3e.Breadcrumb`. Import that module directly for the strict, component-scoped types.
-}
breadcrumb :
    List
        (M3e.Html.Attr.Attr
            { wrap : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { breadcrumbItem : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | breadcrumb : M3e.Token.Supported } msg
breadcrumb =
    M3e.Breadcrumb.view


{-| Convenience binding for the `M3e.BreadcrumbItem` element: `view` re-exposed from `M3e.BreadcrumbItem`. Import that module directly for the strict, component-scoped types.
-}
breadcrumbItem :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , icon : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | breadcrumbItem : M3e.Token.Supported } msg
breadcrumbItem =
    M3e.BreadcrumbItem.view


{-| Convenience binding for the `M3e.BreadcrumbItemButton` element: `view` re-exposed from `M3e.BreadcrumbItemButton`. Import that module directly for the strict, component-scoped types.
-}
breadcrumbItemButton :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , icon : M3e.Token.Supported
                }
                msg
            )
    ->
        M3e.Element.Element
            { s
                | breadcrumbItemButton : M3e.Token.Supported
            }
            msg
breadcrumbItemButton =
    M3e.BreadcrumbItemButton.view


{-| Convenience binding for the `M3e.BottomSheetTrigger` element: `view` re-exposed from `M3e.BottomSheetTrigger`. Import that module directly for the strict, component-scoped types.
-}
bottomSheetTrigger :
    List
        (M3e.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , secondary : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetTrigger : M3e.Token.Supported } msg
bottomSheetTrigger =
    M3e.BottomSheetTrigger.view


{-| Convenience binding for the `M3e.BottomSheet` element: `view` re-exposed from `M3e.BottomSheet`. Import that module directly for the strict, component-scoped types.
-}
bottomSheet :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | bottomSheet : M3e.Token.Supported } msg
bottomSheet =
    M3e.BottomSheet.view


{-| Convenience binding for the `M3e.BottomSheetAction` element: `view` re-exposed from `M3e.BottomSheetAction`. Import that module directly for the strict, component-scoped types.
-}
bottomSheetAction :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetAction : M3e.Token.Supported } msg
bottomSheetAction =
    M3e.BottomSheetAction.view


{-| Convenience binding for the `M3e.Badge` element: `view` re-exposed from `M3e.Badge`. Import that module directly for the strict, component-scoped types.
-}
badge :
    List
        (M3e.Html.Attr.Attr
            { size : M3e.Token.Supported
            , position : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | badge : M3e.Token.Supported } msg
badge =
    M3e.Badge.view


{-| Convenience binding for the `M3e.Avatar` element: `view` re-exposed from `M3e.Avatar`. Import that module directly for the strict, component-scoped types.
-}
avatar :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | avatar : M3e.Token.Supported } msg
avatar =
    M3e.Avatar.view


{-| Convenience binding for the `M3e.Autocomplete` element: `view` re-exposed from `M3e.Autocomplete`. Import that module directly for the strict, component-scoped types.
-}
autocomplete :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { option : M3e.Token.Supported
                , optgroup : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | autocomplete : M3e.Token.Supported } msg
autocomplete =
    M3e.Autocomplete.view


{-| Convenience binding for the `M3e.FormField` element: `view` re-exposed from `M3e.FormField`. Import that module directly for the strict, component-scoped types.
-}
formField :
    List
        (M3e.Html.Attr.Attr
            { floatLabel : M3e.Token.Supported
            , hideRequiredMarker : M3e.Token.Supported
            , hideSubscript : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | formField : M3e.Token.Supported } msg
formField =
    M3e.FormField.view


{-| Convenience binding for the `M3e.OptionPanel` element: `view` re-exposed from `M3e.OptionPanel`. Import that module directly for the strict, component-scoped types.
-}
optionPanel :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { option : M3e.Token.Supported
                , optgroup : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | optionPanel : M3e.Token.Supported } msg
optionPanel =
    M3e.OptionPanel.view


{-| Convenience binding for the `M3e.FloatingPanel` element: `view` re-exposed from `M3e.FloatingPanel`. Import that module directly for the strict, component-scoped types.
-}
floatingPanel :
    List
        (M3e.Html.Attr.Attr
            { scrollStrategy : M3e.Token.Supported
            , fitAnchorWidth : M3e.Token.Supported
            , anchorOffset : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | floatingPanel : M3e.Token.Supported } msg
floatingPanel =
    M3e.FloatingPanel.view


{-| Convenience binding for the `M3e.Optgroup` element: `view` re-exposed from `M3e.Optgroup`. Import that module directly for the strict, component-scoped types.
-}
optgroup :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element { option : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | optgroup : M3e.Token.Supported } msg
optgroup =
    M3e.Optgroup.view


{-| Convenience binding for the `M3e.Option` element: `view` re-exposed from `M3e.Option`. Import that module directly for the strict, component-scoped types.
-}
option :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | option : M3e.Token.Supported } msg
option =
    M3e.Option.view


{-| Convenience binding for the `M3e.FocusTrap` element: `view` re-exposed from `M3e.FocusTrap`. Import that module directly for the strict, component-scoped types.
-}
focusTrap :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | focusTrap : M3e.Token.Supported } msg
focusTrap =
    M3e.FocusTrap.view


{-| Convenience binding for the `M3e.AppBar` element: `view` re-exposed from `M3e.AppBar`. Import that module directly for the strict, component-scoped types.
-}
appBar :
    List
        (M3e.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , for : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | appBar : M3e.Token.Supported } msg
appBar =
    M3e.AppBar.view


{-| Convenience binding for the `M3e.TextOverflow` element: `view` re-exposed from `M3e.TextOverflow`. Import that module directly for the strict, component-scoped types.
-}
textOverflow :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | textOverflow : M3e.Token.Supported } msg
textOverflow =
    M3e.TextOverflow.view


{-| Convenience binding for the `M3e.TextHighlight` element: `view` re-exposed from `M3e.TextHighlight`. Import that module directly for the strict, component-scoped types.
-}
textHighlight :
    List
        (M3e.Html.Attr.Attr
            { caseSensitive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , term : M3e.Token.Supported
            , onHighlight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | textHighlight : M3e.Token.Supported } msg
textHighlight =
    M3e.TextHighlight.view


{-| Convenience binding for the `M3e.StateLayer` element: `view` re-exposed from `M3e.StateLayer`. Import that module directly for the strict, component-scoped types.
-}
stateLayer :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disableHover : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stateLayer : M3e.Token.Supported } msg
stateLayer =
    M3e.StateLayer.view


{-| Convenience binding for the `M3e.Slide` element: `view` re-exposed from `M3e.Slide`. Import that module directly for the strict, component-scoped types.
-}
slide :
    List
        (M3e.Html.Attr.Attr
            { selectedIndex : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slide : M3e.Token.Supported } msg
slide =
    M3e.Slide.view


{-| Convenience binding for the `M3e.ScrollContainer` element: `view` re-exposed from `M3e.ScrollContainer`. Import that module directly for the strict, component-scoped types.
-}
scrollContainer :
    List
        (M3e.Html.Attr.Attr
            { dividers : M3e.Token.Supported
            , thin : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | scrollContainer : M3e.Token.Supported } msg
scrollContainer =
    M3e.ScrollContainer.view


{-| Convenience binding for the `M3e.Ripple` element: `view` re-exposed from `M3e.Ripple`. Import that module directly for the strict, component-scoped types.
-}
ripple :
    List
        (M3e.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , radius : M3e.Token.Supported
            , unbounded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | ripple : M3e.Token.Supported } msg
ripple =
    M3e.Ripple.view


{-| Convenience binding for the `M3e.PseudoRadio` element: `view` re-exposed from `M3e.PseudoRadio`. Import that module directly for the strict, component-scoped types.
-}
pseudoRadio :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | pseudoRadio : M3e.Token.Supported } msg
pseudoRadio =
    M3e.PseudoRadio.view


{-| Convenience binding for the `M3e.PseudoCheckbox` element: `view` re-exposed from `M3e.PseudoCheckbox`. Import that module directly for the strict, component-scoped types.
-}
pseudoCheckbox :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | pseudoCheckbox : M3e.Token.Supported } msg
pseudoCheckbox =
    M3e.PseudoCheckbox.view


{-| Convenience binding for the `M3e.FocusRing` element: `view` re-exposed from `M3e.FocusRing`. Import that module directly for the strict, component-scoped types.
-}
focusRing :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , inward : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | focusRing : M3e.Token.Supported } msg
focusRing =
    M3e.FocusRing.view


{-| Convenience binding for the `M3e.Elevation` element: `view` re-exposed from `M3e.Elevation`. Import that module directly for the strict, component-scoped types.
-}
elevation :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , level : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | elevation : M3e.Token.Supported } msg
elevation =
    M3e.Elevation.view


{-| Convenience binding for the `M3e.Collapsible` element: `view` re-exposed from `M3e.Collapsible`. Import that module directly for the strict, component-scoped types.
-}
collapsible :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | collapsible : M3e.Token.Supported } msg
collapsible =
    M3e.Collapsible.view


{-| The label of the snackbar's action. (default: `""`)
-}
attrAction : String -> M3e.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
attrAction =
    M3e.Html.Shared.action


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
attrActionable : Bool -> M3e.Html.Attr.Attr { c | actionable : M3e.Token.Supported } msg
attrActionable =
    M3e.Html.Shared.actionable


{-| Whether the view is active. (default: `false`)
-}
attrActive : Bool -> M3e.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
attrActive =
    M3e.Html.Shared.active


{-| The active date. (default: `new Date()`)
-}
attrActiveDate : String -> M3e.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
attrActiveDate =
    M3e.Html.Shared.activeDate


{-| Whether the dialog is an alert. (default: `false`)
-}
attrAlert : Bool -> M3e.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
attrAlert =
    M3e.Html.Shared.alert


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
attrAnchorOffset : Float -> M3e.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
attrAnchorOffset =
    M3e.Html.Shared.anchorOffset


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid : String -> M3e.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    M3e.Html.Shared.ariaInvalid


{-| Whether the first option should be automatically activated. (default: `false`)
-}
attrAutoActivate : Bool -> M3e.Html.Attr.Attr { c | autoActivate : M3e.Token.Supported } msg
attrAutoActivate =
    M3e.Html.Shared.autoActivate


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
attrBufferValue : Float -> M3e.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
attrBufferValue =
    M3e.Html.Shared.bufferValue


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
attrCascade : Bool -> M3e.Html.Attr.Attr { c | cascade : M3e.Token.Supported } msg
attrCascade =
    M3e.Html.Shared.cascade


{-| Whether filtering is case sensitive. (default: `false`)
-}
attrCaseSensitive : Bool -> M3e.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
attrCaseSensitive =
    M3e.Html.Shared.caseSensitive


{-| Whether the title and subtitle are centered. (default: `false`)
-}
attrCentered : Bool -> M3e.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
attrCentered =
    M3e.Html.Shared.centered


{-| Whether the element is checked. (default: `false`)
-}
attrChecked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
attrChecked =
    M3e.Html.Shared.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
attrClearLabel : String -> M3e.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
attrClearLabel =
    M3e.Html.Shared.clearLabel


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
attrClearable : Bool -> M3e.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
attrClearable =
    M3e.Html.Shared.clearable


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
attrCloseLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
attrCloseLabel =
    M3e.Html.Shared.closeLabel


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
attrColor : String -> M3e.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
attrColor =
    M3e.Html.Shared.color


{-| Whether the step has been completed. (default: `false`)
-}
attrCompleted : Bool -> M3e.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
attrCompleted =
    M3e.Html.Shared.completed


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
attrConfirmLabel : String -> M3e.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
attrConfirmLabel =
    M3e.Html.Shared.confirmLabel


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
attrContained : Bool -> M3e.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
attrContained =
    M3e.Html.Shared.contained


{-| The selected date. (default: `null`)
-}
attrDate : String -> M3e.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
attrDate =
    M3e.Html.Shared.date


{-| The density scale (0, -1, -2). (default: `0`)
-}
attrDensity : Float -> M3e.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
attrDensity =
    M3e.Html.Shared.density


{-| The zero‑based index of the detent the sheet should open to.
-}
attrDetent : Float -> M3e.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
attrDetent =
    M3e.Html.Shared.detent


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
attrDetents : String -> M3e.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
attrDetents =
    M3e.Html.Shared.detents


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
attrDisableClose : Bool -> M3e.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
attrDisableClose =
    M3e.Html.Shared.disableClose


{-| Whether text highlighting is disabled. (default: `false`)
-}
attrDisableHighlight :
    Bool
    -> M3e.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
attrDisableHighlight =
    M3e.Html.Shared.disableHighlight


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
attrDisableHover : Bool -> M3e.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
attrDisableHover =
    M3e.Html.Shared.disableHover


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
attrDisableRestoreFocus :
    Bool
    -> M3e.Html.Attr.Attr { c | disableRestoreFocus : M3e.Token.Supported } msg
attrDisableRestoreFocus =
    M3e.Html.Shared.disableRestoreFocus


{-| Whether the element is disabled. (default: `false`)
-}
attrDisabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
attrDisabled =
    M3e.Html.Shared.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
attrDisabledInteractive :
    Bool
    -> M3e.Html.Attr.Attr { c | disabledInteractive : M3e.Token.Supported } msg
attrDisabledInteractive =
    M3e.Html.Shared.disabledInteractive


{-| Whether to show tick marks. (default: `false`)
-}
attrDiscrete : Bool -> M3e.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
attrDiscrete =
    M3e.Html.Shared.discrete


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
attrDismissLabel : String -> M3e.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
attrDismissLabel =
    M3e.Html.Shared.dismissLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
attrDismissible : Bool -> M3e.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
attrDismissible =
    M3e.Html.Shared.dismissible


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
attrDownload : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
attrDownload =
    M3e.Html.Shared.download


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
attrDuration : Float -> M3e.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
attrDuration =
    M3e.Html.Shared.duration


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
attrEditable : Bool -> M3e.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
attrEditable =
    M3e.Html.Shared.editable


{-| Whether the toolbar is elevated. (default: `false`)
-}
attrElevated : Bool -> M3e.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
attrElevated =
    M3e.Html.Shared.elevated


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
attrEmphasized : Bool -> M3e.Html.Attr.Attr { c | emphasized : M3e.Token.Supported } msg
attrEmphasized =
    M3e.Html.Shared.emphasized


{-| Whether the end drawer is open. (default: `false`)
-}
attrEnd : Bool -> M3e.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
attrEnd =
    M3e.Html.Shared.end


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
attrEndDivider : Bool -> M3e.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
attrEndDivider =
    M3e.Html.Shared.endDivider


{-| Whether the button is extended to show the label. (default: `false`)
-}
attrExtended : Bool -> M3e.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
attrExtended =
    M3e.Html.Shared.extended


{-| Whether the icon is filled. (default: `false`)
-}
attrFilled : Bool -> M3e.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
attrFilled =
    M3e.Html.Shared.filled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
attrFirstPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
attrFirstPageLabel =
    M3e.Html.Shared.firstPageLabel


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
attrFitAnchorWidth : Bool -> M3e.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
attrFitAnchorWidth =
    M3e.Html.Shared.fitAnchorWidth


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
attrFor : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
attrFor =
    M3e.Html.Shared.for


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
attrHandle : Bool -> M3e.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
attrHandle =
    M3e.Html.Shared.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
attrHandleLabel : String -> M3e.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
attrHandleLabel =
    M3e.Html.Shared.handleLabel


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
attrHideDelay : Float -> M3e.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
attrHideDelay =
    M3e.Html.Shared.hideDelay


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
attrHideFriction : Float -> M3e.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
attrHideFriction =
    M3e.Html.Shared.hideFriction


{-| Whether to hide the menu when loading options. (default: `false`)
-}
attrHideLoading : Bool -> M3e.Html.Attr.Attr { c | hideLoading : M3e.Token.Supported } msg
attrHideLoading =
    M3e.Html.Shared.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
attrHideNoData : Bool -> M3e.Html.Attr.Attr { c | hideNoData : M3e.Token.Supported } msg
attrHideNoData =
    M3e.Html.Shared.hideNoData


{-| Whether to hide page size selection. (default: `false`)
-}
attrHidePageSize : Bool -> M3e.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
attrHidePageSize =
    M3e.Html.Shared.hidePageSize


{-| Whether the required marker should be hidden. (default: `false`)
-}
attrHideRequiredMarker :
    Bool
    -> M3e.Html.Attr.Attr { c | hideRequiredMarker : M3e.Token.Supported } msg
attrHideRequiredMarker =
    M3e.Html.Shared.hideRequiredMarker


{-| Whether to hide the search icon. (default: `false`)
-}
attrHideSearchIcon : Bool -> M3e.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
attrHideSearchIcon =
    M3e.Html.Shared.hideSearchIcon


{-| Whether to hide the selection indicator. (default: `false`)
-}
attrHideSelectionIndicator :
    Bool
    ->
        M3e.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
attrHideSelectionIndicator =
    M3e.Html.Shared.hideSelectionIndicator


{-| Whether to hide the expansion toggle. (default: `false`)
-}
attrHideToggle : Bool -> M3e.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
attrHideToggle =
    M3e.Html.Shared.hideToggle


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
attrHideable : Bool -> M3e.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
attrHideable =
    M3e.Html.Shared.hideable


{-| The URL to which the link button points. (default: `""`)
-}
attrHref : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
attrHref =
    M3e.Html.Shared.href


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
attrIndeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
attrIndeterminate =
    M3e.Html.Shared.indeterminate


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
attrInline : Bool -> M3e.Html.Attr.Attr { c | inline : M3e.Token.Supported } msg
attrInline =
    M3e.Html.Shared.inline


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
attrInset : Bool -> M3e.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
attrInset =
    M3e.Html.Shared.inset


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
attrInsetEnd : Bool -> M3e.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
attrInsetEnd =
    M3e.Html.Shared.insetEnd


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
attrInsetStart : Bool -> M3e.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
attrInsetStart =
    M3e.Html.Shared.insetStart


{-| Whether the step has an error. (default: `false`)
-}
attrInvalid : Bool -> M3e.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
attrInvalid =
    M3e.Html.Shared.invalid


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
attrInward : Bool -> M3e.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
attrInward =
    M3e.Html.Shared.inward


{-| The accessible label given to the item's internal button. (default: `""`)
-}
attrItemLabel : String -> M3e.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
attrItemLabel =
    M3e.Html.Shared.itemLabel


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
attrItemsPerPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
attrItemsPerPageLabel =
    M3e.Html.Shared.itemsPerPageLabel


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
attrLabel : String -> M3e.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
attrLabel =
    M3e.Html.Shared.label


{-| Whether to show value labels when activated. (default: `false`)
-}
attrLabelled : Bool -> M3e.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
attrLabelled =
    M3e.Html.Shared.labelled


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
attrLastPageLabel : String -> M3e.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
attrLastPageLabel =
    M3e.Html.Shared.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
attrLength : Float -> M3e.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
attrLength =
    M3e.Html.Shared.length


{-| The accessibility level of the heading.
-}
attrLevel : Int -> M3e.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
attrLevel =
    M3e.Html.Shared.level


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
attrLinear : Bool -> M3e.Html.Attr.Attr { c | linear : M3e.Token.Supported } msg
attrLinear =
    M3e.Html.Shared.linear


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
attrLoaded : Bool -> M3e.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
attrLoaded =
    M3e.Html.Shared.loaded


{-| Whether options are being loaded. (default: `false`)
-}
attrLoading : Bool -> M3e.Html.Attr.Attr { c | loading : M3e.Token.Supported } msg
attrLoading =
    M3e.Html.Shared.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
attrLoadingLabel : String -> M3e.Html.Attr.Attr { c | loadingLabel : M3e.Token.Supported } msg
attrLoadingLabel =
    M3e.Html.Shared.loadingLabel


{-| Whether to present a lowered elevation. (default: `false`)
-}
attrLowered : Bool -> M3e.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
attrLowered =
    M3e.Html.Shared.lowered


{-| Exclude this heading from the table of contents generated by an `m3e-toc` component. `m3e-toc-ignore` is a valueless presence marker the `m3e-toc` reads from heading elements; it is not an `m3e-heading` CEM attribute, so it is injected here as a heading-scoped synthetic capability.
-}
attrTocIgnore : Bool -> M3e.Html.Attr.Attr { c | tocIgnore : M3e.Token.Supported } msg
attrTocIgnore =
    M3e.Html.Shared.tocIgnore


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
attrMax : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
attrMax =
    M3e.Html.Shared.max


{-| The maximum date that can be selected. (default: `null`)
-}
attrMaxDate : String -> M3e.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
attrMaxDate =
    M3e.Html.Shared.maxDate


{-| The maximum depth of the table of contents. (default: `2`)
-}
attrMaxDepth : Float -> M3e.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
attrMaxDepth =
    M3e.Html.Shared.maxDepth


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
attrMaxRows : Float -> M3e.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
attrMaxRows =
    M3e.Html.Shared.maxRows


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
attrMin : Float -> M3e.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
attrMin =
    M3e.Html.Shared.min


{-| The minimum date that can be selected. (default: `null`)
-}
attrMinDate : String -> M3e.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
attrMinDate =
    M3e.Html.Shared.minDate


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
attrMinRows : Float -> M3e.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
attrMinRows =
    M3e.Html.Shared.minRows


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
attrModal : Bool -> M3e.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
attrModal =
    M3e.Html.Shared.modal


{-| Whether multiple items can be selected. (default: `false`)
-}
attrMulti : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
attrMulti =
    M3e.Html.Shared.multi


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
attrNextMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
attrNextMonthLabel =
    M3e.Html.Shared.nextMonthLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
attrNextMultiYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMultiYearLabel : M3e.Token.Supported } msg
attrNextMultiYearLabel =
    M3e.Html.Shared.nextMultiYearLabel


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
attrNextPageLabel : String -> M3e.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
attrNextPageLabel =
    M3e.Html.Shared.nextPageLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
attrNextYearLabel : String -> M3e.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
attrNextYearLabel =
    M3e.Html.Shared.nextYearLabel


{-| Whether to disable animation. (default: `false`)
-}
attrNoAnimate : Bool -> M3e.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
attrNoAnimate =
    M3e.Html.Shared.noAnimate


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
attrNoDataLabel : String -> M3e.Html.Attr.Attr { c | noDataLabel : M3e.Token.Supported } msg
attrNoDataLabel =
    M3e.Html.Shared.noDataLabel


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
attrNoFocusTrap : Bool -> M3e.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
attrNoFocusTrap =
    M3e.Html.Shared.noFocusTrap


{-| Whether the item is expanded. (default: `false`)
-}
attrOpen : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
attrOpen =
    M3e.Html.Shared.open


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
attrOpticalSize : Float -> M3e.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
attrOpticalSize =
    M3e.Html.Shared.opticalSize


{-| Whether the step is optional. (default: `false`)
-}
attrOptional : Bool -> M3e.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
attrOptional =
    M3e.Html.Shared.optional


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
attrOvershootLimit : Float -> M3e.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
attrOvershootLimit =
    M3e.Html.Shared.overshootLimit


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
attrPageIndex : Float -> M3e.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
attrPageIndex =
    M3e.Html.Shared.pageIndex


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
attrPageSizes : String -> M3e.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
attrPageSizes =
    M3e.Html.Shared.pageSizes


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
attrPanelClass : String -> M3e.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
attrPanelClass =
    M3e.Html.Shared.panelClass


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
attrPreviousMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousMonthLabel : M3e.Token.Supported } msg
attrPreviousMonthLabel =
    M3e.Html.Shared.previousMonthLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
attrPreviousMultiYearLabel :
    String
    ->
        M3e.Html.Attr.Attr
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
    -> M3e.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
attrPreviousPageLabel =
    M3e.Html.Shared.previousPageLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
attrPreviousYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
attrPreviousYearLabel =
    M3e.Html.Shared.previousYearLabel


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
attrRadius : Float -> M3e.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
attrRadius =
    M3e.Html.Shared.radius


{-| Whether a range of dates can be selected. (default: `false`)
-}
attrRange : Bool -> M3e.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
attrRange =
    M3e.Html.Shared.range


{-| End of a date range. (default: `null`)
-}
attrRangeEnd : String -> M3e.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
attrRangeEnd =
    M3e.Html.Shared.rangeEnd


{-| Start of a date range. (default: `null`)
-}
attrRangeStart : String -> M3e.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
attrRangeStart =
    M3e.Html.Shared.rangeStart


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
attrRel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
attrRel =
    M3e.Html.Shared.rel


{-| Whether the chip is removable. (default: `false`)
-}
attrRemovable : Bool -> M3e.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
attrRemovable =
    M3e.Html.Shared.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
attrRemoveLabel : String -> M3e.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
attrRemoveLabel =
    M3e.Html.Shared.removeLabel


{-| Whether the element is required. (default: `false`)
-}
attrRequired : Bool -> M3e.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
attrRequired =
    M3e.Html.Shared.required


{-| The value to return from the dialog. (default: `""`)
-}
attrReturnValue : String -> M3e.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
attrReturnValue =
    M3e.Html.Shared.returnValue


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
attrSecondary : Bool -> M3e.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
attrSecondary =
    M3e.Html.Shared.secondary


{-| Whether the item is selected. (default: `false`)
-}
attrSelected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
attrSelected =
    M3e.Html.Shared.selected


{-| The zero-based index of the visible item. (default: `null`)
-}
attrSelectedIndex : Float -> M3e.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
attrSelectedIndex =
    M3e.Html.Shared.selectedIndex


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
attrShowDelay : Float -> M3e.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
attrShowDelay =
    M3e.Html.Shared.showDelay


{-| Whether to show first/last buttons. (default: `false`)
-}
attrShowFirstLastButtons :
    Bool
    -> M3e.Html.Attr.Attr { c | showFirstLastButtons : M3e.Token.Supported } msg
attrShowFirstLastButtons =
    M3e.Html.Shared.showFirstLastButtons


{-| Whether the start drawer is open. (default: `false`)
-}
attrStart : Bool -> M3e.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
attrStart =
    M3e.Html.Shared.start


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
attrStartAt : String -> M3e.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
attrStartAt =
    M3e.Html.Shared.startAt


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
attrStartDivider : Bool -> M3e.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
attrStartDivider =
    M3e.Html.Shared.startDivider


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
attrStep : Float -> M3e.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
attrStep =
    M3e.Html.Shared.step


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
attrStretch : Bool -> M3e.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
attrStretch =
    M3e.Html.Shared.stretch


{-| Whether to enable strong focus indicators. (default: `false`)
-}
attrStrongFocus : Bool -> M3e.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
attrStrongFocus =
    M3e.Html.Shared.strongFocus


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
attrSubmenu : Bool -> M3e.Html.Attr.Attr { c | submenu : M3e.Token.Supported } msg
attrSubmenu =
    M3e.Html.Shared.submenu


{-| The target of the link button. (default: `""`)
-}
attrTarget : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
attrTarget =
    M3e.Html.Shared.target


{-| The search term to highlight. (default: `""`)
-}
attrTerm : String -> M3e.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
attrTerm =
    M3e.Html.Shared.term


{-| Whether to present thin scrollbars. (default: `false`)
-}
attrThin : Bool -> M3e.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
attrThin =
    M3e.Html.Shared.thin


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
attrThreshold : Float -> M3e.Html.Attr.Attr { c | threshold : M3e.Token.Supported } msg
attrThreshold =
    M3e.Html.Shared.threshold


{-| Today's date. (default: `new Date()`)
-}
attrToday : String -> M3e.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
attrToday =
    M3e.Html.Shared.today


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
attrToggle : Bool -> M3e.Html.Attr.Attr { c | toggle : M3e.Token.Supported } msg
attrToggle =
    M3e.Html.Shared.toggle


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
attrUnbounded : Bool -> M3e.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
attrUnbounded =
    M3e.Html.Shared.unbounded


{-| Whether the element is oriented vertically. (default: `false`)
-}
attrVertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
attrVertical =
    M3e.Html.Shared.vertical


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
attrWeight : Int -> M3e.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
attrWeight =
    M3e.Html.Shared.weight


{-| Whether items wrap to a new line. (default: `false`)
-}
attrWrap : Bool -> M3e.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
attrWrap =
    M3e.Html.Shared.wrap


{-| Whether cycling through detents will wrap. (default: `false`)
-}
attrWrapDetents : Bool -> M3e.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
attrWrapDetents =
    M3e.Html.Shared.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
attrName : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
attrName =
    M3e.Html.Shared.name


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
attrValueFloat : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
attrValueFloat =
    M3e.Html.Shared.valueFloat


{-| A string representing the value of the switch. (default: `"on"`)
-}
attrValue : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
attrValue =
    M3e.Html.Shared.value


{-| Set `animation="none"` — the `none` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`)
-}
animationNone : M3e.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationNone =
    M3e.Html.Shared.animation M3e.Token.none


{-| Set `animation="pulse"` — the `pulse` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`)
-}
animationPulse : M3e.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationPulse =
    M3e.Html.Shared.animation M3e.Token.pulse


{-| Set `animation="wave"` — the `wave` value of the `animation` attribute, baked as a constant. The animation effect of the skeleton. (default: `"wave"`)
-}
animationWave : M3e.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animationWave =
    M3e.Html.Shared.animation M3e.Token.wave


{-| Set `contrast="high"` — the `high` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`)
-}
contrastHigh : M3e.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastHigh =
    M3e.Html.Shared.contrast M3e.Token.high


{-| Set `contrast="medium"` — the `medium` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`)
-}
contrastMedium : M3e.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastMedium =
    M3e.Html.Shared.contrast M3e.Token.medium


{-| Set `contrast="standard"` — the `standard` value of the `contrast` attribute, baked as a constant. The contrast level of the theme. (default: `"standard"`)
-}
contrastStandard : M3e.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrastStandard =
    M3e.Html.Shared.contrast M3e.Token.standard


{-| Set `current="date"` — the `date` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentDate : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentDate =
    M3e.Html.Shared.current M3e.Token.date


{-| Set `current="location"` — the `location` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentLocation : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentLocation =
    M3e.Html.Shared.current M3e.Token.location


{-| Set `current="page"` — the `page` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentPage : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentPage =
    M3e.Html.Shared.current M3e.Token.page


{-| Set `current="step"` — the `step` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentStep : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentStep =
    M3e.Html.Shared.current M3e.Token.step


{-| Set `current="time"` — the `time` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentTime : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentTime =
    M3e.Html.Shared.current M3e.Token.time


{-| Set `current="true"` — the `true` value of the `current` attribute, baked as a constant. Indicates the current item in the breadcrumb path.
-}
currentTrue : M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
currentTrue =
    M3e.Html.Shared.current M3e.Token.true


{-| Set `disable-pagination="true"` — the `true` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled.
-}
disablePaginationTrue : M3e.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationTrue =
    M3e.Html.Shared.disablePagination M3e.Token.true


{-| Set `disable-pagination="false"` — the `false` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled.
-}
disablePaginationFalse : M3e.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationFalse =
    M3e.Html.Shared.disablePagination M3e.Token.false


{-| Set `disable-pagination="auto"` — the `auto` value of the `disablePagination` attribute, baked as a constant. Whether scroll buttons are disabled.
-}
disablePaginationAuto : M3e.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePaginationAuto =
    M3e.Html.Shared.disablePagination M3e.Token.auto


{-| Set `dividers="above"` — the `above` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividersAbove : M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersAbove =
    M3e.Html.Shared.dividers M3e.Token.above


{-| Set `dividers="aboveBelow"` — the `aboveBelow` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividersAboveBelow : M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersAboveBelow =
    M3e.Html.Shared.dividers M3e.Token.aboveBelow


{-| Set `dividers="below"` — the `below` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividersBelow : M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersBelow =
    M3e.Html.Shared.dividers M3e.Token.below


{-| Set `dividers="none"` — the `none` value of the `dividers` attribute, baked as a constant. The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividersNone : M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividersNone =
    M3e.Html.Shared.dividers M3e.Token.none


{-| Set `end-mode="auto"` — the `auto` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`)
-}
endModeAuto : M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeAuto =
    M3e.Html.Shared.endMode M3e.Token.auto


{-| Set `end-mode="over"` — the `over` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`)
-}
endModeOver : M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeOver =
    M3e.Html.Shared.endMode M3e.Token.over


{-| Set `end-mode="push"` — the `push` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`)
-}
endModePush : M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModePush =
    M3e.Html.Shared.endMode M3e.Token.push


{-| Set `end-mode="side"` — the `side` value of the `endMode` attribute, baked as a constant. The behavior mode of the end drawer. (default: `"side"`)
-}
endModeSide : M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endModeSide =
    M3e.Html.Shared.endMode M3e.Token.side


{-| Set `filter="contains"` — the `contains` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`)
-}
filterContains : M3e.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterContains =
    M3e.Html.Shared.filter M3e.Token.contains


{-| Set `filter="endsWith"` — the `endsWith` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`)
-}
filterEndsWith : M3e.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterEndsWith =
    M3e.Html.Shared.filter M3e.Token.endsWith


{-| Set `filter="none"` — the `none` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`)
-}
filterNone : M3e.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterNone =
    M3e.Html.Shared.filter M3e.Token.none


{-| Set `filter="startsWith"` — the `startsWith` value of the `filter` attribute, baked as a constant. Mode in which to filter options. (default: `"contains"`)
-}
filterStartsWith : M3e.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filterStartsWith =
    M3e.Html.Shared.filter M3e.Token.startsWith


{-| Set `float-label="always"` — the `always` value of the `floatLabel` attribute, baked as a constant. Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabelAlways : M3e.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabelAlways =
    M3e.Html.Shared.floatLabel M3e.Token.always


{-| Set `float-label="auto"` — the `auto` value of the `floatLabel` attribute, baked as a constant. Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabelAuto : M3e.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabelAuto =
    M3e.Html.Shared.floatLabel M3e.Token.auto


{-| Set `grade="high"` — the `high` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`)
-}
gradeHigh : M3e.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeHigh =
    M3e.Html.Shared.grade M3e.Token.high


{-| Set `grade="low"` — the `low` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`)
-}
gradeLow : M3e.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeLow =
    M3e.Html.Shared.grade M3e.Token.low


{-| Set `grade="medium"` — the `medium` value of the `grade` attribute, baked as a constant. The grade of the icon. (default: `"medium"`)
-}
gradeMedium : M3e.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
gradeMedium =
    M3e.Html.Shared.grade M3e.Token.medium


{-| Set `header-position="after"` — the `after` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`)
-}
headerPositionAfter : M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionAfter =
    M3e.Html.Shared.headerPosition M3e.Token.after


{-| Set `header-position="before"` — the `before` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`)
-}
headerPositionBefore : M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionBefore =
    M3e.Html.Shared.headerPosition M3e.Token.before


{-| Set `header-position="above"` — the `above` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`)
-}
headerPositionAbove : M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionAbove =
    M3e.Html.Shared.headerPosition M3e.Token.above


{-| Set `header-position="below"` — the `below` value of the `headerPosition` attribute, baked as a constant. The position of the tab headers. (default: `"before"`)
-}
headerPositionBelow : M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPositionBelow =
    M3e.Html.Shared.headerPosition M3e.Token.below


{-| Set `hide-subscript="always"` — the `always` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscriptAlways : M3e.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptAlways =
    M3e.Html.Shared.hideSubscript M3e.Token.always


{-| Set `hide-subscript="auto"` — the `auto` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscriptAuto : M3e.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptAuto =
    M3e.Html.Shared.hideSubscript M3e.Token.auto


{-| Set `hide-subscript="never"` — the `never` value of the `hideSubscript` attribute, baked as a constant. Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscriptNever : M3e.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscriptNever =
    M3e.Html.Shared.hideSubscript M3e.Token.never


{-| Set `highlight-mode="contains"` — the `contains` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`)
-}
highlightModeContains : M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeContains =
    M3e.Html.Shared.highlightMode M3e.Token.contains


{-| Set `highlight-mode="endsWith"` — the `endsWith` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`)
-}
highlightModeEndsWith : M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeEndsWith =
    M3e.Html.Shared.highlightMode M3e.Token.endsWith


{-| Set `highlight-mode="startsWith"` — the `startsWith` value of the `highlightMode` attribute, baked as a constant. The mode in which to highlight a term. (default: `"contains"`)
-}
highlightModeStartsWith : M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightModeStartsWith =
    M3e.Html.Shared.highlightMode M3e.Token.startsWith


{-| Set `icons="both"` — the `both` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`)
-}
iconsBoth : M3e.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsBoth =
    M3e.Html.Shared.icons M3e.Token.both


{-| Set `icons="none"` — the `none` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`)
-}
iconsNone : M3e.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsNone =
    M3e.Html.Shared.icons M3e.Token.none


{-| Set `icons="selected"` — the `selected` value of the `icons` attribute, baked as a constant. The icons to present. (default: `"none"`)
-}
iconsSelected : M3e.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
iconsSelected =
    M3e.Html.Shared.icons M3e.Token.selected


{-| Set `label-position="below"` — the `below` value of the `labelPosition` attribute, baked as a constant. The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPositionBelow : M3e.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPositionBelow =
    M3e.Html.Shared.labelPosition M3e.Token.below


{-| Set `label-position="end"` — the `end` value of the `labelPosition` attribute, baked as a constant. The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPositionEnd : M3e.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPositionEnd =
    M3e.Html.Shared.labelPosition M3e.Token.end


{-| Set `mode="auto"` — the `auto` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeAuto : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeAuto =
    M3e.Html.Shared.mode M3e.Token.auto


{-| Set `mode="docked"` — the `docked` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeDocked : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeDocked =
    M3e.Html.Shared.mode M3e.Token.docked


{-| Set `mode="fullscreen"` — the `fullscreen` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeFullscreen : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeFullscreen =
    M3e.Html.Shared.mode M3e.Token.fullscreen


{-| Set `mode="buffer"` — the `buffer` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeBuffer : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeBuffer =
    M3e.Html.Shared.mode M3e.Token.buffer


{-| Set `mode="determinate"` — the `determinate` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeDeterminate : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeDeterminate =
    M3e.Html.Shared.mode M3e.Token.determinate


{-| Set `mode="indeterminate"` — the `indeterminate` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeIndeterminate : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeIndeterminate =
    M3e.Html.Shared.mode M3e.Token.indeterminate


{-| Set `mode="query"` — the `query` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeQuery : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeQuery =
    M3e.Html.Shared.mode M3e.Token.query


{-| Set `mode="compact"` — the `compact` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeCompact : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeCompact =
    M3e.Html.Shared.mode M3e.Token.compact


{-| Set `mode="expanded"` — the `expanded` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeExpanded : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeExpanded =
    M3e.Html.Shared.mode M3e.Token.expanded


{-| Set `mode="contains"` — the `contains` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeContains : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeContains =
    M3e.Html.Shared.mode M3e.Token.contains


{-| Set `mode="endsWith"` — the `endsWith` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeEndsWith : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeEndsWith =
    M3e.Html.Shared.mode M3e.Token.endsWith


{-| Set `mode="startsWith"` — the `startsWith` value of the `mode` attribute, baked as a constant. The behavior mode of the view. (default: `"docked"`)
-}
modeStartsWith : M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
modeStartsWith =
    M3e.Html.Shared.mode M3e.Token.startsWith


{-| Set `motion="expressive"` — the `expressive` value of the `motion` attribute, baked as a constant. The motion scheme. (default: `"standard"`)
-}
motionExpressive : M3e.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motionExpressive =
    M3e.Html.Shared.motion M3e.Token.expressive


{-| Set `motion="standard"` — the `standard` value of the `motion` attribute, baked as a constant. The motion scheme. (default: `"standard"`)
-}
motionStandard : M3e.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motionStandard =
    M3e.Html.Shared.motion M3e.Token.standard


{-| Set `orientation="auto"` — the `auto` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`)
-}
orientationAuto : M3e.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationAuto =
    M3e.Html.Shared.orientation M3e.Token.auto


{-| Set `orientation="horizontal"` — the `horizontal` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`)
-}
orientationHorizontal : M3e.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationHorizontal =
    M3e.Html.Shared.orientation M3e.Token.horizontal


{-| Set `orientation="vertical"` — the `vertical` value of the `orientation` attribute, baked as a constant. The orientation of the stepper. (default: `"horizontal"`)
-}
orientationVertical : M3e.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientationVertical =
    M3e.Html.Shared.orientation M3e.Token.vertical


{-| Set `page-size="all"` — the `all` value of the `pageSize` attribute, baked as a constant. The number of items to display in a page. (default: `50`)
-}
pageSizeAll : M3e.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSizeAll =
    M3e.Html.Shared.pageSize M3e.Token.all


{-| Set `page-size-variant="filled"` — the `filled` value of the `pageSizeVariant` attribute, baked as a constant. The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariantFilled : M3e.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariantFilled =
    M3e.Html.Shared.pageSizeVariant M3e.Token.filled


{-| Set `page-size-variant="outlined"` — the `outlined` value of the `pageSizeVariant` attribute, baked as a constant. The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariantOutlined : M3e.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariantOutlined =
    M3e.Html.Shared.pageSizeVariant M3e.Token.outlined


{-| Set `position="above"` — the `above` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionAbove : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAbove =
    M3e.Html.Shared.position M3e.Token.above


{-| Set `position="after"` — the `after` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionAfter : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAfter =
    M3e.Html.Shared.position M3e.Token.after


{-| Set `position="before"` — the `before` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionBefore : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBefore =
    M3e.Html.Shared.position M3e.Token.before


{-| Set `position="below"` — the `below` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionBelow : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelow =
    M3e.Html.Shared.position M3e.Token.below


{-| Set `position="aboveAfter"` — the `aboveAfter` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionAboveAfter : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAboveAfter =
    M3e.Html.Shared.position M3e.Token.aboveAfter


{-| Set `position="aboveBefore"` — the `aboveBefore` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionAboveBefore : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionAboveBefore =
    M3e.Html.Shared.position M3e.Token.aboveBefore


{-| Set `position="belowAfter"` — the `belowAfter` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionBelowAfter : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelowAfter =
    M3e.Html.Shared.position M3e.Token.belowAfter


{-| Set `position="belowBefore"` — the `belowBefore` value of the `position` attribute, baked as a constant. The position of the tooltip. (default: `"below"`)
-}
positionBelowBefore : M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
positionBelowBefore =
    M3e.Html.Shared.position M3e.Token.belowBefore


{-| Set `position-x="after"` — the `after` value of the `positionX` attribute, baked as a constant. The position of the menu, on the x-axis. (default: `"after"`)
-}
positionXAfter : M3e.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionXAfter =
    M3e.Html.Shared.positionX M3e.Token.after


{-| Set `position-x="before"` — the `before` value of the `positionX` attribute, baked as a constant. The position of the menu, on the x-axis. (default: `"after"`)
-}
positionXBefore : M3e.Html.Attr.Attr { c | positionX : M3e.Token.Supported } msg
positionXBefore =
    M3e.Html.Shared.positionX M3e.Token.before


{-| Set `position-y="above"` — the `above` value of the `positionY` attribute, baked as a constant. The position of the menu, on the y-axis. (default: `"below"`)
-}
positionYAbove : M3e.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionYAbove =
    M3e.Html.Shared.positionY M3e.Token.above


{-| Set `position-y="below"` — the `below` value of the `positionY` attribute, baked as a constant. The position of the menu, on the y-axis. (default: `"below"`)
-}
positionYBelow : M3e.Html.Attr.Attr { c | positionY : M3e.Token.Supported } msg
positionYBelow =
    M3e.Html.Shared.positionY M3e.Token.below


{-| Set `scheme="auto"` — the `auto` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`)
-}
schemeAuto : M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeAuto =
    M3e.Html.Shared.scheme M3e.Token.auto


{-| Set `scheme="dark"` — the `dark` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`)
-}
schemeDark : M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeDark =
    M3e.Html.Shared.scheme M3e.Token.dark


{-| Set `scheme="light"` — the `light` value of the `scheme` attribute, baked as a constant. The color scheme of the theme. (default: `"auto"`)
-}
schemeLight : M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
schemeLight =
    M3e.Html.Shared.scheme M3e.Token.light


{-| Set `scroll-strategy="hide"` — the `hide` value of the `scrollStrategy` attribute, baked as a constant. The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategyHide : M3e.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategyHide =
    M3e.Html.Shared.scrollStrategy M3e.Token.hide


{-| Set `scroll-strategy="reposition"` — the `reposition` value of the `scrollStrategy` attribute, baked as a constant. The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategyReposition : M3e.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategyReposition =
    M3e.Html.Shared.scrollStrategy M3e.Token.reposition


{-| Set `shape="rounded"` — the `rounded` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`)
-}
shapeRounded : M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeRounded =
    M3e.Html.Shared.shape M3e.Token.rounded


{-| Set `shape="square"` — the `square` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`)
-}
shapeSquare : M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeSquare =
    M3e.Html.Shared.shape M3e.Token.square


{-| Set `shape="auto"` — the `auto` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`)
-}
shapeAuto : M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeAuto =
    M3e.Html.Shared.shape M3e.Token.auto


{-| Set `shape="circular"` — the `circular` value of the `shape` attribute, baked as a constant. The shape of the toolbar. (default: `"square"`)
-}
shapeCircular : M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shapeCircular =
    M3e.Html.Shared.shape M3e.Token.circular


{-| Set `size="extraLarge"` — the `extraLarge` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`)
-}
sizeExtraLarge : M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeExtraLarge =
    M3e.Html.Shared.size M3e.Token.extraLarge


{-| Set `size="extraSmall"` — the `extraSmall` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`)
-}
sizeExtraSmall : M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeExtraSmall =
    M3e.Html.Shared.size M3e.Token.extraSmall


{-| Set `size="large"` — the `large` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`)
-}
sizeLarge : M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeLarge =
    M3e.Html.Shared.size M3e.Token.large


{-| Set `size="medium"` — the `medium` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`)
-}
sizeMedium : M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeMedium =
    M3e.Html.Shared.size M3e.Token.medium


{-| Set `size="small"` — the `small` value of the `size` attribute, baked as a constant. The size of the button. (default: `"small"`)
-}
sizeSmall : M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
sizeSmall =
    M3e.Html.Shared.size M3e.Token.small


{-| Set `start-mode="auto"` — the `auto` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`)
-}
startModeAuto : M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeAuto =
    M3e.Html.Shared.startMode M3e.Token.auto


{-| Set `start-mode="over"` — the `over` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`)
-}
startModeOver : M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeOver =
    M3e.Html.Shared.startMode M3e.Token.over


{-| Set `start-mode="push"` — the `push` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`)
-}
startModePush : M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModePush =
    M3e.Html.Shared.startMode M3e.Token.push


{-| Set `start-mode="side"` — the `side` value of the `startMode` attribute, baked as a constant. The behavior mode of the start drawer. (default: `"side"`)
-}
startModeSide : M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startModeSide =
    M3e.Html.Shared.startMode M3e.Token.side


{-| Set `start-view="month"` — the `month` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`)
-}
startViewMonth : M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewMonth =
    M3e.Html.Shared.startView M3e.Token.month


{-| Set `start-view="multiYear"` — the `multiYear` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`)
-}
startViewMultiYear : M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewMultiYear =
    M3e.Html.Shared.startView M3e.Token.multiYear


{-| Set `start-view="year"` — the `year` value of the `startView` attribute, baked as a constant. The initial view used to select a date. (default: `"month"`)
-}
startViewYear : M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startViewYear =
    M3e.Html.Shared.startView M3e.Token.year


{-| Set `state="content"` — the `content` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`)
-}
stateContent : M3e.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateContent =
    M3e.Html.Shared.state M3e.Token.content


{-| Set `state="loading"` — the `loading` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`)
-}
stateLoading : M3e.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateLoading =
    M3e.Html.Shared.state M3e.Token.loading


{-| Set `state="noData"` — the `noData` value of the `state` attribute, baked as a constant. The state for which to present content. (default: `"content"`)
-}
stateNoData : M3e.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
stateNoData =
    M3e.Html.Shared.state M3e.Token.noData


{-| Set `toggle-direction="horizontal"` — the `horizontal` value of the `toggleDirection` attribute, baked as a constant. The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirectionHorizontal : M3e.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirectionHorizontal =
    M3e.Html.Shared.toggleDirection M3e.Token.horizontal


{-| Set `toggle-direction="vertical"` — the `vertical` value of the `toggleDirection` attribute, baked as a constant. The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirectionVertical : M3e.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirectionVertical =
    M3e.Html.Shared.toggleDirection M3e.Token.vertical


{-| Set `toggle-position="after"` — the `after` value of the `togglePosition` attribute, baked as a constant. The position of the expansion toggle. (default: `"after"`)
-}
togglePositionAfter : M3e.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePositionAfter =
    M3e.Html.Shared.togglePosition M3e.Token.after


{-| Set `toggle-position="before"` — the `before` value of the `togglePosition` attribute, baked as a constant. The position of the expansion toggle. (default: `"after"`)
-}
togglePositionBefore : M3e.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePositionBefore =
    M3e.Html.Shared.togglePosition M3e.Token.before


{-| Set `touch-gestures="auto"` — the `auto` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGesturesAuto : M3e.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesAuto =
    M3e.Html.Shared.touchGestures M3e.Token.auto


{-| Set `touch-gestures="off"` — the `off` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGesturesOff : M3e.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesOff =
    M3e.Html.Shared.touchGestures M3e.Token.off


{-| Set `touch-gestures="on"` — the `on` value of the `touchGestures` attribute, baked as a constant. The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGesturesOn : M3e.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGesturesOn =
    M3e.Html.Shared.touchGestures M3e.Token.on


{-| Set `type="button"` — the `button` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`)
-}
typeButton : M3e.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeButton =
    M3e.Html.Shared.type_ M3e.Token.button


{-| Set `type="reset"` — the `reset` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`)
-}
typeReset : M3e.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeReset =
    M3e.Html.Shared.type_ M3e.Token.reset


{-| Set `type="submit"` — the `submit` value of the `type` attribute, baked as a constant. The type of the element. (default: `"button"`)
-}
typeSubmit : M3e.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
typeSubmit =
    M3e.Html.Shared.type_ M3e.Token.submit


{-| Set `variant="standard"` — the `standard` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantStandard : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantStandard =
    M3e.Html.Shared.variant M3e.Token.standard


{-| Set `variant="vibrant"` — the `vibrant` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantVibrant : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantVibrant =
    M3e.Html.Shared.variant M3e.Token.vibrant


{-| Set `variant="content"` — the `content` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantContent : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantContent =
    M3e.Html.Shared.variant M3e.Token.content


{-| Set `variant="expressive"` — the `expressive` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantExpressive : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantExpressive =
    M3e.Html.Shared.variant M3e.Token.expressive


{-| Set `variant="fidelity"` — the `fidelity` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantFidelity : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFidelity =
    M3e.Html.Shared.variant M3e.Token.fidelity


{-| Set `variant="fruitSalad"` — the `fruitSalad` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantFruitSalad : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFruitSalad =
    M3e.Html.Shared.variant M3e.Token.fruitSalad


{-| Set `variant="monochrome"` — the `monochrome` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantMonochrome : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantMonochrome =
    M3e.Html.Shared.variant M3e.Token.monochrome


{-| Set `variant="neutral"` — the `neutral` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantNeutral : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantNeutral =
    M3e.Html.Shared.variant M3e.Token.neutral


{-| Set `variant="rainbow"` — the `rainbow` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantRainbow : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantRainbow =
    M3e.Html.Shared.variant M3e.Token.rainbow


{-| Set `variant="tonalSpot"` — the `tonalSpot` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantTonalSpot : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTonalSpot =
    M3e.Html.Shared.variant M3e.Token.tonalSpot


{-| Set `variant="primary"` — the `primary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantPrimary : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantPrimary =
    M3e.Html.Shared.variant M3e.Token.primary


{-| Set `variant="secondary"` — the `secondary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantSecondary : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSecondary =
    M3e.Html.Shared.variant M3e.Token.secondary


{-| Set `variant="elevated"` — the `elevated` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantElevated : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantElevated =
    M3e.Html.Shared.variant M3e.Token.elevated


{-| Set `variant="filled"` — the `filled` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantFilled : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFilled =
    M3e.Html.Shared.variant M3e.Token.filled


{-| Set `variant="outlined"` — the `outlined` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantOutlined : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantOutlined =
    M3e.Html.Shared.variant M3e.Token.outlined


{-| Set `variant="tonal"` — the `tonal` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantTonal : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTonal =
    M3e.Html.Shared.variant M3e.Token.tonal


{-| Set `variant="flat"` — the `flat` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantFlat : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantFlat =
    M3e.Html.Shared.variant M3e.Token.flat


{-| Set `variant="wavy"` — the `wavy` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantWavy : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantWavy =
    M3e.Html.Shared.variant M3e.Token.wavy


{-| Set `variant="contained"` — the `contained` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantContained : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantContained =
    M3e.Html.Shared.variant M3e.Token.contained


{-| Set `variant="uncontained"` — the `uncontained` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantUncontained : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantUncontained =
    M3e.Html.Shared.variant M3e.Token.uncontained


{-| Set `variant="segmented"` — the `segmented` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantSegmented : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSegmented =
    M3e.Html.Shared.variant M3e.Token.segmented


{-| Set `variant="rounded"` — the `rounded` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantRounded : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantRounded =
    M3e.Html.Shared.variant M3e.Token.rounded


{-| Set `variant="sharp"` — the `sharp` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantSharp : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSharp =
    M3e.Html.Shared.variant M3e.Token.sharp


{-| Set `variant="display"` — the `display` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantDisplay : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantDisplay =
    M3e.Html.Shared.variant M3e.Token.display


{-| Set `variant="headline"` — the `headline` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantHeadline : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantHeadline =
    M3e.Html.Shared.variant M3e.Token.headline


{-| Set `variant="label"` — the `label` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantLabel : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantLabel =
    M3e.Html.Shared.variant M3e.Token.label


{-| Set `variant="title"` — the `title` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantTitle : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTitle =
    M3e.Html.Shared.variant M3e.Token.title


{-| Set `variant="tertiary"` — the `tertiary` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantTertiary : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTertiary =
    M3e.Html.Shared.variant M3e.Token.tertiary


{-| Set `variant="primaryContainer"` — the `primaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantPrimaryContainer : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantPrimaryContainer =
    M3e.Html.Shared.variant M3e.Token.primaryContainer


{-| Set `variant="secondaryContainer"` — the `secondaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantSecondaryContainer : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSecondaryContainer =
    M3e.Html.Shared.variant M3e.Token.secondaryContainer


{-| Set `variant="surface"` — the `surface` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantSurface : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantSurface =
    M3e.Html.Shared.variant M3e.Token.surface


{-| Set `variant="tertiaryContainer"` — the `tertiaryContainer` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantTertiaryContainer : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantTertiaryContainer =
    M3e.Html.Shared.variant M3e.Token.tertiaryContainer


{-| Set `variant="auto"` — the `auto` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantAuto : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantAuto =
    M3e.Html.Shared.variant M3e.Token.auto


{-| Set `variant="docked"` — the `docked` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantDocked : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantDocked =
    M3e.Html.Shared.variant M3e.Token.docked


{-| Set `variant="modal"` — the `modal` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantModal : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantModal =
    M3e.Html.Shared.variant M3e.Token.modal


{-| Set `variant="connected"` — the `connected` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantConnected : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantConnected =
    M3e.Html.Shared.variant M3e.Token.connected


{-| Set `variant="text"` — the `text` value of the `variant` attribute, baked as a constant. The appearance variant of the toolbar. (default: `"standard"`)
-}
variantText : M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variantText =
    M3e.Html.Shared.variant M3e.Token.text


{-| Set `width="default"` — the `default` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`)
-}
widthDefault : M3e.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthDefault =
    M3e.Html.Shared.width M3e.Token.default


{-| Set `width="narrow"` — the `narrow` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`)
-}
widthNarrow : M3e.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthNarrow =
    M3e.Html.Shared.width M3e.Token.narrow


{-| Set `width="wide"` — the `wide` value of the `width` attribute, baked as a constant. The width of the button. (default: `"default"`)
-}
widthWide : M3e.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
widthWide =
    M3e.Html.Shared.width M3e.Token.wide


{-| Set `aria-label` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaLabel : String -> M3e.Html.Attr.Attr capability msg
ariaLabel =
    M3e.Aria.label


{-| Set `aria-labelledby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaLabelledby : String -> M3e.Html.Attr.Attr capability msg
ariaLabelledby =
    M3e.Aria.labelledby


{-| Set `aria-describedby` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaDescribedby : String -> M3e.Html.Attr.Attr capability msg
ariaDescribedby =
    M3e.Aria.describedby


{-| Set `aria-hidden` on any component (universal accessibility setter, re-exposed from `M3e.Aria`).
-}
ariaHidden : String -> M3e.Html.Attr.Attr capability msg
ariaHidden =
    M3e.Aria.hidden


{-| Set the `id` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
id : String -> M3e.Html.Attr.Attr capability msg
id =
    M3e.Attributes.id


{-| Set the `for` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
for : String -> M3e.Html.Attr.Attr capability msg
for =
    M3e.Attributes.for


{-| Set the `class` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
class : String -> M3e.Html.Attr.Attr capability msg
class =
    M3e.Attributes.class


{-| Set the `style` attribute on any component (universal HTML setter, re-exposed from `M3e.Attributes`).
-}
style : List ( String, String ) -> M3e.Html.Attr.Attr capability msg
style =
    M3e.Attributes.style


{-| Listen for `change` events.
-}
onChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Shared.onChange


{-| Listen for `opening` events.
-}
onOpening :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.Shared.onOpening


{-| Listen for `opened` events.
-}
onOpened :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.Shared.onOpened


{-| Listen for `closing` events.
-}
onClosing :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.Shared.onClosing


{-| Listen for `closed` events.
-}
onClosed :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.Shared.onClosed


{-| Listen for `click` events.
-}
onClick :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Shared.onClick


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Shared.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Shared.onInput


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Shared.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Shared.onToggle


{-| Listen for `value-change` events.
-}
onValueChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    M3e.Html.Shared.onValueChange


{-| Listen for `query` events.
-}
onQuery :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    M3e.Html.Shared.onQuery


{-| Listen for `clear` events.
-}
onClear :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.Shared.onClear


{-| Listen for `page` events.
-}
onPage :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage =
    M3e.Html.Shared.onPage


{-| Listen for `cancel` events.
-}
onCancel :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    M3e.Html.Shared.onCancel


{-| Listen for `remove` events.
-}
onRemove :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove =
    M3e.Html.Shared.onRemove


{-| Listen for `invalid` events.
-}
onInvalid :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid =
    M3e.Html.Shared.onInvalid


{-| Listen for `active-change` events.
-}
onActiveChange :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange =
    M3e.Html.Shared.onActiveChange


{-| Listen for `highlight` events.
-}
onHighlight :
    Json.Decode.Decoder msg
    -> M3e.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight =
    M3e.Html.Shared.onHighlight


{-| Place content in the `leading` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLeading`.
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
    M3e.Html.Shared.slotLeading


{-| Place content in the `title` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotTitle`.
-}
slotTitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotTitle =
    M3e.Html.Shared.slotTitle


{-| Place content in the `subtitle` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSubtitle`.
-}
slotSubtitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSubtitle =
    M3e.Html.Shared.slotSubtitle


{-| Place content in the `trailing` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotTrailing`.
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
    M3e.Html.Shared.slotTrailing


{-| Place content in the `leading-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLeadingIcon`.
-}
slotLeadingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLeadingIcon =
    M3e.Html.Shared.slotLeadingIcon


{-| Place content in the `trailing-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotTrailingIcon`.
-}
slotTrailingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotTrailingIcon =
    M3e.Html.Shared.slotTrailingIcon


{-| Place content in the `icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotIcon`.
-}
slotIcon :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , loadingIndicator : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotIcon =
    M3e.Html.Shared.slotIcon


{-| Place content in the `loading` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLoading`.
-}
slotLoading : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLoading =
    M3e.Html.Shared.slotLoading


{-| Place content in the `no-data` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotNoData`.
-}
slotNoData : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotNoData =
    M3e.Html.Shared.slotNoData


{-| Place content in the `header` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotHeader`.
-}
slotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHeader =
    M3e.Html.Shared.slotHeader


{-| Place content in the `separator` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSeparator`.
-}
slotSeparator : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSeparator =
    M3e.Html.Shared.slotSeparator


{-| Place content in the `selected` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSelected`.
-}
slotSelected :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , icon : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSelected =
    M3e.Html.Shared.slotSelected


{-| Place content in the `selected-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSelectedIcon`.
-}
slotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSelectedIcon =
    M3e.Html.Shared.slotSelectedIcon


{-| Place content in the `content` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotContent`.
-}
slotContent : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotContent =
    M3e.Html.Shared.slotContent


{-| Place content in the `actions` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotActions`.
-}
slotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotActions =
    M3e.Html.Shared.slotActions


{-| Place content in the `footer` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotFooter`.
-}
slotFooter : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotFooter =
    M3e.Html.Shared.slotFooter


{-| Place content in the `close-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotCloseIcon`.
-}
slotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotCloseIcon =
    M3e.Html.Shared.slotCloseIcon


{-| Place content in the `start` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotStart`.
-}
slotStart : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotStart =
    M3e.Html.Shared.slotStart


{-| Place content in the `end` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotEnd`.
-}
slotEnd : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotEnd =
    M3e.Html.Shared.slotEnd


{-| Place content in the `overline` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotOverline`.
-}
slotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOverline =
    M3e.Html.Shared.slotOverline


{-| Place content in the `supporting-text` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSupportingText`.
-}
slotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotSupportingText =
    M3e.Html.Shared.slotSupportingText


{-| Place content in the `toggle-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotToggleIcon`.
-}
slotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotToggleIcon =
    M3e.Html.Shared.slotToggleIcon


{-| Place content in the `items` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotItems`.
-}
slotItems : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotItems =
    M3e.Html.Shared.slotItems


{-| Place content in the `label` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLabel`.
-}
slotLabel : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotLabel =
    M3e.Html.Shared.slotLabel


{-| Place content in the `prefix` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotPrefix`.
-}
slotPrefix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefix =
    M3e.Html.Shared.slotPrefix


{-| Place content in the `prefix-text` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotPrefixText`.
-}
slotPrefixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotPrefixText =
    M3e.Html.Shared.slotPrefixText


{-| Place content in the `suffix` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSuffix`.
-}
slotSuffix : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffix =
    M3e.Html.Shared.slotSuffix


{-| Place content in the `suffix-text` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSuffixText`.
-}
slotSuffixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotSuffixText =
    M3e.Html.Shared.slotSuffixText


{-| Place content in the `hint` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotHint`.
-}
slotHint : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotHint =
    M3e.Html.Shared.slotHint


{-| Place content in the `error` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotError`.
-}
slotError : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotError =
    M3e.Html.Shared.slotError


{-| Place content in the `avatar` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotAvatar`.
-}
slotAvatar :
    M3e.Element.Element { avatar : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotAvatar =
    M3e.Html.Shared.slotAvatar


{-| Place content in the `remove-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotRemoveIcon`.
-}
slotRemoveIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotRemoveIcon =
    M3e.Html.Shared.slotRemoveIcon


{-| Place content in the `input` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotInput`.
-}
slotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotInput =
    M3e.Html.Shared.slotInput


{-| Place content in the `badge` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotBadge`.
-}
slotBadge :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , badge : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotBadge =
    M3e.Html.Shared.slotBadge


{-| Place content in the `first-page-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotFirstPageIcon`.
-}
slotFirstPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotFirstPageIcon =
    M3e.Html.Shared.slotFirstPageIcon


{-| Place content in the `previous-page-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotPreviousPageIcon`.
-}
slotPreviousPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotPreviousPageIcon =
    M3e.Html.Shared.slotPreviousPageIcon


{-| Place content in the `next-page-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotNextPageIcon`.
-}
slotNextPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotNextPageIcon =
    M3e.Html.Shared.slotNextPageIcon


{-| Place content in the `last-page-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLastPageIcon`.
-}
slotLastPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotLastPageIcon =
    M3e.Html.Shared.slotLastPageIcon


{-| Place content in the `subhead` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSubhead`.
-}
slotSubhead :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSubhead =
    M3e.Html.Shared.slotSubhead


{-| Place content in the `clear-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotClearIcon`.
-}
slotClearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotClearIcon =
    M3e.Html.Shared.slotClearIcon


{-| Place content in the `open-leading` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotOpenLeading`.
-}
slotOpenLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOpenLeading =
    M3e.Html.Shared.slotOpenLeading


{-| Place content in the `open-trailing` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotOpenTrailing`.
-}
slotOpenTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotOpenTrailing =
    M3e.Html.Shared.slotOpenTrailing


{-| Place content in the `closed-leading` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotClosedLeading`.
-}
slotClosedLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotClosedLeading =
    M3e.Html.Shared.slotClosedLeading


{-| Place content in the `closed-trailing` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotClosedTrailing`.
-}
slotClosedTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotClosedTrailing =
    M3e.Html.Shared.slotClosedTrailing


{-| Place content in the `search-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotSearchIcon`.
-}
slotSearchIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotSearchIcon =
    M3e.Html.Shared.slotSearchIcon


{-| Place content in the `arrow` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotArrow`.
-}
slotArrow :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotArrow =
    M3e.Html.Shared.slotArrow


{-| Place content in the `value` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotValue`.
-}
slotValue : M3e.Element.Element any msg -> M3e.Element.Element k msg
slotValue =
    M3e.Html.Shared.slotValue


{-| Place content in the `next-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotNextIcon`.
-}
slotNextIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotNextIcon =
    M3e.Html.Shared.slotNextIcon


{-| Place content in the `prev-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotPrevIcon`.
-}
slotPrevIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotPrevIcon =
    M3e.Html.Shared.slotPrevIcon


{-| Place content in the `leading-button` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotLeadingButton`.
-}
slotLeadingButton :
    M3e.Element.Element { button : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotLeadingButton =
    M3e.Html.Shared.slotLeadingButton


{-| Place content in the `trailing-button` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotTrailingButton`.
-}
slotTrailingButton :
    M3e.Element.Element { iconButton : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotTrailingButton =
    M3e.Html.Shared.slotTrailingButton


{-| Place content in the `done-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotDoneIcon`.
-}
slotDoneIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotDoneIcon =
    M3e.Html.Shared.slotDoneIcon


{-| Place content in the `edit-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotEditIcon`.
-}
slotEditIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotEditIcon =
    M3e.Html.Shared.slotEditIcon


{-| Place content in the `error-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotErrorIcon`.
-}
slotErrorIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotErrorIcon =
    M3e.Html.Shared.slotErrorIcon


{-| Place content in the `step` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotStep`.
-}
slotStep :
    M3e.Element.Element { step : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotStep =
    M3e.Html.Shared.slotStep


{-| Place content in the `panel` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotPanel`.
-}
slotPanel :
    M3e.Element.Element
        { stepPanel : M3e.Token.Supported
        , tabPanel : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
slotPanel =
    M3e.Html.Shared.slotPanel


{-| Place content in the `open-toggle-icon` slot (component-agnostic; the input row is the UNION of every component's kinds for this slot, so misuse valid in no component is a compile error and cross-component misuse is caught by the `Cem.ValidSlotKind` review rule). The kind-precise, per-component form is `<component>SlotOpenToggleIcon`.
-}
slotOpenToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slotOpenToggleIcon =
    M3e.Html.Shared.slotOpenToggleIcon


{-| Per-component `label` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
treeItemSlotLabel :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , link : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
treeItemSlotLabel =
    M3e.TreeItem.label


{-| Per-component `icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
treeItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
treeItemSlotIcon =
    M3e.TreeItem.icon


{-| Per-component `selected-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`.
-}
treeItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
treeItemSlotSelectedIcon =
    M3e.TreeItem.selectedIcon


{-| Per-component `toggle-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`.
-}
treeItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
treeItemSlotToggleIcon =
    M3e.TreeItem.toggleIcon


{-| Per-component `open-toggle-icon` slot setter for `M3e.TreeItem`, re-exposed flat. The loose, component-agnostic form is `slotOpenToggleIcon`.
-}
treeItemSlotOpenToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
treeItemSlotOpenToggleIcon =
    M3e.TreeItem.openToggleIcon


{-| Per-component `overline` slot setter for `M3e.Toc`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
tocSlotOverline :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tocSlotOverline =
    M3e.Toc.overline


{-| Per-component `title` slot setter for `M3e.Toc`, re-exposed flat. The loose, component-agnostic form is `slotTitle`.
-}
tocSlotTitle :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tocSlotTitle =
    M3e.Toc.title


{-| Per-component `panel` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotPanel`.
-}
tabsSlotPanel :
    M3e.Element.Element { tabPanel : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tabsSlotPanel =
    M3e.Tabs.panel


{-| Per-component `next-icon` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotNextIcon`.
-}
tabsSlotNextIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tabsSlotNextIcon =
    M3e.Tabs.nextIcon


{-| Per-component `prev-icon` slot setter for `M3e.Tabs`, re-exposed flat. The loose, component-agnostic form is `slotPrevIcon`.
-}
tabsSlotPrevIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tabsSlotPrevIcon =
    M3e.Tabs.prevIcon


{-| Per-component `icon` slot setter for `M3e.Tab`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
tabSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
tabSlotIcon =
    M3e.Tab.icon


{-| Per-component `icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
stepSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotIcon =
    M3e.Step.icon


{-| Per-component `done-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotDoneIcon`.
-}
stepSlotDoneIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotDoneIcon =
    M3e.Step.doneIcon


{-| Per-component `edit-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotEditIcon`.
-}
stepSlotEditIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotEditIcon =
    M3e.Step.editIcon


{-| Per-component `error-icon` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotErrorIcon`.
-}
stepSlotErrorIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotErrorIcon =
    M3e.Step.errorIcon


{-| Per-component `hint` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotHint`.
-}
stepSlotHint :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotHint =
    M3e.Step.hint


{-| Per-component `error` slot setter for `M3e.Step`, re-exposed flat. The loose, component-agnostic form is `slotError`.
-}
stepSlotError :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepSlotError =
    M3e.Step.error


{-| Per-component `actions` slot setter for `M3e.StepPanel`, re-exposed flat. The loose, component-agnostic form is `slotActions`.
-}
stepPanelSlotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
stepPanelSlotActions =
    M3e.StepPanel.actions


{-| Per-component `step` slot setter for `M3e.Stepper`, re-exposed flat. The loose, component-agnostic form is `slotStep`.
-}
stepperSlotStep :
    M3e.Element.Element { step : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepperSlotStep =
    M3e.Stepper.step


{-| Per-component `panel` slot setter for `M3e.Stepper`, re-exposed flat. The loose, component-agnostic form is `slotPanel`.
-}
stepperSlotPanel :
    M3e.Element.Element { stepPanel : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
stepperSlotPanel =
    M3e.Stepper.panel


{-| Per-component `start` slot setter for `M3e.SplitPane`, re-exposed flat. The loose, component-agnostic form is `slotStart`.
-}
splitPaneSlotStart : M3e.Element.Element any msg -> M3e.Element.Element k msg
splitPaneSlotStart =
    M3e.SplitPane.start


{-| Per-component `end` slot setter for `M3e.SplitPane`, re-exposed flat. The loose, component-agnostic form is `slotEnd`.
-}
splitPaneSlotEnd : M3e.Element.Element any msg -> M3e.Element.Element k msg
splitPaneSlotEnd =
    M3e.SplitPane.end


{-| Per-component `leading-button` slot setter for `M3e.SplitButton`, re-exposed flat. The loose, component-agnostic form is `slotLeadingButton`.
-}
splitButtonSlotLeadingButton :
    M3e.Element.Element { button : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
splitButtonSlotLeadingButton =
    M3e.SplitButton.leadingButton


{-| Per-component `trailing-button` slot setter for `M3e.SplitButton`, re-exposed flat. The loose, component-agnostic form is `slotTrailingButton`.
-}
splitButtonSlotTrailingButton :
    M3e.Element.Element { iconButton : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
splitButtonSlotTrailingButton =
    M3e.SplitButton.trailingButton


{-| Per-component `close-icon` slot setter for `M3e.Snackbar`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`.
-}
snackbarSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
snackbarSlotCloseIcon =
    M3e.Snackbar.closeIcon


{-| Per-component `next-icon` slot setter for `M3e.SlideGroup`, re-exposed flat. The loose, component-agnostic form is `slotNextIcon`.
-}
slideGroupSlotNextIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slideGroupSlotNextIcon =
    M3e.SlideGroup.nextIcon


{-| Per-component `prev-icon` slot setter for `M3e.SlideGroup`, re-exposed flat. The loose, component-agnostic form is `slotPrevIcon`.
-}
slideGroupSlotPrevIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
slideGroupSlotPrevIcon =
    M3e.SlideGroup.prevIcon


{-| Per-component `icon` slot setter for `M3e.ButtonSegment`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
buttonSegmentSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
buttonSegmentSlotIcon =
    M3e.ButtonSegment.icon


{-| Per-component `input` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotInput`.
-}
searchViewSlotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
searchViewSlotInput =
    M3e.SearchView.input


{-| Per-component `open-leading` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotOpenLeading`.
-}
searchViewSlotOpenLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchViewSlotOpenLeading =
    M3e.SearchView.openLeading


{-| Per-component `open-trailing` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotOpenTrailing`.
-}
searchViewSlotOpenTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchViewSlotOpenTrailing =
    M3e.SearchView.openTrailing


{-| Per-component `closed-leading` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClosedLeading`.
-}
searchViewSlotClosedLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchViewSlotClosedLeading =
    M3e.SearchView.closedLeading


{-| Per-component `closed-trailing` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClosedTrailing`.
-}
searchViewSlotClosedTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchViewSlotClosedTrailing =
    M3e.SearchView.closedTrailing


{-| Per-component `search-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotSearchIcon`.
-}
searchViewSlotSearchIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
searchViewSlotSearchIcon =
    M3e.SearchView.searchIcon


{-| Per-component `close-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`.
-}
searchViewSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
searchViewSlotCloseIcon =
    M3e.SearchView.closeIcon


{-| Per-component `clear-icon` slot setter for `M3e.SearchView`, re-exposed flat. The loose, component-agnostic form is `slotClearIcon`.
-}
searchViewSlotClearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
searchViewSlotClearIcon =
    M3e.SearchView.clearIcon


{-| Per-component `leading` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
searchBarSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchBarSlotLeading =
    M3e.SearchBar.leading


{-| Per-component `input` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotInput`.
-}
searchBarSlotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
searchBarSlotInput =
    M3e.SearchBar.input


{-| Per-component `trailing` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
searchBarSlotTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
searchBarSlotTrailing =
    M3e.SearchBar.trailing


{-| Per-component `clear-icon` slot setter for `M3e.SearchBar`, re-exposed flat. The loose, component-agnostic form is `slotClearIcon`.
-}
searchBarSlotClearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
searchBarSlotClearIcon =
    M3e.SearchBar.clearIcon


{-| Per-component `first-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotFirstPageIcon`.
-}
paginatorSlotFirstPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
paginatorSlotFirstPageIcon =
    M3e.Paginator.firstPageIcon


{-| Per-component `previous-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotPreviousPageIcon`.
-}
paginatorSlotPreviousPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
paginatorSlotPreviousPageIcon =
    M3e.Paginator.previousPageIcon


{-| Per-component `next-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotNextPageIcon`.
-}
paginatorSlotNextPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
paginatorSlotNextPageIcon =
    M3e.Paginator.nextPageIcon


{-| Per-component `last-page-icon` slot setter for `M3e.Paginator`, re-exposed flat. The loose, component-agnostic form is `slotLastPageIcon`.
-}
paginatorSlotLastPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
paginatorSlotLastPageIcon =
    M3e.Paginator.lastPageIcon


{-| Per-component `arrow` slot setter for `M3e.Select`, re-exposed flat. The loose, component-agnostic form is `slotArrow`.
-}
selectSlotArrow :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
selectSlotArrow =
    M3e.Select.arrow


{-| Per-component `value` slot setter for `M3e.Select`, re-exposed flat. The loose, component-agnostic form is `slotValue`.
-}
selectSlotValue : M3e.Element.Element any msg -> M3e.Element.Element k msg
selectSlotValue =
    M3e.Select.value


{-| Per-component `label` slot setter for `M3e.NavMenuItemGroup`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
navMenuItemGroupSlotLabel :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , heading : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
navMenuItemGroupSlotLabel =
    M3e.NavMenuItemGroup.label


{-| Per-component `label` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
navMenuItemSlotLabel :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , link : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
navMenuItemSlotLabel =
    M3e.NavMenuItem.label


{-| Per-component `icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
navMenuItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
navMenuItemSlotIcon =
    M3e.NavMenuItem.icon


{-| Per-component `badge` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotBadge`.
-}
navMenuItemSlotBadge :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , badge : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
navMenuItemSlotBadge =
    M3e.NavMenuItem.badge


{-| Per-component `selected-icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`.
-}
navMenuItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
navMenuItemSlotSelectedIcon =
    M3e.NavMenuItem.selectedIcon


{-| Per-component `toggle-icon` slot setter for `M3e.NavMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`.
-}
navMenuItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
navMenuItemSlotToggleIcon =
    M3e.NavMenuItem.toggleIcon


{-| Per-component `icon` slot setter for `M3e.NavItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
navItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
navItemSlotIcon =
    M3e.NavItem.icon


{-| Per-component `selected-icon` slot setter for `M3e.NavItem`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`.
-}
navItemSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
navItemSlotSelectedIcon =
    M3e.NavItem.selectedIcon


{-| Per-component `icon` slot setter for `M3e.MenuItemRadio`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
menuItemRadioSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemRadioSlotIcon =
    M3e.MenuItemRadio.icon


{-| Per-component `trailing-icon` slot setter for `M3e.MenuItemRadio`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
menuItemRadioSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemRadioSlotTrailingIcon =
    M3e.MenuItemRadio.trailingIcon


{-| Per-component `icon` slot setter for `M3e.MenuItemCheckbox`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
menuItemCheckboxSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemCheckboxSlotIcon =
    M3e.MenuItemCheckbox.icon


{-| Per-component `trailing-icon` slot setter for `M3e.MenuItemCheckbox`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
menuItemCheckboxSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemCheckboxSlotTrailingIcon =
    M3e.MenuItemCheckbox.trailingIcon


{-| Per-component `icon` slot setter for `M3e.MenuItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
menuItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemSlotIcon =
    M3e.MenuItem.icon


{-| Per-component `trailing-icon` slot setter for `M3e.MenuItem`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
menuItemSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
menuItemSlotTrailingIcon =
    M3e.MenuItem.trailingIcon


{-| Per-component `leading` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
listOptionSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listOptionSlotLeading =
    M3e.ListOption.leading


{-| Per-component `overline` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
listOptionSlotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listOptionSlotOverline =
    M3e.ListOption.overline


{-| Per-component `supporting-text` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`.
-}
listOptionSlotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listOptionSlotSupportingText =
    M3e.ListOption.supportingText


{-| Per-component `trailing` slot setter for `M3e.ListOption`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
listOptionSlotTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listOptionSlotTrailing =
    M3e.ListOption.trailing


{-| Per-component `leading` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
expandableListItemSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
expandableListItemSlotLeading =
    M3e.ExpandableListItem.leading


{-| Per-component `overline` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
expandableListItemSlotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
expandableListItemSlotOverline =
    M3e.ExpandableListItem.overline


{-| Per-component `supporting-text` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`.
-}
expandableListItemSlotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
expandableListItemSlotSupportingText =
    M3e.ExpandableListItem.supportingText


{-| Per-component `toggle-icon` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`.
-}
expandableListItemSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
expandableListItemSlotToggleIcon =
    M3e.ExpandableListItem.toggleIcon


{-| Per-component `items` slot setter for `M3e.ExpandableListItem`, re-exposed flat. The loose, component-agnostic form is `slotItems`.
-}
expandableListItemSlotItems : M3e.Element.Element any msg -> M3e.Element.Element k msg
expandableListItemSlotItems =
    M3e.ExpandableListItem.items


{-| Per-component `leading` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
listActionSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listActionSlotLeading =
    M3e.ListAction.leading


{-| Per-component `overline` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
listActionSlotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listActionSlotOverline =
    M3e.ListAction.overline


{-| Per-component `supporting-text` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`.
-}
listActionSlotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listActionSlotSupportingText =
    M3e.ListAction.supportingText


{-| Per-component `trailing` slot setter for `M3e.ListAction`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
listActionSlotTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listActionSlotTrailing =
    M3e.ListAction.trailing


{-| Per-component `leading` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
listItemButtonSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemButtonSlotLeading =
    M3e.ListItemButton.leading


{-| Per-component `overline` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
listItemButtonSlotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemButtonSlotOverline =
    M3e.ListItemButton.overline


{-| Per-component `supporting-text` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`.
-}
listItemButtonSlotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemButtonSlotSupportingText =
    M3e.ListItemButton.supportingText


{-| Per-component `trailing` slot setter for `M3e.ListItemButton`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
listItemButtonSlotTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemButtonSlotTrailing =
    M3e.ListItemButton.trailing


{-| Per-component `leading` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
listItemSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemSlotLeading =
    M3e.ListItem.leading


{-| Per-component `overline` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotOverline`.
-}
listItemSlotOverline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemSlotOverline =
    M3e.ListItem.overline


{-| Per-component `supporting-text` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotSupportingText`.
-}
listItemSlotSupportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemSlotSupportingText =
    M3e.ListItem.supportingText


{-| Per-component `trailing` slot setter for `M3e.ListItem`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
listItemSlotTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
listItemSlotTrailing =
    M3e.ListItem.trailing


{-| Per-component `icon` slot setter for `M3e.FabMenuItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
fabMenuItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
fabMenuItemSlotIcon =
    M3e.FabMenuItem.icon


{-| Per-component `label` slot setter for `M3e.Fab`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
fabSlotLabel :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
fabSlotLabel =
    M3e.Fab.label


{-| Per-component `close-icon` slot setter for `M3e.Fab`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`.
-}
fabSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
fabSlotCloseIcon =
    M3e.Fab.closeIcon


{-| Per-component `actions` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotActions`.
-}
expansionPanelSlotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
expansionPanelSlotActions =
    M3e.ExpansionPanel.actions


{-| Per-component `header` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotHeader`.
-}
expansionPanelSlotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
expansionPanelSlotHeader =
    M3e.ExpansionPanel.header


{-| Per-component `toggle-icon` slot setter for `M3e.ExpansionPanel`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`.
-}
expansionPanelSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
expansionPanelSlotToggleIcon =
    M3e.ExpansionPanel.toggleIcon


{-| Per-component `toggle-icon` slot setter for `M3e.ExpansionHeader`, re-exposed flat. The loose, component-agnostic form is `slotToggleIcon`.
-}
expansionHeaderSlotToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
expansionHeaderSlotToggleIcon =
    M3e.ExpansionHeader.toggleIcon


{-| Per-component `start` slot setter for `M3e.DrawerContainer`, re-exposed flat. The loose, component-agnostic form is `slotStart`.
-}
drawerContainerSlotStart : M3e.Element.Element any msg -> M3e.Element.Element k msg
drawerContainerSlotStart =
    M3e.DrawerContainer.startSlot


{-| Per-component `end` slot setter for `M3e.DrawerContainer`, re-exposed flat. The loose, component-agnostic form is `slotEnd`.
-}
drawerContainerSlotEnd : M3e.Element.Element any msg -> M3e.Element.Element k msg
drawerContainerSlotEnd =
    M3e.DrawerContainer.endSlot


{-| Per-component `header` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotHeader`.
-}
dialogSlotHeader :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
dialogSlotHeader =
    M3e.Dialog.header


{-| Per-component `actions` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotActions`.
-}
dialogSlotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
dialogSlotActions =
    M3e.Dialog.actions


{-| Per-component `close-icon` slot setter for `M3e.Dialog`, re-exposed flat. The loose, component-agnostic form is `slotCloseIcon`.
-}
dialogSlotCloseIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
dialogSlotCloseIcon =
    M3e.Dialog.closeIcon


{-| Per-component `icon` slot setter for `M3e.SuggestionChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
suggestionChipSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
suggestionChipSlotIcon =
    M3e.SuggestionChip.icon


{-| Per-component `input` slot setter for `M3e.InputChipSet`, re-exposed flat. The loose, component-agnostic form is `slotInput`.
-}
inputChipSetSlotInput : M3e.Element.Element any msg -> M3e.Element.Element k msg
inputChipSetSlotInput =
    M3e.InputChipSet.input


{-| Per-component `avatar` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotAvatar`.
-}
inputChipSlotAvatar :
    M3e.Element.Element { avatar : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
inputChipSlotAvatar =
    M3e.InputChip.avatar


{-| Per-component `icon` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
inputChipSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
inputChipSlotIcon =
    M3e.InputChip.icon


{-| Per-component `remove-icon` slot setter for `M3e.InputChip`, re-exposed flat. The loose, component-agnostic form is `slotRemoveIcon`.
-}
inputChipSlotRemoveIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
inputChipSlotRemoveIcon =
    M3e.InputChip.removeIcon


{-| Per-component `icon` slot setter for `M3e.FilterChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
filterChipSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
filterChipSlotIcon =
    M3e.FilterChip.icon


{-| Per-component `trailing-icon` slot setter for `M3e.FilterChip`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
filterChipSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
filterChipSlotTrailingIcon =
    M3e.FilterChip.trailingIcon


{-| Per-component `icon` slot setter for `M3e.AssistChip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
assistChipSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
assistChipSlotIcon =
    M3e.AssistChip.icon


{-| Per-component `icon` slot setter for `M3e.Chip`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
chipSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
chipSlotIcon =
    M3e.Chip.icon


{-| Per-component `trailing-icon` slot setter for `M3e.Chip`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
chipSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
chipSlotTrailingIcon =
    M3e.Chip.trailingIcon


{-| Per-component `header` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotHeader`.
-}
cardSlotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
cardSlotHeader =
    M3e.Card.header


{-| Per-component `content` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotContent`.
-}
cardSlotContent : M3e.Element.Element any msg -> M3e.Element.Element k msg
cardSlotContent =
    M3e.Card.content


{-| Per-component `actions` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotActions`.
-}
cardSlotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
cardSlotActions =
    M3e.Card.actions


{-| Per-component `footer` slot setter for `M3e.Card`, re-exposed flat. The loose, component-agnostic form is `slotFooter`.
-}
cardSlotFooter : M3e.Element.Element any msg -> M3e.Element.Element k msg
cardSlotFooter =
    M3e.Card.footer


{-| Per-component `header` slot setter for `M3e.Calendar`, re-exposed flat. The loose, component-agnostic form is `slotHeader`.
-}
calendarSlotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
calendarSlotHeader =
    M3e.Calendar.header


{-| Per-component `subhead` slot setter for `M3e.RichTooltip`, re-exposed flat. The loose, component-agnostic form is `slotSubhead`.
-}
richTooltipSlotSubhead :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
richTooltipSlotSubhead =
    M3e.RichTooltip.subhead


{-| Per-component `actions` slot setter for `M3e.RichTooltip`, re-exposed flat. The loose, component-agnostic form is `slotActions`.
-}
richTooltipSlotActions : M3e.Element.Element any msg -> M3e.Element.Element k msg
richTooltipSlotActions =
    M3e.RichTooltip.actions


{-| Per-component `selected` slot setter for `M3e.IconButton`, re-exposed flat. The loose, component-agnostic form is `slotSelected`.
-}
iconButtonSlotSelected :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
iconButtonSlotSelected =
    M3e.IconButton.selectedSlot


{-| Per-component `icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
buttonSlotIcon :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , loadingIndicator : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
buttonSlotIcon =
    M3e.Button.icon


{-| Per-component `selected` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotSelected`.
-}
buttonSlotSelected :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , icon : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
buttonSlotSelected =
    M3e.Button.selectedSlot


{-| Per-component `selected-icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotSelectedIcon`.
-}
buttonSlotSelectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
buttonSlotSelectedIcon =
    M3e.Button.selectedIcon


{-| Per-component `trailing-icon` slot setter for `M3e.Button`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
buttonSlotTrailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
buttonSlotTrailingIcon =
    M3e.Button.trailingIcon


{-| Per-component `separator` slot setter for `M3e.Breadcrumb`, re-exposed flat. The loose, component-agnostic form is `slotSeparator`.
-}
breadcrumbSlotSeparator : M3e.Element.Element any msg -> M3e.Element.Element k msg
breadcrumbSlotSeparator =
    M3e.Breadcrumb.separator


{-| Per-component `icon` slot setter for `M3e.BreadcrumbItem`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
breadcrumbItemSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
breadcrumbItemSlotIcon =
    M3e.BreadcrumbItem.icon


{-| Per-component `icon` slot setter for `M3e.BreadcrumbItemButton`, re-exposed flat. The loose, component-agnostic form is `slotIcon`.
-}
breadcrumbItemButtonSlotIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
breadcrumbItemButtonSlotIcon =
    M3e.BreadcrumbItemButton.icon


{-| Per-component `header` slot setter for `M3e.BottomSheet`, re-exposed flat. The loose, component-agnostic form is `slotHeader`.
-}
bottomSheetSlotHeader : M3e.Element.Element any msg -> M3e.Element.Element k msg
bottomSheetSlotHeader =
    M3e.BottomSheet.header


{-| Per-component `loading` slot setter for `M3e.Autocomplete`, re-exposed flat. The loose, component-agnostic form is `slotLoading`.
-}
autocompleteSlotLoading : M3e.Element.Element any msg -> M3e.Element.Element k msg
autocompleteSlotLoading =
    M3e.Autocomplete.loadingSlot


{-| Per-component `no-data` slot setter for `M3e.Autocomplete`, re-exposed flat. The loose, component-agnostic form is `slotNoData`.
-}
autocompleteSlotNoData : M3e.Element.Element any msg -> M3e.Element.Element k msg
autocompleteSlotNoData =
    M3e.Autocomplete.noData


{-| Per-component `(default)` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotDefault`.
-}
formFieldSlotDefault : String -> M3e.Element.Element k msg -> M3e.Element.Element k msg
formFieldSlotDefault =
    M3e.FormField.control


{-| Per-component `prefix` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotPrefix`.
-}
formFieldSlotPrefix : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotPrefix =
    M3e.FormField.prefix


{-| Per-component `prefix-text` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotPrefixText`.
-}
formFieldSlotPrefixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotPrefixText =
    M3e.FormField.prefixText


{-| Per-component `label` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
formFieldSlotLabel : String -> M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotLabel =
    M3e.FormField.label


{-| Per-component `suffix` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotSuffix`.
-}
formFieldSlotSuffix : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotSuffix =
    M3e.FormField.suffix


{-| Per-component `suffix-text` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotSuffixText`.
-}
formFieldSlotSuffixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotSuffixText =
    M3e.FormField.suffixText


{-| Per-component `hint` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotHint`.
-}
formFieldSlotHint : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotHint =
    M3e.FormField.hint


{-| Per-component `error` slot setter for `M3e.FormField`, re-exposed flat. The loose, component-agnostic form is `slotError`.
-}
formFieldSlotError : M3e.Element.Element any msg -> M3e.Element.Element k msg
formFieldSlotError =
    M3e.FormField.error


{-| Per-component `no-data` slot setter for `M3e.OptionPanel`, re-exposed flat. The loose, component-agnostic form is `slotNoData`.
-}
optionPanelSlotNoData : M3e.Element.Element any msg -> M3e.Element.Element k msg
optionPanelSlotNoData =
    M3e.OptionPanel.noData


{-| Per-component `loading` slot setter for `M3e.OptionPanel`, re-exposed flat. The loose, component-agnostic form is `slotLoading`.
-}
optionPanelSlotLoading :
    M3e.Element.Element
        { circularProgressIndicator : M3e.Token.Supported
        , loadingIndicator : M3e.Token.Supported
        , text : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
optionPanelSlotLoading =
    M3e.OptionPanel.loading


{-| Per-component `label` slot setter for `M3e.Optgroup`, re-exposed flat. The loose, component-agnostic form is `slotLabel`.
-}
optgroupSlotLabel :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
optgroupSlotLabel =
    M3e.Optgroup.label


{-| Per-component `leading` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotLeading`.
-}
appBarSlotLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        , button : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
appBarSlotLeading =
    M3e.AppBar.leading


{-| Per-component `title` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTitle`.
-}
appBarSlotTitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
appBarSlotTitle =
    M3e.AppBar.title


{-| Per-component `subtitle` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotSubtitle`.
-}
appBarSlotSubtitle :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
appBarSlotSubtitle =
    M3e.AppBar.subtitle


{-| Per-component `trailing` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailing`.
-}
appBarSlotTrailing :
    M3e.Element.Element
        { iconButton : M3e.Token.Supported
        , button : M3e.Token.Supported
        , searchBar : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
appBarSlotTrailing =
    M3e.AppBar.trailing


{-| Per-component `leading-icon` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotLeadingIcon`.
-}
appBarSlotLeadingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
appBarSlotLeadingIcon =
    M3e.AppBar.leadingIcon


{-| Per-component `trailing-icon` slot setter for `M3e.AppBar`, re-exposed flat. The loose, component-agnostic form is `slotTrailingIcon`.
-}
appBarSlotTrailingIcon : M3e.Element.Element any msg -> M3e.Element.Element k msg
appBarSlotTrailingIcon =
    M3e.AppBar.trailingIcon


{-| Place content in a component's default (unnamed) slot — the identity placement, since default-slot content is passed straight into the element's children (no `slot=` attribute). The component-agnostic form of a per-component default-slot setter.
-}
slotDefault : M3e.Element.Element k msg -> M3e.Element.Element k msg
slotDefault content =
    content


{-| Place content in a component's default (unnamed) slot — the identity placement, since default-slot content is passed straight into the element's children (no `slot=` attribute). The component-agnostic form of a per-component default-slot setter.
-}
child : M3e.Element.Element k msg -> M3e.Element.Element k msg
child content =
    content


{-| Place a list of elements in a component's default (unnamed) slot — the identity placement (default-slot content is passed straight into the element's children). The component-agnostic form of a per-component default-slot setter.
-}
children : List (M3e.Element.Element k msg) -> List (M3e.Element.Element k msg)
children content =
    content


{-| Place content in a control slot, stamping `id="<id>"` from the required `String` so the label and control are associated. The component-agnostic form of a per-component `control` slot setter.
-}
control : String -> M3e.Element.Element k msg -> M3e.Element.Element k msg
control =
    M3e.Element.withAttr "id"


{-| The `linear` variant constructor, re-exposed from `M3e.Progress`.
-}
linear :
    List
        (M3e.Html.Attr.Attr
            { bufferValue : M3e.Token.Supported
            , max : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Token.Supported } msg
linear =
    M3e.Progress.linear


{-| The `circular` variant constructor, re-exposed from `M3e.Progress`.
-}
circular :
    List
        (M3e.Html.Attr.Attr
            { indeterminate : M3e.Token.Supported
            , max : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Token.Supported } msg
circular =
    M3e.Progress.circular
