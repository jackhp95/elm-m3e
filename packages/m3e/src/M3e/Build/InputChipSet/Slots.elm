module M3e.Build.InputChipSet.Slots exposing
    ( inputTree, inputTreeItem, inputToolbar, inputToc, inputTocItem, inputThemeIcon
    , inputTheme, inputTextareaAutosize, inputTabs, inputTabPanel, inputTab, inputSwitch, inputStepperReset
    , inputStepperPrevious, inputStep, inputStepPanel, inputStepper, inputSplitPane, inputSplitButton, inputSnackbar
    , inputSlider, inputSliderThumb, inputSlideGroup, inputSkeleton, inputShape, inputSegmentedButton, inputButtonSegment
    , inputSearchView, inputSearchBar, inputRadioGroup, inputRadio, inputProgressElementIndicatorBase, inputPaginator, inputSelect
    , inputNavRailToggle, inputNavRail, inputNavMenuItemGroup, inputNavMenu, inputNavMenuItem, inputNavBar, inputNavItem
    , inputMenuItemRadio, inputMenuItemGroup, inputMenuItemCheckbox, inputMenu, inputMenuItem, inputMenuTrigger, inputMenuItemElementBase
    , inputLoadingIndicator, inputSelectionList, inputListOption, inputActionList, inputExpandableListItem, inputListAction, inputListItemButton
    , inputList, inputListItem, inputIcon, inputHeading, inputFabMenuTrigger, inputFabMenu, inputFab
    , inputAccordion, inputExpansionPanel, inputExpansionHeader, inputDrawerToggle, inputDrawerContainer, inputDivider, inputDialogTrigger
    , inputDialog, inputDialogAction, inputDatepickerToggle, inputDatepicker, inputContentPane, inputSuggestionChip, inputInputChipSet
    , inputInputChip, inputFilterChipSet, inputFilterChip, inputChipSet, inputAssistChip, inputChip, inputCheckbox
    , inputCard, inputCalendar, inputYearView, inputMultiYearView, inputMonthView, inputTooltip, inputRichTooltip
    , inputTooltipElementBase, inputRichTooltipAction, inputButtonGroup, inputIconButton, inputButton, inputBreadcrumb, inputBreadcrumbItem
    , inputBreadcrumbItemButton, inputBottomSheetTrigger, inputBottomSheet, inputBottomSheetAction, inputBadge, inputAvatar, inputAutocomplete
    , inputFormField, inputOptionPanel, inputFloatingPanel, inputOptgroup, inputOption, inputFocusTrap, inputAppBar
    , inputTextOverflow, inputTextHighlight, inputStateLayer, inputSlide, inputScrollContainer, inputRipple, inputPseudoRadio
    , inputPseudoCheckbox, inputFocusRing, inputElevation, inputCollapsible, inputActionElementBase
    )

