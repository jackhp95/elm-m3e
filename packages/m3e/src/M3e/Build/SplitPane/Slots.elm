module M3e.Build.SplitPane.Slots exposing
    ( startTree, startTreeItem, startToolbar, startToc, startTocItem, startThemeIcon
    , startTheme, startTextareaAutosize, startTabs, startTabPanel, startTab, startSwitch, startStepperReset
    , startStepperPrevious, startStep, startStepPanel, startStepper, startSplitPane, startSplitButton, startSnackbar
    , startSlider, startSliderThumb, startSlideGroup, startSkeleton, startShape, startSegmentedButton, startButtonSegment
    , startSearchView, startSearchBar, startRadioGroup, startRadio, startProgressElementIndicatorBase, startPaginator, startSelect
    , startNavRailToggle, startNavRail, startNavMenuItemGroup, startNavMenu, startNavMenuItem, startNavBar, startNavItem
    , startMenuItemRadio, startMenuItemGroup, startMenuItemCheckbox, startMenu, startMenuItem, startMenuTrigger, startMenuItemElementBase
    , startLoadingIndicator, startSelectionList, startListOption, startActionList, startExpandableListItem, startListAction, startListItemButton
    , startList, startListItem, startIcon, startHeading, startFabMenuTrigger, startFabMenu, startFab
    , startAccordion, startExpansionPanel, startExpansionHeader, startDrawerToggle, startDrawerContainer, startDivider, startDialogTrigger
    , startDialog, startDialogAction, startDatepickerToggle, startDatepicker, startContentPane, startSuggestionChip, startInputChipSet
    , startInputChip, startFilterChipSet, startFilterChip, startChipSet, startAssistChip, startChip, startCheckbox
    , startCard, startCalendar, startYearView, startMultiYearView, startMonthView, startTooltip, startRichTooltip
    , startTooltipElementBase, startRichTooltipAction, startButtonGroup, startIconButton, startButton, startBreadcrumb, startBreadcrumbItem
    , startBreadcrumbItemButton, startBottomSheetTrigger, startBottomSheet, startBottomSheetAction, startBadge, startAvatar, startAutocomplete
    , startFormField, startOptionPanel, startFloatingPanel, startOptgroup, startOption, startFocusTrap, startAppBar
    , startTextOverflow, startTextHighlight, startStateLayer, startSlide, startScrollContainer, startRipple, startPseudoRadio
    , startPseudoCheckbox, startFocusRing, startElevation, startCollapsible, startActionElementBase, endTree, endTreeItem
    , endToolbar, endToc, endTocItem, endThemeIcon, endTheme, endTextareaAutosize, endTabs
    , endTabPanel, endTab, endSwitch, endStepperReset, endStepperPrevious, endStep, endStepPanel
    , endStepper, endSplitPane, endSplitButton, endSnackbar, endSlider, endSliderThumb, endSlideGroup
    , endSkeleton, endShape, endSegmentedButton, endButtonSegment, endSearchView, endSearchBar, endRadioGroup
    , endRadio, endProgressElementIndicatorBase, endPaginator, endSelect, endNavRailToggle, endNavRail, endNavMenuItemGroup
    , endNavMenu, endNavMenuItem, endNavBar, endNavItem, endMenuItemRadio, endMenuItemGroup, endMenuItemCheckbox
    , endMenu, endMenuItem, endMenuTrigger, endMenuItemElementBase, endLoadingIndicator, endSelectionList, endListOption
    , endActionList, endExpandableListItem, endListAction, endListItemButton, endList, endListItem, endIcon
    , endHeading, endFabMenuTrigger, endFabMenu, endFab, endAccordion, endExpansionPanel, endExpansionHeader
    , endDrawerToggle, endDrawerContainer, endDivider, endDialogTrigger, endDialog, endDialogAction, endDatepickerToggle
    , endDatepicker, endContentPane, endSuggestionChip, endInputChipSet, endInputChip, endFilterChipSet, endFilterChip
    , endChipSet, endAssistChip, endChip, endCheckbox, endCard, endCalendar, endYearView
    , endMultiYearView, endMonthView, endTooltip, endRichTooltip, endTooltipElementBase, endRichTooltipAction, endButtonGroup
    , endIconButton, endButton, endBreadcrumb, endBreadcrumbItem, endBreadcrumbItemButton, endBottomSheetTrigger, endBottomSheet
    , endBottomSheetAction, endBadge, endAvatar, endAutocomplete, endFormField, endOptionPanel, endFloatingPanel
    , endOptgroup, endOption, endFocusTrap, endAppBar, endTextOverflow, endTextHighlight, endStateLayer
    , endSlide, endScrollContainer, endRipple, endPseudoRadio, endPseudoCheckbox, endFocusRing, endElevation
    , endCollapsible, endActionElementBase
    )

