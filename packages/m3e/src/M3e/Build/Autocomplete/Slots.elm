module M3e.Build.Autocomplete.Slots exposing
    ( loadingTree, loadingTreeItem, loadingToolbar, loadingToc, loadingTocItem, loadingThemeIcon
    , loadingTheme, loadingTextareaAutosize, loadingTabs, loadingTabPanel, loadingTab, loadingSwitch, loadingStepperReset
    , loadingStepperPrevious, loadingStep, loadingStepPanel, loadingStepper, loadingSplitPane, loadingSplitButton, loadingSnackbar
    , loadingSlider, loadingSliderThumb, loadingSlideGroup, loadingSkeleton, loadingShape, loadingSegmentedButton, loadingButtonSegment
    , loadingSearchView, loadingSearchBar, loadingRadioGroup, loadingRadio, loadingProgressElementIndicatorBase, loadingPaginator, loadingSelect
    , loadingNavRailToggle, loadingNavRail, loadingNavMenuItemGroup, loadingNavMenu, loadingNavMenuItem, loadingNavBar, loadingNavItem
    , loadingMenuItemRadio, loadingMenuItemGroup, loadingMenuItemCheckbox, loadingMenu, loadingMenuItem, loadingMenuTrigger, loadingMenuItemElementBase
    , loadingLoadingIndicator, loadingSelectionList, loadingListOption, loadingActionList, loadingExpandableListItem, loadingListAction, loadingListItemButton
    , loadingList, loadingListItem, loadingIcon, loadingHeading, loadingFabMenuTrigger, loadingFabMenu, loadingFab
    , loadingAccordion, loadingExpansionPanel, loadingExpansionHeader, loadingDrawerToggle, loadingDrawerContainer, loadingDivider, loadingDialogTrigger
    , loadingDialog, loadingDialogAction, loadingDatepickerToggle, loadingDatepicker, loadingContentPane, loadingSuggestionChip, loadingInputChipSet
    , loadingInputChip, loadingFilterChipSet, loadingFilterChip, loadingChipSet, loadingAssistChip, loadingChip, loadingCheckbox
    , loadingCard, loadingCalendar, loadingYearView, loadingMultiYearView, loadingMonthView, loadingTooltip, loadingRichTooltip
    , loadingTooltipElementBase, loadingRichTooltipAction, loadingButtonGroup, loadingIconButton, loadingButton, loadingBreadcrumb, loadingBreadcrumbItem
    , loadingBreadcrumbItemButton, loadingBottomSheetTrigger, loadingBottomSheet, loadingBottomSheetAction, loadingBadge, loadingAvatar, loadingAutocomplete
    , loadingFormField, loadingOptionPanel, loadingFloatingPanel, loadingOptgroup, loadingOption, loadingFocusTrap, loadingAppBar
    , loadingTextOverflow, loadingTextHighlight, loadingStateLayer, loadingSlide, loadingScrollContainer, loadingRipple, loadingPseudoRadio
    , loadingPseudoCheckbox, loadingFocusRing, loadingElevation, loadingCollapsible, loadingActionElementBase, noDataTree, noDataTreeItem
    , noDataToolbar, noDataToc, noDataTocItem, noDataThemeIcon, noDataTheme, noDataTextareaAutosize, noDataTabs
    , noDataTabPanel, noDataTab, noDataSwitch, noDataStepperReset, noDataStepperPrevious, noDataStep, noDataStepPanel
    , noDataStepper, noDataSplitPane, noDataSplitButton, noDataSnackbar, noDataSlider, noDataSliderThumb, noDataSlideGroup
    , noDataSkeleton, noDataShape, noDataSegmentedButton, noDataButtonSegment, noDataSearchView, noDataSearchBar, noDataRadioGroup
    , noDataRadio, noDataProgressElementIndicatorBase, noDataPaginator, noDataSelect, noDataNavRailToggle, noDataNavRail, noDataNavMenuItemGroup
    , noDataNavMenu, noDataNavMenuItem, noDataNavBar, noDataNavItem, noDataMenuItemRadio, noDataMenuItemGroup, noDataMenuItemCheckbox
    , noDataMenu, noDataMenuItem, noDataMenuTrigger, noDataMenuItemElementBase, noDataLoadingIndicator, noDataSelectionList, noDataListOption
    , noDataActionList, noDataExpandableListItem, noDataListAction, noDataListItemButton, noDataList, noDataListItem, noDataIcon
    , noDataHeading, noDataFabMenuTrigger, noDataFabMenu, noDataFab, noDataAccordion, noDataExpansionPanel, noDataExpansionHeader
    , noDataDrawerToggle, noDataDrawerContainer, noDataDivider, noDataDialogTrigger, noDataDialog, noDataDialogAction, noDataDatepickerToggle
    , noDataDatepicker, noDataContentPane, noDataSuggestionChip, noDataInputChipSet, noDataInputChip, noDataFilterChipSet, noDataFilterChip
    , noDataChipSet, noDataAssistChip, noDataChip, noDataCheckbox, noDataCard, noDataCalendar, noDataYearView
    , noDataMultiYearView, noDataMonthView, noDataTooltip, noDataRichTooltip, noDataTooltipElementBase, noDataRichTooltipAction, noDataButtonGroup
    , noDataIconButton, noDataButton, noDataBreadcrumb, noDataBreadcrumbItem, noDataBreadcrumbItemButton, noDataBottomSheetTrigger, noDataBottomSheet
    , noDataBottomSheetAction, noDataBadge, noDataAvatar, noDataAutocomplete, noDataFormField, noDataOptionPanel, noDataFloatingPanel
    , noDataOptgroup, noDataOption, noDataFocusTrap, noDataAppBar, noDataTextOverflow, noDataTextHighlight, noDataStateLayer
    , noDataSlide, noDataScrollContainer, noDataRipple, noDataPseudoRadio, noDataPseudoCheckbox, noDataFocusRing, noDataElevation
    , noDataCollapsible, noDataActionElementBase, optgroup, option
    )

