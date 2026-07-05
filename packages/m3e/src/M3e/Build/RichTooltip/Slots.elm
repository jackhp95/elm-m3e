module M3e.Build.RichTooltip.Slots exposing
    ( actionsTree, actionsTreeItem, actionsToolbar, actionsToc, actionsTocItem, actionsThemeIcon
    , actionsTheme, actionsTextareaAutosize, actionsTabs, actionsTabPanel, actionsTab, actionsSwitch, actionsStepperReset
    , actionsStepperPrevious, actionsStep, actionsStepPanel, actionsStepper, actionsSplitPane, actionsSplitButton, actionsSnackbar
    , actionsSlider, actionsSliderThumb, actionsSlideGroup, actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment
    , actionsSearchView, actionsSearchBar, actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator, actionsSelect
    , actionsNavRailToggle, actionsNavRail, actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem, actionsNavBar, actionsNavItem
    , actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu, actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase
    , actionsLoadingIndicator, actionsSelectionList, actionsListOption, actionsActionList, actionsExpandableListItem, actionsListAction, actionsListItemButton
    , actionsList, actionsListItem, actionsIcon, actionsHeading, actionsFabMenuTrigger, actionsFabMenu, actionsFab
    , actionsAccordion, actionsExpansionPanel, actionsExpansionHeader, actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger
    , actionsDialog, actionsDialogAction, actionsDatepickerToggle, actionsDatepicker, actionsContentPane, actionsSuggestionChip, actionsInputChipSet
    , actionsInputChip, actionsFilterChipSet, actionsFilterChip, actionsChipSet, actionsAssistChip, actionsChip, actionsCheckbox
    , actionsCard, actionsCalendar, actionsYearView, actionsMultiYearView, actionsMonthView, actionsTooltip, actionsRichTooltip
    , actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup, actionsIconButton, actionsButton, actionsBreadcrumb, actionsBreadcrumbItem
    , actionsBreadcrumbItemButton, actionsBottomSheetTrigger, actionsBottomSheet, actionsBottomSheetAction, actionsBadge, actionsAvatar, actionsAutocomplete
    , actionsFormField, actionsOptionPanel, actionsFloatingPanel, actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar
    , actionsTextOverflow, actionsTextHighlight, actionsStateLayer, actionsSlide, actionsScrollContainer, actionsRipple, actionsPseudoRadio
    , actionsPseudoCheckbox, actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase
    )

{-|
Slot setters for `M3e.Build.RichTooltip`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs actionsTree, actionsTreeItem, actionsToolbar, actionsToc, actionsTocItem, actionsThemeIcon
@docs actionsTheme, actionsTextareaAutosize, actionsTabs, actionsTabPanel, actionsTab, actionsSwitch
@docs actionsStepperReset, actionsStepperPrevious, actionsStep, actionsStepPanel, actionsStepper, actionsSplitPane
@docs actionsSplitButton, actionsSnackbar, actionsSlider, actionsSliderThumb, actionsSlideGroup, actionsSkeleton
@docs actionsShape, actionsSegmentedButton, actionsButtonSegment, actionsSearchView, actionsSearchBar, actionsRadioGroup
@docs actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator, actionsSelect, actionsNavRailToggle, actionsNavRail
@docs actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem, actionsNavBar, actionsNavItem, actionsMenuItemRadio
@docs actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu, actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase
@docs actionsLoadingIndicator, actionsSelectionList, actionsListOption, actionsActionList, actionsExpandableListItem, actionsListAction
@docs actionsListItemButton, actionsList, actionsListItem, actionsIcon, actionsHeading, actionsFabMenuTrigger
@docs actionsFabMenu, actionsFab, actionsAccordion, actionsExpansionPanel, actionsExpansionHeader, actionsDrawerToggle
@docs actionsDrawerContainer, actionsDivider, actionsDialogTrigger, actionsDialog, actionsDialogAction, actionsDatepickerToggle
@docs actionsDatepicker, actionsContentPane, actionsSuggestionChip, actionsInputChipSet, actionsInputChip, actionsFilterChipSet
@docs actionsFilterChip, actionsChipSet, actionsAssistChip, actionsChip, actionsCheckbox, actionsCard
@docs actionsCalendar, actionsYearView, actionsMultiYearView, actionsMonthView, actionsTooltip, actionsRichTooltip
@docs actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup, actionsIconButton, actionsButton, actionsBreadcrumb
@docs actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger, actionsBottomSheet, actionsBottomSheetAction, actionsBadge
@docs actionsAvatar, actionsAutocomplete, actionsFormField, actionsOptionPanel, actionsFloatingPanel, actionsOptgroup
@docs actionsOption, actionsFocusTrap, actionsAppBar, actionsTextOverflow, actionsTextHighlight, actionsStateLayer
@docs actionsSlide, actionsScrollContainer, actionsRipple, actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing
@docs actionsElevation, actionsCollapsible, actionsActionElementBase
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


actions_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actions_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `actions` slot of `RichTooltip`. -}
actionsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTree =
    actions_core