{-|
Slot setters for `M3e.Build.SplitPane`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs startTree, startTreeItem, startToolbar, startToc, startTocItem, startThemeIcon
@docs startTheme, startTextareaAutosize, startTabs, startTabPanel, startTab, startSwitch
@docs startStepperReset, startStepperPrevious, startStep, startStepPanel, startStepper, startSplitPane
@docs startSplitButton, startSnackbar, startSlider, startSliderThumb, startSlideGroup, startSkeleton
@docs startShape, startSegmentedButton, startButtonSegment, startSearchView, startSearchBar, startRadioGroup
@docs startRadio, startProgressElementIndicatorBase, startPaginator, startSelect, startNavRailToggle, startNavRail
@docs startNavMenuItemGroup, startNavMenu, startNavMenuItem, startNavBar, startNavItem, startMenuItemRadio
@docs startMenuItemGroup, startMenuItemCheckbox, startMenu, startMenuItem, startMenuTrigger, startMenuItemElementBase
@docs startLoadingIndicator, startSelectionList, startListOption, startActionList, startExpandableListItem, startListAction
@docs startListItemButton, startList, startListItem, startIcon, startHeading, startFabMenuTrigger
@docs startFabMenu, startFab, startAccordion, startExpansionPanel, startExpansionHeader, startDrawerToggle
@docs startDrawerContainer, startDivider, startDialogTrigger, startDialog, startDialogAction, startDatepickerToggle
@docs startDatepicker, startContentPane, startSuggestionChip, startInputChipSet, startInputChip, startFilterChipSet
@docs startFilterChip, startChipSet, startAssistChip, startChip, startCheckbox, startCard
@docs startCalendar, startYearView, startMultiYearView, startMonthView, startTooltip, startRichTooltip
@docs startTooltipElementBase, startRichTooltipAction, startButtonGroup, startIconButton, startButton, startBreadcrumb
@docs startBreadcrumbItem, startBreadcrumbItemButton, startBottomSheetTrigger, startBottomSheet, startBottomSheetAction, startBadge
@docs startAvatar, startAutocomplete, startFormField, startOptionPanel, startFloatingPanel, startOptgroup
@docs startOption, startFocusTrap, startAppBar, startTextOverflow, startTextHighlight, startStateLayer
@docs startSlide, startScrollContainer, startRipple, startPseudoRadio, startPseudoCheckbox, startFocusRing
@docs startElevation, startCollapsible, startActionElementBase, endTree, endTreeItem, endToolbar
@docs endToc, endTocItem, endThemeIcon, endTheme, endTextareaAutosize, endTabs
@docs endTabPanel, endTab, endSwitch, endStepperReset, endStepperPrevious, endStep
@docs endStepPanel, endStepper, endSplitPane, endSplitButton, endSnackbar, endSlider
@docs endSliderThumb, endSlideGroup, endSkeleton, endShape, endSegmentedButton, endButtonSegment
@docs endSearchView, endSearchBar, endRadioGroup, endRadio, endProgressElementIndicatorBase, endPaginator
@docs endSelect, endNavRailToggle, endNavRail, endNavMenuItemGroup, endNavMenu, endNavMenuItem
@docs endNavBar, endNavItem, endMenuItemRadio, endMenuItemGroup, endMenuItemCheckbox, endMenu
@docs endMenuItem, endMenuTrigger, endMenuItemElementBase, endLoadingIndicator, endSelectionList, endListOption
@docs endActionList, endExpandableListItem, endListAction, endListItemButton, endList, endListItem
@docs endIcon, endHeading, endFabMenuTrigger, endFabMenu, endFab, endAccordion
@docs endExpansionPanel, endExpansionHeader, endDrawerToggle, endDrawerContainer, endDivider, endDialogTrigger
@docs endDialog, endDialogAction, endDatepickerToggle, endDatepicker, endContentPane, endSuggestionChip
@docs endInputChipSet, endInputChip, endFilterChipSet, endFilterChip, endChipSet, endAssistChip
@docs endChip, endCheckbox, endCard, endCalendar, endYearView, endMultiYearView
@docs endMonthView, endTooltip, endRichTooltip, endTooltipElementBase, endRichTooltipAction, endButtonGroup
@docs endIconButton, endButton, endBreadcrumb, endBreadcrumbItem, endBreadcrumbItemButton, endBottomSheetTrigger
@docs endBottomSheet, endBottomSheetAction, endBadge, endAvatar, endAutocomplete, endFormField
@docs endOptionPanel, endFloatingPanel, endOptgroup, endOption, endFocusTrap, endAppBar
@docs endTextOverflow, endTextHighlight, endStateLayer, endSlide, endScrollContainer, endRipple
@docs endPseudoRadio, endPseudoCheckbox, endFocusRing, endElevation, endCollapsible, endActionElementBase
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


start_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
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
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
end_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `start` slot of `SplitPane`. -}
startTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTree =
    start_core


