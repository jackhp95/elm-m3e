module M3e.Build.FormField.Slots exposing
    ( prefixTree, prefixTreeItem, prefixToolbar, prefixToc, prefixTocItem, prefixThemeIcon
    , prefixTheme, prefixTextareaAutosize, prefixTabs, prefixTabPanel, prefixTab, prefixSwitch, prefixStepperReset
    , prefixStepperPrevious, prefixStep, prefixStepPanel, prefixStepper, prefixSplitPane, prefixSplitButton, prefixSnackbar
    , prefixSlider, prefixSliderThumb, prefixSlideGroup, prefixSkeleton, prefixShape, prefixSegmentedButton, prefixButtonSegment
    , prefixSearchView, prefixSearchBar, prefixRadioGroup, prefixRadio, prefixProgressElementIndicatorBase, prefixPaginator, prefixSelect
    , prefixNavRailToggle, prefixNavRail, prefixNavMenuItemGroup, prefixNavMenu, prefixNavMenuItem, prefixNavBar, prefixNavItem
    , prefixMenuItemRadio, prefixMenuItemGroup, prefixMenuItemCheckbox, prefixMenu, prefixMenuItem, prefixMenuTrigger, prefixMenuItemElementBase
    , prefixLoadingIndicator, prefixSelectionList, prefixListOption, prefixActionList, prefixExpandableListItem, prefixListAction, prefixListItemButton
    , prefixList, prefixListItem, prefixIcon, prefixHeading, prefixFabMenuTrigger, prefixFabMenu, prefixFab
    , prefixAccordion, prefixExpansionPanel, prefixExpansionHeader, prefixDrawerToggle, prefixDrawerContainer, prefixDivider, prefixDialogTrigger
    , prefixDialog, prefixDialogAction, prefixDatepickerToggle, prefixDatepicker, prefixContentPane, prefixSuggestionChip, prefixInputChipSet
    , prefixInputChip, prefixFilterChipSet, prefixFilterChip, prefixChipSet, prefixAssistChip, prefixChip, prefixCheckbox
    , prefixCard, prefixCalendar, prefixYearView, prefixMultiYearView, prefixMonthView, prefixTooltip, prefixRichTooltip
    , prefixTooltipElementBase, prefixRichTooltipAction, prefixButtonGroup, prefixIconButton, prefixButton, prefixBreadcrumb, prefixBreadcrumbItem
    , prefixBreadcrumbItemButton, prefixBottomSheetTrigger, prefixBottomSheet, prefixBottomSheetAction, prefixBadge, prefixAvatar, prefixAutocomplete
    , prefixFormField, prefixOptionPanel, prefixFloatingPanel, prefixOptgroup, prefixOption, prefixFocusTrap, prefixAppBar
    , prefixTextOverflow, prefixTextHighlight, prefixStateLayer, prefixSlide, prefixScrollContainer, prefixRipple, prefixPseudoRadio
    , prefixPseudoCheckbox, prefixFocusRing, prefixElevation, prefixCollapsible, prefixActionElementBase, prefixTextTree, prefixTextTreeItem
    , prefixTextToolbar, prefixTextToc, prefixTextTocItem, prefixTextThemeIcon, prefixTextTheme, prefixTextTextareaAutosize, prefixTextTabs
    , prefixTextTabPanel, prefixTextTab, prefixTextSwitch, prefixTextStepperReset, prefixTextStepperPrevious, prefixTextStep, prefixTextStepPanel
    , prefixTextStepper, prefixTextSplitPane, prefixTextSplitButton, prefixTextSnackbar, prefixTextSlider, prefixTextSliderThumb, prefixTextSlideGroup
    , prefixTextSkeleton, prefixTextShape, prefixTextSegmentedButton, prefixTextButtonSegment, prefixTextSearchView, prefixTextSearchBar, prefixTextRadioGroup
    , prefixTextRadio, prefixTextProgressElementIndicatorBase, prefixTextPaginator, prefixTextSelect, prefixTextNavRailToggle, prefixTextNavRail, prefixTextNavMenuItemGroup
    , prefixTextNavMenu, prefixTextNavMenuItem, prefixTextNavBar, prefixTextNavItem, prefixTextMenuItemRadio, prefixTextMenuItemGroup, prefixTextMenuItemCheckbox
    , prefixTextMenu, prefixTextMenuItem, prefixTextMenuTrigger, prefixTextMenuItemElementBase, prefixTextLoadingIndicator, prefixTextSelectionList, prefixTextListOption
    , prefixTextActionList, prefixTextExpandableListItem, prefixTextListAction, prefixTextListItemButton, prefixTextList, prefixTextListItem, prefixTextIcon
    , prefixTextHeading, prefixTextFabMenuTrigger, prefixTextFabMenu, prefixTextFab, prefixTextAccordion, prefixTextExpansionPanel, prefixTextExpansionHeader
    , prefixTextDrawerToggle, prefixTextDrawerContainer, prefixTextDivider, prefixTextDialogTrigger, prefixTextDialog, prefixTextDialogAction, prefixTextDatepickerToggle
    , prefixTextDatepicker, prefixTextContentPane, prefixTextSuggestionChip, prefixTextInputChipSet, prefixTextInputChip, prefixTextFilterChipSet, prefixTextFilterChip
    , prefixTextChipSet, prefixTextAssistChip, prefixTextChip, prefixTextCheckbox, prefixTextCard, prefixTextCalendar, prefixTextYearView
    , prefixTextMultiYearView, prefixTextMonthView, prefixTextTooltip, prefixTextRichTooltip, prefixTextTooltipElementBase, prefixTextRichTooltipAction, prefixTextButtonGroup
    , prefixTextIconButton, prefixTextButton, prefixTextBreadcrumb, prefixTextBreadcrumbItem, prefixTextBreadcrumbItemButton, prefixTextBottomSheetTrigger, prefixTextBottomSheet
    , prefixTextBottomSheetAction, prefixTextBadge, prefixTextAvatar, prefixTextAutocomplete, prefixTextFormField, prefixTextOptionPanel, prefixTextFloatingPanel
    , prefixTextOptgroup, prefixTextOption, prefixTextFocusTrap, prefixTextAppBar, prefixTextTextOverflow, prefixTextTextHighlight, prefixTextStateLayer
    , prefixTextSlide, prefixTextScrollContainer, prefixTextRipple, prefixTextPseudoRadio, prefixTextPseudoCheckbox, prefixTextFocusRing, prefixTextElevation
    , prefixTextCollapsible, prefixTextActionElementBase, labelTree, labelTreeItem, labelToolbar, labelToc, labelTocItem
    , labelThemeIcon, labelTheme, labelTextareaAutosize, labelTabs, labelTabPanel, labelTab, labelSwitch
    , labelStepperReset, labelStepperPrevious, labelStep, labelStepPanel, labelStepper, labelSplitPane, labelSplitButton
    , labelSnackbar, labelSlider, labelSliderThumb, labelSlideGroup, labelSkeleton, labelShape, labelSegmentedButton
    , labelButtonSegment, labelSearchView, labelSearchBar, labelRadioGroup, labelRadio, labelProgressElementIndicatorBase, labelPaginator
    , labelSelect, labelNavRailToggle, labelNavRail, labelNavMenuItemGroup, labelNavMenu, labelNavMenuItem, labelNavBar
    , labelNavItem, labelMenuItemRadio, labelMenuItemGroup, labelMenuItemCheckbox, labelMenu, labelMenuItem, labelMenuTrigger
    , labelMenuItemElementBase, labelLoadingIndicator, labelSelectionList, labelListOption, labelActionList, labelExpandableListItem, labelListAction
    , labelListItemButton, labelList, labelListItem, labelIcon, labelHeading, labelFabMenuTrigger, labelFabMenu
    , labelFab, labelAccordion, labelExpansionPanel, labelExpansionHeader, labelDrawerToggle, labelDrawerContainer, labelDivider
    , labelDialogTrigger, labelDialog, labelDialogAction, labelDatepickerToggle, labelDatepicker, labelContentPane, labelSuggestionChip
    , labelInputChipSet, labelInputChip, labelFilterChipSet, labelFilterChip, labelChipSet, labelAssistChip, labelChip
    , labelCheckbox, labelCard, labelCalendar, labelYearView, labelMultiYearView, labelMonthView, labelTooltip
    , labelRichTooltip, labelTooltipElementBase, labelRichTooltipAction, labelButtonGroup, labelIconButton, labelButton, labelBreadcrumb
    , labelBreadcrumbItem, labelBreadcrumbItemButton, labelBottomSheetTrigger, labelBottomSheet, labelBottomSheetAction, labelBadge, labelAvatar
    , labelAutocomplete, labelFormField, labelOptionPanel, labelFloatingPanel, labelOptgroup, labelOption, labelFocusTrap
    , labelAppBar, labelTextOverflow, labelTextHighlight, labelStateLayer, labelSlide, labelScrollContainer, labelRipple
    , labelPseudoRadio, labelPseudoCheckbox, labelFocusRing, labelElevation, labelCollapsible, labelActionElementBase, suffixTree
    , suffixTreeItem, suffixToolbar, suffixToc, suffixTocItem, suffixThemeIcon, suffixTheme, suffixTextareaAutosize
    , suffixTabs, suffixTabPanel, suffixTab, suffixSwitch, suffixStepperReset, suffixStepperPrevious, suffixStep
    , suffixStepPanel, suffixStepper, suffixSplitPane, suffixSplitButton, suffixSnackbar, suffixSlider, suffixSliderThumb
    , suffixSlideGroup, suffixSkeleton, suffixShape, suffixSegmentedButton, suffixButtonSegment, suffixSearchView, suffixSearchBar
    , suffixRadioGroup, suffixRadio, suffixProgressElementIndicatorBase, suffixPaginator, suffixSelect, suffixNavRailToggle, suffixNavRail
    , suffixNavMenuItemGroup, suffixNavMenu, suffixNavMenuItem, suffixNavBar, suffixNavItem, suffixMenuItemRadio, suffixMenuItemGroup
    , suffixMenuItemCheckbox, suffixMenu, suffixMenuItem, suffixMenuTrigger, suffixMenuItemElementBase, suffixLoadingIndicator, suffixSelectionList
    , suffixListOption, suffixActionList, suffixExpandableListItem, suffixListAction, suffixListItemButton, suffixList, suffixListItem
    , suffixIcon, suffixHeading, suffixFabMenuTrigger, suffixFabMenu, suffixFab, suffixAccordion, suffixExpansionPanel
    , suffixExpansionHeader, suffixDrawerToggle, suffixDrawerContainer, suffixDivider, suffixDialogTrigger, suffixDialog, suffixDialogAction
    , suffixDatepickerToggle, suffixDatepicker, suffixContentPane, suffixSuggestionChip, suffixInputChipSet, suffixInputChip, suffixFilterChipSet
    , suffixFilterChip, suffixChipSet, suffixAssistChip, suffixChip, suffixCheckbox, suffixCard, suffixCalendar
    , suffixYearView, suffixMultiYearView, suffixMonthView, suffixTooltip, suffixRichTooltip, suffixTooltipElementBase, suffixRichTooltipAction
    , suffixButtonGroup, suffixIconButton, suffixButton, suffixBreadcrumb, suffixBreadcrumbItem, suffixBreadcrumbItemButton, suffixBottomSheetTrigger
    , suffixBottomSheet, suffixBottomSheetAction, suffixBadge, suffixAvatar, suffixAutocomplete, suffixFormField, suffixOptionPanel
    , suffixFloatingPanel, suffixOptgroup, suffixOption, suffixFocusTrap, suffixAppBar, suffixTextOverflow, suffixTextHighlight
    , suffixStateLayer, suffixSlide, suffixScrollContainer, suffixRipple, suffixPseudoRadio, suffixPseudoCheckbox, suffixFocusRing
    , suffixElevation, suffixCollapsible, suffixActionElementBase, suffixTextTree, suffixTextTreeItem, suffixTextToolbar, suffixTextToc
    , suffixTextTocItem, suffixTextThemeIcon, suffixTextTheme, suffixTextTextareaAutosize, suffixTextTabs, suffixTextTabPanel, suffixTextTab
    , suffixTextSwitch, suffixTextStepperReset, suffixTextStepperPrevious, suffixTextStep, suffixTextStepPanel, suffixTextStepper, suffixTextSplitPane
    , suffixTextSplitButton, suffixTextSnackbar, suffixTextSlider, suffixTextSliderThumb, suffixTextSlideGroup, suffixTextSkeleton, suffixTextShape
    , suffixTextSegmentedButton, suffixTextButtonSegment, suffixTextSearchView, suffixTextSearchBar, suffixTextRadioGroup, suffixTextRadio, suffixTextProgressElementIndicatorBase
    , suffixTextPaginator, suffixTextSelect, suffixTextNavRailToggle, suffixTextNavRail, suffixTextNavMenuItemGroup, suffixTextNavMenu, suffixTextNavMenuItem
    , suffixTextNavBar, suffixTextNavItem, suffixTextMenuItemRadio, suffixTextMenuItemGroup, suffixTextMenuItemCheckbox, suffixTextMenu, suffixTextMenuItem
    , suffixTextMenuTrigger, suffixTextMenuItemElementBase, suffixTextLoadingIndicator, suffixTextSelectionList, suffixTextListOption, suffixTextActionList, suffixTextExpandableListItem
    , suffixTextListAction, suffixTextListItemButton, suffixTextList, suffixTextListItem, suffixTextIcon, suffixTextHeading, suffixTextFabMenuTrigger
    , suffixTextFabMenu, suffixTextFab, suffixTextAccordion, suffixTextExpansionPanel, suffixTextExpansionHeader, suffixTextDrawerToggle, suffixTextDrawerContainer
    , suffixTextDivider, suffixTextDialogTrigger, suffixTextDialog, suffixTextDialogAction, suffixTextDatepickerToggle, suffixTextDatepicker, suffixTextContentPane
    , suffixTextSuggestionChip, suffixTextInputChipSet, suffixTextInputChip, suffixTextFilterChipSet, suffixTextFilterChip, suffixTextChipSet, suffixTextAssistChip
    , suffixTextChip, suffixTextCheckbox, suffixTextCard, suffixTextCalendar, suffixTextYearView, suffixTextMultiYearView, suffixTextMonthView
    , suffixTextTooltip, suffixTextRichTooltip, suffixTextTooltipElementBase, suffixTextRichTooltipAction, suffixTextButtonGroup, suffixTextIconButton, suffixTextButton
    , suffixTextBreadcrumb, suffixTextBreadcrumbItem, suffixTextBreadcrumbItemButton, suffixTextBottomSheetTrigger, suffixTextBottomSheet, suffixTextBottomSheetAction, suffixTextBadge
    , suffixTextAvatar, suffixTextAutocomplete, suffixTextFormField, suffixTextOptionPanel, suffixTextFloatingPanel, suffixTextOptgroup, suffixTextOption
    , suffixTextFocusTrap, suffixTextAppBar, suffixTextTextOverflow, suffixTextTextHighlight, suffixTextStateLayer, suffixTextSlide, suffixTextScrollContainer
    , suffixTextRipple, suffixTextPseudoRadio, suffixTextPseudoCheckbox, suffixTextFocusRing, suffixTextElevation, suffixTextCollapsible, suffixTextActionElementBase
    , hintTree, hintTreeItem, hintToolbar, hintToc, hintTocItem, hintThemeIcon, hintTheme
    , hintTextareaAutosize, hintTabs, hintTabPanel, hintTab, hintSwitch, hintStepperReset, hintStepperPrevious
    , hintStep, hintStepPanel, hintStepper, hintSplitPane, hintSplitButton, hintSnackbar, hintSlider
    , hintSliderThumb, hintSlideGroup, hintSkeleton, hintShape, hintSegmentedButton, hintButtonSegment, hintSearchView
    , hintSearchBar, hintRadioGroup, hintRadio, hintProgressElementIndicatorBase, hintPaginator, hintSelect, hintNavRailToggle
    , hintNavRail, hintNavMenuItemGroup, hintNavMenu, hintNavMenuItem, hintNavBar, hintNavItem, hintMenuItemRadio
    , hintMenuItemGroup, hintMenuItemCheckbox, hintMenu, hintMenuItem, hintMenuTrigger, hintMenuItemElementBase, hintLoadingIndicator
    , hintSelectionList, hintListOption, hintActionList, hintExpandableListItem, hintListAction, hintListItemButton, hintList
    , hintListItem, hintIcon, hintHeading, hintFabMenuTrigger, hintFabMenu, hintFab, hintAccordion
    , hintExpansionPanel, hintExpansionHeader, hintDrawerToggle, hintDrawerContainer, hintDivider, hintDialogTrigger, hintDialog
    , hintDialogAction, hintDatepickerToggle, hintDatepicker, hintContentPane, hintSuggestionChip, hintInputChipSet, hintInputChip
    , hintFilterChipSet, hintFilterChip, hintChipSet, hintAssistChip, hintChip, hintCheckbox, hintCard
    , hintCalendar, hintYearView, hintMultiYearView, hintMonthView, hintTooltip, hintRichTooltip, hintTooltipElementBase
    , hintRichTooltipAction, hintButtonGroup, hintIconButton, hintButton, hintBreadcrumb, hintBreadcrumbItem, hintBreadcrumbItemButton
    , hintBottomSheetTrigger, hintBottomSheet, hintBottomSheetAction, hintBadge, hintAvatar, hintAutocomplete, hintFormField
    , hintOptionPanel, hintFloatingPanel, hintOptgroup, hintOption, hintFocusTrap, hintAppBar, hintTextOverflow
    , hintTextHighlight, hintStateLayer, hintSlide, hintScrollContainer, hintRipple, hintPseudoRadio, hintPseudoCheckbox
    , hintFocusRing, hintElevation, hintCollapsible, hintActionElementBase, errorTree, errorTreeItem, errorToolbar
    , errorToc, errorTocItem, errorThemeIcon, errorTheme, errorTextareaAutosize, errorTabs, errorTabPanel
    , errorTab, errorSwitch, errorStepperReset, errorStepperPrevious, errorStep, errorStepPanel, errorStepper
    , errorSplitPane, errorSplitButton, errorSnackbar, errorSlider, errorSliderThumb, errorSlideGroup, errorSkeleton
    , errorShape, errorSegmentedButton, errorButtonSegment, errorSearchView, errorSearchBar, errorRadioGroup, errorRadio
    , errorProgressElementIndicatorBase, errorPaginator, errorSelect, errorNavRailToggle, errorNavRail, errorNavMenuItemGroup, errorNavMenu
    , errorNavMenuItem, errorNavBar, errorNavItem, errorMenuItemRadio, errorMenuItemGroup, errorMenuItemCheckbox, errorMenu
    , errorMenuItem, errorMenuTrigger, errorMenuItemElementBase, errorLoadingIndicator, errorSelectionList, errorListOption, errorActionList
    , errorExpandableListItem, errorListAction, errorListItemButton, errorList, errorListItem, errorIcon, errorHeading
    , errorFabMenuTrigger, errorFabMenu, errorFab, errorAccordion, errorExpansionPanel, errorExpansionHeader, errorDrawerToggle
    , errorDrawerContainer, errorDivider, errorDialogTrigger, errorDialog, errorDialogAction, errorDatepickerToggle, errorDatepicker
    , errorContentPane, errorSuggestionChip, errorInputChipSet, errorInputChip, errorFilterChipSet, errorFilterChip, errorChipSet
    , errorAssistChip, errorChip, errorCheckbox, errorCard, errorCalendar, errorYearView, errorMultiYearView
    , errorMonthView, errorTooltip, errorRichTooltip, errorTooltipElementBase, errorRichTooltipAction, errorButtonGroup, errorIconButton
    , errorButton, errorBreadcrumb, errorBreadcrumbItem, errorBreadcrumbItemButton, errorBottomSheetTrigger, errorBottomSheet, errorBottomSheetAction
    , errorBadge, errorAvatar, errorAutocomplete, errorFormField, errorOptionPanel, errorFloatingPanel, errorOptgroup
    , errorOption, errorFocusTrap, errorAppBar, errorTextOverflow, errorTextHighlight, errorStateLayer, errorSlide
    , errorScrollContainer, errorRipple, errorPseudoRadio, errorPseudoCheckbox, errorFocusRing, errorElevation, errorCollapsible
    , errorActionElementBase, tree, treeItem, toolbar, toc, tocItem, themeIcon
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase
    )

