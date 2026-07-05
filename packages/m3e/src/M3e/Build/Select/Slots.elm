module M3e.Build.Select.Slots exposing
    ( arrowIcon, valueTree, valueTreeItem, valueToolbar, valueToc, valueTocItem
    , valueThemeIcon, valueTheme, valueTextareaAutosize, valueTabs, valueTabPanel, valueTab, valueSwitch
    , valueStepperReset, valueStepperPrevious, valueStep, valueStepPanel, valueStepper, valueSplitPane, valueSplitButton
    , valueSnackbar, valueSlider, valueSliderThumb, valueSlideGroup, valueSkeleton, valueShape, valueSegmentedButton
    , valueButtonSegment, valueSearchView, valueSearchBar, valueRadioGroup, valueRadio, valueProgressElementIndicatorBase, valuePaginator
    , valueSelect, valueNavRailToggle, valueNavRail, valueNavMenuItemGroup, valueNavMenu, valueNavMenuItem, valueNavBar
    , valueNavItem, valueMenuItemRadio, valueMenuItemGroup, valueMenuItemCheckbox, valueMenu, valueMenuItem, valueMenuTrigger
    , valueMenuItemElementBase, valueLoadingIndicator, valueSelectionList, valueListOption, valueActionList, valueExpandableListItem, valueListAction
    , valueListItemButton, valueList, valueListItem, valueIcon, valueHeading, valueFabMenuTrigger, valueFabMenu
    , valueFab, valueAccordion, valueExpansionPanel, valueExpansionHeader, valueDrawerToggle, valueDrawerContainer, valueDivider
    , valueDialogTrigger, valueDialog, valueDialogAction, valueDatepickerToggle, valueDatepicker, valueContentPane, valueSuggestionChip
    , valueInputChipSet, valueInputChip, valueFilterChipSet, valueFilterChip, valueChipSet, valueAssistChip, valueChip
    , valueCheckbox, valueCard, valueCalendar, valueYearView, valueMultiYearView, valueMonthView, valueTooltip
    , valueRichTooltip, valueTooltipElementBase, valueRichTooltipAction, valueButtonGroup, valueIconButton, valueButton, valueBreadcrumb
    , valueBreadcrumbItem, valueBreadcrumbItemButton, valueBottomSheetTrigger, valueBottomSheet, valueBottomSheetAction, valueBadge, valueAvatar
    , valueAutocomplete, valueFormField, valueOptionPanel, valueFloatingPanel, valueOptgroup, valueOption, valueFocusTrap
    , valueAppBar, valueTextOverflow, valueTextHighlight, valueStateLayer, valueSlide, valueScrollContainer, valueRipple
    , valuePseudoRadio, valuePseudoCheckbox, valueFocusRing, valueElevation, valueCollapsible, valueActionElementBase
    )