{-| Place a `TreeItem` in the `start` slot of `SplitPane`. -}
startTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTreeItem =
    start_core


{-| Place a `Toolbar` in the `start` slot of `SplitPane`. -}
startToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startToolbar =
    start_core


{-| Place a `Toc` in the `start` slot of `SplitPane`. -}
startToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startToc =
    start_core


{-| Place a `TocItem` in the `start` slot of `SplitPane`. -}
startTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTocItem =
    start_core


{-| Place a `ThemeIcon` in the `start` slot of `SplitPane`. -}
startThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startThemeIcon =
    start_core


{-| Place a `Theme` in the `start` slot of `SplitPane`. -}
startTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTheme =
    start_core


{-| Place a `TextareaAutosize` in the `start` slot of `SplitPane`. -}
startTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextareaAutosize =
    start_core


{-| Place a `Tabs` in the `start` slot of `SplitPane`. -}
startTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTabs =
    start_core


{-| Place a `TabPanel` in the `start` slot of `SplitPane`. -}
startTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTabPanel =
    start_core


{-| Place a `Tab` in the `start` slot of `SplitPane`. -}
startTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTab =
    start_core


{-| Place a `Switch` in the `start` slot of `SplitPane`. -}
startSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSwitch =
    start_core


{-| Place a `StepperReset` in the `start` slot of `SplitPane`. -}
startStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepperReset =
    start_core


{-| Place a `StepperPrevious` in the `start` slot of `SplitPane`. -}
startStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepperPrevious =
    start_core


{-| Place a `Step` in the `start` slot of `SplitPane`. -}
startStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStep =
    start_core


{-| Place a `StepPanel` in the `start` slot of `SplitPane`. -}
startStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepPanel =
    start_core


{-| Place a `Stepper` in the `start` slot of `SplitPane`. -}
startStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStepper =
    start_core


{-| Place a `SplitPane` in the `start` slot of `SplitPane`. -}
startSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSplitPane =
    start_core


{-| Place a `SplitButton` in the `start` slot of `SplitPane`. -}
startSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSplitButton =
    start_core


{-| Place a `Snackbar` in the `start` slot of `SplitPane`. -}
startSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSnackbar =
    start_core


{-| Place a `Slider` in the `start` slot of `SplitPane`. -}
startSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlider =
    start_core


{-| Place a `SliderThumb` in the `start` slot of `SplitPane`. -}
startSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSliderThumb =
    start_core


{-| Place a `SlideGroup` in the `start` slot of `SplitPane`. -}
startSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlideGroup =
    start_core


{-| Place a `Skeleton` in the `start` slot of `SplitPane`. -}
startSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSkeleton =
    start_core


{-| Place a `Shape` in the `start` slot of `SplitPane`. -}
startShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startShape =
    start_core


{-| Place a `SegmentedButton` in the `start` slot of `SplitPane`. -}
startSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSegmentedButton =
    start_core


{-| Place a `ButtonSegment` in the `start` slot of `SplitPane`. -}
startButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButtonSegment =
    start_core


{-| Place a `SearchView` in the `start` slot of `SplitPane`. -}
startSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSearchView =
    start_core


{-| Place a `SearchBar` in the `start` slot of `SplitPane`. -}
startSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSearchBar =
    start_core


{-| Place a `RadioGroup` in the `start` slot of `SplitPane`. -}
startRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRadioGroup =
    start_core


{-| Place a `Radio` in the `start` slot of `SplitPane`. -}
startRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRadio =
    start_core


{-| Place a `ProgressElementIndicatorBase` in the `start` slot of `SplitPane`. -}
startProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startProgressElementIndicatorBase =
    start_core


{-| Place a `Paginator` in the `start` slot of `SplitPane`. -}
startPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPaginator =
    start_core


{-| Place a `Select` in the `start` slot of `SplitPane`. -}
startSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSelect =
    start_core


{-| Place a `NavRailToggle` in the `start` slot of `SplitPane`. -}
startNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavRailToggle =
    start_core


{-| Place a `NavRail` in the `start` slot of `SplitPane`. -}
startNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavRail =
    start_core


{-| Place a `NavMenuItemGroup` in the `start` slot of `SplitPane`. -}
startNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenuItemGroup =
    start_core


{-| Place a `NavMenu` in the `start` slot of `SplitPane`. -}
startNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenu =
    start_core


{-| Place a `NavMenuItem` in the `start` slot of `SplitPane`. -}
startNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavMenuItem =
    start_core


{-| Place a `NavBar` in the `start` slot of `SplitPane`. -}
startNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavBar =
    start_core


{-| Place a `NavItem` in the `start` slot of `SplitPane`. -}
startNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startNavItem =
    start_core


{-| Place a `MenuItemRadio` in the `start` slot of `SplitPane`. -}
startMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemRadio =
    start_core


{-| Place a `MenuItemGroup` in the `start` slot of `SplitPane`. -}
startMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemGroup =
    start_core


