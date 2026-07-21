module M3e exposing
    ( accordion, actionList, appBar, assistChip, autocomplete, avatar, badge, bottomSheet, bottomSheetAction, bottomSheetTrigger, breadcrumb, breadcrumbItem, breadcrumbItemButton, button, buttonGroup, buttonSegment, calendar, card, checkbox, chip, chipSet, circularProgressIndicator, collapsible, contentPane, datepicker, datepickerToggle, dialog, dialogAction, dialogTrigger, divider, drawerContainer, drawerToggle, elevation, expandableListItem, expansionHeader, expansionPanel, fab, fabMenu, fabMenuItem, fabMenuTrigger, filterChip, filterChipSet, floatingPanel, focusRing, focusTrap, formField, heading, icon, iconButton, inputChip, inputChipSet, linearProgressIndicator, list, listAction, listItem, listItemButton, listOption, loadingIndicator, menu, menuItem, menuItemCheckbox, menuItemGroup, menuItemRadio, menuTrigger, monthView, multiYearView, navBar, navItem, navMenu, navMenuItem, navMenuItemGroup, navRail, navRailToggle, optgroup, option, optionPanel, paginator, pseudoCheckbox, pseudoRadio, radio, radioGroup, richTooltip, richTooltipAction, ripple, scrollContainer, searchBar, searchView, segmentedButton, select, selectionList, shape, skeleton, slide, slideGroup, slider, sliderThumb, snackbar, splitButton, splitPane, stateLayer, step, stepPanel, stepper, stepperNext, stepperPrevious, stepperReset, suggestionChip, switch, tab, tabPanel, tabs, textHighlight, textOverflow, textareaAutosize, theme, themeIcon, toc, tocItem, toolbar, tooltip, tree, treeItem, yearView
    , text
    )

{-| The general surface: every component constructor in the elm/html call
shape, one import. Signatures reference each component's aliases — reach for
`M3e.<Component>` when you want the strict per-component surface (required
content, builder, narrowed values), and `M3e.Attributes` / `M3e.Events` /
`M3e.Values` for the shared vocabulary.

@docs accordion, actionList, appBar, assistChip, autocomplete, avatar, badge, bottomSheet, bottomSheetAction, bottomSheetTrigger, breadcrumb, breadcrumbItem, breadcrumbItemButton, button, buttonGroup, buttonSegment, calendar, card, checkbox, chip, chipSet, circularProgressIndicator, collapsible, contentPane, datepicker, datepickerToggle, dialog, dialogAction, dialogTrigger, divider, drawerContainer, drawerToggle, elevation, expandableListItem, expansionHeader, expansionPanel, fab, fabMenu, fabMenuItem, fabMenuTrigger, filterChip, filterChipSet, floatingPanel, focusRing, focusTrap, formField, heading, icon, iconButton, inputChip, inputChipSet, linearProgressIndicator, list, listAction, listItem, listItemButton, listOption, loadingIndicator, menu, menuItem, menuItemCheckbox, menuItemGroup, menuItemRadio, menuTrigger, monthView, multiYearView, navBar, navItem, navMenu, navMenuItem, navMenuItemGroup, navRail, navRailToggle, optgroup, option, optionPanel, paginator, pseudoCheckbox, pseudoRadio, radio, radioGroup, richTooltip, richTooltipAction, ripple, scrollContainer, searchBar, searchView, segmentedButton, select, selectionList, shape, skeleton, slide, slideGroup, slider, sliderThumb, snackbar, splitButton, splitPane, stateLayer, step, stepPanel, stepper, stepperNext, stepperPrevious, stepperReset, suggestionChip, switch, tab, tabPanel, tabs, textHighlight, textOverflow, textareaAutosize, theme, themeIcon, toc, tocItem, toolbar, tooltip, tree, treeItem, yearView
@docs text

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared)
import M3e.Accordion
import M3e.ActionList
import M3e.AppBar
import M3e.AssistChip
import M3e.Autocomplete
import M3e.Avatar
import M3e.Badge
import M3e.BottomSheet
import M3e.BottomSheetAction
import M3e.BottomSheetTrigger
import M3e.Breadcrumb
import M3e.BreadcrumbItem
import M3e.BreadcrumbItemButton
import M3e.Button
import M3e.ButtonGroup
import M3e.ButtonSegment
import M3e.Calendar
import M3e.Card
import M3e.Checkbox
import M3e.Chip
import M3e.ChipSet
import M3e.CircularProgressIndicator
import M3e.Collapsible
import M3e.ContentPane
import M3e.Datepicker
import M3e.DatepickerToggle
import M3e.Dialog
import M3e.DialogAction
import M3e.DialogTrigger
import M3e.Divider
import M3e.DrawerContainer
import M3e.DrawerToggle
import M3e.Elevation
import M3e.ExpandableListItem
import M3e.ExpansionHeader
import M3e.ExpansionPanel
import M3e.Fab
import M3e.FabMenu
import M3e.FabMenuItem
import M3e.FabMenuTrigger
import M3e.FilterChip
import M3e.FilterChipSet
import M3e.FloatingPanel
import M3e.FocusRing
import M3e.FocusTrap
import M3e.FormField
import M3e.Heading
import M3e.Icon
import M3e.IconButton
import M3e.InputChip
import M3e.InputChipSet
import M3e.LinearProgressIndicator
import M3e.List
import M3e.ListAction
import M3e.ListItem
import M3e.ListItemButton
import M3e.ListOption
import M3e.LoadingIndicator
import M3e.Menu
import M3e.MenuItem
import M3e.MenuItemCheckbox
import M3e.MenuItemGroup
import M3e.MenuItemRadio
import M3e.MenuTrigger
import M3e.MonthView
import M3e.MultiYearView
import M3e.NavBar
import M3e.NavItem
import M3e.NavMenu
import M3e.NavMenuItem
import M3e.NavMenuItemGroup
import M3e.NavRail
import M3e.NavRailToggle
import M3e.Optgroup
import M3e.Option
import M3e.OptionPanel
import M3e.Paginator
import M3e.PseudoCheckbox
import M3e.PseudoRadio
import M3e.Radio
import M3e.RadioGroup
import M3e.RichTooltip
import M3e.RichTooltipAction
import M3e.Ripple
import M3e.ScrollContainer
import M3e.SearchBar
import M3e.SearchView
import M3e.SegmentedButton
import M3e.Select
import M3e.SelectionList
import M3e.Shape
import M3e.Skeleton
import M3e.Slide
import M3e.SlideGroup
import M3e.Slider
import M3e.SliderThumb
import M3e.Snackbar
import M3e.SplitButton
import M3e.SplitPane
import M3e.StateLayer
import M3e.Step
import M3e.StepPanel
import M3e.Stepper
import M3e.StepperNext
import M3e.StepperPrevious
import M3e.StepperReset
import M3e.SuggestionChip
import M3e.Switch
import M3e.Tab
import M3e.TabPanel
import M3e.Tabs
import M3e.TextHighlight
import M3e.TextOverflow
import M3e.TextareaAutosize
import M3e.Theme
import M3e.ThemeIcon
import M3e.Toc
import M3e.TocItem
import M3e.Toolbar
import M3e.Tooltip
import M3e.Tree
import M3e.TreeItem
import M3e.YearView