{-|
Slot setters for `M3e.Build.FormField`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs prefixTree, prefixTreeItem, prefixToolbar, prefixToc, prefixTocItem, prefixThemeIcon
@docs prefixTheme, prefixTextareaAutosize, prefixTabs, prefixTabPanel, prefixTab, prefixSwitch
@docs prefixStepperReset, prefixStepperPrevious, prefixStep, prefixStepPanel, prefixStepper, prefixSplitPane
@docs prefixSplitButton, prefixSnackbar, prefixSlider, prefixSliderThumb, prefixSlideGroup, prefixSkeleton
@docs prefixShape, prefixSegmentedButton, prefixButtonSegment, prefixSearchView, prefixSearchBar, prefixRadioGroup
@docs prefixRadio, prefixProgressElementIndicatorBase, prefixPaginator, prefixSelect, prefixNavRailToggle, prefixNavRail
@docs prefixNavMenuItemGroup, prefixNavMenu, prefixNavMenuItem, prefixNavBar, prefixNavItem, prefixMenuItemRadio
@docs prefixMenuItemGroup, prefixMenuItemCheckbox, prefixMenu, prefixMenuItem, prefixMenuTrigger, prefixMenuItemElementBase
@docs prefixLoadingIndicator, prefixSelectionList, prefixListOption, prefixActionList, prefixExpandableListItem, prefixListAction
@docs prefixListItemButton, prefixList, prefixListItem, prefixIcon, prefixHeading, prefixFabMenuTrigger
@docs prefixFabMenu, prefixFab, prefixAccordion, prefixExpansionPanel, prefixExpansionHeader, prefixDrawerToggle
@docs prefixDrawerContainer, prefixDivider, prefixDialogTrigger, prefixDialog, prefixDialogAction, prefixDatepickerToggle
@docs prefixDatepicker, prefixContentPane, prefixSuggestionChip, prefixInputChipSet, prefixInputChip, prefixFilterChipSet
@docs prefixFilterChip, prefixChipSet, prefixAssistChip, prefixChip, prefixCheckbox, prefixCard
@docs prefixCalendar, prefixYearView, prefixMultiYearView, prefixMonthView, prefixTooltip, prefixRichTooltip
@docs prefixTooltipElementBase, prefixRichTooltipAction, prefixButtonGroup, prefixIconButton, prefixButton, prefixBreadcrumb
@docs prefixBreadcrumbItem, prefixBreadcrumbItemButton, prefixBottomSheetTrigger, prefixBottomSheet, prefixBottomSheetAction, prefixBadge
@docs prefixAvatar, prefixAutocomplete, prefixFormField, prefixOptionPanel, prefixFloatingPanel, prefixOptgroup
@docs prefixOption, prefixFocusTrap, prefixAppBar, prefixTextOverflow, prefixTextHighlight, prefixStateLayer
@docs prefixSlide, prefixScrollContainer, prefixRipple, prefixPseudoRadio, prefixPseudoCheckbox, prefixFocusRing
@docs prefixElevation, prefixCollapsible, prefixActionElementBase, prefixTextTree, prefixTextTreeItem, prefixTextToolbar
@docs prefixTextToc, prefixTextTocItem, prefixTextThemeIcon, prefixTextTheme, prefixTextTextareaAutosize, prefixTextTabs
@docs prefixTextTabPanel, prefixTextTab, prefixTextSwitch, prefixTextStepperReset, prefixTextStepperPrevious, prefixTextStep
@docs prefixTextStepPanel, prefixTextStepper, prefixTextSplitPane, prefixTextSplitButton, prefixTextSnackbar, prefixTextSlider
@docs prefixTextSliderThumb, prefixTextSlideGroup, prefixTextSkeleton, prefixTextShape, prefixTextSegmentedButton, prefixTextButtonSegment
@docs prefixTextSearchView, prefixTextSearchBar, prefixTextRadioGroup, prefixTextRadio, prefixTextProgressElementIndicatorBase, prefixTextPaginator
@docs prefixTextSelect, prefixTextNavRailToggle, prefixTextNavRail, prefixTextNavMenuItemGroup, prefixTextNavMenu, prefixTextNavMenuItem
@docs prefixTextNavBar, prefixTextNavItem, prefixTextMenuItemRadio, prefixTextMenuItemGroup, prefixTextMenuItemCheckbox, prefixTextMenu
@docs prefixTextMenuItem, prefixTextMenuTrigger, prefixTextMenuItemElementBase, prefixTextLoadingIndicator, prefixTextSelectionList, prefixTextListOption
@docs prefixTextActionList, prefixTextExpandableListItem, prefixTextListAction, prefixTextListItemButton, prefixTextList, prefixTextListItem
@docs prefixTextIcon, prefixTextHeading, prefixTextFabMenuTrigger, prefixTextFabMenu, prefixTextFab, prefixTextAccordion
@docs prefixTextExpansionPanel, prefixTextExpansionHeader, prefixTextDrawerToggle, prefixTextDrawerContainer, prefixTextDivider, prefixTextDialogTrigger
@docs prefixTextDialog, prefixTextDialogAction, prefixTextDatepickerToggle, prefixTextDatepicker, prefixTextContentPane, prefixTextSuggestionChip
@docs prefixTextInputChipSet, prefixTextInputChip, prefixTextFilterChipSet, prefixTextFilterChip, prefixTextChipSet, prefixTextAssistChip
@docs prefixTextChip, prefixTextCheckbox, prefixTextCard, prefixTextCalendar, prefixTextYearView, prefixTextMultiYearView
@docs prefixTextMonthView, prefixTextTooltip, prefixTextRichTooltip, prefixTextTooltipElementBase, prefixTextRichTooltipAction, prefixTextButtonGroup
@docs prefixTextIconButton, prefixTextButton, prefixTextBreadcrumb, prefixTextBreadcrumbItem, prefixTextBreadcrumbItemButton, prefixTextBottomSheetTrigger
@docs prefixTextBottomSheet, prefixTextBottomSheetAction, prefixTextBadge, prefixTextAvatar, prefixTextAutocomplete, prefixTextFormField
@docs prefixTextOptionPanel, prefixTextFloatingPanel, prefixTextOptgroup, prefixTextOption, prefixTextFocusTrap, prefixTextAppBar
@docs prefixTextTextOverflow, prefixTextTextHighlight, prefixTextStateLayer, prefixTextSlide, prefixTextScrollContainer, prefixTextRipple
@docs prefixTextPseudoRadio, prefixTextPseudoCheckbox, prefixTextFocusRing, prefixTextElevation, prefixTextCollapsible, prefixTextActionElementBase
@docs labelTree, labelTreeItem, labelToolbar, labelToc, labelTocItem, labelThemeIcon
@docs labelTheme, labelTextareaAutosize, labelTabs, labelTabPanel, labelTab, labelSwitch
@docs labelStepperReset, labelStepperPrevious, labelStep, labelStepPanel, labelStepper, labelSplitPane
@docs labelSplitButton, labelSnackbar, labelSlider, labelSliderThumb, labelSlideGroup, labelSkeleton
@docs labelShape, labelSegmentedButton, labelButtonSegment, labelSearchView, labelSearchBar, labelRadioGroup
@docs labelRadio, labelProgressElementIndicatorBase, labelPaginator, labelSelect, labelNavRailToggle, labelNavRail
@docs labelNavMenuItemGroup, labelNavMenu, labelNavMenuItem, labelNavBar, labelNavItem, labelMenuItemRadio
@docs labelMenuItemGroup, labelMenuItemCheckbox, labelMenu, labelMenuItem, labelMenuTrigger, labelMenuItemElementBase
@docs labelLoadingIndicator, labelSelectionList, labelListOption, labelActionList, labelExpandableListItem, labelListAction
@docs labelListItemButton, labelList, labelListItem, labelIcon, labelHeading, labelFabMenuTrigger
@docs labelFabMenu, labelFab, labelAccordion, labelExpansionPanel, labelExpansionHeader, labelDrawerToggle
@docs labelDrawerContainer, labelDivider, labelDialogTrigger, labelDialog, labelDialogAction, labelDatepickerToggle
@docs labelDatepicker, labelContentPane, labelSuggestionChip, labelInputChipSet, labelInputChip, labelFilterChipSet
@docs labelFilterChip, labelChipSet, labelAssistChip, labelChip, labelCheckbox, labelCard
@docs labelCalendar, labelYearView, labelMultiYearView, labelMonthView, labelTooltip, labelRichTooltip
@docs labelTooltipElementBase, labelRichTooltipAction, labelButtonGroup, labelIconButton, labelButton, labelBreadcrumb
@docs labelBreadcrumbItem, labelBreadcrumbItemButton, labelBottomSheetTrigger, labelBottomSheet, labelBottomSheetAction, labelBadge
@docs labelAvatar, labelAutocomplete, labelFormField, labelOptionPanel, labelFloatingPanel, labelOptgroup
@docs labelOption, labelFocusTrap, labelAppBar, labelTextOverflow, labelTextHighlight, labelStateLayer
@docs labelSlide, labelScrollContainer, labelRipple, labelPseudoRadio, labelPseudoCheckbox, labelFocusRing
@docs labelElevation, labelCollapsible, labelActionElementBase, suffixTree, suffixTreeItem, suffixToolbar
@docs suffixToc, suffixTocItem, suffixThemeIcon, suffixTheme, suffixTextareaAutosize, suffixTabs
@docs suffixTabPanel, suffixTab, suffixSwitch, suffixStepperReset, suffixStepperPrevious, suffixStep
@docs suffixStepPanel, suffixStepper, suffixSplitPane, suffixSplitButton, suffixSnackbar, suffixSlider
@docs suffixSliderThumb, suffixSlideGroup, suffixSkeleton, suffixShape, suffixSegmentedButton, suffixButtonSegment
@docs suffixSearchView, suffixSearchBar, suffixRadioGroup, suffixRadio, suffixProgressElementIndicatorBase, suffixPaginator
@docs suffixSelect, suffixNavRailToggle, suffixNavRail, suffixNavMenuItemGroup, suffixNavMenu, suffixNavMenuItem
@docs suffixNavBar, suffixNavItem, suffixMenuItemRadio, suffixMenuItemGroup, suffixMenuItemCheckbox, suffixMenu
@docs suffixMenuItem, suffixMenuTrigger, suffixMenuItemElementBase, suffixLoadingIndicator, suffixSelectionList, suffixListOption
@docs suffixActionList, suffixExpandableListItem, suffixListAction, suffixListItemButton, suffixList, suffixListItem
@docs suffixIcon, suffixHeading, suffixFabMenuTrigger, suffixFabMenu, suffixFab, suffixAccordion
@docs suffixExpansionPanel, suffixExpansionHeader, suffixDrawerToggle, suffixDrawerContainer, suffixDivider, suffixDialogTrigger
@docs suffixDialog, suffixDialogAction, suffixDatepickerToggle, suffixDatepicker, suffixContentPane, suffixSuggestionChip
@docs suffixInputChipSet, suffixInputChip, suffixFilterChipSet, suffixFilterChip, suffixChipSet, suffixAssistChip
@docs suffixChip, suffixCheckbox, suffixCard, suffixCalendar, suffixYearView, suffixMultiYearView
@docs suffixMonthView, suffixTooltip, suffixRichTooltip, suffixTooltipElementBase, suffixRichTooltipAction, suffixButtonGroup
@docs suffixIconButton, suffixButton, suffixBreadcrumb, suffixBreadcrumbItem, suffixBreadcrumbItemButton, suffixBottomSheetTrigger
@docs suffixBottomSheet, suffixBottomSheetAction, suffixBadge, suffixAvatar, suffixAutocomplete, suffixFormField
@docs suffixOptionPanel, suffixFloatingPanel, suffixOptgroup, suffixOption, suffixFocusTrap, suffixAppBar
@docs suffixTextOverflow, suffixTextHighlight, suffixStateLayer, suffixSlide, suffixScrollContainer, suffixRipple
@docs suffixPseudoRadio, suffixPseudoCheckbox, suffixFocusRing, suffixElevation, suffixCollapsible, suffixActionElementBase
@docs suffixTextTree, suffixTextTreeItem, suffixTextToolbar, suffixTextToc, suffixTextTocItem, suffixTextThemeIcon
@docs suffixTextTheme, suffixTextTextareaAutosize, suffixTextTabs, suffixTextTabPanel, suffixTextTab, suffixTextSwitch
@docs suffixTextStepperReset, suffixTextStepperPrevious, suffixTextStep, suffixTextStepPanel, suffixTextStepper, suffixTextSplitPane
@docs suffixTextSplitButton, suffixTextSnackbar, suffixTextSlider, suffixTextSliderThumb, suffixTextSlideGroup, suffixTextSkeleton
@docs suffixTextShape, suffixTextSegmentedButton, suffixTextButtonSegment, suffixTextSearchView, suffixTextSearchBar, suffixTextRadioGroup
@docs suffixTextRadio, suffixTextProgressElementIndicatorBase, suffixTextPaginator, suffixTextSelect, suffixTextNavRailToggle, suffixTextNavRail
@docs suffixTextNavMenuItemGroup, suffixTextNavMenu, suffixTextNavMenuItem, suffixTextNavBar, suffixTextNavItem, suffixTextMenuItemRadio
@docs suffixTextMenuItemGroup, suffixTextMenuItemCheckbox, suffixTextMenu, suffixTextMenuItem, suffixTextMenuTrigger, suffixTextMenuItemElementBase
@docs suffixTextLoadingIndicator, suffixTextSelectionList, suffixTextListOption, suffixTextActionList, suffixTextExpandableListItem, suffixTextListAction
@docs suffixTextListItemButton, suffixTextList, suffixTextListItem, suffixTextIcon, suffixTextHeading, suffixTextFabMenuTrigger
@docs suffixTextFabMenu, suffixTextFab, suffixTextAccordion, suffixTextExpansionPanel, suffixTextExpansionHeader, suffixTextDrawerToggle
@docs suffixTextDrawerContainer, suffixTextDivider, suffixTextDialogTrigger, suffixTextDialog, suffixTextDialogAction, suffixTextDatepickerToggle
@docs suffixTextDatepicker, suffixTextContentPane, suffixTextSuggestionChip, suffixTextInputChipSet, suffixTextInputChip, suffixTextFilterChipSet
@docs suffixTextFilterChip, suffixTextChipSet, suffixTextAssistChip, suffixTextChip, suffixTextCheckbox, suffixTextCard
@docs suffixTextCalendar, suffixTextYearView, suffixTextMultiYearView, suffixTextMonthView, suffixTextTooltip, suffixTextRichTooltip
@docs suffixTextTooltipElementBase, suffixTextRichTooltipAction, suffixTextButtonGroup, suffixTextIconButton, suffixTextButton, suffixTextBreadcrumb
@docs suffixTextBreadcrumbItem, suffixTextBreadcrumbItemButton, suffixTextBottomSheetTrigger, suffixTextBottomSheet, suffixTextBottomSheetAction, suffixTextBadge
@docs suffixTextAvatar, suffixTextAutocomplete, suffixTextFormField, suffixTextOptionPanel, suffixTextFloatingPanel, suffixTextOptgroup
@docs suffixTextOption, suffixTextFocusTrap, suffixTextAppBar, suffixTextTextOverflow, suffixTextTextHighlight, suffixTextStateLayer
@docs suffixTextSlide, suffixTextScrollContainer, suffixTextRipple, suffixTextPseudoRadio, suffixTextPseudoCheckbox, suffixTextFocusRing
@docs suffixTextElevation, suffixTextCollapsible, suffixTextActionElementBase, hintTree, hintTreeItem, hintToolbar
@docs hintToc, hintTocItem, hintThemeIcon, hintTheme, hintTextareaAutosize, hintTabs
@docs hintTabPanel, hintTab, hintSwitch, hintStepperReset, hintStepperPrevious, hintStep
@docs hintStepPanel, hintStepper, hintSplitPane, hintSplitButton, hintSnackbar, hintSlider
@docs hintSliderThumb, hintSlideGroup, hintSkeleton, hintShape, hintSegmentedButton, hintButtonSegment
@docs hintSearchView, hintSearchBar, hintRadioGroup, hintRadio, hintProgressElementIndicatorBase, hintPaginator
@docs hintSelect, hintNavRailToggle, hintNavRail, hintNavMenuItemGroup, hintNavMenu, hintNavMenuItem
@docs hintNavBar, hintNavItem, hintMenuItemRadio, hintMenuItemGroup, hintMenuItemCheckbox, hintMenu
@docs hintMenuItem, hintMenuTrigger, hintMenuItemElementBase, hintLoadingIndicator, hintSelectionList, hintListOption
@docs hintActionList, hintExpandableListItem, hintListAction, hintListItemButton, hintList, hintListItem
@docs hintIcon, hintHeading, hintFabMenuTrigger, hintFabMenu, hintFab, hintAccordion
@docs hintExpansionPanel, hintExpansionHeader, hintDrawerToggle, hintDrawerContainer, hintDivider, hintDialogTrigger
@docs hintDialog, hintDialogAction, hintDatepickerToggle, hintDatepicker, hintContentPane, hintSuggestionChip
@docs hintInputChipSet, hintInputChip, hintFilterChipSet, hintFilterChip, hintChipSet, hintAssistChip
@docs hintChip, hintCheckbox, hintCard, hintCalendar, hintYearView, hintMultiYearView
@docs hintMonthView, hintTooltip, hintRichTooltip, hintTooltipElementBase, hintRichTooltipAction, hintButtonGroup
@docs hintIconButton, hintButton, hintBreadcrumb, hintBreadcrumbItem, hintBreadcrumbItemButton, hintBottomSheetTrigger
@docs hintBottomSheet, hintBottomSheetAction, hintBadge, hintAvatar, hintAutocomplete, hintFormField
@docs hintOptionPanel, hintFloatingPanel, hintOptgroup, hintOption, hintFocusTrap, hintAppBar
@docs hintTextOverflow, hintTextHighlight, hintStateLayer, hintSlide, hintScrollContainer, hintRipple
@docs hintPseudoRadio, hintPseudoCheckbox, hintFocusRing, hintElevation, hintCollapsible, hintActionElementBase
@docs errorTree, errorTreeItem, errorToolbar, errorToc, errorTocItem, errorThemeIcon
@docs errorTheme, errorTextareaAutosize, errorTabs, errorTabPanel, errorTab, errorSwitch
@docs errorStepperReset, errorStepperPrevious, errorStep, errorStepPanel, errorStepper, errorSplitPane
@docs errorSplitButton, errorSnackbar, errorSlider, errorSliderThumb, errorSlideGroup, errorSkeleton
@docs errorShape, errorSegmentedButton, errorButtonSegment, errorSearchView, errorSearchBar, errorRadioGroup
@docs errorRadio, errorProgressElementIndicatorBase, errorPaginator, errorSelect, errorNavRailToggle, errorNavRail
@docs errorNavMenuItemGroup, errorNavMenu, errorNavMenuItem, errorNavBar, errorNavItem, errorMenuItemRadio
@docs errorMenuItemGroup, errorMenuItemCheckbox, errorMenu, errorMenuItem, errorMenuTrigger, errorMenuItemElementBase
@docs errorLoadingIndicator, errorSelectionList, errorListOption, errorActionList, errorExpandableListItem, errorListAction
@docs errorListItemButton, errorList, errorListItem, errorIcon, errorHeading, errorFabMenuTrigger
@docs errorFabMenu, errorFab, errorAccordion, errorExpansionPanel, errorExpansionHeader, errorDrawerToggle
@docs errorDrawerContainer, errorDivider, errorDialogTrigger, errorDialog, errorDialogAction, errorDatepickerToggle
@docs errorDatepicker, errorContentPane, errorSuggestionChip, errorInputChipSet, errorInputChip, errorFilterChipSet
@docs errorFilterChip, errorChipSet, errorAssistChip, errorChip, errorCheckbox, errorCard
@docs errorCalendar, errorYearView, errorMultiYearView, errorMonthView, errorTooltip, errorRichTooltip
@docs errorTooltipElementBase, errorRichTooltipAction, errorButtonGroup, errorIconButton, errorButton, errorBreadcrumb
@docs errorBreadcrumbItem, errorBreadcrumbItemButton, errorBottomSheetTrigger, errorBottomSheet, errorBottomSheetAction, errorBadge
@docs errorAvatar, errorAutocomplete, errorFormField, errorOptionPanel, errorFloatingPanel, errorOptgroup
@docs errorOption, errorFocusTrap, errorAppBar, errorTextOverflow, errorTextHighlight, errorStateLayer
@docs errorSlide, errorScrollContainer, errorRipple, errorPseudoRadio, errorPseudoCheckbox, errorFocusRing
@docs errorElevation, errorCollapsible, errorActionElementBase, tree, treeItem, toolbar
@docs toc, tocItem, themeIcon, theme, textareaAutosize, tabs
@docs tabPanel, tab, switch, stepperReset, stepperPrevious, step
@docs stepPanel, stepper, splitPane, splitButton, snackbar, slider
@docs sliderThumb, slideGroup, skeleton, shape, segmentedButton, buttonSegment
@docs searchView, searchBar, radioGroup, radio, progressElementIndicatorBase, paginator
@docs select, navRailToggle, navRail, navMenuItemGroup, navMenu, navMenuItem
@docs navBar, navItem, menuItemRadio, menuItemGroup, menuItemCheckbox, menu
@docs menuItem, menuTrigger, menuItemElementBase, loadingIndicator, selectionList, listOption
@docs actionList, expandableListItem, listAction, listItemButton, list, listItem
@docs icon, heading, fabMenuTrigger, fabMenu, fab, accordion
@docs expansionPanel, expansionHeader, drawerToggle, drawerContainer, divider, dialogTrigger
@docs dialog, dialogAction, datepickerToggle, datepicker, contentPane, suggestionChip
@docs inputChipSet, inputChip, filterChipSet, filterChip, chipSet, assistChip
@docs chip, checkbox, card, calendar, yearView, multiYearView
@docs monthView, tooltip, richTooltip, tooltipElementBase, richTooltipAction, buttonGroup
@docs iconButton, button, breadcrumb, breadcrumbItem, breadcrumbItemButton, bottomSheetTrigger
@docs bottomSheet, bottomSheetAction, badge, avatar, autocomplete, formField
@docs optionPanel, floatingPanel, optgroup, option, focusTrap, appBar
@docs textOverflow, textHighlight, stateLayer, slide, scrollContainer, ripple
@docs pseudoRadio, pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase
-}


