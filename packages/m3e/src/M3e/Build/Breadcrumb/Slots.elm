module M3e.Build.Breadcrumb.Slots exposing
    ( separatorTree, separatorTreeItem, separatorToolbar, separatorToc, separatorTocItem, separatorThemeIcon
    , separatorTheme, separatorTextareaAutosize, separatorTabs, separatorTabPanel, separatorTab, separatorSwitch, separatorStepperReset
    , separatorStepperPrevious, separatorStep, separatorStepPanel, separatorStepper, separatorSplitPane, separatorSplitButton, separatorSnackbar
    , separatorSlider, separatorSliderThumb, separatorSlideGroup, separatorSkeleton, separatorShape, separatorSegmentedButton, separatorButtonSegment
    , separatorSearchView, separatorSearchBar, separatorRadioGroup, separatorRadio, separatorProgressElementIndicatorBase, separatorPaginator, separatorSelect
    , separatorNavRailToggle, separatorNavRail, separatorNavMenuItemGroup, separatorNavMenu, separatorNavMenuItem, separatorNavBar, separatorNavItem
    , separatorMenuItemRadio, separatorMenuItemGroup, separatorMenuItemCheckbox, separatorMenu, separatorMenuItem, separatorMenuTrigger, separatorMenuItemElementBase
    , separatorLoadingIndicator, separatorSelectionList, separatorListOption, separatorActionList, separatorExpandableListItem, separatorListAction, separatorListItemButton
    , separatorList, separatorListItem, separatorIcon, separatorHeading, separatorFabMenuTrigger, separatorFabMenu, separatorFab
    , separatorAccordion, separatorExpansionPanel, separatorExpansionHeader, separatorDrawerToggle, separatorDrawerContainer, separatorDivider, separatorDialogTrigger
    , separatorDialog, separatorDialogAction, separatorDatepickerToggle, separatorDatepicker, separatorContentPane, separatorSuggestionChip, separatorInputChipSet
    , separatorInputChip, separatorFilterChipSet, separatorFilterChip, separatorChipSet, separatorAssistChip, separatorChip, separatorCheckbox
    , separatorCard, separatorCalendar, separatorYearView, separatorMultiYearView, separatorMonthView, separatorTooltip, separatorRichTooltip
    , separatorTooltipElementBase, separatorRichTooltipAction, separatorButtonGroup, separatorIconButton, separatorButton, separatorBreadcrumb, separatorBreadcrumbItem
    , separatorBreadcrumbItemButton, separatorBottomSheetTrigger, separatorBottomSheet, separatorBottomSheetAction, separatorBadge, separatorAvatar, separatorAutocomplete
    , separatorFormField, separatorOptionPanel, separatorFloatingPanel, separatorOptgroup, separatorOption, separatorFocusTrap, separatorAppBar
    , separatorTextOverflow, separatorTextHighlight, separatorStateLayer, separatorSlide, separatorScrollContainer, separatorRipple, separatorPseudoRadio
    , separatorPseudoCheckbox, separatorFocusRing, separatorElevation, separatorCollapsible, separatorActionElementBase, breadcrumbItem
    )