{-| Place a `TreeItem` in the `actions` slot of `RichTooltip`. -}
actionsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTreeItem =
    actions_core


{-| Place a `Toolbar` in the `actions` slot of `RichTooltip`. -}
actionsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToolbar =
    actions_core


{-| Place a `Toc` in the `actions` slot of `RichTooltip`. -}
actionsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToc =
    actions_core


{-| Place a `TocItem` in the `actions` slot of `RichTooltip`. -}
actionsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTocItem =
    actions_core


{-| Place a `ThemeIcon` in the `actions` slot of `RichTooltip`. -}
actionsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsThemeIcon =
    actions_core


{-| Place a `Theme` in the `actions` slot of `RichTooltip`. -}
actionsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTheme =
    actions_core


{-| Place a `TextareaAutosize` in the `actions` slot of `RichTooltip`. -}
actionsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextareaAutosize =
    actions_core


{-| Place a `Tabs` in the `actions` slot of `RichTooltip`. -}
actionsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabs =
    actions_core


{-| Place a `TabPanel` in the `actions` slot of `RichTooltip`. -}
actionsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabPanel =
    actions_core


{-| Place a `Tab` in the `actions` slot of `RichTooltip`. -}
actionsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTab =
    actions_core


{-| Place a `Switch` in the `actions` slot of `RichTooltip`. -}
actionsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSwitch =
    actions_core


{-| Place a `StepperReset` in the `actions` slot of `RichTooltip`. -}
actionsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperReset =
    actions_core


{-| Place a `StepperPrevious` in the `actions` slot of `RichTooltip`. -}
actionsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperPrevious =
    actions_core


{-| Place a `Step` in the `actions` slot of `RichTooltip`. -}
actionsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStep =
    actions_core


{-| Place a `StepPanel` in the `actions` slot of `RichTooltip`. -}
actionsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepPanel =
    actions_core


{-| Place a `Stepper` in the `actions` slot of `RichTooltip`. -}
actionsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepper =
    actions_core


{-| Place a `SplitPane` in the `actions` slot of `RichTooltip`. -}
actionsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitPane =
    actions_core


{-| Place a `SplitButton` in the `actions` slot of `RichTooltip`. -}
actionsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitButton =
    actions_core


{-| Place a `Snackbar` in the `actions` slot of `RichTooltip`. -}
actionsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSnackbar =
    actions_core


{-| Place a `Slider` in the `actions` slot of `RichTooltip`. -}
actionsSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlider =
    actions_core


{-| Place a `SliderThumb` in the `actions` slot of `RichTooltip`. -}
actionsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSliderThumb =
    actions_core


{-| Place a `SlideGroup` in the `actions` slot of `RichTooltip`. -}
actionsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlideGroup =
    actions_core


{-| Place a `Skeleton` in the `actions` slot of `RichTooltip`. -}
actionsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSkeleton =
    actions_core


{-| Place a `Shape` in the `actions` slot of `RichTooltip`. -}
actionsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsShape =
    actions_core


{-| Place a `SegmentedButton` in the `actions` slot of `RichTooltip`. -}
actionsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSegmentedButton =
    actions_core


