module M3e.Build.Card.Slots exposing
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, headerTree, headerTreeItem
    , headerToolbar, headerToc, headerTocItem, headerThemeIcon, headerTheme, headerTextareaAutosize, headerTabs
    , headerTabPanel, headerTab, headerSwitch, headerStepperReset, headerStepperPrevious, headerStep, headerStepPanel
    , headerStepper, headerSplitPane, headerSplitButton, headerSnackbar, headerSlider, headerSliderThumb, headerSlideGroup
    , headerSkeleton, headerShape, headerSegmentedButton, headerButtonSegment, headerSearchView, headerSearchBar, headerRadioGroup
    , headerRadio, headerProgressElementIndicatorBase, headerPaginator, headerSelect, headerNavRailToggle, headerNavRail, headerNavMenuItemGroup
    , headerNavMenu, headerNavMenuItem, headerNavBar, headerNavItem, headerMenuItemRadio, headerMenuItemGroup, headerMenuItemCheckbox
    , headerMenu, headerMenuItem, headerMenuTrigger, headerMenuItemElementBase, headerLoadingIndicator, headerSelectionList, headerListOption
    , headerActionList, headerExpandableListItem, headerListAction, headerListItemButton, headerList, headerListItem, headerIcon
    , headerHeading, headerFabMenuTrigger, headerFabMenu, headerFab, headerAccordion, headerExpansionPanel, headerExpansionHeader
    , headerDrawerToggle, headerDrawerContainer, headerDivider, headerDialogTrigger, headerDialog, headerDialogAction, headerDatepickerToggle
    , headerDatepicker, headerContentPane, headerSuggestionChip, headerInputChipSet, headerInputChip, headerFilterChipSet, headerFilterChip
    , headerChipSet, headerAssistChip, headerChip, headerCheckbox, headerCard, headerCalendar, headerYearView
    , headerMultiYearView, headerMonthView, headerTooltip, headerRichTooltip, headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup
    , headerIconButton, headerButton, headerBreadcrumb, headerBreadcrumbItem, headerBreadcrumbItemButton, headerBottomSheetTrigger, headerBottomSheet
    , headerBottomSheetAction, headerBadge, headerAvatar, headerAutocomplete, headerFormField, headerOptionPanel, headerFloatingPanel
    , headerOptgroup, headerOption, headerFocusTrap, headerAppBar, headerTextOverflow, headerTextHighlight, headerStateLayer
    , headerSlide, headerScrollContainer, headerRipple, headerPseudoRadio, headerPseudoCheckbox, headerFocusRing, headerElevation
    , headerCollapsible, headerActionElementBase, contentTree, contentTreeItem, contentToolbar, contentToc, contentTocItem
    , contentThemeIcon, contentTheme, contentTextareaAutosize, contentTabs, contentTabPanel, contentTab, contentSwitch
    , contentStepperReset, contentStepperPrevious, contentStep, contentStepPanel, contentStepper, contentSplitPane, contentSplitButton
    , contentSnackbar, contentSlider, contentSliderThumb, contentSlideGroup, contentSkeleton, contentShape, contentSegmentedButton
    , contentButtonSegment, contentSearchView, contentSearchBar, contentRadioGroup, contentRadio, contentProgressElementIndicatorBase, contentPaginator
    , contentSelect, contentNavRailToggle, contentNavRail, contentNavMenuItemGroup, contentNavMenu, contentNavMenuItem, contentNavBar
    , contentNavItem, contentMenuItemRadio, contentMenuItemGroup, contentMenuItemCheckbox, contentMenu, contentMenuItem, contentMenuTrigger
    , contentMenuItemElementBase, contentLoadingIndicator, contentSelectionList, contentListOption, contentActionList, contentExpandableListItem, contentListAction
    , contentListItemButton, contentList, contentListItem, contentIcon, contentHeading, contentFabMenuTrigger, contentFabMenu
    , contentFab, contentAccordion, contentExpansionPanel, contentExpansionHeader, contentDrawerToggle, contentDrawerContainer, contentDivider
    , contentDialogTrigger, contentDialog, contentDialogAction, contentDatepickerToggle, contentDatepicker, contentContentPane, contentSuggestionChip
    , contentInputChipSet, contentInputChip, contentFilterChipSet, contentFilterChip, contentChipSet, contentAssistChip, contentChip
    , contentCheckbox, contentCard, contentCalendar, contentYearView, contentMultiYearView, contentMonthView, contentTooltip
    , contentRichTooltip, contentTooltipElementBase, contentRichTooltipAction, contentButtonGroup, contentIconButton, contentButton, contentBreadcrumb
    , contentBreadcrumbItem, contentBreadcrumbItemButton, contentBottomSheetTrigger, contentBottomSheet, contentBottomSheetAction, contentBadge, contentAvatar
    , contentAutocomplete, contentFormField, contentOptionPanel, contentFloatingPanel, contentOptgroup, contentOption, contentFocusTrap
    , contentAppBar, contentTextOverflow, contentTextHighlight, contentStateLayer, contentSlide, contentScrollContainer, contentRipple
    , contentPseudoRadio, contentPseudoCheckbox, contentFocusRing, contentElevation, contentCollapsible, contentActionElementBase, actionsTree
    , actionsTreeItem, actionsToolbar, actionsToc, actionsTocItem, actionsThemeIcon, actionsTheme, actionsTextareaAutosize
    , actionsTabs, actionsTabPanel, actionsTab, actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep
    , actionsStepPanel, actionsStepper, actionsSplitPane, actionsSplitButton, actionsSnackbar, actionsSlider, actionsSliderThumb
    , actionsSlideGroup, actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment, actionsSearchView, actionsSearchBar
    , actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator, actionsSelect, actionsNavRailToggle, actionsNavRail
    , actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem, actionsNavBar, actionsNavItem, actionsMenuItemRadio, actionsMenuItemGroup
    , actionsMenuItemCheckbox, actionsMenu, actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList
    , actionsListOption, actionsActionList, actionsExpandableListItem, actionsListAction, actionsListItemButton, actionsList, actionsListItem
    , actionsIcon, actionsHeading, actionsFabMenuTrigger, actionsFabMenu, actionsFab, actionsAccordion, actionsExpansionPanel
    , actionsExpansionHeader, actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger, actionsDialog, actionsDialogAction
    , actionsDatepickerToggle, actionsDatepicker, actionsContentPane, actionsSuggestionChip, actionsInputChipSet, actionsInputChip, actionsFilterChipSet
    , actionsFilterChip, actionsChipSet, actionsAssistChip, actionsChip, actionsCheckbox, actionsCard, actionsCalendar
    , actionsYearView, actionsMultiYearView, actionsMonthView, actionsTooltip, actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction
    , actionsButtonGroup, actionsIconButton, actionsButton, actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger
    , actionsBottomSheet, actionsBottomSheetAction, actionsBadge, actionsAvatar, actionsAutocomplete, actionsFormField, actionsOptionPanel
    , actionsFloatingPanel, actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar, actionsTextOverflow, actionsTextHighlight
    , actionsStateLayer, actionsSlide, actionsScrollContainer, actionsRipple, actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing
    , actionsElevation, actionsCollapsible, actionsActionElementBase, footerTree, footerTreeItem, footerToolbar, footerToc
    , footerTocItem, footerThemeIcon, footerTheme, footerTextareaAutosize, footerTabs, footerTabPanel, footerTab
    , footerSwitch, footerStepperReset, footerStepperPrevious, footerStep, footerStepPanel, footerStepper, footerSplitPane
    , footerSplitButton, footerSnackbar, footerSlider, footerSliderThumb, footerSlideGroup, footerSkeleton, footerShape
    , footerSegmentedButton, footerButtonSegment, footerSearchView, footerSearchBar, footerRadioGroup, footerRadio, footerProgressElementIndicatorBase
    , footerPaginator, footerSelect, footerNavRailToggle, footerNavRail, footerNavMenuItemGroup, footerNavMenu, footerNavMenuItem
    , footerNavBar, footerNavItem, footerMenuItemRadio, footerMenuItemGroup, footerMenuItemCheckbox, footerMenu, footerMenuItem
    , footerMenuTrigger, footerMenuItemElementBase, footerLoadingIndicator, footerSelectionList, footerListOption, footerActionList, footerExpandableListItem
    , footerListAction, footerListItemButton, footerList, footerListItem, footerIcon, footerHeading, footerFabMenuTrigger
    , footerFabMenu, footerFab, footerAccordion, footerExpansionPanel, footerExpansionHeader, footerDrawerToggle, footerDrawerContainer
    , footerDivider, footerDialogTrigger, footerDialog, footerDialogAction, footerDatepickerToggle, footerDatepicker, footerContentPane
    , footerSuggestionChip, footerInputChipSet, footerInputChip, footerFilterChipSet, footerFilterChip, footerChipSet, footerAssistChip
    , footerChip, footerCheckbox, footerCard, footerCalendar, footerYearView, footerMultiYearView, footerMonthView
    , footerTooltip, footerRichTooltip, footerTooltipElementBase, footerRichTooltipAction, footerButtonGroup, footerIconButton, footerButton
    , footerBreadcrumb, footerBreadcrumbItem, footerBreadcrumbItemButton, footerBottomSheetTrigger, footerBottomSheet, footerBottomSheetAction, footerBadge
    , footerAvatar, footerAutocomplete, footerFormField, footerOptionPanel, footerFloatingPanel, footerOptgroup, footerOption
    , footerFocusTrap, footerAppBar, footerTextOverflow, footerTextHighlight, footerStateLayer, footerSlide, footerScrollContainer
    , footerRipple, footerPseudoRadio, footerPseudoCheckbox, footerFocusRing, footerElevation, footerCollapsible, footerActionElementBase
    )

