module M3e.Build.TabPanel.Slots exposing
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
Slot setters for `M3e.Build.TabPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `TabPanel`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tree =
    default_core


{-| Place a `TreeItem` in the `unnamed` slot of `TabPanel`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
treeItem =
    default_core


{-| Place a `Toolbar` in the `unnamed` slot of `TabPanel`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toolbar =
    default_core


{-| Place a `Toc` in the `unnamed` slot of `TabPanel`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toc =
    default_core


{-| Place a `TocItem` in the `unnamed` slot of `TabPanel`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tocItem =
    default_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `TabPanel`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
themeIcon =
    default_core


{-| Place a `Theme` in the `unnamed` slot of `TabPanel`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
theme =
    default_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `TabPanel`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textareaAutosize =
    default_core


{-| Place a `Tabs` in the `unnamed` slot of `TabPanel`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabs =
    default_core


{-| Place a `TabPanel` in the `unnamed` slot of `TabPanel`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabPanel =
    default_core


{-| Place a `Tab` in the `unnamed` slot of `TabPanel`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tab =
    default_core


{-| Place a `Switch` in the `unnamed` slot of `TabPanel`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
switch =
    default_core


{-| Place a `StepperReset` in the `unnamed` slot of `TabPanel`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `TabPanel`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    default_core


{-| Place a `Step` in the `unnamed` slot of `TabPanel`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
step =
    default_core


{-| Place a `StepPanel` in the `unnamed` slot of `TabPanel`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepPanel =
    default_core


{-| Place a `Stepper` in the `unnamed` slot of `TabPanel`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepper =
    default_core


{-| Place a `SplitPane` in the `unnamed` slot of `TabPanel`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitPane =
    default_core


{-| Place a `SplitButton` in the `unnamed` slot of `TabPanel`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitButton =
    default_core


{-| Place a `Snackbar` in the `unnamed` slot of `TabPanel`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
snackbar =
    default_core


{-| Place a `Slider` in the `unnamed` slot of `TabPanel`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slider =
    default_core


{-| Place a `SliderThumb` in the `unnamed` slot of `TabPanel`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
sliderThumb =
    default_core


{-| Place a `SlideGroup` in the `unnamed` slot of `TabPanel`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slideGroup =
    default_core


{-| Place a `Skeleton` in the `unnamed` slot of `TabPanel`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
skeleton =
    default_core


{-| Place a `Shape` in the `unnamed` slot of `TabPanel`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
shape =
    default_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `TabPanel`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
segmentedButton =
    default_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `TabPanel`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonSegment =
    default_core


{-| Place a `SearchView` in the `unnamed` slot of `TabPanel`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchView =
    default_core


{-| Place a `SearchBar` in the `unnamed` slot of `TabPanel`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchBar =
    default_core


{-| Place a `RadioGroup` in the `unnamed` slot of `TabPanel`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radioGroup =
    default_core


{-| Place a `Radio` in the `unnamed` slot of `TabPanel`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radio =
    default_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `TabPanel`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
progressElementIndicatorBase =
    default_core


{-| Place a `Paginator` in the `unnamed` slot of `TabPanel`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
paginator =
    default_core


{-| Place a `Select` in the `unnamed` slot of `TabPanel`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
select =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `TabPanel`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    default_core


{-| Place a `NavRail` in the `unnamed` slot of `TabPanel`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRail =
    default_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `TabPanel`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenu` in the `unnamed` slot of `TabPanel`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenu =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `TabPanel`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItem =
    default_core


