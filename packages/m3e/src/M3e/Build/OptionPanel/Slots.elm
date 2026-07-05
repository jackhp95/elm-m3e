module M3e.Build.OptionPanel.Slots exposing
    ( noDataTree, noDataTreeItem, noDataToolbar, noDataToc, noDataTocItem, noDataThemeIcon
    , noDataTheme, noDataTextareaAutosize, noDataTabs, noDataTabPanel, noDataTab, noDataSwitch, noDataStepperReset
    , noDataStepperPrevious, noDataStep, noDataStepPanel, noDataStepper, noDataSplitPane, noDataSplitButton, noDataSnackbar
    , noDataSlider, noDataSliderThumb, noDataSlideGroup, noDataSkeleton, noDataShape, noDataSegmentedButton, noDataButtonSegment
    , noDataSearchView, noDataSearchBar, noDataRadioGroup, noDataRadio, noDataProgressElementIndicatorBase, noDataPaginator, noDataSelect
    , noDataNavRailToggle, noDataNavRail, noDataNavMenuItemGroup, noDataNavMenu, noDataNavMenuItem, noDataNavBar, noDataNavItem
    , noDataMenuItemRadio, noDataMenuItemGroup, noDataMenuItemCheckbox, noDataMenu, noDataMenuItem, noDataMenuTrigger, noDataMenuItemElementBase
    , noDataLoadingIndicator, noDataSelectionList, noDataListOption, noDataActionList, noDataExpandableListItem, noDataListAction, noDataListItemButton
    , noDataList, noDataListItem, noDataIcon, noDataHeading, noDataFabMenuTrigger, noDataFabMenu, noDataFab
    , noDataAccordion, noDataExpansionPanel, noDataExpansionHeader, noDataDrawerToggle, noDataDrawerContainer, noDataDivider, noDataDialogTrigger
    , noDataDialog, noDataDialogAction, noDataDatepickerToggle, noDataDatepicker, noDataContentPane, noDataSuggestionChip, noDataInputChipSet
    , noDataInputChip, noDataFilterChipSet, noDataFilterChip, noDataChipSet, noDataAssistChip, noDataChip, noDataCheckbox
    , noDataCard, noDataCalendar, noDataYearView, noDataMultiYearView, noDataMonthView, noDataTooltip, noDataRichTooltip
    , noDataTooltipElementBase, noDataRichTooltipAction, noDataButtonGroup, noDataIconButton, noDataButton, noDataBreadcrumb, noDataBreadcrumbItem
    , noDataBreadcrumbItemButton, noDataBottomSheetTrigger, noDataBottomSheet, noDataBottomSheetAction, noDataBadge, noDataAvatar, noDataAutocomplete
    , noDataFormField, noDataOptionPanel, noDataFloatingPanel, noDataOptgroup, noDataOption, noDataFocusTrap, noDataAppBar
    , noDataTextOverflow, noDataTextHighlight, noDataStateLayer, noDataSlide, noDataScrollContainer, noDataRipple, noDataPseudoRadio
    , noDataPseudoCheckbox, noDataFocusRing, noDataElevation, noDataCollapsible, noDataActionElementBase
    )