{-| Place a `ButtonSegment` in the `actions` slot of `RichTooltip`. -}
actionsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonSegment =
    actions_core


{-| Place a `SearchView` in the `actions` slot of `RichTooltip`. -}
actionsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchView =
    actions_core


{-| Place a `SearchBar` in the `actions` slot of `RichTooltip`. -}
actionsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchBar =
    actions_core


{-| Place a `RadioGroup` in the `actions` slot of `RichTooltip`. -}
actionsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadioGroup =
    actions_core


{-| Place a `Radio` in the `actions` slot of `RichTooltip`. -}
actionsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadio =
    actions_core


{-| Place a `ProgressElementIndicatorBase` in the `actions` slot of `RichTooltip`. -}
actionsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsProgressElementIndicatorBase =
    actions_core


{-| Place a `Paginator` in the `actions` slot of `RichTooltip`. -}
actionsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPaginator =
    actions_core


{-| Place a `Select` in the `actions` slot of `RichTooltip`. -}
actionsSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelect =
    actions_core


{-| Place a `NavRailToggle` in the `actions` slot of `RichTooltip`. -}
actionsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRailToggle =
    actions_core


{-| Place a `NavRail` in the `actions` slot of `RichTooltip`. -}
actionsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRail =
    actions_core


{-| Place a `NavMenuItemGroup` in the `actions` slot of `RichTooltip`. -}
actionsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItemGroup =
    actions_core


{-| Place a `NavMenu` in the `actions` slot of `RichTooltip`. -}
actionsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenu =
    actions_core


{-| Place a `NavMenuItem` in the `actions` slot of `RichTooltip`. -}
actionsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItem =
    actions_core


{-| Place a `NavBar` in the `actions` slot of `RichTooltip`. -}
actionsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavBar =
    actions_core


{-| Place a `NavItem` in the `actions` slot of `RichTooltip`. -}
actionsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavItem =
    actions_core


{-| Place a `MenuItemRadio` in the `actions` slot of `RichTooltip`. -}
actionsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemRadio =
    actions_core


{-| Place a `MenuItemGroup` in the `actions` slot of `RichTooltip`. -}
actionsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemGroup =
    actions_core


{-| Place a `MenuItemCheckbox` in the `actions` slot of `RichTooltip`. -}
actionsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemCheckbox =
    actions_core


{-| Place a `Menu` in the `actions` slot of `RichTooltip`. -}
actionsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenu =
    actions_core


{-| Place a `MenuItem` in the `actions` slot of `RichTooltip`. -}
actionsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItem =
    actions_core


{-| Place a `MenuTrigger` in the `actions` slot of `RichTooltip`. -}
actionsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuTrigger =
    actions_core


{-| Place a `MenuItemElementBase` in the `actions` slot of `RichTooltip`. -}
actionsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemElementBase =
    actions_core


{-| Place a `LoadingIndicator` in the `actions` slot of `RichTooltip`. -}
actionsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsLoadingIndicator =
    actions_core


{-| Place a `SelectionList` in the `actions` slot of `RichTooltip`. -}
actionsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelectionList =
    actions_core


{-| Place a `ListOption` in the `actions` slot of `RichTooltip`. -}
actionsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListOption =
    actions_core


{-| Place a `ActionList` in the `actions` slot of `RichTooltip`. -}
actionsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionList =
    actions_core


{-| Place a `ExpandableListItem` in the `actions` slot of `RichTooltip`. -}
actionsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpandableListItem =
    actions_core


{-| Place a `ListAction` in the `actions` slot of `RichTooltip`. -}
actionsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListAction =
    actions_core


{-| Place a `ListItemButton` in the `actions` slot of `RichTooltip`. -}
actionsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItemButton =
    actions_core


{-| Place a `List` in the `actions` slot of `RichTooltip`. -}
actionsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsList =
    actions_core


{-| Place a `ListItem` in the `actions` slot of `RichTooltip`. -}
actionsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItem =
    actions_core


{-| Place a `Icon` in the `actions` slot of `RichTooltip`. -}
actionsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIcon =
    actions_core