{-|
Slot setters for `M3e.Build.Breadcrumb`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs separatorTree, separatorTreeItem, separatorToolbar, separatorToc, separatorTocItem, separatorThemeIcon
@docs separatorTheme, separatorTextareaAutosize, separatorTabs, separatorTabPanel, separatorTab, separatorSwitch
@docs separatorStepperReset, separatorStepperPrevious, separatorStep, separatorStepPanel, separatorStepper, separatorSplitPane
@docs separatorSplitButton, separatorSnackbar, separatorSlider, separatorSliderThumb, separatorSlideGroup, separatorSkeleton
@docs separatorShape, separatorSegmentedButton, separatorButtonSegment, separatorSearchView, separatorSearchBar, separatorRadioGroup
@docs separatorRadio, separatorProgressElementIndicatorBase, separatorPaginator, separatorSelect, separatorNavRailToggle, separatorNavRail
@docs separatorNavMenuItemGroup, separatorNavMenu, separatorNavMenuItem, separatorNavBar, separatorNavItem, separatorMenuItemRadio
@docs separatorMenuItemGroup, separatorMenuItemCheckbox, separatorMenu, separatorMenuItem, separatorMenuTrigger, separatorMenuItemElementBase
@docs separatorLoadingIndicator, separatorSelectionList, separatorListOption, separatorActionList, separatorExpandableListItem, separatorListAction
@docs separatorListItemButton, separatorList, separatorListItem, separatorIcon, separatorHeading, separatorFabMenuTrigger
@docs separatorFabMenu, separatorFab, separatorAccordion, separatorExpansionPanel, separatorExpansionHeader, separatorDrawerToggle
@docs separatorDrawerContainer, separatorDivider, separatorDialogTrigger, separatorDialog, separatorDialogAction, separatorDatepickerToggle
@docs separatorDatepicker, separatorContentPane, separatorSuggestionChip, separatorInputChipSet, separatorInputChip, separatorFilterChipSet
@docs separatorFilterChip, separatorChipSet, separatorAssistChip, separatorChip, separatorCheckbox, separatorCard
@docs separatorCalendar, separatorYearView, separatorMultiYearView, separatorMonthView, separatorTooltip, separatorRichTooltip
@docs separatorTooltipElementBase, separatorRichTooltipAction, separatorButtonGroup, separatorIconButton, separatorButton, separatorBreadcrumb
@docs separatorBreadcrumbItem, separatorBreadcrumbItemButton, separatorBottomSheetTrigger, separatorBottomSheet, separatorBottomSheetAction, separatorBadge
@docs separatorAvatar, separatorAutocomplete, separatorFormField, separatorOptionPanel, separatorFloatingPanel, separatorOptgroup
@docs separatorOption, separatorFocusTrap, separatorAppBar, separatorTextOverflow, separatorTextHighlight, separatorStateLayer
@docs separatorSlide, separatorScrollContainer, separatorRipple, separatorPseudoRadio, separatorPseudoCheckbox, separatorFocusRing
@docs separatorElevation, separatorCollapsible, separatorActionElementBase, breadcrumbItem
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


separator_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separator_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Breadcrumb.Builder pa { ps | default : filled } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | default : M3e.Build.Internal.Filled
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `separator` slot of `Breadcrumb`. -}
separatorTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTree =
    separator_core


{-| Place a `TreeItem` in the `separator` slot of `Breadcrumb`. -}
separatorTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTreeItem =
    separator_core


{-| Place a `Toolbar` in the `separator` slot of `Breadcrumb`. -}
separatorToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorToolbar =
    separator_core


{-| Place a `Toc` in the `separator` slot of `Breadcrumb`. -}
separatorToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorToc =
    separator_core


{-| Place a `TocItem` in the `separator` slot of `Breadcrumb`. -}
separatorTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTocItem =
    separator_core


{-| Place a `ThemeIcon` in the `separator` slot of `Breadcrumb`. -}
separatorThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorThemeIcon =
    separator_core


{-| Place a `Theme` in the `separator` slot of `Breadcrumb`. -}
separatorTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTheme =
    separator_core


{-| Place a `TextareaAutosize` in the `separator` slot of `Breadcrumb`. -}
separatorTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTextareaAutosize =
    separator_core


{-| Place a `Tabs` in the `separator` slot of `Breadcrumb`. -}
separatorTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTabs =
    separator_core


{-| Place a `TabPanel` in the `separator` slot of `Breadcrumb`. -}
separatorTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTabPanel =
    separator_core


{-| Place a `Tab` in the `separator` slot of `Breadcrumb`. -}
separatorTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTab =
    separator_core


