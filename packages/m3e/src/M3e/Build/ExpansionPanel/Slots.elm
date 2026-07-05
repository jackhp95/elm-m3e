module M3e.Build.ExpansionPanel.Slots exposing
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
    , pseudoCheckbox, focusRing, elevation, collapsible, actionElementBase, headerTree, headerTreeItem
    , headerToolbar, headerToc, headerTocItem, headerThemeIcon, headerTheme, headerTextareaAutosize, headerTabs
    , headerTabPanel, headerTab, headerSwitch, headerStepperReset, headerStepperPrevious, headerStep, headerStepPanel
    , headerStepper, headerSplitPane, headerSplitButton, headerSnackbar, headerSlider, headerSliderThumb, headerSlideGroup
    , headerSkeleton, headerShape, headerSegmentedButton, headerButtonSegment, headerSearchView, headerSearchBar, headerRadioGroup
    , headerRadio, headerProgressElementIndicatorBase, headerPaginator, headerSelect, headerNavRailToggle, headerNavRail, headerNavMenuItemGroup
    , headerNavMenu, headerNavMenuItem, headerNavBar, headerNavItem, headerMenuItemRadio, headerMenuItemGroup, headerMenuItemCheckbox
    , headerMenu, headerMenuItem, headerMenuTrigger, headerMenuItemElementBase, headerLoadingIndicator, headerSelectionList, headerListOption
    , headerActionList, headerExpandableListItem, headerListAction, headerListItemButton, headerList, headerListItem, headerIcon
    , headerHeading, headerFabMenuTrigger, headerFabMenu, headerFab, headerAccordion, headerExpansionPanel, headerExpansionHeader
    , headerDrawerToggle, headerDrawerContainer, headerDivider, headerDialogTrigger, headerDialog, headerDialogAction, headerDatepickerToggle
    , headerDatepicker, headerContentPane, headerSuggestionChip, headerInputChipSet, headerInputChip, headerFilterChipSet, headerFilterChip
    , headerChipSet, headerAssistChip, headerChip, headerCheckbox, headerCard, headerCalendar, headerYearView
    , headerMultiYearView, headerMonthView, headerTooltip, headerRichTooltip, headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup
    , headerIconButton, headerButton, headerBreadcrumb, headerBreadcrumbItem, headerBreadcrumbItemButton, headerBottomSheetTrigger, headerBottomSheet
    , headerBottomSheetAction, headerBadge, headerAvatar, headerAutocomplete, headerFormField, headerOptionPanel, headerFloatingPanel
    , headerOptgroup, headerOption, headerFocusTrap, headerAppBar, headerTextOverflow, headerTextHighlight, headerStateLayer
    , headerSlide, headerScrollContainer, headerRipple, headerPseudoRadio, headerPseudoCheckbox, headerFocusRing, headerElevation
    , headerCollapsible, headerActionElementBase, toggleIconIcon, actionsTree, actionsTreeItem, actionsToolbar, actionsToc
    , actionsTocItem, actionsThemeIcon, actionsTheme, actionsTextareaAutosize, actionsTabs, actionsTabPanel, actionsTab
    , actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep, actionsStepPanel, actionsStepper, actionsSplitPane
    , actionsSplitButton, actionsSnackbar, actionsSlider, actionsSliderThumb, actionsSlideGroup, actionsSkeleton, actionsShape
    , actionsSegmentedButton, actionsButtonSegment, actionsSearchView, actionsSearchBar, actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase
    , actionsPaginator, actionsSelect, actionsNavRailToggle, actionsNavRail, actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem
    , actionsNavBar, actionsNavItem, actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu, actionsMenuItem
    , actionsMenuTrigger, actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList, actionsListOption, actionsActionList, actionsExpandableListItem
    , actionsListAction, actionsListItemButton, actionsList, actionsListItem, actionsIcon, actionsHeading, actionsFabMenuTrigger
    , actionsFabMenu, actionsFab, actionsAccordion, actionsExpansionPanel, actionsExpansionHeader, actionsDrawerToggle, actionsDrawerContainer
    , actionsDivider, actionsDialogTrigger, actionsDialog, actionsDialogAction, actionsDatepickerToggle, actionsDatepicker, actionsContentPane
    , actionsSuggestionChip, actionsInputChipSet, actionsInputChip, actionsFilterChipSet, actionsFilterChip, actionsChipSet, actionsAssistChip
    , actionsChip, actionsCheckbox, actionsCard, actionsCalendar, actionsYearView, actionsMultiYearView, actionsMonthView
    , actionsTooltip, actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup, actionsIconButton, actionsButton
    , actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger, actionsBottomSheet, actionsBottomSheetAction, actionsBadge
    , actionsAvatar, actionsAutocomplete, actionsFormField, actionsOptionPanel, actionsFloatingPanel, actionsOptgroup, actionsOption
    , actionsFocusTrap, actionsAppBar, actionsTextOverflow, actionsTextHighlight, actionsStateLayer, actionsSlide, actionsScrollContainer
    , actionsRipple, actionsPseudoRadio, actionsPseudoCheckbox, actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase
    )