import M3e.Build.Accordion
import M3e.Build.ActionElementBase
import M3e.Build.ActionList
import M3e.Build.AppBar
import M3e.Build.AssistChip
import M3e.Build.Autocomplete
import M3e.Build.Avatar
import M3e.Build.Badge
import M3e.Build.BottomSheet
import M3e.Build.BottomSheetAction
import M3e.Build.BottomSheetTrigger
import M3e.Build.Breadcrumb
import M3e.Build.BreadcrumbItem
import M3e.Build.BreadcrumbItemButton
import M3e.Build.Button
import M3e.Build.ButtonGroup
import M3e.Build.ButtonSegment
import M3e.Build.Calendar
import M3e.Build.Card
import M3e.Build.Checkbox
import M3e.Build.Chip
import M3e.Build.ChipSet
import M3e.Build.Collapsible
import M3e.Build.ContentPane
import M3e.Build.Datepicker
import M3e.Build.DatepickerToggle
import M3e.Build.Dialog
import M3e.Build.DialogAction
import M3e.Build.DialogTrigger
import M3e.Build.Divider
import M3e.Build.DrawerContainer
import M3e.Build.DrawerToggle
import M3e.Build.Elevation
import M3e.Build.ExpandableListItem
import M3e.Build.ExpansionHeader
import M3e.Build.ExpansionPanel
import M3e.Build.Fab
import M3e.Build.FabMenu
import M3e.Build.FabMenuTrigger
import M3e.Build.FilterChip
import M3e.Build.FilterChipSet
import M3e.Build.FloatingPanel
import M3e.Build.FocusRing
import M3e.Build.FocusTrap
import M3e.Build.FormField
import M3e.Build.Heading
import M3e.Build.Icon
import M3e.Build.IconButton
import M3e.Build.InputChip
import M3e.Build.InputChipSet
import M3e.Build.Internal
import M3e.Build.List
import M3e.Build.ListAction
import M3e.Build.ListItem
import M3e.Build.ListItemButton
import M3e.Build.ListOption
import M3e.Build.LoadingIndicator
import M3e.Build.Menu
import M3e.Build.MenuItem
import M3e.Build.MenuItemCheckbox
import M3e.Build.MenuItemElementBase
import M3e.Build.MenuItemGroup
import M3e.Build.MenuItemRadio
import M3e.Build.MenuTrigger
import M3e.Build.MonthView
import M3e.Build.MultiYearView
import M3e.Build.NavBar
import M3e.Build.NavItem
import M3e.Build.NavMenu
import M3e.Build.NavMenuItem
import M3e.Build.NavMenuItemGroup
import M3e.Build.NavRail
import M3e.Build.NavRailToggle
import M3e.Build.Optgroup
import M3e.Build.Option
import M3e.Build.OptionPanel
import M3e.Build.Paginator
import M3e.Build.ProgressElementIndicatorBase
import M3e.Build.PseudoCheckbox
import M3e.Build.PseudoRadio
import M3e.Build.Radio
import M3e.Build.RadioGroup
import M3e.Build.RichTooltip
import M3e.Build.RichTooltipAction
import M3e.Build.Ripple
import M3e.Build.ScrollContainer
import M3e.Build.SearchBar
import M3e.Build.SearchView
import M3e.Build.SegmentedButton
import M3e.Build.Select
import M3e.Build.SelectionList
import M3e.Build.Shape
import M3e.Build.Skeleton
import M3e.Build.Slide
import M3e.Build.SlideGroup
import M3e.Build.Slider
import M3e.Build.SliderThumb
import M3e.Build.Snackbar
import M3e.Build.SplitButton
import M3e.Build.SplitPane
import M3e.Build.StateLayer
import M3e.Build.Step
import M3e.Build.StepPanel
import M3e.Build.Stepper
import M3e.Build.StepperPrevious
import M3e.Build.StepperReset
import M3e.Build.SuggestionChip
import M3e.Build.Switch
import M3e.Build.Tab
import M3e.Build.TabPanel
import M3e.Build.Tabs
import M3e.Build.TextHighlight
import M3e.Build.TextOverflow
import M3e.Build.TextareaAutosize
import M3e.Build.Theme
import M3e.Build.ThemeIcon
import M3e.Build.Toc
import M3e.Build.TocItem
import M3e.Build.Toolbar
import M3e.Build.Tooltip
import M3e.Build.TooltipElementBase
import M3e.Build.Tree
import M3e.Build.TreeItem
import M3e.Build.YearView
import M3e.Node


prefix_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefix_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


prefixText_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixText_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


label_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
label_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


suffix_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffix_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


suffixText_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixText_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


hint_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hint_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


error_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
error_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `prefix` slot of `FormField`. -}
prefixTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTree =
    prefix_core


{-| Place a `TreeItem` in the `prefix` slot of `FormField`. -}
prefixTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTreeItem =
    prefix_core


{-| Place a `Toolbar` in the `prefix` slot of `FormField`. -}
prefixToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixToolbar =
    prefix_core


{-| Place a `Toc` in the `prefix` slot of `FormField`. -}
prefixToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixToc =
    prefix_core


{-| Place a `TocItem` in the `prefix` slot of `FormField`. -}
prefixTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTocItem =
    prefix_core


{-| Place a `ThemeIcon` in the `prefix` slot of `FormField`. -}
prefixThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixThemeIcon =
    prefix_core


{-| Place a `Theme` in the `prefix` slot of `FormField`. -}
prefixTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTheme =
    prefix_core


{-| Place a `TextareaAutosize` in the `prefix` slot of `FormField`. -}
prefixTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTextareaAutosize =
    prefix_core


{-| Place a `Tabs` in the `prefix` slot of `FormField`. -}
prefixTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTabs =
    prefix_core


{-| Place a `TabPanel` in the `prefix` slot of `FormField`. -}
prefixTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTabPanel =
    prefix_core


{-| Place a `Tab` in the `prefix` slot of `FormField`. -}
prefixTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTab =
    prefix_core


{-| Place a `Switch` in the `prefix` slot of `FormField`. -}
prefixSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSwitch =
    prefix_core


{-| Place a `StepperReset` in the `prefix` slot of `FormField`. -}
prefixStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStepperReset =
    prefix_core


{-| Place a `StepperPrevious` in the `prefix` slot of `FormField`. -}
prefixStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStepperPrevious =
    prefix_core


{-| Place a `Step` in the `prefix` slot of `FormField`. -}
prefixStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStep =
    prefix_core


{-| Place a `StepPanel` in the `prefix` slot of `FormField`. -}
prefixStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStepPanel =
    prefix_core


{-| Place a `Stepper` in the `prefix` slot of `FormField`. -}
prefixStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStepper =
    prefix_core


{-| Place a `SplitPane` in the `prefix` slot of `FormField`. -}
prefixSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSplitPane =
    prefix_core


{-| Place a `SplitButton` in the `prefix` slot of `FormField`. -}
prefixSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSplitButton =
    prefix_core


{-| Place a `Snackbar` in the `prefix` slot of `FormField`. -}
prefixSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSnackbar =
    prefix_core


{-| Place a `Slider` in the `prefix` slot of `FormField`. -}
prefixSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSlider =
    prefix_core


{-| Place a `SliderThumb` in the `prefix` slot of `FormField`. -}
prefixSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSliderThumb =
    prefix_core


{-| Place a `SlideGroup` in the `prefix` slot of `FormField`. -}
prefixSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSlideGroup =
    prefix_core


{-| Place a `Skeleton` in the `prefix` slot of `FormField`. -}
prefixSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSkeleton =
    prefix_core


{-| Place a `Shape` in the `prefix` slot of `FormField`. -}
prefixShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixShape =
    prefix_core


{-| Place a `SegmentedButton` in the `prefix` slot of `FormField`. -}
prefixSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSegmentedButton =
    prefix_core


{-| Place a `ButtonSegment` in the `prefix` slot of `FormField`. -}
prefixButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixButtonSegment =
    prefix_core


{-| Place a `SearchView` in the `prefix` slot of `FormField`. -}
prefixSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSearchView =
    prefix_core


{-| Place a `SearchBar` in the `prefix` slot of `FormField`. -}
prefixSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSearchBar =
    prefix_core


{-| Place a `RadioGroup` in the `prefix` slot of `FormField`. -}
prefixRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixRadioGroup =
    prefix_core


{-| Place a `Radio` in the `prefix` slot of `FormField`. -}
prefixRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixRadio =
    prefix_core


{-| Place a `ProgressElementIndicatorBase` in the `prefix` slot of `FormField`. -}
prefixProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixProgressElementIndicatorBase =
    prefix_core


{-| Place a `Paginator` in the `prefix` slot of `FormField`. -}
prefixPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixPaginator =
    prefix_core


{-| Place a `Select` in the `prefix` slot of `FormField`. -}
prefixSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSelect =
    prefix_core


{-| Place a `NavRailToggle` in the `prefix` slot of `FormField`. -}
prefixNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavRailToggle =
    prefix_core


{-| Place a `NavRail` in the `prefix` slot of `FormField`. -}
prefixNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavRail =
    prefix_core


{-| Place a `NavMenuItemGroup` in the `prefix` slot of `FormField`. -}
prefixNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavMenuItemGroup =
    prefix_core


{-| Place a `NavMenu` in the `prefix` slot of `FormField`. -}
prefixNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavMenu =
    prefix_core


{-| Place a `NavMenuItem` in the `prefix` slot of `FormField`. -}
prefixNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavMenuItem =
    prefix_core


{-| Place a `NavBar` in the `prefix` slot of `FormField`. -}
prefixNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavBar =
    prefix_core


{-| Place a `NavItem` in the `prefix` slot of `FormField`. -}
prefixNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixNavItem =
    prefix_core


{-| Place a `MenuItemRadio` in the `prefix` slot of `FormField`. -}
prefixMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuItemRadio =
    prefix_core


{-| Place a `MenuItemGroup` in the `prefix` slot of `FormField`. -}
prefixMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuItemGroup =
    prefix_core


{-| Place a `MenuItemCheckbox` in the `prefix` slot of `FormField`. -}
prefixMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuItemCheckbox =
    prefix_core


{-| Place a `Menu` in the `prefix` slot of `FormField`. -}
prefixMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenu =
    prefix_core


{-| Place a `MenuItem` in the `prefix` slot of `FormField`. -}
prefixMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuItem =
    prefix_core


{-| Place a `MenuTrigger` in the `prefix` slot of `FormField`. -}
prefixMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuTrigger =
    prefix_core


{-| Place a `MenuItemElementBase` in the `prefix` slot of `FormField`. -}
prefixMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMenuItemElementBase =
    prefix_core


{-| Place a `LoadingIndicator` in the `prefix` slot of `FormField`. -}
prefixLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixLoadingIndicator =
    prefix_core


{-| Place a `SelectionList` in the `prefix` slot of `FormField`. -}
prefixSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSelectionList =
    prefix_core


{-| Place a `ListOption` in the `prefix` slot of `FormField`. -}
prefixListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixListOption =
    prefix_core


{-| Place a `ActionList` in the `prefix` slot of `FormField`. -}
prefixActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixActionList =
    prefix_core


{-| Place a `ExpandableListItem` in the `prefix` slot of `FormField`. -}
prefixExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixExpandableListItem =
    prefix_core


{-| Place a `ListAction` in the `prefix` slot of `FormField`. -}
prefixListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixListAction =
    prefix_core


{-| Place a `ListItemButton` in the `prefix` slot of `FormField`. -}
prefixListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixListItemButton =
    prefix_core


{-| Place a `List` in the `prefix` slot of `FormField`. -}
prefixList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixList =
    prefix_core


{-| Place a `ListItem` in the `prefix` slot of `FormField`. -}
prefixListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixListItem =
    prefix_core


{-| Place a `Icon` in the `prefix` slot of `FormField`. -}
prefixIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixIcon =
    prefix_core


{-| Place a `Heading` in the `prefix` slot of `FormField`. -}
prefixHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixHeading =
    prefix_core


{-| Place a `FabMenuTrigger` in the `prefix` slot of `FormField`. -}
prefixFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFabMenuTrigger =
    prefix_core


{-| Place a `FabMenu` in the `prefix` slot of `FormField`. -}
prefixFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFabMenu =
    prefix_core


{-| Place a `Fab` in the `prefix` slot of `FormField`. -}
prefixFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFab =
    prefix_core


{-| Place a `Accordion` in the `prefix` slot of `FormField`. -}
prefixAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixAccordion =
    prefix_core


{-| Place a `ExpansionPanel` in the `prefix` slot of `FormField`. -}
prefixExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixExpansionPanel =
    prefix_core


{-| Place a `ExpansionHeader` in the `prefix` slot of `FormField`. -}
prefixExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixExpansionHeader =
    prefix_core


{-| Place a `DrawerToggle` in the `prefix` slot of `FormField`. -}
prefixDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDrawerToggle =
    prefix_core


{-| Place a `DrawerContainer` in the `prefix` slot of `FormField`. -}
prefixDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDrawerContainer =
    prefix_core


{-| Place a `Divider` in the `prefix` slot of `FormField`. -}
prefixDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDivider =
    prefix_core


{-| Place a `DialogTrigger` in the `prefix` slot of `FormField`. -}
prefixDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDialogTrigger =
    prefix_core


{-| Place a `Dialog` in the `prefix` slot of `FormField`. -}
prefixDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDialog =
    prefix_core


{-| Place a `DialogAction` in the `prefix` slot of `FormField`. -}
prefixDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDialogAction =
    prefix_core


{-| Place a `DatepickerToggle` in the `prefix` slot of `FormField`. -}
prefixDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDatepickerToggle =
    prefix_core


{-| Place a `Datepicker` in the `prefix` slot of `FormField`. -}
prefixDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixDatepicker =
    prefix_core


{-| Place a `ContentPane` in the `prefix` slot of `FormField`. -}
prefixContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixContentPane =
    prefix_core


{-| Place a `SuggestionChip` in the `prefix` slot of `FormField`. -}
prefixSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSuggestionChip =
    prefix_core


{-| Place a `InputChipSet` in the `prefix` slot of `FormField`. -}
prefixInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixInputChipSet =
    prefix_core


{-| Place a `InputChip` in the `prefix` slot of `FormField`. -}
prefixInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixInputChip =
    prefix_core


{-| Place a `FilterChipSet` in the `prefix` slot of `FormField`. -}
prefixFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFilterChipSet =
    prefix_core


{-| Place a `FilterChip` in the `prefix` slot of `FormField`. -}
prefixFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFilterChip =
    prefix_core


{-| Place a `ChipSet` in the `prefix` slot of `FormField`. -}
prefixChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixChipSet =
    prefix_core


{-| Place a `AssistChip` in the `prefix` slot of `FormField`. -}
prefixAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixAssistChip =
    prefix_core


{-| Place a `Chip` in the `prefix` slot of `FormField`. -}
prefixChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixChip =
    prefix_core


{-| Place a `Checkbox` in the `prefix` slot of `FormField`. -}
prefixCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixCheckbox =
    prefix_core


{-| Place a `Card` in the `prefix` slot of `FormField`. -}
prefixCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixCard =
    prefix_core


{-| Place a `Calendar` in the `prefix` slot of `FormField`. -}
prefixCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixCalendar =
    prefix_core


{-| Place a `YearView` in the `prefix` slot of `FormField`. -}
prefixYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixYearView =
    prefix_core


{-| Place a `MultiYearView` in the `prefix` slot of `FormField`. -}
prefixMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMultiYearView =
    prefix_core


{-| Place a `MonthView` in the `prefix` slot of `FormField`. -}
prefixMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixMonthView =
    prefix_core


{-| Place a `Tooltip` in the `prefix` slot of `FormField`. -}
prefixTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTooltip =
    prefix_core


{-| Place a `RichTooltip` in the `prefix` slot of `FormField`. -}
prefixRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixRichTooltip =
    prefix_core


{-| Place a `TooltipElementBase` in the `prefix` slot of `FormField`. -}
prefixTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTooltipElementBase =
    prefix_core


{-| Place a `RichTooltipAction` in the `prefix` slot of `FormField`. -}
prefixRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixRichTooltipAction =
    prefix_core


{-| Place a `ButtonGroup` in the `prefix` slot of `FormField`. -}
prefixButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixButtonGroup =
    prefix_core


{-| Place a `IconButton` in the `prefix` slot of `FormField`. -}
prefixIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixIconButton =
    prefix_core


{-| Place a `Button` in the `prefix` slot of `FormField`. -}
prefixButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixButton =
    prefix_core


{-| Place a `Breadcrumb` in the `prefix` slot of `FormField`. -}
prefixBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBreadcrumb =
    prefix_core


{-| Place a `BreadcrumbItem` in the `prefix` slot of `FormField`. -}
prefixBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBreadcrumbItem =
    prefix_core


{-| Place a `BreadcrumbItemButton` in the `prefix` slot of `FormField`. -}
prefixBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBreadcrumbItemButton =
    prefix_core


{-| Place a `BottomSheetTrigger` in the `prefix` slot of `FormField`. -}
prefixBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBottomSheetTrigger =
    prefix_core


{-| Place a `BottomSheet` in the `prefix` slot of `FormField`. -}
prefixBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBottomSheet =
    prefix_core


{-| Place a `BottomSheetAction` in the `prefix` slot of `FormField`. -}
prefixBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBottomSheetAction =
    prefix_core


{-| Place a `Badge` in the `prefix` slot of `FormField`. -}
prefixBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixBadge =
    prefix_core


{-| Place a `Avatar` in the `prefix` slot of `FormField`. -}
prefixAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixAvatar =
    prefix_core


{-| Place a `Autocomplete` in the `prefix` slot of `FormField`. -}
prefixAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixAutocomplete =
    prefix_core


{-| Place a `FormField` in the `prefix` slot of `FormField`. -}
prefixFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFormField =
    prefix_core


{-| Place a `OptionPanel` in the `prefix` slot of `FormField`. -}
prefixOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixOptionPanel =
    prefix_core


{-| Place a `FloatingPanel` in the `prefix` slot of `FormField`. -}
prefixFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFloatingPanel =
    prefix_core


{-| Place a `Optgroup` in the `prefix` slot of `FormField`. -}
prefixOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixOptgroup =
    prefix_core


{-| Place a `Option` in the `prefix` slot of `FormField`. -}
prefixOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixOption =
    prefix_core


{-| Place a `FocusTrap` in the `prefix` slot of `FormField`. -}
prefixFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFocusTrap =
    prefix_core


{-| Place a `AppBar` in the `prefix` slot of `FormField`. -}
prefixAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixAppBar =
    prefix_core


{-| Place a `TextOverflow` in the `prefix` slot of `FormField`. -}
prefixTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTextOverflow =
    prefix_core


{-| Place a `TextHighlight` in the `prefix` slot of `FormField`. -}
prefixTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixTextHighlight =
    prefix_core


{-| Place a `StateLayer` in the `prefix` slot of `FormField`. -}
prefixStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixStateLayer =
    prefix_core


{-| Place a `Slide` in the `prefix` slot of `FormField`. -}
prefixSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixSlide =
    prefix_core


{-| Place a `ScrollContainer` in the `prefix` slot of `FormField`. -}
prefixScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixScrollContainer =
    prefix_core


{-| Place a `Ripple` in the `prefix` slot of `FormField`. -}
prefixRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixRipple =
    prefix_core


{-| Place a `PseudoRadio` in the `prefix` slot of `FormField`. -}
prefixPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixPseudoRadio =
    prefix_core


{-| Place a `PseudoCheckbox` in the `prefix` slot of `FormField`. -}
prefixPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixPseudoCheckbox =
    prefix_core