{-|
Slot setters for `M3e.Build.Autocomplete`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs loadingTree, loadingTreeItem, loadingToolbar, loadingToc, loadingTocItem, loadingThemeIcon
@docs loadingTheme, loadingTextareaAutosize, loadingTabs, loadingTabPanel, loadingTab, loadingSwitch
@docs loadingStepperReset, loadingStepperPrevious, loadingStep, loadingStepPanel, loadingStepper, loadingSplitPane
@docs loadingSplitButton, loadingSnackbar, loadingSlider, loadingSliderThumb, loadingSlideGroup, loadingSkeleton
@docs loadingShape, loadingSegmentedButton, loadingButtonSegment, loadingSearchView, loadingSearchBar, loadingRadioGroup
@docs loadingRadio, loadingProgressElementIndicatorBase, loadingPaginator, loadingSelect, loadingNavRailToggle, loadingNavRail
@docs loadingNavMenuItemGroup, loadingNavMenu, loadingNavMenuItem, loadingNavBar, loadingNavItem, loadingMenuItemRadio
@docs loadingMenuItemGroup, loadingMenuItemCheckbox, loadingMenu, loadingMenuItem, loadingMenuTrigger, loadingMenuItemElementBase
@docs loadingLoadingIndicator, loadingSelectionList, loadingListOption, loadingActionList, loadingExpandableListItem, loadingListAction
@docs loadingListItemButton, loadingList, loadingListItem, loadingIcon, loadingHeading, loadingFabMenuTrigger
@docs loadingFabMenu, loadingFab, loadingAccordion, loadingExpansionPanel, loadingExpansionHeader, loadingDrawerToggle
@docs loadingDrawerContainer, loadingDivider, loadingDialogTrigger, loadingDialog, loadingDialogAction, loadingDatepickerToggle
@docs loadingDatepicker, loadingContentPane, loadingSuggestionChip, loadingInputChipSet, loadingInputChip, loadingFilterChipSet
@docs loadingFilterChip, loadingChipSet, loadingAssistChip, loadingChip, loadingCheckbox, loadingCard
@docs loadingCalendar, loadingYearView, loadingMultiYearView, loadingMonthView, loadingTooltip, loadingRichTooltip
@docs loadingTooltipElementBase, loadingRichTooltipAction, loadingButtonGroup, loadingIconButton, loadingButton, loadingBreadcrumb
@docs loadingBreadcrumbItem, loadingBreadcrumbItemButton, loadingBottomSheetTrigger, loadingBottomSheet, loadingBottomSheetAction, loadingBadge
@docs loadingAvatar, loadingAutocomplete, loadingFormField, loadingOptionPanel, loadingFloatingPanel, loadingOptgroup
@docs loadingOption, loadingFocusTrap, loadingAppBar, loadingTextOverflow, loadingTextHighlight, loadingStateLayer
@docs loadingSlide, loadingScrollContainer, loadingRipple, loadingPseudoRadio, loadingPseudoCheckbox, loadingFocusRing
@docs loadingElevation, loadingCollapsible, loadingActionElementBase, noDataTree, noDataTreeItem, noDataToolbar
@docs noDataToc, noDataTocItem, noDataThemeIcon, noDataTheme, noDataTextareaAutosize, noDataTabs
@docs noDataTabPanel, noDataTab, noDataSwitch, noDataStepperReset, noDataStepperPrevious, noDataStep
@docs noDataStepPanel, noDataStepper, noDataSplitPane, noDataSplitButton, noDataSnackbar, noDataSlider
@docs noDataSliderThumb, noDataSlideGroup, noDataSkeleton, noDataShape, noDataSegmentedButton, noDataButtonSegment
@docs noDataSearchView, noDataSearchBar, noDataRadioGroup, noDataRadio, noDataProgressElementIndicatorBase, noDataPaginator
@docs noDataSelect, noDataNavRailToggle, noDataNavRail, noDataNavMenuItemGroup, noDataNavMenu, noDataNavMenuItem
@docs noDataNavBar, noDataNavItem, noDataMenuItemRadio, noDataMenuItemGroup, noDataMenuItemCheckbox, noDataMenu
@docs noDataMenuItem, noDataMenuTrigger, noDataMenuItemElementBase, noDataLoadingIndicator, noDataSelectionList, noDataListOption
@docs noDataActionList, noDataExpandableListItem, noDataListAction, noDataListItemButton, noDataList, noDataListItem
@docs noDataIcon, noDataHeading, noDataFabMenuTrigger, noDataFabMenu, noDataFab, noDataAccordion
@docs noDataExpansionPanel, noDataExpansionHeader, noDataDrawerToggle, noDataDrawerContainer, noDataDivider, noDataDialogTrigger
@docs noDataDialog, noDataDialogAction, noDataDatepickerToggle, noDataDatepicker, noDataContentPane, noDataSuggestionChip
@docs noDataInputChipSet, noDataInputChip, noDataFilterChipSet, noDataFilterChip, noDataChipSet, noDataAssistChip
@docs noDataChip, noDataCheckbox, noDataCard, noDataCalendar, noDataYearView, noDataMultiYearView
@docs noDataMonthView, noDataTooltip, noDataRichTooltip, noDataTooltipElementBase, noDataRichTooltipAction, noDataButtonGroup
@docs noDataIconButton, noDataButton, noDataBreadcrumb, noDataBreadcrumbItem, noDataBreadcrumbItemButton, noDataBottomSheetTrigger
@docs noDataBottomSheet, noDataBottomSheetAction, noDataBadge, noDataAvatar, noDataAutocomplete, noDataFormField
@docs noDataOptionPanel, noDataFloatingPanel, noDataOptgroup, noDataOption, noDataFocusTrap, noDataAppBar
@docs noDataTextOverflow, noDataTextHighlight, noDataStateLayer, noDataSlide, noDataScrollContainer, noDataRipple
@docs noDataPseudoRadio, noDataPseudoCheckbox, noDataFocusRing, noDataElevation, noDataCollapsible, noDataActionElementBase
@docs optgroup, option
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


loading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


noData_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noData_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `loading` slot of `Autocomplete`. -}
loadingTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTree =
    loading_core