{-|
Slot setters for `M3e.Build.InputChipSet`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs inputTree, inputTreeItem, inputToolbar, inputToc, inputTocItem, inputThemeIcon
@docs inputTheme, inputTextareaAutosize, inputTabs, inputTabPanel, inputTab, inputSwitch
@docs inputStepperReset, inputStepperPrevious, inputStep, inputStepPanel, inputStepper, inputSplitPane
@docs inputSplitButton, inputSnackbar, inputSlider, inputSliderThumb, inputSlideGroup, inputSkeleton
@docs inputShape, inputSegmentedButton, inputButtonSegment, inputSearchView, inputSearchBar, inputRadioGroup
@docs inputRadio, inputProgressElementIndicatorBase, inputPaginator, inputSelect, inputNavRailToggle, inputNavRail
@docs inputNavMenuItemGroup, inputNavMenu, inputNavMenuItem, inputNavBar, inputNavItem, inputMenuItemRadio
@docs inputMenuItemGroup, inputMenuItemCheckbox, inputMenu, inputMenuItem, inputMenuTrigger, inputMenuItemElementBase
@docs inputLoadingIndicator, inputSelectionList, inputListOption, inputActionList, inputExpandableListItem, inputListAction
@docs inputListItemButton, inputList, inputListItem, inputIcon, inputHeading, inputFabMenuTrigger
@docs inputFabMenu, inputFab, inputAccordion, inputExpansionPanel, inputExpansionHeader, inputDrawerToggle
@docs inputDrawerContainer, inputDivider, inputDialogTrigger, inputDialog, inputDialogAction, inputDatepickerToggle
@docs inputDatepicker, inputContentPane, inputSuggestionChip, inputInputChipSet, inputInputChip, inputFilterChipSet
@docs inputFilterChip, inputChipSet, inputAssistChip, inputChip, inputCheckbox, inputCard
@docs inputCalendar, inputYearView, inputMultiYearView, inputMonthView, inputTooltip, inputRichTooltip
@docs inputTooltipElementBase, inputRichTooltipAction, inputButtonGroup, inputIconButton, inputButton, inputBreadcrumb
@docs inputBreadcrumbItem, inputBreadcrumbItemButton, inputBottomSheetTrigger, inputBottomSheet, inputBottomSheetAction, inputBadge
@docs inputAvatar, inputAutocomplete, inputFormField, inputOptionPanel, inputFloatingPanel, inputOptgroup
@docs inputOption, inputFocusTrap, inputAppBar, inputTextOverflow, inputTextHighlight, inputStateLayer
@docs inputSlide, inputScrollContainer, inputRipple, inputPseudoRadio, inputPseudoCheckbox, inputFocusRing
@docs inputElevation, inputCollapsible, inputActionElementBase
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


input_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
input_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `input` slot of `InputChipSet`. -}
inputTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTree =
    input_core


{-| Place a `TreeItem` in the `input` slot of `InputChipSet`. -}
inputTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTreeItem =
    input_core


{-| Place a `Toolbar` in the `input` slot of `InputChipSet`. -}
inputToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputToolbar =
    input_core


{-| Place a `Toc` in the `input` slot of `InputChipSet`. -}
inputToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputToc =
    input_core


{-| Place a `TocItem` in the `input` slot of `InputChipSet`. -}
inputTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTocItem =
    input_core


{-| Place a `ThemeIcon` in the `input` slot of `InputChipSet`. -}
inputThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputThemeIcon =
    input_core


{-| Place a `Theme` in the `input` slot of `InputChipSet`. -}
inputTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTheme =
    input_core


{-| Place a `TextareaAutosize` in the `input` slot of `InputChipSet`. -}
inputTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTextareaAutosize =
    input_core


{-| Place a `Tabs` in the `input` slot of `InputChipSet`. -}
inputTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTabs =
    input_core


{-| Place a `TabPanel` in the `input` slot of `InputChipSet`. -}
inputTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTabPanel =
    input_core


{-| Place a `Tab` in the `input` slot of `InputChipSet`. -}
inputTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTab =
    input_core


{-| Place a `Switch` in the `input` slot of `InputChipSet`. -}
inputSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSwitch =
    input_core


{-| Place a `StepperReset` in the `input` slot of `InputChipSet`. -}
inputStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStepperReset =
    input_core


{-| Place a `StepperPrevious` in the `input` slot of `InputChipSet`. -}
inputStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStepperPrevious =
    input_core


{-| Place a `Step` in the `input` slot of `InputChipSet`. -}
inputStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStep =
    input_core


{-| Place a `StepPanel` in the `input` slot of `InputChipSet`. -}
inputStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStepPanel =
    input_core


{-| Place a `Stepper` in the `input` slot of `InputChipSet`. -}
inputStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStepper =
    input_core


{-| Place a `SplitPane` in the `input` slot of `InputChipSet`. -}
inputSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSplitPane =
    input_core


{-| Place a `SplitButton` in the `input` slot of `InputChipSet`. -}
inputSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSplitButton =
    input_core


{-| Place a `Snackbar` in the `input` slot of `InputChipSet`. -}
inputSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSnackbar =
    input_core


{-| Place a `Slider` in the `input` slot of `InputChipSet`. -}
inputSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSlider =
    input_core


{-| Place a `SliderThumb` in the `input` slot of `InputChipSet`. -}
inputSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSliderThumb =
    input_core


{-| Place a `SlideGroup` in the `input` slot of `InputChipSet`. -}
inputSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSlideGroup =
    input_core


{-| Place a `Skeleton` in the `input` slot of `InputChipSet`. -}
inputSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSkeleton =
    input_core


