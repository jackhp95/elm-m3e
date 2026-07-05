module M3e.Build.ExpandableListItem.Slots exposing
    ( leadingIcon, leadingAvatar, toggleIconIcon, itemsTree, itemsTreeItem, itemsToolbar
    , itemsToc, itemsTocItem, itemsThemeIcon, itemsTheme, itemsTextareaAutosize, itemsTabs, itemsTabPanel
    , itemsTab, itemsSwitch, itemsStepperReset, itemsStepperPrevious, itemsStep, itemsStepPanel, itemsStepper
    , itemsSplitPane, itemsSplitButton, itemsSnackbar, itemsSlider, itemsSliderThumb, itemsSlideGroup, itemsSkeleton
    , itemsShape, itemsSegmentedButton, itemsButtonSegment, itemsSearchView, itemsSearchBar, itemsRadioGroup, itemsRadio
    , itemsProgressElementIndicatorBase, itemsPaginator, itemsSelect, itemsNavRailToggle, itemsNavRail, itemsNavMenuItemGroup, itemsNavMenu
    , itemsNavMenuItem, itemsNavBar, itemsNavItem, itemsMenuItemRadio, itemsMenuItemGroup, itemsMenuItemCheckbox, itemsMenu
    , itemsMenuItem, itemsMenuTrigger, itemsMenuItemElementBase, itemsLoadingIndicator, itemsSelectionList, itemsListOption, itemsActionList
    , itemsExpandableListItem, itemsListAction, itemsListItemButton, itemsList, itemsListItem, itemsIcon, itemsHeading
    , itemsFabMenuTrigger, itemsFabMenu, itemsFab, itemsAccordion, itemsExpansionPanel, itemsExpansionHeader, itemsDrawerToggle
    , itemsDrawerContainer, itemsDivider, itemsDialogTrigger, itemsDialog, itemsDialogAction, itemsDatepickerToggle, itemsDatepicker
    , itemsContentPane, itemsSuggestionChip, itemsInputChipSet, itemsInputChip, itemsFilterChipSet, itemsFilterChip, itemsChipSet
    , itemsAssistChip, itemsChip, itemsCheckbox, itemsCard, itemsCalendar, itemsYearView, itemsMultiYearView
    , itemsMonthView, itemsTooltip, itemsRichTooltip, itemsTooltipElementBase, itemsRichTooltipAction, itemsButtonGroup, itemsIconButton
    , itemsButton, itemsBreadcrumb, itemsBreadcrumbItem, itemsBreadcrumbItemButton, itemsBottomSheetTrigger, itemsBottomSheet, itemsBottomSheetAction
    , itemsBadge, itemsAvatar, itemsAutocomplete, itemsFormField, itemsOptionPanel, itemsFloatingPanel, itemsOptgroup
    , itemsOption, itemsFocusTrap, itemsAppBar, itemsTextOverflow, itemsTextHighlight, itemsStateLayer, itemsSlide
    , itemsScrollContainer, itemsRipple, itemsPseudoRadio, itemsPseudoCheckbox, itemsFocusRing, itemsElevation, itemsCollapsible
    , itemsActionElementBase
    )

