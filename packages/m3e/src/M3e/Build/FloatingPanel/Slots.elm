module M3e.Build.FloatingPanel.Slots exposing
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
Slot setters for `M3e.Build.FloatingPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `FloatingPanel`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tree =
    default_core


{-| Place a `TreeItem` in the `unnamed` slot of `FloatingPanel`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
treeItem =
    default_core


{-| Place a `Toolbar` in the `unnamed` slot of `FloatingPanel`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
toolbar =
    default_core


{-| Place a `Toc` in the `unnamed` slot of `FloatingPanel`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
toc =
    default_core


{-| Place a `TocItem` in the `unnamed` slot of `FloatingPanel`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tocItem =
    default_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `FloatingPanel`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
themeIcon =
    default_core


{-| Place a `Theme` in the `unnamed` slot of `FloatingPanel`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
theme =
    default_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `FloatingPanel`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
textareaAutosize =
    default_core


{-| Place a `Tabs` in the `unnamed` slot of `FloatingPanel`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tabs =
    default_core


{-| Place a `TabPanel` in the `unnamed` slot of `FloatingPanel`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tabPanel =
    default_core


{-| Place a `Tab` in the `unnamed` slot of `FloatingPanel`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tab =
    default_core


{-| Place a `Switch` in the `unnamed` slot of `FloatingPanel`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
switch =
    default_core


{-| Place a `StepperReset` in the `unnamed` slot of `FloatingPanel`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `FloatingPanel`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
stepperPrevious =
    default_core


{-| Place a `Step` in the `unnamed` slot of `FloatingPanel`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
step =
    default_core


{-| Place a `StepPanel` in the `unnamed` slot of `FloatingPanel`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
stepPanel =
    default_core


{-| Place a `Stepper` in the `unnamed` slot of `FloatingPanel`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
stepper =
    default_core


{-| Place a `SplitPane` in the `unnamed` slot of `FloatingPanel`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
splitPane =
    default_core


{-| Place a `SplitButton` in the `unnamed` slot of `FloatingPanel`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
splitButton =
    default_core


{-| Place a `Snackbar` in the `unnamed` slot of `FloatingPanel`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
snackbar =
    default_core


{-| Place a `Slider` in the `unnamed` slot of `FloatingPanel`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
slider =
    default_core


{-| Place a `SliderThumb` in the `unnamed` slot of `FloatingPanel`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
sliderThumb =
    default_core


{-| Place a `SlideGroup` in the `unnamed` slot of `FloatingPanel`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
slideGroup =
    default_core


{-| Place a `Skeleton` in the `unnamed` slot of `FloatingPanel`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
skeleton =
    default_core


{-| Place a `Shape` in the `unnamed` slot of `FloatingPanel`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
shape =
    default_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `FloatingPanel`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
segmentedButton =
    default_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `FloatingPanel`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
buttonSegment =
    default_core


{-| Place a `SearchView` in the `unnamed` slot of `FloatingPanel`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
searchView =
    default_core


{-| Place a `SearchBar` in the `unnamed` slot of `FloatingPanel`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
searchBar =
    default_core


{-| Place a `RadioGroup` in the `unnamed` slot of `FloatingPanel`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
radioGroup =
    default_core


{-| Place a `Radio` in the `unnamed` slot of `FloatingPanel`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
radio =
    default_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `FloatingPanel`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
progressElementIndicatorBase =
    default_core


{-| Place a `Paginator` in the `unnamed` slot of `FloatingPanel`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
paginator =
    default_core


{-| Place a `Select` in the `unnamed` slot of `FloatingPanel`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
select =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `FloatingPanel`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navRailToggle =
    default_core


{-| Place a `NavRail` in the `unnamed` slot of `FloatingPanel`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navRail =
    default_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `FloatingPanel`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenu` in the `unnamed` slot of `FloatingPanel`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navMenu =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `FloatingPanel`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navMenuItem =
    default_core