{-| Place a `MenuItemCheckbox` in the `start` slot of `SplitPane`. -}
startMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemCheckbox =
    start_core


{-| Place a `Menu` in the `start` slot of `SplitPane`. -}
startMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenu =
    start_core


{-| Place a `MenuItem` in the `start` slot of `SplitPane`. -}
startMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItem =
    start_core


{-| Place a `MenuTrigger` in the `start` slot of `SplitPane`. -}
startMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuTrigger =
    start_core


{-| Place a `MenuItemElementBase` in the `start` slot of `SplitPane`. -}
startMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMenuItemElementBase =
    start_core


{-| Place a `LoadingIndicator` in the `start` slot of `SplitPane`. -}
startLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startLoadingIndicator =
    start_core


{-| Place a `SelectionList` in the `start` slot of `SplitPane`. -}
startSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSelectionList =
    start_core


{-| Place a `ListOption` in the `start` slot of `SplitPane`. -}
startListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListOption =
    start_core


{-| Place a `ActionList` in the `start` slot of `SplitPane`. -}
startActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startActionList =
    start_core


{-| Place a `ExpandableListItem` in the `start` slot of `SplitPane`. -}
startExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpandableListItem =
    start_core


{-| Place a `ListAction` in the `start` slot of `SplitPane`. -}
startListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListAction =
    start_core


{-| Place a `ListItemButton` in the `start` slot of `SplitPane`. -}
startListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListItemButton =
    start_core


{-| Place a `List` in the `start` slot of `SplitPane`. -}
startList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startList =
    start_core


{-| Place a `ListItem` in the `start` slot of `SplitPane`. -}
startListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startListItem =
    start_core


{-| Place a `Icon` in the `start` slot of `SplitPane`. -}
startIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startIcon =
    start_core


{-| Place a `Heading` in the `start` slot of `SplitPane`. -}
startHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startHeading =
    start_core


{-| Place a `FabMenuTrigger` in the `start` slot of `SplitPane`. -}
startFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFabMenuTrigger =
    start_core


{-| Place a `FabMenu` in the `start` slot of `SplitPane`. -}
startFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFabMenu =
    start_core


{-| Place a `Fab` in the `start` slot of `SplitPane`. -}
startFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFab =
    start_core


{-| Place a `Accordion` in the `start` slot of `SplitPane`. -}
startAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAccordion =
    start_core


{-| Place a `ExpansionPanel` in the `start` slot of `SplitPane`. -}
startExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpansionPanel =
    start_core


{-| Place a `ExpansionHeader` in the `start` slot of `SplitPane`. -}
startExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startExpansionHeader =
    start_core


{-| Place a `DrawerToggle` in the `start` slot of `SplitPane`. -}
startDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDrawerToggle =
    start_core


{-| Place a `DrawerContainer` in the `start` slot of `SplitPane`. -}
startDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDrawerContainer =
    start_core


{-| Place a `Divider` in the `start` slot of `SplitPane`. -}
startDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDivider =
    start_core


{-| Place a `DialogTrigger` in the `start` slot of `SplitPane`. -}
startDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialogTrigger =
    start_core


{-| Place a `Dialog` in the `start` slot of `SplitPane`. -}
startDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialog =
    start_core


{-| Place a `DialogAction` in the `start` slot of `SplitPane`. -}
startDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDialogAction =
    start_core


{-| Place a `DatepickerToggle` in the `start` slot of `SplitPane`. -}
startDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDatepickerToggle =
    start_core


{-| Place a `Datepicker` in the `start` slot of `SplitPane`. -}
startDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startDatepicker =
    start_core


{-| Place a `ContentPane` in the `start` slot of `SplitPane`. -}
startContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startContentPane =
    start_core


{-| Place a `SuggestionChip` in the `start` slot of `SplitPane`. -}
startSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSuggestionChip =
    start_core


{-| Place a `InputChipSet` in the `start` slot of `SplitPane`. -}
startInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startInputChipSet =
    start_core


{-| Place a `InputChip` in the `start` slot of `SplitPane`. -}
startInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startInputChip =
    start_core


{-| Place a `FilterChipSet` in the `start` slot of `SplitPane`. -}
startFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFilterChipSet =
    start_core


{-| Place a `FilterChip` in the `start` slot of `SplitPane`. -}
startFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFilterChip =
    start_core


{-| Place a `ChipSet` in the `start` slot of `SplitPane`. -}
startChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startChipSet =
    start_core


{-| Place a `AssistChip` in the `start` slot of `SplitPane`. -}
startAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAssistChip =
    start_core


{-| Place a `Chip` in the `start` slot of `SplitPane`. -}
startChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startChip =
    start_core


{-| Place a `Checkbox` in the `start` slot of `SplitPane`. -}
startCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCheckbox =
    start_core