{-| Place a `TreeItem` in the `loading` slot of `Autocomplete`. -}
loadingTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTreeItem =
    loading_core


{-| Place a `Toolbar` in the `loading` slot of `Autocomplete`. -}
loadingToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingToolbar =
    loading_core


{-| Place a `Toc` in the `loading` slot of `Autocomplete`. -}
loadingToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingToc =
    loading_core


{-| Place a `TocItem` in the `loading` slot of `Autocomplete`. -}
loadingTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTocItem =
    loading_core


{-| Place a `ThemeIcon` in the `loading` slot of `Autocomplete`. -}
loadingThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingThemeIcon =
    loading_core


{-| Place a `Theme` in the `loading` slot of `Autocomplete`. -}
loadingTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTheme =
    loading_core


{-| Place a `TextareaAutosize` in the `loading` slot of `Autocomplete`. -}
loadingTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTextareaAutosize =
    loading_core


{-| Place a `Tabs` in the `loading` slot of `Autocomplete`. -}
loadingTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTabs =
    loading_core


{-| Place a `TabPanel` in the `loading` slot of `Autocomplete`. -}
loadingTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTabPanel =
    loading_core


{-| Place a `Tab` in the `loading` slot of `Autocomplete`. -}
loadingTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTab =
    loading_core


{-| Place a `Switch` in the `loading` slot of `Autocomplete`. -}
loadingSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSwitch =
    loading_core


{-| Place a `StepperReset` in the `loading` slot of `Autocomplete`. -}
loadingStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStepperReset =
    loading_core


{-| Place a `StepperPrevious` in the `loading` slot of `Autocomplete`. -}
loadingStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStepperPrevious =
    loading_core


{-| Place a `Step` in the `loading` slot of `Autocomplete`. -}
loadingStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStep =
    loading_core


{-| Place a `StepPanel` in the `loading` slot of `Autocomplete`. -}
loadingStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStepPanel =
    loading_core


{-| Place a `Stepper` in the `loading` slot of `Autocomplete`. -}
loadingStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStepper =
    loading_core


{-| Place a `SplitPane` in the `loading` slot of `Autocomplete`. -}
loadingSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSplitPane =
    loading_core


{-| Place a `SplitButton` in the `loading` slot of `Autocomplete`. -}
loadingSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSplitButton =
    loading_core


{-| Place a `Snackbar` in the `loading` slot of `Autocomplete`. -}
loadingSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSnackbar =
    loading_core


{-| Place a `Slider` in the `loading` slot of `Autocomplete`. -}
loadingSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSlider =
    loading_core


{-| Place a `SliderThumb` in the `loading` slot of `Autocomplete`. -}
loadingSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSliderThumb =
    loading_core


{-| Place a `SlideGroup` in the `loading` slot of `Autocomplete`. -}
loadingSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSlideGroup =
    loading_core


{-| Place a `Skeleton` in the `loading` slot of `Autocomplete`. -}
loadingSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSkeleton =
    loading_core


{-| Place a `Shape` in the `loading` slot of `Autocomplete`. -}
loadingShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingShape =
    loading_core


{-| Place a `SegmentedButton` in the `loading` slot of `Autocomplete`. -}
loadingSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSegmentedButton =
    loading_core


{-| Place a `ButtonSegment` in the `loading` slot of `Autocomplete`. -}
loadingButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingButtonSegment =
    loading_core


{-| Place a `SearchView` in the `loading` slot of `Autocomplete`. -}
loadingSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSearchView =
    loading_core


{-| Place a `SearchBar` in the `loading` slot of `Autocomplete`. -}
loadingSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSearchBar =
    loading_core


{-| Place a `RadioGroup` in the `loading` slot of `Autocomplete`. -}
loadingRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingRadioGroup =
    loading_core


{-| Place a `Radio` in the `loading` slot of `Autocomplete`. -}
loadingRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingRadio =
    loading_core


{-| Place a `ProgressElementIndicatorBase` in the `loading` slot of `Autocomplete`. -}
loadingProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingProgressElementIndicatorBase =
    loading_core


{-| Place a `Paginator` in the `loading` slot of `Autocomplete`. -}
loadingPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingPaginator =
    loading_core


{-| Place a `Select` in the `loading` slot of `Autocomplete`. -}
loadingSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSelect =
    loading_core


{-| Place a `NavRailToggle` in the `loading` slot of `Autocomplete`. -}
loadingNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavRailToggle =
    loading_core


{-| Place a `NavRail` in the `loading` slot of `Autocomplete`. -}
loadingNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavRail =
    loading_core


{-| Place a `NavMenuItemGroup` in the `loading` slot of `Autocomplete`. -}
loadingNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavMenuItemGroup =
    loading_core


{-| Place a `NavMenu` in the `loading` slot of `Autocomplete`. -}
loadingNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavMenu =
    loading_core