{-| Place a `Heading` in the `actions` slot of `RichTooltip`. -}
actionsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsHeading =
    actions_core


{-| Place a `FabMenuTrigger` in the `actions` slot of `RichTooltip`. -}
actionsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenuTrigger =
    actions_core


{-| Place a `FabMenu` in the `actions` slot of `RichTooltip`. -}
actionsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenu =
    actions_core


{-| Place a `Fab` in the `actions` slot of `RichTooltip`. -}
actionsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFab =
    actions_core


{-| Place a `Accordion` in the `actions` slot of `RichTooltip`. -}
actionsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAccordion =
    actions_core


{-| Place a `ExpansionPanel` in the `actions` slot of `RichTooltip`. -}
actionsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionPanel =
    actions_core


{-| Place a `ExpansionHeader` in the `actions` slot of `RichTooltip`. -}
actionsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionHeader =
    actions_core


{-| Place a `DrawerToggle` in the `actions` slot of `RichTooltip`. -}
actionsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerToggle =
    actions_core


{-| Place a `DrawerContainer` in the `actions` slot of `RichTooltip`. -}
actionsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerContainer =
    actions_core


{-| Place a `Divider` in the `actions` slot of `RichTooltip`. -}
actionsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDivider =
    actions_core


{-| Place a `DialogTrigger` in the `actions` slot of `RichTooltip`. -}
actionsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogTrigger =
    actions_core


{-| Place a `Dialog` in the `actions` slot of `RichTooltip`. -}
actionsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialog =
    actions_core


{-| Place a `DialogAction` in the `actions` slot of `RichTooltip`. -}
actionsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogAction =
    actions_core


{-| Place a `DatepickerToggle` in the `actions` slot of `RichTooltip`. -}
actionsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepickerToggle =
    actions_core


{-| Place a `Datepicker` in the `actions` slot of `RichTooltip`. -}
actionsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepicker =
    actions_core


{-| Place a `ContentPane` in the `actions` slot of `RichTooltip`. -}
actionsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsContentPane =
    actions_core


{-| Place a `SuggestionChip` in the `actions` slot of `RichTooltip`. -}
actionsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSuggestionChip =
    actions_core


{-| Place a `InputChipSet` in the `actions` slot of `RichTooltip`. -}
actionsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChipSet =
    actions_core


{-| Place a `InputChip` in the `actions` slot of `RichTooltip`. -}
actionsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChip =
    actions_core


{-| Place a `FilterChipSet` in the `actions` slot of `RichTooltip`. -}
actionsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChipSet =
    actions_core


{-| Place a `FilterChip` in the `actions` slot of `RichTooltip`. -}
actionsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChip =
    actions_core


{-| Place a `ChipSet` in the `actions` slot of `RichTooltip`. -}
actionsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChipSet =
    actions_core


{-| Place a `AssistChip` in the `actions` slot of `RichTooltip`. -}
actionsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAssistChip =
    actions_core


{-| Place a `Chip` in the `actions` slot of `RichTooltip`. -}
actionsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChip =
    actions_core


{-| Place a `Checkbox` in the `actions` slot of `RichTooltip`. -}
actionsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCheckbox =
    actions_core


{-| Place a `Card` in the `actions` slot of `RichTooltip`. -}
actionsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCard =
    actions_core


{-| Place a `Calendar` in the `actions` slot of `RichTooltip`. -}
actionsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCalendar =
    actions_core


{-| Place a `YearView` in the `actions` slot of `RichTooltip`. -}
actionsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsYearView =
    actions_core


{-| Place a `MultiYearView` in the `actions` slot of `RichTooltip`. -}
actionsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMultiYearView =
    actions_core


{-| Place a `MonthView` in the `actions` slot of `RichTooltip`. -}
actionsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMonthView =
    actions_core


{-| Place a `Tooltip` in the `actions` slot of `RichTooltip`. -}
actionsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltip =
    actions_core


{-| Place a `RichTooltip` in the `actions` slot of `RichTooltip`. -}
actionsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltip =
    actions_core


{-| Place a `TooltipElementBase` in the `actions` slot of `RichTooltip`. -}
actionsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltipElementBase =
    actions_core