{-| Place a `Switch` in the `separator` slot of `Breadcrumb`. -}
separatorSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSwitch =
    separator_core


{-| Place a `StepperReset` in the `separator` slot of `Breadcrumb`. -}
separatorStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStepperReset =
    separator_core


{-| Place a `StepperPrevious` in the `separator` slot of `Breadcrumb`. -}
separatorStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStepperPrevious =
    separator_core


{-| Place a `Step` in the `separator` slot of `Breadcrumb`. -}
separatorStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStep =
    separator_core


{-| Place a `StepPanel` in the `separator` slot of `Breadcrumb`. -}
separatorStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStepPanel =
    separator_core


{-| Place a `Stepper` in the `separator` slot of `Breadcrumb`. -}
separatorStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStepper =
    separator_core


{-| Place a `SplitPane` in the `separator` slot of `Breadcrumb`. -}
separatorSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSplitPane =
    separator_core


{-| Place a `SplitButton` in the `separator` slot of `Breadcrumb`. -}
separatorSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSplitButton =
    separator_core


{-| Place a `Snackbar` in the `separator` slot of `Breadcrumb`. -}
separatorSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSnackbar =
    separator_core


{-| Place a `Slider` in the `separator` slot of `Breadcrumb`. -}
separatorSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSlider =
    separator_core


{-| Place a `SliderThumb` in the `separator` slot of `Breadcrumb`. -}
separatorSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSliderThumb =
    separator_core


{-| Place a `SlideGroup` in the `separator` slot of `Breadcrumb`. -}
separatorSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSlideGroup =
    separator_core


{-| Place a `Skeleton` in the `separator` slot of `Breadcrumb`. -}
separatorSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSkeleton =
    separator_core


{-| Place a `Shape` in the `separator` slot of `Breadcrumb`. -}
separatorShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorShape =
    separator_core


{-| Place a `SegmentedButton` in the `separator` slot of `Breadcrumb`. -}
separatorSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSegmentedButton =
    separator_core


{-| Place a `ButtonSegment` in the `separator` slot of `Breadcrumb`. -}
separatorButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorButtonSegment =
    separator_core


{-| Place a `SearchView` in the `separator` slot of `Breadcrumb`. -}
separatorSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSearchView =
    separator_core


{-| Place a `SearchBar` in the `separator` slot of `Breadcrumb`. -}
separatorSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSearchBar =
    separator_core


{-| Place a `RadioGroup` in the `separator` slot of `Breadcrumb`. -}
separatorRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorRadioGroup =
    separator_core


{-| Place a `Radio` in the `separator` slot of `Breadcrumb`. -}
separatorRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorRadio =
    separator_core


{-| Place a `ProgressElementIndicatorBase` in the `separator` slot of `Breadcrumb`. -}
separatorProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorProgressElementIndicatorBase =
    separator_core


{-| Place a `Paginator` in the `separator` slot of `Breadcrumb`. -}
separatorPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorPaginator =
    separator_core


{-| Place a `Select` in the `separator` slot of `Breadcrumb`. -}
separatorSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSelect =
    separator_core


{-| Place a `NavRailToggle` in the `separator` slot of `Breadcrumb`. -}
separatorNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavRailToggle =
    separator_core


{-| Place a `NavRail` in the `separator` slot of `Breadcrumb`. -}
separatorNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavRail =
    separator_core


{-| Place a `NavMenuItemGroup` in the `separator` slot of `Breadcrumb`. -}
separatorNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavMenuItemGroup =
    separator_core


{-| Place a `NavMenu` in the `separator` slot of `Breadcrumb`. -}
separatorNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavMenu =
    separator_core


{-| Place a `NavMenuItem` in the `separator` slot of `Breadcrumb`. -}
separatorNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavMenuItem =
    separator_core


{-| Place a `NavBar` in the `separator` slot of `Breadcrumb`. -}
separatorNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavBar =
    separator_core