{-| Place a `Card` in the `start` slot of `SplitPane`. -}
startCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCard =
    start_core


{-| Place a `Calendar` in the `start` slot of `SplitPane`. -}
startCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCalendar =
    start_core


{-| Place a `YearView` in the `start` slot of `SplitPane`. -}
startYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startYearView =
    start_core


{-| Place a `MultiYearView` in the `start` slot of `SplitPane`. -}
startMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMultiYearView =
    start_core


{-| Place a `MonthView` in the `start` slot of `SplitPane`. -}
startMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startMonthView =
    start_core


{-| Place a `Tooltip` in the `start` slot of `SplitPane`. -}
startTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTooltip =
    start_core


{-| Place a `RichTooltip` in the `start` slot of `SplitPane`. -}
startRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRichTooltip =
    start_core


{-| Place a `TooltipElementBase` in the `start` slot of `SplitPane`. -}
startTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTooltipElementBase =
    start_core


{-| Place a `RichTooltipAction` in the `start` slot of `SplitPane`. -}
startRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRichTooltipAction =
    start_core


{-| Place a `ButtonGroup` in the `start` slot of `SplitPane`. -}
startButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButtonGroup =
    start_core


{-| Place a `IconButton` in the `start` slot of `SplitPane`. -}
startIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startIconButton =
    start_core


{-| Place a `Button` in the `start` slot of `SplitPane`. -}
startButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startButton =
    start_core


{-| Place a `Breadcrumb` in the `start` slot of `SplitPane`. -}
startBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumb =
    start_core


{-| Place a `BreadcrumbItem` in the `start` slot of `SplitPane`. -}
startBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumbItem =
    start_core


{-| Place a `BreadcrumbItemButton` in the `start` slot of `SplitPane`. -}
startBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBreadcrumbItemButton =
    start_core


{-| Place a `BottomSheetTrigger` in the `start` slot of `SplitPane`. -}
startBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheetTrigger =
    start_core


{-| Place a `BottomSheet` in the `start` slot of `SplitPane`. -}
startBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheet =
    start_core


{-| Place a `BottomSheetAction` in the `start` slot of `SplitPane`. -}
startBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBottomSheetAction =
    start_core


{-| Place a `Badge` in the `start` slot of `SplitPane`. -}
startBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startBadge =
    start_core


{-| Place a `Avatar` in the `start` slot of `SplitPane`. -}
startAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAvatar =
    start_core


{-| Place a `Autocomplete` in the `start` slot of `SplitPane`. -}
startAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAutocomplete =
    start_core


{-| Place a `FormField` in the `start` slot of `SplitPane`. -}
startFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFormField =
    start_core


{-| Place a `OptionPanel` in the `start` slot of `SplitPane`. -}
startOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOptionPanel =
    start_core


{-| Place a `FloatingPanel` in the `start` slot of `SplitPane`. -}
startFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFloatingPanel =
    start_core


{-| Place a `Optgroup` in the `start` slot of `SplitPane`. -}
startOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOptgroup =
    start_core


{-| Place a `Option` in the `start` slot of `SplitPane`. -}
startOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startOption =
    start_core


{-| Place a `FocusTrap` in the `start` slot of `SplitPane`. -}
startFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFocusTrap =
    start_core


{-| Place a `AppBar` in the `start` slot of `SplitPane`. -}
startAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startAppBar =
    start_core


{-| Place a `TextOverflow` in the `start` slot of `SplitPane`. -}
startTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextOverflow =
    start_core


{-| Place a `TextHighlight` in the `start` slot of `SplitPane`. -}
startTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startTextHighlight =
    start_core


{-| Place a `StateLayer` in the `start` slot of `SplitPane`. -}
startStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startStateLayer =
    start_core


{-| Place a `Slide` in the `start` slot of `SplitPane`. -}
startSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startSlide =
    start_core


{-| Place a `ScrollContainer` in the `start` slot of `SplitPane`. -}
startScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startScrollContainer =
    start_core


{-| Place a `Ripple` in the `start` slot of `SplitPane`. -}
startRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startRipple =
    start_core


{-| Place a `PseudoRadio` in the `start` slot of `SplitPane`. -}
startPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPseudoRadio =
    start_core


{-| Place a `PseudoCheckbox` in the `start` slot of `SplitPane`. -}
startPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startPseudoCheckbox =
    start_core


{-| Place a `FocusRing` in the `start` slot of `SplitPane`. -}
startFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startFocusRing =
    start_core


{-| Place a `Elevation` in the `start` slot of `SplitPane`. -}
startElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startElevation =
    start_core


{-| Place a `Collapsible` in the `start` slot of `SplitPane`. -}
startCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startCollapsible =
    start_core


{-| Place a `ActionElementBase` in the `start` slot of `SplitPane`. -}
startActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
startActionElementBase =
    start_core


{-| Place a `Tree` in the `end` slot of `SplitPane`. -}
endTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTree =
    end_core