{-| Place a `NavBar` in the `unnamed` slot of `FloatingPanel`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navBar =
    default_core


{-| Place a `NavItem` in the `unnamed` slot of `FloatingPanel`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
navItem =
    default_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `FloatingPanel`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `FloatingPanel`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `FloatingPanel`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuItemCheckbox =
    default_core


{-| Place a `Menu` in the `unnamed` slot of `FloatingPanel`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menu =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `FloatingPanel`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuItem =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `FloatingPanel`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuTrigger =
    default_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `FloatingPanel`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
menuItemElementBase =
    default_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `FloatingPanel`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
loadingIndicator =
    default_core


{-| Place a `SelectionList` in the `unnamed` slot of `FloatingPanel`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
selectionList =
    default_core


{-| Place a `ListOption` in the `unnamed` slot of `FloatingPanel`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
listOption =
    default_core


{-| Place a `ActionList` in the `unnamed` slot of `FloatingPanel`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
actionList =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `FloatingPanel`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `FloatingPanel`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
listAction =
    default_core


{-| Place a `ListItemButton` in the `unnamed` slot of `FloatingPanel`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
listItemButton =
    default_core


{-| Place a `List` in the `unnamed` slot of `FloatingPanel`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
list =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `FloatingPanel`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
listItem =
    default_core


{-| Place a `Icon` in the `unnamed` slot of `FloatingPanel`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
icon =
    default_core


{-| Place a `Heading` in the `unnamed` slot of `FloatingPanel`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
heading =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `FloatingPanel`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
fabMenuTrigger =
    default_core


{-| Place a `FabMenu` in the `unnamed` slot of `FloatingPanel`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
fabMenu =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `FloatingPanel`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
fab =
    default_core


{-| Place a `Accordion` in the `unnamed` slot of `FloatingPanel`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
accordion =
    default_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `FloatingPanel`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
expansionPanel =
    default_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `FloatingPanel`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
expansionHeader =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `FloatingPanel`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
drawerToggle =
    default_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `FloatingPanel`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
drawerContainer =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `FloatingPanel`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
divider =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `FloatingPanel`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
dialogTrigger =
    default_core


{-| Place a `Dialog` in the `unnamed` slot of `FloatingPanel`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
dialog =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `FloatingPanel`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `FloatingPanel`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
datepickerToggle =
    default_core


{-| Place a `Datepicker` in the `unnamed` slot of `FloatingPanel`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
datepicker =
    default_core


{-| Place a `ContentPane` in the `unnamed` slot of `FloatingPanel`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
contentPane =
    default_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `FloatingPanel`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
suggestionChip =
    default_core


{-| Place a `InputChipSet` in the `unnamed` slot of `FloatingPanel`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
inputChipSet =
    default_core


{-| Place a `InputChip` in the `unnamed` slot of `FloatingPanel`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
inputChip =
    default_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `FloatingPanel`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
filterChipSet =
    default_core


{-| Place a `FilterChip` in the `unnamed` slot of `FloatingPanel`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
filterChip =
    default_core


{-| Place a `ChipSet` in the `unnamed` slot of `FloatingPanel`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
chipSet =
    default_core


{-| Place a `AssistChip` in the `unnamed` slot of `FloatingPanel`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
assistChip =
    default_core


{-| Place a `Chip` in the `unnamed` slot of `FloatingPanel`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
chip =
    default_core


{-| Place a `Checkbox` in the `unnamed` slot of `FloatingPanel`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
checkbox =
    default_core


{-| Place a `Card` in the `unnamed` slot of `FloatingPanel`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
card =
    default_core


{-| Place a `Calendar` in the `unnamed` slot of `FloatingPanel`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
calendar =
    default_core


{-| Place a `YearView` in the `unnamed` slot of `FloatingPanel`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
yearView =
    default_core


{-| Place a `MultiYearView` in the `unnamed` slot of `FloatingPanel`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
multiYearView =
    default_core


{-| Place a `MonthView` in the `unnamed` slot of `FloatingPanel`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
monthView =
    default_core


{-| Place a `Tooltip` in the `unnamed` slot of `FloatingPanel`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tooltip =
    default_core


{-| Place a `RichTooltip` in the `unnamed` slot of `FloatingPanel`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
richTooltip =
    default_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `FloatingPanel`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
tooltipElementBase =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `FloatingPanel`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
richTooltipAction =
    default_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `FloatingPanel`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
buttonGroup =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `FloatingPanel`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
iconButton =
    default_core


{-| Place a `Button` in the `unnamed` slot of `FloatingPanel`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
button =
    default_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `FloatingPanel`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
breadcrumb =
    default_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `FloatingPanel`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
breadcrumbItem =
    default_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `FloatingPanel`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
breadcrumbItemButton =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `FloatingPanel`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheet` in the `unnamed` slot of `FloatingPanel`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
bottomSheet =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `FloatingPanel`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
bottomSheetAction =
    default_core


{-| Place a `Badge` in the `unnamed` slot of `FloatingPanel`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
badge =
    default_core


{-| Place a `Avatar` in the `unnamed` slot of `FloatingPanel`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
avatar =
    default_core


{-| Place a `Autocomplete` in the `unnamed` slot of `FloatingPanel`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
autocomplete =
    default_core


{-| Place a `FormField` in the `unnamed` slot of `FloatingPanel`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
formField =
    default_core


{-| Place a `OptionPanel` in the `unnamed` slot of `FloatingPanel`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
optionPanel =
    default_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `FloatingPanel`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
floatingPanel =
    default_core


{-| Place a `Optgroup` in the `unnamed` slot of `FloatingPanel`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
optgroup =
    default_core


{-| Place a `Option` in the `unnamed` slot of `FloatingPanel`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
option =
    default_core


{-| Place a `FocusTrap` in the `unnamed` slot of `FloatingPanel`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
focusTrap =
    default_core


{-| Place a `AppBar` in the `unnamed` slot of `FloatingPanel`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
appBar =
    default_core


{-| Place a `TextOverflow` in the `unnamed` slot of `FloatingPanel`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
textOverflow =
    default_core


{-| Place a `TextHighlight` in the `unnamed` slot of `FloatingPanel`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
textHighlight =
    default_core


{-| Place a `StateLayer` in the `unnamed` slot of `FloatingPanel`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
stateLayer =
    default_core


{-| Place a `Slide` in the `unnamed` slot of `FloatingPanel`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
slide =
    default_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `FloatingPanel`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
scrollContainer =
    default_core


{-| Place a `Ripple` in the `unnamed` slot of `FloatingPanel`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
ripple =
    default_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `FloatingPanel`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
pseudoRadio =
    default_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `FloatingPanel`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
pseudoCheckbox =
    default_core


{-| Place a `FocusRing` in the `unnamed` slot of `FloatingPanel`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
focusRing =
    default_core


{-| Place a `Elevation` in the `unnamed` slot of `FloatingPanel`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
elevation =
    default_core


{-| Place a `Collapsible` in the `unnamed` slot of `FloatingPanel`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
collapsible =
    default_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `FloatingPanel`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
actionElementBase =
    default_core