{-|
Slot setters for `M3e.Build.Select`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs arrowIcon, valueTree, valueTreeItem, valueToolbar, valueToc, valueTocItem
@docs valueThemeIcon, valueTheme, valueTextareaAutosize, valueTabs, valueTabPanel, valueTab
@docs valueSwitch, valueStepperReset, valueStepperPrevious, valueStep, valueStepPanel, valueStepper
@docs valueSplitPane, valueSplitButton, valueSnackbar, valueSlider, valueSliderThumb, valueSlideGroup
@docs valueSkeleton, valueShape, valueSegmentedButton, valueButtonSegment, valueSearchView, valueSearchBar
@docs valueRadioGroup, valueRadio, valueProgressElementIndicatorBase, valuePaginator, valueSelect, valueNavRailToggle
@docs valueNavRail, valueNavMenuItemGroup, valueNavMenu, valueNavMenuItem, valueNavBar, valueNavItem
@docs valueMenuItemRadio, valueMenuItemGroup, valueMenuItemCheckbox, valueMenu, valueMenuItem, valueMenuTrigger
@docs valueMenuItemElementBase, valueLoadingIndicator, valueSelectionList, valueListOption, valueActionList, valueExpandableListItem
@docs valueListAction, valueListItemButton, valueList, valueListItem, valueIcon, valueHeading
@docs valueFabMenuTrigger, valueFabMenu, valueFab, valueAccordion, valueExpansionPanel, valueExpansionHeader
@docs valueDrawerToggle, valueDrawerContainer, valueDivider, valueDialogTrigger, valueDialog, valueDialogAction
@docs valueDatepickerToggle, valueDatepicker, valueContentPane, valueSuggestionChip, valueInputChipSet, valueInputChip
@docs valueFilterChipSet, valueFilterChip, valueChipSet, valueAssistChip, valueChip, valueCheckbox
@docs valueCard, valueCalendar, valueYearView, valueMultiYearView, valueMonthView, valueTooltip
@docs valueRichTooltip, valueTooltipElementBase, valueRichTooltipAction, valueButtonGroup, valueIconButton, valueButton
@docs valueBreadcrumb, valueBreadcrumbItem, valueBreadcrumbItemButton, valueBottomSheetTrigger, valueBottomSheet, valueBottomSheetAction
@docs valueBadge, valueAvatar, valueAutocomplete, valueFormField, valueOptionPanel, valueFloatingPanel
@docs valueOptgroup, valueOption, valueFocusTrap, valueAppBar, valueTextOverflow, valueTextHighlight
@docs valueStateLayer, valueSlide, valueScrollContainer, valueRipple, valuePseudoRadio, valuePseudoCheckbox
@docs valueFocusRing, valueElevation, valueCollapsible, valueActionElementBase
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


arrow_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Used
    } msg pk
arrow_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


value_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
value_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `arrow` slot of `Select`. -}
arrowIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Used
    } msg pk
arrowIcon =
    arrow_core


{-| Place a `Tree` in the `value` slot of `Select`. -}
valueTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTree =
    value_core


{-| Place a `TreeItem` in the `value` slot of `Select`. -}
valueTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTreeItem =
    value_core


{-| Place a `Toolbar` in the `value` slot of `Select`. -}
valueToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueToolbar =
    value_core


{-| Place a `Toc` in the `value` slot of `Select`. -}
valueToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueToc =
    value_core


{-| Place a `TocItem` in the `value` slot of `Select`. -}
valueTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTocItem =
    value_core


{-| Place a `ThemeIcon` in the `value` slot of `Select`. -}
valueThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueThemeIcon =
    value_core


{-| Place a `Theme` in the `value` slot of `Select`. -}
valueTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTheme =
    value_core


{-| Place a `TextareaAutosize` in the `value` slot of `Select`. -}
valueTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTextareaAutosize =
    value_core


{-| Place a `Tabs` in the `value` slot of `Select`. -}
valueTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTabs =
    value_core


{-| Place a `TabPanel` in the `value` slot of `Select`. -}
valueTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTabPanel =
    value_core


{-| Place a `Tab` in the `value` slot of `Select`. -}
valueTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTab =
    value_core


{-| Place a `Switch` in the `value` slot of `Select`. -}
valueSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSwitch =
    value_core


{-| Place a `StepperReset` in the `value` slot of `Select`. -}
valueStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStepperReset =
    value_core


{-| Place a `StepperPrevious` in the `value` slot of `Select`. -}
valueStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStepperPrevious =
    value_core


{-| Place a `Step` in the `value` slot of `Select`. -}
valueStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStep =
    value_core


{-| Place a `StepPanel` in the `value` slot of `Select`. -}
valueStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStepPanel =
    value_core


{-| Place a `Stepper` in the `value` slot of `Select`. -}
valueStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStepper =
    value_core


{-| Place a `SplitPane` in the `value` slot of `Select`. -}
valueSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSplitPane =
    value_core


{-| Place a `SplitButton` in the `value` slot of `Select`. -}
valueSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSplitButton =
    value_core


{-| Place a `Snackbar` in the `value` slot of `Select`. -}
valueSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSnackbar =
    value_core


{-| Place a `Slider` in the `value` slot of `Select`. -}
valueSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSlider =
    value_core


