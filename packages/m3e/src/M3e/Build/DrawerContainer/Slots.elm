module M3e.Build.DrawerContainer.Slots exposing
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, startTree, startTreeItem
    , startToolbar, startToc, startTocItem, startThemeIcon, startTheme, startTextareaAutosize, startTabs
    , startTabPanel, startTab, startSwitch, startStepperReset, startStepperPrevious, startStep, startStepPanel
    , startStepper, startSplitPane, startSplitButton, startSnackbar, startSlider, startSliderThumb, startSlideGroup
    , startSkeleton, startShape, startSegmentedButton, startButtonSegment, startSearchView, startSearchBar, startRadioGroup
    , startRadio, startProgressElementIndicatorBase, startPaginator, startSelect, startNavRailToggle, startNavRail, startNavMenuItemGroup
    , startNavMenu, startNavMenuItem, startNavBar, startNavItem, startMenuItemRadio, startMenuItemGroup, startMenuItemCheckbox
    , startMenu, startMenuItem, startMenuTrigger, startMenuItemElementBase, startLoadingIndicator, startSelectionList, startListOption
    , startActionList, startExpandableListItem, startListAction, startListItemButton, startList, startListItem, startIcon
    , startHeading, startFabMenuTrigger, startFabMenu, startFab, startAccordion, startExpansionPanel, startExpansionHeader
    , startDrawerToggle, startDrawerContainer, startDivider, startDialogTrigger, startDialog, startDialogAction, startDatepickerToggle
    , startDatepicker, startContentPane, startSuggestionChip, startInputChipSet, startInputChip, startFilterChipSet, startFilterChip
    , startChipSet, startAssistChip, startChip, startCheckbox, startCard, startCalendar, startYearView
    , startMultiYearView, startMonthView, startTooltip, startRichTooltip, startTooltipElementBase, startRichTooltipAction, startButtonGroup
    , startIconButton, startButton, startBreadcrumb, startBreadcrumbItem, startBreadcrumbItemButton, startBottomSheetTrigger, startBottomSheet
    , startBottomSheetAction, startBadge, startAvatar, startAutocomplete, startFormField, startOptionPanel, startFloatingPanel
    , startOptgroup, startOption, startFocusTrap, startAppBar, startTextOverflow, startTextHighlight, startStateLayer
    , startSlide, startScrollContainer, startRipple, startPseudoRadio, startPseudoCheckbox, startFocusRing, startElevation
    , startCollapsible, startActionElementBase, endTree, endTreeItem, endToolbar, endToc, endTocItem
    , endThemeIcon, endTheme, endTextareaAutosize, endTabs, endTabPanel, endTab, endSwitch
    , endStepperReset, endStepperPrevious, endStep, endStepPanel, endStepper, endSplitPane, endSplitButton
    , endSnackbar, endSlider, endSliderThumb, endSlideGroup, endSkeleton, endShape, endSegmentedButton
    , endButtonSegment, endSearchView, endSearchBar, endRadioGroup, endRadio, endProgressElementIndicatorBase, endPaginator
    , endSelect, endNavRailToggle, endNavRail, endNavMenuItemGroup, endNavMenu, endNavMenuItem, endNavBar
    , endNavItem, endMenuItemRadio, endMenuItemGroup, endMenuItemCheckbox, endMenu, endMenuItem, endMenuTrigger
    , endMenuItemElementBase, endLoadingIndicator, endSelectionList, endListOption, endActionList, endExpandableListItem, endListAction
    , endListItemButton, endList, endListItem, endIcon, endHeading, endFabMenuTrigger, endFabMenu
    , endFab, endAccordion, endExpansionPanel, endExpansionHeader, endDrawerToggle, endDrawerContainer, endDivider
    , endDialogTrigger, endDialog, endDialogAction, endDatepickerToggle, endDatepicker, endContentPane, endSuggestionChip
    , endInputChipSet, endInputChip, endFilterChipSet, endFilterChip, endChipSet, endAssistChip, endChip
    , endCheckbox, endCard, endCalendar, endYearView, endMultiYearView, endMonthView, endTooltip
    , endRichTooltip, endTooltipElementBase, endRichTooltipAction, endButtonGroup, endIconButton, endButton, endBreadcrumb
    , endBreadcrumbItem, endBreadcrumbItemButton, endBottomSheetTrigger, endBottomSheet, endBottomSheetAction, endBadge, endAvatar
    , endAutocomplete, endFormField, endOptionPanel, endFloatingPanel, endOptgroup, endOption, endFocusTrap
    , endAppBar, endTextOverflow, endTextHighlight, endStateLayer, endSlide, endScrollContainer, endRipple
    , endPseudoRadio, endPseudoCheckbox, endFocusRing, endElevation, endCollapsible, endActionElementBase
    )