{-| Place a `NavMenuItem` in the `loading` slot of `Autocomplete`. -}
loadingNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavMenuItem =
    loading_core


{-| Place a `NavBar` in the `loading` slot of `Autocomplete`. -}
loadingNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavBar =
    loading_core


{-| Place a `NavItem` in the `loading` slot of `Autocomplete`. -}
loadingNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingNavItem =
    loading_core


{-| Place a `MenuItemRadio` in the `loading` slot of `Autocomplete`. -}
loadingMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuItemRadio =
    loading_core


{-| Place a `MenuItemGroup` in the `loading` slot of `Autocomplete`. -}
loadingMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuItemGroup =
    loading_core


{-| Place a `MenuItemCheckbox` in the `loading` slot of `Autocomplete`. -}
loadingMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuItemCheckbox =
    loading_core


{-| Place a `Menu` in the `loading` slot of `Autocomplete`. -}
loadingMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenu =
    loading_core


{-| Place a `MenuItem` in the `loading` slot of `Autocomplete`. -}
loadingMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuItem =
    loading_core


{-| Place a `MenuTrigger` in the `loading` slot of `Autocomplete`. -}
loadingMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuTrigger =
    loading_core


{-| Place a `MenuItemElementBase` in the `loading` slot of `Autocomplete`. -}
loadingMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMenuItemElementBase =
    loading_core


{-| Place a `LoadingIndicator` in the `loading` slot of `Autocomplete`. -}
loadingLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingLoadingIndicator =
    loading_core


{-| Place a `SelectionList` in the `loading` slot of `Autocomplete`. -}
loadingSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSelectionList =
    loading_core


{-| Place a `ListOption` in the `loading` slot of `Autocomplete`. -}
loadingListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingListOption =
    loading_core


{-| Place a `ActionList` in the `loading` slot of `Autocomplete`. -}
loadingActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingActionList =
    loading_core


{-| Place a `ExpandableListItem` in the `loading` slot of `Autocomplete`. -}
loadingExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingExpandableListItem =
    loading_core


{-| Place a `ListAction` in the `loading` slot of `Autocomplete`. -}
loadingListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingListAction =
    loading_core


{-| Place a `ListItemButton` in the `loading` slot of `Autocomplete`. -}
loadingListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingListItemButton =
    loading_core


{-| Place a `List` in the `loading` slot of `Autocomplete`. -}
loadingList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingList =
    loading_core


{-| Place a `ListItem` in the `loading` slot of `Autocomplete`. -}
loadingListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingListItem =
    loading_core


{-| Place a `Icon` in the `loading` slot of `Autocomplete`. -}
loadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingIcon =
    loading_core


{-| Place a `Heading` in the `loading` slot of `Autocomplete`. -}
loadingHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingHeading =
    loading_core


{-| Place a `FabMenuTrigger` in the `loading` slot of `Autocomplete`. -}
loadingFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFabMenuTrigger =
    loading_core


{-| Place a `FabMenu` in the `loading` slot of `Autocomplete`. -}
loadingFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFabMenu =
    loading_core


{-| Place a `Fab` in the `loading` slot of `Autocomplete`. -}
loadingFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFab =
    loading_core


{-| Place a `Accordion` in the `loading` slot of `Autocomplete`. -}
loadingAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingAccordion =
    loading_core


{-| Place a `ExpansionPanel` in the `loading` slot of `Autocomplete`. -}
loadingExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingExpansionPanel =
    loading_core


{-| Place a `ExpansionHeader` in the `loading` slot of `Autocomplete`. -}
loadingExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingExpansionHeader =
    loading_core


{-| Place a `DrawerToggle` in the `loading` slot of `Autocomplete`. -}
loadingDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDrawerToggle =
    loading_core


{-| Place a `DrawerContainer` in the `loading` slot of `Autocomplete`. -}
loadingDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDrawerContainer =
    loading_core


{-| Place a `Divider` in the `loading` slot of `Autocomplete`. -}
loadingDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDivider =
    loading_core


{-| Place a `DialogTrigger` in the `loading` slot of `Autocomplete`. -}
loadingDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDialogTrigger =
    loading_core


{-| Place a `Dialog` in the `loading` slot of `Autocomplete`. -}
loadingDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDialog =
    loading_core


{-| Place a `DialogAction` in the `loading` slot of `Autocomplete`. -}
loadingDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDialogAction =
    loading_core


{-| Place a `DatepickerToggle` in the `loading` slot of `Autocomplete`. -}
loadingDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDatepickerToggle =
    loading_core


{-| Place a `Datepicker` in the `loading` slot of `Autocomplete`. -}
loadingDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingDatepicker =
    loading_core


{-| Place a `ContentPane` in the `loading` slot of `Autocomplete`. -}
loadingContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingContentPane =
    loading_core


{-| Place a `SuggestionChip` in the `loading` slot of `Autocomplete`. -}
loadingSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSuggestionChip =
    loading_core


{-| Place a `InputChipSet` in the `loading` slot of `Autocomplete`. -}
loadingInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingInputChipSet =
    loading_core


{-| Place a `InputChip` in the `loading` slot of `Autocomplete`. -}
loadingInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingInputChip =
    loading_core


{-| Place a `FilterChipSet` in the `loading` slot of `Autocomplete`. -}
loadingFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFilterChipSet =
    loading_core


{-| Place a `FilterChip` in the `loading` slot of `Autocomplete`. -}
loadingFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFilterChip =
    loading_core


{-| Place a `ChipSet` in the `loading` slot of `Autocomplete`. -}
loadingChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingChipSet =
    loading_core