{-| Place a `SliderThumb` in the `value` slot of `Select`. -}
valueSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSliderThumb =
    value_core


{-| Place a `SlideGroup` in the `value` slot of `Select`. -}
valueSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSlideGroup =
    value_core


{-| Place a `Skeleton` in the `value` slot of `Select`. -}
valueSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSkeleton =
    value_core


{-| Place a `Shape` in the `value` slot of `Select`. -}
valueShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueShape =
    value_core


{-| Place a `SegmentedButton` in the `value` slot of `Select`. -}
valueSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSegmentedButton =
    value_core


{-| Place a `ButtonSegment` in the `value` slot of `Select`. -}
valueButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueButtonSegment =
    value_core


{-| Place a `SearchView` in the `value` slot of `Select`. -}
valueSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSearchView =
    value_core


{-| Place a `SearchBar` in the `value` slot of `Select`. -}
valueSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSearchBar =
    value_core


{-| Place a `RadioGroup` in the `value` slot of `Select`. -}
valueRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueRadioGroup =
    value_core


{-| Place a `Radio` in the `value` slot of `Select`. -}
valueRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueRadio =
    value_core


{-| Place a `ProgressElementIndicatorBase` in the `value` slot of `Select`. -}
valueProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueProgressElementIndicatorBase =
    value_core


{-| Place a `Paginator` in the `value` slot of `Select`. -}
valuePaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valuePaginator =
    value_core


{-| Place a `Select` in the `value` slot of `Select`. -}
valueSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSelect =
    value_core


{-| Place a `NavRailToggle` in the `value` slot of `Select`. -}
valueNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavRailToggle =
    value_core


{-| Place a `NavRail` in the `value` slot of `Select`. -}
valueNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavRail =
    value_core


{-| Place a `NavMenuItemGroup` in the `value` slot of `Select`. -}
valueNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavMenuItemGroup =
    value_core


{-| Place a `NavMenu` in the `value` slot of `Select`. -}
valueNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavMenu =
    value_core


{-| Place a `NavMenuItem` in the `value` slot of `Select`. -}
valueNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavMenuItem =
    value_core


{-| Place a `NavBar` in the `value` slot of `Select`. -}
valueNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavBar =
    value_core


{-| Place a `NavItem` in the `value` slot of `Select`. -}
valueNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueNavItem =
    value_core


{-| Place a `MenuItemRadio` in the `value` slot of `Select`. -}
valueMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuItemRadio =
    value_core


{-| Place a `MenuItemGroup` in the `value` slot of `Select`. -}
valueMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuItemGroup =
    value_core


{-| Place a `MenuItemCheckbox` in the `value` slot of `Select`. -}
valueMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuItemCheckbox =
    value_core


{-| Place a `Menu` in the `value` slot of `Select`. -}
valueMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenu =
    value_core


{-| Place a `MenuItem` in the `value` slot of `Select`. -}
valueMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuItem =
    value_core


{-| Place a `MenuTrigger` in the `value` slot of `Select`. -}
valueMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuTrigger =
    value_core


{-| Place a `MenuItemElementBase` in the `value` slot of `Select`. -}
valueMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMenuItemElementBase =
    value_core


{-| Place a `LoadingIndicator` in the `value` slot of `Select`. -}
valueLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueLoadingIndicator =
    value_core


{-| Place a `SelectionList` in the `value` slot of `Select`. -}
valueSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSelectionList =
    value_core


{-| Place a `ListOption` in the `value` slot of `Select`. -}
valueListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueListOption =
    value_core


{-| Place a `ActionList` in the `value` slot of `Select`. -}
valueActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueActionList =
    value_core


{-| Place a `ExpandableListItem` in the `value` slot of `Select`. -}
valueExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueExpandableListItem =
    value_core


{-| Place a `ListAction` in the `value` slot of `Select`. -}
valueListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueListAction =
    value_core


{-| Place a `ListItemButton` in the `value` slot of `Select`. -}
valueListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueListItemButton =
    value_core