{-|
Slot setters for `M3e.Build.DrawerContainer`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs elevation, collapsible, actionElementBase, startTree, startTreeItem, startToolbar
@docs startToc, startTocItem, startThemeIcon, startTheme, startTextareaAutosize, startTabs
@docs startTabPanel, startTab, startSwitch, startStepperReset, startStepperPrevious, startStep
@docs startStepPanel, startStepper, startSplitPane, startSplitButton, startSnackbar, startSlider
@docs startSliderThumb, startSlideGroup, startSkeleton, startShape, startSegmentedButton, startButtonSegment
@docs startSearchView, startSearchBar, startRadioGroup, startRadio, startProgressElementIndicatorBase, startPaginator
@docs startSelect, startNavRailToggle, startNavRail, startNavMenuItemGroup, startNavMenu, startNavMenuItem
@docs startNavBar, startNavItem, startMenuItemRadio, startMenuItemGroup, startMenuItemCheckbox, startMenu
@docs startMenuItem, startMenuTrigger, startMenuItemElementBase, startLoadingIndicator, startSelectionList, startListOption
@docs startActionList, startExpandableListItem, startListAction, startListItemButton, startList, startListItem
@docs startIcon, startHeading, startFabMenuTrigger, startFabMenu, startFab, startAccordion
@docs startExpansionPanel, startExpansionHeader, startDrawerToggle, startDrawerContainer, startDivider, startDialogTrigger
@docs startDialog, startDialogAction, startDatepickerToggle, startDatepicker, startContentPane, startSuggestionChip
@docs startInputChipSet, startInputChip, startFilterChipSet, startFilterChip, startChipSet, startAssistChip
@docs startChip, startCheckbox, startCard, startCalendar, startYearView, startMultiYearView
@docs startMonthView, startTooltip, startRichTooltip, startTooltipElementBase, startRichTooltipAction, startButtonGroup
@docs startIconButton, startButton, startBreadcrumb, startBreadcrumbItem, startBreadcrumbItemButton, startBottomSheetTrigger
@docs startBottomSheet, startBottomSheetAction, startBadge, startAvatar, startAutocomplete, startFormField
@docs startOptionPanel, startFloatingPanel, startOptgroup, startOption, startFocusTrap, startAppBar
@docs startTextOverflow, startTextHighlight, startStateLayer, startSlide, startScrollContainer, startRipple
@docs startPseudoRadio, startPseudoCheckbox, startFocusRing, startElevation, startCollapsible, startActionElementBase
@docs endTree, endTreeItem, endToolbar, endToc, endTocItem, endThemeIcon
@docs endTheme, endTextareaAutosize, endTabs, endTabPanel, endTab, endSwitch
@docs endStepperReset, endStepperPrevious, endStep, endStepPanel, endStepper, endSplitPane
@docs endSplitButton, endSnackbar, endSlider, endSliderThumb, endSlideGroup, endSkeleton
@docs endShape, endSegmentedButton, endButtonSegment, endSearchView, endSearchBar, endRadioGroup
@docs endRadio, endProgressElementIndicatorBase, endPaginator, endSelect, endNavRailToggle, endNavRail
@docs endNavMenuItemGroup, endNavMenu, endNavMenuItem, endNavBar, endNavItem, endMenuItemRadio
@docs endMenuItemGroup, endMenuItemCheckbox, endMenu, endMenuItem, endMenuTrigger, endMenuItemElementBase
@docs endLoadingIndicator, endSelectionList, endListOption, endActionList, endExpandableListItem, endListAction
@docs endListItemButton, endList, endListItem, endIcon, endHeading, endFabMenuTrigger
@docs endFabMenu, endFab, endAccordion, endExpansionPanel, endExpansionHeader, endDrawerToggle
@docs endDrawerContainer, endDivider, endDialogTrigger, endDialog, endDialogAction, endDatepickerToggle
@docs endDatepicker, endContentPane, endSuggestionChip, endInputChipSet, endInputChip, endFilterChipSet
@docs endFilterChip, endChipSet, endAssistChip, endChip, endCheckbox, endCard
@docs endCalendar, endYearView, endMultiYearView, endMonthView, endTooltip, endRichTooltip
@docs endTooltipElementBase, endRichTooltipAction, endButtonGroup, endIconButton, endButton, endBreadcrumb
@docs endBreadcrumbItem, endBreadcrumbItemButton, endBottomSheetTrigger, endBottomSheet, endBottomSheetAction, endBadge
@docs endAvatar, endAutocomplete, endFormField, endOptionPanel, endFloatingPanel, endOptgroup
@docs endOption, endFocusTrap, endAppBar, endTextOverflow, endTextHighlight, endStateLayer
@docs endSlide, endScrollContainer, endRipple, endPseudoRadio, endPseudoCheckbox, endFocusRing
@docs endElevation, endCollapsible, endActionElementBase
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


unnamed_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


start_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
start_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


end_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
end_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `DrawerContainer`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tree =
    unnamed_core


{-| Place a `TreeItem` in the `unnamed` slot of `DrawerContainer`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
treeItem =
    unnamed_core


{-| Place a `Toolbar` in the `unnamed` slot of `DrawerContainer`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
toolbar =
    unnamed_core


{-| Place a `Toc` in the `unnamed` slot of `DrawerContainer`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
toc =
    unnamed_core


{-| Place a `TocItem` in the `unnamed` slot of `DrawerContainer`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tocItem =
    unnamed_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `DrawerContainer`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
themeIcon =
    unnamed_core


{-| Place a `Theme` in the `unnamed` slot of `DrawerContainer`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
theme =
    unnamed_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `DrawerContainer`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textareaAutosize =
    unnamed_core


{-| Place a `Tabs` in the `unnamed` slot of `DrawerContainer`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tabs =
    unnamed_core


{-| Place a `TabPanel` in the `unnamed` slot of `DrawerContainer`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tabPanel =
    unnamed_core


{-| Place a `Tab` in the `unnamed` slot of `DrawerContainer`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tab =
    unnamed_core


{-| Place a `Switch` in the `unnamed` slot of `DrawerContainer`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
switch =
    unnamed_core


{-| Place a `StepperReset` in the `unnamed` slot of `DrawerContainer`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    unnamed_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `DrawerContainer`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    unnamed_core


{-| Place a `Step` in the `unnamed` slot of `DrawerContainer`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
step =
    unnamed_core


{-| Place a `StepPanel` in the `unnamed` slot of `DrawerContainer`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepPanel =
    unnamed_core


{-| Place a `Stepper` in the `unnamed` slot of `DrawerContainer`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepper =
    unnamed_core


{-| Place a `SplitPane` in the `unnamed` slot of `DrawerContainer`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
splitPane =
    unnamed_core


{-| Place a `SplitButton` in the `unnamed` slot of `DrawerContainer`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
splitButton =
    unnamed_core


{-| Place a `Snackbar` in the `unnamed` slot of `DrawerContainer`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
snackbar =
    unnamed_core


{-| Place a `Slider` in the `unnamed` slot of `DrawerContainer`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slider =
    unnamed_core


{-| Place a `SliderThumb` in the `unnamed` slot of `DrawerContainer`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
sliderThumb =
    unnamed_core


{-| Place a `SlideGroup` in the `unnamed` slot of `DrawerContainer`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slideGroup =
    unnamed_core


{-| Place a `Skeleton` in the `unnamed` slot of `DrawerContainer`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
skeleton =
    unnamed_core


{-| Place a `Shape` in the `unnamed` slot of `DrawerContainer`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
shape =
    unnamed_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `DrawerContainer`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
segmentedButton =
    unnamed_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `DrawerContainer`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
buttonSegment =
    unnamed_core


{-| Place a `SearchView` in the `unnamed` slot of `DrawerContainer`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
searchView =
    unnamed_core


{-| Place a `SearchBar` in the `unnamed` slot of `DrawerContainer`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
searchBar =
    unnamed_core


{-| Place a `RadioGroup` in the `unnamed` slot of `DrawerContainer`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
radioGroup =
    unnamed_core


{-| Place a `Radio` in the `unnamed` slot of `DrawerContainer`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
radio =
    unnamed_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `DrawerContainer`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
progressElementIndicatorBase =
    unnamed_core


{-| Place a `Paginator` in the `unnamed` slot of `DrawerContainer`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
paginator =
    unnamed_core


{-| Place a `Select` in the `unnamed` slot of `DrawerContainer`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
select =
    unnamed_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `DrawerContainer`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    unnamed_core


{-| Place a `NavRail` in the `unnamed` slot of `DrawerContainer`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navRail =
    unnamed_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `DrawerContainer`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenuItemGroup =
    unnamed_core


{-| Place a `NavMenu` in the `unnamed` slot of `DrawerContainer`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenu =
    unnamed_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `DrawerContainer`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenuItem =
    unnamed_core


{-| Place a `NavBar` in the `unnamed` slot of `DrawerContainer`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navBar =
    unnamed_core


{-| Place a `NavItem` in the `unnamed` slot of `DrawerContainer`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navItem =
    unnamed_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `DrawerContainer`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemRadio =
    unnamed_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `DrawerContainer`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemGroup =
    unnamed_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `DrawerContainer`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemCheckbox =
    unnamed_core


{-| Place a `Menu` in the `unnamed` slot of `DrawerContainer`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menu =
    unnamed_core


{-| Place a `MenuItem` in the `unnamed` slot of `DrawerContainer`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItem =
    unnamed_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `DrawerContainer`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    unnamed_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `DrawerContainer`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemElementBase =
    unnamed_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `DrawerContainer`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
loadingIndicator =
    unnamed_core


{-| Place a `SelectionList` in the `unnamed` slot of `DrawerContainer`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
selectionList =
    unnamed_core


{-| Place a `ListOption` in the `unnamed` slot of `DrawerContainer`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listOption =
    unnamed_core


{-| Place a `ActionList` in the `unnamed` slot of `DrawerContainer`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
actionList =
    unnamed_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `DrawerContainer`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expandableListItem =
    unnamed_core


{-| Place a `ListAction` in the `unnamed` slot of `DrawerContainer`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listAction =
    unnamed_core


{-| Place a `ListItemButton` in the `unnamed` slot of `DrawerContainer`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listItemButton =
    unnamed_core


{-| Place a `List` in the `unnamed` slot of `DrawerContainer`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
list =
    unnamed_core


{-| Place a `ListItem` in the `unnamed` slot of `DrawerContainer`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listItem =
    unnamed_core


{-| Place a `Icon` in the `unnamed` slot of `DrawerContainer`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
icon =
    unnamed_core


{-| Place a `Heading` in the `unnamed` slot of `DrawerContainer`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
heading =
    unnamed_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `DrawerContainer`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    unnamed_core


{-| Place a `FabMenu` in the `unnamed` slot of `DrawerContainer`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fabMenu =
    unnamed_core


{-| Place a `Fab` in the `unnamed` slot of `DrawerContainer`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fab =
    unnamed_core


{-| Place a `Accordion` in the `unnamed` slot of `DrawerContainer`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
accordion =
    unnamed_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `DrawerContainer`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expansionPanel =
    unnamed_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `DrawerContainer`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expansionHeader =
    unnamed_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `DrawerContainer`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    unnamed_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `DrawerContainer`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
drawerContainer =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `DrawerContainer`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
divider =
    unnamed_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `DrawerContainer`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    unnamed_core


{-| Place a `Dialog` in the `unnamed` slot of `DrawerContainer`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialog =
    unnamed_core


{-| Place a `DialogAction` in the `unnamed` slot of `DrawerContainer`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    unnamed_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `DrawerContainer`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    unnamed_core


{-| Place a `Datepicker` in the `unnamed` slot of `DrawerContainer`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
datepicker =
    unnamed_core


{-| Place a `ContentPane` in the `unnamed` slot of `DrawerContainer`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
contentPane =
    unnamed_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `DrawerContainer`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
suggestionChip =
    unnamed_core


{-| Place a `InputChipSet` in the `unnamed` slot of `DrawerContainer`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    unnamed_core


{-| Place a `InputChip` in the `unnamed` slot of `DrawerContainer`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
inputChip =
    unnamed_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `DrawerContainer`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
filterChipSet =
    unnamed_core


{-| Place a `FilterChip` in the `unnamed` slot of `DrawerContainer`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
filterChip =
    unnamed_core


{-| Place a `ChipSet` in the `unnamed` slot of `DrawerContainer`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
chipSet =
    unnamed_core


{-| Place a `AssistChip` in the `unnamed` slot of `DrawerContainer`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
assistChip =
    unnamed_core


{-| Place a `Chip` in the `unnamed` slot of `DrawerContainer`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
chip =
    unnamed_core


{-| Place a `Checkbox` in the `unnamed` slot of `DrawerContainer`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
checkbox =
    unnamed_core


{-| Place a `Card` in the `unnamed` slot of `DrawerContainer`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
card =
    unnamed_core


{-| Place a `Calendar` in the `unnamed` slot of `DrawerContainer`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
calendar =
    unnamed_core


{-| Place a `YearView` in the `unnamed` slot of `DrawerContainer`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
yearView =
    unnamed_core


{-| Place a `MultiYearView` in the `unnamed` slot of `DrawerContainer`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
multiYearView =
    unnamed_core


{-| Place a `MonthView` in the `unnamed` slot of `DrawerContainer`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
monthView =
    unnamed_core


{-| Place a `Tooltip` in the `unnamed` slot of `DrawerContainer`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tooltip =
    unnamed_core


{-| Place a `RichTooltip` in the `unnamed` slot of `DrawerContainer`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
richTooltip =
    unnamed_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `DrawerContainer`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tooltipElementBase =
    unnamed_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `DrawerContainer`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    unnamed_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `DrawerContainer`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
buttonGroup =
    unnamed_core


{-| Place a `IconButton` in the `unnamed` slot of `DrawerContainer`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
iconButton =
    unnamed_core


{-| Place a `Button` in the `unnamed` slot of `DrawerContainer`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
button =
    unnamed_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `DrawerContainer`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumb =
    unnamed_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `DrawerContainer`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumbItem =
    unnamed_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `DrawerContainer`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumbItemButton =
    unnamed_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `DrawerContainer`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    unnamed_core


{-| Place a `BottomSheet` in the `unnamed` slot of `DrawerContainer`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheet =
    unnamed_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `DrawerContainer`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    unnamed_core


{-| Place a `Badge` in the `unnamed` slot of `DrawerContainer`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
badge =
    unnamed_core


{-| Place a `Avatar` in the `unnamed` slot of `DrawerContainer`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
avatar =
    unnamed_core


{-| Place a `Autocomplete` in the `unnamed` slot of `DrawerContainer`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
autocomplete =
    unnamed_core


{-| Place a `FormField` in the `unnamed` slot of `DrawerContainer`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
formField =
    unnamed_core


{-| Place a `OptionPanel` in the `unnamed` slot of `DrawerContainer`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
optionPanel =
    unnamed_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `DrawerContainer`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
floatingPanel =
    unnamed_core


{-| Place a `Optgroup` in the `unnamed` slot of `DrawerContainer`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `DrawerContainer`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
option =
    unnamed_core


{-| Place a `FocusTrap` in the `unnamed` slot of `DrawerContainer`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
focusTrap =
    unnamed_core


{-| Place a `AppBar` in the `unnamed` slot of `DrawerContainer`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
appBar =
    unnamed_core


{-| Place a `TextOverflow` in the `unnamed` slot of `DrawerContainer`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textOverflow =
    unnamed_core


{-| Place a `TextHighlight` in the `unnamed` slot of `DrawerContainer`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textHighlight =
    unnamed_core


{-| Place a `StateLayer` in the `unnamed` slot of `DrawerContainer`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stateLayer =
    unnamed_core


{-| Place a `Slide` in the `unnamed` slot of `DrawerContainer`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slide =
    unnamed_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `DrawerContainer`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
scrollContainer =
    unnamed_core


{-| Place a `Ripple` in the `unnamed` slot of `DrawerContainer`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
ripple =
    unnamed_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `DrawerContainer`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
pseudoRadio =
    unnamed_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `DrawerContainer`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
pseudoCheckbox =
    unnamed_core


{-| Place a `FocusRing` in the `unnamed` slot of `DrawerContainer`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
focusRing =
    unnamed_core


{-| Place a `Elevation` in the `unnamed` slot of `DrawerContainer`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
elevation =
    unnamed_core


{-| Place a `Collapsible` in the `unnamed` slot of `DrawerContainer`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
collapsible =
    unnamed_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `DrawerContainer`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
actionElementBase =
    unnamed_core


{-| Place a `Tree` in the `start` slot of `DrawerContainer`. -}
startTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTree =
    start_core


{-| Place a `TreeItem` in the `start` slot of `DrawerContainer`. -}
startTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTreeItem =
    start_core


{-| Place a `Toolbar` in the `start` slot of `DrawerContainer`. -}
startToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startToolbar =
    start_core


{-| Place a `Toc` in the `start` slot of `DrawerContainer`. -}
startToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startToc =
    start_core


{-| Place a `TocItem` in the `start` slot of `DrawerContainer`. -}
startTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTocItem =
    start_core


{-| Place a `ThemeIcon` in the `start` slot of `DrawerContainer`. -}
startThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startThemeIcon =
    start_core


{-| Place a `Theme` in the `start` slot of `DrawerContainer`. -}
startTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTheme =
    start_core


{-| Place a `TextareaAutosize` in the `start` slot of `DrawerContainer`. -}
startTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextareaAutosize =
    start_core


{-| Place a `Tabs` in the `start` slot of `DrawerContainer`. -}
startTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTabs =
    start_core


{-| Place a `TabPanel` in the `start` slot of `DrawerContainer`. -}
startTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTabPanel =
    start_core


{-| Place a `Tab` in the `start` slot of `DrawerContainer`. -}
startTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTab =
    start_core


{-| Place a `Switch` in the `start` slot of `DrawerContainer`. -}
startSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSwitch =
    start_core


{-| Place a `StepperReset` in the `start` slot of `DrawerContainer`. -}
startStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepperReset =
    start_core


{-| Place a `StepperPrevious` in the `start` slot of `DrawerContainer`. -}
startStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepperPrevious =
    start_core


{-| Place a `Step` in the `start` slot of `DrawerContainer`. -}
startStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStep =
    start_core


{-| Place a `StepPanel` in the `start` slot of `DrawerContainer`. -}
startStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepPanel =
    start_core


{-| Place a `Stepper` in the `start` slot of `DrawerContainer`. -}
startStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepper =
    start_core


{-| Place a `SplitPane` in the `start` slot of `DrawerContainer`. -}
startSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSplitPane =
    start_core


{-| Place a `SplitButton` in the `start` slot of `DrawerContainer`. -}
startSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSplitButton =
    start_core


{-| Place a `Snackbar` in the `start` slot of `DrawerContainer`. -}
startSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSnackbar =
    start_core


{-| Place a `Slider` in the `start` slot of `DrawerContainer`. -}
startSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlider =
    start_core


{-| Place a `SliderThumb` in the `start` slot of `DrawerContainer`. -}
startSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSliderThumb =
    start_core


{-| Place a `SlideGroup` in the `start` slot of `DrawerContainer`. -}
startSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlideGroup =
    start_core


{-| Place a `Skeleton` in the `start` slot of `DrawerContainer`. -}
startSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSkeleton =
    start_core


{-| Place a `Shape` in the `start` slot of `DrawerContainer`. -}
startShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startShape =
    start_core


{-| Place a `SegmentedButton` in the `start` slot of `DrawerContainer`. -}
startSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSegmentedButton =
    start_core


{-| Place a `ButtonSegment` in the `start` slot of `DrawerContainer`. -}
startButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButtonSegment =
    start_core


{-| Place a `SearchView` in the `start` slot of `DrawerContainer`. -}
startSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSearchView =
    start_core


{-| Place a `SearchBar` in the `start` slot of `DrawerContainer`. -}
startSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSearchBar =
    start_core


{-| Place a `RadioGroup` in the `start` slot of `DrawerContainer`. -}
startRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRadioGroup =
    start_core


{-| Place a `Radio` in the `start` slot of `DrawerContainer`. -}
startRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRadio =
    start_core


{-| Place a `ProgressElementIndicatorBase` in the `start` slot of `DrawerContainer`. -}
startProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startProgressElementIndicatorBase =
    start_core


{-| Place a `Paginator` in the `start` slot of `DrawerContainer`. -}
startPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPaginator =
    start_core


{-| Place a `Select` in the `start` slot of `DrawerContainer`. -}
startSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSelect =
    start_core


{-| Place a `NavRailToggle` in the `start` slot of `DrawerContainer`. -}
startNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavRailToggle =
    start_core


{-| Place a `NavRail` in the `start` slot of `DrawerContainer`. -}
startNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavRail =
    start_core


{-| Place a `NavMenuItemGroup` in the `start` slot of `DrawerContainer`. -}
startNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenuItemGroup =
    start_core


{-| Place a `NavMenu` in the `start` slot of `DrawerContainer`. -}
startNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenu =
    start_core


{-| Place a `NavMenuItem` in the `start` slot of `DrawerContainer`. -}
startNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenuItem =
    start_core


{-| Place a `NavBar` in the `start` slot of `DrawerContainer`. -}
startNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavBar =
    start_core


{-| Place a `NavItem` in the `start` slot of `DrawerContainer`. -}
startNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavItem =
    start_core


{-| Place a `MenuItemRadio` in the `start` slot of `DrawerContainer`. -}
startMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemRadio =
    start_core


{-| Place a `MenuItemGroup` in the `start` slot of `DrawerContainer`. -}
startMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemGroup =
    start_core


{-| Place a `MenuItemCheckbox` in the `start` slot of `DrawerContainer`. -}
startMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemCheckbox =
    start_core


{-| Place a `Menu` in the `start` slot of `DrawerContainer`. -}
startMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenu =
    start_core


{-| Place a `MenuItem` in the `start` slot of `DrawerContainer`. -}
startMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItem =
    start_core


{-| Place a `MenuTrigger` in the `start` slot of `DrawerContainer`. -}
startMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuTrigger =
    start_core


{-| Place a `MenuItemElementBase` in the `start` slot of `DrawerContainer`. -}
startMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemElementBase =
    start_core


{-| Place a `LoadingIndicator` in the `start` slot of `DrawerContainer`. -}
startLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startLoadingIndicator =
    start_core


{-| Place a `SelectionList` in the `start` slot of `DrawerContainer`. -}
startSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSelectionList =
    start_core


{-| Place a `ListOption` in the `start` slot of `DrawerContainer`. -}
startListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListOption =
    start_core


{-| Place a `ActionList` in the `start` slot of `DrawerContainer`. -}
startActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startActionList =
    start_core


{-| Place a `ExpandableListItem` in the `start` slot of `DrawerContainer`. -}
startExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpandableListItem =
    start_core


{-| Place a `ListAction` in the `start` slot of `DrawerContainer`. -}
startListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListAction =
    start_core


{-| Place a `ListItemButton` in the `start` slot of `DrawerContainer`. -}
startListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListItemButton =
    start_core


{-| Place a `List` in the `start` slot of `DrawerContainer`. -}
startList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startList =
    start_core


{-| Place a `ListItem` in the `start` slot of `DrawerContainer`. -}
startListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListItem =
    start_core


{-| Place a `Icon` in the `start` slot of `DrawerContainer`. -}
startIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startIcon =
    start_core


{-| Place a `Heading` in the `start` slot of `DrawerContainer`. -}
startHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startHeading =
    start_core


{-| Place a `FabMenuTrigger` in the `start` slot of `DrawerContainer`. -}
startFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFabMenuTrigger =
    start_core


{-| Place a `FabMenu` in the `start` slot of `DrawerContainer`. -}
startFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFabMenu =
    start_core


{-| Place a `Fab` in the `start` slot of `DrawerContainer`. -}
startFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFab =
    start_core


{-| Place a `Accordion` in the `start` slot of `DrawerContainer`. -}
startAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAccordion =
    start_core


{-| Place a `ExpansionPanel` in the `start` slot of `DrawerContainer`. -}
startExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpansionPanel =
    start_core


{-| Place a `ExpansionHeader` in the `start` slot of `DrawerContainer`. -}
startExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpansionHeader =
    start_core


{-| Place a `DrawerToggle` in the `start` slot of `DrawerContainer`. -}
startDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDrawerToggle =
    start_core


{-| Place a `DrawerContainer` in the `start` slot of `DrawerContainer`. -}
startDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDrawerContainer =
    start_core


{-| Place a `Divider` in the `start` slot of `DrawerContainer`. -}
startDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDivider =
    start_core


{-| Place a `DialogTrigger` in the `start` slot of `DrawerContainer`. -}
startDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialogTrigger =
    start_core


{-| Place a `Dialog` in the `start` slot of `DrawerContainer`. -}
startDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialog =
    start_core


{-| Place a `DialogAction` in the `start` slot of `DrawerContainer`. -}
startDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialogAction =
    start_core


{-| Place a `DatepickerToggle` in the `start` slot of `DrawerContainer`. -}
startDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDatepickerToggle =
    start_core


{-| Place a `Datepicker` in the `start` slot of `DrawerContainer`. -}
startDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDatepicker =
    start_core


{-| Place a `ContentPane` in the `start` slot of `DrawerContainer`. -}
startContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startContentPane =
    start_core


{-| Place a `SuggestionChip` in the `start` slot of `DrawerContainer`. -}
startSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSuggestionChip =
    start_core


{-| Place a `InputChipSet` in the `start` slot of `DrawerContainer`. -}
startInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startInputChipSet =
    start_core


{-| Place a `InputChip` in the `start` slot of `DrawerContainer`. -}
startInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startInputChip =
    start_core


{-| Place a `FilterChipSet` in the `start` slot of `DrawerContainer`. -}
startFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFilterChipSet =
    start_core


{-| Place a `FilterChip` in the `start` slot of `DrawerContainer`. -}
startFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFilterChip =
    start_core


{-| Place a `ChipSet` in the `start` slot of `DrawerContainer`. -}
startChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startChipSet =
    start_core


{-| Place a `AssistChip` in the `start` slot of `DrawerContainer`. -}
startAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAssistChip =
    start_core


{-| Place a `Chip` in the `start` slot of `DrawerContainer`. -}
startChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startChip =
    start_core


{-| Place a `Checkbox` in the `start` slot of `DrawerContainer`. -}
startCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCheckbox =
    start_core


{-| Place a `Card` in the `start` slot of `DrawerContainer`. -}
startCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCard =
    start_core


{-| Place a `Calendar` in the `start` slot of `DrawerContainer`. -}
startCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCalendar =
    start_core


{-| Place a `YearView` in the `start` slot of `DrawerContainer`. -}
startYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startYearView =
    start_core


{-| Place a `MultiYearView` in the `start` slot of `DrawerContainer`. -}
startMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMultiYearView =
    start_core


{-| Place a `MonthView` in the `start` slot of `DrawerContainer`. -}
startMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMonthView =
    start_core


{-| Place a `Tooltip` in the `start` slot of `DrawerContainer`. -}
startTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTooltip =
    start_core


{-| Place a `RichTooltip` in the `start` slot of `DrawerContainer`. -}
startRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRichTooltip =
    start_core


{-| Place a `TooltipElementBase` in the `start` slot of `DrawerContainer`. -}
startTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTooltipElementBase =
    start_core


{-| Place a `RichTooltipAction` in the `start` slot of `DrawerContainer`. -}
startRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRichTooltipAction =
    start_core


{-| Place a `ButtonGroup` in the `start` slot of `DrawerContainer`. -}
startButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButtonGroup =
    start_core


{-| Place a `IconButton` in the `start` slot of `DrawerContainer`. -}
startIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startIconButton =
    start_core


{-| Place a `Button` in the `start` slot of `DrawerContainer`. -}
startButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButton =
    start_core


{-| Place a `Breadcrumb` in the `start` slot of `DrawerContainer`. -}
startBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumb =
    start_core


{-| Place a `BreadcrumbItem` in the `start` slot of `DrawerContainer`. -}
startBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumbItem =
    start_core


{-| Place a `BreadcrumbItemButton` in the `start` slot of `DrawerContainer`. -}
startBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumbItemButton =
    start_core


{-| Place a `BottomSheetTrigger` in the `start` slot of `DrawerContainer`. -}
startBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheetTrigger =
    start_core


{-| Place a `BottomSheet` in the `start` slot of `DrawerContainer`. -}
startBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheet =
    start_core


{-| Place a `BottomSheetAction` in the `start` slot of `DrawerContainer`. -}
startBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheetAction =
    start_core


{-| Place a `Badge` in the `start` slot of `DrawerContainer`. -}
startBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBadge =
    start_core


{-| Place a `Avatar` in the `start` slot of `DrawerContainer`. -}
startAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAvatar =
    start_core


{-| Place a `Autocomplete` in the `start` slot of `DrawerContainer`. -}
startAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAutocomplete =
    start_core


{-| Place a `FormField` in the `start` slot of `DrawerContainer`. -}
startFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFormField =
    start_core


{-| Place a `OptionPanel` in the `start` slot of `DrawerContainer`. -}
startOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOptionPanel =
    start_core


{-| Place a `FloatingPanel` in the `start` slot of `DrawerContainer`. -}
startFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFloatingPanel =
    start_core


{-| Place a `Optgroup` in the `start` slot of `DrawerContainer`. -}
startOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOptgroup =
    start_core


{-| Place a `Option` in the `start` slot of `DrawerContainer`. -}
startOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOption =
    start_core


{-| Place a `FocusTrap` in the `start` slot of `DrawerContainer`. -}
startFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFocusTrap =
    start_core


{-| Place a `AppBar` in the `start` slot of `DrawerContainer`. -}
startAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAppBar =
    start_core


{-| Place a `TextOverflow` in the `start` slot of `DrawerContainer`. -}
startTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextOverflow =
    start_core


{-| Place a `TextHighlight` in the `start` slot of `DrawerContainer`. -}
startTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextHighlight =
    start_core


{-| Place a `StateLayer` in the `start` slot of `DrawerContainer`. -}
startStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStateLayer =
    start_core


{-| Place a `Slide` in the `start` slot of `DrawerContainer`. -}
startSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlide =
    start_core


{-| Place a `ScrollContainer` in the `start` slot of `DrawerContainer`. -}
startScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startScrollContainer =
    start_core


{-| Place a `Ripple` in the `start` slot of `DrawerContainer`. -}
startRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRipple =
    start_core


{-| Place a `PseudoRadio` in the `start` slot of `DrawerContainer`. -}
startPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPseudoRadio =
    start_core


{-| Place a `PseudoCheckbox` in the `start` slot of `DrawerContainer`. -}
startPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPseudoCheckbox =
    start_core


{-| Place a `FocusRing` in the `start` slot of `DrawerContainer`. -}
startFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFocusRing =
    start_core


{-| Place a `Elevation` in the `start` slot of `DrawerContainer`. -}
startElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startElevation =
    start_core


{-| Place a `Collapsible` in the `start` slot of `DrawerContainer`. -}
startCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCollapsible =
    start_core


{-| Place a `ActionElementBase` in the `start` slot of `DrawerContainer`. -}
startActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startActionElementBase =
    start_core


{-| Place a `Tree` in the `end` slot of `DrawerContainer`. -}
endTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTree =
    end_core


{-| Place a `TreeItem` in the `end` slot of `DrawerContainer`. -}
endTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTreeItem =
    end_core


{-| Place a `Toolbar` in the `end` slot of `DrawerContainer`. -}
endToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endToolbar =
    end_core


{-| Place a `Toc` in the `end` slot of `DrawerContainer`. -}
endToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endToc =
    end_core


{-| Place a `TocItem` in the `end` slot of `DrawerContainer`. -}
endTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTocItem =
    end_core


{-| Place a `ThemeIcon` in the `end` slot of `DrawerContainer`. -}
endThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endThemeIcon =
    end_core


{-| Place a `Theme` in the `end` slot of `DrawerContainer`. -}
endTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTheme =
    end_core


{-| Place a `TextareaAutosize` in the `end` slot of `DrawerContainer`. -}
endTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextareaAutosize =
    end_core


{-| Place a `Tabs` in the `end` slot of `DrawerContainer`. -}
endTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTabs =
    end_core


{-| Place a `TabPanel` in the `end` slot of `DrawerContainer`. -}
endTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTabPanel =
    end_core


{-| Place a `Tab` in the `end` slot of `DrawerContainer`. -}
endTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTab =
    end_core


{-| Place a `Switch` in the `end` slot of `DrawerContainer`. -}
endSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSwitch =
    end_core


{-| Place a `StepperReset` in the `end` slot of `DrawerContainer`. -}
endStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepperReset =
    end_core


{-| Place a `StepperPrevious` in the `end` slot of `DrawerContainer`. -}
endStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepperPrevious =
    end_core


{-| Place a `Step` in the `end` slot of `DrawerContainer`. -}
endStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStep =
    end_core


{-| Place a `StepPanel` in the `end` slot of `DrawerContainer`. -}
endStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepPanel =
    end_core


{-| Place a `Stepper` in the `end` slot of `DrawerContainer`. -}
endStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepper =
    end_core


{-| Place a `SplitPane` in the `end` slot of `DrawerContainer`. -}
endSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSplitPane =
    end_core


{-| Place a `SplitButton` in the `end` slot of `DrawerContainer`. -}
endSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSplitButton =
    end_core


{-| Place a `Snackbar` in the `end` slot of `DrawerContainer`. -}
endSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSnackbar =
    end_core


{-| Place a `Slider` in the `end` slot of `DrawerContainer`. -}
endSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlider =
    end_core


{-| Place a `SliderThumb` in the `end` slot of `DrawerContainer`. -}
endSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSliderThumb =
    end_core


{-| Place a `SlideGroup` in the `end` slot of `DrawerContainer`. -}
endSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlideGroup =
    end_core


{-| Place a `Skeleton` in the `end` slot of `DrawerContainer`. -}
endSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSkeleton =
    end_core


{-| Place a `Shape` in the `end` slot of `DrawerContainer`. -}
endShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endShape =
    end_core


{-| Place a `SegmentedButton` in the `end` slot of `DrawerContainer`. -}
endSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSegmentedButton =
    end_core


{-| Place a `ButtonSegment` in the `end` slot of `DrawerContainer`. -}
endButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButtonSegment =
    end_core


{-| Place a `SearchView` in the `end` slot of `DrawerContainer`. -}
endSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSearchView =
    end_core


{-| Place a `SearchBar` in the `end` slot of `DrawerContainer`. -}
endSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSearchBar =
    end_core


{-| Place a `RadioGroup` in the `end` slot of `DrawerContainer`. -}
endRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRadioGroup =
    end_core


{-| Place a `Radio` in the `end` slot of `DrawerContainer`. -}
endRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRadio =
    end_core


{-| Place a `ProgressElementIndicatorBase` in the `end` slot of `DrawerContainer`. -}
endProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endProgressElementIndicatorBase =
    end_core


{-| Place a `Paginator` in the `end` slot of `DrawerContainer`. -}
endPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPaginator =
    end_core


{-| Place a `Select` in the `end` slot of `DrawerContainer`. -}
endSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSelect =
    end_core


{-| Place a `NavRailToggle` in the `end` slot of `DrawerContainer`. -}
endNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavRailToggle =
    end_core


{-| Place a `NavRail` in the `end` slot of `DrawerContainer`. -}
endNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavRail =
    end_core


{-| Place a `NavMenuItemGroup` in the `end` slot of `DrawerContainer`. -}
endNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenuItemGroup =
    end_core


{-| Place a `NavMenu` in the `end` slot of `DrawerContainer`. -}
endNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenu =
    end_core


{-| Place a `NavMenuItem` in the `end` slot of `DrawerContainer`. -}
endNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenuItem =
    end_core


{-| Place a `NavBar` in the `end` slot of `DrawerContainer`. -}
endNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavBar =
    end_core


{-| Place a `NavItem` in the `end` slot of `DrawerContainer`. -}
endNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavItem =
    end_core


{-| Place a `MenuItemRadio` in the `end` slot of `DrawerContainer`. -}
endMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemRadio =
    end_core


{-| Place a `MenuItemGroup` in the `end` slot of `DrawerContainer`. -}
endMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemGroup =
    end_core


{-| Place a `MenuItemCheckbox` in the `end` slot of `DrawerContainer`. -}
endMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemCheckbox =
    end_core


{-| Place a `Menu` in the `end` slot of `DrawerContainer`. -}
endMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenu =
    end_core


{-| Place a `MenuItem` in the `end` slot of `DrawerContainer`. -}
endMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItem =
    end_core


{-| Place a `MenuTrigger` in the `end` slot of `DrawerContainer`. -}
endMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuTrigger =
    end_core


{-| Place a `MenuItemElementBase` in the `end` slot of `DrawerContainer`. -}
endMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemElementBase =
    end_core


{-| Place a `LoadingIndicator` in the `end` slot of `DrawerContainer`. -}
endLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endLoadingIndicator =
    end_core


{-| Place a `SelectionList` in the `end` slot of `DrawerContainer`. -}
endSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSelectionList =
    end_core


{-| Place a `ListOption` in the `end` slot of `DrawerContainer`. -}
endListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListOption =
    end_core


{-| Place a `ActionList` in the `end` slot of `DrawerContainer`. -}
endActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endActionList =
    end_core


{-| Place a `ExpandableListItem` in the `end` slot of `DrawerContainer`. -}
endExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpandableListItem =
    end_core


{-| Place a `ListAction` in the `end` slot of `DrawerContainer`. -}
endListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListAction =
    end_core


{-| Place a `ListItemButton` in the `end` slot of `DrawerContainer`. -}
endListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListItemButton =
    end_core


{-| Place a `List` in the `end` slot of `DrawerContainer`. -}
endList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endList =
    end_core


{-| Place a `ListItem` in the `end` slot of `DrawerContainer`. -}
endListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListItem =
    end_core


{-| Place a `Icon` in the `end` slot of `DrawerContainer`. -}
endIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endIcon =
    end_core


{-| Place a `Heading` in the `end` slot of `DrawerContainer`. -}
endHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endHeading =
    end_core


{-| Place a `FabMenuTrigger` in the `end` slot of `DrawerContainer`. -}
endFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFabMenuTrigger =
    end_core


{-| Place a `FabMenu` in the `end` slot of `DrawerContainer`. -}
endFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFabMenu =
    end_core


{-| Place a `Fab` in the `end` slot of `DrawerContainer`. -}
endFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFab =
    end_core


{-| Place a `Accordion` in the `end` slot of `DrawerContainer`. -}
endAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAccordion =
    end_core


{-| Place a `ExpansionPanel` in the `end` slot of `DrawerContainer`. -}
endExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpansionPanel =
    end_core


{-| Place a `ExpansionHeader` in the `end` slot of `DrawerContainer`. -}
endExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpansionHeader =
    end_core


{-| Place a `DrawerToggle` in the `end` slot of `DrawerContainer`. -}
endDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDrawerToggle =
    end_core


{-| Place a `DrawerContainer` in the `end` slot of `DrawerContainer`. -}
endDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDrawerContainer =
    end_core


{-| Place a `Divider` in the `end` slot of `DrawerContainer`. -}
endDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDivider =
    end_core


{-| Place a `DialogTrigger` in the `end` slot of `DrawerContainer`. -}
endDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialogTrigger =
    end_core


{-| Place a `Dialog` in the `end` slot of `DrawerContainer`. -}
endDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialog =
    end_core


{-| Place a `DialogAction` in the `end` slot of `DrawerContainer`. -}
endDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialogAction =
    end_core


{-| Place a `DatepickerToggle` in the `end` slot of `DrawerContainer`. -}
endDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDatepickerToggle =
    end_core


{-| Place a `Datepicker` in the `end` slot of `DrawerContainer`. -}
endDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDatepicker =
    end_core


{-| Place a `ContentPane` in the `end` slot of `DrawerContainer`. -}
endContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endContentPane =
    end_core


{-| Place a `SuggestionChip` in the `end` slot of `DrawerContainer`. -}
endSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSuggestionChip =
    end_core


{-| Place a `InputChipSet` in the `end` slot of `DrawerContainer`. -}
endInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endInputChipSet =
    end_core


{-| Place a `InputChip` in the `end` slot of `DrawerContainer`. -}
endInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endInputChip =
    end_core


{-| Place a `FilterChipSet` in the `end` slot of `DrawerContainer`. -}
endFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFilterChipSet =
    end_core


{-| Place a `FilterChip` in the `end` slot of `DrawerContainer`. -}
endFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFilterChip =
    end_core


{-| Place a `ChipSet` in the `end` slot of `DrawerContainer`. -}
endChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endChipSet =
    end_core


{-| Place a `AssistChip` in the `end` slot of `DrawerContainer`. -}
endAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAssistChip =
    end_core


{-| Place a `Chip` in the `end` slot of `DrawerContainer`. -}
endChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endChip =
    end_core


{-| Place a `Checkbox` in the `end` slot of `DrawerContainer`. -}
endCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCheckbox =
    end_core


{-| Place a `Card` in the `end` slot of `DrawerContainer`. -}
endCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCard =
    end_core


{-| Place a `Calendar` in the `end` slot of `DrawerContainer`. -}
endCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCalendar =
    end_core


{-| Place a `YearView` in the `end` slot of `DrawerContainer`. -}
endYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endYearView =
    end_core


{-| Place a `MultiYearView` in the `end` slot of `DrawerContainer`. -}
endMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMultiYearView =
    end_core


{-| Place a `MonthView` in the `end` slot of `DrawerContainer`. -}
endMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMonthView =
    end_core


{-| Place a `Tooltip` in the `end` slot of `DrawerContainer`. -}
endTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTooltip =
    end_core


{-| Place a `RichTooltip` in the `end` slot of `DrawerContainer`. -}
endRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRichTooltip =
    end_core


{-| Place a `TooltipElementBase` in the `end` slot of `DrawerContainer`. -}
endTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTooltipElementBase =
    end_core


{-| Place a `RichTooltipAction` in the `end` slot of `DrawerContainer`. -}
endRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRichTooltipAction =
    end_core


{-| Place a `ButtonGroup` in the `end` slot of `DrawerContainer`. -}
endButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButtonGroup =
    end_core


{-| Place a `IconButton` in the `end` slot of `DrawerContainer`. -}
endIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endIconButton =
    end_core


{-| Place a `Button` in the `end` slot of `DrawerContainer`. -}
endButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButton =
    end_core


{-| Place a `Breadcrumb` in the `end` slot of `DrawerContainer`. -}
endBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumb =
    end_core


{-| Place a `BreadcrumbItem` in the `end` slot of `DrawerContainer`. -}
endBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumbItem =
    end_core


{-| Place a `BreadcrumbItemButton` in the `end` slot of `DrawerContainer`. -}
endBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumbItemButton =
    end_core


{-| Place a `BottomSheetTrigger` in the `end` slot of `DrawerContainer`. -}
endBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheetTrigger =
    end_core


{-| Place a `BottomSheet` in the `end` slot of `DrawerContainer`. -}
endBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheet =
    end_core


{-| Place a `BottomSheetAction` in the `end` slot of `DrawerContainer`. -}
endBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheetAction =
    end_core


{-| Place a `Badge` in the `end` slot of `DrawerContainer`. -}
endBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBadge =
    end_core


{-| Place a `Avatar` in the `end` slot of `DrawerContainer`. -}
endAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAvatar =
    end_core


{-| Place a `Autocomplete` in the `end` slot of `DrawerContainer`. -}
endAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAutocomplete =
    end_core


{-| Place a `FormField` in the `end` slot of `DrawerContainer`. -}
endFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFormField =
    end_core


{-| Place a `OptionPanel` in the `end` slot of `DrawerContainer`. -}
endOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOptionPanel =
    end_core


{-| Place a `FloatingPanel` in the `end` slot of `DrawerContainer`. -}
endFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFloatingPanel =
    end_core


{-| Place a `Optgroup` in the `end` slot of `DrawerContainer`. -}
endOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOptgroup =
    end_core


{-| Place a `Option` in the `end` slot of `DrawerContainer`. -}
endOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOption =
    end_core


{-| Place a `FocusTrap` in the `end` slot of `DrawerContainer`. -}
endFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFocusTrap =
    end_core


{-| Place a `AppBar` in the `end` slot of `DrawerContainer`. -}
endAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAppBar =
    end_core


{-| Place a `TextOverflow` in the `end` slot of `DrawerContainer`. -}
endTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextOverflow =
    end_core


{-| Place a `TextHighlight` in the `end` slot of `DrawerContainer`. -}
endTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextHighlight =
    end_core


{-| Place a `StateLayer` in the `end` slot of `DrawerContainer`. -}
endStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStateLayer =
    end_core


{-| Place a `Slide` in the `end` slot of `DrawerContainer`. -}
endSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlide =
    end_core


{-| Place a `ScrollContainer` in the `end` slot of `DrawerContainer`. -}
endScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endScrollContainer =
    end_core


{-| Place a `Ripple` in the `end` slot of `DrawerContainer`. -}
endRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRipple =
    end_core


{-| Place a `PseudoRadio` in the `end` slot of `DrawerContainer`. -}
endPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPseudoRadio =
    end_core


{-| Place a `PseudoCheckbox` in the `end` slot of `DrawerContainer`. -}
endPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPseudoCheckbox =
    end_core


{-| Place a `FocusRing` in the `end` slot of `DrawerContainer`. -}
endFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFocusRing =
    end_core


{-| Place a `Elevation` in the `end` slot of `DrawerContainer`. -}
endElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endElevation =
    end_core


{-| Place a `Collapsible` in the `end` slot of `DrawerContainer`. -}
endCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCollapsible =
    end_core


{-| Place a `ActionElementBase` in the `end` slot of `DrawerContainer`. -}
endActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.DrawerContainer.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endActionElementBase =
    end_core