{-| Place a `NavItem` in the `separator` slot of `Breadcrumb`. -}
separatorNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorNavItem =
    separator_core


{-| Place a `MenuItemRadio` in the `separator` slot of `Breadcrumb`. -}
separatorMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuItemRadio =
    separator_core


{-| Place a `MenuItemGroup` in the `separator` slot of `Breadcrumb`. -}
separatorMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuItemGroup =
    separator_core


{-| Place a `MenuItemCheckbox` in the `separator` slot of `Breadcrumb`. -}
separatorMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuItemCheckbox =
    separator_core


{-| Place a `Menu` in the `separator` slot of `Breadcrumb`. -}
separatorMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenu =
    separator_core


{-| Place a `MenuItem` in the `separator` slot of `Breadcrumb`. -}
separatorMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuItem =
    separator_core


{-| Place a `MenuTrigger` in the `separator` slot of `Breadcrumb`. -}
separatorMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuTrigger =
    separator_core


{-| Place a `MenuItemElementBase` in the `separator` slot of `Breadcrumb`. -}
separatorMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMenuItemElementBase =
    separator_core


{-| Place a `LoadingIndicator` in the `separator` slot of `Breadcrumb`. -}
separatorLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorLoadingIndicator =
    separator_core


{-| Place a `SelectionList` in the `separator` slot of `Breadcrumb`. -}
separatorSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSelectionList =
    separator_core


{-| Place a `ListOption` in the `separator` slot of `Breadcrumb`. -}
separatorListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorListOption =
    separator_core


{-| Place a `ActionList` in the `separator` slot of `Breadcrumb`. -}
separatorActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorActionList =
    separator_core


{-| Place a `ExpandableListItem` in the `separator` slot of `Breadcrumb`. -}
separatorExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorExpandableListItem =
    separator_core


{-| Place a `ListAction` in the `separator` slot of `Breadcrumb`. -}
separatorListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorListAction =
    separator_core


{-| Place a `ListItemButton` in the `separator` slot of `Breadcrumb`. -}
separatorListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorListItemButton =
    separator_core


{-| Place a `List` in the `separator` slot of `Breadcrumb`. -}
separatorList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorList =
    separator_core


{-| Place a `ListItem` in the `separator` slot of `Breadcrumb`. -}
separatorListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorListItem =
    separator_core


{-| Place a `Icon` in the `separator` slot of `Breadcrumb`. -}
separatorIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorIcon =
    separator_core


{-| Place a `Heading` in the `separator` slot of `Breadcrumb`. -}
separatorHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorHeading =
    separator_core


{-| Place a `FabMenuTrigger` in the `separator` slot of `Breadcrumb`. -}
separatorFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFabMenuTrigger =
    separator_core


{-| Place a `FabMenu` in the `separator` slot of `Breadcrumb`. -}
separatorFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFabMenu =
    separator_core


{-| Place a `Fab` in the `separator` slot of `Breadcrumb`. -}
separatorFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFab =
    separator_core


{-| Place a `Accordion` in the `separator` slot of `Breadcrumb`. -}
separatorAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorAccordion =
    separator_core


{-| Place a `ExpansionPanel` in the `separator` slot of `Breadcrumb`. -}
separatorExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorExpansionPanel =
    separator_core


{-| Place a `ExpansionHeader` in the `separator` slot of `Breadcrumb`. -}
separatorExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorExpansionHeader =
    separator_core


{-| Place a `DrawerToggle` in the `separator` slot of `Breadcrumb`. -}
separatorDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDrawerToggle =
    separator_core


{-| Place a `DrawerContainer` in the `separator` slot of `Breadcrumb`. -}
separatorDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDrawerContainer =
    separator_core


{-| Place a `Divider` in the `separator` slot of `Breadcrumb`. -}
separatorDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDivider =
    separator_core


{-| Place a `DialogTrigger` in the `separator` slot of `Breadcrumb`. -}
separatorDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDialogTrigger =
    separator_core