{-| See `M3e.Accordion.view`.
-}
accordion :
    List (Attr M3e.Accordion.Attrs msg)
    -> List (Element M3e.Accordion.Content (M3e.Accordion.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Accordion.Is s) admittedBy msg
accordion =
    M3e.Accordion.view


{-| See `M3e.ActionList.view`.
-}
actionList :
    List (Attr M3e.ActionList.Attrs msg)
    -> List (Element M3e.ActionList.Content (M3e.ActionList.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ActionList.Is s) admittedBy msg
actionList =
    M3e.ActionList.view


{-| See `M3e.AppBar.view`.
-}
appBar :
    List (Attr M3e.AppBar.Attrs msg)
    -> List (Element childAccepts (M3e.AppBar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.AppBar.Is s) admittedBy msg
appBar =
    M3e.AppBar.view


{-| See `M3e.AssistChip.view`.
-}
assistChip :
    List (Attr M3e.AssistChip.Attrs msg)
    -> List (Element M3e.AssistChip.Content (M3e.AssistChip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.AssistChip.Is s) admittedBy msg
assistChip =
    M3e.AssistChip.view


{-| See `M3e.Autocomplete.view`.
-}
autocomplete :
    List (Attr M3e.Autocomplete.Attrs msg)
    -> List (Element M3e.Autocomplete.Content (M3e.Autocomplete.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Autocomplete.Is s) admittedBy msg
autocomplete =
    M3e.Autocomplete.view


{-| See `M3e.Avatar.view`.
-}
avatar :
    List (Attr M3e.Avatar.Attrs msg)
    -> List (Element childAccepts (M3e.Avatar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Avatar.Is s) admittedBy msg
avatar =
    M3e.Avatar.view


{-| See `M3e.Badge.view`.
-}
badge :
    List (Attr M3e.Badge.Attrs msg)
    -> List (Element M3e.Badge.Content (M3e.Badge.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Badge.Is s) admittedBy msg
badge =
    M3e.Badge.view


{-| See `M3e.BottomSheet.view`.
-}
bottomSheet :
    List (Attr M3e.BottomSheet.Attrs msg)
    -> List (Element childAccepts (M3e.BottomSheet.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.BottomSheet.Is s) admittedBy msg
bottomSheet =
    M3e.BottomSheet.view


{-| See `M3e.BottomSheetAction.view`.
-}
bottomSheetAction :
    List (Attr M3e.BottomSheetAction.Attrs msg)
    -> List (Element M3e.BottomSheetAction.Content (M3e.BottomSheetAction.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.BottomSheetAction.Is s) admittedBy msg
bottomSheetAction =
    M3e.BottomSheetAction.view


{-| See `M3e.BottomSheetTrigger.view`.
-}
bottomSheetTrigger :
    List (Attr M3e.BottomSheetTrigger.Attrs msg)
    -> List (Element M3e.BottomSheetTrigger.Content (M3e.BottomSheetTrigger.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.BottomSheetTrigger.Is s) admittedBy msg
bottomSheetTrigger =
    M3e.BottomSheetTrigger.view


{-| See `M3e.Breadcrumb.view`.
-}
breadcrumb :
    List (Attr M3e.Breadcrumb.Attrs msg)
    -> List (Element M3e.Breadcrumb.Content (M3e.Breadcrumb.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Breadcrumb.Is s) admittedBy msg
breadcrumb =
    M3e.Breadcrumb.view


{-| See `M3e.BreadcrumbItem.view`.
-}
breadcrumbItem :
    List (Attr M3e.BreadcrumbItem.Attrs msg)
    -> List (Element M3e.BreadcrumbItem.Content (M3e.BreadcrumbItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.BreadcrumbItem.Is s) admittedBy msg
breadcrumbItem =
    M3e.BreadcrumbItem.view


{-| See `M3e.BreadcrumbItemButton.view`.
-}
breadcrumbItemButton :
    List (Attr M3e.BreadcrumbItemButton.Attrs msg)
    -> List (Element M3e.BreadcrumbItemButton.Content (M3e.BreadcrumbItemButton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.BreadcrumbItemButton.Is s) admittedBy msg
breadcrumbItemButton =
    M3e.BreadcrumbItemButton.view


{-| See `M3e.Button.view`.
-}
button :
    List (Attr M3e.Button.Attrs msg)
    -> List (Element M3e.Button.Content (M3e.Button.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Button.Is s) admittedBy msg
button =
    M3e.Button.view


{-| See `M3e.ButtonGroup.view`.
-}
buttonGroup :
    List (Attr M3e.ButtonGroup.Attrs msg)
    -> List (Element M3e.ButtonGroup.Content (M3e.ButtonGroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ButtonGroup.Is s) admittedBy msg
buttonGroup =
    M3e.ButtonGroup.view


{-| See `M3e.ButtonSegment.view`.
-}
buttonSegment :
    List (Attr M3e.ButtonSegment.Attrs msg)
    -> List (Element M3e.ButtonSegment.Content (M3e.ButtonSegment.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ButtonSegment.Is s) admittedBy msg
buttonSegment =
    M3e.ButtonSegment.view


{-| See `M3e.Calendar.view`.
-}
calendar :
    List (Attr M3e.Calendar.Attrs msg)
    -> List (Element childAccepts (M3e.Calendar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Calendar.Is s) admittedBy msg
calendar =
    M3e.Calendar.view


{-| See `M3e.Card.view`.
-}
card :
    List (Attr M3e.Card.Attrs msg)
    -> List (Element childAccepts (M3e.Card.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Card.Is s) admittedBy msg
card =
    M3e.Card.view


{-| See `M3e.Checkbox.view`.
-}
checkbox :
    List (Attr M3e.Checkbox.Attrs msg)
    -> List (Element childAccepts (M3e.Checkbox.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Checkbox.Is s) admittedBy msg
checkbox =
    M3e.Checkbox.view


{-| See `M3e.Chip.view`.
-}
chip :
    List (Attr M3e.Chip.Attrs msg)
    -> List (Element M3e.Chip.Content (M3e.Chip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Chip.Is s) admittedBy msg
chip =
    M3e.Chip.view


{-| See `M3e.ChipSet.view`.
-}
chipSet :
    List (Attr M3e.ChipSet.Attrs msg)
    -> List (Element M3e.ChipSet.Content (M3e.ChipSet.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ChipSet.Is s) admittedBy msg
chipSet =
    M3e.ChipSet.view


{-| See `M3e.CircularProgressIndicator.view`.
-}
circularProgressIndicator :
    List (Attr M3e.CircularProgressIndicator.Attrs msg)
    -> List (Element childAccepts (M3e.CircularProgressIndicator.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.CircularProgressIndicator.Is s) admittedBy msg
circularProgressIndicator =
    M3e.CircularProgressIndicator.view


{-| See `M3e.Collapsible.view`.
-}
collapsible :
    List (Attr M3e.Collapsible.Attrs msg)
    -> List (Element childAccepts (M3e.Collapsible.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Collapsible.Is s) admittedBy msg
collapsible =
    M3e.Collapsible.view


{-| See `M3e.ContentPane.view`.
-}
contentPane :
    List (Attr M3e.ContentPane.Attrs msg)
    -> List (Element childAccepts (M3e.ContentPane.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ContentPane.Is s) admittedBy msg
contentPane =
    M3e.ContentPane.view


{-| See `M3e.Datepicker.view`.
-}
datepicker :
    List (Attr M3e.Datepicker.Attrs msg)
    -> List (Element childAccepts (M3e.Datepicker.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Datepicker.Is s) admittedBy msg
datepicker =
    M3e.Datepicker.view


{-| See `M3e.DatepickerToggle.view`.
-}
datepickerToggle :
    List (Attr M3e.DatepickerToggle.Attrs msg)
    -> List (Element childAccepts (M3e.DatepickerToggle.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.DatepickerToggle.Is s) admittedBy msg
datepickerToggle =
    M3e.DatepickerToggle.view


{-| See `M3e.Dialog.view`.
-}
dialog :
    List (Attr M3e.Dialog.Attrs msg)
    -> List (Element childAccepts (M3e.Dialog.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Dialog.Is s) admittedBy msg
dialog =
    M3e.Dialog.view


{-| See `M3e.DialogAction.view`.
-}
dialogAction :
    List (Attr M3e.DialogAction.Attrs msg)
    -> List (Element childAccepts (M3e.DialogAction.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.DialogAction.Is s) admittedBy msg
dialogAction =
    M3e.DialogAction.view


{-| See `M3e.DialogTrigger.view`.
-}
dialogTrigger :
    List (Attr M3e.DialogTrigger.Attrs msg)
    -> List (Element childAccepts (M3e.DialogTrigger.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.DialogTrigger.Is s) admittedBy msg
dialogTrigger =
    M3e.DialogTrigger.view


{-| See `M3e.Divider.view`.
-}
divider :
    List (Attr M3e.Divider.Attrs msg)
    -> List (Element childAccepts (M3e.Divider.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Divider.Is s) admittedBy msg
divider =
    M3e.Divider.view


{-| See `M3e.DrawerContainer.view`.
-}
drawerContainer :
    List (Attr M3e.DrawerContainer.Attrs msg)
    -> List (Element childAccepts (M3e.DrawerContainer.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.DrawerContainer.Is s) admittedBy msg
drawerContainer =
    M3e.DrawerContainer.view


{-| See `M3e.DrawerToggle.view`.
-}
drawerToggle :
    List (Attr M3e.DrawerToggle.Attrs msg)
    -> List (Element childAccepts (M3e.DrawerToggle.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.DrawerToggle.Is s) admittedBy msg
drawerToggle =
    M3e.DrawerToggle.view


{-| See `M3e.Elevation.view`.
-}
elevation :
    List (Attr M3e.Elevation.Attrs msg)
    -> List (Element childAccepts (M3e.Elevation.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Elevation.Is s) admittedBy msg
elevation =
    M3e.Elevation.view


{-| See `M3e.ExpandableListItem.view`.
-}
expandableListItem :
    List (Attr M3e.ExpandableListItem.Attrs msg)
    -> List (Element M3e.ExpandableListItem.Content (M3e.ExpandableListItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ExpandableListItem.Is s) admittedBy msg
expandableListItem =
    M3e.ExpandableListItem.view


{-| See `M3e.ExpansionHeader.view`.
-}
expansionHeader :
    List (Attr M3e.ExpansionHeader.Attrs msg)
    -> List (Element M3e.ExpansionHeader.Content (M3e.ExpansionHeader.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ExpansionHeader.Is s) admittedBy msg
expansionHeader =
    M3e.ExpansionHeader.view


{-| See `M3e.ExpansionPanel.view`.
-}
expansionPanel :
    List (Attr M3e.ExpansionPanel.Attrs msg)
    -> List (Element childAccepts (M3e.ExpansionPanel.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ExpansionPanel.Is s) admittedBy msg
expansionPanel =
    M3e.ExpansionPanel.view


{-| See `M3e.Fab.view`.
-}
fab :
    List (Attr M3e.Fab.Attrs msg)
    -> List (Element M3e.Fab.Content (M3e.Fab.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Fab.Is s) admittedBy msg
fab =
    M3e.Fab.view


{-| See `M3e.FabMenu.view`.
-}
fabMenu :
    List (Attr M3e.FabMenu.Attrs msg)
    -> List (Element M3e.FabMenu.Content (M3e.FabMenu.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FabMenu.Is s) admittedBy msg
fabMenu =
    M3e.FabMenu.view


{-| See `M3e.FabMenuItem.view`.
-}
fabMenuItem :
    List (Attr M3e.FabMenuItem.Attrs msg)
    -> List (Element childAccepts (M3e.FabMenuItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FabMenuItem.Is s) admittedBy msg
fabMenuItem =
    M3e.FabMenuItem.view


{-| See `M3e.FabMenuTrigger.view`.
-}
fabMenuTrigger :
    List (Attr M3e.FabMenuTrigger.Attrs msg)
    -> List (Element childAccepts (M3e.FabMenuTrigger.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FabMenuTrigger.Is s) admittedBy msg
fabMenuTrigger =
    M3e.FabMenuTrigger.view


{-| See `M3e.FilterChip.view`.
-}
filterChip :
    List (Attr M3e.FilterChip.Attrs msg)
    -> List (Element M3e.FilterChip.Content (M3e.FilterChip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FilterChip.Is s) admittedBy msg
filterChip =
    M3e.FilterChip.view


{-| See `M3e.FilterChipSet.view`.
-}
filterChipSet :
    List (Attr M3e.FilterChipSet.Attrs msg)
    -> List (Element M3e.FilterChipSet.Content (M3e.FilterChipSet.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FilterChipSet.Is s) admittedBy msg
filterChipSet =
    M3e.FilterChipSet.view


{-| See `M3e.FloatingPanel.view`.
-}
floatingPanel :
    List (Attr M3e.FloatingPanel.Attrs msg)
    -> List (Element childAccepts (M3e.FloatingPanel.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FloatingPanel.Is s) admittedBy msg
floatingPanel =
    M3e.FloatingPanel.view


{-| See `M3e.FocusRing.view`.
-}
focusRing :
    List (Attr M3e.FocusRing.Attrs msg)
    -> List (Element childAccepts (M3e.FocusRing.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FocusRing.Is s) admittedBy msg
focusRing =
    M3e.FocusRing.view


{-| See `M3e.FocusTrap.view`.
-}
focusTrap :
    List (Attr M3e.FocusTrap.Attrs msg)
    -> List (Element childAccepts (M3e.FocusTrap.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FocusTrap.Is s) admittedBy msg
focusTrap =
    M3e.FocusTrap.view


{-| See `M3e.FormField.view`.
-}
formField :
    List (Attr M3e.FormField.Attrs msg)
    -> List (Element childAccepts (M3e.FormField.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.FormField.Is s) admittedBy msg
formField =
    M3e.FormField.view


{-| See `M3e.Heading.view`.
-}
heading :
    List (Attr M3e.Heading.Attrs msg)
    -> List (Element M3e.Heading.Content (M3e.Heading.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Heading.Is s) admittedBy msg
heading =
    M3e.Heading.view


{-| See `M3e.Icon.view`.
-}
icon :
    List (Attr M3e.Icon.Attrs msg)
    -> List (Element childAccepts (M3e.Icon.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Icon.Is s) admittedBy msg
icon =
    M3e.Icon.view


{-| See `M3e.IconButton.view`.
-}
iconButton :
    List (Attr M3e.IconButton.Attrs msg)
    -> List (Element M3e.IconButton.Content (M3e.IconButton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.IconButton.Is s) admittedBy msg
iconButton =
    M3e.IconButton.view


{-| See `M3e.InputChip.view`.
-}
inputChip :
    List (Attr M3e.InputChip.Attrs msg)
    -> List (Element M3e.InputChip.Content (M3e.InputChip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.InputChip.Is s) admittedBy msg
inputChip =
    M3e.InputChip.view


{-| See `M3e.InputChipSet.view`.
-}
inputChipSet :
    List (Attr M3e.InputChipSet.Attrs msg)
    -> List (Element M3e.InputChipSet.Content (M3e.InputChipSet.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.InputChipSet.Is s) admittedBy msg
inputChipSet =
    M3e.InputChipSet.view


{-| See `M3e.LinearProgressIndicator.view`.
-}
linearProgressIndicator :
    List (Attr M3e.LinearProgressIndicator.Attrs msg)
    -> List (Element childAccepts (M3e.LinearProgressIndicator.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.LinearProgressIndicator.Is s) admittedBy msg
linearProgressIndicator =
    M3e.LinearProgressIndicator.view


{-| See `M3e.List.view`.
-}
list :
    List (Attr M3e.List.Attrs msg)
    -> List (Element M3e.List.Content (M3e.List.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.List.Is s) admittedBy msg
list =
    M3e.List.view


{-| See `M3e.ListAction.view`.
-}
listAction :
    List (Attr M3e.ListAction.Attrs msg)
    -> List (Element M3e.ListAction.Content (M3e.ListAction.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ListAction.Is s) admittedBy msg
listAction =
    M3e.ListAction.view


{-| See `M3e.ListItem.view`.
-}
listItem :
    List (Attr M3e.ListItem.Attrs msg)
    -> List (Element M3e.ListItem.Content (M3e.ListItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ListItem.Is s) admittedBy msg
listItem =
    M3e.ListItem.view


{-| See `M3e.ListItemButton.view`.
-}
listItemButton :
    List (Attr M3e.ListItemButton.Attrs msg)
    -> List (Element M3e.ListItemButton.Content (M3e.ListItemButton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ListItemButton.Is s) admittedBy msg
listItemButton =
    M3e.ListItemButton.view


{-| See `M3e.ListOption.view`.
-}
listOption :
    List (Attr M3e.ListOption.Attrs msg)
    -> List (Element M3e.ListOption.Content (M3e.ListOption.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ListOption.Is s) admittedBy msg
listOption =
    M3e.ListOption.view


{-| See `M3e.LoadingIndicator.view`.
-}
loadingIndicator :
    List (Attr M3e.LoadingIndicator.Attrs msg)
    -> List (Element childAccepts (M3e.LoadingIndicator.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.LoadingIndicator.Is s) admittedBy msg
loadingIndicator =
    M3e.LoadingIndicator.view


{-| See `M3e.Menu.view`.
-}
menu :
    List (Attr M3e.Menu.Attrs msg)
    -> List (Element M3e.Menu.Content (M3e.Menu.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Menu.Is s) admittedBy msg
menu =
    M3e.Menu.view


{-| See `M3e.MenuItem.view`.
-}
menuItem :
    List (Attr M3e.MenuItem.Attrs msg)
    -> List (Element M3e.MenuItem.Content (M3e.MenuItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MenuItem.Is s) admittedBy msg
menuItem =
    M3e.MenuItem.view


{-| See `M3e.MenuItemCheckbox.view`.
-}
menuItemCheckbox :
    List (Attr M3e.MenuItemCheckbox.Attrs msg)
    -> List (Element M3e.MenuItemCheckbox.Content (M3e.MenuItemCheckbox.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MenuItemCheckbox.Is s) admittedBy msg
menuItemCheckbox =
    M3e.MenuItemCheckbox.view


{-| See `M3e.MenuItemGroup.view`.
-}
menuItemGroup :
    List (Attr M3e.MenuItemGroup.Attrs msg)
    -> List (Element M3e.MenuItemGroup.Content (M3e.MenuItemGroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MenuItemGroup.Is s) admittedBy msg
menuItemGroup =
    M3e.MenuItemGroup.view


{-| See `M3e.MenuItemRadio.view`.
-}
menuItemRadio :
    List (Attr M3e.MenuItemRadio.Attrs msg)
    -> List (Element M3e.MenuItemRadio.Content (M3e.MenuItemRadio.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MenuItemRadio.Is s) admittedBy msg
menuItemRadio =
    M3e.MenuItemRadio.view


{-| See `M3e.MenuTrigger.view`.
-}
menuTrigger :
    List (Attr M3e.MenuTrigger.Attrs msg)
    -> List (Element childAccepts (M3e.MenuTrigger.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MenuTrigger.Is s) admittedBy msg
menuTrigger =
    M3e.MenuTrigger.view


{-| See `M3e.MonthView.view`.
-}
monthView :
    List (Attr M3e.MonthView.Attrs msg)
    -> List (Element childAccepts (M3e.MonthView.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MonthView.Is s) admittedBy msg
monthView =
    M3e.MonthView.view


{-| See `M3e.MultiYearView.view`.
-}
multiYearView :
    List (Attr M3e.MultiYearView.Attrs msg)
    -> List (Element childAccepts (M3e.MultiYearView.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.MultiYearView.Is s) admittedBy msg
multiYearView =
    M3e.MultiYearView.view


{-| See `M3e.NavBar.view`.
-}
navBar :
    List (Attr M3e.NavBar.Attrs msg)
    -> List (Element M3e.NavBar.Content (M3e.NavBar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavBar.Is s) admittedBy msg
navBar =
    M3e.NavBar.view


{-| See `M3e.NavItem.view`.
-}
navItem :
    List (Attr M3e.NavItem.Attrs msg)
    -> List (Element M3e.NavItem.Content (M3e.NavItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavItem.Is s) admittedBy msg
navItem =
    M3e.NavItem.view


{-| See `M3e.NavMenu.view`.
-}
navMenu :
    List (Attr M3e.NavMenu.Attrs msg)
    -> List (Element M3e.NavMenu.Content (M3e.NavMenu.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavMenu.Is s) admittedBy msg
navMenu =
    M3e.NavMenu.view


{-| See `M3e.NavMenuItem.view`.
-}
navMenuItem :
    List (Attr M3e.NavMenuItem.Attrs msg)
    -> List (Element M3e.NavMenuItem.Content (M3e.NavMenuItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavMenuItem.Is s) admittedBy msg
navMenuItem =
    M3e.NavMenuItem.view


{-| See `M3e.NavMenuItemGroup.view`.
-}
navMenuItemGroup :
    List (Attr M3e.NavMenuItemGroup.Attrs msg)
    -> List (Element M3e.NavMenuItemGroup.Content (M3e.NavMenuItemGroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavMenuItemGroup.Is s) admittedBy msg
navMenuItemGroup =
    M3e.NavMenuItemGroup.view


{-| See `M3e.NavRail.view`.
-}
navRail :
    List (Attr M3e.NavRail.Attrs msg)
    -> List (Element M3e.NavRail.Content (M3e.NavRail.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavRail.Is s) admittedBy msg
navRail =
    M3e.NavRail.view


{-| See `M3e.NavRailToggle.view`.
-}
navRailToggle :
    List (Attr M3e.NavRailToggle.Attrs msg)
    -> List (Element childAccepts (M3e.NavRailToggle.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.NavRailToggle.Is s) admittedBy msg
navRailToggle =
    M3e.NavRailToggle.view


{-| See `M3e.Optgroup.view`.
-}
optgroup :
    List (Attr M3e.Optgroup.Attrs msg)
    -> List (Element M3e.Optgroup.Content (M3e.Optgroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Optgroup.Is s) admittedBy msg
optgroup =
    M3e.Optgroup.view


{-| See `M3e.Option.view`.
-}
option :
    List (Attr M3e.Option.Attrs msg)
    -> List (Element M3e.Option.Content (M3e.Option.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Option.Is s) admittedBy msg
option =
    M3e.Option.view


{-| See `M3e.OptionPanel.view`.
-}
optionPanel :
    List (Attr M3e.OptionPanel.Attrs msg)
    -> List (Element M3e.OptionPanel.Content (M3e.OptionPanel.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.OptionPanel.Is s) admittedBy msg
optionPanel =
    M3e.OptionPanel.view


{-| See `M3e.Paginator.view`.
-}
paginator :
    List (Attr M3e.Paginator.Attrs msg)
    -> List (Element childAccepts (M3e.Paginator.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Paginator.Is s) admittedBy msg
paginator =
    M3e.Paginator.view


{-| See `M3e.PseudoCheckbox.view`.
-}
pseudoCheckbox :
    List (Attr M3e.PseudoCheckbox.Attrs msg)
    -> List (Element childAccepts (M3e.PseudoCheckbox.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.PseudoCheckbox.Is s) admittedBy msg
pseudoCheckbox =
    M3e.PseudoCheckbox.view


{-| See `M3e.PseudoRadio.view`.
-}
pseudoRadio :
    List (Attr M3e.PseudoRadio.Attrs msg)
    -> List (Element childAccepts (M3e.PseudoRadio.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.PseudoRadio.Is s) admittedBy msg
pseudoRadio =
    M3e.PseudoRadio.view


{-| See `M3e.Radio.view`.
-}
radio :
    List (Attr M3e.Radio.Attrs msg)
    -> List (Element childAccepts (M3e.Radio.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Radio.Is s) admittedBy msg
radio =
    M3e.Radio.view


{-| See `M3e.RadioGroup.view`.
-}
radioGroup :
    List (Attr M3e.RadioGroup.Attrs msg)
    -> List (Element childAccepts (M3e.RadioGroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.RadioGroup.Is s) admittedBy msg
radioGroup =
    M3e.RadioGroup.view


{-| See `M3e.RichTooltip.view`.
-}
richTooltip :
    List (Attr M3e.RichTooltip.Attrs msg)
    -> List (Element M3e.RichTooltip.Content (M3e.RichTooltip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.RichTooltip.Is s) admittedBy msg
richTooltip =
    M3e.RichTooltip.view


{-| See `M3e.RichTooltipAction.view`.
-}
richTooltipAction :
    List (Attr M3e.RichTooltipAction.Attrs msg)
    -> List (Element M3e.RichTooltipAction.Content (M3e.RichTooltipAction.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.RichTooltipAction.Is s) admittedBy msg
richTooltipAction =
    M3e.RichTooltipAction.view


{-| See `M3e.Ripple.view`.
-}
ripple :
    List (Attr M3e.Ripple.Attrs msg)
    -> List (Element childAccepts (M3e.Ripple.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Ripple.Is s) admittedBy msg
ripple =
    M3e.Ripple.view


{-| See `M3e.ScrollContainer.view`.
-}
scrollContainer :
    List (Attr M3e.ScrollContainer.Attrs msg)
    -> List (Element childAccepts (M3e.ScrollContainer.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ScrollContainer.Is s) admittedBy msg
scrollContainer =
    M3e.ScrollContainer.view


{-| See `M3e.SearchBar.view`.
-}
searchBar :
    List (Attr M3e.SearchBar.Attrs msg)
    -> List (Element childAccepts (M3e.SearchBar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SearchBar.Is s) admittedBy msg
searchBar =
    M3e.SearchBar.view


{-| See `M3e.SearchView.view`.
-}
searchView :
    List (Attr M3e.SearchView.Attrs msg)
    -> List (Element childAccepts (M3e.SearchView.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SearchView.Is s) admittedBy msg
searchView =
    M3e.SearchView.view


{-| See `M3e.SegmentedButton.view`.
-}
segmentedButton :
    List (Attr M3e.SegmentedButton.Attrs msg)
    -> List (Element M3e.SegmentedButton.Content (M3e.SegmentedButton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SegmentedButton.Is s) admittedBy msg
segmentedButton =
    M3e.SegmentedButton.view


{-| See `M3e.Select.view`.
-}
select :
    List (Attr M3e.Select.Attrs msg)
    -> List (Element M3e.Select.Content (M3e.Select.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Select.Is s) admittedBy msg
select =
    M3e.Select.view


{-| See `M3e.SelectionList.view`.
-}
selectionList :
    List (Attr M3e.SelectionList.Attrs msg)
    -> List (Element M3e.SelectionList.Content (M3e.SelectionList.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SelectionList.Is s) admittedBy msg
selectionList =
    M3e.SelectionList.view


{-| See `M3e.Shape.view`.
-}
shape :
    List (Attr M3e.Shape.Attrs msg)
    -> List (Element childAccepts (M3e.Shape.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Shape.Is s) admittedBy msg
shape =
    M3e.Shape.view


{-| See `M3e.Skeleton.view`.
-}
skeleton :
    List (Attr M3e.Skeleton.Attrs msg)
    -> List (Element childAccepts (M3e.Skeleton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Skeleton.Is s) admittedBy msg
skeleton =
    M3e.Skeleton.view


{-| See `M3e.Slide.view`.
-}
slide :
    List (Attr M3e.Slide.Attrs msg)
    -> List (Element childAccepts (M3e.Slide.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Slide.Is s) admittedBy msg
slide =
    M3e.Slide.view


{-| See `M3e.SlideGroup.view`.
-}
slideGroup :
    List (Attr M3e.SlideGroup.Attrs msg)
    -> List (Element childAccepts (M3e.SlideGroup.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SlideGroup.Is s) admittedBy msg
slideGroup =
    M3e.SlideGroup.view


{-| See `M3e.Slider.view`.
-}
slider :
    List (Attr M3e.Slider.Attrs msg)
    -> List (Element childAccepts (M3e.Slider.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Slider.Is s) admittedBy msg
slider =
    M3e.Slider.view


{-| See `M3e.SliderThumb.view`.
-}
sliderThumb :
    List (Attr M3e.SliderThumb.Attrs msg)
    -> List (Element childAccepts (M3e.SliderThumb.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SliderThumb.Is s) admittedBy msg
sliderThumb =
    M3e.SliderThumb.view


{-| See `M3e.Snackbar.view`.
-}
snackbar :
    List (Attr M3e.Snackbar.Attrs msg)
    -> List (Element M3e.Snackbar.Content (M3e.Snackbar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Snackbar.Is s) admittedBy msg
snackbar =
    M3e.Snackbar.view


{-| See `M3e.SplitButton.view`.
-}
splitButton :
    List (Attr M3e.SplitButton.Attrs msg)
    -> List (Element childAccepts (M3e.SplitButton.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SplitButton.Is s) admittedBy msg
splitButton =
    M3e.SplitButton.view


{-| See `M3e.SplitPane.view`.
-}
splitPane :
    List (Attr M3e.SplitPane.Attrs msg)
    -> List (Element childAccepts (M3e.SplitPane.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SplitPane.Is s) admittedBy msg
splitPane =
    M3e.SplitPane.view


{-| See `M3e.StateLayer.view`.
-}
stateLayer :
    List (Attr M3e.StateLayer.Attrs msg)
    -> List (Element childAccepts (M3e.StateLayer.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.StateLayer.Is s) admittedBy msg
stateLayer =
    M3e.StateLayer.view


{-| See `M3e.Step.view`.
-}
step :
    List (Attr M3e.Step.Attrs msg)
    -> List (Element M3e.Step.Content (M3e.Step.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Step.Is s) admittedBy msg
step =
    M3e.Step.view


{-| See `M3e.StepPanel.view`.
-}
stepPanel :
    List (Attr M3e.StepPanel.Attrs msg)
    -> List (Element childAccepts (M3e.StepPanel.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.StepPanel.Is s) admittedBy msg
stepPanel =
    M3e.StepPanel.view


{-| See `M3e.Stepper.view`.
-}
stepper :
    List (Attr M3e.Stepper.Attrs msg)
    -> List (Element childAccepts (M3e.Stepper.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Stepper.Is s) admittedBy msg
stepper =
    M3e.Stepper.view


{-| See `M3e.StepperNext.view`.
-}
stepperNext :
    List (Attr M3e.StepperNext.Attrs msg)
    -> List (Element childAccepts (M3e.StepperNext.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.StepperNext.Is s) admittedBy msg
stepperNext =
    M3e.StepperNext.view


{-| See `M3e.StepperPrevious.view`.
-}
stepperPrevious :
    List (Attr M3e.StepperPrevious.Attrs msg)
    -> List (Element childAccepts (M3e.StepperPrevious.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.StepperPrevious.Is s) admittedBy msg
stepperPrevious =
    M3e.StepperPrevious.view


{-| See `M3e.StepperReset.view`.
-}
stepperReset :
    List (Attr M3e.StepperReset.Attrs msg)
    -> List (Element childAccepts (M3e.StepperReset.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.StepperReset.Is s) admittedBy msg
stepperReset =
    M3e.StepperReset.view


{-| See `M3e.SuggestionChip.view`.
-}
suggestionChip :
    List (Attr M3e.SuggestionChip.Attrs msg)
    -> List (Element M3e.SuggestionChip.Content (M3e.SuggestionChip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.SuggestionChip.Is s) admittedBy msg
suggestionChip =
    M3e.SuggestionChip.view


{-| See `M3e.Switch.view`.
-}
switch :
    List (Attr M3e.Switch.Attrs msg)
    -> List (Element childAccepts (M3e.Switch.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Switch.Is s) admittedBy msg
switch =
    M3e.Switch.view


{-| See `M3e.Tab.view`.
-}
tab :
    List (Attr M3e.Tab.Attrs msg)
    -> List (Element M3e.Tab.Content (M3e.Tab.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Tab.Is s) admittedBy msg
tab =
    M3e.Tab.view


{-| See `M3e.TabPanel.view`.
-}
tabPanel :
    List (Attr M3e.TabPanel.Attrs msg)
    -> List (Element childAccepts (M3e.TabPanel.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TabPanel.Is s) admittedBy msg
tabPanel =
    M3e.TabPanel.view


{-| See `M3e.Tabs.view`.
-}
tabs :
    List (Attr M3e.Tabs.Attrs msg)
    -> List (Element M3e.Tabs.Content (M3e.Tabs.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Tabs.Is s) admittedBy msg
tabs =
    M3e.Tabs.view


{-| See `M3e.TextHighlight.view`.
-}
textHighlight :
    List (Attr M3e.TextHighlight.Attrs msg)
    -> List (Element childAccepts (M3e.TextHighlight.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TextHighlight.Is s) admittedBy msg
textHighlight =
    M3e.TextHighlight.view


{-| See `M3e.TextOverflow.view`.
-}
textOverflow :
    List (Attr M3e.TextOverflow.Attrs msg)
    -> List (Element M3e.TextOverflow.Content (M3e.TextOverflow.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TextOverflow.Is s) admittedBy msg
textOverflow =
    M3e.TextOverflow.view


{-| See `M3e.TextareaAutosize.view`.
-}
textareaAutosize :
    List (Attr M3e.TextareaAutosize.Attrs msg)
    -> List (Element childAccepts (M3e.TextareaAutosize.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TextareaAutosize.Is s) admittedBy msg
textareaAutosize =
    M3e.TextareaAutosize.view


{-| See `M3e.Theme.view`.
-}
theme :
    List (Attr M3e.Theme.Attrs msg)
    -> List (Element childAccepts (M3e.Theme.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Theme.Is s) admittedBy msg
theme =
    M3e.Theme.view


{-| See `M3e.ThemeIcon.view`.
-}
themeIcon :
    List (Attr M3e.ThemeIcon.Attrs msg)
    -> List (Element childAccepts (M3e.ThemeIcon.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.ThemeIcon.Is s) admittedBy msg
themeIcon =
    M3e.ThemeIcon.view


{-| See `M3e.Toc.view`.
-}
toc :
    List (Attr M3e.Toc.Attrs msg)
    -> List (Element childAccepts (M3e.Toc.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Toc.Is s) admittedBy msg
toc =
    M3e.Toc.view


{-| See `M3e.TocItem.view`.
-}
tocItem :
    List (Attr M3e.TocItem.Attrs msg)
    -> List (Element M3e.TocItem.Content (M3e.TocItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TocItem.Is s) admittedBy msg
tocItem =
    M3e.TocItem.view


{-| See `M3e.Toolbar.view`.
-}
toolbar :
    List (Attr M3e.Toolbar.Attrs msg)
    -> List (Element childAccepts (M3e.Toolbar.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Toolbar.Is s) admittedBy msg
toolbar =
    M3e.Toolbar.view


{-| See `M3e.Tooltip.view`.
-}
tooltip :
    List (Attr M3e.Tooltip.Attrs msg)
    -> List (Element M3e.Tooltip.Content (M3e.Tooltip.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Tooltip.Is s) admittedBy msg
tooltip =
    M3e.Tooltip.view


{-| See `M3e.Tree.view`.
-}
tree :
    List (Attr M3e.Tree.Attrs msg)
    -> List (Element M3e.Tree.Content (M3e.Tree.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.Tree.Is s) admittedBy msg
tree =
    M3e.Tree.view


{-| See `M3e.TreeItem.view`.
-}
treeItem :
    List (Attr M3e.TreeItem.Attrs msg)
    -> List (Element M3e.TreeItem.Content (M3e.TreeItem.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.TreeItem.Is s) admittedBy msg
treeItem =
    M3e.TreeItem.view


{-| See `M3e.YearView.view`.
-}
yearView :
    List (Attr M3e.YearView.Attrs msg)
    -> List (Element childAccepts (M3e.YearView.ChildAdmittedBy childAdm) msg)
    -> Element (M3e.YearView.Is s) admittedBy msg
yearView =
    M3e.YearView.view


{-| The shared text atom — admissible into any library's opted-in slot.
-}
text : String -> Element { s | sharedText : Shared } admittedBy msg
text value_ =
    Ir.fromNode (Ir.text value_)