{-| Place a `FocusRing` in the `prefix` slot of `FormField`. -}
prefixFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixFocusRing =
    prefix_core


{-| Place a `Elevation` in the `prefix` slot of `FormField`. -}
prefixElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixElevation =
    prefix_core


{-| Place a `Collapsible` in the `prefix` slot of `FormField`. -}
prefixCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixCollapsible =
    prefix_core


{-| Place a `ActionElementBase` in the `prefix` slot of `FormField`. -}
prefixActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefix : M3e.Build.Internal.Used
    } msg pk
prefixActionElementBase =
    prefix_core


{-| Place a `Tree` in the `prefix-text` slot of `FormField`. -}
prefixTextTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTree =
    prefixText_core


{-| Place a `TreeItem` in the `prefix-text` slot of `FormField`. -}
prefixTextTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTreeItem =
    prefixText_core


{-| Place a `Toolbar` in the `prefix-text` slot of `FormField`. -}
prefixTextToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextToolbar =
    prefixText_core


{-| Place a `Toc` in the `prefix-text` slot of `FormField`. -}
prefixTextToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextToc =
    prefixText_core


{-| Place a `TocItem` in the `prefix-text` slot of `FormField`. -}
prefixTextTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTocItem =
    prefixText_core


{-| Place a `ThemeIcon` in the `prefix-text` slot of `FormField`. -}
prefixTextThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextThemeIcon =
    prefixText_core


{-| Place a `Theme` in the `prefix-text` slot of `FormField`. -}
prefixTextTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTheme =
    prefixText_core


{-| Place a `TextareaAutosize` in the `prefix-text` slot of `FormField`. -}
prefixTextTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTextareaAutosize =
    prefixText_core


{-| Place a `Tabs` in the `prefix-text` slot of `FormField`. -}
prefixTextTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTabs =
    prefixText_core


{-| Place a `TabPanel` in the `prefix-text` slot of `FormField`. -}
prefixTextTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTabPanel =
    prefixText_core


{-| Place a `Tab` in the `prefix-text` slot of `FormField`. -}
prefixTextTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTab =
    prefixText_core


{-| Place a `Switch` in the `prefix-text` slot of `FormField`. -}
prefixTextSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSwitch =
    prefixText_core


{-| Place a `StepperReset` in the `prefix-text` slot of `FormField`. -}
prefixTextStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStepperReset =
    prefixText_core


{-| Place a `StepperPrevious` in the `prefix-text` slot of `FormField`. -}
prefixTextStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStepperPrevious =
    prefixText_core


{-| Place a `Step` in the `prefix-text` slot of `FormField`. -}
prefixTextStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStep =
    prefixText_core


{-| Place a `StepPanel` in the `prefix-text` slot of `FormField`. -}
prefixTextStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStepPanel =
    prefixText_core


{-| Place a `Stepper` in the `prefix-text` slot of `FormField`. -}
prefixTextStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStepper =
    prefixText_core


{-| Place a `SplitPane` in the `prefix-text` slot of `FormField`. -}
prefixTextSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSplitPane =
    prefixText_core


{-| Place a `SplitButton` in the `prefix-text` slot of `FormField`. -}
prefixTextSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSplitButton =
    prefixText_core


{-| Place a `Snackbar` in the `prefix-text` slot of `FormField`. -}
prefixTextSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSnackbar =
    prefixText_core


{-| Place a `Slider` in the `prefix-text` slot of `FormField`. -}
prefixTextSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSlider =
    prefixText_core


{-| Place a `SliderThumb` in the `prefix-text` slot of `FormField`. -}
prefixTextSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSliderThumb =
    prefixText_core


{-| Place a `SlideGroup` in the `prefix-text` slot of `FormField`. -}
prefixTextSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSlideGroup =
    prefixText_core


{-| Place a `Skeleton` in the `prefix-text` slot of `FormField`. -}
prefixTextSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSkeleton =
    prefixText_core


{-| Place a `Shape` in the `prefix-text` slot of `FormField`. -}
prefixTextShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextShape =
    prefixText_core


{-| Place a `SegmentedButton` in the `prefix-text` slot of `FormField`. -}
prefixTextSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSegmentedButton =
    prefixText_core


{-| Place a `ButtonSegment` in the `prefix-text` slot of `FormField`. -}
prefixTextButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextButtonSegment =
    prefixText_core


{-| Place a `SearchView` in the `prefix-text` slot of `FormField`. -}
prefixTextSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSearchView =
    prefixText_core


{-| Place a `SearchBar` in the `prefix-text` slot of `FormField`. -}
prefixTextSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSearchBar =
    prefixText_core


{-| Place a `RadioGroup` in the `prefix-text` slot of `FormField`. -}
prefixTextRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextRadioGroup =
    prefixText_core


{-| Place a `Radio` in the `prefix-text` slot of `FormField`. -}
prefixTextRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextRadio =
    prefixText_core


{-| Place a `ProgressElementIndicatorBase` in the `prefix-text` slot of `FormField`. -}
prefixTextProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextProgressElementIndicatorBase =
    prefixText_core


{-| Place a `Paginator` in the `prefix-text` slot of `FormField`. -}
prefixTextPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextPaginator =
    prefixText_core


{-| Place a `Select` in the `prefix-text` slot of `FormField`. -}
prefixTextSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSelect =
    prefixText_core


{-| Place a `NavRailToggle` in the `prefix-text` slot of `FormField`. -}
prefixTextNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavRailToggle =
    prefixText_core


{-| Place a `NavRail` in the `prefix-text` slot of `FormField`. -}
prefixTextNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavRail =
    prefixText_core


{-| Place a `NavMenuItemGroup` in the `prefix-text` slot of `FormField`. -}
prefixTextNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavMenuItemGroup =
    prefixText_core


{-| Place a `NavMenu` in the `prefix-text` slot of `FormField`. -}
prefixTextNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavMenu =
    prefixText_core


{-| Place a `NavMenuItem` in the `prefix-text` slot of `FormField`. -}
prefixTextNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavMenuItem =
    prefixText_core


{-| Place a `NavBar` in the `prefix-text` slot of `FormField`. -}
prefixTextNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavBar =
    prefixText_core


{-| Place a `NavItem` in the `prefix-text` slot of `FormField`. -}
prefixTextNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextNavItem =
    prefixText_core