{-| Place a `Dialog` in the `separator` slot of `Breadcrumb`. -}
separatorDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDialog =
    separator_core


{-| Place a `DialogAction` in the `separator` slot of `Breadcrumb`. -}
separatorDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDialogAction =
    separator_core


{-| Place a `DatepickerToggle` in the `separator` slot of `Breadcrumb`. -}
separatorDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDatepickerToggle =
    separator_core


{-| Place a `Datepicker` in the `separator` slot of `Breadcrumb`. -}
separatorDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorDatepicker =
    separator_core


{-| Place a `ContentPane` in the `separator` slot of `Breadcrumb`. -}
separatorContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorContentPane =
    separator_core


{-| Place a `SuggestionChip` in the `separator` slot of `Breadcrumb`. -}
separatorSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSuggestionChip =
    separator_core


{-| Place a `InputChipSet` in the `separator` slot of `Breadcrumb`. -}
separatorInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorInputChipSet =
    separator_core


{-| Place a `InputChip` in the `separator` slot of `Breadcrumb`. -}
separatorInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorInputChip =
    separator_core


{-| Place a `FilterChipSet` in the `separator` slot of `Breadcrumb`. -}
separatorFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFilterChipSet =
    separator_core


{-| Place a `FilterChip` in the `separator` slot of `Breadcrumb`. -}
separatorFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFilterChip =
    separator_core


{-| Place a `ChipSet` in the `separator` slot of `Breadcrumb`. -}
separatorChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorChipSet =
    separator_core


{-| Place a `AssistChip` in the `separator` slot of `Breadcrumb`. -}
separatorAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorAssistChip =
    separator_core


{-| Place a `Chip` in the `separator` slot of `Breadcrumb`. -}
separatorChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorChip =
    separator_core


{-| Place a `Checkbox` in the `separator` slot of `Breadcrumb`. -}
separatorCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorCheckbox =
    separator_core


{-| Place a `Card` in the `separator` slot of `Breadcrumb`. -}
separatorCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorCard =
    separator_core


{-| Place a `Calendar` in the `separator` slot of `Breadcrumb`. -}
separatorCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorCalendar =
    separator_core


{-| Place a `YearView` in the `separator` slot of `Breadcrumb`. -}
separatorYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorYearView =
    separator_core


{-| Place a `MultiYearView` in the `separator` slot of `Breadcrumb`. -}
separatorMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMultiYearView =
    separator_core


{-| Place a `MonthView` in the `separator` slot of `Breadcrumb`. -}
separatorMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorMonthView =
    separator_core


{-| Place a `Tooltip` in the `separator` slot of `Breadcrumb`. -}
separatorTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTooltip =
    separator_core


{-| Place a `RichTooltip` in the `separator` slot of `Breadcrumb`. -}
separatorRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorRichTooltip =
    separator_core


{-| Place a `TooltipElementBase` in the `separator` slot of `Breadcrumb`. -}
separatorTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTooltipElementBase =
    separator_core


{-| Place a `RichTooltipAction` in the `separator` slot of `Breadcrumb`. -}
separatorRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorRichTooltipAction =
    separator_core


{-| Place a `ButtonGroup` in the `separator` slot of `Breadcrumb`. -}
separatorButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorButtonGroup =
    separator_core


{-| Place a `IconButton` in the `separator` slot of `Breadcrumb`. -}
separatorIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorIconButton =
    separator_core


{-| Place a `Button` in the `separator` slot of `Breadcrumb`. -}
separatorButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorButton =
    separator_core


{-| Place a `Breadcrumb` in the `separator` slot of `Breadcrumb`. -}
separatorBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBreadcrumb =
    separator_core


{-| Place a `BreadcrumbItem` in the `separator` slot of `Breadcrumb`. -}
separatorBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBreadcrumbItem =
    separator_core


