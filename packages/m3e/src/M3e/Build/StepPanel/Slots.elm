module M3e.Build.StepPanel.Slots exposing
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, actionsTree, actionsTreeItem
    , actionsToolbar, actionsToc, actionsTocItem, actionsThemeIcon, actionsTheme, actionsTextareaAutosize, actionsTabs
    , actionsTabPanel, actionsTab, actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep, actionsStepPanel
    , actionsStepper, actionsSplitPane, actionsSplitButton, actionsSnackbar, actionsSlider, actionsSliderThumb, actionsSlideGroup
    , actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment, actionsSearchView, actionsSearchBar, actionsRadioGroup
    , actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator, actionsSelect, actionsNavRailToggle, actionsNavRail, actionsNavMenuItemGroup
    , actionsNavMenu, actionsNavMenuItem, actionsNavBar, actionsNavItem, actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox
    , actionsMenu, actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList, actionsListOption
    , actionsActionList, actionsExpandableListItem, actionsListAction, actionsListItemButton, actionsList, actionsListItem, actionsIcon
    , actionsHeading, actionsFabMenuTrigger, actionsFabMenu, actionsFab, actionsAccordion, actionsExpansionPanel, actionsExpansionHeader
    , actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger, actionsDialog, actionsDialogAction, actionsDatepickerToggle
    , actionsDatepicker, actionsContentPane, actionsSuggestionChip, actionsInputChipSet, actionsInputChip, actionsFilterChipSet, actionsFilterChip
    , actionsChipSet, actionsAssistChip, actionsChip, actionsCheckbox, actionsCard, actionsCalendar, actionsYearView
    , actionsMultiYearView, actionsMonthView, actionsTooltip, actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup
    , actionsIconButton, actionsButton, actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger, actionsBottomSheet
    , actionsBottomSheetAction, actionsBadge, actionsAvatar, actionsAutocomplete, actionsFormField, actionsOptionPanel, actionsFloatingPanel
    , actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar, actionsTextOverflow, actionsTextHighlight, actionsStateLayer
    , actionsSlide, actionsScrollContainer, actionsRipple, actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing, actionsElevation
    , actionsCollapsible, actionsActionElementBase
    )