{-| Place a `NavBar` in the `unnamed` slot of `TabPanel`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navBar =
    default_core


{-| Place a `NavItem` in the `unnamed` slot of `TabPanel`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navItem =
    default_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `TabPanel`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `TabPanel`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `TabPanel`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemCheckbox =
    default_core


{-| Place a `Menu` in the `unnamed` slot of `TabPanel`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menu =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `TabPanel`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItem =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `TabPanel`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    default_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `TabPanel`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemElementBase =
    default_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `TabPanel`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
loadingIndicator =
    default_core


{-| Place a `SelectionList` in the `unnamed` slot of `TabPanel`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
selectionList =
    default_core


{-| Place a `ListOption` in the `unnamed` slot of `TabPanel`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listOption =
    default_core


{-| Place a `ActionList` in the `unnamed` slot of `TabPanel`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionList =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `TabPanel`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `TabPanel`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listAction =
    default_core


{-| Place a `ListItemButton` in the `unnamed` slot of `TabPanel`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItemButton =
    default_core


{-| Place a `List` in the `unnamed` slot of `TabPanel`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
list =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `TabPanel`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItem =
    default_core


{-| Place a `Icon` in the `unnamed` slot of `TabPanel`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
icon =
    default_core


{-| Place a `Heading` in the `unnamed` slot of `TabPanel`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
heading =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `TabPanel`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    default_core


{-| Place a `FabMenu` in the `unnamed` slot of `TabPanel`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenu =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `TabPanel`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fab =
    default_core


{-| Place a `Accordion` in the `unnamed` slot of `TabPanel`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
accordion =
    default_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `TabPanel`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionPanel =
    default_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `TabPanel`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionHeader =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `TabPanel`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    default_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `TabPanel`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerContainer =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `TabPanel`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
divider =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `TabPanel`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    default_core


{-| Place a `Dialog` in the `unnamed` slot of `TabPanel`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialog =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `TabPanel`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `TabPanel`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    default_core


{-| Place a `Datepicker` in the `unnamed` slot of `TabPanel`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepicker =
    default_core


{-| Place a `ContentPane` in the `unnamed` slot of `TabPanel`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
contentPane =
    default_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `TabPanel`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
suggestionChip =
    default_core


{-| Place a `InputChipSet` in the `unnamed` slot of `TabPanel`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    default_core


{-| Place a `InputChip` in the `unnamed` slot of `TabPanel`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChip =
    default_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `TabPanel`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChipSet =
    default_core


{-| Place a `FilterChip` in the `unnamed` slot of `TabPanel`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChip =
    default_core


{-| Place a `ChipSet` in the `unnamed` slot of `TabPanel`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chipSet =
    default_core


{-| Place a `AssistChip` in the `unnamed` slot of `TabPanel`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
assistChip =
    default_core


{-| Place a `Chip` in the `unnamed` slot of `TabPanel`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chip =
    default_core


{-| Place a `Checkbox` in the `unnamed` slot of `TabPanel`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
checkbox =
    default_core


{-| Place a `Card` in the `unnamed` slot of `TabPanel`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
card =
    default_core


{-| Place a `Calendar` in the `unnamed` slot of `TabPanel`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
calendar =
    default_core


{-| Place a `YearView` in the `unnamed` slot of `TabPanel`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
yearView =
    default_core


{-| Place a `MultiYearView` in the `unnamed` slot of `TabPanel`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
multiYearView =
    default_core


{-| Place a `MonthView` in the `unnamed` slot of `TabPanel`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
monthView =
    default_core


{-| Place a `Tooltip` in the `unnamed` slot of `TabPanel`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltip =
    default_core


{-| Place a `RichTooltip` in the `unnamed` slot of `TabPanel`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltip =
    default_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `TabPanel`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltipElementBase =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `TabPanel`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    default_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `TabPanel`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonGroup =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `TabPanel`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
iconButton =
    default_core


{-| Place a `Button` in the `unnamed` slot of `TabPanel`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
button =
    default_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `TabPanel`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumb =
    default_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `TabPanel`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItem =
    default_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `TabPanel`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItemButton =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `TabPanel`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheet` in the `unnamed` slot of `TabPanel`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheet =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `TabPanel`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    default_core


{-| Place a `Badge` in the `unnamed` slot of `TabPanel`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
badge =
    default_core


{-| Place a `Avatar` in the `unnamed` slot of `TabPanel`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
avatar =
    default_core


{-| Place a `Autocomplete` in the `unnamed` slot of `TabPanel`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
autocomplete =
    default_core


{-| Place a `FormField` in the `unnamed` slot of `TabPanel`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
formField =
    default_core


{-| Place a `OptionPanel` in the `unnamed` slot of `TabPanel`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optionPanel =
    default_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `TabPanel`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
floatingPanel =
    default_core


{-| Place a `Optgroup` in the `unnamed` slot of `TabPanel`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optgroup =
    default_core


{-| Place a `Option` in the `unnamed` slot of `TabPanel`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
option =
    default_core


{-| Place a `FocusTrap` in the `unnamed` slot of `TabPanel`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusTrap =
    default_core


{-| Place a `AppBar` in the `unnamed` slot of `TabPanel`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
appBar =
    default_core


{-| Place a `TextOverflow` in the `unnamed` slot of `TabPanel`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textOverflow =
    default_core


{-| Place a `TextHighlight` in the `unnamed` slot of `TabPanel`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textHighlight =
    default_core


{-| Place a `StateLayer` in the `unnamed` slot of `TabPanel`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stateLayer =
    default_core


{-| Place a `Slide` in the `unnamed` slot of `TabPanel`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slide =
    default_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `TabPanel`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
scrollContainer =
    default_core


{-| Place a `Ripple` in the `unnamed` slot of `TabPanel`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
ripple =
    default_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `TabPanel`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoRadio =
    default_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `TabPanel`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoCheckbox =
    default_core


{-| Place a `FocusRing` in the `unnamed` slot of `TabPanel`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusRing =
    default_core


{-| Place a `Elevation` in the `unnamed` slot of `TabPanel`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
elevation =
    default_core


{-| Place a `Collapsible` in the `unnamed` slot of `TabPanel`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
collapsible =
    default_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `TabPanel`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.TabPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionElementBase =
    default_core