{-| Place a `BreadcrumbItemButton` in the `separator` slot of `Breadcrumb`. -}
separatorBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBreadcrumbItemButton =
    separator_core


{-| Place a `BottomSheetTrigger` in the `separator` slot of `Breadcrumb`. -}
separatorBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBottomSheetTrigger =
    separator_core


{-| Place a `BottomSheet` in the `separator` slot of `Breadcrumb`. -}
separatorBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBottomSheet =
    separator_core


{-| Place a `BottomSheetAction` in the `separator` slot of `Breadcrumb`. -}
separatorBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBottomSheetAction =
    separator_core


{-| Place a `Badge` in the `separator` slot of `Breadcrumb`. -}
separatorBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorBadge =
    separator_core


{-| Place a `Avatar` in the `separator` slot of `Breadcrumb`. -}
separatorAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorAvatar =
    separator_core


{-| Place a `Autocomplete` in the `separator` slot of `Breadcrumb`. -}
separatorAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorAutocomplete =
    separator_core


{-| Place a `FormField` in the `separator` slot of `Breadcrumb`. -}
separatorFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFormField =
    separator_core


{-| Place a `OptionPanel` in the `separator` slot of `Breadcrumb`. -}
separatorOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorOptionPanel =
    separator_core


{-| Place a `FloatingPanel` in the `separator` slot of `Breadcrumb`. -}
separatorFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFloatingPanel =
    separator_core


{-| Place a `Optgroup` in the `separator` slot of `Breadcrumb`. -}
separatorOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorOptgroup =
    separator_core


{-| Place a `Option` in the `separator` slot of `Breadcrumb`. -}
separatorOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorOption =
    separator_core


{-| Place a `FocusTrap` in the `separator` slot of `Breadcrumb`. -}
separatorFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFocusTrap =
    separator_core


{-| Place a `AppBar` in the `separator` slot of `Breadcrumb`. -}
separatorAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorAppBar =
    separator_core


{-| Place a `TextOverflow` in the `separator` slot of `Breadcrumb`. -}
separatorTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTextOverflow =
    separator_core


{-| Place a `TextHighlight` in the `separator` slot of `Breadcrumb`. -}
separatorTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorTextHighlight =
    separator_core


{-| Place a `StateLayer` in the `separator` slot of `Breadcrumb`. -}
separatorStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorStateLayer =
    separator_core


{-| Place a `Slide` in the `separator` slot of `Breadcrumb`. -}
separatorSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorSlide =
    separator_core


{-| Place a `ScrollContainer` in the `separator` slot of `Breadcrumb`. -}
separatorScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorScrollContainer =
    separator_core


{-| Place a `Ripple` in the `separator` slot of `Breadcrumb`. -}
separatorRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorRipple =
    separator_core


{-| Place a `PseudoRadio` in the `separator` slot of `Breadcrumb`. -}
separatorPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorPseudoRadio =
    separator_core


{-| Place a `PseudoCheckbox` in the `separator` slot of `Breadcrumb`. -}
separatorPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorPseudoCheckbox =
    separator_core


{-| Place a `FocusRing` in the `separator` slot of `Breadcrumb`. -}
separatorFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorFocusRing =
    separator_core


{-| Place a `Elevation` in the `separator` slot of `Breadcrumb`. -}
separatorElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorElevation =
    separator_core


{-| Place a `Collapsible` in the `separator` slot of `Breadcrumb`. -}
separatorCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorCollapsible =
    separator_core


{-| Place a `ActionElementBase` in the `separator` slot of `Breadcrumb`. -}
separatorActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | separator : M3e.Build.Internal.Used
    } msg pk
separatorActionElementBase =
    separator_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `Breadcrumb`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps | default : filled } msg pk
    -> M3e.Build.Breadcrumb.Builder pa { ps
        | default : M3e.Build.Internal.Filled
    } msg pk
breadcrumbItem =
    default_core