{-|
Slot setters for `M3e.Build.OptionPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs noDataTree, noDataTreeItem, noDataToolbar, noDataToc, noDataTocItem, noDataThemeIcon
@docs noDataTheme, noDataTextareaAutosize, noDataTabs, noDataTabPanel, noDataTab, noDataSwitch
@docs noDataStepperReset, noDataStepperPrevious, noDataStep, noDataStepPanel, noDataStepper, noDataSplitPane
@docs noDataSplitButton, noDataSnackbar, noDataSlider, noDataSliderThumb, noDataSlideGroup, noDataSkeleton
@docs noDataShape, noDataSegmentedButton, noDataButtonSegment, noDataSearchView, noDataSearchBar, noDataRadioGroup
@docs noDataRadio, noDataProgressElementIndicatorBase, noDataPaginator, noDataSelect, noDataNavRailToggle, noDataNavRail
@docs noDataNavMenuItemGroup, noDataNavMenu, noDataNavMenuItem, noDataNavBar, noDataNavItem, noDataMenuItemRadio
@docs noDataMenuItemGroup, noDataMenuItemCheckbox, noDataMenu, noDataMenuItem, noDataMenuTrigger, noDataMenuItemElementBase
@docs noDataLoadingIndicator, noDataSelectionList, noDataListOption, noDataActionList, noDataExpandableListItem, noDataListAction
@docs noDataListItemButton, noDataList, noDataListItem, noDataIcon, noDataHeading, noDataFabMenuTrigger
@docs noDataFabMenu, noDataFab, noDataAccordion, noDataExpansionPanel, noDataExpansionHeader, noDataDrawerToggle
@docs noDataDrawerContainer, noDataDivider, noDataDialogTrigger, noDataDialog, noDataDialogAction, noDataDatepickerToggle
@docs noDataDatepicker, noDataContentPane, noDataSuggestionChip, noDataInputChipSet, noDataInputChip, noDataFilterChipSet
@docs noDataFilterChip, noDataChipSet, noDataAssistChip, noDataChip, noDataCheckbox, noDataCard
@docs noDataCalendar, noDataYearView, noDataMultiYearView, noDataMonthView, noDataTooltip, noDataRichTooltip
@docs noDataTooltipElementBase, noDataRichTooltipAction, noDataButtonGroup, noDataIconButton, noDataButton, noDataBreadcrumb
@docs noDataBreadcrumbItem, noDataBreadcrumbItemButton, noDataBottomSheetTrigger, noDataBottomSheet, noDataBottomSheetAction, noDataBadge
@docs noDataAvatar, noDataAutocomplete, noDataFormField, noDataOptionPanel, noDataFloatingPanel, noDataOptgroup
@docs noDataOption, noDataFocusTrap, noDataAppBar, noDataTextOverflow, noDataTextHighlight, noDataStateLayer
@docs noDataSlide, noDataScrollContainer, noDataRipple, noDataPseudoRadio, noDataPseudoCheckbox, noDataFocusRing
@docs noDataElevation, noDataCollapsible, noDataActionElementBase
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


noData_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noData_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `no-data` slot of `OptionPanel`. -}
noDataTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTree =
    noData_core


{-| Place a `TreeItem` in the `no-data` slot of `OptionPanel`. -}
noDataTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTreeItem =
    noData_core


{-| Place a `Toolbar` in the `no-data` slot of `OptionPanel`. -}
noDataToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataToolbar =
    noData_core


{-| Place a `Toc` in the `no-data` slot of `OptionPanel`. -}
noDataToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataToc =
    noData_core


{-| Place a `TocItem` in the `no-data` slot of `OptionPanel`. -}
noDataTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTocItem =
    noData_core


{-| Place a `ThemeIcon` in the `no-data` slot of `OptionPanel`. -}
noDataThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataThemeIcon =
    noData_core


{-| Place a `Theme` in the `no-data` slot of `OptionPanel`. -}
noDataTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTheme =
    noData_core


{-| Place a `TextareaAutosize` in the `no-data` slot of `OptionPanel`. -}
noDataTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextareaAutosize =
    noData_core


{-| Place a `Tabs` in the `no-data` slot of `OptionPanel`. -}
noDataTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTabs =
    noData_core


{-| Place a `TabPanel` in the `no-data` slot of `OptionPanel`. -}
noDataTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTabPanel =
    noData_core


{-| Place a `Tab` in the `no-data` slot of `OptionPanel`. -}
noDataTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTab =
    noData_core


{-| Place a `Switch` in the `no-data` slot of `OptionPanel`. -}
noDataSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSwitch =
    noData_core


{-| Place a `StepperReset` in the `no-data` slot of `OptionPanel`. -}
noDataStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepperReset =
    noData_core


{-| Place a `StepperPrevious` in the `no-data` slot of `OptionPanel`. -}
noDataStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepperPrevious =
    noData_core


{-| Place a `Step` in the `no-data` slot of `OptionPanel`. -}
noDataStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStep =
    noData_core


{-| Place a `StepPanel` in the `no-data` slot of `OptionPanel`. -}
noDataStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepPanel =
    noData_core


{-| Place a `Stepper` in the `no-data` slot of `OptionPanel`. -}
noDataStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepper =
    noData_core


{-| Place a `SplitPane` in the `no-data` slot of `OptionPanel`. -}
noDataSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSplitPane =
    noData_core


{-| Place a `SplitButton` in the `no-data` slot of `OptionPanel`. -}
noDataSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSplitButton =
    noData_core


{-| Place a `Snackbar` in the `no-data` slot of `OptionPanel`. -}
noDataSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSnackbar =
    noData_core


{-| Place a `Slider` in the `no-data` slot of `OptionPanel`. -}
noDataSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlider =
    noData_core


{-| Place a `SliderThumb` in the `no-data` slot of `OptionPanel`. -}
noDataSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSliderThumb =
    noData_core


{-| Place a `SlideGroup` in the `no-data` slot of `OptionPanel`. -}
noDataSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlideGroup =
    noData_core


{-| Place a `Skeleton` in the `no-data` slot of `OptionPanel`. -}
noDataSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSkeleton =
    noData_core


{-| Place a `Shape` in the `no-data` slot of `OptionPanel`. -}
noDataShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataShape =
    noData_core


{-| Place a `SegmentedButton` in the `no-data` slot of `OptionPanel`. -}
noDataSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSegmentedButton =
    noData_core


{-| Place a `ButtonSegment` in the `no-data` slot of `OptionPanel`. -}
noDataButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButtonSegment =
    noData_core


{-| Place a `SearchView` in the `no-data` slot of `OptionPanel`. -}
noDataSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSearchView =
    noData_core


{-| Place a `SearchBar` in the `no-data` slot of `OptionPanel`. -}
noDataSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSearchBar =
    noData_core


{-| Place a `RadioGroup` in the `no-data` slot of `OptionPanel`. -}
noDataRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRadioGroup =
    noData_core


{-| Place a `Radio` in the `no-data` slot of `OptionPanel`. -}
noDataRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRadio =
    noData_core


{-| Place a `ProgressElementIndicatorBase` in the `no-data` slot of `OptionPanel`. -}
noDataProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataProgressElementIndicatorBase =
    noData_core


{-| Place a `Paginator` in the `no-data` slot of `OptionPanel`. -}
noDataPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPaginator =
    noData_core


{-| Place a `Select` in the `no-data` slot of `OptionPanel`. -}
noDataSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSelect =
    noData_core


{-| Place a `NavRailToggle` in the `no-data` slot of `OptionPanel`. -}
noDataNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavRailToggle =
    noData_core


{-| Place a `NavRail` in the `no-data` slot of `OptionPanel`. -}
noDataNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavRail =
    noData_core


{-| Place a `NavMenuItemGroup` in the `no-data` slot of `OptionPanel`. -}
noDataNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenuItemGroup =
    noData_core


{-| Place a `NavMenu` in the `no-data` slot of `OptionPanel`. -}
noDataNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenu =
    noData_core


{-| Place a `NavMenuItem` in the `no-data` slot of `OptionPanel`. -}
noDataNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenuItem =
    noData_core


{-| Place a `NavBar` in the `no-data` slot of `OptionPanel`. -}
noDataNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavBar =
    noData_core


{-| Place a `NavItem` in the `no-data` slot of `OptionPanel`. -}
noDataNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavItem =
    noData_core


{-| Place a `MenuItemRadio` in the `no-data` slot of `OptionPanel`. -}
noDataMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemRadio =
    noData_core


{-| Place a `MenuItemGroup` in the `no-data` slot of `OptionPanel`. -}
noDataMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemGroup =
    noData_core


{-| Place a `MenuItemCheckbox` in the `no-data` slot of `OptionPanel`. -}
noDataMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemCheckbox =
    noData_core


{-| Place a `Menu` in the `no-data` slot of `OptionPanel`. -}
noDataMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenu =
    noData_core


{-| Place a `MenuItem` in the `no-data` slot of `OptionPanel`. -}
noDataMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItem =
    noData_core


{-| Place a `MenuTrigger` in the `no-data` slot of `OptionPanel`. -}
noDataMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuTrigger =
    noData_core


{-| Place a `MenuItemElementBase` in the `no-data` slot of `OptionPanel`. -}
noDataMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemElementBase =
    noData_core


{-| Place a `LoadingIndicator` in the `no-data` slot of `OptionPanel`. -}
noDataLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataLoadingIndicator =
    noData_core


{-| Place a `SelectionList` in the `no-data` slot of `OptionPanel`. -}
noDataSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSelectionList =
    noData_core


{-| Place a `ListOption` in the `no-data` slot of `OptionPanel`. -}
noDataListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListOption =
    noData_core


{-| Place a `ActionList` in the `no-data` slot of `OptionPanel`. -}
noDataActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataActionList =
    noData_core


{-| Place a `ExpandableListItem` in the `no-data` slot of `OptionPanel`. -}
noDataExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpandableListItem =
    noData_core


{-| Place a `ListAction` in the `no-data` slot of `OptionPanel`. -}
noDataListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListAction =
    noData_core


{-| Place a `ListItemButton` in the `no-data` slot of `OptionPanel`. -}
noDataListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListItemButton =
    noData_core


{-| Place a `List` in the `no-data` slot of `OptionPanel`. -}
noDataList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataList =
    noData_core


{-| Place a `ListItem` in the `no-data` slot of `OptionPanel`. -}
noDataListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListItem =
    noData_core


{-| Place a `Icon` in the `no-data` slot of `OptionPanel`. -}
noDataIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataIcon =
    noData_core


{-| Place a `Heading` in the `no-data` slot of `OptionPanel`. -}
noDataHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataHeading =
    noData_core


{-| Place a `FabMenuTrigger` in the `no-data` slot of `OptionPanel`. -}
noDataFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFabMenuTrigger =
    noData_core


{-| Place a `FabMenu` in the `no-data` slot of `OptionPanel`. -}
noDataFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFabMenu =
    noData_core


{-| Place a `Fab` in the `no-data` slot of `OptionPanel`. -}
noDataFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFab =
    noData_core


{-| Place a `Accordion` in the `no-data` slot of `OptionPanel`. -}
noDataAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAccordion =
    noData_core


{-| Place a `ExpansionPanel` in the `no-data` slot of `OptionPanel`. -}
noDataExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpansionPanel =
    noData_core


{-| Place a `ExpansionHeader` in the `no-data` slot of `OptionPanel`. -}
noDataExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpansionHeader =
    noData_core


{-| Place a `DrawerToggle` in the `no-data` slot of `OptionPanel`. -}
noDataDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDrawerToggle =
    noData_core


{-| Place a `DrawerContainer` in the `no-data` slot of `OptionPanel`. -}
noDataDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDrawerContainer =
    noData_core


{-| Place a `Divider` in the `no-data` slot of `OptionPanel`. -}
noDataDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDivider =
    noData_core


{-| Place a `DialogTrigger` in the `no-data` slot of `OptionPanel`. -}
noDataDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialogTrigger =
    noData_core


{-| Place a `Dialog` in the `no-data` slot of `OptionPanel`. -}
noDataDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialog =
    noData_core


{-| Place a `DialogAction` in the `no-data` slot of `OptionPanel`. -}
noDataDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialogAction =
    noData_core


{-| Place a `DatepickerToggle` in the `no-data` slot of `OptionPanel`. -}
noDataDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDatepickerToggle =
    noData_core


{-| Place a `Datepicker` in the `no-data` slot of `OptionPanel`. -}
noDataDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDatepicker =
    noData_core


{-| Place a `ContentPane` in the `no-data` slot of `OptionPanel`. -}
noDataContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataContentPane =
    noData_core


{-| Place a `SuggestionChip` in the `no-data` slot of `OptionPanel`. -}
noDataSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSuggestionChip =
    noData_core


{-| Place a `InputChipSet` in the `no-data` slot of `OptionPanel`. -}
noDataInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataInputChipSet =
    noData_core


{-| Place a `InputChip` in the `no-data` slot of `OptionPanel`. -}
noDataInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataInputChip =
    noData_core


{-| Place a `FilterChipSet` in the `no-data` slot of `OptionPanel`. -}
noDataFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFilterChipSet =
    noData_core


{-| Place a `FilterChip` in the `no-data` slot of `OptionPanel`. -}
noDataFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFilterChip =
    noData_core


{-| Place a `ChipSet` in the `no-data` slot of `OptionPanel`. -}
noDataChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataChipSet =
    noData_core


{-| Place a `AssistChip` in the `no-data` slot of `OptionPanel`. -}
noDataAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAssistChip =
    noData_core


{-| Place a `Chip` in the `no-data` slot of `OptionPanel`. -}
noDataChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataChip =
    noData_core


{-| Place a `Checkbox` in the `no-data` slot of `OptionPanel`. -}
noDataCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCheckbox =
    noData_core


{-| Place a `Card` in the `no-data` slot of `OptionPanel`. -}
noDataCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCard =
    noData_core


{-| Place a `Calendar` in the `no-data` slot of `OptionPanel`. -}
noDataCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCalendar =
    noData_core


{-| Place a `YearView` in the `no-data` slot of `OptionPanel`. -}
noDataYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataYearView =
    noData_core


{-| Place a `MultiYearView` in the `no-data` slot of `OptionPanel`. -}
noDataMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMultiYearView =
    noData_core


{-| Place a `MonthView` in the `no-data` slot of `OptionPanel`. -}
noDataMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMonthView =
    noData_core


{-| Place a `Tooltip` in the `no-data` slot of `OptionPanel`. -}
noDataTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTooltip =
    noData_core


{-| Place a `RichTooltip` in the `no-data` slot of `OptionPanel`. -}
noDataRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRichTooltip =
    noData_core


{-| Place a `TooltipElementBase` in the `no-data` slot of `OptionPanel`. -}
noDataTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTooltipElementBase =
    noData_core


{-| Place a `RichTooltipAction` in the `no-data` slot of `OptionPanel`. -}
noDataRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRichTooltipAction =
    noData_core


{-| Place a `ButtonGroup` in the `no-data` slot of `OptionPanel`. -}
noDataButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButtonGroup =
    noData_core


{-| Place a `IconButton` in the `no-data` slot of `OptionPanel`. -}
noDataIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataIconButton =
    noData_core


{-| Place a `Button` in the `no-data` slot of `OptionPanel`. -}
noDataButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButton =
    noData_core


{-| Place a `Breadcrumb` in the `no-data` slot of `OptionPanel`. -}
noDataBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumb =
    noData_core


{-| Place a `BreadcrumbItem` in the `no-data` slot of `OptionPanel`. -}
noDataBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumbItem =
    noData_core


{-| Place a `BreadcrumbItemButton` in the `no-data` slot of `OptionPanel`. -}
noDataBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumbItemButton =
    noData_core


{-| Place a `BottomSheetTrigger` in the `no-data` slot of `OptionPanel`. -}
noDataBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheetTrigger =
    noData_core


{-| Place a `BottomSheet` in the `no-data` slot of `OptionPanel`. -}
noDataBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheet =
    noData_core


{-| Place a `BottomSheetAction` in the `no-data` slot of `OptionPanel`. -}
noDataBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheetAction =
    noData_core


{-| Place a `Badge` in the `no-data` slot of `OptionPanel`. -}
noDataBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBadge =
    noData_core


{-| Place a `Avatar` in the `no-data` slot of `OptionPanel`. -}
noDataAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAvatar =
    noData_core


{-| Place a `Autocomplete` in the `no-data` slot of `OptionPanel`. -}
noDataAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAutocomplete =
    noData_core


{-| Place a `FormField` in the `no-data` slot of `OptionPanel`. -}
noDataFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFormField =
    noData_core


{-| Place a `OptionPanel` in the `no-data` slot of `OptionPanel`. -}
noDataOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOptionPanel =
    noData_core


{-| Place a `FloatingPanel` in the `no-data` slot of `OptionPanel`. -}
noDataFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFloatingPanel =
    noData_core


{-| Place a `Optgroup` in the `no-data` slot of `OptionPanel`. -}
noDataOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOptgroup =
    noData_core


{-| Place a `Option` in the `no-data` slot of `OptionPanel`. -}
noDataOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOption =
    noData_core


{-| Place a `FocusTrap` in the `no-data` slot of `OptionPanel`. -}
noDataFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFocusTrap =
    noData_core


{-| Place a `AppBar` in the `no-data` slot of `OptionPanel`. -}
noDataAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAppBar =
    noData_core


{-| Place a `TextOverflow` in the `no-data` slot of `OptionPanel`. -}
noDataTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextOverflow =
    noData_core


{-| Place a `TextHighlight` in the `no-data` slot of `OptionPanel`. -}
noDataTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextHighlight =
    noData_core


{-| Place a `StateLayer` in the `no-data` slot of `OptionPanel`. -}
noDataStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStateLayer =
    noData_core


{-| Place a `Slide` in the `no-data` slot of `OptionPanel`. -}
noDataSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlide =
    noData_core


{-| Place a `ScrollContainer` in the `no-data` slot of `OptionPanel`. -}
noDataScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataScrollContainer =
    noData_core


{-| Place a `Ripple` in the `no-data` slot of `OptionPanel`. -}
noDataRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRipple =
    noData_core


{-| Place a `PseudoRadio` in the `no-data` slot of `OptionPanel`. -}
noDataPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPseudoRadio =
    noData_core


{-| Place a `PseudoCheckbox` in the `no-data` slot of `OptionPanel`. -}
noDataPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPseudoCheckbox =
    noData_core


{-| Place a `FocusRing` in the `no-data` slot of `OptionPanel`. -}
noDataFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFocusRing =
    noData_core


{-| Place a `Elevation` in the `no-data` slot of `OptionPanel`. -}
noDataElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataElevation =
    noData_core


{-| Place a `Collapsible` in the `no-data` slot of `OptionPanel`. -}
noDataCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCollapsible =
    noData_core


{-| Place a `ActionElementBase` in the `no-data` slot of `OptionPanel`. -}
noDataActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.OptionPanel.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataActionElementBase =
    noData_core