{-| Place a `RichTooltipAction` in the `actions` slot of `RichTooltip`. -}
actionsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltipAction =
    actions_core


{-| Place a `ButtonGroup` in the `actions` slot of `RichTooltip`. -}
actionsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonGroup =
    actions_core


{-| Place a `IconButton` in the `actions` slot of `RichTooltip`. -}
actionsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIconButton =
    actions_core


{-| Place a `Button` in the `actions` slot of `RichTooltip`. -}
actionsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButton =
    actions_core


{-| Place a `Breadcrumb` in the `actions` slot of `RichTooltip`. -}
actionsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumb =
    actions_core


{-| Place a `BreadcrumbItem` in the `actions` slot of `RichTooltip`. -}
actionsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItem =
    actions_core


{-| Place a `BreadcrumbItemButton` in the `actions` slot of `RichTooltip`. -}
actionsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItemButton =
    actions_core


{-| Place a `BottomSheetTrigger` in the `actions` slot of `RichTooltip`. -}
actionsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetTrigger =
    actions_core


{-| Place a `BottomSheet` in the `actions` slot of `RichTooltip`. -}
actionsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheet =
    actions_core


{-| Place a `BottomSheetAction` in the `actions` slot of `RichTooltip`. -}
actionsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetAction =
    actions_core


{-| Place a `Badge` in the `actions` slot of `RichTooltip`. -}
actionsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBadge =
    actions_core


{-| Place a `Avatar` in the `actions` slot of `RichTooltip`. -}
actionsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAvatar =
    actions_core


{-| Place a `Autocomplete` in the `actions` slot of `RichTooltip`. -}
actionsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAutocomplete =
    actions_core


{-| Place a `FormField` in the `actions` slot of `RichTooltip`. -}
actionsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFormField =
    actions_core


{-| Place a `OptionPanel` in the `actions` slot of `RichTooltip`. -}
actionsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptionPanel =
    actions_core


{-| Place a `FloatingPanel` in the `actions` slot of `RichTooltip`. -}
actionsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFloatingPanel =
    actions_core


{-| Place a `Optgroup` in the `actions` slot of `RichTooltip`. -}
actionsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptgroup =
    actions_core


{-| Place a `Option` in the `actions` slot of `RichTooltip`. -}
actionsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOption =
    actions_core


{-| Place a `FocusTrap` in the `actions` slot of `RichTooltip`. -}
actionsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusTrap =
    actions_core


{-| Place a `AppBar` in the `actions` slot of `RichTooltip`. -}
actionsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAppBar =
    actions_core


{-| Place a `TextOverflow` in the `actions` slot of `RichTooltip`. -}
actionsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextOverflow =
    actions_core


{-| Place a `TextHighlight` in the `actions` slot of `RichTooltip`. -}
actionsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextHighlight =
    actions_core


{-| Place a `StateLayer` in the `actions` slot of `RichTooltip`. -}
actionsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStateLayer =
    actions_core


{-| Place a `Slide` in the `actions` slot of `RichTooltip`. -}
actionsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlide =
    actions_core


{-| Place a `ScrollContainer` in the `actions` slot of `RichTooltip`. -}
actionsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsScrollContainer =
    actions_core


{-| Place a `Ripple` in the `actions` slot of `RichTooltip`. -}
actionsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRipple =
    actions_core


{-| Place a `PseudoRadio` in the `actions` slot of `RichTooltip`. -}
actionsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoRadio =
    actions_core


{-| Place a `PseudoCheckbox` in the `actions` slot of `RichTooltip`. -}
actionsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoCheckbox =
    actions_core


{-| Place a `FocusRing` in the `actions` slot of `RichTooltip`. -}
actionsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusRing =
    actions_core


{-| Place a `Elevation` in the `actions` slot of `RichTooltip`. -}
actionsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsElevation =
    actions_core


{-| Place a `Collapsible` in the `actions` slot of `RichTooltip`. -}
actionsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCollapsible =
    actions_core


{-| Place a `ActionElementBase` in the `actions` slot of `RichTooltip`. -}
actionsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.RichTooltip.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionElementBase =
    actions_core