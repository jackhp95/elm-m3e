module M3e.Build.ScrollContainer.Slots exposing
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase
    )

{-|
Slot setters for `M3e.Build.ScrollContainer`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs elevation, collapsible, actionElementBase
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
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `ScrollContainer`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tree =
    unnamed_core


{-| Place a `TreeItem` in the `unnamed` slot of `ScrollContainer`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
treeItem =
    unnamed_core


{-| Place a `Toolbar` in the `unnamed` slot of `ScrollContainer`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
toolbar =
    unnamed_core


{-| Place a `Toc` in the `unnamed` slot of `ScrollContainer`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
toc =
    unnamed_core


{-| Place a `TocItem` in the `unnamed` slot of `ScrollContainer`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tocItem =
    unnamed_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `ScrollContainer`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
themeIcon =
    unnamed_core


{-| Place a `Theme` in the `unnamed` slot of `ScrollContainer`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
theme =
    unnamed_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `ScrollContainer`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
textareaAutosize =
    unnamed_core


{-| Place a `Tabs` in the `unnamed` slot of `ScrollContainer`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tabs =
    unnamed_core


{-| Place a `TabPanel` in the `unnamed` slot of `ScrollContainer`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tabPanel =
    unnamed_core


{-| Place a `Tab` in the `unnamed` slot of `ScrollContainer`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tab =
    unnamed_core


{-| Place a `Switch` in the `unnamed` slot of `ScrollContainer`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
switch =
    unnamed_core


{-| Place a `StepperReset` in the `unnamed` slot of `ScrollContainer`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
stepperReset =
    unnamed_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `ScrollContainer`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
stepperPrevious =
    unnamed_core


{-| Place a `Step` in the `unnamed` slot of `ScrollContainer`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
step =
    unnamed_core


{-| Place a `StepPanel` in the `unnamed` slot of `ScrollContainer`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
stepPanel =
    unnamed_core


{-| Place a `Stepper` in the `unnamed` slot of `ScrollContainer`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
stepper =
    unnamed_core


{-| Place a `SplitPane` in the `unnamed` slot of `ScrollContainer`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
splitPane =
    unnamed_core


{-| Place a `SplitButton` in the `unnamed` slot of `ScrollContainer`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
splitButton =
    unnamed_core


{-| Place a `Snackbar` in the `unnamed` slot of `ScrollContainer`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
snackbar =
    unnamed_core


{-| Place a `Slider` in the `unnamed` slot of `ScrollContainer`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
slider =
    unnamed_core


{-| Place a `SliderThumb` in the `unnamed` slot of `ScrollContainer`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
sliderThumb =
    unnamed_core


{-| Place a `SlideGroup` in the `unnamed` slot of `ScrollContainer`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
slideGroup =
    unnamed_core


{-| Place a `Skeleton` in the `unnamed` slot of `ScrollContainer`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
skeleton =
    unnamed_core


{-| Place a `Shape` in the `unnamed` slot of `ScrollContainer`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
shape =
    unnamed_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `ScrollContainer`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
segmentedButton =
    unnamed_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `ScrollContainer`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
buttonSegment =
    unnamed_core


{-| Place a `SearchView` in the `unnamed` slot of `ScrollContainer`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
searchView =
    unnamed_core


{-| Place a `SearchBar` in the `unnamed` slot of `ScrollContainer`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
searchBar =
    unnamed_core


{-| Place a `RadioGroup` in the `unnamed` slot of `ScrollContainer`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
radioGroup =
    unnamed_core


{-| Place a `Radio` in the `unnamed` slot of `ScrollContainer`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
radio =
    unnamed_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `ScrollContainer`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
progressElementIndicatorBase =
    unnamed_core


{-| Place a `Paginator` in the `unnamed` slot of `ScrollContainer`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
paginator =
    unnamed_core


{-| Place a `Select` in the `unnamed` slot of `ScrollContainer`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
select =
    unnamed_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `ScrollContainer`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navRailToggle =
    unnamed_core


{-| Place a `NavRail` in the `unnamed` slot of `ScrollContainer`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navRail =
    unnamed_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `ScrollContainer`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navMenuItemGroup =
    unnamed_core


{-| Place a `NavMenu` in the `unnamed` slot of `ScrollContainer`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navMenu =
    unnamed_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `ScrollContainer`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navMenuItem =
    unnamed_core


{-| Place a `NavBar` in the `unnamed` slot of `ScrollContainer`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navBar =
    unnamed_core


{-| Place a `NavItem` in the `unnamed` slot of `ScrollContainer`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
navItem =
    unnamed_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `ScrollContainer`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuItemRadio =
    unnamed_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `ScrollContainer`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuItemGroup =
    unnamed_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `ScrollContainer`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuItemCheckbox =
    unnamed_core


{-| Place a `Menu` in the `unnamed` slot of `ScrollContainer`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menu =
    unnamed_core


{-| Place a `MenuItem` in the `unnamed` slot of `ScrollContainer`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuItem =
    unnamed_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `ScrollContainer`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuTrigger =
    unnamed_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `ScrollContainer`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
menuItemElementBase =
    unnamed_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `ScrollContainer`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
loadingIndicator =
    unnamed_core


{-| Place a `SelectionList` in the `unnamed` slot of `ScrollContainer`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
selectionList =
    unnamed_core


{-| Place a `ListOption` in the `unnamed` slot of `ScrollContainer`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
listOption =
    unnamed_core


{-| Place a `ActionList` in the `unnamed` slot of `ScrollContainer`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
actionList =
    unnamed_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `ScrollContainer`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
expandableListItem =
    unnamed_core


{-| Place a `ListAction` in the `unnamed` slot of `ScrollContainer`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
listAction =
    unnamed_core


{-| Place a `ListItemButton` in the `unnamed` slot of `ScrollContainer`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
listItemButton =
    unnamed_core


{-| Place a `List` in the `unnamed` slot of `ScrollContainer`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
list =
    unnamed_core


{-| Place a `ListItem` in the `unnamed` slot of `ScrollContainer`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
listItem =
    unnamed_core


{-| Place a `Icon` in the `unnamed` slot of `ScrollContainer`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
icon =
    unnamed_core


{-| Place a `Heading` in the `unnamed` slot of `ScrollContainer`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
heading =
    unnamed_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `ScrollContainer`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
fabMenuTrigger =
    unnamed_core


{-| Place a `FabMenu` in the `unnamed` slot of `ScrollContainer`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
fabMenu =
    unnamed_core


{-| Place a `Fab` in the `unnamed` slot of `ScrollContainer`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
fab =
    unnamed_core


{-| Place a `Accordion` in the `unnamed` slot of `ScrollContainer`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
accordion =
    unnamed_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `ScrollContainer`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
expansionPanel =
    unnamed_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `ScrollContainer`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
expansionHeader =
    unnamed_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `ScrollContainer`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
drawerToggle =
    unnamed_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `ScrollContainer`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
drawerContainer =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `ScrollContainer`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
divider =
    unnamed_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `ScrollContainer`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
dialogTrigger =
    unnamed_core


{-| Place a `Dialog` in the `unnamed` slot of `ScrollContainer`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
dialog =
    unnamed_core


{-| Place a `DialogAction` in the `unnamed` slot of `ScrollContainer`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
dialogAction =
    unnamed_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `ScrollContainer`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
datepickerToggle =
    unnamed_core


{-| Place a `Datepicker` in the `unnamed` slot of `ScrollContainer`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
datepicker =
    unnamed_core


{-| Place a `ContentPane` in the `unnamed` slot of `ScrollContainer`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
contentPane =
    unnamed_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `ScrollContainer`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
suggestionChip =
    unnamed_core


{-| Place a `InputChipSet` in the `unnamed` slot of `ScrollContainer`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
inputChipSet =
    unnamed_core


{-| Place a `InputChip` in the `unnamed` slot of `ScrollContainer`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
inputChip =
    unnamed_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `ScrollContainer`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
filterChipSet =
    unnamed_core


{-| Place a `FilterChip` in the `unnamed` slot of `ScrollContainer`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
filterChip =
    unnamed_core


{-| Place a `ChipSet` in the `unnamed` slot of `ScrollContainer`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
chipSet =
    unnamed_core


{-| Place a `AssistChip` in the `unnamed` slot of `ScrollContainer`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
assistChip =
    unnamed_core


{-| Place a `Chip` in the `unnamed` slot of `ScrollContainer`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
chip =
    unnamed_core


{-| Place a `Checkbox` in the `unnamed` slot of `ScrollContainer`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
checkbox =
    unnamed_core


{-| Place a `Card` in the `unnamed` slot of `ScrollContainer`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
card =
    unnamed_core


{-| Place a `Calendar` in the `unnamed` slot of `ScrollContainer`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
calendar =
    unnamed_core


{-| Place a `YearView` in the `unnamed` slot of `ScrollContainer`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
yearView =
    unnamed_core


{-| Place a `MultiYearView` in the `unnamed` slot of `ScrollContainer`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
multiYearView =
    unnamed_core


{-| Place a `MonthView` in the `unnamed` slot of `ScrollContainer`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
monthView =
    unnamed_core


{-| Place a `Tooltip` in the `unnamed` slot of `ScrollContainer`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tooltip =
    unnamed_core


{-| Place a `RichTooltip` in the `unnamed` slot of `ScrollContainer`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
richTooltip =
    unnamed_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `ScrollContainer`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
tooltipElementBase =
    unnamed_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `ScrollContainer`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
richTooltipAction =
    unnamed_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `ScrollContainer`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
buttonGroup =
    unnamed_core


{-| Place a `IconButton` in the `unnamed` slot of `ScrollContainer`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
iconButton =
    unnamed_core


{-| Place a `Button` in the `unnamed` slot of `ScrollContainer`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
button =
    unnamed_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `ScrollContainer`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | unnamed : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
breadcrumb =
    unnamed_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `ScrollContainer`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
breadcrumbItem =
    unnamed_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `ScrollContainer`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
breadcrumbItemButton =
    unnamed_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `ScrollContainer`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
bottomSheetTrigger =
    unnamed_core


{-| Place a `BottomSheet` in the `unnamed` slot of `ScrollContainer`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
bottomSheet =
    unnamed_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `ScrollContainer`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
bottomSheetAction =
    unnamed_core


{-| Place a `Badge` in the `unnamed` slot of `ScrollContainer`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
badge =
    unnamed_core


{-| Place a `Avatar` in the `unnamed` slot of `ScrollContainer`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
avatar =
    unnamed_core


{-| Place a `Autocomplete` in the `unnamed` slot of `ScrollContainer`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
autocomplete =
    unnamed_core


{-| Place a `FormField` in the `unnamed` slot of `ScrollContainer`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
formField =
    unnamed_core


{-| Place a `OptionPanel` in the `unnamed` slot of `ScrollContainer`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
optionPanel =
    unnamed_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `ScrollContainer`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
floatingPanel =
    unnamed_core


{-| Place a `Optgroup` in the `unnamed` slot of `ScrollContainer`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `ScrollContainer`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
option =
    unnamed_core


{-| Place a `FocusTrap` in the `unnamed` slot of `ScrollContainer`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
focusTrap =
    unnamed_core


{-| Place a `AppBar` in the `unnamed` slot of `ScrollContainer`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
appBar =
    unnamed_core


{-| Place a `TextOverflow` in the `unnamed` slot of `ScrollContainer`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
textOverflow =
    unnamed_core


{-| Place a `TextHighlight` in the `unnamed` slot of `ScrollContainer`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
textHighlight =
    unnamed_core


{-| Place a `StateLayer` in the `unnamed` slot of `ScrollContainer`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
stateLayer =
    unnamed_core


{-| Place a `Slide` in the `unnamed` slot of `ScrollContainer`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
slide =
    unnamed_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `ScrollContainer`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
scrollContainer =
    unnamed_core


{-| Place a `Ripple` in the `unnamed` slot of `ScrollContainer`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
ripple =
    unnamed_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `ScrollContainer`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
pseudoRadio =
    unnamed_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `ScrollContainer`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
pseudoCheckbox =
    unnamed_core


{-| Place a `FocusRing` in the `unnamed` slot of `ScrollContainer`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
focusRing =
    unnamed_core


{-| Place a `Elevation` in the `unnamed` slot of `ScrollContainer`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
elevation =
    unnamed_core


{-| Place a `Collapsible` in the `unnamed` slot of `ScrollContainer`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
collapsible =
    unnamed_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `ScrollContainer`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
    -> M3e.Build.ScrollContainer.Builder pa ps msg pk
actionElementBase =
    unnamed_core