{-|
Slot setters for `M3e.Build.ExpandableListItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIcon, leadingAvatar, toggleIconIcon, itemsTree, itemsTreeItem, itemsToolbar
@docs itemsToc, itemsTocItem, itemsThemeIcon, itemsTheme, itemsTextareaAutosize, itemsTabs
@docs itemsTabPanel, itemsTab, itemsSwitch, itemsStepperReset, itemsStepperPrevious, itemsStep
@docs itemsStepPanel, itemsStepper, itemsSplitPane, itemsSplitButton, itemsSnackbar, itemsSlider
@docs itemsSliderThumb, itemsSlideGroup, itemsSkeleton, itemsShape, itemsSegmentedButton, itemsButtonSegment
@docs itemsSearchView, itemsSearchBar, itemsRadioGroup, itemsRadio, itemsProgressElementIndicatorBase, itemsPaginator
@docs itemsSelect, itemsNavRailToggle, itemsNavRail, itemsNavMenuItemGroup, itemsNavMenu, itemsNavMenuItem
@docs itemsNavBar, itemsNavItem, itemsMenuItemRadio, itemsMenuItemGroup, itemsMenuItemCheckbox, itemsMenu
@docs itemsMenuItem, itemsMenuTrigger, itemsMenuItemElementBase, itemsLoadingIndicator, itemsSelectionList, itemsListOption
@docs itemsActionList, itemsExpandableListItem, itemsListAction, itemsListItemButton, itemsList, itemsListItem
@docs itemsIcon, itemsHeading, itemsFabMenuTrigger, itemsFabMenu, itemsFab, itemsAccordion
@docs itemsExpansionPanel, itemsExpansionHeader, itemsDrawerToggle, itemsDrawerContainer, itemsDivider, itemsDialogTrigger
@docs itemsDialog, itemsDialogAction, itemsDatepickerToggle, itemsDatepicker, itemsContentPane, itemsSuggestionChip
@docs itemsInputChipSet, itemsInputChip, itemsFilterChipSet, itemsFilterChip, itemsChipSet, itemsAssistChip
@docs itemsChip, itemsCheckbox, itemsCard, itemsCalendar, itemsYearView, itemsMultiYearView
@docs itemsMonthView, itemsTooltip, itemsRichTooltip, itemsTooltipElementBase, itemsRichTooltipAction, itemsButtonGroup
@docs itemsIconButton, itemsButton, itemsBreadcrumb, itemsBreadcrumbItem, itemsBreadcrumbItemButton, itemsBottomSheetTrigger
@docs itemsBottomSheet, itemsBottomSheetAction, itemsBadge, itemsAvatar, itemsAutocomplete, itemsFormField
@docs itemsOptionPanel, itemsFloatingPanel, itemsOptgroup, itemsOption, itemsFocusTrap, itemsAppBar
@docs itemsTextOverflow, itemsTextHighlight, itemsStateLayer, itemsSlide, itemsScrollContainer, itemsRipple
@docs itemsPseudoRadio, itemsPseudoCheckbox, itemsFocusRing, itemsElevation, itemsCollapsible, itemsActionElementBase
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


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


items_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
items_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `leading` slot of `ExpandableListItem`. -}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingIcon =
    leading_core


{-| Place a `Avatar` in the `leading` slot of `ExpandableListItem`. -}
leadingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingAvatar =
    leading_core


{-| Place a `Icon` in the `toggle-icon` slot of `ExpandableListItem`. -}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIconIcon =
    toggleIcon_core


{-| Place a `Tree` in the `items` slot of `ExpandableListItem`. -}
itemsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTree =
    items_core


{-| Place a `TreeItem` in the `items` slot of `ExpandableListItem`. -}
itemsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTreeItem =
    items_core


{-| Place a `Toolbar` in the `items` slot of `ExpandableListItem`. -}
itemsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsToolbar =
    items_core


{-| Place a `Toc` in the `items` slot of `ExpandableListItem`. -}
itemsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsToc =
    items_core


{-| Place a `TocItem` in the `items` slot of `ExpandableListItem`. -}
itemsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTocItem =
    items_core


{-| Place a `ThemeIcon` in the `items` slot of `ExpandableListItem`. -}
itemsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsThemeIcon =
    items_core


{-| Place a `Theme` in the `items` slot of `ExpandableListItem`. -}
itemsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTheme =
    items_core


{-| Place a `TextareaAutosize` in the `items` slot of `ExpandableListItem`. -}
itemsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTextareaAutosize =
    items_core


{-| Place a `Tabs` in the `items` slot of `ExpandableListItem`. -}
itemsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTabs =
    items_core


{-| Place a `TabPanel` in the `items` slot of `ExpandableListItem`. -}
itemsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTabPanel =
    items_core


{-| Place a `Tab` in the `items` slot of `ExpandableListItem`. -}
itemsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTab =
    items_core


{-| Place a `Switch` in the `items` slot of `ExpandableListItem`. -}
itemsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSwitch =
    items_core


{-| Place a `StepperReset` in the `items` slot of `ExpandableListItem`. -}
itemsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStepperReset =
    items_core


{-| Place a `StepperPrevious` in the `items` slot of `ExpandableListItem`. -}
itemsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStepperPrevious =
    items_core


{-| Place a `Step` in the `items` slot of `ExpandableListItem`. -}
itemsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStep =
    items_core


{-| Place a `StepPanel` in the `items` slot of `ExpandableListItem`. -}
itemsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStepPanel =
    items_core


{-| Place a `Stepper` in the `items` slot of `ExpandableListItem`. -}
itemsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStepper =
    items_core


{-| Place a `SplitPane` in the `items` slot of `ExpandableListItem`. -}
itemsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSplitPane =
    items_core


{-| Place a `SplitButton` in the `items` slot of `ExpandableListItem`. -}
itemsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSplitButton =
    items_core


{-| Place a `Snackbar` in the `items` slot of `ExpandableListItem`. -}
itemsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSnackbar =
    items_core


{-| Place a `Slider` in the `items` slot of `ExpandableListItem`. -}
itemsSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSlider =
    items_core


{-| Place a `SliderThumb` in the `items` slot of `ExpandableListItem`. -}
itemsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSliderThumb =
    items_core


{-| Place a `SlideGroup` in the `items` slot of `ExpandableListItem`. -}
itemsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSlideGroup =
    items_core


{-| Place a `Skeleton` in the `items` slot of `ExpandableListItem`. -}
itemsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSkeleton =
    items_core


{-| Place a `Shape` in the `items` slot of `ExpandableListItem`. -}
itemsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsShape =
    items_core


{-| Place a `SegmentedButton` in the `items` slot of `ExpandableListItem`. -}
itemsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSegmentedButton =
    items_core


{-| Place a `ButtonSegment` in the `items` slot of `ExpandableListItem`. -}
itemsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsButtonSegment =
    items_core


{-| Place a `SearchView` in the `items` slot of `ExpandableListItem`. -}
itemsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSearchView =
    items_core


{-| Place a `SearchBar` in the `items` slot of `ExpandableListItem`. -}
itemsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSearchBar =
    items_core


{-| Place a `RadioGroup` in the `items` slot of `ExpandableListItem`. -}
itemsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsRadioGroup =
    items_core


{-| Place a `Radio` in the `items` slot of `ExpandableListItem`. -}
itemsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsRadio =
    items_core


{-| Place a `ProgressElementIndicatorBase` in the `items` slot of `ExpandableListItem`. -}
itemsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsProgressElementIndicatorBase =
    items_core


{-| Place a `Paginator` in the `items` slot of `ExpandableListItem`. -}
itemsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsPaginator =
    items_core


{-| Place a `Select` in the `items` slot of `ExpandableListItem`. -}
itemsSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSelect =
    items_core


{-| Place a `NavRailToggle` in the `items` slot of `ExpandableListItem`. -}
itemsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavRailToggle =
    items_core


{-| Place a `NavRail` in the `items` slot of `ExpandableListItem`. -}
itemsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavRail =
    items_core


{-| Place a `NavMenuItemGroup` in the `items` slot of `ExpandableListItem`. -}
itemsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavMenuItemGroup =
    items_core


{-| Place a `NavMenu` in the `items` slot of `ExpandableListItem`. -}
itemsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavMenu =
    items_core


{-| Place a `NavMenuItem` in the `items` slot of `ExpandableListItem`. -}
itemsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavMenuItem =
    items_core


{-| Place a `NavBar` in the `items` slot of `ExpandableListItem`. -}
itemsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavBar =
    items_core


{-| Place a `NavItem` in the `items` slot of `ExpandableListItem`. -}
itemsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsNavItem =
    items_core


{-| Place a `MenuItemRadio` in the `items` slot of `ExpandableListItem`. -}
itemsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuItemRadio =
    items_core


{-| Place a `MenuItemGroup` in the `items` slot of `ExpandableListItem`. -}
itemsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuItemGroup =
    items_core


{-| Place a `MenuItemCheckbox` in the `items` slot of `ExpandableListItem`. -}
itemsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuItemCheckbox =
    items_core


{-| Place a `Menu` in the `items` slot of `ExpandableListItem`. -}
itemsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenu =
    items_core


{-| Place a `MenuItem` in the `items` slot of `ExpandableListItem`. -}
itemsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuItem =
    items_core


{-| Place a `MenuTrigger` in the `items` slot of `ExpandableListItem`. -}
itemsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuTrigger =
    items_core


{-| Place a `MenuItemElementBase` in the `items` slot of `ExpandableListItem`. -}
itemsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMenuItemElementBase =
    items_core


{-| Place a `LoadingIndicator` in the `items` slot of `ExpandableListItem`. -}
itemsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsLoadingIndicator =
    items_core


{-| Place a `SelectionList` in the `items` slot of `ExpandableListItem`. -}
itemsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSelectionList =
    items_core


{-| Place a `ListOption` in the `items` slot of `ExpandableListItem`. -}
itemsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsListOption =
    items_core


{-| Place a `ActionList` in the `items` slot of `ExpandableListItem`. -}
itemsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsActionList =
    items_core


{-| Place a `ExpandableListItem` in the `items` slot of `ExpandableListItem`. -}
itemsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsExpandableListItem =
    items_core


{-| Place a `ListAction` in the `items` slot of `ExpandableListItem`. -}
itemsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsListAction =
    items_core


{-| Place a `ListItemButton` in the `items` slot of `ExpandableListItem`. -}
itemsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsListItemButton =
    items_core


{-| Place a `List` in the `items` slot of `ExpandableListItem`. -}
itemsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsList =
    items_core


{-| Place a `ListItem` in the `items` slot of `ExpandableListItem`. -}
itemsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsListItem =
    items_core


{-| Place a `Icon` in the `items` slot of `ExpandableListItem`. -}
itemsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsIcon =
    items_core


{-| Place a `Heading` in the `items` slot of `ExpandableListItem`. -}
itemsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsHeading =
    items_core


{-| Place a `FabMenuTrigger` in the `items` slot of `ExpandableListItem`. -}
itemsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFabMenuTrigger =
    items_core


{-| Place a `FabMenu` in the `items` slot of `ExpandableListItem`. -}
itemsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFabMenu =
    items_core


{-| Place a `Fab` in the `items` slot of `ExpandableListItem`. -}
itemsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFab =
    items_core


{-| Place a `Accordion` in the `items` slot of `ExpandableListItem`. -}
itemsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsAccordion =
    items_core


{-| Place a `ExpansionPanel` in the `items` slot of `ExpandableListItem`. -}
itemsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsExpansionPanel =
    items_core


{-| Place a `ExpansionHeader` in the `items` slot of `ExpandableListItem`. -}
itemsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsExpansionHeader =
    items_core


{-| Place a `DrawerToggle` in the `items` slot of `ExpandableListItem`. -}
itemsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDrawerToggle =
    items_core


{-| Place a `DrawerContainer` in the `items` slot of `ExpandableListItem`. -}
itemsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDrawerContainer =
    items_core


{-| Place a `Divider` in the `items` slot of `ExpandableListItem`. -}
itemsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDivider =
    items_core


{-| Place a `DialogTrigger` in the `items` slot of `ExpandableListItem`. -}
itemsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDialogTrigger =
    items_core


{-| Place a `Dialog` in the `items` slot of `ExpandableListItem`. -}
itemsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDialog =
    items_core


{-| Place a `DialogAction` in the `items` slot of `ExpandableListItem`. -}
itemsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDialogAction =
    items_core


{-| Place a `DatepickerToggle` in the `items` slot of `ExpandableListItem`. -}
itemsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDatepickerToggle =
    items_core


{-| Place a `Datepicker` in the `items` slot of `ExpandableListItem`. -}
itemsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsDatepicker =
    items_core


{-| Place a `ContentPane` in the `items` slot of `ExpandableListItem`. -}
itemsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsContentPane =
    items_core


{-| Place a `SuggestionChip` in the `items` slot of `ExpandableListItem`. -}
itemsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSuggestionChip =
    items_core


{-| Place a `InputChipSet` in the `items` slot of `ExpandableListItem`. -}
itemsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsInputChipSet =
    items_core


{-| Place a `InputChip` in the `items` slot of `ExpandableListItem`. -}
itemsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsInputChip =
    items_core


{-| Place a `FilterChipSet` in the `items` slot of `ExpandableListItem`. -}
itemsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFilterChipSet =
    items_core


{-| Place a `FilterChip` in the `items` slot of `ExpandableListItem`. -}
itemsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFilterChip =
    items_core


{-| Place a `ChipSet` in the `items` slot of `ExpandableListItem`. -}
itemsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsChipSet =
    items_core


{-| Place a `AssistChip` in the `items` slot of `ExpandableListItem`. -}
itemsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsAssistChip =
    items_core


{-| Place a `Chip` in the `items` slot of `ExpandableListItem`. -}
itemsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsChip =
    items_core


{-| Place a `Checkbox` in the `items` slot of `ExpandableListItem`. -}
itemsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsCheckbox =
    items_core


{-| Place a `Card` in the `items` slot of `ExpandableListItem`. -}
itemsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsCard =
    items_core


{-| Place a `Calendar` in the `items` slot of `ExpandableListItem`. -}
itemsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsCalendar =
    items_core


{-| Place a `YearView` in the `items` slot of `ExpandableListItem`. -}
itemsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsYearView =
    items_core


{-| Place a `MultiYearView` in the `items` slot of `ExpandableListItem`. -}
itemsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMultiYearView =
    items_core


{-| Place a `MonthView` in the `items` slot of `ExpandableListItem`. -}
itemsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsMonthView =
    items_core


{-| Place a `Tooltip` in the `items` slot of `ExpandableListItem`. -}
itemsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTooltip =
    items_core


{-| Place a `RichTooltip` in the `items` slot of `ExpandableListItem`. -}
itemsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsRichTooltip =
    items_core


{-| Place a `TooltipElementBase` in the `items` slot of `ExpandableListItem`. -}
itemsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTooltipElementBase =
    items_core


{-| Place a `RichTooltipAction` in the `items` slot of `ExpandableListItem`. -}
itemsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsRichTooltipAction =
    items_core


{-| Place a `ButtonGroup` in the `items` slot of `ExpandableListItem`. -}
itemsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsButtonGroup =
    items_core


{-| Place a `IconButton` in the `items` slot of `ExpandableListItem`. -}
itemsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsIconButton =
    items_core


{-| Place a `Button` in the `items` slot of `ExpandableListItem`. -}
itemsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsButton =
    items_core


{-| Place a `Breadcrumb` in the `items` slot of `ExpandableListItem`. -}
itemsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBreadcrumb =
    items_core


{-| Place a `BreadcrumbItem` in the `items` slot of `ExpandableListItem`. -}
itemsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBreadcrumbItem =
    items_core


{-| Place a `BreadcrumbItemButton` in the `items` slot of `ExpandableListItem`. -}
itemsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBreadcrumbItemButton =
    items_core


{-| Place a `BottomSheetTrigger` in the `items` slot of `ExpandableListItem`. -}
itemsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBottomSheetTrigger =
    items_core


{-| Place a `BottomSheet` in the `items` slot of `ExpandableListItem`. -}
itemsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBottomSheet =
    items_core


{-| Place a `BottomSheetAction` in the `items` slot of `ExpandableListItem`. -}
itemsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBottomSheetAction =
    items_core


{-| Place a `Badge` in the `items` slot of `ExpandableListItem`. -}
itemsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsBadge =
    items_core


{-| Place a `Avatar` in the `items` slot of `ExpandableListItem`. -}
itemsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsAvatar =
    items_core


{-| Place a `Autocomplete` in the `items` slot of `ExpandableListItem`. -}
itemsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsAutocomplete =
    items_core


{-| Place a `FormField` in the `items` slot of `ExpandableListItem`. -}
itemsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFormField =
    items_core


{-| Place a `OptionPanel` in the `items` slot of `ExpandableListItem`. -}
itemsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsOptionPanel =
    items_core


{-| Place a `FloatingPanel` in the `items` slot of `ExpandableListItem`. -}
itemsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFloatingPanel =
    items_core


{-| Place a `Optgroup` in the `items` slot of `ExpandableListItem`. -}
itemsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsOptgroup =
    items_core


{-| Place a `Option` in the `items` slot of `ExpandableListItem`. -}
itemsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsOption =
    items_core


{-| Place a `FocusTrap` in the `items` slot of `ExpandableListItem`. -}
itemsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFocusTrap =
    items_core


{-| Place a `AppBar` in the `items` slot of `ExpandableListItem`. -}
itemsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsAppBar =
    items_core


{-| Place a `TextOverflow` in the `items` slot of `ExpandableListItem`. -}
itemsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTextOverflow =
    items_core


{-| Place a `TextHighlight` in the `items` slot of `ExpandableListItem`. -}
itemsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsTextHighlight =
    items_core


{-| Place a `StateLayer` in the `items` slot of `ExpandableListItem`. -}
itemsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsStateLayer =
    items_core


{-| Place a `Slide` in the `items` slot of `ExpandableListItem`. -}
itemsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsSlide =
    items_core


{-| Place a `ScrollContainer` in the `items` slot of `ExpandableListItem`. -}
itemsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsScrollContainer =
    items_core


{-| Place a `Ripple` in the `items` slot of `ExpandableListItem`. -}
itemsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsRipple =
    items_core


{-| Place a `PseudoRadio` in the `items` slot of `ExpandableListItem`. -}
itemsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsPseudoRadio =
    items_core


{-| Place a `PseudoCheckbox` in the `items` slot of `ExpandableListItem`. -}
itemsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsPseudoCheckbox =
    items_core


{-| Place a `FocusRing` in the `items` slot of `ExpandableListItem`. -}
itemsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsFocusRing =
    items_core


{-| Place a `Elevation` in the `items` slot of `ExpandableListItem`. -}
itemsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsElevation =
    items_core


{-| Place a `Collapsible` in the `items` slot of `ExpandableListItem`. -}
itemsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsCollapsible =
    items_core


{-| Place a `ActionElementBase` in the `items` slot of `ExpandableListItem`. -}
itemsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpandableListItem.Builder pa { ps
        | items : M3e.Build.Internal.Used
    } msg pk
itemsActionElementBase =
    items_core