{-| Place a `TreeItem` in the `end` slot of `SplitPane`. -}
endTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTreeItem =
    end_core


{-| Place a `Toolbar` in the `end` slot of `SplitPane`. -}
endToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endToolbar =
    end_core


{-| Place a `Toc` in the `end` slot of `SplitPane`. -}
endToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endToc =
    end_core


{-| Place a `TocItem` in the `end` slot of `SplitPane`. -}
endTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTocItem =
    end_core


{-| Place a `ThemeIcon` in the `end` slot of `SplitPane`. -}
endThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endThemeIcon =
    end_core


{-| Place a `Theme` in the `end` slot of `SplitPane`. -}
endTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTheme =
    end_core


{-| Place a `TextareaAutosize` in the `end` slot of `SplitPane`. -}
endTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextareaAutosize =
    end_core


{-| Place a `Tabs` in the `end` slot of `SplitPane`. -}
endTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTabs =
    end_core


{-| Place a `TabPanel` in the `end` slot of `SplitPane`. -}
endTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTabPanel =
    end_core


{-| Place a `Tab` in the `end` slot of `SplitPane`. -}
endTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTab =
    end_core


{-| Place a `Switch` in the `end` slot of `SplitPane`. -}
endSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSwitch =
    end_core


{-| Place a `StepperReset` in the `end` slot of `SplitPane`. -}
endStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepperReset =
    end_core


{-| Place a `StepperPrevious` in the `end` slot of `SplitPane`. -}
endStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepperPrevious =
    end_core


{-| Place a `Step` in the `end` slot of `SplitPane`. -}
endStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStep =
    end_core


{-| Place a `StepPanel` in the `end` slot of `SplitPane`. -}
endStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepPanel =
    end_core


{-| Place a `Stepper` in the `end` slot of `SplitPane`. -}
endStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStepper =
    end_core


{-| Place a `SplitPane` in the `end` slot of `SplitPane`. -}
endSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSplitPane =
    end_core


{-| Place a `SplitButton` in the `end` slot of `SplitPane`. -}
endSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSplitButton =
    end_core


{-| Place a `Snackbar` in the `end` slot of `SplitPane`. -}
endSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSnackbar =
    end_core


{-| Place a `Slider` in the `end` slot of `SplitPane`. -}
endSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlider =
    end_core


{-| Place a `SliderThumb` in the `end` slot of `SplitPane`. -}
endSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSliderThumb =
    end_core


{-| Place a `SlideGroup` in the `end` slot of `SplitPane`. -}
endSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlideGroup =
    end_core


{-| Place a `Skeleton` in the `end` slot of `SplitPane`. -}
endSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSkeleton =
    end_core


{-| Place a `Shape` in the `end` slot of `SplitPane`. -}
endShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endShape =
    end_core


{-| Place a `SegmentedButton` in the `end` slot of `SplitPane`. -}
endSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSegmentedButton =
    end_core


{-| Place a `ButtonSegment` in the `end` slot of `SplitPane`. -}
endButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButtonSegment =
    end_core


{-| Place a `SearchView` in the `end` slot of `SplitPane`. -}
endSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSearchView =
    end_core


{-| Place a `SearchBar` in the `end` slot of `SplitPane`. -}
endSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSearchBar =
    end_core


{-| Place a `RadioGroup` in the `end` slot of `SplitPane`. -}
endRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRadioGroup =
    end_core


{-| Place a `Radio` in the `end` slot of `SplitPane`. -}
endRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRadio =
    end_core


{-| Place a `ProgressElementIndicatorBase` in the `end` slot of `SplitPane`. -}
endProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endProgressElementIndicatorBase =
    end_core


{-| Place a `Paginator` in the `end` slot of `SplitPane`. -}
endPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPaginator =
    end_core


{-| Place a `Select` in the `end` slot of `SplitPane`. -}
endSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSelect =
    end_core


{-| Place a `NavRailToggle` in the `end` slot of `SplitPane`. -}
endNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavRailToggle =
    end_core


{-| Place a `NavRail` in the `end` slot of `SplitPane`. -}
endNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavRail =
    end_core


{-| Place a `NavMenuItemGroup` in the `end` slot of `SplitPane`. -}
endNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenuItemGroup =
    end_core


{-| Place a `NavMenu` in the `end` slot of `SplitPane`. -}
endNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenu =
    end_core


{-| Place a `NavMenuItem` in the `end` slot of `SplitPane`. -}
endNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavMenuItem =
    end_core


{-| Place a `NavBar` in the `end` slot of `SplitPane`. -}
endNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavBar =
    end_core


{-| Place a `NavItem` in the `end` slot of `SplitPane`. -}
endNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endNavItem =
    end_core


{-| Place a `MenuItemRadio` in the `end` slot of `SplitPane`. -}
endMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemRadio =
    end_core


