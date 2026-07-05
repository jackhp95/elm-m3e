module M3e.Build.Calendar.Slots exposing
    ( headerTree, headerTreeItem, headerToolbar, headerToc, headerTocItem, headerThemeIcon
    , headerTheme, headerTextareaAutosize, headerTabs, headerTabPanel, headerTab, headerSwitch, headerStepperReset
    , headerStepperPrevious, headerStep, headerStepPanel, headerStepper, headerSplitPane, headerSplitButton, headerSnackbar
    , headerSlider, headerSliderThumb, headerSlideGroup, headerSkeleton, headerShape, headerSegmentedButton, headerButtonSegment
    , headerSearchView, headerSearchBar, headerRadioGroup, headerRadio, headerProgressElementIndicatorBase, headerPaginator, headerSelect
    , headerNavRailToggle, headerNavRail, headerNavMenuItemGroup, headerNavMenu, headerNavMenuItem, headerNavBar, headerNavItem
    , headerMenuItemRadio, headerMenuItemGroup, headerMenuItemCheckbox, headerMenu, headerMenuItem, headerMenuTrigger, headerMenuItemElementBase
    , headerLoadingIndicator, headerSelectionList, headerListOption, headerActionList, headerExpandableListItem, headerListAction, headerListItemButton
    , headerList, headerListItem, headerIcon, headerHeading, headerFabMenuTrigger, headerFabMenu, headerFab
    , headerAccordion, headerExpansionPanel, headerExpansionHeader, headerDrawerToggle, headerDrawerContainer, headerDivider, headerDialogTrigger
    , headerDialog, headerDialogAction, headerDatepickerToggle, headerDatepicker, headerContentPane, headerSuggestionChip, headerInputChipSet
    , headerInputChip, headerFilterChipSet, headerFilterChip, headerChipSet, headerAssistChip, headerChip, headerCheckbox
    , headerCard, headerCalendar, headerYearView, headerMultiYearView, headerMonthView, headerTooltip, headerRichTooltip
    , headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup, headerIconButton, headerButton, headerBreadcrumb, headerBreadcrumbItem
    , headerBreadcrumbItemButton, headerBottomSheetTrigger, headerBottomSheet, headerBottomSheetAction, headerBadge, headerAvatar, headerAutocomplete
    , headerFormField, headerOptionPanel, headerFloatingPanel, headerOptgroup, headerOption, headerFocusTrap, headerAppBar
    , headerTextOverflow, headerTextHighlight, headerStateLayer, headerSlide, headerScrollContainer, headerRipple, headerPseudoRadio
    , headerPseudoCheckbox, headerFocusRing, headerElevation, headerCollapsible, headerActionElementBase
    )