{-| Place a `List` in the `value` slot of `Select`. -}
valueList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueList =
    value_core


{-| Place a `ListItem` in the `value` slot of `Select`. -}
valueListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueListItem =
    value_core


{-| Place a `Icon` in the `value` slot of `Select`. -}
valueIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueIcon =
    value_core


{-| Place a `Heading` in the `value` slot of `Select`. -}
valueHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueHeading =
    value_core


{-| Place a `FabMenuTrigger` in the `value` slot of `Select`. -}
valueFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFabMenuTrigger =
    value_core


{-| Place a `FabMenu` in the `value` slot of `Select`. -}
valueFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFabMenu =
    value_core


{-| Place a `Fab` in the `value` slot of `Select`. -}
valueFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFab =
    value_core


{-| Place a `Accordion` in the `value` slot of `Select`. -}
valueAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueAccordion =
    value_core


{-| Place a `ExpansionPanel` in the `value` slot of `Select`. -}
valueExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueExpansionPanel =
    value_core


{-| Place a `ExpansionHeader` in the `value` slot of `Select`. -}
valueExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueExpansionHeader =
    value_core


{-| Place a `DrawerToggle` in the `value` slot of `Select`. -}
valueDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDrawerToggle =
    value_core


{-| Place a `DrawerContainer` in the `value` slot of `Select`. -}
valueDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDrawerContainer =
    value_core


{-| Place a `Divider` in the `value` slot of `Select`. -}
valueDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDivider =
    value_core


{-| Place a `DialogTrigger` in the `value` slot of `Select`. -}
valueDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDialogTrigger =
    value_core


{-| Place a `Dialog` in the `value` slot of `Select`. -}
valueDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDialog =
    value_core


{-| Place a `DialogAction` in the `value` slot of `Select`. -}
valueDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDialogAction =
    value_core


{-| Place a `DatepickerToggle` in the `value` slot of `Select`. -}
valueDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDatepickerToggle =
    value_core


{-| Place a `Datepicker` in the `value` slot of `Select`. -}
valueDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueDatepicker =
    value_core


{-| Place a `ContentPane` in the `value` slot of `Select`. -}
valueContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueContentPane =
    value_core


{-| Place a `SuggestionChip` in the `value` slot of `Select`. -}
valueSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSuggestionChip =
    value_core


{-| Place a `InputChipSet` in the `value` slot of `Select`. -}
valueInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueInputChipSet =
    value_core


{-| Place a `InputChip` in the `value` slot of `Select`. -}
valueInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueInputChip =
    value_core


{-| Place a `FilterChipSet` in the `value` slot of `Select`. -}
valueFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFilterChipSet =
    value_core


{-| Place a `FilterChip` in the `value` slot of `Select`. -}
valueFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFilterChip =
    value_core


{-| Place a `ChipSet` in the `value` slot of `Select`. -}
valueChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueChipSet =
    value_core


{-| Place a `AssistChip` in the `value` slot of `Select`. -}
valueAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueAssistChip =
    value_core


{-| Place a `Chip` in the `value` slot of `Select`. -}
valueChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueChip =
    value_core


{-| Place a `Checkbox` in the `value` slot of `Select`. -}
valueCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueCheckbox =
    value_core


{-| Place a `Card` in the `value` slot of `Select`. -}
valueCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueCard =
    value_core


{-| Place a `Calendar` in the `value` slot of `Select`. -}
valueCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueCalendar =
    value_core


{-| Place a `YearView` in the `value` slot of `Select`. -}
valueYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueYearView =
    value_core


{-| Place a `MultiYearView` in the `value` slot of `Select`. -}
valueMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMultiYearView =
    value_core


{-| Place a `MonthView` in the `value` slot of `Select`. -}
valueMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueMonthView =
    value_core


{-| Place a `Tooltip` in the `value` slot of `Select`. -}
valueTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTooltip =
    value_core


{-| Place a `RichTooltip` in the `value` slot of `Select`. -}
valueRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueRichTooltip =
    value_core