{-| Place a `MenuItemGroup` in the `end` slot of `SplitPane`. -}
endMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemGroup =
    end_core


{-| Place a `MenuItemCheckbox` in the `end` slot of `SplitPane`. -}
endMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemCheckbox =
    end_core


{-| Place a `Menu` in the `end` slot of `SplitPane`. -}
endMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenu =
    end_core


{-| Place a `MenuItem` in the `end` slot of `SplitPane`. -}
endMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItem =
    end_core


{-| Place a `MenuTrigger` in the `end` slot of `SplitPane`. -}
endMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuTrigger =
    end_core


{-| Place a `MenuItemElementBase` in the `end` slot of `SplitPane`. -}
endMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMenuItemElementBase =
    end_core


{-| Place a `LoadingIndicator` in the `end` slot of `SplitPane`. -}
endLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endLoadingIndicator =
    end_core


{-| Place a `SelectionList` in the `end` slot of `SplitPane`. -}
endSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSelectionList =
    end_core


{-| Place a `ListOption` in the `end` slot of `SplitPane`. -}
endListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListOption =
    end_core


{-| Place a `ActionList` in the `end` slot of `SplitPane`. -}
endActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endActionList =
    end_core


{-| Place a `ExpandableListItem` in the `end` slot of `SplitPane`. -}
endExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpandableListItem =
    end_core


{-| Place a `ListAction` in the `end` slot of `SplitPane`. -}
endListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListAction =
    end_core


{-| Place a `ListItemButton` in the `end` slot of `SplitPane`. -}
endListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListItemButton =
    end_core


{-| Place a `List` in the `end` slot of `SplitPane`. -}
endList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endList =
    end_core


{-| Place a `ListItem` in the `end` slot of `SplitPane`. -}
endListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endListItem =
    end_core


{-| Place a `Icon` in the `end` slot of `SplitPane`. -}
endIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endIcon =
    end_core


{-| Place a `Heading` in the `end` slot of `SplitPane`. -}
endHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endHeading =
    end_core


{-| Place a `FabMenuTrigger` in the `end` slot of `SplitPane`. -}
endFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFabMenuTrigger =
    end_core


{-| Place a `FabMenu` in the `end` slot of `SplitPane`. -}
endFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFabMenu =
    end_core


{-| Place a `Fab` in the `end` slot of `SplitPane`. -}
endFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFab =
    end_core


{-| Place a `Accordion` in the `end` slot of `SplitPane`. -}
endAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAccordion =
    end_core


{-| Place a `ExpansionPanel` in the `end` slot of `SplitPane`. -}
endExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpansionPanel =
    end_core


{-| Place a `ExpansionHeader` in the `end` slot of `SplitPane`. -}
endExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endExpansionHeader =
    end_core


{-| Place a `DrawerToggle` in the `end` slot of `SplitPane`. -}
endDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDrawerToggle =
    end_core


{-| Place a `DrawerContainer` in the `end` slot of `SplitPane`. -}
endDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDrawerContainer =
    end_core


{-| Place a `Divider` in the `end` slot of `SplitPane`. -}
endDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDivider =
    end_core


{-| Place a `DialogTrigger` in the `end` slot of `SplitPane`. -}
endDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialogTrigger =
    end_core


{-| Place a `Dialog` in the `end` slot of `SplitPane`. -}
endDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialog =
    end_core


{-| Place a `DialogAction` in the `end` slot of `SplitPane`. -}
endDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDialogAction =
    end_core


{-| Place a `DatepickerToggle` in the `end` slot of `SplitPane`. -}
endDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDatepickerToggle =
    end_core


{-| Place a `Datepicker` in the `end` slot of `SplitPane`. -}
endDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endDatepicker =
    end_core


{-| Place a `ContentPane` in the `end` slot of `SplitPane`. -}
endContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endContentPane =
    end_core


{-| Place a `SuggestionChip` in the `end` slot of `SplitPane`. -}
endSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSuggestionChip =
    end_core


{-| Place a `InputChipSet` in the `end` slot of `SplitPane`. -}
endInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endInputChipSet =
    end_core


{-| Place a `InputChip` in the `end` slot of `SplitPane`. -}
endInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endInputChip =
    end_core


{-| Place a `FilterChipSet` in the `end` slot of `SplitPane`. -}
endFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFilterChipSet =
    end_core


{-| Place a `FilterChip` in the `end` slot of `SplitPane`. -}
endFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFilterChip =
    end_core


{-| Place a `ChipSet` in the `end` slot of `SplitPane`. -}
endChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endChipSet =
    end_core


{-| Place a `AssistChip` in the `end` slot of `SplitPane`. -}
endAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAssistChip =
    end_core


{-| Place a `Chip` in the `end` slot of `SplitPane`. -}
endChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endChip =
    end_core


{-| Place a `Checkbox` in the `end` slot of `SplitPane`. -}
endCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCheckbox =
    end_core