{-| Place a `MenuItemRadio` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuItemRadio =
    prefixText_core


{-| Place a `MenuItemGroup` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuItemGroup =
    prefixText_core


{-| Place a `MenuItemCheckbox` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuItemCheckbox =
    prefixText_core


{-| Place a `Menu` in the `prefix-text` slot of `FormField`. -}
prefixTextMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenu =
    prefixText_core


{-| Place a `MenuItem` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuItem =
    prefixText_core


{-| Place a `MenuTrigger` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuTrigger =
    prefixText_core


{-| Place a `MenuItemElementBase` in the `prefix-text` slot of `FormField`. -}
prefixTextMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMenuItemElementBase =
    prefixText_core


{-| Place a `LoadingIndicator` in the `prefix-text` slot of `FormField`. -}
prefixTextLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextLoadingIndicator =
    prefixText_core


{-| Place a `SelectionList` in the `prefix-text` slot of `FormField`. -}
prefixTextSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSelectionList =
    prefixText_core


{-| Place a `ListOption` in the `prefix-text` slot of `FormField`. -}
prefixTextListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextListOption =
    prefixText_core


{-| Place a `ActionList` in the `prefix-text` slot of `FormField`. -}
prefixTextActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextActionList =
    prefixText_core


{-| Place a `ExpandableListItem` in the `prefix-text` slot of `FormField`. -}
prefixTextExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextExpandableListItem =
    prefixText_core


{-| Place a `ListAction` in the `prefix-text` slot of `FormField`. -}
prefixTextListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextListAction =
    prefixText_core


{-| Place a `ListItemButton` in the `prefix-text` slot of `FormField`. -}
prefixTextListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextListItemButton =
    prefixText_core


{-| Place a `List` in the `prefix-text` slot of `FormField`. -}
prefixTextList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextList =
    prefixText_core


{-| Place a `ListItem` in the `prefix-text` slot of `FormField`. -}
prefixTextListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextListItem =
    prefixText_core


{-| Place a `Icon` in the `prefix-text` slot of `FormField`. -}
prefixTextIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextIcon =
    prefixText_core


{-| Place a `Heading` in the `prefix-text` slot of `FormField`. -}
prefixTextHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextHeading =
    prefixText_core


{-| Place a `FabMenuTrigger` in the `prefix-text` slot of `FormField`. -}
prefixTextFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFabMenuTrigger =
    prefixText_core


{-| Place a `FabMenu` in the `prefix-text` slot of `FormField`. -}
prefixTextFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFabMenu =
    prefixText_core


{-| Place a `Fab` in the `prefix-text` slot of `FormField`. -}
prefixTextFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFab =
    prefixText_core


{-| Place a `Accordion` in the `prefix-text` slot of `FormField`. -}
prefixTextAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextAccordion =
    prefixText_core


{-| Place a `ExpansionPanel` in the `prefix-text` slot of `FormField`. -}
prefixTextExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextExpansionPanel =
    prefixText_core


{-| Place a `ExpansionHeader` in the `prefix-text` slot of `FormField`. -}
prefixTextExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextExpansionHeader =
    prefixText_core


{-| Place a `DrawerToggle` in the `prefix-text` slot of `FormField`. -}
prefixTextDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDrawerToggle =
    prefixText_core


{-| Place a `DrawerContainer` in the `prefix-text` slot of `FormField`. -}
prefixTextDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDrawerContainer =
    prefixText_core


{-| Place a `Divider` in the `prefix-text` slot of `FormField`. -}
prefixTextDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDivider =
    prefixText_core


{-| Place a `DialogTrigger` in the `prefix-text` slot of `FormField`. -}
prefixTextDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDialogTrigger =
    prefixText_core


{-| Place a `Dialog` in the `prefix-text` slot of `FormField`. -}
prefixTextDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDialog =
    prefixText_core


{-| Place a `DialogAction` in the `prefix-text` slot of `FormField`. -}
prefixTextDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDialogAction =
    prefixText_core


{-| Place a `DatepickerToggle` in the `prefix-text` slot of `FormField`. -}
prefixTextDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDatepickerToggle =
    prefixText_core


{-| Place a `Datepicker` in the `prefix-text` slot of `FormField`. -}
prefixTextDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextDatepicker =
    prefixText_core


{-| Place a `ContentPane` in the `prefix-text` slot of `FormField`. -}
prefixTextContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextContentPane =
    prefixText_core


{-| Place a `SuggestionChip` in the `prefix-text` slot of `FormField`. -}
prefixTextSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSuggestionChip =
    prefixText_core


{-| Place a `InputChipSet` in the `prefix-text` slot of `FormField`. -}
prefixTextInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextInputChipSet =
    prefixText_core


{-| Place a `InputChip` in the `prefix-text` slot of `FormField`. -}
prefixTextInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextInputChip =
    prefixText_core


{-| Place a `FilterChipSet` in the `prefix-text` slot of `FormField`. -}
prefixTextFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFilterChipSet =
    prefixText_core


{-| Place a `FilterChip` in the `prefix-text` slot of `FormField`. -}
prefixTextFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFilterChip =
    prefixText_core


{-| Place a `ChipSet` in the `prefix-text` slot of `FormField`. -}
prefixTextChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextChipSet =
    prefixText_core


{-| Place a `AssistChip` in the `prefix-text` slot of `FormField`. -}
prefixTextAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextAssistChip =
    prefixText_core


{-| Place a `Chip` in the `prefix-text` slot of `FormField`. -}
prefixTextChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextChip =
    prefixText_core


{-| Place a `Checkbox` in the `prefix-text` slot of `FormField`. -}
prefixTextCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextCheckbox =
    prefixText_core


{-| Place a `Card` in the `prefix-text` slot of `FormField`. -}
prefixTextCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextCard =
    prefixText_core


{-| Place a `Calendar` in the `prefix-text` slot of `FormField`. -}
prefixTextCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextCalendar =
    prefixText_core


{-| Place a `YearView` in the `prefix-text` slot of `FormField`. -}
prefixTextYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextYearView =
    prefixText_core


{-| Place a `MultiYearView` in the `prefix-text` slot of `FormField`. -}
prefixTextMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMultiYearView =
    prefixText_core


{-| Place a `MonthView` in the `prefix-text` slot of `FormField`. -}
prefixTextMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextMonthView =
    prefixText_core


{-| Place a `Tooltip` in the `prefix-text` slot of `FormField`. -}
prefixTextTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTooltip =
    prefixText_core


{-| Place a `RichTooltip` in the `prefix-text` slot of `FormField`. -}
prefixTextRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextRichTooltip =
    prefixText_core


{-| Place a `TooltipElementBase` in the `prefix-text` slot of `FormField`. -}
prefixTextTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTooltipElementBase =
    prefixText_core


{-| Place a `RichTooltipAction` in the `prefix-text` slot of `FormField`. -}
prefixTextRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextRichTooltipAction =
    prefixText_core


{-| Place a `ButtonGroup` in the `prefix-text` slot of `FormField`. -}
prefixTextButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextButtonGroup =
    prefixText_core


{-| Place a `IconButton` in the `prefix-text` slot of `FormField`. -}
prefixTextIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextIconButton =
    prefixText_core


{-| Place a `Button` in the `prefix-text` slot of `FormField`. -}
prefixTextButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextButton =
    prefixText_core


{-| Place a `Breadcrumb` in the `prefix-text` slot of `FormField`. -}
prefixTextBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBreadcrumb =
    prefixText_core


{-| Place a `BreadcrumbItem` in the `prefix-text` slot of `FormField`. -}
prefixTextBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBreadcrumbItem =
    prefixText_core


{-| Place a `BreadcrumbItemButton` in the `prefix-text` slot of `FormField`. -}
prefixTextBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBreadcrumbItemButton =
    prefixText_core


{-| Place a `BottomSheetTrigger` in the `prefix-text` slot of `FormField`. -}
prefixTextBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBottomSheetTrigger =
    prefixText_core


{-| Place a `BottomSheet` in the `prefix-text` slot of `FormField`. -}
prefixTextBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBottomSheet =
    prefixText_core


{-| Place a `BottomSheetAction` in the `prefix-text` slot of `FormField`. -}
prefixTextBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBottomSheetAction =
    prefixText_core


{-| Place a `Badge` in the `prefix-text` slot of `FormField`. -}
prefixTextBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextBadge =
    prefixText_core


{-| Place a `Avatar` in the `prefix-text` slot of `FormField`. -}
prefixTextAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextAvatar =
    prefixText_core


{-| Place a `Autocomplete` in the `prefix-text` slot of `FormField`. -}
prefixTextAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextAutocomplete =
    prefixText_core


{-| Place a `FormField` in the `prefix-text` slot of `FormField`. -}
prefixTextFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFormField =
    prefixText_core


{-| Place a `OptionPanel` in the `prefix-text` slot of `FormField`. -}
prefixTextOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextOptionPanel =
    prefixText_core


{-| Place a `FloatingPanel` in the `prefix-text` slot of `FormField`. -}
prefixTextFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFloatingPanel =
    prefixText_core


{-| Place a `Optgroup` in the `prefix-text` slot of `FormField`. -}
prefixTextOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextOptgroup =
    prefixText_core


{-| Place a `Option` in the `prefix-text` slot of `FormField`. -}
prefixTextOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextOption =
    prefixText_core


{-| Place a `FocusTrap` in the `prefix-text` slot of `FormField`. -}
prefixTextFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFocusTrap =
    prefixText_core


{-| Place a `AppBar` in the `prefix-text` slot of `FormField`. -}
prefixTextAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextAppBar =
    prefixText_core


{-| Place a `TextOverflow` in the `prefix-text` slot of `FormField`. -}
prefixTextTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTextOverflow =
    prefixText_core


{-| Place a `TextHighlight` in the `prefix-text` slot of `FormField`. -}
prefixTextTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextTextHighlight =
    prefixText_core


{-| Place a `StateLayer` in the `prefix-text` slot of `FormField`. -}
prefixTextStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextStateLayer =
    prefixText_core


{-| Place a `Slide` in the `prefix-text` slot of `FormField`. -}
prefixTextSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextSlide =
    prefixText_core


{-| Place a `ScrollContainer` in the `prefix-text` slot of `FormField`. -}
prefixTextScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextScrollContainer =
    prefixText_core


{-| Place a `Ripple` in the `prefix-text` slot of `FormField`. -}
prefixTextRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextRipple =
    prefixText_core


{-| Place a `PseudoRadio` in the `prefix-text` slot of `FormField`. -}
prefixTextPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextPseudoRadio =
    prefixText_core


{-| Place a `PseudoCheckbox` in the `prefix-text` slot of `FormField`. -}
prefixTextPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextPseudoCheckbox =
    prefixText_core


{-| Place a `FocusRing` in the `prefix-text` slot of `FormField`. -}
prefixTextFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextFocusRing =
    prefixText_core


{-| Place a `Elevation` in the `prefix-text` slot of `FormField`. -}
prefixTextElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextElevation =
    prefixText_core


{-| Place a `Collapsible` in the `prefix-text` slot of `FormField`. -}
prefixTextCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextCollapsible =
    prefixText_core


{-| Place a `ActionElementBase` in the `prefix-text` slot of `FormField`. -}
prefixTextActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | prefixText : M3e.Build.Internal.Used
    } msg pk
prefixTextActionElementBase =
    prefixText_core


{-| Place a `Tree` in the `label` slot of `FormField`. -}
labelTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTree =
    label_core


{-| Place a `TreeItem` in the `label` slot of `FormField`. -}
labelTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTreeItem =
    label_core


{-| Place a `Toolbar` in the `label` slot of `FormField`. -}
labelToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelToolbar =
    label_core


{-| Place a `Toc` in the `label` slot of `FormField`. -}
labelToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelToc =
    label_core


{-| Place a `TocItem` in the `label` slot of `FormField`. -}
labelTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTocItem =
    label_core


{-| Place a `ThemeIcon` in the `label` slot of `FormField`. -}
labelThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelThemeIcon =
    label_core


{-| Place a `Theme` in the `label` slot of `FormField`. -}
labelTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTheme =
    label_core


{-| Place a `TextareaAutosize` in the `label` slot of `FormField`. -}
labelTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTextareaAutosize =
    label_core


{-| Place a `Tabs` in the `label` slot of `FormField`. -}
labelTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTabs =
    label_core


{-| Place a `TabPanel` in the `label` slot of `FormField`. -}
labelTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTabPanel =
    label_core


{-| Place a `Tab` in the `label` slot of `FormField`. -}
labelTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTab =
    label_core


{-| Place a `Switch` in the `label` slot of `FormField`. -}
labelSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSwitch =
    label_core


{-| Place a `StepperReset` in the `label` slot of `FormField`. -}
labelStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStepperReset =
    label_core


{-| Place a `StepperPrevious` in the `label` slot of `FormField`. -}
labelStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStepperPrevious =
    label_core


{-| Place a `Step` in the `label` slot of `FormField`. -}
labelStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStep =
    label_core


{-| Place a `StepPanel` in the `label` slot of `FormField`. -}
labelStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStepPanel =
    label_core


{-| Place a `Stepper` in the `label` slot of `FormField`. -}
labelStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStepper =
    label_core


{-| Place a `SplitPane` in the `label` slot of `FormField`. -}
labelSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSplitPane =
    label_core


{-| Place a `SplitButton` in the `label` slot of `FormField`. -}
labelSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSplitButton =
    label_core


{-| Place a `Snackbar` in the `label` slot of `FormField`. -}
labelSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSnackbar =
    label_core


{-| Place a `Slider` in the `label` slot of `FormField`. -}
labelSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSlider =
    label_core


{-| Place a `SliderThumb` in the `label` slot of `FormField`. -}
labelSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSliderThumb =
    label_core


{-| Place a `SlideGroup` in the `label` slot of `FormField`. -}
labelSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSlideGroup =
    label_core


{-| Place a `Skeleton` in the `label` slot of `FormField`. -}
labelSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSkeleton =
    label_core


{-| Place a `Shape` in the `label` slot of `FormField`. -}
labelShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelShape =
    label_core


{-| Place a `SegmentedButton` in the `label` slot of `FormField`. -}
labelSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSegmentedButton =
    label_core


{-| Place a `ButtonSegment` in the `label` slot of `FormField`. -}
labelButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelButtonSegment =
    label_core


{-| Place a `SearchView` in the `label` slot of `FormField`. -}
labelSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSearchView =
    label_core


{-| Place a `SearchBar` in the `label` slot of `FormField`. -}
labelSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSearchBar =
    label_core


{-| Place a `RadioGroup` in the `label` slot of `FormField`. -}
labelRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelRadioGroup =
    label_core


{-| Place a `Radio` in the `label` slot of `FormField`. -}
labelRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelRadio =
    label_core


{-| Place a `ProgressElementIndicatorBase` in the `label` slot of `FormField`. -}
labelProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelProgressElementIndicatorBase =
    label_core


{-| Place a `Paginator` in the `label` slot of `FormField`. -}
labelPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelPaginator =
    label_core


{-| Place a `Select` in the `label` slot of `FormField`. -}
labelSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSelect =
    label_core


{-| Place a `NavRailToggle` in the `label` slot of `FormField`. -}
labelNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavRailToggle =
    label_core


{-| Place a `NavRail` in the `label` slot of `FormField`. -}
labelNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavRail =
    label_core


{-| Place a `NavMenuItemGroup` in the `label` slot of `FormField`. -}
labelNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavMenuItemGroup =
    label_core


{-| Place a `NavMenu` in the `label` slot of `FormField`. -}
labelNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavMenu =
    label_core


{-| Place a `NavMenuItem` in the `label` slot of `FormField`. -}
labelNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavMenuItem =
    label_core


{-| Place a `NavBar` in the `label` slot of `FormField`. -}
labelNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavBar =
    label_core


{-| Place a `NavItem` in the `label` slot of `FormField`. -}
labelNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelNavItem =
    label_core


{-| Place a `MenuItemRadio` in the `label` slot of `FormField`. -}
labelMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuItemRadio =
    label_core


{-| Place a `MenuItemGroup` in the `label` slot of `FormField`. -}
labelMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuItemGroup =
    label_core


{-| Place a `MenuItemCheckbox` in the `label` slot of `FormField`. -}
labelMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuItemCheckbox =
    label_core


{-| Place a `Menu` in the `label` slot of `FormField`. -}
labelMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenu =
    label_core


{-| Place a `MenuItem` in the `label` slot of `FormField`. -}
labelMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuItem =
    label_core


{-| Place a `MenuTrigger` in the `label` slot of `FormField`. -}
labelMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuTrigger =
    label_core


{-| Place a `MenuItemElementBase` in the `label` slot of `FormField`. -}
labelMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMenuItemElementBase =
    label_core


{-| Place a `LoadingIndicator` in the `label` slot of `FormField`. -}
labelLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelLoadingIndicator =
    label_core


{-| Place a `SelectionList` in the `label` slot of `FormField`. -}
labelSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSelectionList =
    label_core


{-| Place a `ListOption` in the `label` slot of `FormField`. -}
labelListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelListOption =
    label_core


{-| Place a `ActionList` in the `label` slot of `FormField`. -}
labelActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelActionList =
    label_core


{-| Place a `ExpandableListItem` in the `label` slot of `FormField`. -}
labelExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelExpandableListItem =
    label_core


{-| Place a `ListAction` in the `label` slot of `FormField`. -}
labelListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelListAction =
    label_core


{-| Place a `ListItemButton` in the `label` slot of `FormField`. -}
labelListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelListItemButton =
    label_core


{-| Place a `List` in the `label` slot of `FormField`. -}
labelList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelList =
    label_core


{-| Place a `ListItem` in the `label` slot of `FormField`. -}
labelListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelListItem =
    label_core


{-| Place a `Icon` in the `label` slot of `FormField`. -}
labelIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelIcon =
    label_core


{-| Place a `Heading` in the `label` slot of `FormField`. -}
labelHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelHeading =
    label_core


{-| Place a `FabMenuTrigger` in the `label` slot of `FormField`. -}
labelFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFabMenuTrigger =
    label_core


{-| Place a `FabMenu` in the `label` slot of `FormField`. -}
labelFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFabMenu =
    label_core


{-| Place a `Fab` in the `label` slot of `FormField`. -}
labelFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFab =
    label_core


{-| Place a `Accordion` in the `label` slot of `FormField`. -}
labelAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelAccordion =
    label_core


{-| Place a `ExpansionPanel` in the `label` slot of `FormField`. -}
labelExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelExpansionPanel =
    label_core


{-| Place a `ExpansionHeader` in the `label` slot of `FormField`. -}
labelExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelExpansionHeader =
    label_core


{-| Place a `DrawerToggle` in the `label` slot of `FormField`. -}
labelDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDrawerToggle =
    label_core


{-| Place a `DrawerContainer` in the `label` slot of `FormField`. -}
labelDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDrawerContainer =
    label_core


{-| Place a `Divider` in the `label` slot of `FormField`. -}
labelDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDivider =
    label_core


{-| Place a `DialogTrigger` in the `label` slot of `FormField`. -}
labelDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDialogTrigger =
    label_core


{-| Place a `Dialog` in the `label` slot of `FormField`. -}
labelDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDialog =
    label_core


{-| Place a `DialogAction` in the `label` slot of `FormField`. -}
labelDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDialogAction =
    label_core


{-| Place a `DatepickerToggle` in the `label` slot of `FormField`. -}
labelDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDatepickerToggle =
    label_core


{-| Place a `Datepicker` in the `label` slot of `FormField`. -}
labelDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelDatepicker =
    label_core


{-| Place a `ContentPane` in the `label` slot of `FormField`. -}
labelContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelContentPane =
    label_core


{-| Place a `SuggestionChip` in the `label` slot of `FormField`. -}
labelSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSuggestionChip =
    label_core


{-| Place a `InputChipSet` in the `label` slot of `FormField`. -}
labelInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelInputChipSet =
    label_core


{-| Place a `InputChip` in the `label` slot of `FormField`. -}
labelInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelInputChip =
    label_core


{-| Place a `FilterChipSet` in the `label` slot of `FormField`. -}
labelFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFilterChipSet =
    label_core


{-| Place a `FilterChip` in the `label` slot of `FormField`. -}
labelFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFilterChip =
    label_core


{-| Place a `ChipSet` in the `label` slot of `FormField`. -}
labelChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelChipSet =
    label_core


{-| Place a `AssistChip` in the `label` slot of `FormField`. -}
labelAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelAssistChip =
    label_core


{-| Place a `Chip` in the `label` slot of `FormField`. -}
labelChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelChip =
    label_core


{-| Place a `Checkbox` in the `label` slot of `FormField`. -}
labelCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelCheckbox =
    label_core


{-| Place a `Card` in the `label` slot of `FormField`. -}
labelCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelCard =
    label_core


{-| Place a `Calendar` in the `label` slot of `FormField`. -}
labelCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelCalendar =
    label_core


{-| Place a `YearView` in the `label` slot of `FormField`. -}
labelYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelYearView =
    label_core


{-| Place a `MultiYearView` in the `label` slot of `FormField`. -}
labelMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMultiYearView =
    label_core


{-| Place a `MonthView` in the `label` slot of `FormField`. -}
labelMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelMonthView =
    label_core


{-| Place a `Tooltip` in the `label` slot of `FormField`. -}
labelTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTooltip =
    label_core


{-| Place a `RichTooltip` in the `label` slot of `FormField`. -}
labelRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelRichTooltip =
    label_core


{-| Place a `TooltipElementBase` in the `label` slot of `FormField`. -}
labelTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTooltipElementBase =
    label_core


{-| Place a `RichTooltipAction` in the `label` slot of `FormField`. -}
labelRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelRichTooltipAction =
    label_core


{-| Place a `ButtonGroup` in the `label` slot of `FormField`. -}
labelButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelButtonGroup =
    label_core


{-| Place a `IconButton` in the `label` slot of `FormField`. -}
labelIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelIconButton =
    label_core


{-| Place a `Button` in the `label` slot of `FormField`. -}
labelButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelButton =
    label_core


{-| Place a `Breadcrumb` in the `label` slot of `FormField`. -}
labelBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBreadcrumb =
    label_core


{-| Place a `BreadcrumbItem` in the `label` slot of `FormField`. -}
labelBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBreadcrumbItem =
    label_core


{-| Place a `BreadcrumbItemButton` in the `label` slot of `FormField`. -}
labelBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBreadcrumbItemButton =
    label_core


{-| Place a `BottomSheetTrigger` in the `label` slot of `FormField`. -}
labelBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBottomSheetTrigger =
    label_core


{-| Place a `BottomSheet` in the `label` slot of `FormField`. -}
labelBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBottomSheet =
    label_core


{-| Place a `BottomSheetAction` in the `label` slot of `FormField`. -}
labelBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBottomSheetAction =
    label_core


{-| Place a `Badge` in the `label` slot of `FormField`. -}
labelBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelBadge =
    label_core


{-| Place a `Avatar` in the `label` slot of `FormField`. -}
labelAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelAvatar =
    label_core


{-| Place a `Autocomplete` in the `label` slot of `FormField`. -}
labelAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelAutocomplete =
    label_core


{-| Place a `FormField` in the `label` slot of `FormField`. -}
labelFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFormField =
    label_core


{-| Place a `OptionPanel` in the `label` slot of `FormField`. -}
labelOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelOptionPanel =
    label_core


{-| Place a `FloatingPanel` in the `label` slot of `FormField`. -}
labelFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFloatingPanel =
    label_core


{-| Place a `Optgroup` in the `label` slot of `FormField`. -}
labelOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelOptgroup =
    label_core


{-| Place a `Option` in the `label` slot of `FormField`. -}
labelOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelOption =
    label_core


{-| Place a `FocusTrap` in the `label` slot of `FormField`. -}
labelFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFocusTrap =
    label_core


{-| Place a `AppBar` in the `label` slot of `FormField`. -}
labelAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelAppBar =
    label_core


{-| Place a `TextOverflow` in the `label` slot of `FormField`. -}
labelTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTextOverflow =
    label_core


{-| Place a `TextHighlight` in the `label` slot of `FormField`. -}
labelTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelTextHighlight =
    label_core


{-| Place a `StateLayer` in the `label` slot of `FormField`. -}
labelStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelStateLayer =
    label_core


{-| Place a `Slide` in the `label` slot of `FormField`. -}
labelSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelSlide =
    label_core


{-| Place a `ScrollContainer` in the `label` slot of `FormField`. -}
labelScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelScrollContainer =
    label_core


{-| Place a `Ripple` in the `label` slot of `FormField`. -}
labelRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelRipple =
    label_core


{-| Place a `PseudoRadio` in the `label` slot of `FormField`. -}
labelPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelPseudoRadio =
    label_core


{-| Place a `PseudoCheckbox` in the `label` slot of `FormField`. -}
labelPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelPseudoCheckbox =
    label_core


{-| Place a `FocusRing` in the `label` slot of `FormField`. -}
labelFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelFocusRing =
    label_core


{-| Place a `Elevation` in the `label` slot of `FormField`. -}
labelElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelElevation =
    label_core


{-| Place a `Collapsible` in the `label` slot of `FormField`. -}
labelCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelCollapsible =
    label_core


{-| Place a `ActionElementBase` in the `label` slot of `FormField`. -}
labelActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelActionElementBase =
    label_core


{-| Place a `Tree` in the `suffix` slot of `FormField`. -}
suffixTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTree =
    suffix_core


{-| Place a `TreeItem` in the `suffix` slot of `FormField`. -}
suffixTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTreeItem =
    suffix_core


{-| Place a `Toolbar` in the `suffix` slot of `FormField`. -}
suffixToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixToolbar =
    suffix_core


{-| Place a `Toc` in the `suffix` slot of `FormField`. -}
suffixToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixToc =
    suffix_core


{-| Place a `TocItem` in the `suffix` slot of `FormField`. -}
suffixTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTocItem =
    suffix_core


{-| Place a `ThemeIcon` in the `suffix` slot of `FormField`. -}
suffixThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixThemeIcon =
    suffix_core


{-| Place a `Theme` in the `suffix` slot of `FormField`. -}
suffixTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTheme =
    suffix_core


{-| Place a `TextareaAutosize` in the `suffix` slot of `FormField`. -}
suffixTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTextareaAutosize =
    suffix_core


{-| Place a `Tabs` in the `suffix` slot of `FormField`. -}
suffixTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTabs =
    suffix_core


{-| Place a `TabPanel` in the `suffix` slot of `FormField`. -}
suffixTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTabPanel =
    suffix_core


{-| Place a `Tab` in the `suffix` slot of `FormField`. -}
suffixTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTab =
    suffix_core


{-| Place a `Switch` in the `suffix` slot of `FormField`. -}
suffixSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSwitch =
    suffix_core


{-| Place a `StepperReset` in the `suffix` slot of `FormField`. -}
suffixStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStepperReset =
    suffix_core


{-| Place a `StepperPrevious` in the `suffix` slot of `FormField`. -}
suffixStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStepperPrevious =
    suffix_core


{-| Place a `Step` in the `suffix` slot of `FormField`. -}
suffixStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStep =
    suffix_core


{-| Place a `StepPanel` in the `suffix` slot of `FormField`. -}
suffixStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStepPanel =
    suffix_core


{-| Place a `Stepper` in the `suffix` slot of `FormField`. -}
suffixStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStepper =
    suffix_core


{-| Place a `SplitPane` in the `suffix` slot of `FormField`. -}
suffixSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSplitPane =
    suffix_core


{-| Place a `SplitButton` in the `suffix` slot of `FormField`. -}
suffixSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSplitButton =
    suffix_core


{-| Place a `Snackbar` in the `suffix` slot of `FormField`. -}
suffixSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSnackbar =
    suffix_core


{-| Place a `Slider` in the `suffix` slot of `FormField`. -}
suffixSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSlider =
    suffix_core


{-| Place a `SliderThumb` in the `suffix` slot of `FormField`. -}
suffixSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSliderThumb =
    suffix_core


{-| Place a `SlideGroup` in the `suffix` slot of `FormField`. -}
suffixSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSlideGroup =
    suffix_core


{-| Place a `Skeleton` in the `suffix` slot of `FormField`. -}
suffixSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSkeleton =
    suffix_core


{-| Place a `Shape` in the `suffix` slot of `FormField`. -}
suffixShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixShape =
    suffix_core


{-| Place a `SegmentedButton` in the `suffix` slot of `FormField`. -}
suffixSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSegmentedButton =
    suffix_core


{-| Place a `ButtonSegment` in the `suffix` slot of `FormField`. -}
suffixButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixButtonSegment =
    suffix_core


{-| Place a `SearchView` in the `suffix` slot of `FormField`. -}
suffixSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSearchView =
    suffix_core


{-| Place a `SearchBar` in the `suffix` slot of `FormField`. -}
suffixSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSearchBar =
    suffix_core


{-| Place a `RadioGroup` in the `suffix` slot of `FormField`. -}
suffixRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixRadioGroup =
    suffix_core


{-| Place a `Radio` in the `suffix` slot of `FormField`. -}
suffixRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixRadio =
    suffix_core


{-| Place a `ProgressElementIndicatorBase` in the `suffix` slot of `FormField`. -}
suffixProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixProgressElementIndicatorBase =
    suffix_core


{-| Place a `Paginator` in the `suffix` slot of `FormField`. -}
suffixPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixPaginator =
    suffix_core


{-| Place a `Select` in the `suffix` slot of `FormField`. -}
suffixSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSelect =
    suffix_core


{-| Place a `NavRailToggle` in the `suffix` slot of `FormField`. -}
suffixNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavRailToggle =
    suffix_core


{-| Place a `NavRail` in the `suffix` slot of `FormField`. -}
suffixNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavRail =
    suffix_core


{-| Place a `NavMenuItemGroup` in the `suffix` slot of `FormField`. -}
suffixNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavMenuItemGroup =
    suffix_core


{-| Place a `NavMenu` in the `suffix` slot of `FormField`. -}
suffixNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavMenu =
    suffix_core


{-| Place a `NavMenuItem` in the `suffix` slot of `FormField`. -}
suffixNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavMenuItem =
    suffix_core


{-| Place a `NavBar` in the `suffix` slot of `FormField`. -}
suffixNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavBar =
    suffix_core


{-| Place a `NavItem` in the `suffix` slot of `FormField`. -}
suffixNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixNavItem =
    suffix_core


{-| Place a `MenuItemRadio` in the `suffix` slot of `FormField`. -}
suffixMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuItemRadio =
    suffix_core


{-| Place a `MenuItemGroup` in the `suffix` slot of `FormField`. -}
suffixMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuItemGroup =
    suffix_core


{-| Place a `MenuItemCheckbox` in the `suffix` slot of `FormField`. -}
suffixMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuItemCheckbox =
    suffix_core


{-| Place a `Menu` in the `suffix` slot of `FormField`. -}
suffixMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenu =
    suffix_core


{-| Place a `MenuItem` in the `suffix` slot of `FormField`. -}
suffixMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuItem =
    suffix_core


{-| Place a `MenuTrigger` in the `suffix` slot of `FormField`. -}
suffixMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuTrigger =
    suffix_core


{-| Place a `MenuItemElementBase` in the `suffix` slot of `FormField`. -}
suffixMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMenuItemElementBase =
    suffix_core


{-| Place a `LoadingIndicator` in the `suffix` slot of `FormField`. -}
suffixLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixLoadingIndicator =
    suffix_core


{-| Place a `SelectionList` in the `suffix` slot of `FormField`. -}
suffixSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSelectionList =
    suffix_core


{-| Place a `ListOption` in the `suffix` slot of `FormField`. -}
suffixListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixListOption =
    suffix_core


{-| Place a `ActionList` in the `suffix` slot of `FormField`. -}
suffixActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixActionList =
    suffix_core


{-| Place a `ExpandableListItem` in the `suffix` slot of `FormField`. -}
suffixExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixExpandableListItem =
    suffix_core


{-| Place a `ListAction` in the `suffix` slot of `FormField`. -}
suffixListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixListAction =
    suffix_core


{-| Place a `ListItemButton` in the `suffix` slot of `FormField`. -}
suffixListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixListItemButton =
    suffix_core


{-| Place a `List` in the `suffix` slot of `FormField`. -}
suffixList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixList =
    suffix_core


{-| Place a `ListItem` in the `suffix` slot of `FormField`. -}
suffixListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixListItem =
    suffix_core


{-| Place a `Icon` in the `suffix` slot of `FormField`. -}
suffixIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixIcon =
    suffix_core


{-| Place a `Heading` in the `suffix` slot of `FormField`. -}
suffixHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixHeading =
    suffix_core


{-| Place a `FabMenuTrigger` in the `suffix` slot of `FormField`. -}
suffixFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFabMenuTrigger =
    suffix_core


{-| Place a `FabMenu` in the `suffix` slot of `FormField`. -}
suffixFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFabMenu =
    suffix_core


{-| Place a `Fab` in the `suffix` slot of `FormField`. -}
suffixFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFab =
    suffix_core


{-| Place a `Accordion` in the `suffix` slot of `FormField`. -}
suffixAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixAccordion =
    suffix_core


{-| Place a `ExpansionPanel` in the `suffix` slot of `FormField`. -}
suffixExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixExpansionPanel =
    suffix_core


{-| Place a `ExpansionHeader` in the `suffix` slot of `FormField`. -}
suffixExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixExpansionHeader =
    suffix_core


{-| Place a `DrawerToggle` in the `suffix` slot of `FormField`. -}
suffixDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDrawerToggle =
    suffix_core


{-| Place a `DrawerContainer` in the `suffix` slot of `FormField`. -}
suffixDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDrawerContainer =
    suffix_core


{-| Place a `Divider` in the `suffix` slot of `FormField`. -}
suffixDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDivider =
    suffix_core


{-| Place a `DialogTrigger` in the `suffix` slot of `FormField`. -}
suffixDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDialogTrigger =
    suffix_core


{-| Place a `Dialog` in the `suffix` slot of `FormField`. -}
suffixDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDialog =
    suffix_core


{-| Place a `DialogAction` in the `suffix` slot of `FormField`. -}
suffixDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDialogAction =
    suffix_core


{-| Place a `DatepickerToggle` in the `suffix` slot of `FormField`. -}
suffixDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDatepickerToggle =
    suffix_core


{-| Place a `Datepicker` in the `suffix` slot of `FormField`. -}
suffixDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixDatepicker =
    suffix_core


{-| Place a `ContentPane` in the `suffix` slot of `FormField`. -}
suffixContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixContentPane =
    suffix_core


{-| Place a `SuggestionChip` in the `suffix` slot of `FormField`. -}
suffixSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSuggestionChip =
    suffix_core


{-| Place a `InputChipSet` in the `suffix` slot of `FormField`. -}
suffixInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixInputChipSet =
    suffix_core


{-| Place a `InputChip` in the `suffix` slot of `FormField`. -}
suffixInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixInputChip =
    suffix_core


{-| Place a `FilterChipSet` in the `suffix` slot of `FormField`. -}
suffixFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFilterChipSet =
    suffix_core


{-| Place a `FilterChip` in the `suffix` slot of `FormField`. -}
suffixFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFilterChip =
    suffix_core


{-| Place a `ChipSet` in the `suffix` slot of `FormField`. -}
suffixChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixChipSet =
    suffix_core


{-| Place a `AssistChip` in the `suffix` slot of `FormField`. -}
suffixAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixAssistChip =
    suffix_core


{-| Place a `Chip` in the `suffix` slot of `FormField`. -}
suffixChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixChip =
    suffix_core


{-| Place a `Checkbox` in the `suffix` slot of `FormField`. -}
suffixCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixCheckbox =
    suffix_core


{-| Place a `Card` in the `suffix` slot of `FormField`. -}
suffixCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixCard =
    suffix_core


{-| Place a `Calendar` in the `suffix` slot of `FormField`. -}
suffixCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixCalendar =
    suffix_core


{-| Place a `YearView` in the `suffix` slot of `FormField`. -}
suffixYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixYearView =
    suffix_core


{-| Place a `MultiYearView` in the `suffix` slot of `FormField`. -}
suffixMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMultiYearView =
    suffix_core


{-| Place a `MonthView` in the `suffix` slot of `FormField`. -}
suffixMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixMonthView =
    suffix_core


{-| Place a `Tooltip` in the `suffix` slot of `FormField`. -}
suffixTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTooltip =
    suffix_core


{-| Place a `RichTooltip` in the `suffix` slot of `FormField`. -}
suffixRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixRichTooltip =
    suffix_core


{-| Place a `TooltipElementBase` in the `suffix` slot of `FormField`. -}
suffixTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTooltipElementBase =
    suffix_core


{-| Place a `RichTooltipAction` in the `suffix` slot of `FormField`. -}
suffixRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixRichTooltipAction =
    suffix_core


{-| Place a `ButtonGroup` in the `suffix` slot of `FormField`. -}
suffixButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixButtonGroup =
    suffix_core


{-| Place a `IconButton` in the `suffix` slot of `FormField`. -}
suffixIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixIconButton =
    suffix_core


{-| Place a `Button` in the `suffix` slot of `FormField`. -}
suffixButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixButton =
    suffix_core


{-| Place a `Breadcrumb` in the `suffix` slot of `FormField`. -}
suffixBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBreadcrumb =
    suffix_core


{-| Place a `BreadcrumbItem` in the `suffix` slot of `FormField`. -}
suffixBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBreadcrumbItem =
    suffix_core


{-| Place a `BreadcrumbItemButton` in the `suffix` slot of `FormField`. -}
suffixBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBreadcrumbItemButton =
    suffix_core


{-| Place a `BottomSheetTrigger` in the `suffix` slot of `FormField`. -}
suffixBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBottomSheetTrigger =
    suffix_core


{-| Place a `BottomSheet` in the `suffix` slot of `FormField`. -}
suffixBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBottomSheet =
    suffix_core


{-| Place a `BottomSheetAction` in the `suffix` slot of `FormField`. -}
suffixBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBottomSheetAction =
    suffix_core


{-| Place a `Badge` in the `suffix` slot of `FormField`. -}
suffixBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixBadge =
    suffix_core


{-| Place a `Avatar` in the `suffix` slot of `FormField`. -}
suffixAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixAvatar =
    suffix_core


{-| Place a `Autocomplete` in the `suffix` slot of `FormField`. -}
suffixAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixAutocomplete =
    suffix_core


{-| Place a `FormField` in the `suffix` slot of `FormField`. -}
suffixFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFormField =
    suffix_core


{-| Place a `OptionPanel` in the `suffix` slot of `FormField`. -}
suffixOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixOptionPanel =
    suffix_core


{-| Place a `FloatingPanel` in the `suffix` slot of `FormField`. -}
suffixFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFloatingPanel =
    suffix_core


{-| Place a `Optgroup` in the `suffix` slot of `FormField`. -}
suffixOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixOptgroup =
    suffix_core


{-| Place a `Option` in the `suffix` slot of `FormField`. -}
suffixOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixOption =
    suffix_core


{-| Place a `FocusTrap` in the `suffix` slot of `FormField`. -}
suffixFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFocusTrap =
    suffix_core


{-| Place a `AppBar` in the `suffix` slot of `FormField`. -}
suffixAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixAppBar =
    suffix_core


{-| Place a `TextOverflow` in the `suffix` slot of `FormField`. -}
suffixTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTextOverflow =
    suffix_core


{-| Place a `TextHighlight` in the `suffix` slot of `FormField`. -}
suffixTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixTextHighlight =
    suffix_core


{-| Place a `StateLayer` in the `suffix` slot of `FormField`. -}
suffixStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixStateLayer =
    suffix_core


{-| Place a `Slide` in the `suffix` slot of `FormField`. -}
suffixSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixSlide =
    suffix_core


{-| Place a `ScrollContainer` in the `suffix` slot of `FormField`. -}
suffixScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixScrollContainer =
    suffix_core


{-| Place a `Ripple` in the `suffix` slot of `FormField`. -}
suffixRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixRipple =
    suffix_core


{-| Place a `PseudoRadio` in the `suffix` slot of `FormField`. -}
suffixPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixPseudoRadio =
    suffix_core


{-| Place a `PseudoCheckbox` in the `suffix` slot of `FormField`. -}
suffixPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixPseudoCheckbox =
    suffix_core


{-| Place a `FocusRing` in the `suffix` slot of `FormField`. -}
suffixFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixFocusRing =
    suffix_core


{-| Place a `Elevation` in the `suffix` slot of `FormField`. -}
suffixElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixElevation =
    suffix_core


{-| Place a `Collapsible` in the `suffix` slot of `FormField`. -}
suffixCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixCollapsible =
    suffix_core


{-| Place a `ActionElementBase` in the `suffix` slot of `FormField`. -}
suffixActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffix : M3e.Build.Internal.Used
    } msg pk
suffixActionElementBase =
    suffix_core


{-| Place a `Tree` in the `suffix-text` slot of `FormField`. -}
suffixTextTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTree =
    suffixText_core


{-| Place a `TreeItem` in the `suffix-text` slot of `FormField`. -}
suffixTextTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTreeItem =
    suffixText_core


{-| Place a `Toolbar` in the `suffix-text` slot of `FormField`. -}
suffixTextToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextToolbar =
    suffixText_core


{-| Place a `Toc` in the `suffix-text` slot of `FormField`. -}
suffixTextToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextToc =
    suffixText_core


{-| Place a `TocItem` in the `suffix-text` slot of `FormField`. -}
suffixTextTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTocItem =
    suffixText_core


{-| Place a `ThemeIcon` in the `suffix-text` slot of `FormField`. -}
suffixTextThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextThemeIcon =
    suffixText_core


{-| Place a `Theme` in the `suffix-text` slot of `FormField`. -}
suffixTextTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTheme =
    suffixText_core


{-| Place a `TextareaAutosize` in the `suffix-text` slot of `FormField`. -}
suffixTextTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTextareaAutosize =
    suffixText_core


{-| Place a `Tabs` in the `suffix-text` slot of `FormField`. -}
suffixTextTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTabs =
    suffixText_core


{-| Place a `TabPanel` in the `suffix-text` slot of `FormField`. -}
suffixTextTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTabPanel =
    suffixText_core


{-| Place a `Tab` in the `suffix-text` slot of `FormField`. -}
suffixTextTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTab =
    suffixText_core


{-| Place a `Switch` in the `suffix-text` slot of `FormField`. -}
suffixTextSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSwitch =
    suffixText_core


{-| Place a `StepperReset` in the `suffix-text` slot of `FormField`. -}
suffixTextStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStepperReset =
    suffixText_core


{-| Place a `StepperPrevious` in the `suffix-text` slot of `FormField`. -}
suffixTextStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStepperPrevious =
    suffixText_core


{-| Place a `Step` in the `suffix-text` slot of `FormField`. -}
suffixTextStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStep =
    suffixText_core


{-| Place a `StepPanel` in the `suffix-text` slot of `FormField`. -}
suffixTextStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStepPanel =
    suffixText_core


{-| Place a `Stepper` in the `suffix-text` slot of `FormField`. -}
suffixTextStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStepper =
    suffixText_core


{-| Place a `SplitPane` in the `suffix-text` slot of `FormField`. -}
suffixTextSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSplitPane =
    suffixText_core


{-| Place a `SplitButton` in the `suffix-text` slot of `FormField`. -}
suffixTextSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSplitButton =
    suffixText_core


{-| Place a `Snackbar` in the `suffix-text` slot of `FormField`. -}
suffixTextSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSnackbar =
    suffixText_core


{-| Place a `Slider` in the `suffix-text` slot of `FormField`. -}
suffixTextSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSlider =
    suffixText_core


{-| Place a `SliderThumb` in the `suffix-text` slot of `FormField`. -}
suffixTextSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSliderThumb =
    suffixText_core


{-| Place a `SlideGroup` in the `suffix-text` slot of `FormField`. -}
suffixTextSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSlideGroup =
    suffixText_core


{-| Place a `Skeleton` in the `suffix-text` slot of `FormField`. -}
suffixTextSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSkeleton =
    suffixText_core


{-| Place a `Shape` in the `suffix-text` slot of `FormField`. -}
suffixTextShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextShape =
    suffixText_core


{-| Place a `SegmentedButton` in the `suffix-text` slot of `FormField`. -}
suffixTextSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSegmentedButton =
    suffixText_core


{-| Place a `ButtonSegment` in the `suffix-text` slot of `FormField`. -}
suffixTextButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextButtonSegment =
    suffixText_core


{-| Place a `SearchView` in the `suffix-text` slot of `FormField`. -}
suffixTextSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSearchView =
    suffixText_core


{-| Place a `SearchBar` in the `suffix-text` slot of `FormField`. -}
suffixTextSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSearchBar =
    suffixText_core


{-| Place a `RadioGroup` in the `suffix-text` slot of `FormField`. -}
suffixTextRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextRadioGroup =
    suffixText_core


{-| Place a `Radio` in the `suffix-text` slot of `FormField`. -}
suffixTextRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextRadio =
    suffixText_core


{-| Place a `ProgressElementIndicatorBase` in the `suffix-text` slot of `FormField`. -}
suffixTextProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextProgressElementIndicatorBase =
    suffixText_core


{-| Place a `Paginator` in the `suffix-text` slot of `FormField`. -}
suffixTextPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextPaginator =
    suffixText_core


{-| Place a `Select` in the `suffix-text` slot of `FormField`. -}
suffixTextSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSelect =
    suffixText_core


{-| Place a `NavRailToggle` in the `suffix-text` slot of `FormField`. -}
suffixTextNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavRailToggle =
    suffixText_core


{-| Place a `NavRail` in the `suffix-text` slot of `FormField`. -}
suffixTextNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavRail =
    suffixText_core


{-| Place a `NavMenuItemGroup` in the `suffix-text` slot of `FormField`. -}
suffixTextNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavMenuItemGroup =
    suffixText_core


{-| Place a `NavMenu` in the `suffix-text` slot of `FormField`. -}
suffixTextNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavMenu =
    suffixText_core


{-| Place a `NavMenuItem` in the `suffix-text` slot of `FormField`. -}
suffixTextNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavMenuItem =
    suffixText_core


{-| Place a `NavBar` in the `suffix-text` slot of `FormField`. -}
suffixTextNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavBar =
    suffixText_core


{-| Place a `NavItem` in the `suffix-text` slot of `FormField`. -}
suffixTextNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextNavItem =
    suffixText_core


{-| Place a `MenuItemRadio` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuItemRadio =
    suffixText_core


{-| Place a `MenuItemGroup` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuItemGroup =
    suffixText_core


{-| Place a `MenuItemCheckbox` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuItemCheckbox =
    suffixText_core


{-| Place a `Menu` in the `suffix-text` slot of `FormField`. -}
suffixTextMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenu =
    suffixText_core


{-| Place a `MenuItem` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuItem =
    suffixText_core


{-| Place a `MenuTrigger` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuTrigger =
    suffixText_core


{-| Place a `MenuItemElementBase` in the `suffix-text` slot of `FormField`. -}
suffixTextMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMenuItemElementBase =
    suffixText_core


{-| Place a `LoadingIndicator` in the `suffix-text` slot of `FormField`. -}
suffixTextLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextLoadingIndicator =
    suffixText_core


{-| Place a `SelectionList` in the `suffix-text` slot of `FormField`. -}
suffixTextSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSelectionList =
    suffixText_core


{-| Place a `ListOption` in the `suffix-text` slot of `FormField`. -}
suffixTextListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextListOption =
    suffixText_core


{-| Place a `ActionList` in the `suffix-text` slot of `FormField`. -}
suffixTextActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextActionList =
    suffixText_core


{-| Place a `ExpandableListItem` in the `suffix-text` slot of `FormField`. -}
suffixTextExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextExpandableListItem =
    suffixText_core


{-| Place a `ListAction` in the `suffix-text` slot of `FormField`. -}
suffixTextListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextListAction =
    suffixText_core


{-| Place a `ListItemButton` in the `suffix-text` slot of `FormField`. -}
suffixTextListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextListItemButton =
    suffixText_core


{-| Place a `List` in the `suffix-text` slot of `FormField`. -}
suffixTextList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextList =
    suffixText_core


{-| Place a `ListItem` in the `suffix-text` slot of `FormField`. -}
suffixTextListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextListItem =
    suffixText_core


{-| Place a `Icon` in the `suffix-text` slot of `FormField`. -}
suffixTextIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextIcon =
    suffixText_core


{-| Place a `Heading` in the `suffix-text` slot of `FormField`. -}
suffixTextHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextHeading =
    suffixText_core


{-| Place a `FabMenuTrigger` in the `suffix-text` slot of `FormField`. -}
suffixTextFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFabMenuTrigger =
    suffixText_core


{-| Place a `FabMenu` in the `suffix-text` slot of `FormField`. -}
suffixTextFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFabMenu =
    suffixText_core


{-| Place a `Fab` in the `suffix-text` slot of `FormField`. -}
suffixTextFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFab =
    suffixText_core


{-| Place a `Accordion` in the `suffix-text` slot of `FormField`. -}
suffixTextAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextAccordion =
    suffixText_core


{-| Place a `ExpansionPanel` in the `suffix-text` slot of `FormField`. -}
suffixTextExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextExpansionPanel =
    suffixText_core


{-| Place a `ExpansionHeader` in the `suffix-text` slot of `FormField`. -}
suffixTextExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextExpansionHeader =
    suffixText_core


{-| Place a `DrawerToggle` in the `suffix-text` slot of `FormField`. -}
suffixTextDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDrawerToggle =
    suffixText_core


{-| Place a `DrawerContainer` in the `suffix-text` slot of `FormField`. -}
suffixTextDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDrawerContainer =
    suffixText_core


{-| Place a `Divider` in the `suffix-text` slot of `FormField`. -}
suffixTextDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDivider =
    suffixText_core


{-| Place a `DialogTrigger` in the `suffix-text` slot of `FormField`. -}
suffixTextDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDialogTrigger =
    suffixText_core


{-| Place a `Dialog` in the `suffix-text` slot of `FormField`. -}
suffixTextDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDialog =
    suffixText_core


{-| Place a `DialogAction` in the `suffix-text` slot of `FormField`. -}
suffixTextDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDialogAction =
    suffixText_core


{-| Place a `DatepickerToggle` in the `suffix-text` slot of `FormField`. -}
suffixTextDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDatepickerToggle =
    suffixText_core


{-| Place a `Datepicker` in the `suffix-text` slot of `FormField`. -}
suffixTextDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextDatepicker =
    suffixText_core


{-| Place a `ContentPane` in the `suffix-text` slot of `FormField`. -}
suffixTextContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextContentPane =
    suffixText_core


{-| Place a `SuggestionChip` in the `suffix-text` slot of `FormField`. -}
suffixTextSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSuggestionChip =
    suffixText_core


{-| Place a `InputChipSet` in the `suffix-text` slot of `FormField`. -}
suffixTextInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextInputChipSet =
    suffixText_core


{-| Place a `InputChip` in the `suffix-text` slot of `FormField`. -}
suffixTextInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextInputChip =
    suffixText_core


{-| Place a `FilterChipSet` in the `suffix-text` slot of `FormField`. -}
suffixTextFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFilterChipSet =
    suffixText_core


{-| Place a `FilterChip` in the `suffix-text` slot of `FormField`. -}
suffixTextFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFilterChip =
    suffixText_core


{-| Place a `ChipSet` in the `suffix-text` slot of `FormField`. -}
suffixTextChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextChipSet =
    suffixText_core


{-| Place a `AssistChip` in the `suffix-text` slot of `FormField`. -}
suffixTextAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextAssistChip =
    suffixText_core


{-| Place a `Chip` in the `suffix-text` slot of `FormField`. -}
suffixTextChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextChip =
    suffixText_core


{-| Place a `Checkbox` in the `suffix-text` slot of `FormField`. -}
suffixTextCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextCheckbox =
    suffixText_core


{-| Place a `Card` in the `suffix-text` slot of `FormField`. -}
suffixTextCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextCard =
    suffixText_core


{-| Place a `Calendar` in the `suffix-text` slot of `FormField`. -}
suffixTextCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextCalendar =
    suffixText_core


{-| Place a `YearView` in the `suffix-text` slot of `FormField`. -}
suffixTextYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextYearView =
    suffixText_core


{-| Place a `MultiYearView` in the `suffix-text` slot of `FormField`. -}
suffixTextMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMultiYearView =
    suffixText_core


{-| Place a `MonthView` in the `suffix-text` slot of `FormField`. -}
suffixTextMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextMonthView =
    suffixText_core


{-| Place a `Tooltip` in the `suffix-text` slot of `FormField`. -}
suffixTextTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTooltip =
    suffixText_core


{-| Place a `RichTooltip` in the `suffix-text` slot of `FormField`. -}
suffixTextRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextRichTooltip =
    suffixText_core


{-| Place a `TooltipElementBase` in the `suffix-text` slot of `FormField`. -}
suffixTextTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTooltipElementBase =
    suffixText_core


{-| Place a `RichTooltipAction` in the `suffix-text` slot of `FormField`. -}
suffixTextRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextRichTooltipAction =
    suffixText_core


{-| Place a `ButtonGroup` in the `suffix-text` slot of `FormField`. -}
suffixTextButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextButtonGroup =
    suffixText_core


{-| Place a `IconButton` in the `suffix-text` slot of `FormField`. -}
suffixTextIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextIconButton =
    suffixText_core


{-| Place a `Button` in the `suffix-text` slot of `FormField`. -}
suffixTextButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextButton =
    suffixText_core


{-| Place a `Breadcrumb` in the `suffix-text` slot of `FormField`. -}
suffixTextBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBreadcrumb =
    suffixText_core


{-| Place a `BreadcrumbItem` in the `suffix-text` slot of `FormField`. -}
suffixTextBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBreadcrumbItem =
    suffixText_core


{-| Place a `BreadcrumbItemButton` in the `suffix-text` slot of `FormField`. -}
suffixTextBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBreadcrumbItemButton =
    suffixText_core


{-| Place a `BottomSheetTrigger` in the `suffix-text` slot of `FormField`. -}
suffixTextBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBottomSheetTrigger =
    suffixText_core


{-| Place a `BottomSheet` in the `suffix-text` slot of `FormField`. -}
suffixTextBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBottomSheet =
    suffixText_core


{-| Place a `BottomSheetAction` in the `suffix-text` slot of `FormField`. -}
suffixTextBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBottomSheetAction =
    suffixText_core


{-| Place a `Badge` in the `suffix-text` slot of `FormField`. -}
suffixTextBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextBadge =
    suffixText_core


{-| Place a `Avatar` in the `suffix-text` slot of `FormField`. -}
suffixTextAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextAvatar =
    suffixText_core


{-| Place a `Autocomplete` in the `suffix-text` slot of `FormField`. -}
suffixTextAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextAutocomplete =
    suffixText_core


{-| Place a `FormField` in the `suffix-text` slot of `FormField`. -}
suffixTextFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFormField =
    suffixText_core


{-| Place a `OptionPanel` in the `suffix-text` slot of `FormField`. -}
suffixTextOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextOptionPanel =
    suffixText_core


{-| Place a `FloatingPanel` in the `suffix-text` slot of `FormField`. -}
suffixTextFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFloatingPanel =
    suffixText_core


{-| Place a `Optgroup` in the `suffix-text` slot of `FormField`. -}
suffixTextOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextOptgroup =
    suffixText_core


{-| Place a `Option` in the `suffix-text` slot of `FormField`. -}
suffixTextOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextOption =
    suffixText_core


{-| Place a `FocusTrap` in the `suffix-text` slot of `FormField`. -}
suffixTextFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFocusTrap =
    suffixText_core


{-| Place a `AppBar` in the `suffix-text` slot of `FormField`. -}
suffixTextAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextAppBar =
    suffixText_core


{-| Place a `TextOverflow` in the `suffix-text` slot of `FormField`. -}
suffixTextTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTextOverflow =
    suffixText_core


{-| Place a `TextHighlight` in the `suffix-text` slot of `FormField`. -}
suffixTextTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextTextHighlight =
    suffixText_core


{-| Place a `StateLayer` in the `suffix-text` slot of `FormField`. -}
suffixTextStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextStateLayer =
    suffixText_core


{-| Place a `Slide` in the `suffix-text` slot of `FormField`. -}
suffixTextSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextSlide =
    suffixText_core


{-| Place a `ScrollContainer` in the `suffix-text` slot of `FormField`. -}
suffixTextScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextScrollContainer =
    suffixText_core


{-| Place a `Ripple` in the `suffix-text` slot of `FormField`. -}
suffixTextRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextRipple =
    suffixText_core


{-| Place a `PseudoRadio` in the `suffix-text` slot of `FormField`. -}
suffixTextPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextPseudoRadio =
    suffixText_core


{-| Place a `PseudoCheckbox` in the `suffix-text` slot of `FormField`. -}
suffixTextPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextPseudoCheckbox =
    suffixText_core


{-| Place a `FocusRing` in the `suffix-text` slot of `FormField`. -}
suffixTextFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextFocusRing =
    suffixText_core


{-| Place a `Elevation` in the `suffix-text` slot of `FormField`. -}
suffixTextElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextElevation =
    suffixText_core


{-| Place a `Collapsible` in the `suffix-text` slot of `FormField`. -}
suffixTextCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextCollapsible =
    suffixText_core


{-| Place a `ActionElementBase` in the `suffix-text` slot of `FormField`. -}
suffixTextActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | suffixText : M3e.Build.Internal.Used
    } msg pk
suffixTextActionElementBase =
    suffixText_core


{-| Place a `Tree` in the `hint` slot of `FormField`. -}
hintTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTree =
    hint_core


{-| Place a `TreeItem` in the `hint` slot of `FormField`. -}
hintTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTreeItem =
    hint_core


{-| Place a `Toolbar` in the `hint` slot of `FormField`. -}
hintToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintToolbar =
    hint_core


{-| Place a `Toc` in the `hint` slot of `FormField`. -}
hintToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintToc =
    hint_core


{-| Place a `TocItem` in the `hint` slot of `FormField`. -}
hintTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTocItem =
    hint_core


{-| Place a `ThemeIcon` in the `hint` slot of `FormField`. -}
hintThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintThemeIcon =
    hint_core


{-| Place a `Theme` in the `hint` slot of `FormField`. -}
hintTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTheme =
    hint_core


{-| Place a `TextareaAutosize` in the `hint` slot of `FormField`. -}
hintTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTextareaAutosize =
    hint_core


{-| Place a `Tabs` in the `hint` slot of `FormField`. -}
hintTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTabs =
    hint_core


{-| Place a `TabPanel` in the `hint` slot of `FormField`. -}
hintTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTabPanel =
    hint_core


{-| Place a `Tab` in the `hint` slot of `FormField`. -}
hintTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTab =
    hint_core


{-| Place a `Switch` in the `hint` slot of `FormField`. -}
hintSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSwitch =
    hint_core


{-| Place a `StepperReset` in the `hint` slot of `FormField`. -}
hintStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStepperReset =
    hint_core


{-| Place a `StepperPrevious` in the `hint` slot of `FormField`. -}
hintStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStepperPrevious =
    hint_core


{-| Place a `Step` in the `hint` slot of `FormField`. -}
hintStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStep =
    hint_core


{-| Place a `StepPanel` in the `hint` slot of `FormField`. -}
hintStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStepPanel =
    hint_core


{-| Place a `Stepper` in the `hint` slot of `FormField`. -}
hintStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStepper =
    hint_core


{-| Place a `SplitPane` in the `hint` slot of `FormField`. -}
hintSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSplitPane =
    hint_core


{-| Place a `SplitButton` in the `hint` slot of `FormField`. -}
hintSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSplitButton =
    hint_core


{-| Place a `Snackbar` in the `hint` slot of `FormField`. -}
hintSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSnackbar =
    hint_core


{-| Place a `Slider` in the `hint` slot of `FormField`. -}
hintSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSlider =
    hint_core


{-| Place a `SliderThumb` in the `hint` slot of `FormField`. -}
hintSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSliderThumb =
    hint_core


{-| Place a `SlideGroup` in the `hint` slot of `FormField`. -}
hintSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSlideGroup =
    hint_core


{-| Place a `Skeleton` in the `hint` slot of `FormField`. -}
hintSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSkeleton =
    hint_core


{-| Place a `Shape` in the `hint` slot of `FormField`. -}
hintShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintShape =
    hint_core


{-| Place a `SegmentedButton` in the `hint` slot of `FormField`. -}
hintSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSegmentedButton =
    hint_core


{-| Place a `ButtonSegment` in the `hint` slot of `FormField`. -}
hintButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintButtonSegment =
    hint_core


{-| Place a `SearchView` in the `hint` slot of `FormField`. -}
hintSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSearchView =
    hint_core


{-| Place a `SearchBar` in the `hint` slot of `FormField`. -}
hintSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSearchBar =
    hint_core


{-| Place a `RadioGroup` in the `hint` slot of `FormField`. -}
hintRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintRadioGroup =
    hint_core


{-| Place a `Radio` in the `hint` slot of `FormField`. -}
hintRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintRadio =
    hint_core


{-| Place a `ProgressElementIndicatorBase` in the `hint` slot of `FormField`. -}
hintProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintProgressElementIndicatorBase =
    hint_core


{-| Place a `Paginator` in the `hint` slot of `FormField`. -}
hintPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintPaginator =
    hint_core


{-| Place a `Select` in the `hint` slot of `FormField`. -}
hintSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSelect =
    hint_core


{-| Place a `NavRailToggle` in the `hint` slot of `FormField`. -}
hintNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavRailToggle =
    hint_core


{-| Place a `NavRail` in the `hint` slot of `FormField`. -}
hintNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavRail =
    hint_core


{-| Place a `NavMenuItemGroup` in the `hint` slot of `FormField`. -}
hintNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavMenuItemGroup =
    hint_core


{-| Place a `NavMenu` in the `hint` slot of `FormField`. -}
hintNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavMenu =
    hint_core


{-| Place a `NavMenuItem` in the `hint` slot of `FormField`. -}
hintNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavMenuItem =
    hint_core


{-| Place a `NavBar` in the `hint` slot of `FormField`. -}
hintNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavBar =
    hint_core


{-| Place a `NavItem` in the `hint` slot of `FormField`. -}
hintNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintNavItem =
    hint_core


{-| Place a `MenuItemRadio` in the `hint` slot of `FormField`. -}
hintMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuItemRadio =
    hint_core


{-| Place a `MenuItemGroup` in the `hint` slot of `FormField`. -}
hintMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuItemGroup =
    hint_core


{-| Place a `MenuItemCheckbox` in the `hint` slot of `FormField`. -}
hintMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuItemCheckbox =
    hint_core


{-| Place a `Menu` in the `hint` slot of `FormField`. -}
hintMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenu =
    hint_core


{-| Place a `MenuItem` in the `hint` slot of `FormField`. -}
hintMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuItem =
    hint_core


{-| Place a `MenuTrigger` in the `hint` slot of `FormField`. -}
hintMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuTrigger =
    hint_core


{-| Place a `MenuItemElementBase` in the `hint` slot of `FormField`. -}
hintMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMenuItemElementBase =
    hint_core


{-| Place a `LoadingIndicator` in the `hint` slot of `FormField`. -}
hintLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintLoadingIndicator =
    hint_core


{-| Place a `SelectionList` in the `hint` slot of `FormField`. -}
hintSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSelectionList =
    hint_core


{-| Place a `ListOption` in the `hint` slot of `FormField`. -}
hintListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintListOption =
    hint_core


{-| Place a `ActionList` in the `hint` slot of `FormField`. -}
hintActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintActionList =
    hint_core


{-| Place a `ExpandableListItem` in the `hint` slot of `FormField`. -}
hintExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintExpandableListItem =
    hint_core


{-| Place a `ListAction` in the `hint` slot of `FormField`. -}
hintListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintListAction =
    hint_core


{-| Place a `ListItemButton` in the `hint` slot of `FormField`. -}
hintListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintListItemButton =
    hint_core


{-| Place a `List` in the `hint` slot of `FormField`. -}
hintList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintList =
    hint_core


{-| Place a `ListItem` in the `hint` slot of `FormField`. -}
hintListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintListItem =
    hint_core


{-| Place a `Icon` in the `hint` slot of `FormField`. -}
hintIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintIcon =
    hint_core


{-| Place a `Heading` in the `hint` slot of `FormField`. -}
hintHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintHeading =
    hint_core


{-| Place a `FabMenuTrigger` in the `hint` slot of `FormField`. -}
hintFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFabMenuTrigger =
    hint_core


{-| Place a `FabMenu` in the `hint` slot of `FormField`. -}
hintFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFabMenu =
    hint_core


{-| Place a `Fab` in the `hint` slot of `FormField`. -}
hintFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFab =
    hint_core


{-| Place a `Accordion` in the `hint` slot of `FormField`. -}
hintAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintAccordion =
    hint_core


{-| Place a `ExpansionPanel` in the `hint` slot of `FormField`. -}
hintExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintExpansionPanel =
    hint_core


{-| Place a `ExpansionHeader` in the `hint` slot of `FormField`. -}
hintExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintExpansionHeader =
    hint_core


{-| Place a `DrawerToggle` in the `hint` slot of `FormField`. -}
hintDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDrawerToggle =
    hint_core


{-| Place a `DrawerContainer` in the `hint` slot of `FormField`. -}
hintDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDrawerContainer =
    hint_core


{-| Place a `Divider` in the `hint` slot of `FormField`. -}
hintDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDivider =
    hint_core


{-| Place a `DialogTrigger` in the `hint` slot of `FormField`. -}
hintDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDialogTrigger =
    hint_core


{-| Place a `Dialog` in the `hint` slot of `FormField`. -}
hintDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDialog =
    hint_core


{-| Place a `DialogAction` in the `hint` slot of `FormField`. -}
hintDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDialogAction =
    hint_core


{-| Place a `DatepickerToggle` in the `hint` slot of `FormField`. -}
hintDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDatepickerToggle =
    hint_core


{-| Place a `Datepicker` in the `hint` slot of `FormField`. -}
hintDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintDatepicker =
    hint_core


{-| Place a `ContentPane` in the `hint` slot of `FormField`. -}
hintContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintContentPane =
    hint_core


{-| Place a `SuggestionChip` in the `hint` slot of `FormField`. -}
hintSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSuggestionChip =
    hint_core


{-| Place a `InputChipSet` in the `hint` slot of `FormField`. -}
hintInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintInputChipSet =
    hint_core


{-| Place a `InputChip` in the `hint` slot of `FormField`. -}
hintInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintInputChip =
    hint_core


{-| Place a `FilterChipSet` in the `hint` slot of `FormField`. -}
hintFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFilterChipSet =
    hint_core


{-| Place a `FilterChip` in the `hint` slot of `FormField`. -}
hintFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFilterChip =
    hint_core


{-| Place a `ChipSet` in the `hint` slot of `FormField`. -}
hintChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintChipSet =
    hint_core


{-| Place a `AssistChip` in the `hint` slot of `FormField`. -}
hintAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintAssistChip =
    hint_core


{-| Place a `Chip` in the `hint` slot of `FormField`. -}
hintChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintChip =
    hint_core


{-| Place a `Checkbox` in the `hint` slot of `FormField`. -}
hintCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintCheckbox =
    hint_core


{-| Place a `Card` in the `hint` slot of `FormField`. -}
hintCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintCard =
    hint_core


{-| Place a `Calendar` in the `hint` slot of `FormField`. -}
hintCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintCalendar =
    hint_core


{-| Place a `YearView` in the `hint` slot of `FormField`. -}
hintYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintYearView =
    hint_core


{-| Place a `MultiYearView` in the `hint` slot of `FormField`. -}
hintMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMultiYearView =
    hint_core


{-| Place a `MonthView` in the `hint` slot of `FormField`. -}
hintMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintMonthView =
    hint_core


{-| Place a `Tooltip` in the `hint` slot of `FormField`. -}
hintTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTooltip =
    hint_core


{-| Place a `RichTooltip` in the `hint` slot of `FormField`. -}
hintRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintRichTooltip =
    hint_core


{-| Place a `TooltipElementBase` in the `hint` slot of `FormField`. -}
hintTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTooltipElementBase =
    hint_core


{-| Place a `RichTooltipAction` in the `hint` slot of `FormField`. -}
hintRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintRichTooltipAction =
    hint_core


{-| Place a `ButtonGroup` in the `hint` slot of `FormField`. -}
hintButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintButtonGroup =
    hint_core


{-| Place a `IconButton` in the `hint` slot of `FormField`. -}
hintIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintIconButton =
    hint_core


{-| Place a `Button` in the `hint` slot of `FormField`. -}
hintButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintButton =
    hint_core


{-| Place a `Breadcrumb` in the `hint` slot of `FormField`. -}
hintBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBreadcrumb =
    hint_core


{-| Place a `BreadcrumbItem` in the `hint` slot of `FormField`. -}
hintBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBreadcrumbItem =
    hint_core


{-| Place a `BreadcrumbItemButton` in the `hint` slot of `FormField`. -}
hintBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBreadcrumbItemButton =
    hint_core


{-| Place a `BottomSheetTrigger` in the `hint` slot of `FormField`. -}
hintBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBottomSheetTrigger =
    hint_core


{-| Place a `BottomSheet` in the `hint` slot of `FormField`. -}
hintBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBottomSheet =
    hint_core


{-| Place a `BottomSheetAction` in the `hint` slot of `FormField`. -}
hintBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBottomSheetAction =
    hint_core


{-| Place a `Badge` in the `hint` slot of `FormField`. -}
hintBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintBadge =
    hint_core


{-| Place a `Avatar` in the `hint` slot of `FormField`. -}
hintAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintAvatar =
    hint_core


{-| Place a `Autocomplete` in the `hint` slot of `FormField`. -}
hintAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintAutocomplete =
    hint_core


{-| Place a `FormField` in the `hint` slot of `FormField`. -}
hintFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFormField =
    hint_core


{-| Place a `OptionPanel` in the `hint` slot of `FormField`. -}
hintOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintOptionPanel =
    hint_core


{-| Place a `FloatingPanel` in the `hint` slot of `FormField`. -}
hintFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFloatingPanel =
    hint_core


{-| Place a `Optgroup` in the `hint` slot of `FormField`. -}
hintOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintOptgroup =
    hint_core


{-| Place a `Option` in the `hint` slot of `FormField`. -}
hintOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintOption =
    hint_core


{-| Place a `FocusTrap` in the `hint` slot of `FormField`. -}
hintFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFocusTrap =
    hint_core


{-| Place a `AppBar` in the `hint` slot of `FormField`. -}
hintAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintAppBar =
    hint_core


{-| Place a `TextOverflow` in the `hint` slot of `FormField`. -}
hintTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTextOverflow =
    hint_core


{-| Place a `TextHighlight` in the `hint` slot of `FormField`. -}
hintTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintTextHighlight =
    hint_core


{-| Place a `StateLayer` in the `hint` slot of `FormField`. -}
hintStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintStateLayer =
    hint_core


{-| Place a `Slide` in the `hint` slot of `FormField`. -}
hintSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintSlide =
    hint_core


{-| Place a `ScrollContainer` in the `hint` slot of `FormField`. -}
hintScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintScrollContainer =
    hint_core


{-| Place a `Ripple` in the `hint` slot of `FormField`. -}
hintRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintRipple =
    hint_core


{-| Place a `PseudoRadio` in the `hint` slot of `FormField`. -}
hintPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintPseudoRadio =
    hint_core


{-| Place a `PseudoCheckbox` in the `hint` slot of `FormField`. -}
hintPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintPseudoCheckbox =
    hint_core


{-| Place a `FocusRing` in the `hint` slot of `FormField`. -}
hintFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintFocusRing =
    hint_core


{-| Place a `Elevation` in the `hint` slot of `FormField`. -}
hintElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintElevation =
    hint_core


{-| Place a `Collapsible` in the `hint` slot of `FormField`. -}
hintCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintCollapsible =
    hint_core


{-| Place a `ActionElementBase` in the `hint` slot of `FormField`. -}
hintActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | hint : M3e.Build.Internal.Used
    } msg pk
hintActionElementBase =
    hint_core


{-| Place a `Tree` in the `error` slot of `FormField`. -}
errorTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTree =
    error_core


{-| Place a `TreeItem` in the `error` slot of `FormField`. -}
errorTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTreeItem =
    error_core


{-| Place a `Toolbar` in the `error` slot of `FormField`. -}
errorToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorToolbar =
    error_core


{-| Place a `Toc` in the `error` slot of `FormField`. -}
errorToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorToc =
    error_core


{-| Place a `TocItem` in the `error` slot of `FormField`. -}
errorTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTocItem =
    error_core


{-| Place a `ThemeIcon` in the `error` slot of `FormField`. -}
errorThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorThemeIcon =
    error_core


{-| Place a `Theme` in the `error` slot of `FormField`. -}
errorTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTheme =
    error_core


{-| Place a `TextareaAutosize` in the `error` slot of `FormField`. -}
errorTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTextareaAutosize =
    error_core


{-| Place a `Tabs` in the `error` slot of `FormField`. -}
errorTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTabs =
    error_core


{-| Place a `TabPanel` in the `error` slot of `FormField`. -}
errorTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTabPanel =
    error_core


{-| Place a `Tab` in the `error` slot of `FormField`. -}
errorTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTab =
    error_core


{-| Place a `Switch` in the `error` slot of `FormField`. -}
errorSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSwitch =
    error_core


{-| Place a `StepperReset` in the `error` slot of `FormField`. -}
errorStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStepperReset =
    error_core


{-| Place a `StepperPrevious` in the `error` slot of `FormField`. -}
errorStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStepperPrevious =
    error_core


{-| Place a `Step` in the `error` slot of `FormField`. -}
errorStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStep =
    error_core


{-| Place a `StepPanel` in the `error` slot of `FormField`. -}
errorStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStepPanel =
    error_core


{-| Place a `Stepper` in the `error` slot of `FormField`. -}
errorStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStepper =
    error_core


{-| Place a `SplitPane` in the `error` slot of `FormField`. -}
errorSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSplitPane =
    error_core


{-| Place a `SplitButton` in the `error` slot of `FormField`. -}
errorSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSplitButton =
    error_core


{-| Place a `Snackbar` in the `error` slot of `FormField`. -}
errorSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSnackbar =
    error_core


{-| Place a `Slider` in the `error` slot of `FormField`. -}
errorSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSlider =
    error_core


{-| Place a `SliderThumb` in the `error` slot of `FormField`. -}
errorSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSliderThumb =
    error_core


{-| Place a `SlideGroup` in the `error` slot of `FormField`. -}
errorSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSlideGroup =
    error_core


{-| Place a `Skeleton` in the `error` slot of `FormField`. -}
errorSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSkeleton =
    error_core


{-| Place a `Shape` in the `error` slot of `FormField`. -}
errorShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorShape =
    error_core


{-| Place a `SegmentedButton` in the `error` slot of `FormField`. -}
errorSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSegmentedButton =
    error_core


{-| Place a `ButtonSegment` in the `error` slot of `FormField`. -}
errorButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorButtonSegment =
    error_core


{-| Place a `SearchView` in the `error` slot of `FormField`. -}
errorSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSearchView =
    error_core


{-| Place a `SearchBar` in the `error` slot of `FormField`. -}
errorSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSearchBar =
    error_core


{-| Place a `RadioGroup` in the `error` slot of `FormField`. -}
errorRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorRadioGroup =
    error_core


{-| Place a `Radio` in the `error` slot of `FormField`. -}
errorRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorRadio =
    error_core


{-| Place a `ProgressElementIndicatorBase` in the `error` slot of `FormField`. -}
errorProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorProgressElementIndicatorBase =
    error_core


{-| Place a `Paginator` in the `error` slot of `FormField`. -}
errorPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorPaginator =
    error_core


{-| Place a `Select` in the `error` slot of `FormField`. -}
errorSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSelect =
    error_core


{-| Place a `NavRailToggle` in the `error` slot of `FormField`. -}
errorNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavRailToggle =
    error_core


{-| Place a `NavRail` in the `error` slot of `FormField`. -}
errorNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavRail =
    error_core


{-| Place a `NavMenuItemGroup` in the `error` slot of `FormField`. -}
errorNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavMenuItemGroup =
    error_core


{-| Place a `NavMenu` in the `error` slot of `FormField`. -}
errorNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavMenu =
    error_core


{-| Place a `NavMenuItem` in the `error` slot of `FormField`. -}
errorNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavMenuItem =
    error_core


{-| Place a `NavBar` in the `error` slot of `FormField`. -}
errorNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavBar =
    error_core


{-| Place a `NavItem` in the `error` slot of `FormField`. -}
errorNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorNavItem =
    error_core


{-| Place a `MenuItemRadio` in the `error` slot of `FormField`. -}
errorMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuItemRadio =
    error_core


{-| Place a `MenuItemGroup` in the `error` slot of `FormField`. -}
errorMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuItemGroup =
    error_core


{-| Place a `MenuItemCheckbox` in the `error` slot of `FormField`. -}
errorMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuItemCheckbox =
    error_core


{-| Place a `Menu` in the `error` slot of `FormField`. -}
errorMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenu =
    error_core


{-| Place a `MenuItem` in the `error` slot of `FormField`. -}
errorMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuItem =
    error_core


{-| Place a `MenuTrigger` in the `error` slot of `FormField`. -}
errorMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuTrigger =
    error_core


{-| Place a `MenuItemElementBase` in the `error` slot of `FormField`. -}
errorMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMenuItemElementBase =
    error_core


{-| Place a `LoadingIndicator` in the `error` slot of `FormField`. -}
errorLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorLoadingIndicator =
    error_core


{-| Place a `SelectionList` in the `error` slot of `FormField`. -}
errorSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSelectionList =
    error_core


{-| Place a `ListOption` in the `error` slot of `FormField`. -}
errorListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorListOption =
    error_core


{-| Place a `ActionList` in the `error` slot of `FormField`. -}
errorActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorActionList =
    error_core


{-| Place a `ExpandableListItem` in the `error` slot of `FormField`. -}
errorExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorExpandableListItem =
    error_core


{-| Place a `ListAction` in the `error` slot of `FormField`. -}
errorListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorListAction =
    error_core


{-| Place a `ListItemButton` in the `error` slot of `FormField`. -}
errorListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorListItemButton =
    error_core


{-| Place a `List` in the `error` slot of `FormField`. -}
errorList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorList =
    error_core


{-| Place a `ListItem` in the `error` slot of `FormField`. -}
errorListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorListItem =
    error_core


{-| Place a `Icon` in the `error` slot of `FormField`. -}
errorIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorIcon =
    error_core


{-| Place a `Heading` in the `error` slot of `FormField`. -}
errorHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorHeading =
    error_core


{-| Place a `FabMenuTrigger` in the `error` slot of `FormField`. -}
errorFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFabMenuTrigger =
    error_core


{-| Place a `FabMenu` in the `error` slot of `FormField`. -}
errorFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFabMenu =
    error_core


{-| Place a `Fab` in the `error` slot of `FormField`. -}
errorFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFab =
    error_core


{-| Place a `Accordion` in the `error` slot of `FormField`. -}
errorAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorAccordion =
    error_core


{-| Place a `ExpansionPanel` in the `error` slot of `FormField`. -}
errorExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorExpansionPanel =
    error_core


{-| Place a `ExpansionHeader` in the `error` slot of `FormField`. -}
errorExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorExpansionHeader =
    error_core


{-| Place a `DrawerToggle` in the `error` slot of `FormField`. -}
errorDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDrawerToggle =
    error_core


{-| Place a `DrawerContainer` in the `error` slot of `FormField`. -}
errorDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDrawerContainer =
    error_core


{-| Place a `Divider` in the `error` slot of `FormField`. -}
errorDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDivider =
    error_core


{-| Place a `DialogTrigger` in the `error` slot of `FormField`. -}
errorDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDialogTrigger =
    error_core


{-| Place a `Dialog` in the `error` slot of `FormField`. -}
errorDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDialog =
    error_core


{-| Place a `DialogAction` in the `error` slot of `FormField`. -}
errorDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDialogAction =
    error_core


{-| Place a `DatepickerToggle` in the `error` slot of `FormField`. -}
errorDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDatepickerToggle =
    error_core


{-| Place a `Datepicker` in the `error` slot of `FormField`. -}
errorDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorDatepicker =
    error_core


{-| Place a `ContentPane` in the `error` slot of `FormField`. -}
errorContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorContentPane =
    error_core


{-| Place a `SuggestionChip` in the `error` slot of `FormField`. -}
errorSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSuggestionChip =
    error_core


{-| Place a `InputChipSet` in the `error` slot of `FormField`. -}
errorInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorInputChipSet =
    error_core


{-| Place a `InputChip` in the `error` slot of `FormField`. -}
errorInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorInputChip =
    error_core


{-| Place a `FilterChipSet` in the `error` slot of `FormField`. -}
errorFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFilterChipSet =
    error_core


{-| Place a `FilterChip` in the `error` slot of `FormField`. -}
errorFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFilterChip =
    error_core


{-| Place a `ChipSet` in the `error` slot of `FormField`. -}
errorChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorChipSet =
    error_core


{-| Place a `AssistChip` in the `error` slot of `FormField`. -}
errorAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorAssistChip =
    error_core


{-| Place a `Chip` in the `error` slot of `FormField`. -}
errorChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorChip =
    error_core


{-| Place a `Checkbox` in the `error` slot of `FormField`. -}
errorCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorCheckbox =
    error_core


{-| Place a `Card` in the `error` slot of `FormField`. -}
errorCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorCard =
    error_core


{-| Place a `Calendar` in the `error` slot of `FormField`. -}
errorCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorCalendar =
    error_core


{-| Place a `YearView` in the `error` slot of `FormField`. -}
errorYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorYearView =
    error_core


{-| Place a `MultiYearView` in the `error` slot of `FormField`. -}
errorMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMultiYearView =
    error_core


{-| Place a `MonthView` in the `error` slot of `FormField`. -}
errorMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorMonthView =
    error_core


{-| Place a `Tooltip` in the `error` slot of `FormField`. -}
errorTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTooltip =
    error_core


{-| Place a `RichTooltip` in the `error` slot of `FormField`. -}
errorRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorRichTooltip =
    error_core


{-| Place a `TooltipElementBase` in the `error` slot of `FormField`. -}
errorTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTooltipElementBase =
    error_core


{-| Place a `RichTooltipAction` in the `error` slot of `FormField`. -}
errorRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorRichTooltipAction =
    error_core


{-| Place a `ButtonGroup` in the `error` slot of `FormField`. -}
errorButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorButtonGroup =
    error_core


{-| Place a `IconButton` in the `error` slot of `FormField`. -}
errorIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorIconButton =
    error_core


{-| Place a `Button` in the `error` slot of `FormField`. -}
errorButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorButton =
    error_core


{-| Place a `Breadcrumb` in the `error` slot of `FormField`. -}
errorBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBreadcrumb =
    error_core


{-| Place a `BreadcrumbItem` in the `error` slot of `FormField`. -}
errorBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBreadcrumbItem =
    error_core


{-| Place a `BreadcrumbItemButton` in the `error` slot of `FormField`. -}
errorBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBreadcrumbItemButton =
    error_core


{-| Place a `BottomSheetTrigger` in the `error` slot of `FormField`. -}
errorBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBottomSheetTrigger =
    error_core


{-| Place a `BottomSheet` in the `error` slot of `FormField`. -}
errorBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBottomSheet =
    error_core


{-| Place a `BottomSheetAction` in the `error` slot of `FormField`. -}
errorBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBottomSheetAction =
    error_core


{-| Place a `Badge` in the `error` slot of `FormField`. -}
errorBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorBadge =
    error_core


{-| Place a `Avatar` in the `error` slot of `FormField`. -}
errorAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorAvatar =
    error_core


{-| Place a `Autocomplete` in the `error` slot of `FormField`. -}
errorAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorAutocomplete =
    error_core


{-| Place a `FormField` in the `error` slot of `FormField`. -}
errorFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFormField =
    error_core


{-| Place a `OptionPanel` in the `error` slot of `FormField`. -}
errorOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorOptionPanel =
    error_core


{-| Place a `FloatingPanel` in the `error` slot of `FormField`. -}
errorFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFloatingPanel =
    error_core


{-| Place a `Optgroup` in the `error` slot of `FormField`. -}
errorOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorOptgroup =
    error_core


{-| Place a `Option` in the `error` slot of `FormField`. -}
errorOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorOption =
    error_core


{-| Place a `FocusTrap` in the `error` slot of `FormField`. -}
errorFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFocusTrap =
    error_core


{-| Place a `AppBar` in the `error` slot of `FormField`. -}
errorAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorAppBar =
    error_core


{-| Place a `TextOverflow` in the `error` slot of `FormField`. -}
errorTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTextOverflow =
    error_core


{-| Place a `TextHighlight` in the `error` slot of `FormField`. -}
errorTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorTextHighlight =
    error_core


{-| Place a `StateLayer` in the `error` slot of `FormField`. -}
errorStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorStateLayer =
    error_core


{-| Place a `Slide` in the `error` slot of `FormField`. -}
errorSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorSlide =
    error_core


{-| Place a `ScrollContainer` in the `error` slot of `FormField`. -}
errorScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorScrollContainer =
    error_core


{-| Place a `Ripple` in the `error` slot of `FormField`. -}
errorRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorRipple =
    error_core


{-| Place a `PseudoRadio` in the `error` slot of `FormField`. -}
errorPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorPseudoRadio =
    error_core


{-| Place a `PseudoCheckbox` in the `error` slot of `FormField`. -}
errorPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorPseudoCheckbox =
    error_core


{-| Place a `FocusRing` in the `error` slot of `FormField`. -}
errorFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorFocusRing =
    error_core


{-| Place a `Elevation` in the `error` slot of `FormField`. -}
errorElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorElevation =
    error_core


{-| Place a `Collapsible` in the `error` slot of `FormField`. -}
errorCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorCollapsible =
    error_core


{-| Place a `ActionElementBase` in the `error` slot of `FormField`. -}
errorActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.FormField.Builder pa { ps
        | error : M3e.Build.Internal.Used
    } msg pk
errorActionElementBase =
    error_core


{-| Place a `Tree` in the `unnamed` slot of `FormField`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tree =
    unnamed_core


{-| Place a `TreeItem` in the `unnamed` slot of `FormField`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
treeItem =
    unnamed_core


{-| Place a `Toolbar` in the `unnamed` slot of `FormField`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
toolbar =
    unnamed_core


{-| Place a `Toc` in the `unnamed` slot of `FormField`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
toc =
    unnamed_core


{-| Place a `TocItem` in the `unnamed` slot of `FormField`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tocItem =
    unnamed_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `FormField`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
themeIcon =
    unnamed_core


{-| Place a `Theme` in the `unnamed` slot of `FormField`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
theme =
    unnamed_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `FormField`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
textareaAutosize =
    unnamed_core


{-| Place a `Tabs` in the `unnamed` slot of `FormField`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tabs =
    unnamed_core


{-| Place a `TabPanel` in the `unnamed` slot of `FormField`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tabPanel =
    unnamed_core


{-| Place a `Tab` in the `unnamed` slot of `FormField`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tab =
    unnamed_core


{-| Place a `Switch` in the `unnamed` slot of `FormField`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
switch =
    unnamed_core


{-| Place a `StepperReset` in the `unnamed` slot of `FormField`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
stepperReset =
    unnamed_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `FormField`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
stepperPrevious =
    unnamed_core


{-| Place a `Step` in the `unnamed` slot of `FormField`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
step =
    unnamed_core


{-| Place a `StepPanel` in the `unnamed` slot of `FormField`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
stepPanel =
    unnamed_core


{-| Place a `Stepper` in the `unnamed` slot of `FormField`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
stepper =
    unnamed_core


{-| Place a `SplitPane` in the `unnamed` slot of `FormField`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
splitPane =
    unnamed_core


{-| Place a `SplitButton` in the `unnamed` slot of `FormField`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
splitButton =
    unnamed_core


{-| Place a `Snackbar` in the `unnamed` slot of `FormField`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
snackbar =
    unnamed_core


{-| Place a `Slider` in the `unnamed` slot of `FormField`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
slider =
    unnamed_core


{-| Place a `SliderThumb` in the `unnamed` slot of `FormField`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
sliderThumb =
    unnamed_core


{-| Place a `SlideGroup` in the `unnamed` slot of `FormField`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
slideGroup =
    unnamed_core


{-| Place a `Skeleton` in the `unnamed` slot of `FormField`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
skeleton =
    unnamed_core


{-| Place a `Shape` in the `unnamed` slot of `FormField`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
shape =
    unnamed_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `FormField`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
segmentedButton =
    unnamed_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `FormField`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
buttonSegment =
    unnamed_core


{-| Place a `SearchView` in the `unnamed` slot of `FormField`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
searchView =
    unnamed_core


{-| Place a `SearchBar` in the `unnamed` slot of `FormField`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
searchBar =
    unnamed_core


{-| Place a `RadioGroup` in the `unnamed` slot of `FormField`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
radioGroup =
    unnamed_core


{-| Place a `Radio` in the `unnamed` slot of `FormField`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
radio =
    unnamed_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `FormField`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
progressElementIndicatorBase =
    unnamed_core


{-| Place a `Paginator` in the `unnamed` slot of `FormField`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
paginator =
    unnamed_core


{-| Place a `Select` in the `unnamed` slot of `FormField`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
select =
    unnamed_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `FormField`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navRailToggle =
    unnamed_core


{-| Place a `NavRail` in the `unnamed` slot of `FormField`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navRail =
    unnamed_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `FormField`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navMenuItemGroup =
    unnamed_core


{-| Place a `NavMenu` in the `unnamed` slot of `FormField`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navMenu =
    unnamed_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `FormField`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navMenuItem =
    unnamed_core


{-| Place a `NavBar` in the `unnamed` slot of `FormField`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navBar =
    unnamed_core


{-| Place a `NavItem` in the `unnamed` slot of `FormField`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
navItem =
    unnamed_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `FormField`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuItemRadio =
    unnamed_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `FormField`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuItemGroup =
    unnamed_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `FormField`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuItemCheckbox =
    unnamed_core


{-| Place a `Menu` in the `unnamed` slot of `FormField`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menu =
    unnamed_core


{-| Place a `MenuItem` in the `unnamed` slot of `FormField`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuItem =
    unnamed_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `FormField`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuTrigger =
    unnamed_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `FormField`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
menuItemElementBase =
    unnamed_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `FormField`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
loadingIndicator =
    unnamed_core


{-| Place a `SelectionList` in the `unnamed` slot of `FormField`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
selectionList =
    unnamed_core


{-| Place a `ListOption` in the `unnamed` slot of `FormField`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
listOption =
    unnamed_core


{-| Place a `ActionList` in the `unnamed` slot of `FormField`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
actionList =
    unnamed_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `FormField`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
expandableListItem =
    unnamed_core


{-| Place a `ListAction` in the `unnamed` slot of `FormField`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
listAction =
    unnamed_core


{-| Place a `ListItemButton` in the `unnamed` slot of `FormField`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
listItemButton =
    unnamed_core


{-| Place a `List` in the `unnamed` slot of `FormField`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
list =
    unnamed_core


{-| Place a `ListItem` in the `unnamed` slot of `FormField`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
listItem =
    unnamed_core


{-| Place a `Icon` in the `unnamed` slot of `FormField`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
icon =
    unnamed_core


{-| Place a `Heading` in the `unnamed` slot of `FormField`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
heading =
    unnamed_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `FormField`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
fabMenuTrigger =
    unnamed_core


{-| Place a `FabMenu` in the `unnamed` slot of `FormField`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
fabMenu =
    unnamed_core


{-| Place a `Fab` in the `unnamed` slot of `FormField`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
fab =
    unnamed_core


{-| Place a `Accordion` in the `unnamed` slot of `FormField`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
accordion =
    unnamed_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `FormField`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
expansionPanel =
    unnamed_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `FormField`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
expansionHeader =
    unnamed_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `FormField`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
drawerToggle =
    unnamed_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `FormField`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
drawerContainer =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `FormField`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
divider =
    unnamed_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `FormField`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
dialogTrigger =
    unnamed_core


{-| Place a `Dialog` in the `unnamed` slot of `FormField`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
dialog =
    unnamed_core


{-| Place a `DialogAction` in the `unnamed` slot of `FormField`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
dialogAction =
    unnamed_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `FormField`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
datepickerToggle =
    unnamed_core


{-| Place a `Datepicker` in the `unnamed` slot of `FormField`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
datepicker =
    unnamed_core


{-| Place a `ContentPane` in the `unnamed` slot of `FormField`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
contentPane =
    unnamed_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `FormField`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
suggestionChip =
    unnamed_core


{-| Place a `InputChipSet` in the `unnamed` slot of `FormField`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
inputChipSet =
    unnamed_core


{-| Place a `InputChip` in the `unnamed` slot of `FormField`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
inputChip =
    unnamed_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `FormField`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
filterChipSet =
    unnamed_core


{-| Place a `FilterChip` in the `unnamed` slot of `FormField`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
filterChip =
    unnamed_core


{-| Place a `ChipSet` in the `unnamed` slot of `FormField`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
chipSet =
    unnamed_core


{-| Place a `AssistChip` in the `unnamed` slot of `FormField`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
assistChip =
    unnamed_core


{-| Place a `Chip` in the `unnamed` slot of `FormField`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
chip =
    unnamed_core


{-| Place a `Checkbox` in the `unnamed` slot of `FormField`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
checkbox =
    unnamed_core


{-| Place a `Card` in the `unnamed` slot of `FormField`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
card =
    unnamed_core


{-| Place a `Calendar` in the `unnamed` slot of `FormField`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
calendar =
    unnamed_core


{-| Place a `YearView` in the `unnamed` slot of `FormField`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
yearView =
    unnamed_core


{-| Place a `MultiYearView` in the `unnamed` slot of `FormField`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
multiYearView =
    unnamed_core


{-| Place a `MonthView` in the `unnamed` slot of `FormField`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
monthView =
    unnamed_core


{-| Place a `Tooltip` in the `unnamed` slot of `FormField`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tooltip =
    unnamed_core


{-| Place a `RichTooltip` in the `unnamed` slot of `FormField`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
richTooltip =
    unnamed_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `FormField`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
tooltipElementBase =
    unnamed_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `FormField`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
richTooltipAction =
    unnamed_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `FormField`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
buttonGroup =
    unnamed_core


{-| Place a `IconButton` in the `unnamed` slot of `FormField`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
iconButton =
    unnamed_core


{-| Place a `Button` in the `unnamed` slot of `FormField`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
button =
    unnamed_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `FormField`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
breadcrumb =
    unnamed_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `FormField`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
breadcrumbItem =
    unnamed_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `FormField`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
breadcrumbItemButton =
    unnamed_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `FormField`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
bottomSheetTrigger =
    unnamed_core


{-| Place a `BottomSheet` in the `unnamed` slot of `FormField`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
bottomSheet =
    unnamed_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `FormField`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
bottomSheetAction =
    unnamed_core


{-| Place a `Badge` in the `unnamed` slot of `FormField`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
badge =
    unnamed_core


{-| Place a `Avatar` in the `unnamed` slot of `FormField`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
avatar =
    unnamed_core


{-| Place a `Autocomplete` in the `unnamed` slot of `FormField`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
autocomplete =
    unnamed_core


{-| Place a `FormField` in the `unnamed` slot of `FormField`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
formField =
    unnamed_core


{-| Place a `OptionPanel` in the `unnamed` slot of `FormField`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
optionPanel =
    unnamed_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `FormField`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
floatingPanel =
    unnamed_core


{-| Place a `Optgroup` in the `unnamed` slot of `FormField`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `FormField`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
option =
    unnamed_core


{-| Place a `FocusTrap` in the `unnamed` slot of `FormField`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
focusTrap =
    unnamed_core


{-| Place a `AppBar` in the `unnamed` slot of `FormField`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
appBar =
    unnamed_core


{-| Place a `TextOverflow` in the `unnamed` slot of `FormField`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
textOverflow =
    unnamed_core


{-| Place a `TextHighlight` in the `unnamed` slot of `FormField`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
textHighlight =
    unnamed_core


{-| Place a `StateLayer` in the `unnamed` slot of `FormField`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
stateLayer =
    unnamed_core


{-| Place a `Slide` in the `unnamed` slot of `FormField`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
slide =
    unnamed_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `FormField`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
scrollContainer =
    unnamed_core


{-| Place a `Ripple` in the `unnamed` slot of `FormField`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
ripple =
    unnamed_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `FormField`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
pseudoRadio =
    unnamed_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `FormField`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
pseudoCheckbox =
    unnamed_core


{-| Place a `FocusRing` in the `unnamed` slot of `FormField`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
focusRing =
    unnamed_core


{-| Place a `Elevation` in the `unnamed` slot of `FormField`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
elevation =
    unnamed_core


{-| Place a `Collapsible` in the `unnamed` slot of `FormField`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
collapsible =
    unnamed_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `FormField`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
actionElementBase =
    unnamed_core