{-| Place a `AssistChip` in the `loading` slot of `Autocomplete`. -}
loadingAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingAssistChip =
    loading_core


{-| Place a `Chip` in the `loading` slot of `Autocomplete`. -}
loadingChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingChip =
    loading_core


{-| Place a `Checkbox` in the `loading` slot of `Autocomplete`. -}
loadingCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingCheckbox =
    loading_core


{-| Place a `Card` in the `loading` slot of `Autocomplete`. -}
loadingCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingCard =
    loading_core


{-| Place a `Calendar` in the `loading` slot of `Autocomplete`. -}
loadingCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingCalendar =
    loading_core


{-| Place a `YearView` in the `loading` slot of `Autocomplete`. -}
loadingYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingYearView =
    loading_core


{-| Place a `MultiYearView` in the `loading` slot of `Autocomplete`. -}
loadingMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMultiYearView =
    loading_core


{-| Place a `MonthView` in the `loading` slot of `Autocomplete`. -}
loadingMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingMonthView =
    loading_core


{-| Place a `Tooltip` in the `loading` slot of `Autocomplete`. -}
loadingTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTooltip =
    loading_core


{-| Place a `RichTooltip` in the `loading` slot of `Autocomplete`. -}
loadingRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingRichTooltip =
    loading_core


{-| Place a `TooltipElementBase` in the `loading` slot of `Autocomplete`. -}
loadingTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTooltipElementBase =
    loading_core


{-| Place a `RichTooltipAction` in the `loading` slot of `Autocomplete`. -}
loadingRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingRichTooltipAction =
    loading_core


{-| Place a `ButtonGroup` in the `loading` slot of `Autocomplete`. -}
loadingButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingButtonGroup =
    loading_core


{-| Place a `IconButton` in the `loading` slot of `Autocomplete`. -}
loadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingIconButton =
    loading_core


{-| Place a `Button` in the `loading` slot of `Autocomplete`. -}
loadingButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingButton =
    loading_core


{-| Place a `Breadcrumb` in the `loading` slot of `Autocomplete`. -}
loadingBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBreadcrumb =
    loading_core


{-| Place a `BreadcrumbItem` in the `loading` slot of `Autocomplete`. -}
loadingBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBreadcrumbItem =
    loading_core


{-| Place a `BreadcrumbItemButton` in the `loading` slot of `Autocomplete`. -}
loadingBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBreadcrumbItemButton =
    loading_core


{-| Place a `BottomSheetTrigger` in the `loading` slot of `Autocomplete`. -}
loadingBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBottomSheetTrigger =
    loading_core


{-| Place a `BottomSheet` in the `loading` slot of `Autocomplete`. -}
loadingBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBottomSheet =
    loading_core


{-| Place a `BottomSheetAction` in the `loading` slot of `Autocomplete`. -}
loadingBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBottomSheetAction =
    loading_core


{-| Place a `Badge` in the `loading` slot of `Autocomplete`. -}
loadingBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingBadge =
    loading_core


{-| Place a `Avatar` in the `loading` slot of `Autocomplete`. -}
loadingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingAvatar =
    loading_core


{-| Place a `Autocomplete` in the `loading` slot of `Autocomplete`. -}
loadingAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingAutocomplete =
    loading_core


{-| Place a `FormField` in the `loading` slot of `Autocomplete`. -}
loadingFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFormField =
    loading_core


{-| Place a `OptionPanel` in the `loading` slot of `Autocomplete`. -}
loadingOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingOptionPanel =
    loading_core


{-| Place a `FloatingPanel` in the `loading` slot of `Autocomplete`. -}
loadingFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFloatingPanel =
    loading_core


{-| Place a `Optgroup` in the `loading` slot of `Autocomplete`. -}
loadingOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingOptgroup =
    loading_core


{-| Place a `Option` in the `loading` slot of `Autocomplete`. -}
loadingOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingOption =
    loading_core


{-| Place a `FocusTrap` in the `loading` slot of `Autocomplete`. -}
loadingFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFocusTrap =
    loading_core


{-| Place a `AppBar` in the `loading` slot of `Autocomplete`. -}
loadingAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingAppBar =
    loading_core


{-| Place a `TextOverflow` in the `loading` slot of `Autocomplete`. -}
loadingTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTextOverflow =
    loading_core


{-| Place a `TextHighlight` in the `loading` slot of `Autocomplete`. -}
loadingTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingTextHighlight =
    loading_core


{-| Place a `StateLayer` in the `loading` slot of `Autocomplete`. -}
loadingStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingStateLayer =
    loading_core


{-| Place a `Slide` in the `loading` slot of `Autocomplete`. -}
loadingSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingSlide =
    loading_core


{-| Place a `ScrollContainer` in the `loading` slot of `Autocomplete`. -}
loadingScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingScrollContainer =
    loading_core


{-| Place a `Ripple` in the `loading` slot of `Autocomplete`. -}
loadingRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingRipple =
    loading_core


{-| Place a `PseudoRadio` in the `loading` slot of `Autocomplete`. -}
loadingPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingPseudoRadio =
    loading_core


{-| Place a `PseudoCheckbox` in the `loading` slot of `Autocomplete`. -}
loadingPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingPseudoCheckbox =
    loading_core


{-| Place a `FocusRing` in the `loading` slot of `Autocomplete`. -}
loadingFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingFocusRing =
    loading_core


{-| Place a `Elevation` in the `loading` slot of `Autocomplete`. -}
loadingElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingElevation =
    loading_core


{-| Place a `Collapsible` in the `loading` slot of `Autocomplete`. -}
loadingCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingCollapsible =
    loading_core