{-| Place a `Card` in the `end` slot of `SplitPane`. -}
endCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCard =
    end_core


{-| Place a `Calendar` in the `end` slot of `SplitPane`. -}
endCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCalendar =
    end_core


{-| Place a `YearView` in the `end` slot of `SplitPane`. -}
endYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endYearView =
    end_core


{-| Place a `MultiYearView` in the `end` slot of `SplitPane`. -}
endMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMultiYearView =
    end_core


{-| Place a `MonthView` in the `end` slot of `SplitPane`. -}
endMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endMonthView =
    end_core


{-| Place a `Tooltip` in the `end` slot of `SplitPane`. -}
endTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTooltip =
    end_core


{-| Place a `RichTooltip` in the `end` slot of `SplitPane`. -}
endRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRichTooltip =
    end_core


{-| Place a `TooltipElementBase` in the `end` slot of `SplitPane`. -}
endTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTooltipElementBase =
    end_core


{-| Place a `RichTooltipAction` in the `end` slot of `SplitPane`. -}
endRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRichTooltipAction =
    end_core


{-| Place a `ButtonGroup` in the `end` slot of `SplitPane`. -}
endButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButtonGroup =
    end_core


{-| Place a `IconButton` in the `end` slot of `SplitPane`. -}
endIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endIconButton =
    end_core


{-| Place a `Button` in the `end` slot of `SplitPane`. -}
endButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endButton =
    end_core


{-| Place a `Breadcrumb` in the `end` slot of `SplitPane`. -}
endBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumb =
    end_core


{-| Place a `BreadcrumbItem` in the `end` slot of `SplitPane`. -}
endBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumbItem =
    end_core


{-| Place a `BreadcrumbItemButton` in the `end` slot of `SplitPane`. -}
endBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBreadcrumbItemButton =
    end_core


{-| Place a `BottomSheetTrigger` in the `end` slot of `SplitPane`. -}
endBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheetTrigger =
    end_core


{-| Place a `BottomSheet` in the `end` slot of `SplitPane`. -}
endBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheet =
    end_core


{-| Place a `BottomSheetAction` in the `end` slot of `SplitPane`. -}
endBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBottomSheetAction =
    end_core


{-| Place a `Badge` in the `end` slot of `SplitPane`. -}
endBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endBadge =
    end_core


{-| Place a `Avatar` in the `end` slot of `SplitPane`. -}
endAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAvatar =
    end_core


{-| Place a `Autocomplete` in the `end` slot of `SplitPane`. -}
endAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAutocomplete =
    end_core


{-| Place a `FormField` in the `end` slot of `SplitPane`. -}
endFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFormField =
    end_core


{-| Place a `OptionPanel` in the `end` slot of `SplitPane`. -}
endOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOptionPanel =
    end_core


{-| Place a `FloatingPanel` in the `end` slot of `SplitPane`. -}
endFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFloatingPanel =
    end_core


{-| Place a `Optgroup` in the `end` slot of `SplitPane`. -}
endOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOptgroup =
    end_core


{-| Place a `Option` in the `end` slot of `SplitPane`. -}
endOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endOption =
    end_core


{-| Place a `FocusTrap` in the `end` slot of `SplitPane`. -}
endFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFocusTrap =
    end_core


{-| Place a `AppBar` in the `end` slot of `SplitPane`. -}
endAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endAppBar =
    end_core


{-| Place a `TextOverflow` in the `end` slot of `SplitPane`. -}
endTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextOverflow =
    end_core


{-| Place a `TextHighlight` in the `end` slot of `SplitPane`. -}
endTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endTextHighlight =
    end_core


{-| Place a `StateLayer` in the `end` slot of `SplitPane`. -}
endStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endStateLayer =
    end_core


{-| Place a `Slide` in the `end` slot of `SplitPane`. -}
endSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endSlide =
    end_core


{-| Place a `ScrollContainer` in the `end` slot of `SplitPane`. -}
endScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endScrollContainer =
    end_core


{-| Place a `Ripple` in the `end` slot of `SplitPane`. -}
endRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endRipple =
    end_core


{-| Place a `PseudoRadio` in the `end` slot of `SplitPane`. -}
endPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPseudoRadio =
    end_core


{-| Place a `PseudoCheckbox` in the `end` slot of `SplitPane`. -}
endPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endPseudoCheckbox =
    end_core


{-| Place a `FocusRing` in the `end` slot of `SplitPane`. -}
endFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endFocusRing =
    end_core


{-| Place a `Elevation` in the `end` slot of `SplitPane`. -}
endElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endElevation =
    end_core


{-| Place a `Collapsible` in the `end` slot of `SplitPane`. -}
endCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endCollapsible =
    end_core


{-| Place a `ActionElementBase` in the `end` slot of `SplitPane`. -}
endActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
endActionElementBase =
    end_core