{-| Place a `TooltipElementBase` in the `value` slot of `Select`. -}
valueTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTooltipElementBase =
    value_core


{-| Place a `RichTooltipAction` in the `value` slot of `Select`. -}
valueRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueRichTooltipAction =
    value_core


{-| Place a `ButtonGroup` in the `value` slot of `Select`. -}
valueButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueButtonGroup =
    value_core


{-| Place a `IconButton` in the `value` slot of `Select`. -}
valueIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueIconButton =
    value_core


{-| Place a `Button` in the `value` slot of `Select`. -}
valueButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueButton =
    value_core


{-| Place a `Breadcrumb` in the `value` slot of `Select`. -}
valueBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBreadcrumb =
    value_core


{-| Place a `BreadcrumbItem` in the `value` slot of `Select`. -}
valueBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBreadcrumbItem =
    value_core


{-| Place a `BreadcrumbItemButton` in the `value` slot of `Select`. -}
valueBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBreadcrumbItemButton =
    value_core


{-| Place a `BottomSheetTrigger` in the `value` slot of `Select`. -}
valueBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBottomSheetTrigger =
    value_core


{-| Place a `BottomSheet` in the `value` slot of `Select`. -}
valueBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBottomSheet =
    value_core


{-| Place a `BottomSheetAction` in the `value` slot of `Select`. -}
valueBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBottomSheetAction =
    value_core


{-| Place a `Badge` in the `value` slot of `Select`. -}
valueBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueBadge =
    value_core


{-| Place a `Avatar` in the `value` slot of `Select`. -}
valueAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueAvatar =
    value_core


{-| Place a `Autocomplete` in the `value` slot of `Select`. -}
valueAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueAutocomplete =
    value_core


{-| Place a `FormField` in the `value` slot of `Select`. -}
valueFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFormField =
    value_core


{-| Place a `OptionPanel` in the `value` slot of `Select`. -}
valueOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueOptionPanel =
    value_core


{-| Place a `FloatingPanel` in the `value` slot of `Select`. -}
valueFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFloatingPanel =
    value_core


{-| Place a `Optgroup` in the `value` slot of `Select`. -}
valueOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueOptgroup =
    value_core


{-| Place a `Option` in the `value` slot of `Select`. -}
valueOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueOption =
    value_core


{-| Place a `FocusTrap` in the `value` slot of `Select`. -}
valueFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFocusTrap =
    value_core


{-| Place a `AppBar` in the `value` slot of `Select`. -}
valueAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueAppBar =
    value_core


{-| Place a `TextOverflow` in the `value` slot of `Select`. -}
valueTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTextOverflow =
    value_core


{-| Place a `TextHighlight` in the `value` slot of `Select`. -}
valueTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueTextHighlight =
    value_core


{-| Place a `StateLayer` in the `value` slot of `Select`. -}
valueStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueStateLayer =
    value_core


{-| Place a `Slide` in the `value` slot of `Select`. -}
valueSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueSlide =
    value_core


{-| Place a `ScrollContainer` in the `value` slot of `Select`. -}
valueScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueScrollContainer =
    value_core


{-| Place a `Ripple` in the `value` slot of `Select`. -}
valueRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueRipple =
    value_core


{-| Place a `PseudoRadio` in the `value` slot of `Select`. -}
valuePseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valuePseudoRadio =
    value_core


{-| Place a `PseudoCheckbox` in the `value` slot of `Select`. -}
valuePseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valuePseudoCheckbox =
    value_core


{-| Place a `FocusRing` in the `value` slot of `Select`. -}
valueFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueFocusRing =
    value_core


{-| Place a `Elevation` in the `value` slot of `Select`. -}
valueElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueElevation =
    value_core


{-| Place a `Collapsible` in the `value` slot of `Select`. -}
valueCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueCollapsible =
    value_core


{-| Place a `ActionElementBase` in the `value` slot of `Select`. -}
valueActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
valueActionElementBase =
    value_core