{-| Place a `ActionElementBase` in the `loading` slot of `Autocomplete`. -}
loadingActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | loading : M3e.Build.Internal.Used
    } msg pk
loadingActionElementBase =
    loading_core


{-| Place a `Tree` in the `no-data` slot of `Autocomplete`. -}
noDataTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTree =
    noData_core


{-| Place a `TreeItem` in the `no-data` slot of `Autocomplete`. -}
noDataTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTreeItem =
    noData_core


{-| Place a `Toolbar` in the `no-data` slot of `Autocomplete`. -}
noDataToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataToolbar =
    noData_core


{-| Place a `Toc` in the `no-data` slot of `Autocomplete`. -}
noDataToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataToc =
    noData_core


{-| Place a `TocItem` in the `no-data` slot of `Autocomplete`. -}
noDataTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTocItem =
    noData_core


{-| Place a `ThemeIcon` in the `no-data` slot of `Autocomplete`. -}
noDataThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataThemeIcon =
    noData_core


{-| Place a `Theme` in the `no-data` slot of `Autocomplete`. -}
noDataTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTheme =
    noData_core


{-| Place a `TextareaAutosize` in the `no-data` slot of `Autocomplete`. -}
noDataTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextareaAutosize =
    noData_core


{-| Place a `Tabs` in the `no-data` slot of `Autocomplete`. -}
noDataTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTabs =
    noData_core


{-| Place a `TabPanel` in the `no-data` slot of `Autocomplete`. -}
noDataTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTabPanel =
    noData_core


{-| Place a `Tab` in the `no-data` slot of `Autocomplete`. -}
noDataTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTab =
    noData_core


{-| Place a `Switch` in the `no-data` slot of `Autocomplete`. -}
noDataSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSwitch =
    noData_core


{-| Place a `StepperReset` in the `no-data` slot of `Autocomplete`. -}
noDataStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepperReset =
    noData_core


{-| Place a `StepperPrevious` in the `no-data` slot of `Autocomplete`. -}
noDataStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepperPrevious =
    noData_core


{-| Place a `Step` in the `no-data` slot of `Autocomplete`. -}
noDataStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStep =
    noData_core


{-| Place a `StepPanel` in the `no-data` slot of `Autocomplete`. -}
noDataStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepPanel =
    noData_core


{-| Place a `Stepper` in the `no-data` slot of `Autocomplete`. -}
noDataStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStepper =
    noData_core


{-| Place a `SplitPane` in the `no-data` slot of `Autocomplete`. -}
noDataSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSplitPane =
    noData_core


{-| Place a `SplitButton` in the `no-data` slot of `Autocomplete`. -}
noDataSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSplitButton =
    noData_core


{-| Place a `Snackbar` in the `no-data` slot of `Autocomplete`. -}
noDataSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSnackbar =
    noData_core


{-| Place a `Slider` in the `no-data` slot of `Autocomplete`. -}
noDataSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlider =
    noData_core


{-| Place a `SliderThumb` in the `no-data` slot of `Autocomplete`. -}
noDataSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSliderThumb =
    noData_core


{-| Place a `SlideGroup` in the `no-data` slot of `Autocomplete`. -}
noDataSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlideGroup =
    noData_core


{-| Place a `Skeleton` in the `no-data` slot of `Autocomplete`. -}
noDataSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSkeleton =
    noData_core


{-| Place a `Shape` in the `no-data` slot of `Autocomplete`. -}
noDataShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataShape =
    noData_core


{-| Place a `SegmentedButton` in the `no-data` slot of `Autocomplete`. -}
noDataSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSegmentedButton =
    noData_core


{-| Place a `ButtonSegment` in the `no-data` slot of `Autocomplete`. -}
noDataButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButtonSegment =
    noData_core


{-| Place a `SearchView` in the `no-data` slot of `Autocomplete`. -}
noDataSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSearchView =
    noData_core


{-| Place a `SearchBar` in the `no-data` slot of `Autocomplete`. -}
noDataSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSearchBar =
    noData_core


{-| Place a `RadioGroup` in the `no-data` slot of `Autocomplete`. -}
noDataRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRadioGroup =
    noData_core


{-| Place a `Radio` in the `no-data` slot of `Autocomplete`. -}
noDataRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRadio =
    noData_core


{-| Place a `ProgressElementIndicatorBase` in the `no-data` slot of `Autocomplete`. -}
noDataProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataProgressElementIndicatorBase =
    noData_core


{-| Place a `Paginator` in the `no-data` slot of `Autocomplete`. -}
noDataPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPaginator =
    noData_core


{-| Place a `Select` in the `no-data` slot of `Autocomplete`. -}
noDataSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSelect =
    noData_core


{-| Place a `NavRailToggle` in the `no-data` slot of `Autocomplete`. -}
noDataNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavRailToggle =
    noData_core


{-| Place a `NavRail` in the `no-data` slot of `Autocomplete`. -}
noDataNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavRail =
    noData_core


{-| Place a `NavMenuItemGroup` in the `no-data` slot of `Autocomplete`. -}
noDataNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenuItemGroup =
    noData_core


{-| Place a `NavMenu` in the `no-data` slot of `Autocomplete`. -}
noDataNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenu =
    noData_core


{-| Place a `NavMenuItem` in the `no-data` slot of `Autocomplete`. -}
noDataNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavMenuItem =
    noData_core


{-| Place a `NavBar` in the `no-data` slot of `Autocomplete`. -}
noDataNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavBar =
    noData_core


{-| Place a `NavItem` in the `no-data` slot of `Autocomplete`. -}
noDataNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataNavItem =
    noData_core