{-|
Slot setters for `M3e.Build.Calendar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs headerTree, headerTreeItem, headerToolbar, headerToc, headerTocItem, headerThemeIcon
@docs headerTheme, headerTextareaAutosize, headerTabs, headerTabPanel, headerTab, headerSwitch
@docs headerStepperReset, headerStepperPrevious, headerStep, headerStepPanel, headerStepper, headerSplitPane
@docs headerSplitButton, headerSnackbar, headerSlider, headerSliderThumb, headerSlideGroup, headerSkeleton
@docs headerShape, headerSegmentedButton, headerButtonSegment, headerSearchView, headerSearchBar, headerRadioGroup
@docs headerRadio, headerProgressElementIndicatorBase, headerPaginator, headerSelect, headerNavRailToggle, headerNavRail
@docs headerNavMenuItemGroup, headerNavMenu, headerNavMenuItem, headerNavBar, headerNavItem, headerMenuItemRadio
@docs headerMenuItemGroup, headerMenuItemCheckbox, headerMenu, headerMenuItem, headerMenuTrigger, headerMenuItemElementBase
@docs headerLoadingIndicator, headerSelectionList, headerListOption, headerActionList, headerExpandableListItem, headerListAction
@docs headerListItemButton, headerList, headerListItem, headerIcon, headerHeading, headerFabMenuTrigger
@docs headerFabMenu, headerFab, headerAccordion, headerExpansionPanel, headerExpansionHeader, headerDrawerToggle
@docs headerDrawerContainer, headerDivider, headerDialogTrigger, headerDialog, headerDialogAction, headerDatepickerToggle
@docs headerDatepicker, headerContentPane, headerSuggestionChip, headerInputChipSet, headerInputChip, headerFilterChipSet
@docs headerFilterChip, headerChipSet, headerAssistChip, headerChip, headerCheckbox, headerCard
@docs headerCalendar, headerYearView, headerMultiYearView, headerMonthView, headerTooltip, headerRichTooltip
@docs headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup, headerIconButton, headerButton, headerBreadcrumb
@docs headerBreadcrumbItem, headerBreadcrumbItemButton, headerBottomSheetTrigger, headerBottomSheet, headerBottomSheetAction, headerBadge
@docs headerAvatar, headerAutocomplete, headerFormField, headerOptionPanel, headerFloatingPanel, headerOptgroup
@docs headerOption, headerFocusTrap, headerAppBar, headerTextOverflow, headerTextHighlight, headerStateLayer
@docs headerSlide, headerScrollContainer, headerRipple, headerPseudoRadio, headerPseudoCheckbox, headerFocusRing
@docs headerElevation, headerCollapsible, headerActionElementBase
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


header_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
header_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `header` slot of `Calendar`. -}
headerTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTree =
    header_core


{-| Place a `TreeItem` in the `header` slot of `Calendar`. -}
headerTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTreeItem =
    header_core


{-| Place a `Toolbar` in the `header` slot of `Calendar`. -}
headerToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToolbar =
    header_core


{-| Place a `Toc` in the `header` slot of `Calendar`. -}
headerToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToc =
    header_core


{-| Place a `TocItem` in the `header` slot of `Calendar`. -}
headerTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTocItem =
    header_core


{-| Place a `ThemeIcon` in the `header` slot of `Calendar`. -}
headerThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerThemeIcon =
    header_core


{-| Place a `Theme` in the `header` slot of `Calendar`. -}
headerTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTheme =
    header_core


{-| Place a `TextareaAutosize` in the `header` slot of `Calendar`. -}
headerTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextareaAutosize =
    header_core


{-| Place a `Tabs` in the `header` slot of `Calendar`. -}
headerTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabs =
    header_core


{-| Place a `TabPanel` in the `header` slot of `Calendar`. -}
headerTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabPanel =
    header_core


{-| Place a `Tab` in the `header` slot of `Calendar`. -}
headerTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTab =
    header_core


{-| Place a `Switch` in the `header` slot of `Calendar`. -}
headerSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSwitch =
    header_core


{-| Place a `StepperReset` in the `header` slot of `Calendar`. -}
headerStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperReset =
    header_core


{-| Place a `StepperPrevious` in the `header` slot of `Calendar`. -}
headerStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperPrevious =
    header_core


{-| Place a `Step` in the `header` slot of `Calendar`. -}
headerStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStep =
    header_core


{-| Place a `StepPanel` in the `header` slot of `Calendar`. -}
headerStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepPanel =
    header_core


{-| Place a `Stepper` in the `header` slot of `Calendar`. -}
headerStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepper =
    header_core


{-| Place a `SplitPane` in the `header` slot of `Calendar`. -}
headerSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitPane =
    header_core


{-| Place a `SplitButton` in the `header` slot of `Calendar`. -}
headerSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitButton =
    header_core


{-| Place a `Snackbar` in the `header` slot of `Calendar`. -}
headerSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSnackbar =
    header_core


{-| Place a `Slider` in the `header` slot of `Calendar`. -}
headerSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlider =
    header_core


{-| Place a `SliderThumb` in the `header` slot of `Calendar`. -}
headerSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSliderThumb =
    header_core


{-| Place a `SlideGroup` in the `header` slot of `Calendar`. -}
headerSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlideGroup =
    header_core


{-| Place a `Skeleton` in the `header` slot of `Calendar`. -}
headerSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSkeleton =
    header_core


{-| Place a `Shape` in the `header` slot of `Calendar`. -}
headerShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerShape =
    header_core


{-| Place a `SegmentedButton` in the `header` slot of `Calendar`. -}
headerSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSegmentedButton =
    header_core


{-| Place a `ButtonSegment` in the `header` slot of `Calendar`. -}
headerButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonSegment =
    header_core


{-| Place a `SearchView` in the `header` slot of `Calendar`. -}
headerSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchView =
    header_core


{-| Place a `SearchBar` in the `header` slot of `Calendar`. -}
headerSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchBar =
    header_core


{-| Place a `RadioGroup` in the `header` slot of `Calendar`. -}
headerRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadioGroup =
    header_core


{-| Place a `Radio` in the `header` slot of `Calendar`. -}
headerRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadio =
    header_core


{-| Place a `ProgressElementIndicatorBase` in the `header` slot of `Calendar`. -}
headerProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerProgressElementIndicatorBase =
    header_core


{-| Place a `Paginator` in the `header` slot of `Calendar`. -}
headerPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPaginator =
    header_core


{-| Place a `Select` in the `header` slot of `Calendar`. -}
headerSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelect =
    header_core


{-| Place a `NavRailToggle` in the `header` slot of `Calendar`. -}
headerNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRailToggle =
    header_core


{-| Place a `NavRail` in the `header` slot of `Calendar`. -}
headerNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRail =
    header_core


{-| Place a `NavMenuItemGroup` in the `header` slot of `Calendar`. -}
headerNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItemGroup =
    header_core


{-| Place a `NavMenu` in the `header` slot of `Calendar`. -}
headerNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenu =
    header_core


{-| Place a `NavMenuItem` in the `header` slot of `Calendar`. -}
headerNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItem =
    header_core


{-| Place a `NavBar` in the `header` slot of `Calendar`. -}
headerNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavBar =
    header_core


{-| Place a `NavItem` in the `header` slot of `Calendar`. -}
headerNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavItem =
    header_core


{-| Place a `MenuItemRadio` in the `header` slot of `Calendar`. -}
headerMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemRadio =
    header_core


{-| Place a `MenuItemGroup` in the `header` slot of `Calendar`. -}
headerMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemGroup =
    header_core


{-| Place a `MenuItemCheckbox` in the `header` slot of `Calendar`. -}
headerMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemCheckbox =
    header_core


{-| Place a `Menu` in the `header` slot of `Calendar`. -}
headerMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenu =
    header_core


{-| Place a `MenuItem` in the `header` slot of `Calendar`. -}
headerMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItem =
    header_core


{-| Place a `MenuTrigger` in the `header` slot of `Calendar`. -}
headerMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuTrigger =
    header_core


{-| Place a `MenuItemElementBase` in the `header` slot of `Calendar`. -}
headerMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemElementBase =
    header_core


{-| Place a `LoadingIndicator` in the `header` slot of `Calendar`. -}
headerLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerLoadingIndicator =
    header_core


{-| Place a `SelectionList` in the `header` slot of `Calendar`. -}
headerSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelectionList =
    header_core


{-| Place a `ListOption` in the `header` slot of `Calendar`. -}
headerListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListOption =
    header_core


{-| Place a `ActionList` in the `header` slot of `Calendar`. -}
headerActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionList =
    header_core


{-| Place a `ExpandableListItem` in the `header` slot of `Calendar`. -}
headerExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpandableListItem =
    header_core


{-| Place a `ListAction` in the `header` slot of `Calendar`. -}
headerListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListAction =
    header_core


{-| Place a `ListItemButton` in the `header` slot of `Calendar`. -}
headerListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItemButton =
    header_core


{-| Place a `List` in the `header` slot of `Calendar`. -}
headerList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerList =
    header_core


{-| Place a `ListItem` in the `header` slot of `Calendar`. -}
headerListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItem =
    header_core


{-| Place a `Icon` in the `header` slot of `Calendar`. -}
headerIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIcon =
    header_core


{-| Place a `Heading` in the `header` slot of `Calendar`. -}
headerHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerHeading =
    header_core


{-| Place a `FabMenuTrigger` in the `header` slot of `Calendar`. -}
headerFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenuTrigger =
    header_core


{-| Place a `FabMenu` in the `header` slot of `Calendar`. -}
headerFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenu =
    header_core


{-| Place a `Fab` in the `header` slot of `Calendar`. -}
headerFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFab =
    header_core


{-| Place a `Accordion` in the `header` slot of `Calendar`. -}
headerAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAccordion =
    header_core


{-| Place a `ExpansionPanel` in the `header` slot of `Calendar`. -}
headerExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionPanel =
    header_core


{-| Place a `ExpansionHeader` in the `header` slot of `Calendar`. -}
headerExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionHeader =
    header_core


{-| Place a `DrawerToggle` in the `header` slot of `Calendar`. -}
headerDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerToggle =
    header_core


{-| Place a `DrawerContainer` in the `header` slot of `Calendar`. -}
headerDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerContainer =
    header_core


{-| Place a `Divider` in the `header` slot of `Calendar`. -}
headerDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDivider =
    header_core


{-| Place a `DialogTrigger` in the `header` slot of `Calendar`. -}
headerDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogTrigger =
    header_core


{-| Place a `Dialog` in the `header` slot of `Calendar`. -}
headerDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialog =
    header_core


{-| Place a `DialogAction` in the `header` slot of `Calendar`. -}
headerDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogAction =
    header_core


{-| Place a `DatepickerToggle` in the `header` slot of `Calendar`. -}
headerDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepickerToggle =
    header_core


{-| Place a `Datepicker` in the `header` slot of `Calendar`. -}
headerDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepicker =
    header_core


{-| Place a `ContentPane` in the `header` slot of `Calendar`. -}
headerContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerContentPane =
    header_core


{-| Place a `SuggestionChip` in the `header` slot of `Calendar`. -}
headerSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSuggestionChip =
    header_core


{-| Place a `InputChipSet` in the `header` slot of `Calendar`. -}
headerInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChipSet =
    header_core


{-| Place a `InputChip` in the `header` slot of `Calendar`. -}
headerInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChip =
    header_core


{-| Place a `FilterChipSet` in the `header` slot of `Calendar`. -}
headerFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChipSet =
    header_core


{-| Place a `FilterChip` in the `header` slot of `Calendar`. -}
headerFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChip =
    header_core


{-| Place a `ChipSet` in the `header` slot of `Calendar`. -}
headerChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChipSet =
    header_core


{-| Place a `AssistChip` in the `header` slot of `Calendar`. -}
headerAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAssistChip =
    header_core


{-| Place a `Chip` in the `header` slot of `Calendar`. -}
headerChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChip =
    header_core


{-| Place a `Checkbox` in the `header` slot of `Calendar`. -}
headerCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCheckbox =
    header_core


{-| Place a `Card` in the `header` slot of `Calendar`. -}
headerCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCard =
    header_core


{-| Place a `Calendar` in the `header` slot of `Calendar`. -}
headerCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCalendar =
    header_core


{-| Place a `YearView` in the `header` slot of `Calendar`. -}
headerYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerYearView =
    header_core


{-| Place a `MultiYearView` in the `header` slot of `Calendar`. -}
headerMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMultiYearView =
    header_core


{-| Place a `MonthView` in the `header` slot of `Calendar`. -}
headerMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMonthView =
    header_core


{-| Place a `Tooltip` in the `header` slot of `Calendar`. -}
headerTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltip =
    header_core


{-| Place a `RichTooltip` in the `header` slot of `Calendar`. -}
headerRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltip =
    header_core


{-| Place a `TooltipElementBase` in the `header` slot of `Calendar`. -}
headerTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltipElementBase =
    header_core


{-| Place a `RichTooltipAction` in the `header` slot of `Calendar`. -}
headerRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltipAction =
    header_core


{-| Place a `ButtonGroup` in the `header` slot of `Calendar`. -}
headerButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonGroup =
    header_core


{-| Place a `IconButton` in the `header` slot of `Calendar`. -}
headerIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIconButton =
    header_core


{-| Place a `Button` in the `header` slot of `Calendar`. -}
headerButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButton =
    header_core


{-| Place a `Breadcrumb` in the `header` slot of `Calendar`. -}
headerBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumb =
    header_core


{-| Place a `BreadcrumbItem` in the `header` slot of `Calendar`. -}
headerBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItem =
    header_core


{-| Place a `BreadcrumbItemButton` in the `header` slot of `Calendar`. -}
headerBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItemButton =
    header_core


{-| Place a `BottomSheetTrigger` in the `header` slot of `Calendar`. -}
headerBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetTrigger =
    header_core


{-| Place a `BottomSheet` in the `header` slot of `Calendar`. -}
headerBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheet =
    header_core


{-| Place a `BottomSheetAction` in the `header` slot of `Calendar`. -}
headerBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetAction =
    header_core


{-| Place a `Badge` in the `header` slot of `Calendar`. -}
headerBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBadge =
    header_core


{-| Place a `Avatar` in the `header` slot of `Calendar`. -}
headerAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAvatar =
    header_core


{-| Place a `Autocomplete` in the `header` slot of `Calendar`. -}
headerAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAutocomplete =
    header_core


{-| Place a `FormField` in the `header` slot of `Calendar`. -}
headerFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFormField =
    header_core


{-| Place a `OptionPanel` in the `header` slot of `Calendar`. -}
headerOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptionPanel =
    header_core


{-| Place a `FloatingPanel` in the `header` slot of `Calendar`. -}
headerFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFloatingPanel =
    header_core


{-| Place a `Optgroup` in the `header` slot of `Calendar`. -}
headerOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptgroup =
    header_core


{-| Place a `Option` in the `header` slot of `Calendar`. -}
headerOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOption =
    header_core


{-| Place a `FocusTrap` in the `header` slot of `Calendar`. -}
headerFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusTrap =
    header_core


{-| Place a `AppBar` in the `header` slot of `Calendar`. -}
headerAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAppBar =
    header_core


{-| Place a `TextOverflow` in the `header` slot of `Calendar`. -}
headerTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextOverflow =
    header_core


{-| Place a `TextHighlight` in the `header` slot of `Calendar`. -}
headerTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextHighlight =
    header_core


{-| Place a `StateLayer` in the `header` slot of `Calendar`. -}
headerStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStateLayer =
    header_core


{-| Place a `Slide` in the `header` slot of `Calendar`. -}
headerSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlide =
    header_core


{-| Place a `ScrollContainer` in the `header` slot of `Calendar`. -}
headerScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerScrollContainer =
    header_core


{-| Place a `Ripple` in the `header` slot of `Calendar`. -}
headerRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRipple =
    header_core


{-| Place a `PseudoRadio` in the `header` slot of `Calendar`. -}
headerPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoRadio =
    header_core


{-| Place a `PseudoCheckbox` in the `header` slot of `Calendar`. -}
headerPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoCheckbox =
    header_core


{-| Place a `FocusRing` in the `header` slot of `Calendar`. -}
headerFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusRing =
    header_core


{-| Place a `Elevation` in the `header` slot of `Calendar`. -}
headerElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerElevation =
    header_core


{-| Place a `Collapsible` in the `header` slot of `Calendar`. -}
headerCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCollapsible =
    header_core


{-| Place a `ActionElementBase` in the `header` slot of `Calendar`. -}
headerActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Calendar.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionElementBase =
    header_core