{-| Place a `Shape` in the `input` slot of `InputChipSet`. -}
inputShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputShape =
    input_core


{-| Place a `SegmentedButton` in the `input` slot of `InputChipSet`. -}
inputSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSegmentedButton =
    input_core


{-| Place a `ButtonSegment` in the `input` slot of `InputChipSet`. -}
inputButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputButtonSegment =
    input_core


{-| Place a `SearchView` in the `input` slot of `InputChipSet`. -}
inputSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSearchView =
    input_core


{-| Place a `SearchBar` in the `input` slot of `InputChipSet`. -}
inputSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSearchBar =
    input_core


{-| Place a `RadioGroup` in the `input` slot of `InputChipSet`. -}
inputRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputRadioGroup =
    input_core


{-| Place a `Radio` in the `input` slot of `InputChipSet`. -}
inputRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputRadio =
    input_core


{-| Place a `ProgressElementIndicatorBase` in the `input` slot of `InputChipSet`. -}
inputProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputProgressElementIndicatorBase =
    input_core


{-| Place a `Paginator` in the `input` slot of `InputChipSet`. -}
inputPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputPaginator =
    input_core


{-| Place a `Select` in the `input` slot of `InputChipSet`. -}
inputSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSelect =
    input_core


{-| Place a `NavRailToggle` in the `input` slot of `InputChipSet`. -}
inputNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavRailToggle =
    input_core


{-| Place a `NavRail` in the `input` slot of `InputChipSet`. -}
inputNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavRail =
    input_core


{-| Place a `NavMenuItemGroup` in the `input` slot of `InputChipSet`. -}
inputNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavMenuItemGroup =
    input_core


{-| Place a `NavMenu` in the `input` slot of `InputChipSet`. -}
inputNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavMenu =
    input_core


{-| Place a `NavMenuItem` in the `input` slot of `InputChipSet`. -}
inputNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavMenuItem =
    input_core


{-| Place a `NavBar` in the `input` slot of `InputChipSet`. -}
inputNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavBar =
    input_core


{-| Place a `NavItem` in the `input` slot of `InputChipSet`. -}
inputNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputNavItem =
    input_core


{-| Place a `MenuItemRadio` in the `input` slot of `InputChipSet`. -}
inputMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuItemRadio =
    input_core


{-| Place a `MenuItemGroup` in the `input` slot of `InputChipSet`. -}
inputMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuItemGroup =
    input_core


{-| Place a `MenuItemCheckbox` in the `input` slot of `InputChipSet`. -}
inputMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuItemCheckbox =
    input_core


{-| Place a `Menu` in the `input` slot of `InputChipSet`. -}
inputMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenu =
    input_core


{-| Place a `MenuItem` in the `input` slot of `InputChipSet`. -}
inputMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuItem =
    input_core


{-| Place a `MenuTrigger` in the `input` slot of `InputChipSet`. -}
inputMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuTrigger =
    input_core


{-| Place a `MenuItemElementBase` in the `input` slot of `InputChipSet`. -}
inputMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMenuItemElementBase =
    input_core


{-| Place a `LoadingIndicator` in the `input` slot of `InputChipSet`. -}
inputLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputLoadingIndicator =
    input_core


{-| Place a `SelectionList` in the `input` slot of `InputChipSet`. -}
inputSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSelectionList =
    input_core


{-| Place a `ListOption` in the `input` slot of `InputChipSet`. -}
inputListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputListOption =
    input_core


{-| Place a `ActionList` in the `input` slot of `InputChipSet`. -}
inputActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputActionList =
    input_core


{-| Place a `ExpandableListItem` in the `input` slot of `InputChipSet`. -}
inputExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputExpandableListItem =
    input_core


{-| Place a `ListAction` in the `input` slot of `InputChipSet`. -}
inputListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputListAction =
    input_core


{-| Place a `ListItemButton` in the `input` slot of `InputChipSet`. -}
inputListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputListItemButton =
    input_core


{-| Place a `List` in the `input` slot of `InputChipSet`. -}
inputList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputList =
    input_core


{-| Place a `ListItem` in the `input` slot of `InputChipSet`. -}
inputListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputListItem =
    input_core