{-| Place a `MenuItemRadio` in the `no-data` slot of `Autocomplete`. -}
noDataMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemRadio =
    noData_core


{-| Place a `MenuItemGroup` in the `no-data` slot of `Autocomplete`. -}
noDataMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemGroup =
    noData_core


{-| Place a `MenuItemCheckbox` in the `no-data` slot of `Autocomplete`. -}
noDataMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemCheckbox =
    noData_core


{-| Place a `Menu` in the `no-data` slot of `Autocomplete`. -}
noDataMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenu =
    noData_core


{-| Place a `MenuItem` in the `no-data` slot of `Autocomplete`. -}
noDataMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItem =
    noData_core


{-| Place a `MenuTrigger` in the `no-data` slot of `Autocomplete`. -}
noDataMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuTrigger =
    noData_core


{-| Place a `MenuItemElementBase` in the `no-data` slot of `Autocomplete`. -}
noDataMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMenuItemElementBase =
    noData_core


{-| Place a `LoadingIndicator` in the `no-data` slot of `Autocomplete`. -}
noDataLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataLoadingIndicator =
    noData_core


{-| Place a `SelectionList` in the `no-data` slot of `Autocomplete`. -}
noDataSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSelectionList =
    noData_core


{-| Place a `ListOption` in the `no-data` slot of `Autocomplete`. -}
noDataListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListOption =
    noData_core


{-| Place a `ActionList` in the `no-data` slot of `Autocomplete`. -}
noDataActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataActionList =
    noData_core


{-| Place a `ExpandableListItem` in the `no-data` slot of `Autocomplete`. -}
noDataExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpandableListItem =
    noData_core


{-| Place a `ListAction` in the `no-data` slot of `Autocomplete`. -}
noDataListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListAction =
    noData_core


{-| Place a `ListItemButton` in the `no-data` slot of `Autocomplete`. -}
noDataListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListItemButton =
    noData_core


{-| Place a `List` in the `no-data` slot of `Autocomplete`. -}
noDataList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataList =
    noData_core


{-| Place a `ListItem` in the `no-data` slot of `Autocomplete`. -}
noDataListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataListItem =
    noData_core


{-| Place a `Icon` in the `no-data` slot of `Autocomplete`. -}
noDataIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataIcon =
    noData_core


{-| Place a `Heading` in the `no-data` slot of `Autocomplete`. -}
noDataHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataHeading =
    noData_core


{-| Place a `FabMenuTrigger` in the `no-data` slot of `Autocomplete`. -}
noDataFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFabMenuTrigger =
    noData_core


{-| Place a `FabMenu` in the `no-data` slot of `Autocomplete`. -}
noDataFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFabMenu =
    noData_core


{-| Place a `Fab` in the `no-data` slot of `Autocomplete`. -}
noDataFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFab =
    noData_core


{-| Place a `Accordion` in the `no-data` slot of `Autocomplete`. -}
noDataAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAccordion =
    noData_core


{-| Place a `ExpansionPanel` in the `no-data` slot of `Autocomplete`. -}
noDataExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpansionPanel =
    noData_core


{-| Place a `ExpansionHeader` in the `no-data` slot of `Autocomplete`. -}
noDataExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataExpansionHeader =
    noData_core


{-| Place a `DrawerToggle` in the `no-data` slot of `Autocomplete`. -}
noDataDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDrawerToggle =
    noData_core


{-| Place a `DrawerContainer` in the `no-data` slot of `Autocomplete`. -}
noDataDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDrawerContainer =
    noData_core


{-| Place a `Divider` in the `no-data` slot of `Autocomplete`. -}
noDataDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDivider =
    noData_core


{-| Place a `DialogTrigger` in the `no-data` slot of `Autocomplete`. -}
noDataDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialogTrigger =
    noData_core


{-| Place a `Dialog` in the `no-data` slot of `Autocomplete`. -}
noDataDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialog =
    noData_core


{-| Place a `DialogAction` in the `no-data` slot of `Autocomplete`. -}
noDataDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDialogAction =
    noData_core


{-| Place a `DatepickerToggle` in the `no-data` slot of `Autocomplete`. -}
noDataDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDatepickerToggle =
    noData_core


{-| Place a `Datepicker` in the `no-data` slot of `Autocomplete`. -}
noDataDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataDatepicker =
    noData_core


{-| Place a `ContentPane` in the `no-data` slot of `Autocomplete`. -}
noDataContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataContentPane =
    noData_core


{-| Place a `SuggestionChip` in the `no-data` slot of `Autocomplete`. -}
noDataSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSuggestionChip =
    noData_core


{-| Place a `InputChipSet` in the `no-data` slot of `Autocomplete`. -}
noDataInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataInputChipSet =
    noData_core


{-| Place a `InputChip` in the `no-data` slot of `Autocomplete`. -}
noDataInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataInputChip =
    noData_core


{-| Place a `FilterChipSet` in the `no-data` slot of `Autocomplete`. -}
noDataFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFilterChipSet =
    noData_core


{-| Place a `FilterChip` in the `no-data` slot of `Autocomplete`. -}
noDataFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFilterChip =
    noData_core


{-| Place a `ChipSet` in the `no-data` slot of `Autocomplete`. -}
noDataChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataChipSet =
    noData_core


{-| Place a `AssistChip` in the `no-data` slot of `Autocomplete`. -}
noDataAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAssistChip =
    noData_core


{-| Place a `Chip` in the `no-data` slot of `Autocomplete`. -}
noDataChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataChip =
    noData_core


{-| Place a `Checkbox` in the `no-data` slot of `Autocomplete`. -}
noDataCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCheckbox =
    noData_core