{-|
Slot setters for `M3e.Build.StepPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs elevation, collapsible, actionElementBase, actionsTree, actionsTreeItem, actionsToolbar
@docs actionsToc, actionsTocItem, actionsThemeIcon, actionsTheme, actionsTextareaAutosize, actionsTabs
@docs actionsTabPanel, actionsTab, actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep
@docs actionsStepPanel, actionsStepper, actionsSplitPane, actionsSplitButton, actionsSnackbar, actionsSlider
@docs actionsSliderThumb, actionsSlideGroup, actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment
@docs actionsSearchView, actionsSearchBar, actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator
@docs actionsSelect, actionsNavRailToggle, actionsNavRail, actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem
@docs actionsNavBar, actionsNavItem, actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu
@docs actionsMenuItem, actionsMenuTrigger, actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList, actionsListOption
@docs actionsActionList, actionsExpandableListItem, actionsListAction, actionsListItemButton, actionsList, actionsListItem
@docs actionsIcon, actionsHeading, actionsFabMenuTrigger, actionsFabMenu, actionsFab, actionsAccordion
@docs actionsExpansionPanel, actionsExpansionHeader, actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger
@docs actionsDialog, actionsDialogAction, actionsDatepickerToggle, actionsDatepicker, actionsContentPane, actionsSuggestionChip
@docs actionsInputChipSet, actionsInputChip, actionsFilterChipSet, actionsFilterChip, actionsChipSet, actionsAssistChip
@docs actionsChip, actionsCheckbox, actionsCard, actionsCalendar, actionsYearView, actionsMultiYearView
@docs actionsMonthView, actionsTooltip, actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup
@docs actionsIconButton, actionsButton, actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger
@docs actionsBottomSheet, actionsBottomSheetAction, actionsBadge, actionsAvatar, actionsAutocomplete, actionsFormField
@docs actionsOptionPanel, actionsFloatingPanel, actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar
@docs actionsTextOverflow, actionsTextHighlight, actionsStateLayer, actionsSlide, actionsScrollContainer, actionsRipple
@docs actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase
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
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


actions_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actions_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `StepPanel`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tree =
    unnamed_core


{-| Place a `TreeItem` in the `unnamed` slot of `StepPanel`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
treeItem =
    unnamed_core


{-| Place a `Toolbar` in the `unnamed` slot of `StepPanel`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
toolbar =
    unnamed_core


{-| Place a `Toc` in the `unnamed` slot of `StepPanel`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
toc =
    unnamed_core


{-| Place a `TocItem` in the `unnamed` slot of `StepPanel`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tocItem =
    unnamed_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `StepPanel`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
themeIcon =
    unnamed_core


{-| Place a `Theme` in the `unnamed` slot of `StepPanel`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
theme =
    unnamed_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `StepPanel`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textareaAutosize =
    unnamed_core


{-| Place a `Tabs` in the `unnamed` slot of `StepPanel`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tabs =
    unnamed_core


{-| Place a `TabPanel` in the `unnamed` slot of `StepPanel`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tabPanel =
    unnamed_core


{-| Place a `Tab` in the `unnamed` slot of `StepPanel`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tab =
    unnamed_core


{-| Place a `Switch` in the `unnamed` slot of `StepPanel`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
switch =
    unnamed_core


{-| Place a `StepperReset` in the `unnamed` slot of `StepPanel`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    unnamed_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `StepPanel`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    unnamed_core


{-| Place a `Step` in the `unnamed` slot of `StepPanel`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
step =
    unnamed_core


{-| Place a `StepPanel` in the `unnamed` slot of `StepPanel`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepPanel =
    unnamed_core


{-| Place a `Stepper` in the `unnamed` slot of `StepPanel`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stepper =
    unnamed_core


{-| Place a `SplitPane` in the `unnamed` slot of `StepPanel`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
splitPane =
    unnamed_core


{-| Place a `SplitButton` in the `unnamed` slot of `StepPanel`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
splitButton =
    unnamed_core


{-| Place a `Snackbar` in the `unnamed` slot of `StepPanel`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
snackbar =
    unnamed_core


{-| Place a `Slider` in the `unnamed` slot of `StepPanel`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slider =
    unnamed_core


{-| Place a `SliderThumb` in the `unnamed` slot of `StepPanel`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
sliderThumb =
    unnamed_core


{-| Place a `SlideGroup` in the `unnamed` slot of `StepPanel`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slideGroup =
    unnamed_core


{-| Place a `Skeleton` in the `unnamed` slot of `StepPanel`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
skeleton =
    unnamed_core


{-| Place a `Shape` in the `unnamed` slot of `StepPanel`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
shape =
    unnamed_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `StepPanel`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
segmentedButton =
    unnamed_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `StepPanel`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
buttonSegment =
    unnamed_core


{-| Place a `SearchView` in the `unnamed` slot of `StepPanel`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
searchView =
    unnamed_core


{-| Place a `SearchBar` in the `unnamed` slot of `StepPanel`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
searchBar =
    unnamed_core


{-| Place a `RadioGroup` in the `unnamed` slot of `StepPanel`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
radioGroup =
    unnamed_core


{-| Place a `Radio` in the `unnamed` slot of `StepPanel`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
radio =
    unnamed_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `StepPanel`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
progressElementIndicatorBase =
    unnamed_core


{-| Place a `Paginator` in the `unnamed` slot of `StepPanel`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
paginator =
    unnamed_core


{-| Place a `Select` in the `unnamed` slot of `StepPanel`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
select =
    unnamed_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `StepPanel`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    unnamed_core


{-| Place a `NavRail` in the `unnamed` slot of `StepPanel`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navRail =
    unnamed_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `StepPanel`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenuItemGroup =
    unnamed_core


{-| Place a `NavMenu` in the `unnamed` slot of `StepPanel`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenu =
    unnamed_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `StepPanel`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navMenuItem =
    unnamed_core


{-| Place a `NavBar` in the `unnamed` slot of `StepPanel`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navBar =
    unnamed_core


{-| Place a `NavItem` in the `unnamed` slot of `StepPanel`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
navItem =
    unnamed_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `StepPanel`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemRadio =
    unnamed_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `StepPanel`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemGroup =
    unnamed_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `StepPanel`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemCheckbox =
    unnamed_core


{-| Place a `Menu` in the `unnamed` slot of `StepPanel`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menu =
    unnamed_core


{-| Place a `MenuItem` in the `unnamed` slot of `StepPanel`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItem =
    unnamed_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `StepPanel`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    unnamed_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `StepPanel`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
menuItemElementBase =
    unnamed_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `StepPanel`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
loadingIndicator =
    unnamed_core


{-| Place a `SelectionList` in the `unnamed` slot of `StepPanel`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
selectionList =
    unnamed_core


{-| Place a `ListOption` in the `unnamed` slot of `StepPanel`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listOption =
    unnamed_core


{-| Place a `ActionList` in the `unnamed` slot of `StepPanel`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
actionList =
    unnamed_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `StepPanel`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expandableListItem =
    unnamed_core


{-| Place a `ListAction` in the `unnamed` slot of `StepPanel`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listAction =
    unnamed_core


{-| Place a `ListItemButton` in the `unnamed` slot of `StepPanel`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listItemButton =
    unnamed_core


{-| Place a `List` in the `unnamed` slot of `StepPanel`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
list =
    unnamed_core


{-| Place a `ListItem` in the `unnamed` slot of `StepPanel`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
listItem =
    unnamed_core


{-| Place a `Icon` in the `unnamed` slot of `StepPanel`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
icon =
    unnamed_core


{-| Place a `Heading` in the `unnamed` slot of `StepPanel`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
heading =
    unnamed_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `StepPanel`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    unnamed_core


{-| Place a `FabMenu` in the `unnamed` slot of `StepPanel`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fabMenu =
    unnamed_core


{-| Place a `Fab` in the `unnamed` slot of `StepPanel`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
fab =
    unnamed_core


{-| Place a `Accordion` in the `unnamed` slot of `StepPanel`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
accordion =
    unnamed_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `StepPanel`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expansionPanel =
    unnamed_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `StepPanel`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
expansionHeader =
    unnamed_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `StepPanel`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    unnamed_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `StepPanel`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
drawerContainer =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `StepPanel`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
divider =
    unnamed_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `StepPanel`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    unnamed_core


{-| Place a `Dialog` in the `unnamed` slot of `StepPanel`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialog =
    unnamed_core


{-| Place a `DialogAction` in the `unnamed` slot of `StepPanel`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    unnamed_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `StepPanel`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    unnamed_core


{-| Place a `Datepicker` in the `unnamed` slot of `StepPanel`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
datepicker =
    unnamed_core


{-| Place a `ContentPane` in the `unnamed` slot of `StepPanel`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
contentPane =
    unnamed_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `StepPanel`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
suggestionChip =
    unnamed_core


{-| Place a `InputChipSet` in the `unnamed` slot of `StepPanel`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    unnamed_core


{-| Place a `InputChip` in the `unnamed` slot of `StepPanel`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
inputChip =
    unnamed_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `StepPanel`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
filterChipSet =
    unnamed_core


{-| Place a `FilterChip` in the `unnamed` slot of `StepPanel`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
filterChip =
    unnamed_core


{-| Place a `ChipSet` in the `unnamed` slot of `StepPanel`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
chipSet =
    unnamed_core


{-| Place a `AssistChip` in the `unnamed` slot of `StepPanel`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
assistChip =
    unnamed_core


{-| Place a `Chip` in the `unnamed` slot of `StepPanel`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
chip =
    unnamed_core


{-| Place a `Checkbox` in the `unnamed` slot of `StepPanel`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
checkbox =
    unnamed_core


{-| Place a `Card` in the `unnamed` slot of `StepPanel`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
card =
    unnamed_core


{-| Place a `Calendar` in the `unnamed` slot of `StepPanel`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
calendar =
    unnamed_core


{-| Place a `YearView` in the `unnamed` slot of `StepPanel`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
yearView =
    unnamed_core


{-| Place a `MultiYearView` in the `unnamed` slot of `StepPanel`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
multiYearView =
    unnamed_core


{-| Place a `MonthView` in the `unnamed` slot of `StepPanel`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
monthView =
    unnamed_core


{-| Place a `Tooltip` in the `unnamed` slot of `StepPanel`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tooltip =
    unnamed_core


{-| Place a `RichTooltip` in the `unnamed` slot of `StepPanel`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
richTooltip =
    unnamed_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `StepPanel`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
tooltipElementBase =
    unnamed_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `StepPanel`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    unnamed_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `StepPanel`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
buttonGroup =
    unnamed_core


{-| Place a `IconButton` in the `unnamed` slot of `StepPanel`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
iconButton =
    unnamed_core


{-| Place a `Button` in the `unnamed` slot of `StepPanel`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
button =
    unnamed_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `StepPanel`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumb =
    unnamed_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `StepPanel`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumbItem =
    unnamed_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `StepPanel`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
breadcrumbItemButton =
    unnamed_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `StepPanel`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    unnamed_core


{-| Place a `BottomSheet` in the `unnamed` slot of `StepPanel`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheet =
    unnamed_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `StepPanel`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    unnamed_core


{-| Place a `Badge` in the `unnamed` slot of `StepPanel`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
badge =
    unnamed_core


{-| Place a `Avatar` in the `unnamed` slot of `StepPanel`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
avatar =
    unnamed_core


{-| Place a `Autocomplete` in the `unnamed` slot of `StepPanel`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
autocomplete =
    unnamed_core


{-| Place a `FormField` in the `unnamed` slot of `StepPanel`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
formField =
    unnamed_core


{-| Place a `OptionPanel` in the `unnamed` slot of `StepPanel`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
optionPanel =
    unnamed_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `StepPanel`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
floatingPanel =
    unnamed_core


{-| Place a `Optgroup` in the `unnamed` slot of `StepPanel`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `StepPanel`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
option =
    unnamed_core


{-| Place a `FocusTrap` in the `unnamed` slot of `StepPanel`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
focusTrap =
    unnamed_core


{-| Place a `AppBar` in the `unnamed` slot of `StepPanel`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
appBar =
    unnamed_core


{-| Place a `TextOverflow` in the `unnamed` slot of `StepPanel`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textOverflow =
    unnamed_core


{-| Place a `TextHighlight` in the `unnamed` slot of `StepPanel`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
textHighlight =
    unnamed_core


{-| Place a `StateLayer` in the `unnamed` slot of `StepPanel`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
stateLayer =
    unnamed_core


{-| Place a `Slide` in the `unnamed` slot of `StepPanel`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
slide =
    unnamed_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `StepPanel`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
scrollContainer =
    unnamed_core


{-| Place a `Ripple` in the `unnamed` slot of `StepPanel`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
ripple =
    unnamed_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `StepPanel`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
pseudoRadio =
    unnamed_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `StepPanel`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
pseudoCheckbox =
    unnamed_core


{-| Place a `FocusRing` in the `unnamed` slot of `StepPanel`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
focusRing =
    unnamed_core


{-| Place a `Elevation` in the `unnamed` slot of `StepPanel`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
elevation =
    unnamed_core


{-| Place a `Collapsible` in the `unnamed` slot of `StepPanel`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
collapsible =
    unnamed_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `StepPanel`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
actionElementBase =
    unnamed_core


{-| Place a `Tree` in the `actions` slot of `StepPanel`. -}
actionsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTree =
    actions_core


{-| Place a `TreeItem` in the `actions` slot of `StepPanel`. -}
actionsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTreeItem =
    actions_core


{-| Place a `Toolbar` in the `actions` slot of `StepPanel`. -}
actionsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToolbar =
    actions_core


{-| Place a `Toc` in the `actions` slot of `StepPanel`. -}
actionsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToc =
    actions_core


{-| Place a `TocItem` in the `actions` slot of `StepPanel`. -}
actionsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTocItem =
    actions_core


{-| Place a `ThemeIcon` in the `actions` slot of `StepPanel`. -}
actionsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsThemeIcon =
    actions_core


{-| Place a `Theme` in the `actions` slot of `StepPanel`. -}
actionsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTheme =
    actions_core


{-| Place a `TextareaAutosize` in the `actions` slot of `StepPanel`. -}
actionsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextareaAutosize =
    actions_core


{-| Place a `Tabs` in the `actions` slot of `StepPanel`. -}
actionsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabs =
    actions_core


{-| Place a `TabPanel` in the `actions` slot of `StepPanel`. -}
actionsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabPanel =
    actions_core


{-| Place a `Tab` in the `actions` slot of `StepPanel`. -}
actionsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTab =
    actions_core


{-| Place a `Switch` in the `actions` slot of `StepPanel`. -}
actionsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSwitch =
    actions_core


{-| Place a `StepperReset` in the `actions` slot of `StepPanel`. -}
actionsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperReset =
    actions_core


{-| Place a `StepperPrevious` in the `actions` slot of `StepPanel`. -}
actionsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperPrevious =
    actions_core


{-| Place a `Step` in the `actions` slot of `StepPanel`. -}
actionsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStep =
    actions_core


{-| Place a `StepPanel` in the `actions` slot of `StepPanel`. -}
actionsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepPanel =
    actions_core


{-| Place a `Stepper` in the `actions` slot of `StepPanel`. -}
actionsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepper =
    actions_core


{-| Place a `SplitPane` in the `actions` slot of `StepPanel`. -}
actionsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitPane =
    actions_core


{-| Place a `SplitButton` in the `actions` slot of `StepPanel`. -}
actionsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitButton =
    actions_core


{-| Place a `Snackbar` in the `actions` slot of `StepPanel`. -}
actionsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSnackbar =
    actions_core


{-| Place a `Slider` in the `actions` slot of `StepPanel`. -}
actionsSlider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlider =
    actions_core


{-| Place a `SliderThumb` in the `actions` slot of `StepPanel`. -}
actionsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSliderThumb =
    actions_core


{-| Place a `SlideGroup` in the `actions` slot of `StepPanel`. -}
actionsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlideGroup =
    actions_core


{-| Place a `Skeleton` in the `actions` slot of `StepPanel`. -}
actionsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSkeleton =
    actions_core


{-| Place a `Shape` in the `actions` slot of `StepPanel`. -}
actionsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsShape =
    actions_core


{-| Place a `SegmentedButton` in the `actions` slot of `StepPanel`. -}
actionsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSegmentedButton =
    actions_core


{-| Place a `ButtonSegment` in the `actions` slot of `StepPanel`. -}
actionsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonSegment =
    actions_core


{-| Place a `SearchView` in the `actions` slot of `StepPanel`. -}
actionsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchView =
    actions_core


{-| Place a `SearchBar` in the `actions` slot of `StepPanel`. -}
actionsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchBar =
    actions_core


{-| Place a `RadioGroup` in the `actions` slot of `StepPanel`. -}
actionsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadioGroup =
    actions_core


{-| Place a `Radio` in the `actions` slot of `StepPanel`. -}
actionsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadio =
    actions_core


{-| Place a `ProgressElementIndicatorBase` in the `actions` slot of `StepPanel`. -}
actionsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsProgressElementIndicatorBase =
    actions_core


{-| Place a `Paginator` in the `actions` slot of `StepPanel`. -}
actionsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPaginator =
    actions_core


{-| Place a `Select` in the `actions` slot of `StepPanel`. -}
actionsSelect :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelect =
    actions_core


{-| Place a `NavRailToggle` in the `actions` slot of `StepPanel`. -}
actionsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRailToggle =
    actions_core


{-| Place a `NavRail` in the `actions` slot of `StepPanel`. -}
actionsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRail =
    actions_core


{-| Place a `NavMenuItemGroup` in the `actions` slot of `StepPanel`. -}
actionsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItemGroup =
    actions_core


{-| Place a `NavMenu` in the `actions` slot of `StepPanel`. -}
actionsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenu =
    actions_core


{-| Place a `NavMenuItem` in the `actions` slot of `StepPanel`. -}
actionsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItem =
    actions_core


{-| Place a `NavBar` in the `actions` slot of `StepPanel`. -}
actionsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavBar =
    actions_core


{-| Place a `NavItem` in the `actions` slot of `StepPanel`. -}
actionsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavItem =
    actions_core


{-| Place a `MenuItemRadio` in the `actions` slot of `StepPanel`. -}
actionsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemRadio =
    actions_core


{-| Place a `MenuItemGroup` in the `actions` slot of `StepPanel`. -}
actionsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemGroup =
    actions_core


{-| Place a `MenuItemCheckbox` in the `actions` slot of `StepPanel`. -}
actionsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemCheckbox =
    actions_core


{-| Place a `Menu` in the `actions` slot of `StepPanel`. -}
actionsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenu =
    actions_core


{-| Place a `MenuItem` in the `actions` slot of `StepPanel`. -}
actionsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItem =
    actions_core


{-| Place a `MenuTrigger` in the `actions` slot of `StepPanel`. -}
actionsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuTrigger =
    actions_core


{-| Place a `MenuItemElementBase` in the `actions` slot of `StepPanel`. -}
actionsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemElementBase =
    actions_core


{-| Place a `LoadingIndicator` in the `actions` slot of `StepPanel`. -}
actionsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsLoadingIndicator =
    actions_core


{-| Place a `SelectionList` in the `actions` slot of `StepPanel`. -}
actionsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelectionList =
    actions_core


{-| Place a `ListOption` in the `actions` slot of `StepPanel`. -}
actionsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListOption =
    actions_core


{-| Place a `ActionList` in the `actions` slot of `StepPanel`. -}
actionsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionList =
    actions_core


{-| Place a `ExpandableListItem` in the `actions` slot of `StepPanel`. -}
actionsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpandableListItem =
    actions_core


{-| Place a `ListAction` in the `actions` slot of `StepPanel`. -}
actionsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListAction =
    actions_core


{-| Place a `ListItemButton` in the `actions` slot of `StepPanel`. -}
actionsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItemButton =
    actions_core


{-| Place a `List` in the `actions` slot of `StepPanel`. -}
actionsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsList =
    actions_core


{-| Place a `ListItem` in the `actions` slot of `StepPanel`. -}
actionsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItem =
    actions_core


{-| Place a `Icon` in the `actions` slot of `StepPanel`. -}
actionsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIcon =
    actions_core


{-| Place a `Heading` in the `actions` slot of `StepPanel`. -}
actionsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsHeading =
    actions_core


{-| Place a `FabMenuTrigger` in the `actions` slot of `StepPanel`. -}
actionsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenuTrigger =
    actions_core


{-| Place a `FabMenu` in the `actions` slot of `StepPanel`. -}
actionsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenu =
    actions_core


{-| Place a `Fab` in the `actions` slot of `StepPanel`. -}
actionsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFab =
    actions_core


{-| Place a `Accordion` in the `actions` slot of `StepPanel`. -}
actionsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAccordion =
    actions_core


{-| Place a `ExpansionPanel` in the `actions` slot of `StepPanel`. -}
actionsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionPanel =
    actions_core


{-| Place a `ExpansionHeader` in the `actions` slot of `StepPanel`. -}
actionsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionHeader =
    actions_core


{-| Place a `DrawerToggle` in the `actions` slot of `StepPanel`. -}
actionsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerToggle =
    actions_core


{-| Place a `DrawerContainer` in the `actions` slot of `StepPanel`. -}
actionsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerContainer =
    actions_core


{-| Place a `Divider` in the `actions` slot of `StepPanel`. -}
actionsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDivider =
    actions_core


{-| Place a `DialogTrigger` in the `actions` slot of `StepPanel`. -}
actionsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogTrigger =
    actions_core


{-| Place a `Dialog` in the `actions` slot of `StepPanel`. -}
actionsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialog =
    actions_core


{-| Place a `DialogAction` in the `actions` slot of `StepPanel`. -}
actionsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogAction =
    actions_core


{-| Place a `DatepickerToggle` in the `actions` slot of `StepPanel`. -}
actionsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepickerToggle =
    actions_core


{-| Place a `Datepicker` in the `actions` slot of `StepPanel`. -}
actionsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepicker =
    actions_core


{-| Place a `ContentPane` in the `actions` slot of `StepPanel`. -}
actionsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsContentPane =
    actions_core


{-| Place a `SuggestionChip` in the `actions` slot of `StepPanel`. -}
actionsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSuggestionChip =
    actions_core


{-| Place a `InputChipSet` in the `actions` slot of `StepPanel`. -}
actionsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChipSet =
    actions_core


{-| Place a `InputChip` in the `actions` slot of `StepPanel`. -}
actionsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChip =
    actions_core


{-| Place a `FilterChipSet` in the `actions` slot of `StepPanel`. -}
actionsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChipSet =
    actions_core


{-| Place a `FilterChip` in the `actions` slot of `StepPanel`. -}
actionsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChip =
    actions_core


{-| Place a `ChipSet` in the `actions` slot of `StepPanel`. -}
actionsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChipSet =
    actions_core


{-| Place a `AssistChip` in the `actions` slot of `StepPanel`. -}
actionsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAssistChip =
    actions_core


{-| Place a `Chip` in the `actions` slot of `StepPanel`. -}
actionsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChip =
    actions_core


{-| Place a `Checkbox` in the `actions` slot of `StepPanel`. -}
actionsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCheckbox =
    actions_core


{-| Place a `Card` in the `actions` slot of `StepPanel`. -}
actionsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCard =
    actions_core


{-| Place a `Calendar` in the `actions` slot of `StepPanel`. -}
actionsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCalendar =
    actions_core


{-| Place a `YearView` in the `actions` slot of `StepPanel`. -}
actionsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsYearView =
    actions_core


{-| Place a `MultiYearView` in the `actions` slot of `StepPanel`. -}
actionsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMultiYearView =
    actions_core


{-| Place a `MonthView` in the `actions` slot of `StepPanel`. -}
actionsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMonthView =
    actions_core


{-| Place a `Tooltip` in the `actions` slot of `StepPanel`. -}
actionsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltip =
    actions_core


{-| Place a `RichTooltip` in the `actions` slot of `StepPanel`. -}
actionsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltip =
    actions_core


{-| Place a `TooltipElementBase` in the `actions` slot of `StepPanel`. -}
actionsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltipElementBase =
    actions_core


{-| Place a `RichTooltipAction` in the `actions` slot of `StepPanel`. -}
actionsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltipAction =
    actions_core


{-| Place a `ButtonGroup` in the `actions` slot of `StepPanel`. -}
actionsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonGroup =
    actions_core


{-| Place a `IconButton` in the `actions` slot of `StepPanel`. -}
actionsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIconButton =
    actions_core


{-| Place a `Button` in the `actions` slot of `StepPanel`. -}
actionsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButton =
    actions_core


{-| Place a `Breadcrumb` in the `actions` slot of `StepPanel`. -}
actionsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumb =
    actions_core


{-| Place a `BreadcrumbItem` in the `actions` slot of `StepPanel`. -}
actionsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItem =
    actions_core


{-| Place a `BreadcrumbItemButton` in the `actions` slot of `StepPanel`. -}
actionsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItemButton =
    actions_core


{-| Place a `BottomSheetTrigger` in the `actions` slot of `StepPanel`. -}
actionsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetTrigger =
    actions_core


{-| Place a `BottomSheet` in the `actions` slot of `StepPanel`. -}
actionsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheet =
    actions_core


{-| Place a `BottomSheetAction` in the `actions` slot of `StepPanel`. -}
actionsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetAction =
    actions_core


{-| Place a `Badge` in the `actions` slot of `StepPanel`. -}
actionsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBadge =
    actions_core


{-| Place a `Avatar` in the `actions` slot of `StepPanel`. -}
actionsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAvatar =
    actions_core


{-| Place a `Autocomplete` in the `actions` slot of `StepPanel`. -}
actionsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAutocomplete =
    actions_core


{-| Place a `FormField` in the `actions` slot of `StepPanel`. -}
actionsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFormField =
    actions_core


{-| Place a `OptionPanel` in the `actions` slot of `StepPanel`. -}
actionsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptionPanel =
    actions_core


{-| Place a `FloatingPanel` in the `actions` slot of `StepPanel`. -}
actionsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFloatingPanel =
    actions_core


{-| Place a `Optgroup` in the `actions` slot of `StepPanel`. -}
actionsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptgroup =
    actions_core


{-| Place a `Option` in the `actions` slot of `StepPanel`. -}
actionsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOption =
    actions_core


{-| Place a `FocusTrap` in the `actions` slot of `StepPanel`. -}
actionsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusTrap =
    actions_core


{-| Place a `AppBar` in the `actions` slot of `StepPanel`. -}
actionsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAppBar =
    actions_core


{-| Place a `TextOverflow` in the `actions` slot of `StepPanel`. -}
actionsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextOverflow =
    actions_core


{-| Place a `TextHighlight` in the `actions` slot of `StepPanel`. -}
actionsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextHighlight =
    actions_core


{-| Place a `StateLayer` in the `actions` slot of `StepPanel`. -}
actionsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStateLayer =
    actions_core


{-| Place a `Slide` in the `actions` slot of `StepPanel`. -}
actionsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlide =
    actions_core


{-| Place a `ScrollContainer` in the `actions` slot of `StepPanel`. -}
actionsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsScrollContainer =
    actions_core


{-| Place a `Ripple` in the `actions` slot of `StepPanel`. -}
actionsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRipple =
    actions_core


{-| Place a `PseudoRadio` in the `actions` slot of `StepPanel`. -}
actionsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoRadio =
    actions_core


{-| Place a `PseudoCheckbox` in the `actions` slot of `StepPanel`. -}
actionsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoCheckbox =
    actions_core


{-| Place a `FocusRing` in the `actions` slot of `StepPanel`. -}
actionsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusRing =
    actions_core


{-| Place a `Elevation` in the `actions` slot of `StepPanel`. -}
actionsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsElevation =
    actions_core


{-| Place a `Collapsible` in the `actions` slot of `StepPanel`. -}
actionsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCollapsible =
    actions_core


{-| Place a `ActionElementBase` in the `actions` slot of `StepPanel`. -}
actionsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepPanel.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionElementBase =
    actions_core