{-| Place a `Icon` in the `input` slot of `InputChipSet`. -}
inputIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputIcon =
    input_core


{-| Place a `Heading` in the `input` slot of `InputChipSet`. -}
inputHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputHeading =
    input_core


{-| Place a `FabMenuTrigger` in the `input` slot of `InputChipSet`. -}
inputFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFabMenuTrigger =
    input_core


{-| Place a `FabMenu` in the `input` slot of `InputChipSet`. -}
inputFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFabMenu =
    input_core


{-| Place a `Fab` in the `input` slot of `InputChipSet`. -}
inputFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFab =
    input_core


{-| Place a `Accordion` in the `input` slot of `InputChipSet`. -}
inputAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputAccordion =
    input_core


{-| Place a `ExpansionPanel` in the `input` slot of `InputChipSet`. -}
inputExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputExpansionPanel =
    input_core


{-| Place a `ExpansionHeader` in the `input` slot of `InputChipSet`. -}
inputExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputExpansionHeader =
    input_core


{-| Place a `DrawerToggle` in the `input` slot of `InputChipSet`. -}
inputDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDrawerToggle =
    input_core


{-| Place a `DrawerContainer` in the `input` slot of `InputChipSet`. -}
inputDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDrawerContainer =
    input_core


{-| Place a `Divider` in the `input` slot of `InputChipSet`. -}
inputDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDivider =
    input_core


{-| Place a `DialogTrigger` in the `input` slot of `InputChipSet`. -}
inputDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDialogTrigger =
    input_core


{-| Place a `Dialog` in the `input` slot of `InputChipSet`. -}
inputDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDialog =
    input_core


{-| Place a `DialogAction` in the `input` slot of `InputChipSet`. -}
inputDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDialogAction =
    input_core


{-| Place a `DatepickerToggle` in the `input` slot of `InputChipSet`. -}
inputDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDatepickerToggle =
    input_core


{-| Place a `Datepicker` in the `input` slot of `InputChipSet`. -}
inputDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputDatepicker =
    input_core


{-| Place a `ContentPane` in the `input` slot of `InputChipSet`. -}
inputContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputContentPane =
    input_core


{-| Place a `SuggestionChip` in the `input` slot of `InputChipSet`. -}
inputSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSuggestionChip =
    input_core


{-| Place a `InputChipSet` in the `input` slot of `InputChipSet`. -}
inputInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputInputChipSet =
    input_core


{-| Place a `InputChip` in the `input` slot of `InputChipSet`. -}
inputInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputInputChip =
    input_core


{-| Place a `FilterChipSet` in the `input` slot of `InputChipSet`. -}
inputFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFilterChipSet =
    input_core


{-| Place a `FilterChip` in the `input` slot of `InputChipSet`. -}
inputFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFilterChip =
    input_core


{-| Place a `ChipSet` in the `input` slot of `InputChipSet`. -}
inputChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    input_core


{-| Place a `AssistChip` in the `input` slot of `InputChipSet`. -}
inputAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputAssistChip =
    input_core


{-| Place a `Chip` in the `input` slot of `InputChipSet`. -}
inputChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputChip =
    input_core


{-| Place a `Checkbox` in the `input` slot of `InputChipSet`. -}
inputCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputCheckbox =
    input_core


{-| Place a `Card` in the `input` slot of `InputChipSet`. -}
inputCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputCard =
    input_core


{-| Place a `Calendar` in the `input` slot of `InputChipSet`. -}
inputCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputCalendar =
    input_core


{-| Place a `YearView` in the `input` slot of `InputChipSet`. -}
inputYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputYearView =
    input_core


{-| Place a `MultiYearView` in the `input` slot of `InputChipSet`. -}
inputMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMultiYearView =
    input_core


{-| Place a `MonthView` in the `input` slot of `InputChipSet`. -}
inputMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputMonthView =
    input_core


{-| Place a `Tooltip` in the `input` slot of `InputChipSet`. -}
inputTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTooltip =
    input_core


{-| Place a `RichTooltip` in the `input` slot of `InputChipSet`. -}
inputRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputRichTooltip =
    input_core


{-| Place a `TooltipElementBase` in the `input` slot of `InputChipSet`. -}
inputTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTooltipElementBase =
    input_core