{-| Place a `Card` in the `no-data` slot of `Autocomplete`. -}
noDataCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCard =
    noData_core


{-| Place a `Calendar` in the `no-data` slot of `Autocomplete`. -}
noDataCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCalendar =
    noData_core


{-| Place a `YearView` in the `no-data` slot of `Autocomplete`. -}
noDataYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataYearView =
    noData_core


{-| Place a `MultiYearView` in the `no-data` slot of `Autocomplete`. -}
noDataMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMultiYearView =
    noData_core


{-| Place a `MonthView` in the `no-data` slot of `Autocomplete`. -}
noDataMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataMonthView =
    noData_core


{-| Place a `Tooltip` in the `no-data` slot of `Autocomplete`. -}
noDataTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTooltip =
    noData_core


{-| Place a `RichTooltip` in the `no-data` slot of `Autocomplete`. -}
noDataRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRichTooltip =
    noData_core


{-| Place a `TooltipElementBase` in the `no-data` slot of `Autocomplete`. -}
noDataTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTooltipElementBase =
    noData_core


{-| Place a `RichTooltipAction` in the `no-data` slot of `Autocomplete`. -}
noDataRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRichTooltipAction =
    noData_core


{-| Place a `ButtonGroup` in the `no-data` slot of `Autocomplete`. -}
noDataButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButtonGroup =
    noData_core


{-| Place a `IconButton` in the `no-data` slot of `Autocomplete`. -}
noDataIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataIconButton =
    noData_core


{-| Place a `Button` in the `no-data` slot of `Autocomplete`. -}
noDataButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataButton =
    noData_core


{-| Place a `Breadcrumb` in the `no-data` slot of `Autocomplete`. -}
noDataBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumb =
    noData_core


{-| Place a `BreadcrumbItem` in the `no-data` slot of `Autocomplete`. -}
noDataBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumbItem =
    noData_core


{-| Place a `BreadcrumbItemButton` in the `no-data` slot of `Autocomplete`. -}
noDataBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBreadcrumbItemButton =
    noData_core


{-| Place a `BottomSheetTrigger` in the `no-data` slot of `Autocomplete`. -}
noDataBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheetTrigger =
    noData_core


{-| Place a `BottomSheet` in the `no-data` slot of `Autocomplete`. -}
noDataBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheet =
    noData_core


{-| Place a `BottomSheetAction` in the `no-data` slot of `Autocomplete`. -}
noDataBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBottomSheetAction =
    noData_core


{-| Place a `Badge` in the `no-data` slot of `Autocomplete`. -}
noDataBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataBadge =
    noData_core


{-| Place a `Avatar` in the `no-data` slot of `Autocomplete`. -}
noDataAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAvatar =
    noData_core


{-| Place a `Autocomplete` in the `no-data` slot of `Autocomplete`. -}
noDataAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAutocomplete =
    noData_core


{-| Place a `FormField` in the `no-data` slot of `Autocomplete`. -}
noDataFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFormField =
    noData_core


{-| Place a `OptionPanel` in the `no-data` slot of `Autocomplete`. -}
noDataOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOptionPanel =
    noData_core


{-| Place a `FloatingPanel` in the `no-data` slot of `Autocomplete`. -}
noDataFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFloatingPanel =
    noData_core


{-| Place a `Optgroup` in the `no-data` slot of `Autocomplete`. -}
noDataOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOptgroup =
    noData_core


{-| Place a `Option` in the `no-data` slot of `Autocomplete`. -}
noDataOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataOption =
    noData_core


{-| Place a `FocusTrap` in the `no-data` slot of `Autocomplete`. -}
noDataFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFocusTrap =
    noData_core


{-| Place a `AppBar` in the `no-data` slot of `Autocomplete`. -}
noDataAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataAppBar =
    noData_core


{-| Place a `TextOverflow` in the `no-data` slot of `Autocomplete`. -}
noDataTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextOverflow =
    noData_core


{-| Place a `TextHighlight` in the `no-data` slot of `Autocomplete`. -}
noDataTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataTextHighlight =
    noData_core


{-| Place a `StateLayer` in the `no-data` slot of `Autocomplete`. -}
noDataStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataStateLayer =
    noData_core


{-| Place a `Slide` in the `no-data` slot of `Autocomplete`. -}
noDataSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataSlide =
    noData_core


{-| Place a `ScrollContainer` in the `no-data` slot of `Autocomplete`. -}
noDataScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataScrollContainer =
    noData_core


{-| Place a `Ripple` in the `no-data` slot of `Autocomplete`. -}
noDataRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataRipple =
    noData_core


{-| Place a `PseudoRadio` in the `no-data` slot of `Autocomplete`. -}
noDataPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPseudoRadio =
    noData_core


{-| Place a `PseudoCheckbox` in the `no-data` slot of `Autocomplete`. -}
noDataPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataPseudoCheckbox =
    noData_core


{-| Place a `FocusRing` in the `no-data` slot of `Autocomplete`. -}
noDataFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataFocusRing =
    noData_core


{-| Place a `Elevation` in the `no-data` slot of `Autocomplete`. -}
noDataElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataElevation =
    noData_core


{-| Place a `Collapsible` in the `no-data` slot of `Autocomplete`. -}
noDataCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataCollapsible =
    noData_core


{-| Place a `ActionElementBase` in the `no-data` slot of `Autocomplete`. -}
noDataActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Autocomplete.Builder pa { ps
        | noData : M3e.Build.Internal.Used
    } msg pk
noDataActionElementBase =
    noData_core


{-| Place a `Optgroup` in the `unnamed` slot of `Autocomplete`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `Autocomplete`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
option =
    unnamed_core