{-|
Slot setters for `M3e.Build.ExpansionPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs elevation, collapsible, actionElementBase, headerTree, headerTreeItem, headerToolbar
@docs headerToc, headerTocItem, headerThemeIcon, headerTheme, headerTextareaAutosize, headerTabs
@docs headerTabPanel, headerTab, headerSwitch, headerStepperReset, headerStepperPrevious, headerStep
@docs headerStepPanel, headerStepper, headerSplitPane, headerSplitButton, headerSnackbar, headerSlider
@docs headerSliderThumb, headerSlideGroup, headerSkeleton, headerShape, headerSegmentedButton, headerButtonSegment
@docs headerSearchView, headerSearchBar, headerRadioGroup, headerRadio, headerProgressElementIndicatorBase, headerPaginator
@docs headerSelect, headerNavRailToggle, headerNavRail, headerNavMenuItemGroup, headerNavMenu, headerNavMenuItem
@docs headerNavBar, headerNavItem, headerMenuItemRadio, headerMenuItemGroup, headerMenuItemCheckbox, headerMenu
@docs headerMenuItem, headerMenuTrigger, headerMenuItemElementBase, headerLoadingIndicator, headerSelectionList, headerListOption
@docs headerActionList, headerExpandableListItem, headerListAction, headerListItemButton, headerList, headerListItem
@docs headerIcon, headerHeading, headerFabMenuTrigger, headerFabMenu, headerFab, headerAccordion
@docs headerExpansionPanel, headerExpansionHeader, headerDrawerToggle, headerDrawerContainer, headerDivider, headerDialogTrigger
@docs headerDialog, headerDialogAction, headerDatepickerToggle, headerDatepicker, headerContentPane, headerSuggestionChip
@docs headerInputChipSet, headerInputChip, headerFilterChipSet, headerFilterChip, headerChipSet, headerAssistChip
@docs headerChip, headerCheckbox, headerCard, headerCalendar, headerYearView, headerMultiYearView
@docs headerMonthView, headerTooltip, headerRichTooltip, headerTooltipElementBase, headerRichTooltipAction, headerButtonGroup
@docs headerIconButton, headerButton, headerBreadcrumb, headerBreadcrumbItem, headerBreadcrumbItemButton, headerBottomSheetTrigger
@docs headerBottomSheet, headerBottomSheetAction, headerBadge, headerAvatar, headerAutocomplete, headerFormField
@docs headerOptionPanel, headerFloatingPanel, headerOptgroup, headerOption, headerFocusTrap, headerAppBar
@docs headerTextOverflow, headerTextHighlight, headerStateLayer, headerSlide, headerScrollContainer, headerRipple
@docs headerPseudoRadio, headerPseudoCheckbox, headerFocusRing, headerElevation, headerCollapsible, headerActionElementBase
@docs toggleIconIcon, actionsTree, actionsTreeItem, actionsToolbar, actionsToc, actionsTocItem
@docs actionsThemeIcon, actionsTheme, actionsTextareaAutosize, actionsTabs, actionsTabPanel, actionsTab
@docs actionsSwitch, actionsStepperReset, actionsStepperPrevious, actionsStep, actionsStepPanel, actionsStepper
@docs actionsSplitPane, actionsSplitButton, actionsSnackbar, actionsSlider, actionsSliderThumb, actionsSlideGroup
@docs actionsSkeleton, actionsShape, actionsSegmentedButton, actionsButtonSegment, actionsSearchView, actionsSearchBar
@docs actionsRadioGroup, actionsRadio, actionsProgressElementIndicatorBase, actionsPaginator, actionsSelect, actionsNavRailToggle
@docs actionsNavRail, actionsNavMenuItemGroup, actionsNavMenu, actionsNavMenuItem, actionsNavBar, actionsNavItem
@docs actionsMenuItemRadio, actionsMenuItemGroup, actionsMenuItemCheckbox, actionsMenu, actionsMenuItem, actionsMenuTrigger
@docs actionsMenuItemElementBase, actionsLoadingIndicator, actionsSelectionList, actionsListOption, actionsActionList, actionsExpandableListItem
@docs actionsListAction, actionsListItemButton, actionsList, actionsListItem, actionsIcon, actionsHeading
@docs actionsFabMenuTrigger, actionsFabMenu, actionsFab, actionsAccordion, actionsExpansionPanel, actionsExpansionHeader
@docs actionsDrawerToggle, actionsDrawerContainer, actionsDivider, actionsDialogTrigger, actionsDialog, actionsDialogAction
@docs actionsDatepickerToggle, actionsDatepicker, actionsContentPane, actionsSuggestionChip, actionsInputChipSet, actionsInputChip
@docs actionsFilterChipSet, actionsFilterChip, actionsChipSet, actionsAssistChip, actionsChip, actionsCheckbox
@docs actionsCard, actionsCalendar, actionsYearView, actionsMultiYearView, actionsMonthView, actionsTooltip
@docs actionsRichTooltip, actionsTooltipElementBase, actionsRichTooltipAction, actionsButtonGroup, actionsIconButton, actionsButton
@docs actionsBreadcrumb, actionsBreadcrumbItem, actionsBreadcrumbItemButton, actionsBottomSheetTrigger, actionsBottomSheet, actionsBottomSheetAction
@docs actionsBadge, actionsAvatar, actionsAutocomplete, actionsFormField, actionsOptionPanel, actionsFloatingPanel
@docs actionsOptgroup, actionsOption, actionsFocusTrap, actionsAppBar, actionsTextOverflow, actionsTextHighlight
@docs actionsStateLayer, actionsSlide, actionsScrollContainer, actionsRipple, actionsPseudoRadio, actionsPseudoCheckbox
@docs actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase
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
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


header_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
header_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


actions_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actions_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `unnamed` slot of `ExpansionPanel`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tree =
    default_core


{-| Place a `TreeItem` in the `unnamed` slot of `ExpansionPanel`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
treeItem =
    default_core


{-| Place a `Toolbar` in the `unnamed` slot of `ExpansionPanel`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toolbar =
    default_core


{-| Place a `Toc` in the `unnamed` slot of `ExpansionPanel`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
toc =
    default_core


{-| Place a `TocItem` in the `unnamed` slot of `ExpansionPanel`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tocItem =
    default_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `ExpansionPanel`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
themeIcon =
    default_core


{-| Place a `Theme` in the `unnamed` slot of `ExpansionPanel`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
theme =
    default_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `ExpansionPanel`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textareaAutosize =
    default_core


{-| Place a `Tabs` in the `unnamed` slot of `ExpansionPanel`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabs =
    default_core


{-| Place a `TabPanel` in the `unnamed` slot of `ExpansionPanel`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tabPanel =
    default_core


{-| Place a `Tab` in the `unnamed` slot of `ExpansionPanel`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tab =
    default_core


{-| Place a `Switch` in the `unnamed` slot of `ExpansionPanel`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
switch =
    default_core


{-| Place a `StepperReset` in the `unnamed` slot of `ExpansionPanel`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `ExpansionPanel`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    default_core


{-| Place a `Step` in the `unnamed` slot of `ExpansionPanel`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
step =
    default_core


{-| Place a `StepPanel` in the `unnamed` slot of `ExpansionPanel`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepPanel =
    default_core


{-| Place a `Stepper` in the `unnamed` slot of `ExpansionPanel`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepper =
    default_core


{-| Place a `SplitPane` in the `unnamed` slot of `ExpansionPanel`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitPane =
    default_core


{-| Place a `SplitButton` in the `unnamed` slot of `ExpansionPanel`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
splitButton =
    default_core


{-| Place a `Snackbar` in the `unnamed` slot of `ExpansionPanel`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
snackbar =
    default_core


{-| Place a `Slider` in the `unnamed` slot of `ExpansionPanel`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slider =
    default_core


{-| Place a `SliderThumb` in the `unnamed` slot of `ExpansionPanel`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
sliderThumb =
    default_core


{-| Place a `SlideGroup` in the `unnamed` slot of `ExpansionPanel`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slideGroup =
    default_core


{-| Place a `Skeleton` in the `unnamed` slot of `ExpansionPanel`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
skeleton =
    default_core


{-| Place a `Shape` in the `unnamed` slot of `ExpansionPanel`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
shape =
    default_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `ExpansionPanel`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
segmentedButton =
    default_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `ExpansionPanel`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonSegment =
    default_core


{-| Place a `SearchView` in the `unnamed` slot of `ExpansionPanel`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchView =
    default_core


{-| Place a `SearchBar` in the `unnamed` slot of `ExpansionPanel`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
searchBar =
    default_core


{-| Place a `RadioGroup` in the `unnamed` slot of `ExpansionPanel`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radioGroup =
    default_core


{-| Place a `Radio` in the `unnamed` slot of `ExpansionPanel`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
radio =
    default_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `ExpansionPanel`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
progressElementIndicatorBase =
    default_core


{-| Place a `Paginator` in the `unnamed` slot of `ExpansionPanel`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
paginator =
    default_core


{-| Place a `Select` in the `unnamed` slot of `ExpansionPanel`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
select =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `ExpansionPanel`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    default_core


{-| Place a `NavRail` in the `unnamed` slot of `ExpansionPanel`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRail =
    default_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `ExpansionPanel`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenu` in the `unnamed` slot of `ExpansionPanel`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenu =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `ExpansionPanel`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navMenuItem =
    default_core


{-| Place a `NavBar` in the `unnamed` slot of `ExpansionPanel`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navBar =
    default_core


{-| Place a `NavItem` in the `unnamed` slot of `ExpansionPanel`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navItem =
    default_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `ExpansionPanel`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `ExpansionPanel`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `ExpansionPanel`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemCheckbox =
    default_core


{-| Place a `Menu` in the `unnamed` slot of `ExpansionPanel`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menu =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `ExpansionPanel`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItem =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `ExpansionPanel`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    default_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `ExpansionPanel`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuItemElementBase =
    default_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `ExpansionPanel`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
loadingIndicator =
    default_core


{-| Place a `SelectionList` in the `unnamed` slot of `ExpansionPanel`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
selectionList =
    default_core


{-| Place a `ListOption` in the `unnamed` slot of `ExpansionPanel`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listOption =
    default_core


{-| Place a `ActionList` in the `unnamed` slot of `ExpansionPanel`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionList =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `ExpansionPanel`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `ExpansionPanel`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listAction =
    default_core


{-| Place a `ListItemButton` in the `unnamed` slot of `ExpansionPanel`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItemButton =
    default_core


{-| Place a `List` in the `unnamed` slot of `ExpansionPanel`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
list =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `ExpansionPanel`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
listItem =
    default_core


{-| Place a `Icon` in the `unnamed` slot of `ExpansionPanel`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
icon =
    default_core


{-| Place a `Heading` in the `unnamed` slot of `ExpansionPanel`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
heading =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `ExpansionPanel`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    default_core


{-| Place a `FabMenu` in the `unnamed` slot of `ExpansionPanel`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenu =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `ExpansionPanel`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fab =
    default_core


{-| Place a `Accordion` in the `unnamed` slot of `ExpansionPanel`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
accordion =
    default_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `ExpansionPanel`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionPanel =
    default_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `ExpansionPanel`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
expansionHeader =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `ExpansionPanel`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    default_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `ExpansionPanel`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerContainer =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `ExpansionPanel`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
divider =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `ExpansionPanel`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    default_core


{-| Place a `Dialog` in the `unnamed` slot of `ExpansionPanel`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialog =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `ExpansionPanel`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `ExpansionPanel`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    default_core


{-| Place a `Datepicker` in the `unnamed` slot of `ExpansionPanel`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepicker =
    default_core


{-| Place a `ContentPane` in the `unnamed` slot of `ExpansionPanel`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
contentPane =
    default_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `ExpansionPanel`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
suggestionChip =
    default_core


{-| Place a `InputChipSet` in the `unnamed` slot of `ExpansionPanel`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChipSet =
    default_core


{-| Place a `InputChip` in the `unnamed` slot of `ExpansionPanel`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
inputChip =
    default_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `ExpansionPanel`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChipSet =
    default_core


{-| Place a `FilterChip` in the `unnamed` slot of `ExpansionPanel`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
filterChip =
    default_core


{-| Place a `ChipSet` in the `unnamed` slot of `ExpansionPanel`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chipSet =
    default_core


{-| Place a `AssistChip` in the `unnamed` slot of `ExpansionPanel`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
assistChip =
    default_core


{-| Place a `Chip` in the `unnamed` slot of `ExpansionPanel`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
chip =
    default_core


{-| Place a `Checkbox` in the `unnamed` slot of `ExpansionPanel`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
checkbox =
    default_core


{-| Place a `Card` in the `unnamed` slot of `ExpansionPanel`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
card =
    default_core


{-| Place a `Calendar` in the `unnamed` slot of `ExpansionPanel`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
calendar =
    default_core


{-| Place a `YearView` in the `unnamed` slot of `ExpansionPanel`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
yearView =
    default_core


{-| Place a `MultiYearView` in the `unnamed` slot of `ExpansionPanel`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
multiYearView =
    default_core


{-| Place a `MonthView` in the `unnamed` slot of `ExpansionPanel`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
monthView =
    default_core


{-| Place a `Tooltip` in the `unnamed` slot of `ExpansionPanel`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltip =
    default_core


{-| Place a `RichTooltip` in the `unnamed` slot of `ExpansionPanel`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltip =
    default_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `ExpansionPanel`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
tooltipElementBase =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `ExpansionPanel`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    default_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `ExpansionPanel`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
buttonGroup =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `ExpansionPanel`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
iconButton =
    default_core


{-| Place a `Button` in the `unnamed` slot of `ExpansionPanel`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
button =
    default_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `ExpansionPanel`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumb =
    default_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `ExpansionPanel`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItem =
    default_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `ExpansionPanel`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
breadcrumbItemButton =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `ExpansionPanel`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheet` in the `unnamed` slot of `ExpansionPanel`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheet =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `ExpansionPanel`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    default_core


{-| Place a `Badge` in the `unnamed` slot of `ExpansionPanel`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
badge =
    default_core


{-| Place a `Avatar` in the `unnamed` slot of `ExpansionPanel`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
avatar =
    default_core


{-| Place a `Autocomplete` in the `unnamed` slot of `ExpansionPanel`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
autocomplete =
    default_core


{-| Place a `FormField` in the `unnamed` slot of `ExpansionPanel`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
formField =
    default_core


{-| Place a `OptionPanel` in the `unnamed` slot of `ExpansionPanel`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optionPanel =
    default_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `ExpansionPanel`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
floatingPanel =
    default_core


{-| Place a `Optgroup` in the `unnamed` slot of `ExpansionPanel`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
optgroup =
    default_core


{-| Place a `Option` in the `unnamed` slot of `ExpansionPanel`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
option =
    default_core


{-| Place a `FocusTrap` in the `unnamed` slot of `ExpansionPanel`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusTrap =
    default_core


{-| Place a `AppBar` in the `unnamed` slot of `ExpansionPanel`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
appBar =
    default_core


{-| Place a `TextOverflow` in the `unnamed` slot of `ExpansionPanel`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textOverflow =
    default_core


{-| Place a `TextHighlight` in the `unnamed` slot of `ExpansionPanel`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
textHighlight =
    default_core


{-| Place a `StateLayer` in the `unnamed` slot of `ExpansionPanel`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stateLayer =
    default_core


{-| Place a `Slide` in the `unnamed` slot of `ExpansionPanel`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
slide =
    default_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `ExpansionPanel`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
scrollContainer =
    default_core


{-| Place a `Ripple` in the `unnamed` slot of `ExpansionPanel`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
ripple =
    default_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `ExpansionPanel`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoRadio =
    default_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `ExpansionPanel`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
pseudoCheckbox =
    default_core


{-| Place a `FocusRing` in the `unnamed` slot of `ExpansionPanel`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
focusRing =
    default_core


{-| Place a `Elevation` in the `unnamed` slot of `ExpansionPanel`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
elevation =
    default_core


{-| Place a `Collapsible` in the `unnamed` slot of `ExpansionPanel`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
collapsible =
    default_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `ExpansionPanel`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
actionElementBase =
    default_core


{-| Place a `Tree` in the `header` slot of `ExpansionPanel`. -}
headerTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTree =
    header_core


{-| Place a `TreeItem` in the `header` slot of `ExpansionPanel`. -}
headerTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTreeItem =
    header_core


{-| Place a `Toolbar` in the `header` slot of `ExpansionPanel`. -}
headerToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToolbar =
    header_core


{-| Place a `Toc` in the `header` slot of `ExpansionPanel`. -}
headerToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerToc =
    header_core


{-| Place a `TocItem` in the `header` slot of `ExpansionPanel`. -}
headerTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTocItem =
    header_core


{-| Place a `ThemeIcon` in the `header` slot of `ExpansionPanel`. -}
headerThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerThemeIcon =
    header_core


{-| Place a `Theme` in the `header` slot of `ExpansionPanel`. -}
headerTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTheme =
    header_core


{-| Place a `TextareaAutosize` in the `header` slot of `ExpansionPanel`. -}
headerTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextareaAutosize =
    header_core


{-| Place a `Tabs` in the `header` slot of `ExpansionPanel`. -}
headerTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabs =
    header_core


{-| Place a `TabPanel` in the `header` slot of `ExpansionPanel`. -}
headerTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTabPanel =
    header_core


{-| Place a `Tab` in the `header` slot of `ExpansionPanel`. -}
headerTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTab =
    header_core


{-| Place a `Switch` in the `header` slot of `ExpansionPanel`. -}
headerSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSwitch =
    header_core


{-| Place a `StepperReset` in the `header` slot of `ExpansionPanel`. -}
headerStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperReset =
    header_core


{-| Place a `StepperPrevious` in the `header` slot of `ExpansionPanel`. -}
headerStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepperPrevious =
    header_core


{-| Place a `Step` in the `header` slot of `ExpansionPanel`. -}
headerStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStep =
    header_core


{-| Place a `StepPanel` in the `header` slot of `ExpansionPanel`. -}
headerStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepPanel =
    header_core


{-| Place a `Stepper` in the `header` slot of `ExpansionPanel`. -}
headerStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStepper =
    header_core


{-| Place a `SplitPane` in the `header` slot of `ExpansionPanel`. -}
headerSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitPane =
    header_core


{-| Place a `SplitButton` in the `header` slot of `ExpansionPanel`. -}
headerSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSplitButton =
    header_core


{-| Place a `Snackbar` in the `header` slot of `ExpansionPanel`. -}
headerSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSnackbar =
    header_core


{-| Place a `Slider` in the `header` slot of `ExpansionPanel`. -}
headerSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlider =
    header_core


{-| Place a `SliderThumb` in the `header` slot of `ExpansionPanel`. -}
headerSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSliderThumb =
    header_core


{-| Place a `SlideGroup` in the `header` slot of `ExpansionPanel`. -}
headerSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlideGroup =
    header_core


{-| Place a `Skeleton` in the `header` slot of `ExpansionPanel`. -}
headerSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSkeleton =
    header_core


{-| Place a `Shape` in the `header` slot of `ExpansionPanel`. -}
headerShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerShape =
    header_core


{-| Place a `SegmentedButton` in the `header` slot of `ExpansionPanel`. -}
headerSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSegmentedButton =
    header_core


{-| Place a `ButtonSegment` in the `header` slot of `ExpansionPanel`. -}
headerButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonSegment =
    header_core


{-| Place a `SearchView` in the `header` slot of `ExpansionPanel`. -}
headerSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchView =
    header_core


{-| Place a `SearchBar` in the `header` slot of `ExpansionPanel`. -}
headerSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSearchBar =
    header_core


{-| Place a `RadioGroup` in the `header` slot of `ExpansionPanel`. -}
headerRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadioGroup =
    header_core


{-| Place a `Radio` in the `header` slot of `ExpansionPanel`. -}
headerRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRadio =
    header_core


{-| Place a `ProgressElementIndicatorBase` in the `header` slot of `ExpansionPanel`. -}
headerProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerProgressElementIndicatorBase =
    header_core


{-| Place a `Paginator` in the `header` slot of `ExpansionPanel`. -}
headerPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPaginator =
    header_core


{-| Place a `Select` in the `header` slot of `ExpansionPanel`. -}
headerSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelect =
    header_core


{-| Place a `NavRailToggle` in the `header` slot of `ExpansionPanel`. -}
headerNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRailToggle =
    header_core


{-| Place a `NavRail` in the `header` slot of `ExpansionPanel`. -}
headerNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavRail =
    header_core


{-| Place a `NavMenuItemGroup` in the `header` slot of `ExpansionPanel`. -}
headerNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItemGroup =
    header_core


{-| Place a `NavMenu` in the `header` slot of `ExpansionPanel`. -}
headerNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenu =
    header_core


{-| Place a `NavMenuItem` in the `header` slot of `ExpansionPanel`. -}
headerNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavMenuItem =
    header_core


{-| Place a `NavBar` in the `header` slot of `ExpansionPanel`. -}
headerNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavBar =
    header_core


{-| Place a `NavItem` in the `header` slot of `ExpansionPanel`. -}
headerNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerNavItem =
    header_core


{-| Place a `MenuItemRadio` in the `header` slot of `ExpansionPanel`. -}
headerMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemRadio =
    header_core


{-| Place a `MenuItemGroup` in the `header` slot of `ExpansionPanel`. -}
headerMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemGroup =
    header_core


{-| Place a `MenuItemCheckbox` in the `header` slot of `ExpansionPanel`. -}
headerMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemCheckbox =
    header_core


{-| Place a `Menu` in the `header` slot of `ExpansionPanel`. -}
headerMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenu =
    header_core


{-| Place a `MenuItem` in the `header` slot of `ExpansionPanel`. -}
headerMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItem =
    header_core


{-| Place a `MenuTrigger` in the `header` slot of `ExpansionPanel`. -}
headerMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuTrigger =
    header_core


{-| Place a `MenuItemElementBase` in the `header` slot of `ExpansionPanel`. -}
headerMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMenuItemElementBase =
    header_core


{-| Place a `LoadingIndicator` in the `header` slot of `ExpansionPanel`. -}
headerLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerLoadingIndicator =
    header_core


{-| Place a `SelectionList` in the `header` slot of `ExpansionPanel`. -}
headerSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSelectionList =
    header_core


{-| Place a `ListOption` in the `header` slot of `ExpansionPanel`. -}
headerListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListOption =
    header_core


{-| Place a `ActionList` in the `header` slot of `ExpansionPanel`. -}
headerActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionList =
    header_core


{-| Place a `ExpandableListItem` in the `header` slot of `ExpansionPanel`. -}
headerExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpandableListItem =
    header_core


{-| Place a `ListAction` in the `header` slot of `ExpansionPanel`. -}
headerListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListAction =
    header_core


{-| Place a `ListItemButton` in the `header` slot of `ExpansionPanel`. -}
headerListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItemButton =
    header_core


{-| Place a `List` in the `header` slot of `ExpansionPanel`. -}
headerList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerList =
    header_core


{-| Place a `ListItem` in the `header` slot of `ExpansionPanel`. -}
headerListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerListItem =
    header_core


{-| Place a `Icon` in the `header` slot of `ExpansionPanel`. -}
headerIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIcon =
    header_core


{-| Place a `Heading` in the `header` slot of `ExpansionPanel`. -}
headerHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerHeading =
    header_core


{-| Place a `FabMenuTrigger` in the `header` slot of `ExpansionPanel`. -}
headerFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenuTrigger =
    header_core


{-| Place a `FabMenu` in the `header` slot of `ExpansionPanel`. -}
headerFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFabMenu =
    header_core


{-| Place a `Fab` in the `header` slot of `ExpansionPanel`. -}
headerFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFab =
    header_core


{-| Place a `Accordion` in the `header` slot of `ExpansionPanel`. -}
headerAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAccordion =
    header_core


{-| Place a `ExpansionPanel` in the `header` slot of `ExpansionPanel`. -}
headerExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionPanel =
    header_core


{-| Place a `ExpansionHeader` in the `header` slot of `ExpansionPanel`. -}
headerExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerExpansionHeader =
    header_core


{-| Place a `DrawerToggle` in the `header` slot of `ExpansionPanel`. -}
headerDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerToggle =
    header_core


{-| Place a `DrawerContainer` in the `header` slot of `ExpansionPanel`. -}
headerDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDrawerContainer =
    header_core


{-| Place a `Divider` in the `header` slot of `ExpansionPanel`. -}
headerDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDivider =
    header_core


{-| Place a `DialogTrigger` in the `header` slot of `ExpansionPanel`. -}
headerDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogTrigger =
    header_core


{-| Place a `Dialog` in the `header` slot of `ExpansionPanel`. -}
headerDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialog =
    header_core


{-| Place a `DialogAction` in the `header` slot of `ExpansionPanel`. -}
headerDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDialogAction =
    header_core


{-| Place a `DatepickerToggle` in the `header` slot of `ExpansionPanel`. -}
headerDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepickerToggle =
    header_core


{-| Place a `Datepicker` in the `header` slot of `ExpansionPanel`. -}
headerDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerDatepicker =
    header_core


{-| Place a `ContentPane` in the `header` slot of `ExpansionPanel`. -}
headerContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerContentPane =
    header_core


{-| Place a `SuggestionChip` in the `header` slot of `ExpansionPanel`. -}
headerSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSuggestionChip =
    header_core


{-| Place a `InputChipSet` in the `header` slot of `ExpansionPanel`. -}
headerInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChipSet =
    header_core


{-| Place a `InputChip` in the `header` slot of `ExpansionPanel`. -}
headerInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerInputChip =
    header_core


{-| Place a `FilterChipSet` in the `header` slot of `ExpansionPanel`. -}
headerFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChipSet =
    header_core


{-| Place a `FilterChip` in the `header` slot of `ExpansionPanel`. -}
headerFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFilterChip =
    header_core


{-| Place a `ChipSet` in the `header` slot of `ExpansionPanel`. -}
headerChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChipSet =
    header_core


{-| Place a `AssistChip` in the `header` slot of `ExpansionPanel`. -}
headerAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAssistChip =
    header_core


{-| Place a `Chip` in the `header` slot of `ExpansionPanel`. -}
headerChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerChip =
    header_core


{-| Place a `Checkbox` in the `header` slot of `ExpansionPanel`. -}
headerCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCheckbox =
    header_core


{-| Place a `Card` in the `header` slot of `ExpansionPanel`. -}
headerCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCard =
    header_core


{-| Place a `Calendar` in the `header` slot of `ExpansionPanel`. -}
headerCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCalendar =
    header_core


{-| Place a `YearView` in the `header` slot of `ExpansionPanel`. -}
headerYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerYearView =
    header_core


{-| Place a `MultiYearView` in the `header` slot of `ExpansionPanel`. -}
headerMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMultiYearView =
    header_core


{-| Place a `MonthView` in the `header` slot of `ExpansionPanel`. -}
headerMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerMonthView =
    header_core


{-| Place a `Tooltip` in the `header` slot of `ExpansionPanel`. -}
headerTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltip =
    header_core


{-| Place a `RichTooltip` in the `header` slot of `ExpansionPanel`. -}
headerRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltip =
    header_core


{-| Place a `TooltipElementBase` in the `header` slot of `ExpansionPanel`. -}
headerTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTooltipElementBase =
    header_core


{-| Place a `RichTooltipAction` in the `header` slot of `ExpansionPanel`. -}
headerRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRichTooltipAction =
    header_core


{-| Place a `ButtonGroup` in the `header` slot of `ExpansionPanel`. -}
headerButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButtonGroup =
    header_core


{-| Place a `IconButton` in the `header` slot of `ExpansionPanel`. -}
headerIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerIconButton =
    header_core


{-| Place a `Button` in the `header` slot of `ExpansionPanel`. -}
headerButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerButton =
    header_core


{-| Place a `Breadcrumb` in the `header` slot of `ExpansionPanel`. -}
headerBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumb =
    header_core


{-| Place a `BreadcrumbItem` in the `header` slot of `ExpansionPanel`. -}
headerBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItem =
    header_core


{-| Place a `BreadcrumbItemButton` in the `header` slot of `ExpansionPanel`. -}
headerBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBreadcrumbItemButton =
    header_core


{-| Place a `BottomSheetTrigger` in the `header` slot of `ExpansionPanel`. -}
headerBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetTrigger =
    header_core


{-| Place a `BottomSheet` in the `header` slot of `ExpansionPanel`. -}
headerBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheet =
    header_core


{-| Place a `BottomSheetAction` in the `header` slot of `ExpansionPanel`. -}
headerBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBottomSheetAction =
    header_core


{-| Place a `Badge` in the `header` slot of `ExpansionPanel`. -}
headerBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerBadge =
    header_core


{-| Place a `Avatar` in the `header` slot of `ExpansionPanel`. -}
headerAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAvatar =
    header_core


{-| Place a `Autocomplete` in the `header` slot of `ExpansionPanel`. -}
headerAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAutocomplete =
    header_core


{-| Place a `FormField` in the `header` slot of `ExpansionPanel`. -}
headerFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFormField =
    header_core


{-| Place a `OptionPanel` in the `header` slot of `ExpansionPanel`. -}
headerOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptionPanel =
    header_core


{-| Place a `FloatingPanel` in the `header` slot of `ExpansionPanel`. -}
headerFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFloatingPanel =
    header_core


{-| Place a `Optgroup` in the `header` slot of `ExpansionPanel`. -}
headerOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOptgroup =
    header_core


{-| Place a `Option` in the `header` slot of `ExpansionPanel`. -}
headerOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerOption =
    header_core


{-| Place a `FocusTrap` in the `header` slot of `ExpansionPanel`. -}
headerFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusTrap =
    header_core


{-| Place a `AppBar` in the `header` slot of `ExpansionPanel`. -}
headerAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerAppBar =
    header_core


{-| Place a `TextOverflow` in the `header` slot of `ExpansionPanel`. -}
headerTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextOverflow =
    header_core


{-| Place a `TextHighlight` in the `header` slot of `ExpansionPanel`. -}
headerTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerTextHighlight =
    header_core


{-| Place a `StateLayer` in the `header` slot of `ExpansionPanel`. -}
headerStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerStateLayer =
    header_core


{-| Place a `Slide` in the `header` slot of `ExpansionPanel`. -}
headerSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerSlide =
    header_core


{-| Place a `ScrollContainer` in the `header` slot of `ExpansionPanel`. -}
headerScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerScrollContainer =
    header_core


{-| Place a `Ripple` in the `header` slot of `ExpansionPanel`. -}
headerRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerRipple =
    header_core


{-| Place a `PseudoRadio` in the `header` slot of `ExpansionPanel`. -}
headerPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoRadio =
    header_core


{-| Place a `PseudoCheckbox` in the `header` slot of `ExpansionPanel`. -}
headerPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerPseudoCheckbox =
    header_core


{-| Place a `FocusRing` in the `header` slot of `ExpansionPanel`. -}
headerFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerFocusRing =
    header_core


{-| Place a `Elevation` in the `header` slot of `ExpansionPanel`. -}
headerElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerElevation =
    header_core


{-| Place a `Collapsible` in the `header` slot of `ExpansionPanel`. -}
headerCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerCollapsible =
    header_core


{-| Place a `ActionElementBase` in the `header` slot of `ExpansionPanel`. -}
headerActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
headerActionElementBase =
    header_core


{-| Place a `Icon` in the `toggle-icon` slot of `ExpansionPanel`. -}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionPanel.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIconIcon =
    toggleIcon_core


{-| Place a `Tree` in the `actions` slot of `ExpansionPanel`. -}
actionsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTree =
    actions_core


{-| Place a `TreeItem` in the `actions` slot of `ExpansionPanel`. -}
actionsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTreeItem =
    actions_core


{-| Place a `Toolbar` in the `actions` slot of `ExpansionPanel`. -}
actionsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsToolbar =
    actions_core


{-| Place a `Toc` in the `actions` slot of `ExpansionPanel`. -}
actionsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsToc =
    actions_core


{-| Place a `TocItem` in the `actions` slot of `ExpansionPanel`. -}
actionsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTocItem =
    actions_core


{-| Place a `ThemeIcon` in the `actions` slot of `ExpansionPanel`. -}
actionsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsThemeIcon =
    actions_core


{-| Place a `Theme` in the `actions` slot of `ExpansionPanel`. -}
actionsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTheme =
    actions_core


{-| Place a `TextareaAutosize` in the `actions` slot of `ExpansionPanel`. -}
actionsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTextareaAutosize =
    actions_core


{-| Place a `Tabs` in the `actions` slot of `ExpansionPanel`. -}
actionsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTabs =
    actions_core


{-| Place a `TabPanel` in the `actions` slot of `ExpansionPanel`. -}
actionsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTabPanel =
    actions_core


{-| Place a `Tab` in the `actions` slot of `ExpansionPanel`. -}
actionsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTab =
    actions_core


{-| Place a `Switch` in the `actions` slot of `ExpansionPanel`. -}
actionsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSwitch =
    actions_core


{-| Place a `StepperReset` in the `actions` slot of `ExpansionPanel`. -}
actionsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStepperReset =
    actions_core


{-| Place a `StepperPrevious` in the `actions` slot of `ExpansionPanel`. -}
actionsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStepperPrevious =
    actions_core


{-| Place a `Step` in the `actions` slot of `ExpansionPanel`. -}
actionsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStep =
    actions_core


{-| Place a `StepPanel` in the `actions` slot of `ExpansionPanel`. -}
actionsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStepPanel =
    actions_core


{-| Place a `Stepper` in the `actions` slot of `ExpansionPanel`. -}
actionsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStepper =
    actions_core


{-| Place a `SplitPane` in the `actions` slot of `ExpansionPanel`. -}
actionsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSplitPane =
    actions_core


{-| Place a `SplitButton` in the `actions` slot of `ExpansionPanel`. -}
actionsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSplitButton =
    actions_core


{-| Place a `Snackbar` in the `actions` slot of `ExpansionPanel`. -}
actionsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSnackbar =
    actions_core


{-| Place a `Slider` in the `actions` slot of `ExpansionPanel`. -}
actionsSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSlider =
    actions_core


{-| Place a `SliderThumb` in the `actions` slot of `ExpansionPanel`. -}
actionsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSliderThumb =
    actions_core


{-| Place a `SlideGroup` in the `actions` slot of `ExpansionPanel`. -}
actionsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSlideGroup =
    actions_core


{-| Place a `Skeleton` in the `actions` slot of `ExpansionPanel`. -}
actionsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSkeleton =
    actions_core


{-| Place a `Shape` in the `actions` slot of `ExpansionPanel`. -}
actionsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsShape =
    actions_core


{-| Place a `SegmentedButton` in the `actions` slot of `ExpansionPanel`. -}
actionsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSegmentedButton =
    actions_core


{-| Place a `ButtonSegment` in the `actions` slot of `ExpansionPanel`. -}
actionsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsButtonSegment =
    actions_core


{-| Place a `SearchView` in the `actions` slot of `ExpansionPanel`. -}
actionsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSearchView =
    actions_core


{-| Place a `SearchBar` in the `actions` slot of `ExpansionPanel`. -}
actionsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSearchBar =
    actions_core


{-| Place a `RadioGroup` in the `actions` slot of `ExpansionPanel`. -}
actionsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsRadioGroup =
    actions_core


{-| Place a `Radio` in the `actions` slot of `ExpansionPanel`. -}
actionsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsRadio =
    actions_core


{-| Place a `ProgressElementIndicatorBase` in the `actions` slot of `ExpansionPanel`. -}
actionsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsProgressElementIndicatorBase =
    actions_core


{-| Place a `Paginator` in the `actions` slot of `ExpansionPanel`. -}
actionsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsPaginator =
    actions_core


{-| Place a `Select` in the `actions` slot of `ExpansionPanel`. -}
actionsSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSelect =
    actions_core


{-| Place a `NavRailToggle` in the `actions` slot of `ExpansionPanel`. -}
actionsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavRailToggle =
    actions_core


{-| Place a `NavRail` in the `actions` slot of `ExpansionPanel`. -}
actionsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavRail =
    actions_core


{-| Place a `NavMenuItemGroup` in the `actions` slot of `ExpansionPanel`. -}
actionsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavMenuItemGroup =
    actions_core


{-| Place a `NavMenu` in the `actions` slot of `ExpansionPanel`. -}
actionsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavMenu =
    actions_core


{-| Place a `NavMenuItem` in the `actions` slot of `ExpansionPanel`. -}
actionsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavMenuItem =
    actions_core


{-| Place a `NavBar` in the `actions` slot of `ExpansionPanel`. -}
actionsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavBar =
    actions_core


{-| Place a `NavItem` in the `actions` slot of `ExpansionPanel`. -}
actionsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsNavItem =
    actions_core


{-| Place a `MenuItemRadio` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuItemRadio =
    actions_core


{-| Place a `MenuItemGroup` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuItemGroup =
    actions_core


{-| Place a `MenuItemCheckbox` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuItemCheckbox =
    actions_core


{-| Place a `Menu` in the `actions` slot of `ExpansionPanel`. -}
actionsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenu =
    actions_core


{-| Place a `MenuItem` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuItem =
    actions_core


{-| Place a `MenuTrigger` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuTrigger =
    actions_core


{-| Place a `MenuItemElementBase` in the `actions` slot of `ExpansionPanel`. -}
actionsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMenuItemElementBase =
    actions_core


{-| Place a `LoadingIndicator` in the `actions` slot of `ExpansionPanel`. -}
actionsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsLoadingIndicator =
    actions_core


{-| Place a `SelectionList` in the `actions` slot of `ExpansionPanel`. -}
actionsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSelectionList =
    actions_core


{-| Place a `ListOption` in the `actions` slot of `ExpansionPanel`. -}
actionsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsListOption =
    actions_core


{-| Place a `ActionList` in the `actions` slot of `ExpansionPanel`. -}
actionsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsActionList =
    actions_core


{-| Place a `ExpandableListItem` in the `actions` slot of `ExpansionPanel`. -}
actionsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsExpandableListItem =
    actions_core


{-| Place a `ListAction` in the `actions` slot of `ExpansionPanel`. -}
actionsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsListAction =
    actions_core


{-| Place a `ListItemButton` in the `actions` slot of `ExpansionPanel`. -}
actionsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsListItemButton =
    actions_core


{-| Place a `List` in the `actions` slot of `ExpansionPanel`. -}
actionsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsList =
    actions_core


{-| Place a `ListItem` in the `actions` slot of `ExpansionPanel`. -}
actionsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsListItem =
    actions_core


{-| Place a `Icon` in the `actions` slot of `ExpansionPanel`. -}
actionsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsIcon =
    actions_core


{-| Place a `Heading` in the `actions` slot of `ExpansionPanel`. -}
actionsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsHeading =
    actions_core


{-| Place a `FabMenuTrigger` in the `actions` slot of `ExpansionPanel`. -}
actionsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFabMenuTrigger =
    actions_core


{-| Place a `FabMenu` in the `actions` slot of `ExpansionPanel`. -}
actionsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFabMenu =
    actions_core


{-| Place a `Fab` in the `actions` slot of `ExpansionPanel`. -}
actionsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFab =
    actions_core


{-| Place a `Accordion` in the `actions` slot of `ExpansionPanel`. -}
actionsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsAccordion =
    actions_core


{-| Place a `ExpansionPanel` in the `actions` slot of `ExpansionPanel`. -}
actionsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsExpansionPanel =
    actions_core


{-| Place a `ExpansionHeader` in the `actions` slot of `ExpansionPanel`. -}
actionsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsExpansionHeader =
    actions_core


{-| Place a `DrawerToggle` in the `actions` slot of `ExpansionPanel`. -}
actionsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDrawerToggle =
    actions_core


{-| Place a `DrawerContainer` in the `actions` slot of `ExpansionPanel`. -}
actionsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDrawerContainer =
    actions_core


{-| Place a `Divider` in the `actions` slot of `ExpansionPanel`. -}
actionsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDivider =
    actions_core


{-| Place a `DialogTrigger` in the `actions` slot of `ExpansionPanel`. -}
actionsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDialogTrigger =
    actions_core


{-| Place a `Dialog` in the `actions` slot of `ExpansionPanel`. -}
actionsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDialog =
    actions_core


{-| Place a `DialogAction` in the `actions` slot of `ExpansionPanel`. -}
actionsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDialogAction =
    actions_core


{-| Place a `DatepickerToggle` in the `actions` slot of `ExpansionPanel`. -}
actionsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDatepickerToggle =
    actions_core


{-| Place a `Datepicker` in the `actions` slot of `ExpansionPanel`. -}
actionsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsDatepicker =
    actions_core


{-| Place a `ContentPane` in the `actions` slot of `ExpansionPanel`. -}
actionsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsContentPane =
    actions_core


{-| Place a `SuggestionChip` in the `actions` slot of `ExpansionPanel`. -}
actionsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSuggestionChip =
    actions_core


{-| Place a `InputChipSet` in the `actions` slot of `ExpansionPanel`. -}
actionsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsInputChipSet =
    actions_core


{-| Place a `InputChip` in the `actions` slot of `ExpansionPanel`. -}
actionsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsInputChip =
    actions_core


{-| Place a `FilterChipSet` in the `actions` slot of `ExpansionPanel`. -}
actionsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFilterChipSet =
    actions_core


{-| Place a `FilterChip` in the `actions` slot of `ExpansionPanel`. -}
actionsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFilterChip =
    actions_core


{-| Place a `ChipSet` in the `actions` slot of `ExpansionPanel`. -}
actionsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsChipSet =
    actions_core


{-| Place a `AssistChip` in the `actions` slot of `ExpansionPanel`. -}
actionsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsAssistChip =
    actions_core


{-| Place a `Chip` in the `actions` slot of `ExpansionPanel`. -}
actionsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsChip =
    actions_core


{-| Place a `Checkbox` in the `actions` slot of `ExpansionPanel`. -}
actionsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsCheckbox =
    actions_core


{-| Place a `Card` in the `actions` slot of `ExpansionPanel`. -}
actionsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsCard =
    actions_core


{-| Place a `Calendar` in the `actions` slot of `ExpansionPanel`. -}
actionsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsCalendar =
    actions_core


{-| Place a `YearView` in the `actions` slot of `ExpansionPanel`. -}
actionsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsYearView =
    actions_core


{-| Place a `MultiYearView` in the `actions` slot of `ExpansionPanel`. -}
actionsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMultiYearView =
    actions_core


{-| Place a `MonthView` in the `actions` slot of `ExpansionPanel`. -}
actionsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsMonthView =
    actions_core


{-| Place a `Tooltip` in the `actions` slot of `ExpansionPanel`. -}
actionsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTooltip =
    actions_core


{-| Place a `RichTooltip` in the `actions` slot of `ExpansionPanel`. -}
actionsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsRichTooltip =
    actions_core


{-| Place a `TooltipElementBase` in the `actions` slot of `ExpansionPanel`. -}
actionsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTooltipElementBase =
    actions_core


{-| Place a `RichTooltipAction` in the `actions` slot of `ExpansionPanel`. -}
actionsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsRichTooltipAction =
    actions_core


{-| Place a `ButtonGroup` in the `actions` slot of `ExpansionPanel`. -}
actionsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsButtonGroup =
    actions_core


{-| Place a `IconButton` in the `actions` slot of `ExpansionPanel`. -}
actionsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsIconButton =
    actions_core


{-| Place a `Button` in the `actions` slot of `ExpansionPanel`. -}
actionsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsButton =
    actions_core


{-| Place a `Breadcrumb` in the `actions` slot of `ExpansionPanel`. -}
actionsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBreadcrumb =
    actions_core


{-| Place a `BreadcrumbItem` in the `actions` slot of `ExpansionPanel`. -}
actionsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBreadcrumbItem =
    actions_core


{-| Place a `BreadcrumbItemButton` in the `actions` slot of `ExpansionPanel`. -}
actionsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBreadcrumbItemButton =
    actions_core


{-| Place a `BottomSheetTrigger` in the `actions` slot of `ExpansionPanel`. -}
actionsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBottomSheetTrigger =
    actions_core


{-| Place a `BottomSheet` in the `actions` slot of `ExpansionPanel`. -}
actionsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBottomSheet =
    actions_core


{-| Place a `BottomSheetAction` in the `actions` slot of `ExpansionPanel`. -}
actionsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBottomSheetAction =
    actions_core


{-| Place a `Badge` in the `actions` slot of `ExpansionPanel`. -}
actionsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsBadge =
    actions_core


{-| Place a `Avatar` in the `actions` slot of `ExpansionPanel`. -}
actionsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsAvatar =
    actions_core


{-| Place a `Autocomplete` in the `actions` slot of `ExpansionPanel`. -}
actionsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsAutocomplete =
    actions_core


{-| Place a `FormField` in the `actions` slot of `ExpansionPanel`. -}
actionsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFormField =
    actions_core


{-| Place a `OptionPanel` in the `actions` slot of `ExpansionPanel`. -}
actionsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsOptionPanel =
    actions_core


{-| Place a `FloatingPanel` in the `actions` slot of `ExpansionPanel`. -}
actionsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFloatingPanel =
    actions_core


{-| Place a `Optgroup` in the `actions` slot of `ExpansionPanel`. -}
actionsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsOptgroup =
    actions_core


{-| Place a `Option` in the `actions` slot of `ExpansionPanel`. -}
actionsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsOption =
    actions_core


{-| Place a `FocusTrap` in the `actions` slot of `ExpansionPanel`. -}
actionsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFocusTrap =
    actions_core


{-| Place a `AppBar` in the `actions` slot of `ExpansionPanel`. -}
actionsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsAppBar =
    actions_core


{-| Place a `TextOverflow` in the `actions` slot of `ExpansionPanel`. -}
actionsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTextOverflow =
    actions_core


{-| Place a `TextHighlight` in the `actions` slot of `ExpansionPanel`. -}
actionsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsTextHighlight =
    actions_core


{-| Place a `StateLayer` in the `actions` slot of `ExpansionPanel`. -}
actionsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsStateLayer =
    actions_core


{-| Place a `Slide` in the `actions` slot of `ExpansionPanel`. -}
actionsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsSlide =
    actions_core


{-| Place a `ScrollContainer` in the `actions` slot of `ExpansionPanel`. -}
actionsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsScrollContainer =
    actions_core


{-| Place a `Ripple` in the `actions` slot of `ExpansionPanel`. -}
actionsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsRipple =
    actions_core


{-| Place a `PseudoRadio` in the `actions` slot of `ExpansionPanel`. -}
actionsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsPseudoRadio =
    actions_core


{-| Place a `PseudoCheckbox` in the `actions` slot of `ExpansionPanel`. -}
actionsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsPseudoCheckbox =
    actions_core


{-| Place a `FocusRing` in the `actions` slot of `ExpansionPanel`. -}
actionsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsFocusRing =
    actions_core


{-| Place a `Elevation` in the `actions` slot of `ExpansionPanel`. -}
actionsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsElevation =
    actions_core


{-| Place a `Collapsible` in the `actions` slot of `ExpansionPanel`. -}
actionsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsCollapsible =
    actions_core


{-| Place a `ActionElementBase` in the `actions` slot of `ExpansionPanel`. -}
actionsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actionsActionElementBase =
    actions_core