{-| Place a `RichTooltipAction` in the `input` slot of `InputChipSet`. -}
inputRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputRichTooltipAction =
    input_core


{-| Place a `ButtonGroup` in the `input` slot of `InputChipSet`. -}
inputButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputButtonGroup =
    input_core


{-| Place a `IconButton` in the `input` slot of `InputChipSet`. -}
inputIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputIconButton =
    input_core


{-| Place a `Button` in the `input` slot of `InputChipSet`. -}
inputButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputButton =
    input_core


{-| Place a `Breadcrumb` in the `input` slot of `InputChipSet`. -}
inputBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBreadcrumb =
    input_core


{-| Place a `BreadcrumbItem` in the `input` slot of `InputChipSet`. -}
inputBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBreadcrumbItem =
    input_core


{-| Place a `BreadcrumbItemButton` in the `input` slot of `InputChipSet`. -}
inputBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBreadcrumbItemButton =
    input_core


{-| Place a `BottomSheetTrigger` in the `input` slot of `InputChipSet`. -}
inputBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBottomSheetTrigger =
    input_core


{-| Place a `BottomSheet` in the `input` slot of `InputChipSet`. -}
inputBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBottomSheet =
    input_core


{-| Place a `BottomSheetAction` in the `input` slot of `InputChipSet`. -}
inputBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBottomSheetAction =
    input_core


{-| Place a `Badge` in the `input` slot of `InputChipSet`. -}
inputBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputBadge =
    input_core


{-| Place a `Avatar` in the `input` slot of `InputChipSet`. -}
inputAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputAvatar =
    input_core


{-| Place a `Autocomplete` in the `input` slot of `InputChipSet`. -}
inputAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputAutocomplete =
    input_core


{-| Place a `FormField` in the `input` slot of `InputChipSet`. -}
inputFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFormField =
    input_core


{-| Place a `OptionPanel` in the `input` slot of `InputChipSet`. -}
inputOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputOptionPanel =
    input_core


{-| Place a `FloatingPanel` in the `input` slot of `InputChipSet`. -}
inputFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFloatingPanel =
    input_core


{-| Place a `Optgroup` in the `input` slot of `InputChipSet`. -}
inputOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputOptgroup =
    input_core


{-| Place a `Option` in the `input` slot of `InputChipSet`. -}
inputOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputOption =
    input_core


{-| Place a `FocusTrap` in the `input` slot of `InputChipSet`. -}
inputFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFocusTrap =
    input_core


{-| Place a `AppBar` in the `input` slot of `InputChipSet`. -}
inputAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputAppBar =
    input_core


{-| Place a `TextOverflow` in the `input` slot of `InputChipSet`. -}
inputTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTextOverflow =
    input_core


{-| Place a `TextHighlight` in the `input` slot of `InputChipSet`. -}
inputTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputTextHighlight =
    input_core


{-| Place a `StateLayer` in the `input` slot of `InputChipSet`. -}
inputStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputStateLayer =
    input_core


{-| Place a `Slide` in the `input` slot of `InputChipSet`. -}
inputSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputSlide =
    input_core


{-| Place a `ScrollContainer` in the `input` slot of `InputChipSet`. -}
inputScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputScrollContainer =
    input_core


{-| Place a `Ripple` in the `input` slot of `InputChipSet`. -}
inputRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputRipple =
    input_core


{-| Place a `PseudoRadio` in the `input` slot of `InputChipSet`. -}
inputPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputPseudoRadio =
    input_core


{-| Place a `PseudoCheckbox` in the `input` slot of `InputChipSet`. -}
inputPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputPseudoCheckbox =
    input_core


{-| Place a `FocusRing` in the `input` slot of `InputChipSet`. -}
inputFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputFocusRing =
    input_core


{-| Place a `Elevation` in the `input` slot of `InputChipSet`. -}
inputElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputElevation =
    input_core


{-| Place a `Collapsible` in the `input` slot of `InputChipSet`. -}
inputCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputCollapsible =
    input_core


{-| Place a `ActionElementBase` in the `input` slot of `InputChipSet`. -}
inputActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.InputChipSet.Builder pa { ps
        | input : M3e.Build.Internal.Used
    } msg pk
inputActionElementBase =
    input_core