{-|
Slot setters for `M3e.Build.Card`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs elevation, collapsible, actionElementBase, headerTree, headerTreeItem, headerToolbar
@docs headerToc, headerTocItem, headerThemeIcon, headerTheme, headerTextareaAutosize, headerTabs
@docs headerTabPanel, headerTab, headerSwitch, headerStepperReset, headerStepperPrevious, headerStep
@docs headerStepPanel, headerStepper, headerSplitPane, headerSplitButton, headerSnackbar, headerSlider
@docs headerSliderThumb, headerSlideGroup, headerSkeleton, headerShape, headerSegmentedButton, headerButtonSegment
@docs headerSearchView, headerSearchBar, headerRadioGroup, headerRadio, headerProgressElementIndicatorBase, headerPaginator
@docs headerSelect, headerNavRailToggle, headerNavRail, headerNavMenuItemGroup, headerNavMenu, headerNavMenuItem
@docs headerNavBar, headerNavItem, headerMenuItemRadio, headerMenuItemGroup, headerMenuItemCheckbox, headerMenu
@docs headerMenuItem, headerMenuTrigger, headerMenuItemElementBase, headerLoadingIndicator, headerSelectionList, headerListOption
@docs headerActionList, headerExpandableListItem, headerListAction, headerListItemButton, headerList, headerListItem
@docs headerIcon, headerHeading, headerFabMenuTrigger, headerFabMenu, headerFab, headerAccordion
@docs headerExpansionPanel, headerExpansionHeader, headerDrawerToggle, headerDrawerContainer, headerDivider, headerDialogTrigger
@docs headerDialog, headerDialogAction, headerDatepickerToggle, headerDatepicker, headerContentPane, headerSuggestionChip
@docs headerInputChipSet, headerInputChip, headerFilterChipSet, headerFilterChip, headerChipSet, headerAssistChip
@docs headerChip, headerCheckbox, headerCard, headerCalendar, headerYearView, headerMultiYearView
@docs headerMonthView, headerTooltip, headerRichTooltip, headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup
@docs headerIconButton, headerButton, headerBreadcrumb, headerBreadcrumbItem, headerBreadcrumbItemButton, headerBottomSheetTrigger
@docs headerBottomSheet, headerBottomSheetAction, headerBadge, headerAvatar, headerAutocomplete, headerFormField
@docs headerOptionPanel, headerFloatingPanel, headerOptgroup, headerOption, headerFocusTrap, headerAppBar
@docs headerTextOverflow, headerTextHighlight, headerStateLayer, headerSlide, headerScrollContainer, headerRipple
@docs headerPseudoRadio, headerPseudoCheckbox, headerFocusRing, headerElevation, headerCollapsible, headerActionElementBase
@docs contentTree, contentTreeItem, contentToolbar, contentToc, contentTocItem, contentThemeIcon
@docs contentTheme, contentTextareaAutosize, contentTabs, contentTabPanel, contentTab, contentSwitch
@docs contentStepperReset, contentStepperPrevious, contentStep, contentStepPanel, contentStepper, contentSplitPane
@docs contentSplitButton, contentSnackbar, contentSlider, contentSliderThumb, contentSlideGroup, contentSkeleton
@docs contentShape, contentSegmentedButton, contentButtonSegment, contentSearchView, contentSearchBar, contentRadioGroup
@docs contentRadio, contentProgressElementIndicatorBase, contentPaginator, contentSelect, contentNavRailToggle, contentNavRail
@docs contentNavMenuItemGroup, contentNavMenu, contentNavMenuItem, contentNavBar, contentNavItem, contentMenuItemRadio
@docs contentMenuItemGroup, contentMenuItemCheckbox, contentMenu, contentMenuItem, contentMenuTrigger, contentMenuItemElementBase
@docs contentLoadingIndicator, contentSelectionList, contentListOption, contentActionList, contentExpandableListItem, contentListAction
@docs contentListItemButton, contentList, contentListItem, contentIcon, contentHeading, contentFabMenuTrigger
@docs contentFabMenu, contentFab, contentAccordion, contentExpansionPanel, contentExpansionHeader, contentDrawerToggle
@docs contentDrawerContainer, contentDivider, contentDialogTrigger, contentDialog, contentDialogAction, contentDatepickerToggle
@docs contentDatepicker, contentContentPane, contentSuggestionChip, contentInputChipSet, contentInputChip, contentFilterChipSet
@docs contentFilterChip, contentChipSet, contentAssistChip, contentChip, contentCheckbox, contentCard
@docs contentCalendar, contentYearView, contentMultiYearView, contentMonthView, contentTooltip, contentRichTooltip
@docs contentTooltipElementBase, contentRichTooltipAction, contentButtonGroup, contentIconButton, contentButton, contentBreadcrumb
@docs contentBreadcrumbItem, contentBreadcrumbItemButton, contentBottomSheetTrigger, contentBottomSheet, contentBottomSheetAction, contentBadge
@docs contentAvatar, contentAutocomplete, contentFormField, contentOptionPanel, contentFloatingPanel, contentOptgroup
@docs contentOption, contentFocusTrap, contentAppBar, contentTextOverflow, contentTextHighlight, contentStateLayer
@docs contentSlide, contentScrollContainer, contentRipple, contentPseudoRadio, contentPseudoCheckbox, contentFocusRing
@docs contentElevation, contentCollapsible, contentActionElementBase, actionsTree, actionsTreeItem, actionsToolbar
@docs actionsToc, actionsTocItem, actionsThemeIcon, actionsTheme, actionsTextareaAutosize, actionsTabs
@docs actionsTabPanel, actionsTab, actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep
@docs actionsStepPanel, actionsStepper, actionsSplitPane, actionsSplitButton, actionsSnackbar, actionsSlider
@docs actionsSliderThumb, actionsSlideGroup, actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment
@docs actionsSearchView, actionsSearchBar, actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator
@docs actionsSelect, actionsNavRailToggle, actionsNavRail, actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem
@docs actionsNavBar, actionsNavItem, actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu
@docs actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList, actionsListOption
@docs actionsActionList, actionsExpandableListItem, actionsListAction, actionsListItemButton, actionsList, actionsListItem
@docs actionsIcon, actionsHeading, actionsFabMenuTrigger, actionsFabMenu, actionsFab, actionsAccordion
@docs actionsExpansionPanel, actionsExpansionHeader, actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger
@docs actionsDialog, actionsDialogAction, actionsDatepickerToggle, actionsDatepicker, actionsContentPane, actionsSuggestionChip
@docs actionsInputChipSet, actionsInputChip, actionsFilterChipSet, actionsFilterChip, actionsChipSet, actionsAssistChip
@docs actionsChip, actionsCheckbox, actionsCard, actionsCalendar, actionsYearView, actionsMultiYearView
@docs actionsMonthView, actionsTooltip, actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup
@docs actionsIconButton, actionsButton, actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger
@docs actionsBottomSheet, actionsBottomSheetAction, actionsBadge, actionsAvatar, actionsAutocomplete, actionsFormField
@docs actionsOptionPanel, actionsFloatingPanel, actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar
@docs actionsTextOverflow, actionsTextHighlight, actionsStateLayer, actionsSlide, actionsScrollContainer, actionsRipple
@docs actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase
@docs footerTree, footerTreeItem, footerToolbar, footerToc, footerTocItem, footerThemeIcon
@docs footerTheme, footerTextareaAutosize, footerTabs, footerTabPanel, footerTab, footerSwitch
@docs footerStepperReset, footerStepperPrevious, footerStep, footerStepPanel, footerStepper, footerSplitPane
@docs footerSplitButton, footerSnackbar, footerSlider, footerSliderThumb, footerSlideGroup, footerSkeleton
@docs footerShape, footerSegmentedButton, footerButtonSegment, footerSearchView, footerSearchBar, footerRadioGroup
@docs footerRadio, footerProgressElementIndicatorBase, footerPaginator, footerSelect, footerNavRailToggle, footerNavRail
@docs footerNavMenuItemGroup, footerNavMenu, footerNavMenuItem, footerNavBar, footerNavItem, footerMenuItemRadio
@docs footerMenuItemGroup, footerMenuItemCheckbox, footerMenu, footerMenuItem, footerMenuTrigger, footerMenuItemElementBase
@docs footerLoadingIndicator, footerSelectionList, footerListOption, footerActionList, footerExpandableListItem, footerListAction
@docs footerListItemButton, footerList, footerListItem, footerIcon, footerHeading, footerFabMenuTrigger
@docs footerFabMenu, footerFab, footerAccordion, footerExpansionPanel, footerExpansionHeader, footerDrawerToggle
@docs footerDrawerContainer, footerDivider, footerDialogTrigger, footerDialog, footerDialogAction, footerDatepickerToggle
@docs footerDatepicker, footerContentPane, footerSuggestionChip, footerInputChipSet, footerInputChip, footerFilterChipSet
@docs footerFilterChip, footerChipSet, footerAssistChip, footerChip, footerCheckbox, footerCard
@docs footerCalendar, footerYearView, footerMultiYearView, footerMonthView, footerTooltip, footerRichTooltip
@docs footerTooltipElementBase, footerRichTooltipAction, footerButtonGroup, footerIconButton, footerButton, footerBreadcrumb
@docs footerBreadcrumbItem, footerBreadcrumbItemButton, footerBottomSheetTrigger, footerBottomSheet, footerBottomSheetAction, footerBadge
@docs footerAvatar, footerAutocomplete, footerFormField, footerOptionPanel, footerFloatingPanel, footerOptgroup
@docs footerOption, footerFocusTrap, footerAppBar, footerTextOverflow, footerTextHighlight, footerStateLayer
@docs footerSlide, footerScrollContainer, footerRipple, footerPseudoRadio, footerPseudoCheckbox, footerFocusRing
@docs footerElevation, footerCollapsible, footerActionElementBase
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


default_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


header_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
header_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


content_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
content_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


actions_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actions_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


footer_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footer_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `Card`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tree =
    default_core


{-| Place a `TreeItem` in the `unnamed` slot of `Card`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
treeItem =
    default_core


{-| Place a `Toolbar` in the `unnamed` slot of `Card`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toolbar =
    default_core


{-| Place a `Toc` in the `unnamed` slot of `Card`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toc =
    default_core


{-| Place a `TocItem` in the `unnamed` slot of `Card`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tocItem =
    default_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `Card`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
themeIcon =
    default_core


{-| Place a `Theme` in the `unnamed` slot of `Card`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
theme =
    default_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `Card`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textareaAutosize =
    default_core


{-| Place a `Tabs` in the `unnamed` slot of `Card`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabs =
    default_core


{-| Place a `TabPanel` in the `unnamed` slot of `Card`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabPanel =
    default_core


{-| Place a `Tab` in the `unnamed` slot of `Card`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tab =
    default_core


{-| Place a `Switch` in the `unnamed` slot of `Card`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
switch =
    default_core


{-| Place a `StepperReset` in the `unnamed` slot of `Card`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `Card`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    default_core


{-| Place a `Step` in the `unnamed` slot of `Card`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
step =
    default_core


{-| Place a `StepPanel` in the `unnamed` slot of `Card`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepPanel =
    default_core


{-| Place a `Stepper` in the `unnamed` slot of `Card`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepper =
    default_core


{-| Place a `SplitPane` in the `unnamed` slot of `Card`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitPane =
    default_core


{-| Place a `SplitButton` in the `unnamed` slot of `Card`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitButton =
    default_core


{-| Place a `Snackbar` in the `unnamed` slot of `Card`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
snackbar =
    default_core


{-| Place a `Slider` in the `unnamed` slot of `Card`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slider =
    default_core


{-| Place a `SliderThumb` in the `unnamed` slot of `Card`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
sliderThumb =
    default_core


{-| Place a `SlideGroup` in the `unnamed` slot of `Card`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slideGroup =
    default_core


{-| Place a `Skeleton` in the `unnamed` slot of `Card`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
skeleton =
    default_core


{-| Place a `Shape` in the `unnamed` slot of `Card`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
shape =
    default_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `Card`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
segmentedButton =
    default_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `Card`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonSegment =
    default_core


{-| Place a `SearchView` in the `unnamed` slot of `Card`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchView =
    default_core


{-| Place a `SearchBar` in the `unnamed` slot of `Card`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchBar =
    default_core


{-| Place a `RadioGroup` in the `unnamed` slot of `Card`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radioGroup =
    default_core


{-| Place a `Radio` in the `unnamed` slot of `Card`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radio =
    default_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `Card`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
progressElementIndicatorBase =
    default_core


{-| Place a `Paginator` in the `unnamed` slot of `Card`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
paginator =
    default_core


{-| Place a `Select` in the `unnamed` slot of `Card`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
select =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `Card`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    default_core


{-| Place a `NavRail` in the `unnamed` slot of `Card`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRail =
    default_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `Card`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenu` in the `unnamed` slot of `Card`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenu =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `Card`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItem =
    default_core


{-| Place a `NavBar` in the `unnamed` slot of `Card`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navBar =
    default_core


{-| Place a `NavItem` in the `unnamed` slot of `Card`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navItem =
    default_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `Card`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `Card`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `Card`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemCheckbox =
    default_core


{-| Place a `Menu` in the `unnamed` slot of `Card`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menu =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `Card`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItem =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `Card`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    default_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `Card`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemElementBase =
    default_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `Card`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
loadingIndicator =
    default_core


{-| Place a `SelectionList` in the `unnamed` slot of `Card`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
selectionList =
    default_core


{-| Place a `ListOption` in the `unnamed` slot of `Card`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listOption =
    default_core


{-| Place a `ActionList` in the `unnamed` slot of `Card`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionList =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `Card`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `Card`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listAction =
    default_core


{-| Place a `ListItemButton` in the `unnamed` slot of `Card`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItemButton =
    default_core


{-| Place a `List` in the `unnamed` slot of `Card`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
list =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `Card`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItem =
    default_core


{-| Place a `Icon` in the `unnamed` slot of `Card`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
icon =
    default_core


{-| Place a `Heading` in the `unnamed` slot of `Card`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
heading =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `Card`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    default_core


{-| Place a `FabMenu` in the `unnamed` slot of `Card`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenu =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `Card`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fab =
    default_core


{-| Place a `Accordion` in the `unnamed` slot of `Card`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
accordion =
    default_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `Card`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionPanel =
    default_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `Card`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionHeader =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `Card`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    default_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `Card`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerContainer =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `Card`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
divider =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `Card`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    default_core


{-| Place a `Dialog` in the `unnamed` slot of `Card`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialog =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `Card`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `Card`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    default_core


{-| Place a `Datepicker` in the `unnamed` slot of `Card`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepicker =
    default_core


{-| Place a `ContentPane` in the `unnamed` slot of `Card`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
contentPane =
    default_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `Card`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
suggestionChip =
    default_core


{-| Place a `InputChipSet` in the `unnamed` slot of `Card`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    default_core


{-| Place a `InputChip` in the `unnamed` slot of `Card`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChip =
    default_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `Card`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChipSet =
    default_core


{-| Place a `FilterChip` in the `unnamed` slot of `Card`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChip =
    default_core


{-| Place a `ChipSet` in the `unnamed` slot of `Card`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chipSet =
    default_core


{-| Place a `AssistChip` in the `unnamed` slot of `Card`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
assistChip =
    default_core


{-| Place a `Chip` in the `unnamed` slot of `Card`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chip =
    default_core


{-| Place a `Checkbox` in the `unnamed` slot of `Card`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
checkbox =
    default_core


{-| Place a `Card` in the `unnamed` slot of `Card`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
card =
    default_core


{-| Place a `Calendar` in the `unnamed` slot of `Card`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
calendar =
    default_core


{-| Place a `YearView` in the `unnamed` slot of `Card`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
yearView =
    default_core


{-| Place a `MultiYearView` in the `unnamed` slot of `Card`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
multiYearView =
    default_core


{-| Place a `MonthView` in the `unnamed` slot of `Card`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
monthView =
    default_core


{-| Place a `Tooltip` in the `unnamed` slot of `Card`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltip =
    default_core


{-| Place a `RichTooltip` in the `unnamed` slot of `Card`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltip =
    default_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `Card`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltipElementBase =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `Card`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    default_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `Card`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonGroup =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `Card`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
iconButton =
    default_core


{-| Place a `Button` in the `unnamed` slot of `Card`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
button =
    default_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `Card`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumb =
    default_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `Card`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItem =
    default_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `Card`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItemButton =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `Card`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheet` in the `unnamed` slot of `Card`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheet =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `Card`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    default_core


{-| Place a `Badge` in the `unnamed` slot of `Card`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
badge =
    default_core


{-| Place a `Avatar` in the `unnamed` slot of `Card`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
avatar =
    default_core


{-| Place a `Autocomplete` in the `unnamed` slot of `Card`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
autocomplete =
    default_core


{-| Place a `FormField` in the `unnamed` slot of `Card`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
formField =
    default_core


{-| Place a `OptionPanel` in the `unnamed` slot of `Card`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optionPanel =
    default_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `Card`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
floatingPanel =
    default_core


{-| Place a `Optgroup` in the `unnamed` slot of `Card`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optgroup =
    default_core


{-| Place a `Option` in the `unnamed` slot of `Card`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
option =
    default_core


{-| Place a `FocusTrap` in the `unnamed` slot of `Card`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusTrap =
    default_core


{-| Place a `AppBar` in the `unnamed` slot of `Card`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
appBar =
    default_core


{-| Place a `TextOverflow` in the `unnamed` slot of `Card`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textOverflow =
    default_core


{-| Place a `TextHighlight` in the `unnamed` slot of `Card`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textHighlight =
    default_core


{-| Place a `StateLayer` in the `unnamed` slot of `Card`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stateLayer =
    default_core


{-| Place a `Slide` in the `unnamed` slot of `Card`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slide =
    default_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `Card`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
scrollContainer =
    default_core


{-| Place a `Ripple` in the `unnamed` slot of `Card`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
ripple =
    default_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `Card`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoRadio =
    default_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `Card`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoCheckbox =
    default_core


{-| Place a `FocusRing` in the `unnamed` slot of `Card`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusRing =
    default_core


{-| Place a `Elevation` in the `unnamed` slot of `Card`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
elevation =
    default_core


{-| Place a `Collapsible` in the `unnamed` slot of `Card`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
collapsible =
    default_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `Card`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionElementBase =
    default_core


{-| Place a `Tree` in the `header` slot of `Card`. -}
headerTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTree =
    header_core


{-| Place a `TreeItem` in the `header` slot of `Card`. -}
headerTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTreeItem =
    header_core


{-| Place a `Toolbar` in the `header` slot of `Card`. -}
headerToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToolbar =
    header_core


{-| Place a `Toc` in the `header` slot of `Card`. -}
headerToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToc =
    header_core


{-| Place a `TocItem` in the `header` slot of `Card`. -}
headerTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTocItem =
    header_core


{-| Place a `ThemeIcon` in the `header` slot of `Card`. -}
headerThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerThemeIcon =
    header_core


{-| Place a `Theme` in the `header` slot of `Card`. -}
headerTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTheme =
    header_core


{-| Place a `TextareaAutosize` in the `header` slot of `Card`. -}
headerTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextareaAutosize =
    header_core


{-| Place a `Tabs` in the `header` slot of `Card`. -}
headerTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabs =
    header_core


{-| Place a `TabPanel` in the `header` slot of `Card`. -}
headerTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabPanel =
    header_core


{-| Place a `Tab` in the `header` slot of `Card`. -}
headerTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTab =
    header_core


{-| Place a `Switch` in the `header` slot of `Card`. -}
headerSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSwitch =
    header_core


{-| Place a `StepperReset` in the `header` slot of `Card`. -}
headerStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperReset =
    header_core


{-| Place a `StepperPrevious` in the `header` slot of `Card`. -}
headerStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperPrevious =
    header_core


{-| Place a `Step` in the `header` slot of `Card`. -}
headerStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStep =
    header_core


{-| Place a `StepPanel` in the `header` slot of `Card`. -}
headerStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepPanel =
    header_core


{-| Place a `Stepper` in the `header` slot of `Card`. -}
headerStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepper =
    header_core


{-| Place a `SplitPane` in the `header` slot of `Card`. -}
headerSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitPane =
    header_core


{-| Place a `SplitButton` in the `header` slot of `Card`. -}
headerSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitButton =
    header_core


{-| Place a `Snackbar` in the `header` slot of `Card`. -}
headerSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSnackbar =
    header_core


{-| Place a `Slider` in the `header` slot of `Card`. -}
headerSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlider =
    header_core


{-| Place a `SliderThumb` in the `header` slot of `Card`. -}
headerSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSliderThumb =
    header_core


{-| Place a `SlideGroup` in the `header` slot of `Card`. -}
headerSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlideGroup =
    header_core


{-| Place a `Skeleton` in the `header` slot of `Card`. -}
headerSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSkeleton =
    header_core


{-| Place a `Shape` in the `header` slot of `Card`. -}
headerShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerShape =
    header_core


{-| Place a `SegmentedButton` in the `header` slot of `Card`. -}
headerSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSegmentedButton =
    header_core


{-| Place a `ButtonSegment` in the `header` slot of `Card`. -}
headerButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonSegment =
    header_core


{-| Place a `SearchView` in the `header` slot of `Card`. -}
headerSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchView =
    header_core


{-| Place a `SearchBar` in the `header` slot of `Card`. -}
headerSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchBar =
    header_core


{-| Place a `RadioGroup` in the `header` slot of `Card`. -}
headerRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadioGroup =
    header_core


{-| Place a `Radio` in the `header` slot of `Card`. -}
headerRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadio =
    header_core


{-| Place a `ProgressElementIndicatorBase` in the `header` slot of `Card`. -}
headerProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerProgressElementIndicatorBase =
    header_core


{-| Place a `Paginator` in the `header` slot of `Card`. -}
headerPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPaginator =
    header_core


{-| Place a `Select` in the `header` slot of `Card`. -}
headerSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelect =
    header_core


{-| Place a `NavRailToggle` in the `header` slot of `Card`. -}
headerNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRailToggle =
    header_core


{-| Place a `NavRail` in the `header` slot of `Card`. -}
headerNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRail =
    header_core


{-| Place a `NavMenuItemGroup` in the `header` slot of `Card`. -}
headerNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItemGroup =
    header_core


{-| Place a `NavMenu` in the `header` slot of `Card`. -}
headerNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenu =
    header_core


{-| Place a `NavMenuItem` in the `header` slot of `Card`. -}
headerNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItem =
    header_core


{-| Place a `NavBar` in the `header` slot of `Card`. -}
headerNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavBar =
    header_core


{-| Place a `NavItem` in the `header` slot of `Card`. -}
headerNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavItem =
    header_core


{-| Place a `MenuItemRadio` in the `header` slot of `Card`. -}
headerMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemRadio =
    header_core


{-| Place a `MenuItemGroup` in the `header` slot of `Card`. -}
headerMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemGroup =
    header_core


{-| Place a `MenuItemCheckbox` in the `header` slot of `Card`. -}
headerMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemCheckbox =
    header_core


{-| Place a `Menu` in the `header` slot of `Card`. -}
headerMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenu =
    header_core


{-| Place a `MenuItem` in the `header` slot of `Card`. -}
headerMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItem =
    header_core


{-| Place a `MenuTrigger` in the `header` slot of `Card`. -}
headerMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuTrigger =
    header_core


{-| Place a `MenuItemElementBase` in the `header` slot of `Card`. -}
headerMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemElementBase =
    header_core


{-| Place a `LoadingIndicator` in the `header` slot of `Card`. -}
headerLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerLoadingIndicator =
    header_core


{-| Place a `SelectionList` in the `header` slot of `Card`. -}
headerSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelectionList =
    header_core


{-| Place a `ListOption` in the `header` slot of `Card`. -}
headerListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListOption =
    header_core


{-| Place a `ActionList` in the `header` slot of `Card`. -}
headerActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionList =
    header_core


{-| Place a `ExpandableListItem` in the `header` slot of `Card`. -}
headerExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpandableListItem =
    header_core


{-| Place a `ListAction` in the `header` slot of `Card`. -}
headerListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListAction =
    header_core


{-| Place a `ListItemButton` in the `header` slot of `Card`. -}
headerListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItemButton =
    header_core


{-| Place a `List` in the `header` slot of `Card`. -}
headerList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerList =
    header_core


{-| Place a `ListItem` in the `header` slot of `Card`. -}
headerListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItem =
    header_core


{-| Place a `Icon` in the `header` slot of `Card`. -}
headerIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIcon =
    header_core


{-| Place a `Heading` in the `header` slot of `Card`. -}
headerHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerHeading =
    header_core


{-| Place a `FabMenuTrigger` in the `header` slot of `Card`. -}
headerFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenuTrigger =
    header_core


{-| Place a `FabMenu` in the `header` slot of `Card`. -}
headerFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenu =
    header_core


{-| Place a `Fab` in the `header` slot of `Card`. -}
headerFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFab =
    header_core


{-| Place a `Accordion` in the `header` slot of `Card`. -}
headerAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAccordion =
    header_core


{-| Place a `ExpansionPanel` in the `header` slot of `Card`. -}
headerExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionPanel =
    header_core


{-| Place a `ExpansionHeader` in the `header` slot of `Card`. -}
headerExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionHeader =
    header_core


{-| Place a `DrawerToggle` in the `header` slot of `Card`. -}
headerDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerToggle =
    header_core


{-| Place a `DrawerContainer` in the `header` slot of `Card`. -}
headerDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerContainer =
    header_core


{-| Place a `Divider` in the `header` slot of `Card`. -}
headerDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDivider =
    header_core


{-| Place a `DialogTrigger` in the `header` slot of `Card`. -}
headerDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogTrigger =
    header_core


{-| Place a `Dialog` in the `header` slot of `Card`. -}
headerDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialog =
    header_core


{-| Place a `DialogAction` in the `header` slot of `Card`. -}
headerDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogAction =
    header_core


{-| Place a `DatepickerToggle` in the `header` slot of `Card`. -}
headerDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepickerToggle =
    header_core


{-| Place a `Datepicker` in the `header` slot of `Card`. -}
headerDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepicker =
    header_core


{-| Place a `ContentPane` in the `header` slot of `Card`. -}
headerContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerContentPane =
    header_core


{-| Place a `SuggestionChip` in the `header` slot of `Card`. -}
headerSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSuggestionChip =
    header_core


{-| Place a `InputChipSet` in the `header` slot of `Card`. -}
headerInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChipSet =
    header_core


{-| Place a `InputChip` in the `header` slot of `Card`. -}
headerInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChip =
    header_core


{-| Place a `FilterChipSet` in the `header` slot of `Card`. -}
headerFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChipSet =
    header_core


{-| Place a `FilterChip` in the `header` slot of `Card`. -}
headerFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChip =
    header_core


{-| Place a `ChipSet` in the `header` slot of `Card`. -}
headerChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChipSet =
    header_core


{-| Place a `AssistChip` in the `header` slot of `Card`. -}
headerAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAssistChip =
    header_core


{-| Place a `Chip` in the `header` slot of `Card`. -}
headerChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChip =
    header_core


{-| Place a `Checkbox` in the `header` slot of `Card`. -}
headerCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCheckbox =
    header_core


{-| Place a `Card` in the `header` slot of `Card`. -}
headerCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCard =
    header_core


{-| Place a `Calendar` in the `header` slot of `Card`. -}
headerCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCalendar =
    header_core


{-| Place a `YearView` in the `header` slot of `Card`. -}
headerYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerYearView =
    header_core


{-| Place a `MultiYearView` in the `header` slot of `Card`. -}
headerMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMultiYearView =
    header_core


{-| Place a `MonthView` in the `header` slot of `Card`. -}
headerMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMonthView =
    header_core


{-| Place a `Tooltip` in the `header` slot of `Card`. -}
headerTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltip =
    header_core


{-| Place a `RichTooltip` in the `header` slot of `Card`. -}
headerRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltip =
    header_core


{-| Place a `TooltipElementBase` in the `header` slot of `Card`. -}
headerTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltipElementBase =
    header_core


{-| Place a `RichTooltipAction` in the `header` slot of `Card`. -}
headerRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltipAction =
    header_core


{-| Place a `ButtonGroup` in the `header` slot of `Card`. -}
headerButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonGroup =
    header_core


{-| Place a `IconButton` in the `header` slot of `Card`. -}
headerIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIconButton =
    header_core


{-| Place a `Button` in the `header` slot of `Card`. -}
headerButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButton =
    header_core


{-| Place a `Breadcrumb` in the `header` slot of `Card`. -}
headerBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumb =
    header_core


{-| Place a `BreadcrumbItem` in the `header` slot of `Card`. -}
headerBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItem =
    header_core


{-| Place a `BreadcrumbItemButton` in the `header` slot of `Card`. -}
headerBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItemButton =
    header_core


{-| Place a `BottomSheetTrigger` in the `header` slot of `Card`. -}
headerBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetTrigger =
    header_core


{-| Place a `BottomSheet` in the `header` slot of `Card`. -}
headerBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheet =
    header_core


{-| Place a `BottomSheetAction` in the `header` slot of `Card`. -}
headerBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetAction =
    header_core


{-| Place a `Badge` in the `header` slot of `Card`. -}
headerBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBadge =
    header_core


{-| Place a `Avatar` in the `header` slot of `Card`. -}
headerAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAvatar =
    header_core


{-| Place a `Autocomplete` in the `header` slot of `Card`. -}
headerAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAutocomplete =
    header_core


{-| Place a `FormField` in the `header` slot of `Card`. -}
headerFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFormField =
    header_core


{-| Place a `OptionPanel` in the `header` slot of `Card`. -}
headerOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptionPanel =
    header_core


{-| Place a `FloatingPanel` in the `header` slot of `Card`. -}
headerFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFloatingPanel =
    header_core


{-| Place a `Optgroup` in the `header` slot of `Card`. -}
headerOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptgroup =
    header_core


{-| Place a `Option` in the `header` slot of `Card`. -}
headerOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOption =
    header_core


{-| Place a `FocusTrap` in the `header` slot of `Card`. -}
headerFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusTrap =
    header_core


{-| Place a `AppBar` in the `header` slot of `Card`. -}
headerAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAppBar =
    header_core


{-| Place a `TextOverflow` in the `header` slot of `Card`. -}
headerTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextOverflow =
    header_core


{-| Place a `TextHighlight` in the `header` slot of `Card`. -}
headerTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextHighlight =
    header_core


{-| Place a `StateLayer` in the `header` slot of `Card`. -}
headerStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStateLayer =
    header_core


{-| Place a `Slide` in the `header` slot of `Card`. -}
headerSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlide =
    header_core


{-| Place a `ScrollContainer` in the `header` slot of `Card`. -}
headerScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerScrollContainer =
    header_core


{-| Place a `Ripple` in the `header` slot of `Card`. -}
headerRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRipple =
    header_core


{-| Place a `PseudoRadio` in the `header` slot of `Card`. -}
headerPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoRadio =
    header_core


{-| Place a `PseudoCheckbox` in the `header` slot of `Card`. -}
headerPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoCheckbox =
    header_core


{-| Place a `FocusRing` in the `header` slot of `Card`. -}
headerFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusRing =
    header_core


{-| Place a `Elevation` in the `header` slot of `Card`. -}
headerElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerElevation =
    header_core


{-| Place a `Collapsible` in the `header` slot of `Card`. -}
headerCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCollapsible =
    header_core


{-| Place a `ActionElementBase` in the `header` slot of `Card`. -}
headerActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionElementBase =
    header_core


{-| Place a `Tree` in the `content` slot of `Card`. -}
contentTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTree =
    content_core


{-| Place a `TreeItem` in the `content` slot of `Card`. -}
contentTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTreeItem =
    content_core


{-| Place a `Toolbar` in the `content` slot of `Card`. -}
contentToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentToolbar =
    content_core


{-| Place a `Toc` in the `content` slot of `Card`. -}
contentToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentToc =
    content_core


{-| Place a `TocItem` in the `content` slot of `Card`. -}
contentTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTocItem =
    content_core


{-| Place a `ThemeIcon` in the `content` slot of `Card`. -}
contentThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentThemeIcon =
    content_core


{-| Place a `Theme` in the `content` slot of `Card`. -}
contentTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTheme =
    content_core


{-| Place a `TextareaAutosize` in the `content` slot of `Card`. -}
contentTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTextareaAutosize =
    content_core


{-| Place a `Tabs` in the `content` slot of `Card`. -}
contentTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTabs =
    content_core


{-| Place a `TabPanel` in the `content` slot of `Card`. -}
contentTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTabPanel =
    content_core


{-| Place a `Tab` in the `content` slot of `Card`. -}
contentTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTab =
    content_core


{-| Place a `Switch` in the `content` slot of `Card`. -}
contentSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSwitch =
    content_core


{-| Place a `StepperReset` in the `content` slot of `Card`. -}
contentStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStepperReset =
    content_core


{-| Place a `StepperPrevious` in the `content` slot of `Card`. -}
contentStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStepperPrevious =
    content_core


{-| Place a `Step` in the `content` slot of `Card`. -}
contentStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStep =
    content_core


{-| Place a `StepPanel` in the `content` slot of `Card`. -}
contentStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStepPanel =
    content_core


{-| Place a `Stepper` in the `content` slot of `Card`. -}
contentStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStepper =
    content_core


{-| Place a `SplitPane` in the `content` slot of `Card`. -}
contentSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSplitPane =
    content_core


{-| Place a `SplitButton` in the `content` slot of `Card`. -}
contentSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSplitButton =
    content_core


{-| Place a `Snackbar` in the `content` slot of `Card`. -}
contentSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSnackbar =
    content_core


{-| Place a `Slider` in the `content` slot of `Card`. -}
contentSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSlider =
    content_core


{-| Place a `SliderThumb` in the `content` slot of `Card`. -}
contentSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSliderThumb =
    content_core


{-| Place a `SlideGroup` in the `content` slot of `Card`. -}
contentSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSlideGroup =
    content_core


{-| Place a `Skeleton` in the `content` slot of `Card`. -}
contentSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSkeleton =
    content_core


{-| Place a `Shape` in the `content` slot of `Card`. -}
contentShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentShape =
    content_core


{-| Place a `SegmentedButton` in the `content` slot of `Card`. -}
contentSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSegmentedButton =
    content_core


{-| Place a `ButtonSegment` in the `content` slot of `Card`. -}
contentButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentButtonSegment =
    content_core


{-| Place a `SearchView` in the `content` slot of `Card`. -}
contentSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSearchView =
    content_core


{-| Place a `SearchBar` in the `content` slot of `Card`. -}
contentSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSearchBar =
    content_core


{-| Place a `RadioGroup` in the `content` slot of `Card`. -}
contentRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentRadioGroup =
    content_core


{-| Place a `Radio` in the `content` slot of `Card`. -}
contentRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentRadio =
    content_core


{-| Place a `ProgressElementIndicatorBase` in the `content` slot of `Card`. -}
contentProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentProgressElementIndicatorBase =
    content_core


{-| Place a `Paginator` in the `content` slot of `Card`. -}
contentPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentPaginator =
    content_core


{-| Place a `Select` in the `content` slot of `Card`. -}
contentSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSelect =
    content_core


{-| Place a `NavRailToggle` in the `content` slot of `Card`. -}
contentNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavRailToggle =
    content_core


{-| Place a `NavRail` in the `content` slot of `Card`. -}
contentNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavRail =
    content_core


{-| Place a `NavMenuItemGroup` in the `content` slot of `Card`. -}
contentNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavMenuItemGroup =
    content_core


{-| Place a `NavMenu` in the `content` slot of `Card`. -}
contentNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavMenu =
    content_core


{-| Place a `NavMenuItem` in the `content` slot of `Card`. -}
contentNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavMenuItem =
    content_core


{-| Place a `NavBar` in the `content` slot of `Card`. -}
contentNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavBar =
    content_core


{-| Place a `NavItem` in the `content` slot of `Card`. -}
contentNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentNavItem =
    content_core


{-| Place a `MenuItemRadio` in the `content` slot of `Card`. -}
contentMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuItemRadio =
    content_core


{-| Place a `MenuItemGroup` in the `content` slot of `Card`. -}
contentMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuItemGroup =
    content_core


{-| Place a `MenuItemCheckbox` in the `content` slot of `Card`. -}
contentMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuItemCheckbox =
    content_core


{-| Place a `Menu` in the `content` slot of `Card`. -}
contentMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenu =
    content_core


{-| Place a `MenuItem` in the `content` slot of `Card`. -}
contentMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuItem =
    content_core


{-| Place a `MenuTrigger` in the `content` slot of `Card`. -}
contentMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuTrigger =
    content_core


{-| Place a `MenuItemElementBase` in the `content` slot of `Card`. -}
contentMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMenuItemElementBase =
    content_core


{-| Place a `LoadingIndicator` in the `content` slot of `Card`. -}
contentLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentLoadingIndicator =
    content_core


{-| Place a `SelectionList` in the `content` slot of `Card`. -}
contentSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSelectionList =
    content_core


{-| Place a `ListOption` in the `content` slot of `Card`. -}
contentListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentListOption =
    content_core


{-| Place a `ActionList` in the `content` slot of `Card`. -}
contentActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentActionList =
    content_core


{-| Place a `ExpandableListItem` in the `content` slot of `Card`. -}
contentExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentExpandableListItem =
    content_core


{-| Place a `ListAction` in the `content` slot of `Card`. -}
contentListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentListAction =
    content_core


{-| Place a `ListItemButton` in the `content` slot of `Card`. -}
contentListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentListItemButton =
    content_core


{-| Place a `List` in the `content` slot of `Card`. -}
contentList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentList =
    content_core


{-| Place a `ListItem` in the `content` slot of `Card`. -}
contentListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentListItem =
    content_core


{-| Place a `Icon` in the `content` slot of `Card`. -}
contentIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentIcon =
    content_core


{-| Place a `Heading` in the `content` slot of `Card`. -}
contentHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentHeading =
    content_core


{-| Place a `FabMenuTrigger` in the `content` slot of `Card`. -}
contentFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFabMenuTrigger =
    content_core


{-| Place a `FabMenu` in the `content` slot of `Card`. -}
contentFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFabMenu =
    content_core


{-| Place a `Fab` in the `content` slot of `Card`. -}
contentFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFab =
    content_core


{-| Place a `Accordion` in the `content` slot of `Card`. -}
contentAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentAccordion =
    content_core


{-| Place a `ExpansionPanel` in the `content` slot of `Card`. -}
contentExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentExpansionPanel =
    content_core


{-| Place a `ExpansionHeader` in the `content` slot of `Card`. -}
contentExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentExpansionHeader =
    content_core


{-| Place a `DrawerToggle` in the `content` slot of `Card`. -}
contentDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDrawerToggle =
    content_core


{-| Place a `DrawerContainer` in the `content` slot of `Card`. -}
contentDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDrawerContainer =
    content_core


{-| Place a `Divider` in the `content` slot of `Card`. -}
contentDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDivider =
    content_core


{-| Place a `DialogTrigger` in the `content` slot of `Card`. -}
contentDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDialogTrigger =
    content_core


{-| Place a `Dialog` in the `content` slot of `Card`. -}
contentDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDialog =
    content_core


{-| Place a `DialogAction` in the `content` slot of `Card`. -}
contentDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDialogAction =
    content_core


{-| Place a `DatepickerToggle` in the `content` slot of `Card`. -}
contentDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDatepickerToggle =
    content_core


{-| Place a `Datepicker` in the `content` slot of `Card`. -}
contentDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentDatepicker =
    content_core


{-| Place a `ContentPane` in the `content` slot of `Card`. -}
contentContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentContentPane =
    content_core


{-| Place a `SuggestionChip` in the `content` slot of `Card`. -}
contentSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSuggestionChip =
    content_core


{-| Place a `InputChipSet` in the `content` slot of `Card`. -}
contentInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentInputChipSet =
    content_core


{-| Place a `InputChip` in the `content` slot of `Card`. -}
contentInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentInputChip =
    content_core


{-| Place a `FilterChipSet` in the `content` slot of `Card`. -}
contentFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFilterChipSet =
    content_core


{-| Place a `FilterChip` in the `content` slot of `Card`. -}
contentFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFilterChip =
    content_core


{-| Place a `ChipSet` in the `content` slot of `Card`. -}
contentChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentChipSet =
    content_core


{-| Place a `AssistChip` in the `content` slot of `Card`. -}
contentAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentAssistChip =
    content_core


{-| Place a `Chip` in the `content` slot of `Card`. -}
contentChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentChip =
    content_core


{-| Place a `Checkbox` in the `content` slot of `Card`. -}
contentCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentCheckbox =
    content_core


{-| Place a `Card` in the `content` slot of `Card`. -}
contentCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentCard =
    content_core


{-| Place a `Calendar` in the `content` slot of `Card`. -}
contentCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentCalendar =
    content_core


{-| Place a `YearView` in the `content` slot of `Card`. -}
contentYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentYearView =
    content_core


{-| Place a `MultiYearView` in the `content` slot of `Card`. -}
contentMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMultiYearView =
    content_core


{-| Place a `MonthView` in the `content` slot of `Card`. -}
contentMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentMonthView =
    content_core


{-| Place a `Tooltip` in the `content` slot of `Card`. -}
contentTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTooltip =
    content_core


{-| Place a `RichTooltip` in the `content` slot of `Card`. -}
contentRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentRichTooltip =
    content_core


{-| Place a `TooltipElementBase` in the `content` slot of `Card`. -}
contentTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTooltipElementBase =
    content_core


{-| Place a `RichTooltipAction` in the `content` slot of `Card`. -}
contentRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentRichTooltipAction =
    content_core


{-| Place a `ButtonGroup` in the `content` slot of `Card`. -}
contentButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentButtonGroup =
    content_core


{-| Place a `IconButton` in the `content` slot of `Card`. -}
contentIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentIconButton =
    content_core


{-| Place a `Button` in the `content` slot of `Card`. -}
contentButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentButton =
    content_core


{-| Place a `Breadcrumb` in the `content` slot of `Card`. -}
contentBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBreadcrumb =
    content_core


{-| Place a `BreadcrumbItem` in the `content` slot of `Card`. -}
contentBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBreadcrumbItem =
    content_core


{-| Place a `BreadcrumbItemButton` in the `content` slot of `Card`. -}
contentBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBreadcrumbItemButton =
    content_core


{-| Place a `BottomSheetTrigger` in the `content` slot of `Card`. -}
contentBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBottomSheetTrigger =
    content_core


{-| Place a `BottomSheet` in the `content` slot of `Card`. -}
contentBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBottomSheet =
    content_core


{-| Place a `BottomSheetAction` in the `content` slot of `Card`. -}
contentBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBottomSheetAction =
    content_core


{-| Place a `Badge` in the `content` slot of `Card`. -}
contentBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentBadge =
    content_core


{-| Place a `Avatar` in the `content` slot of `Card`. -}
contentAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentAvatar =
    content_core


{-| Place a `Autocomplete` in the `content` slot of `Card`. -}
contentAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentAutocomplete =
    content_core


{-| Place a `FormField` in the `content` slot of `Card`. -}
contentFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFormField =
    content_core


{-| Place a `OptionPanel` in the `content` slot of `Card`. -}
contentOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentOptionPanel =
    content_core


{-| Place a `FloatingPanel` in the `content` slot of `Card`. -}
contentFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFloatingPanel =
    content_core


{-| Place a `Optgroup` in the `content` slot of `Card`. -}
contentOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentOptgroup =
    content_core


{-| Place a `Option` in the `content` slot of `Card`. -}
contentOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentOption =
    content_core


{-| Place a `FocusTrap` in the `content` slot of `Card`. -}
contentFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFocusTrap =
    content_core


{-| Place a `AppBar` in the `content` slot of `Card`. -}
contentAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentAppBar =
    content_core


{-| Place a `TextOverflow` in the `content` slot of `Card`. -}
contentTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTextOverflow =
    content_core


{-| Place a `TextHighlight` in the `content` slot of `Card`. -}
contentTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentTextHighlight =
    content_core


{-| Place a `StateLayer` in the `content` slot of `Card`. -}
contentStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentStateLayer =
    content_core


{-| Place a `Slide` in the `content` slot of `Card`. -}
contentSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentSlide =
    content_core


{-| Place a `ScrollContainer` in the `content` slot of `Card`. -}
contentScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentScrollContainer =
    content_core


{-| Place a `Ripple` in the `content` slot of `Card`. -}
contentRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentRipple =
    content_core


{-| Place a `PseudoRadio` in the `content` slot of `Card`. -}
contentPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentPseudoRadio =
    content_core


{-| Place a `PseudoCheckbox` in the `content` slot of `Card`. -}
contentPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentPseudoCheckbox =
    content_core


{-| Place a `FocusRing` in the `content` slot of `Card`. -}
contentFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentFocusRing =
    content_core


{-| Place a `Elevation` in the `content` slot of `Card`. -}
contentElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentElevation =
    content_core


{-| Place a `Collapsible` in the `content` slot of `Card`. -}
contentCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentCollapsible =
    content_core


{-| Place a `ActionElementBase` in the `content` slot of `Card`. -}
contentActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
contentActionElementBase =
    content_core


{-| Place a `Tree` in the `actions` slot of `Card`. -}
actionsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTree =
    actions_core


{-| Place a `TreeItem` in the `actions` slot of `Card`. -}
actionsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTreeItem =
    actions_core


{-| Place a `Toolbar` in the `actions` slot of `Card`. -}
actionsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToolbar =
    actions_core


{-| Place a `Toc` in the `actions` slot of `Card`. -}
actionsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToc =
    actions_core


{-| Place a `TocItem` in the `actions` slot of `Card`. -}
actionsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTocItem =
    actions_core


{-| Place a `ThemeIcon` in the `actions` slot of `Card`. -}
actionsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsThemeIcon =
    actions_core


{-| Place a `Theme` in the `actions` slot of `Card`. -}
actionsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTheme =
    actions_core


{-| Place a `TextareaAutosize` in the `actions` slot of `Card`. -}
actionsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextareaAutosize =
    actions_core


{-| Place a `Tabs` in the `actions` slot of `Card`. -}
actionsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabs =
    actions_core


{-| Place a `TabPanel` in the `actions` slot of `Card`. -}
actionsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabPanel =
    actions_core


{-| Place a `Tab` in the `actions` slot of `Card`. -}
actionsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTab =
    actions_core


{-| Place a `Switch` in the `actions` slot of `Card`. -}
actionsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSwitch =
    actions_core


{-| Place a `StepperReset` in the `actions` slot of `Card`. -}
actionsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperReset =
    actions_core


{-| Place a `StepperPrevious` in the `actions` slot of `Card`. -}
actionsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperPrevious =
    actions_core


{-| Place a `Step` in the `actions` slot of `Card`. -}
actionsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStep =
    actions_core


{-| Place a `StepPanel` in the `actions` slot of `Card`. -}
actionsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepPanel =
    actions_core


{-| Place a `Stepper` in the `actions` slot of `Card`. -}
actionsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepper =
    actions_core


{-| Place a `SplitPane` in the `actions` slot of `Card`. -}
actionsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitPane =
    actions_core


{-| Place a `SplitButton` in the `actions` slot of `Card`. -}
actionsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitButton =
    actions_core


{-| Place a `Snackbar` in the `actions` slot of `Card`. -}
actionsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSnackbar =
    actions_core


{-| Place a `Slider` in the `actions` slot of `Card`. -}
actionsSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlider =
    actions_core


{-| Place a `SliderThumb` in the `actions` slot of `Card`. -}
actionsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSliderThumb =
    actions_core


{-| Place a `SlideGroup` in the `actions` slot of `Card`. -}
actionsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlideGroup =
    actions_core


{-| Place a `Skeleton` in the `actions` slot of `Card`. -}
actionsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSkeleton =
    actions_core


{-| Place a `Shape` in the `actions` slot of `Card`. -}
actionsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsShape =
    actions_core


{-| Place a `SegmentedButton` in the `actions` slot of `Card`. -}
actionsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSegmentedButton =
    actions_core


{-| Place a `ButtonSegment` in the `actions` slot of `Card`. -}
actionsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonSegment =
    actions_core


{-| Place a `SearchView` in the `actions` slot of `Card`. -}
actionsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchView =
    actions_core


{-| Place a `SearchBar` in the `actions` slot of `Card`. -}
actionsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchBar =
    actions_core


{-| Place a `RadioGroup` in the `actions` slot of `Card`. -}
actionsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadioGroup =
    actions_core


{-| Place a `Radio` in the `actions` slot of `Card`. -}
actionsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadio =
    actions_core


{-| Place a `ProgressElementIndicatorBase` in the `actions` slot of `Card`. -}
actionsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsProgressElementIndicatorBase =
    actions_core


{-| Place a `Paginator` in the `actions` slot of `Card`. -}
actionsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPaginator =
    actions_core


{-| Place a `Select` in the `actions` slot of `Card`. -}
actionsSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelect =
    actions_core


{-| Place a `NavRailToggle` in the `actions` slot of `Card`. -}
actionsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRailToggle =
    actions_core


{-| Place a `NavRail` in the `actions` slot of `Card`. -}
actionsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRail =
    actions_core


{-| Place a `NavMenuItemGroup` in the `actions` slot of `Card`. -}
actionsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItemGroup =
    actions_core


{-| Place a `NavMenu` in the `actions` slot of `Card`. -}
actionsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenu =
    actions_core


{-| Place a `NavMenuItem` in the `actions` slot of `Card`. -}
actionsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItem =
    actions_core


{-| Place a `NavBar` in the `actions` slot of `Card`. -}
actionsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavBar =
    actions_core


{-| Place a `NavItem` in the `actions` slot of `Card`. -}
actionsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavItem =
    actions_core


{-| Place a `MenuItemRadio` in the `actions` slot of `Card`. -}
actionsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemRadio =
    actions_core


{-| Place a `MenuItemGroup` in the `actions` slot of `Card`. -}
actionsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemGroup =
    actions_core


{-| Place a `MenuItemCheckbox` in the `actions` slot of `Card`. -}
actionsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemCheckbox =
    actions_core


{-| Place a `Menu` in the `actions` slot of `Card`. -}
actionsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenu =
    actions_core


{-| Place a `MenuItem` in the `actions` slot of `Card`. -}
actionsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItem =
    actions_core


{-| Place a `MenuTrigger` in the `actions` slot of `Card`. -}
actionsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuTrigger =
    actions_core


{-| Place a `MenuItemElementBase` in the `actions` slot of `Card`. -}
actionsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemElementBase =
    actions_core


{-| Place a `LoadingIndicator` in the `actions` slot of `Card`. -}
actionsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsLoadingIndicator =
    actions_core


{-| Place a `SelectionList` in the `actions` slot of `Card`. -}
actionsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelectionList =
    actions_core


{-| Place a `ListOption` in the `actions` slot of `Card`. -}
actionsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListOption =
    actions_core


{-| Place a `ActionList` in the `actions` slot of `Card`. -}
actionsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionList =
    actions_core


{-| Place a `ExpandableListItem` in the `actions` slot of `Card`. -}
actionsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpandableListItem =
    actions_core


{-| Place a `ListAction` in the `actions` slot of `Card`. -}
actionsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListAction =
    actions_core


{-| Place a `ListItemButton` in the `actions` slot of `Card`. -}
actionsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItemButton =
    actions_core


{-| Place a `List` in the `actions` slot of `Card`. -}
actionsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsList =
    actions_core


{-| Place a `ListItem` in the `actions` slot of `Card`. -}
actionsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItem =
    actions_core


{-| Place a `Icon` in the `actions` slot of `Card`. -}
actionsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIcon =
    actions_core


{-| Place a `Heading` in the `actions` slot of `Card`. -}
actionsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsHeading =
    actions_core


{-| Place a `FabMenuTrigger` in the `actions` slot of `Card`. -}
actionsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenuTrigger =
    actions_core


{-| Place a `FabMenu` in the `actions` slot of `Card`. -}
actionsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenu =
    actions_core


{-| Place a `Fab` in the `actions` slot of `Card`. -}
actionsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFab =
    actions_core


{-| Place a `Accordion` in the `actions` slot of `Card`. -}
actionsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAccordion =
    actions_core


{-| Place a `ExpansionPanel` in the `actions` slot of `Card`. -}
actionsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionPanel =
    actions_core


{-| Place a `ExpansionHeader` in the `actions` slot of `Card`. -}
actionsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionHeader =
    actions_core


{-| Place a `DrawerToggle` in the `actions` slot of `Card`. -}
actionsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerToggle =
    actions_core


{-| Place a `DrawerContainer` in the `actions` slot of `Card`. -}
actionsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerContainer =
    actions_core


{-| Place a `Divider` in the `actions` slot of `Card`. -}
actionsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDivider =
    actions_core


{-| Place a `DialogTrigger` in the `actions` slot of `Card`. -}
actionsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogTrigger =
    actions_core


{-| Place a `Dialog` in the `actions` slot of `Card`. -}
actionsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialog =
    actions_core


{-| Place a `DialogAction` in the `actions` slot of `Card`. -}
actionsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogAction =
    actions_core


{-| Place a `DatepickerToggle` in the `actions` slot of `Card`. -}
actionsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepickerToggle =
    actions_core


{-| Place a `Datepicker` in the `actions` slot of `Card`. -}
actionsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepicker =
    actions_core


{-| Place a `ContentPane` in the `actions` slot of `Card`. -}
actionsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsContentPane =
    actions_core


{-| Place a `SuggestionChip` in the `actions` slot of `Card`. -}
actionsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSuggestionChip =
    actions_core


{-| Place a `InputChipSet` in the `actions` slot of `Card`. -}
actionsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChipSet =
    actions_core


{-| Place a `InputChip` in the `actions` slot of `Card`. -}
actionsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChip =
    actions_core


{-| Place a `FilterChipSet` in the `actions` slot of `Card`. -}
actionsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChipSet =
    actions_core


{-| Place a `FilterChip` in the `actions` slot of `Card`. -}
actionsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChip =
    actions_core


{-| Place a `ChipSet` in the `actions` slot of `Card`. -}
actionsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChipSet =
    actions_core


{-| Place a `AssistChip` in the `actions` slot of `Card`. -}
actionsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAssistChip =
    actions_core


{-| Place a `Chip` in the `actions` slot of `Card`. -}
actionsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChip =
    actions_core


{-| Place a `Checkbox` in the `actions` slot of `Card`. -}
actionsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCheckbox =
    actions_core


{-| Place a `Card` in the `actions` slot of `Card`. -}
actionsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCard =
    actions_core


{-| Place a `Calendar` in the `actions` slot of `Card`. -}
actionsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCalendar =
    actions_core


{-| Place a `YearView` in the `actions` slot of `Card`. -}
actionsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsYearView =
    actions_core


{-| Place a `MultiYearView` in the `actions` slot of `Card`. -}
actionsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMultiYearView =
    actions_core


{-| Place a `MonthView` in the `actions` slot of `Card`. -}
actionsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMonthView =
    actions_core


{-| Place a `Tooltip` in the `actions` slot of `Card`. -}
actionsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltip =
    actions_core


{-| Place a `RichTooltip` in the `actions` slot of `Card`. -}
actionsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltip =
    actions_core


{-| Place a `TooltipElementBase` in the `actions` slot of `Card`. -}
actionsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltipElementBase =
    actions_core


{-| Place a `RichTooltipAction` in the `actions` slot of `Card`. -}
actionsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltipAction =
    actions_core


{-| Place a `ButtonGroup` in the `actions` slot of `Card`. -}
actionsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonGroup =
    actions_core


{-| Place a `IconButton` in the `actions` slot of `Card`. -}
actionsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIconButton =
    actions_core


{-| Place a `Button` in the `actions` slot of `Card`. -}
actionsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButton =
    actions_core


{-| Place a `Breadcrumb` in the `actions` slot of `Card`. -}
actionsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumb =
    actions_core


{-| Place a `BreadcrumbItem` in the `actions` slot of `Card`. -}
actionsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItem =
    actions_core


{-| Place a `BreadcrumbItemButton` in the `actions` slot of `Card`. -}
actionsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItemButton =
    actions_core


{-| Place a `BottomSheetTrigger` in the `actions` slot of `Card`. -}
actionsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetTrigger =
    actions_core


{-| Place a `BottomSheet` in the `actions` slot of `Card`. -}
actionsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheet =
    actions_core


{-| Place a `BottomSheetAction` in the `actions` slot of `Card`. -}
actionsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetAction =
    actions_core


{-| Place a `Badge` in the `actions` slot of `Card`. -}
actionsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBadge =
    actions_core


{-| Place a `Avatar` in the `actions` slot of `Card`. -}
actionsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAvatar =
    actions_core


{-| Place a `Autocomplete` in the `actions` slot of `Card`. -}
actionsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAutocomplete =
    actions_core


{-| Place a `FormField` in the `actions` slot of `Card`. -}
actionsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFormField =
    actions_core


{-| Place a `OptionPanel` in the `actions` slot of `Card`. -}
actionsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptionPanel =
    actions_core


{-| Place a `FloatingPanel` in the `actions` slot of `Card`. -}
actionsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFloatingPanel =
    actions_core


{-| Place a `Optgroup` in the `actions` slot of `Card`. -}
actionsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptgroup =
    actions_core


{-| Place a `Option` in the `actions` slot of `Card`. -}
actionsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOption =
    actions_core


{-| Place a `FocusTrap` in the `actions` slot of `Card`. -}
actionsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusTrap =
    actions_core


{-| Place a `AppBar` in the `actions` slot of `Card`. -}
actionsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAppBar =
    actions_core


{-| Place a `TextOverflow` in the `actions` slot of `Card`. -}
actionsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextOverflow =
    actions_core


{-| Place a `TextHighlight` in the `actions` slot of `Card`. -}
actionsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextHighlight =
    actions_core


{-| Place a `StateLayer` in the `actions` slot of `Card`. -}
actionsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStateLayer =
    actions_core


{-| Place a `Slide` in the `actions` slot of `Card`. -}
actionsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlide =
    actions_core


{-| Place a `ScrollContainer` in the `actions` slot of `Card`. -}
actionsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsScrollContainer =
    actions_core


{-| Place a `Ripple` in the `actions` slot of `Card`. -}
actionsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRipple =
    actions_core


{-| Place a `PseudoRadio` in the `actions` slot of `Card`. -}
actionsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoRadio =
    actions_core


{-| Place a `PseudoCheckbox` in the `actions` slot of `Card`. -}
actionsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoCheckbox =
    actions_core


{-| Place a `FocusRing` in the `actions` slot of `Card`. -}
actionsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusRing =
    actions_core


{-| Place a `Elevation` in the `actions` slot of `Card`. -}
actionsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsElevation =
    actions_core


{-| Place a `Collapsible` in the `actions` slot of `Card`. -}
actionsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCollapsible =
    actions_core


{-| Place a `ActionElementBase` in the `actions` slot of `Card`. -}
actionsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionElementBase =
    actions_core


{-| Place a `Tree` in the `footer` slot of `Card`. -}
footerTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTree =
    footer_core


{-| Place a `TreeItem` in the `footer` slot of `Card`. -}
footerTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTreeItem =
    footer_core


{-| Place a `Toolbar` in the `footer` slot of `Card`. -}
footerToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerToolbar =
    footer_core


{-| Place a `Toc` in the `footer` slot of `Card`. -}
footerToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerToc =
    footer_core


{-| Place a `TocItem` in the `footer` slot of `Card`. -}
footerTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTocItem =
    footer_core


{-| Place a `ThemeIcon` in the `footer` slot of `Card`. -}
footerThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerThemeIcon =
    footer_core


{-| Place a `Theme` in the `footer` slot of `Card`. -}
footerTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTheme =
    footer_core


{-| Place a `TextareaAutosize` in the `footer` slot of `Card`. -}
footerTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTextareaAutosize =
    footer_core


{-| Place a `Tabs` in the `footer` slot of `Card`. -}
footerTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTabs =
    footer_core


{-| Place a `TabPanel` in the `footer` slot of `Card`. -}
footerTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTabPanel =
    footer_core


{-| Place a `Tab` in the `footer` slot of `Card`. -}
footerTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTab =
    footer_core


{-| Place a `Switch` in the `footer` slot of `Card`. -}
footerSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSwitch =
    footer_core


{-| Place a `StepperReset` in the `footer` slot of `Card`. -}
footerStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStepperReset =
    footer_core


{-| Place a `StepperPrevious` in the `footer` slot of `Card`. -}
footerStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStepperPrevious =
    footer_core


{-| Place a `Step` in the `footer` slot of `Card`. -}
footerStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStep =
    footer_core


{-| Place a `StepPanel` in the `footer` slot of `Card`. -}
footerStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStepPanel =
    footer_core


{-| Place a `Stepper` in the `footer` slot of `Card`. -}
footerStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStepper =
    footer_core


{-| Place a `SplitPane` in the `footer` slot of `Card`. -}
footerSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSplitPane =
    footer_core


{-| Place a `SplitButton` in the `footer` slot of `Card`. -}
footerSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSplitButton =
    footer_core


{-| Place a `Snackbar` in the `footer` slot of `Card`. -}
footerSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSnackbar =
    footer_core


{-| Place a `Slider` in the `footer` slot of `Card`. -}
footerSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSlider =
    footer_core


{-| Place a `SliderThumb` in the `footer` slot of `Card`. -}
footerSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSliderThumb =
    footer_core


{-| Place a `SlideGroup` in the `footer` slot of `Card`. -}
footerSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSlideGroup =
    footer_core


{-| Place a `Skeleton` in the `footer` slot of `Card`. -}
footerSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSkeleton =
    footer_core


{-| Place a `Shape` in the `footer` slot of `Card`. -}
footerShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerShape =
    footer_core


{-| Place a `SegmentedButton` in the `footer` slot of `Card`. -}
footerSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSegmentedButton =
    footer_core


{-| Place a `ButtonSegment` in the `footer` slot of `Card`. -}
footerButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerButtonSegment =
    footer_core


{-| Place a `SearchView` in the `footer` slot of `Card`. -}
footerSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSearchView =
    footer_core


{-| Place a `SearchBar` in the `footer` slot of `Card`. -}
footerSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSearchBar =
    footer_core


{-| Place a `RadioGroup` in the `footer` slot of `Card`. -}
footerRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerRadioGroup =
    footer_core


{-| Place a `Radio` in the `footer` slot of `Card`. -}
footerRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerRadio =
    footer_core


{-| Place a `ProgressElementIndicatorBase` in the `footer` slot of `Card`. -}
footerProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerProgressElementIndicatorBase =
    footer_core


{-| Place a `Paginator` in the `footer` slot of `Card`. -}
footerPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerPaginator =
    footer_core


{-| Place a `Select` in the `footer` slot of `Card`. -}
footerSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSelect =
    footer_core


{-| Place a `NavRailToggle` in the `footer` slot of `Card`. -}
footerNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavRailToggle =
    footer_core


{-| Place a `NavRail` in the `footer` slot of `Card`. -}
footerNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavRail =
    footer_core


{-| Place a `NavMenuItemGroup` in the `footer` slot of `Card`. -}
footerNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavMenuItemGroup =
    footer_core


{-| Place a `NavMenu` in the `footer` slot of `Card`. -}
footerNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavMenu =
    footer_core


{-| Place a `NavMenuItem` in the `footer` slot of `Card`. -}
footerNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavMenuItem =
    footer_core


{-| Place a `NavBar` in the `footer` slot of `Card`. -}
footerNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavBar =
    footer_core


{-| Place a `NavItem` in the `footer` slot of `Card`. -}
footerNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerNavItem =
    footer_core


{-| Place a `MenuItemRadio` in the `footer` slot of `Card`. -}
footerMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuItemRadio =
    footer_core


{-| Place a `MenuItemGroup` in the `footer` slot of `Card`. -}
footerMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuItemGroup =
    footer_core


{-| Place a `MenuItemCheckbox` in the `footer` slot of `Card`. -}
footerMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuItemCheckbox =
    footer_core


{-| Place a `Menu` in the `footer` slot of `Card`. -}
footerMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenu =
    footer_core


{-| Place a `MenuItem` in the `footer` slot of `Card`. -}
footerMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuItem =
    footer_core


{-| Place a `MenuTrigger` in the `footer` slot of `Card`. -}
footerMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuTrigger =
    footer_core


{-| Place a `MenuItemElementBase` in the `footer` slot of `Card`. -}
footerMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMenuItemElementBase =
    footer_core


{-| Place a `LoadingIndicator` in the `footer` slot of `Card`. -}
footerLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerLoadingIndicator =
    footer_core


{-| Place a `SelectionList` in the `footer` slot of `Card`. -}
footerSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSelectionList =
    footer_core


{-| Place a `ListOption` in the `footer` slot of `Card`. -}
footerListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerListOption =
    footer_core


{-| Place a `ActionList` in the `footer` slot of `Card`. -}
footerActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerActionList =
    footer_core


{-| Place a `ExpandableListItem` in the `footer` slot of `Card`. -}
footerExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerExpandableListItem =
    footer_core


{-| Place a `ListAction` in the `footer` slot of `Card`. -}
footerListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerListAction =
    footer_core


{-| Place a `ListItemButton` in the `footer` slot of `Card`. -}
footerListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerListItemButton =
    footer_core


{-| Place a `List` in the `footer` slot of `Card`. -}
footerList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerList =
    footer_core


{-| Place a `ListItem` in the `footer` slot of `Card`. -}
footerListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerListItem =
    footer_core


{-| Place a `Icon` in the `footer` slot of `Card`. -}
footerIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerIcon =
    footer_core


{-| Place a `Heading` in the `footer` slot of `Card`. -}
footerHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerHeading =
    footer_core


{-| Place a `FabMenuTrigger` in the `footer` slot of `Card`. -}
footerFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFabMenuTrigger =
    footer_core


{-| Place a `FabMenu` in the `footer` slot of `Card`. -}
footerFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFabMenu =
    footer_core


{-| Place a `Fab` in the `footer` slot of `Card`. -}
footerFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFab =
    footer_core


{-| Place a `Accordion` in the `footer` slot of `Card`. -}
footerAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerAccordion =
    footer_core


{-| Place a `ExpansionPanel` in the `footer` slot of `Card`. -}
footerExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerExpansionPanel =
    footer_core


{-| Place a `ExpansionHeader` in the `footer` slot of `Card`. -}
footerExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerExpansionHeader =
    footer_core


{-| Place a `DrawerToggle` in the `footer` slot of `Card`. -}
footerDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDrawerToggle =
    footer_core


{-| Place a `DrawerContainer` in the `footer` slot of `Card`. -}
footerDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDrawerContainer =
    footer_core


{-| Place a `Divider` in the `footer` slot of `Card`. -}
footerDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDivider =
    footer_core


{-| Place a `DialogTrigger` in the `footer` slot of `Card`. -}
footerDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDialogTrigger =
    footer_core


{-| Place a `Dialog` in the `footer` slot of `Card`. -}
footerDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDialog =
    footer_core


{-| Place a `DialogAction` in the `footer` slot of `Card`. -}
footerDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDialogAction =
    footer_core


{-| Place a `DatepickerToggle` in the `footer` slot of `Card`. -}
footerDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDatepickerToggle =
    footer_core


{-| Place a `Datepicker` in the `footer` slot of `Card`. -}
footerDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerDatepicker =
    footer_core


{-| Place a `ContentPane` in the `footer` slot of `Card`. -}
footerContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerContentPane =
    footer_core


{-| Place a `SuggestionChip` in the `footer` slot of `Card`. -}
footerSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSuggestionChip =
    footer_core


{-| Place a `InputChipSet` in the `footer` slot of `Card`. -}
footerInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerInputChipSet =
    footer_core


{-| Place a `InputChip` in the `footer` slot of `Card`. -}
footerInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerInputChip =
    footer_core


{-| Place a `FilterChipSet` in the `footer` slot of `Card`. -}
footerFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFilterChipSet =
    footer_core


{-| Place a `FilterChip` in the `footer` slot of `Card`. -}
footerFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFilterChip =
    footer_core


{-| Place a `ChipSet` in the `footer` slot of `Card`. -}
footerChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerChipSet =
    footer_core


{-| Place a `AssistChip` in the `footer` slot of `Card`. -}
footerAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerAssistChip =
    footer_core


{-| Place a `Chip` in the `footer` slot of `Card`. -}
footerChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerChip =
    footer_core


{-| Place a `Checkbox` in the `footer` slot of `Card`. -}
footerCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerCheckbox =
    footer_core


{-| Place a `Card` in the `footer` slot of `Card`. -}
footerCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerCard =
    footer_core


{-| Place a `Calendar` in the `footer` slot of `Card`. -}
footerCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerCalendar =
    footer_core


{-| Place a `YearView` in the `footer` slot of `Card`. -}
footerYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerYearView =
    footer_core


{-| Place a `MultiYearView` in the `footer` slot of `Card`. -}
footerMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMultiYearView =
    footer_core


{-| Place a `MonthView` in the `footer` slot of `Card`. -}
footerMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerMonthView =
    footer_core


{-| Place a `Tooltip` in the `footer` slot of `Card`. -}
footerTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTooltip =
    footer_core


{-| Place a `RichTooltip` in the `footer` slot of `Card`. -}
footerRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerRichTooltip =
    footer_core


{-| Place a `TooltipElementBase` in the `footer` slot of `Card`. -}
footerTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTooltipElementBase =
    footer_core


{-| Place a `RichTooltipAction` in the `footer` slot of `Card`. -}
footerRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerRichTooltipAction =
    footer_core


{-| Place a `ButtonGroup` in the `footer` slot of `Card`. -}
footerButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerButtonGroup =
    footer_core


{-| Place a `IconButton` in the `footer` slot of `Card`. -}
footerIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerIconButton =
    footer_core


{-| Place a `Button` in the `footer` slot of `Card`. -}
footerButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerButton =
    footer_core


{-| Place a `Breadcrumb` in the `footer` slot of `Card`. -}
footerBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBreadcrumb =
    footer_core


{-| Place a `BreadcrumbItem` in the `footer` slot of `Card`. -}
footerBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBreadcrumbItem =
    footer_core


{-| Place a `BreadcrumbItemButton` in the `footer` slot of `Card`. -}
footerBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBreadcrumbItemButton =
    footer_core


{-| Place a `BottomSheetTrigger` in the `footer` slot of `Card`. -}
footerBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBottomSheetTrigger =
    footer_core


{-| Place a `BottomSheet` in the `footer` slot of `Card`. -}
footerBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBottomSheet =
    footer_core


{-| Place a `BottomSheetAction` in the `footer` slot of `Card`. -}
footerBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBottomSheetAction =
    footer_core


{-| Place a `Badge` in the `footer` slot of `Card`. -}
footerBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerBadge =
    footer_core


{-| Place a `Avatar` in the `footer` slot of `Card`. -}
footerAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerAvatar =
    footer_core


{-| Place a `Autocomplete` in the `footer` slot of `Card`. -}
footerAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerAutocomplete =
    footer_core


{-| Place a `FormField` in the `footer` slot of `Card`. -}
footerFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFormField =
    footer_core


{-| Place a `OptionPanel` in the `footer` slot of `Card`. -}
footerOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerOptionPanel =
    footer_core


{-| Place a `FloatingPanel` in the `footer` slot of `Card`. -}
footerFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFloatingPanel =
    footer_core


{-| Place a `Optgroup` in the `footer` slot of `Card`. -}
footerOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerOptgroup =
    footer_core


{-| Place a `Option` in the `footer` slot of `Card`. -}
footerOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerOption =
    footer_core


{-| Place a `FocusTrap` in the `footer` slot of `Card`. -}
footerFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFocusTrap =
    footer_core


{-| Place a `AppBar` in the `footer` slot of `Card`. -}
footerAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerAppBar =
    footer_core


{-| Place a `TextOverflow` in the `footer` slot of `Card`. -}
footerTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTextOverflow =
    footer_core


{-| Place a `TextHighlight` in the `footer` slot of `Card`. -}
footerTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerTextHighlight =
    footer_core


{-| Place a `StateLayer` in the `footer` slot of `Card`. -}
footerStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerStateLayer =
    footer_core


{-| Place a `Slide` in the `footer` slot of `Card`. -}
footerSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerSlide =
    footer_core


{-| Place a `ScrollContainer` in the `footer` slot of `Card`. -}
footerScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerScrollContainer =
    footer_core


{-| Place a `Ripple` in the `footer` slot of `Card`. -}
footerRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerRipple =
    footer_core


{-| Place a `PseudoRadio` in the `footer` slot of `Card`. -}
footerPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerPseudoRadio =
    footer_core


{-| Place a `PseudoCheckbox` in the `footer` slot of `Card`. -}
footerPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerPseudoCheckbox =
    footer_core


{-| Place a `FocusRing` in the `footer` slot of `Card`. -}
footerFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerFocusRing =
    footer_core


{-| Place a `Elevation` in the `footer` slot of `Card`. -}
footerElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerElevation =
    footer_core


{-| Place a `Collapsible` in the `footer` slot of `Card`. -}
footerCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerCollapsible =
    footer_core


{-| Place a `ActionElementBase` in the `footer` slot of `Card`. -}
footerActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footerActionElementBase =
    footer_core