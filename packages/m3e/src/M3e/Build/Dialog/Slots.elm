module M3e.Build.Dialog.Slots exposing
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
    , actionsPseudoCheckbox, actionsFocusRing, actionsElevation, actionsCollapsible, actionsActionElementBase, closeIconIcon, tree
    , treeItem, toolbar, toc, tocItem, themeIcon, theme, textareaAutosize
    , tabs, tabPanel, tab, switch, stepperReset, stepperPrevious, step
    , stepPanel, stepper, splitPane, splitButton, snackbar, slider, sliderThumb
    , slideGroup, skeleton, shape, segmentedButton, buttonSegment, searchView, searchBar
    , radioGroup, radio, progressElementIndicatorBase, paginator, select, navRailToggle, navRail
    , navMenuItemGroup, navMenu, navMenuItem, navBar, navItem, menuItemRadio, menuItemGroup
    , menuItemCheckbox, menu, menuItem, menuTrigger, menuItemElementBase, loadingIndicator, selectionList
    , listOption, actionList, expandableListItem, listAction, listItemButton, list, listItem
    , icon, heading, fabMenuTrigger, fabMenu, fab, accordion, expansionPanel
    , expansionHeader, drawerToggle, drawerContainer, divider, dialogTrigger, dialog, dialogAction
    , datepickerToggle, datepicker, contentPane, suggestionChip, inputChipSet, inputChip, filterChipSet
    , filterChip, chipSet, assistChip, chip, checkbox, card, calendar
    , yearView, multiYearView, monthView, tooltip, richTooltip, tooltipElementBase, richTooltipAction
    , buttonGroup, iconButton, button, breadcrumb, breadcrumbItem, breadcrumbItemButton, bottomSheetTrigger
    , bottomSheet, bottomSheetAction, badge, avatar, autocomplete, formField, optionPanel
    , floatingPanel, optgroup, option, focusTrap, appBar, textOverflow, textHighlight
    , stateLayer, slide, scrollContainer, ripple, pseudoRadio, pseudoCheckbox, focusRing
    , elevation, collapsible, actionElementBase
    )

{-|
Slot setters for `M3e.Build.Dialog`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

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
@docs actionsElevation, actionsCollapsible, actionsActionElementBase, closeIconIcon, tree, treeItem
@docs toolbar, toc, tocItem, themeIcon, theme, textareaAutosize
@docs tabs, tabPanel, tab, switch, stepperReset, stepperPrevious
@docs step, stepPanel, stepper, splitPane, splitButton, snackbar
@docs slider, sliderThumb, slideGroup, skeleton, shape, segmentedButton
@docs buttonSegment, searchView, searchBar, radioGroup, radio, progressElementIndicatorBase
@docs paginator, select, navRailToggle, navRail, navMenuItemGroup, navMenu
@docs navMenuItem, navBar, navItem, menuItemRadio, menuItemGroup, menuItemCheckbox
@docs menu, menuItem, menuTrigger, menuItemElementBase, loadingIndicator, selectionList
@docs listOption, actionList, expandableListItem, listAction, listItemButton, list
@docs listItem, icon, heading, fabMenuTrigger, fabMenu, fab
@docs accordion, expansionPanel, expansionHeader, drawerToggle, drawerContainer, divider
@docs dialogTrigger, dialog, dialogAction, datepickerToggle, datepicker, contentPane
@docs suggestionChip, inputChipSet, inputChip, filterChipSet, filterChip, chipSet
@docs assistChip, chip, checkbox, card, calendar, yearView
@docs multiYearView, monthView, tooltip, richTooltip, tooltipElementBase, richTooltipAction
@docs buttonGroup, iconButton, button, breadcrumb, breadcrumbItem, breadcrumbItemButton
@docs bottomSheetTrigger, bottomSheet, bottomSheetAction, badge, avatar, autocomplete
@docs formField, optionPanel, floatingPanel, optgroup, option, focusTrap
@docs appBar, textOverflow, textHighlight, stateLayer, slide, scrollContainer
@docs ripple, pseudoRadio, pseudoCheckbox, focusRing, elevation, collapsible
@docs actionElementBase
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
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actions_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


closeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Dialog.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Tree` in the `actions` slot of `Dialog`. -}
actionsTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTree =
    actions_core


{-| Place a `TreeItem` in the `actions` slot of `Dialog`. -}
actionsTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTreeItem =
    actions_core


{-| Place a `Toolbar` in the `actions` slot of `Dialog`. -}
actionsToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToolbar =
    actions_core


{-| Place a `Toc` in the `actions` slot of `Dialog`. -}
actionsToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsToc =
    actions_core


{-| Place a `TocItem` in the `actions` slot of `Dialog`. -}
actionsTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTocItem =
    actions_core


{-| Place a `ThemeIcon` in the `actions` slot of `Dialog`. -}
actionsThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsThemeIcon =
    actions_core


{-| Place a `Theme` in the `actions` slot of `Dialog`. -}
actionsTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTheme =
    actions_core


{-| Place a `TextareaAutosize` in the `actions` slot of `Dialog`. -}
actionsTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextareaAutosize =
    actions_core


{-| Place a `Tabs` in the `actions` slot of `Dialog`. -}
actionsTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabs =
    actions_core


{-| Place a `TabPanel` in the `actions` slot of `Dialog`. -}
actionsTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTabPanel =
    actions_core


{-| Place a `Tab` in the `actions` slot of `Dialog`. -}
actionsTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTab =
    actions_core


{-| Place a `Switch` in the `actions` slot of `Dialog`. -}
actionsSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSwitch =
    actions_core


{-| Place a `StepperReset` in the `actions` slot of `Dialog`. -}
actionsStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperReset =
    actions_core


{-| Place a `StepperPrevious` in the `actions` slot of `Dialog`. -}
actionsStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepperPrevious =
    actions_core


{-| Place a `Step` in the `actions` slot of `Dialog`. -}
actionsStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStep =
    actions_core


{-| Place a `StepPanel` in the `actions` slot of `Dialog`. -}
actionsStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepPanel =
    actions_core


{-| Place a `Stepper` in the `actions` slot of `Dialog`. -}
actionsStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStepper =
    actions_core


{-| Place a `SplitPane` in the `actions` slot of `Dialog`. -}
actionsSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitPane =
    actions_core


{-| Place a `SplitButton` in the `actions` slot of `Dialog`. -}
actionsSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSplitButton =
    actions_core


{-| Place a `Snackbar` in the `actions` slot of `Dialog`. -}
actionsSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSnackbar =
    actions_core


{-| Place a `Slider` in the `actions` slot of `Dialog`. -}
actionsSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlider =
    actions_core


{-| Place a `SliderThumb` in the `actions` slot of `Dialog`. -}
actionsSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSliderThumb =
    actions_core


{-| Place a `SlideGroup` in the `actions` slot of `Dialog`. -}
actionsSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlideGroup =
    actions_core


{-| Place a `Skeleton` in the `actions` slot of `Dialog`. -}
actionsSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSkeleton =
    actions_core


{-| Place a `Shape` in the `actions` slot of `Dialog`. -}
actionsShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsShape =
    actions_core


{-| Place a `SegmentedButton` in the `actions` slot of `Dialog`. -}
actionsSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSegmentedButton =
    actions_core


{-| Place a `ButtonSegment` in the `actions` slot of `Dialog`. -}
actionsButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonSegment =
    actions_core


{-| Place a `SearchView` in the `actions` slot of `Dialog`. -}
actionsSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchView =
    actions_core


{-| Place a `SearchBar` in the `actions` slot of `Dialog`. -}
actionsSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSearchBar =
    actions_core


{-| Place a `RadioGroup` in the `actions` slot of `Dialog`. -}
actionsRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadioGroup =
    actions_core


{-| Place a `Radio` in the `actions` slot of `Dialog`. -}
actionsRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRadio =
    actions_core


{-| Place a `ProgressElementIndicatorBase` in the `actions` slot of `Dialog`. -}
actionsProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsProgressElementIndicatorBase =
    actions_core


{-| Place a `Paginator` in the `actions` slot of `Dialog`. -}
actionsPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPaginator =
    actions_core


{-| Place a `Select` in the `actions` slot of `Dialog`. -}
actionsSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelect =
    actions_core


{-| Place a `NavRailToggle` in the `actions` slot of `Dialog`. -}
actionsNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRailToggle =
    actions_core


{-| Place a `NavRail` in the `actions` slot of `Dialog`. -}
actionsNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavRail =
    actions_core


{-| Place a `NavMenuItemGroup` in the `actions` slot of `Dialog`. -}
actionsNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItemGroup =
    actions_core


{-| Place a `NavMenu` in the `actions` slot of `Dialog`. -}
actionsNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenu =
    actions_core


{-| Place a `NavMenuItem` in the `actions` slot of `Dialog`. -}
actionsNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavMenuItem =
    actions_core


{-| Place a `NavBar` in the `actions` slot of `Dialog`. -}
actionsNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavBar =
    actions_core


{-| Place a `NavItem` in the `actions` slot of `Dialog`. -}
actionsNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsNavItem =
    actions_core


{-| Place a `MenuItemRadio` in the `actions` slot of `Dialog`. -}
actionsMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemRadio =
    actions_core


{-| Place a `MenuItemGroup` in the `actions` slot of `Dialog`. -}
actionsMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemGroup =
    actions_core


{-| Place a `MenuItemCheckbox` in the `actions` slot of `Dialog`. -}
actionsMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemCheckbox =
    actions_core


{-| Place a `Menu` in the `actions` slot of `Dialog`. -}
actionsMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenu =
    actions_core


{-| Place a `MenuItem` in the `actions` slot of `Dialog`. -}
actionsMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItem =
    actions_core


{-| Place a `MenuTrigger` in the `actions` slot of `Dialog`. -}
actionsMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuTrigger =
    actions_core


{-| Place a `MenuItemElementBase` in the `actions` slot of `Dialog`. -}
actionsMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMenuItemElementBase =
    actions_core


{-| Place a `LoadingIndicator` in the `actions` slot of `Dialog`. -}
actionsLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsLoadingIndicator =
    actions_core


{-| Place a `SelectionList` in the `actions` slot of `Dialog`. -}
actionsSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSelectionList =
    actions_core


{-| Place a `ListOption` in the `actions` slot of `Dialog`. -}
actionsListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListOption =
    actions_core


{-| Place a `ActionList` in the `actions` slot of `Dialog`. -}
actionsActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionList =
    actions_core


{-| Place a `ExpandableListItem` in the `actions` slot of `Dialog`. -}
actionsExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpandableListItem =
    actions_core


{-| Place a `ListAction` in the `actions` slot of `Dialog`. -}
actionsListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListAction =
    actions_core


{-| Place a `ListItemButton` in the `actions` slot of `Dialog`. -}
actionsListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItemButton =
    actions_core


{-| Place a `List` in the `actions` slot of `Dialog`. -}
actionsList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsList =
    actions_core


{-| Place a `ListItem` in the `actions` slot of `Dialog`. -}
actionsListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsListItem =
    actions_core


{-| Place a `Icon` in the `actions` slot of `Dialog`. -}
actionsIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIcon =
    actions_core


{-| Place a `Heading` in the `actions` slot of `Dialog`. -}
actionsHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsHeading =
    actions_core


{-| Place a `FabMenuTrigger` in the `actions` slot of `Dialog`. -}
actionsFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenuTrigger =
    actions_core


{-| Place a `FabMenu` in the `actions` slot of `Dialog`. -}
actionsFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFabMenu =
    actions_core


{-| Place a `Fab` in the `actions` slot of `Dialog`. -}
actionsFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFab =
    actions_core


{-| Place a `Accordion` in the `actions` slot of `Dialog`. -}
actionsAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAccordion =
    actions_core


{-| Place a `ExpansionPanel` in the `actions` slot of `Dialog`. -}
actionsExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionPanel =
    actions_core


{-| Place a `ExpansionHeader` in the `actions` slot of `Dialog`. -}
actionsExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsExpansionHeader =
    actions_core


{-| Place a `DrawerToggle` in the `actions` slot of `Dialog`. -}
actionsDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerToggle =
    actions_core


{-| Place a `DrawerContainer` in the `actions` slot of `Dialog`. -}
actionsDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDrawerContainer =
    actions_core


{-| Place a `Divider` in the `actions` slot of `Dialog`. -}
actionsDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDivider =
    actions_core


{-| Place a `DialogTrigger` in the `actions` slot of `Dialog`. -}
actionsDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogTrigger =
    actions_core


{-| Place a `Dialog` in the `actions` slot of `Dialog`. -}
actionsDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialog =
    actions_core


{-| Place a `DialogAction` in the `actions` slot of `Dialog`. -}
actionsDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDialogAction =
    actions_core


{-| Place a `DatepickerToggle` in the `actions` slot of `Dialog`. -}
actionsDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepickerToggle =
    actions_core


{-| Place a `Datepicker` in the `actions` slot of `Dialog`. -}
actionsDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsDatepicker =
    actions_core


{-| Place a `ContentPane` in the `actions` slot of `Dialog`. -}
actionsContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsContentPane =
    actions_core


{-| Place a `SuggestionChip` in the `actions` slot of `Dialog`. -}
actionsSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSuggestionChip =
    actions_core


{-| Place a `InputChipSet` in the `actions` slot of `Dialog`. -}
actionsInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChipSet =
    actions_core


{-| Place a `InputChip` in the `actions` slot of `Dialog`. -}
actionsInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsInputChip =
    actions_core


{-| Place a `FilterChipSet` in the `actions` slot of `Dialog`. -}
actionsFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChipSet =
    actions_core


{-| Place a `FilterChip` in the `actions` slot of `Dialog`. -}
actionsFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFilterChip =
    actions_core


{-| Place a `ChipSet` in the `actions` slot of `Dialog`. -}
actionsChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChipSet =
    actions_core


{-| Place a `AssistChip` in the `actions` slot of `Dialog`. -}
actionsAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAssistChip =
    actions_core


{-| Place a `Chip` in the `actions` slot of `Dialog`. -}
actionsChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsChip =
    actions_core


{-| Place a `Checkbox` in the `actions` slot of `Dialog`. -}
actionsCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCheckbox =
    actions_core


{-| Place a `Card` in the `actions` slot of `Dialog`. -}
actionsCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCard =
    actions_core


{-| Place a `Calendar` in the `actions` slot of `Dialog`. -}
actionsCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCalendar =
    actions_core


{-| Place a `YearView` in the `actions` slot of `Dialog`. -}
actionsYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsYearView =
    actions_core


{-| Place a `MultiYearView` in the `actions` slot of `Dialog`. -}
actionsMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMultiYearView =
    actions_core


{-| Place a `MonthView` in the `actions` slot of `Dialog`. -}
actionsMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsMonthView =
    actions_core


{-| Place a `Tooltip` in the `actions` slot of `Dialog`. -}
actionsTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltip =
    actions_core


{-| Place a `RichTooltip` in the `actions` slot of `Dialog`. -}
actionsRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltip =
    actions_core


{-| Place a `TooltipElementBase` in the `actions` slot of `Dialog`. -}
actionsTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTooltipElementBase =
    actions_core


{-| Place a `RichTooltipAction` in the `actions` slot of `Dialog`. -}
actionsRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRichTooltipAction =
    actions_core


{-| Place a `ButtonGroup` in the `actions` slot of `Dialog`. -}
actionsButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButtonGroup =
    actions_core


{-| Place a `IconButton` in the `actions` slot of `Dialog`. -}
actionsIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsIconButton =
    actions_core


{-| Place a `Button` in the `actions` slot of `Dialog`. -}
actionsButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsButton =
    actions_core


{-| Place a `Breadcrumb` in the `actions` slot of `Dialog`. -}
actionsBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumb =
    actions_core


{-| Place a `BreadcrumbItem` in the `actions` slot of `Dialog`. -}
actionsBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItem =
    actions_core


{-| Place a `BreadcrumbItemButton` in the `actions` slot of `Dialog`. -}
actionsBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBreadcrumbItemButton =
    actions_core


{-| Place a `BottomSheetTrigger` in the `actions` slot of `Dialog`. -}
actionsBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetTrigger =
    actions_core


{-| Place a `BottomSheet` in the `actions` slot of `Dialog`. -}
actionsBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheet =
    actions_core


{-| Place a `BottomSheetAction` in the `actions` slot of `Dialog`. -}
actionsBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBottomSheetAction =
    actions_core


{-| Place a `Badge` in the `actions` slot of `Dialog`. -}
actionsBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsBadge =
    actions_core


{-| Place a `Avatar` in the `actions` slot of `Dialog`. -}
actionsAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAvatar =
    actions_core


{-| Place a `Autocomplete` in the `actions` slot of `Dialog`. -}
actionsAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAutocomplete =
    actions_core


{-| Place a `FormField` in the `actions` slot of `Dialog`. -}
actionsFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFormField =
    actions_core


{-| Place a `OptionPanel` in the `actions` slot of `Dialog`. -}
actionsOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptionPanel =
    actions_core


{-| Place a `FloatingPanel` in the `actions` slot of `Dialog`. -}
actionsFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFloatingPanel =
    actions_core


{-| Place a `Optgroup` in the `actions` slot of `Dialog`. -}
actionsOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOptgroup =
    actions_core


{-| Place a `Option` in the `actions` slot of `Dialog`. -}
actionsOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsOption =
    actions_core


{-| Place a `FocusTrap` in the `actions` slot of `Dialog`. -}
actionsFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusTrap =
    actions_core


{-| Place a `AppBar` in the `actions` slot of `Dialog`. -}
actionsAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsAppBar =
    actions_core


{-| Place a `TextOverflow` in the `actions` slot of `Dialog`. -}
actionsTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextOverflow =
    actions_core


{-| Place a `TextHighlight` in the `actions` slot of `Dialog`. -}
actionsTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsTextHighlight =
    actions_core


{-| Place a `StateLayer` in the `actions` slot of `Dialog`. -}
actionsStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsStateLayer =
    actions_core


{-| Place a `Slide` in the `actions` slot of `Dialog`. -}
actionsSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsSlide =
    actions_core


{-| Place a `ScrollContainer` in the `actions` slot of `Dialog`. -}
actionsScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsScrollContainer =
    actions_core


{-| Place a `Ripple` in the `actions` slot of `Dialog`. -}
actionsRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsRipple =
    actions_core


{-| Place a `PseudoRadio` in the `actions` slot of `Dialog`. -}
actionsPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoRadio =
    actions_core


{-| Place a `PseudoCheckbox` in the `actions` slot of `Dialog`. -}
actionsPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsPseudoCheckbox =
    actions_core


{-| Place a `FocusRing` in the `actions` slot of `Dialog`. -}
actionsFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsFocusRing =
    actions_core


{-| Place a `Elevation` in the `actions` slot of `Dialog`. -}
actionsElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsElevation =
    actions_core


{-| Place a `Collapsible` in the `actions` slot of `Dialog`. -}
actionsCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsCollapsible =
    actions_core


{-| Place a `ActionElementBase` in the `actions` slot of `Dialog`. -}
actionsActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actionsActionElementBase =
    actions_core


{-| Place a `Icon` in the `close-icon` slot of `Dialog`. -}
closeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Dialog.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIconIcon =
    closeIcon_core


{-| Place a `Tree` in the `unnamed` slot of `Dialog`. -}
tree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tree =
    default_core


{-| Place a `TreeItem` in the `unnamed` slot of `Dialog`. -}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
treeItem =
    default_core


{-| Place a `Toolbar` in the `unnamed` slot of `Dialog`. -}
toolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
toolbar =
    default_core


{-| Place a `Toc` in the `unnamed` slot of `Dialog`. -}
toc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
toc =
    default_core


{-| Place a `TocItem` in the `unnamed` slot of `Dialog`. -}
tocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tocItem =
    default_core


{-| Place a `ThemeIcon` in the `unnamed` slot of `Dialog`. -}
themeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
themeIcon =
    default_core


{-| Place a `Theme` in the `unnamed` slot of `Dialog`. -}
theme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
theme =
    default_core


{-| Place a `TextareaAutosize` in the `unnamed` slot of `Dialog`. -}
textareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
textareaAutosize =
    default_core


{-| Place a `Tabs` in the `unnamed` slot of `Dialog`. -}
tabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tabs =
    default_core


{-| Place a `TabPanel` in the `unnamed` slot of `Dialog`. -}
tabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tabPanel =
    default_core


{-| Place a `Tab` in the `unnamed` slot of `Dialog`. -}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tab =
    default_core


{-| Place a `Switch` in the `unnamed` slot of `Dialog`. -}
switch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
switch =
    default_core


{-| Place a `StepperReset` in the `unnamed` slot of `Dialog`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `Dialog`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
stepperPrevious =
    default_core


{-| Place a `Step` in the `unnamed` slot of `Dialog`. -}
step :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
step =
    default_core


{-| Place a `StepPanel` in the `unnamed` slot of `Dialog`. -}
stepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
stepPanel =
    default_core


{-| Place a `Stepper` in the `unnamed` slot of `Dialog`. -}
stepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
stepper =
    default_core


{-| Place a `SplitPane` in the `unnamed` slot of `Dialog`. -}
splitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
splitPane =
    default_core


{-| Place a `SplitButton` in the `unnamed` slot of `Dialog`. -}
splitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
splitButton =
    default_core


{-| Place a `Snackbar` in the `unnamed` slot of `Dialog`. -}
snackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
snackbar =
    default_core


{-| Place a `Slider` in the `unnamed` slot of `Dialog`. -}
slider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
slider =
    default_core


{-| Place a `SliderThumb` in the `unnamed` slot of `Dialog`. -}
sliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
sliderThumb =
    default_core


{-| Place a `SlideGroup` in the `unnamed` slot of `Dialog`. -}
slideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
slideGroup =
    default_core


{-| Place a `Skeleton` in the `unnamed` slot of `Dialog`. -}
skeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
skeleton =
    default_core


{-| Place a `Shape` in the `unnamed` slot of `Dialog`. -}
shape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
shape =
    default_core


{-| Place a `SegmentedButton` in the `unnamed` slot of `Dialog`. -}
segmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
segmentedButton =
    default_core


{-| Place a `ButtonSegment` in the `unnamed` slot of `Dialog`. -}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
buttonSegment =
    default_core


{-| Place a `SearchView` in the `unnamed` slot of `Dialog`. -}
searchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
searchView =
    default_core


{-| Place a `SearchBar` in the `unnamed` slot of `Dialog`. -}
searchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
searchBar =
    default_core


{-| Place a `RadioGroup` in the `unnamed` slot of `Dialog`. -}
radioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
radioGroup =
    default_core


{-| Place a `Radio` in the `unnamed` slot of `Dialog`. -}
radio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
radio =
    default_core


{-| Place a `ProgressElementIndicatorBase` in the `unnamed` slot of `Dialog`. -}
progressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
progressElementIndicatorBase =
    default_core


{-| Place a `Paginator` in the `unnamed` slot of `Dialog`. -}
paginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
paginator =
    default_core


{-| Place a `Select` in the `unnamed` slot of `Dialog`. -}
select :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
select =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `Dialog`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navRailToggle =
    default_core


{-| Place a `NavRail` in the `unnamed` slot of `Dialog`. -}
navRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navRail =
    default_core


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `Dialog`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenu` in the `unnamed` slot of `Dialog`. -}
navMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navMenu =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `Dialog`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navMenuItem =
    default_core


{-| Place a `NavBar` in the `unnamed` slot of `Dialog`. -}
navBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navBar =
    default_core


{-| Place a `NavItem` in the `unnamed` slot of `Dialog`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
navItem =
    default_core


{-| Place a `MenuItemRadio` in the `unnamed` slot of `Dialog`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `Dialog`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `Dialog`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuItemCheckbox =
    default_core


{-| Place a `Menu` in the `unnamed` slot of `Dialog`. -}
menu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menu =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `Dialog`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuItem =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `Dialog`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuTrigger =
    default_core


{-| Place a `MenuItemElementBase` in the `unnamed` slot of `Dialog`. -}
menuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
menuItemElementBase =
    default_core


{-| Place a `LoadingIndicator` in the `unnamed` slot of `Dialog`. -}
loadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
loadingIndicator =
    default_core


{-| Place a `SelectionList` in the `unnamed` slot of `Dialog`. -}
selectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
selectionList =
    default_core


{-| Place a `ListOption` in the `unnamed` slot of `Dialog`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
listOption =
    default_core


{-| Place a `ActionList` in the `unnamed` slot of `Dialog`. -}
actionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
actionList =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `Dialog`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `Dialog`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
listAction =
    default_core


{-| Place a `ListItemButton` in the `unnamed` slot of `Dialog`. -}
listItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
listItemButton =
    default_core


{-| Place a `List` in the `unnamed` slot of `Dialog`. -}
list :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
list =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `Dialog`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
listItem =
    default_core


{-| Place a `Icon` in the `unnamed` slot of `Dialog`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
icon =
    default_core


{-| Place a `Heading` in the `unnamed` slot of `Dialog`. -}
heading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
heading =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `Dialog`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
fabMenuTrigger =
    default_core


{-| Place a `FabMenu` in the `unnamed` slot of `Dialog`. -}
fabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
fabMenu =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `Dialog`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
fab =
    default_core


{-| Place a `Accordion` in the `unnamed` slot of `Dialog`. -}
accordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
accordion =
    default_core


{-| Place a `ExpansionPanel` in the `unnamed` slot of `Dialog`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
expansionPanel =
    default_core


{-| Place a `ExpansionHeader` in the `unnamed` slot of `Dialog`. -}
expansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
expansionHeader =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `Dialog`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
drawerToggle =
    default_core


{-| Place a `DrawerContainer` in the `unnamed` slot of `Dialog`. -}
drawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
drawerContainer =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `Dialog`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
divider =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `Dialog`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
dialogTrigger =
    default_core


{-| Place a `Dialog` in the `unnamed` slot of `Dialog`. -}
dialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
dialog =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `Dialog`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `Dialog`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
datepickerToggle =
    default_core


{-| Place a `Datepicker` in the `unnamed` slot of `Dialog`. -}
datepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
datepicker =
    default_core


{-| Place a `ContentPane` in the `unnamed` slot of `Dialog`. -}
contentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
contentPane =
    default_core


{-| Place a `SuggestionChip` in the `unnamed` slot of `Dialog`. -}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
suggestionChip =
    default_core


{-| Place a `InputChipSet` in the `unnamed` slot of `Dialog`. -}
inputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
inputChipSet =
    default_core


{-| Place a `InputChip` in the `unnamed` slot of `Dialog`. -}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
inputChip =
    default_core


{-| Place a `FilterChipSet` in the `unnamed` slot of `Dialog`. -}
filterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
filterChipSet =
    default_core


{-| Place a `FilterChip` in the `unnamed` slot of `Dialog`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
filterChip =
    default_core


{-| Place a `ChipSet` in the `unnamed` slot of `Dialog`. -}
chipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
chipSet =
    default_core


{-| Place a `AssistChip` in the `unnamed` slot of `Dialog`. -}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
assistChip =
    default_core


{-| Place a `Chip` in the `unnamed` slot of `Dialog`. -}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
chip =
    default_core


{-| Place a `Checkbox` in the `unnamed` slot of `Dialog`. -}
checkbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
checkbox =
    default_core


{-| Place a `Card` in the `unnamed` slot of `Dialog`. -}
card :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
card =
    default_core


{-| Place a `Calendar` in the `unnamed` slot of `Dialog`. -}
calendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
calendar =
    default_core


{-| Place a `YearView` in the `unnamed` slot of `Dialog`. -}
yearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
yearView =
    default_core


{-| Place a `MultiYearView` in the `unnamed` slot of `Dialog`. -}
multiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
multiYearView =
    default_core


{-| Place a `MonthView` in the `unnamed` slot of `Dialog`. -}
monthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
monthView =
    default_core


{-| Place a `Tooltip` in the `unnamed` slot of `Dialog`. -}
tooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tooltip =
    default_core


{-| Place a `RichTooltip` in the `unnamed` slot of `Dialog`. -}
richTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
richTooltip =
    default_core


{-| Place a `TooltipElementBase` in the `unnamed` slot of `Dialog`. -}
tooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
tooltipElementBase =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `Dialog`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
richTooltipAction =
    default_core


{-| Place a `ButtonGroup` in the `unnamed` slot of `Dialog`. -}
buttonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
buttonGroup =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `Dialog`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
iconButton =
    default_core


{-| Place a `Button` in the `unnamed` slot of `Dialog`. -}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
button =
    default_core


{-| Place a `Breadcrumb` in the `unnamed` slot of `Dialog`. -}
breadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
breadcrumb =
    default_core


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `Dialog`. -}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
breadcrumbItem =
    default_core


{-| Place a `BreadcrumbItemButton` in the `unnamed` slot of `Dialog`. -}
breadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
breadcrumbItemButton =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `Dialog`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheet` in the `unnamed` slot of `Dialog`. -}
bottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
bottomSheet =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `Dialog`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
bottomSheetAction =
    default_core


{-| Place a `Badge` in the `unnamed` slot of `Dialog`. -}
badge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
badge =
    default_core


{-| Place a `Avatar` in the `unnamed` slot of `Dialog`. -}
avatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
avatar =
    default_core


{-| Place a `Autocomplete` in the `unnamed` slot of `Dialog`. -}
autocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
autocomplete =
    default_core


{-| Place a `FormField` in the `unnamed` slot of `Dialog`. -}
formField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
formField =
    default_core


{-| Place a `OptionPanel` in the `unnamed` slot of `Dialog`. -}
optionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
optionPanel =
    default_core


{-| Place a `FloatingPanel` in the `unnamed` slot of `Dialog`. -}
floatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
floatingPanel =
    default_core


{-| Place a `Optgroup` in the `unnamed` slot of `Dialog`. -}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
optgroup =
    default_core


{-| Place a `Option` in the `unnamed` slot of `Dialog`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
option =
    default_core


{-| Place a `FocusTrap` in the `unnamed` slot of `Dialog`. -}
focusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
focusTrap =
    default_core


{-| Place a `AppBar` in the `unnamed` slot of `Dialog`. -}
appBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
appBar =
    default_core


{-| Place a `TextOverflow` in the `unnamed` slot of `Dialog`. -}
textOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
textOverflow =
    default_core


{-| Place a `TextHighlight` in the `unnamed` slot of `Dialog`. -}
textHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
textHighlight =
    default_core


{-| Place a `StateLayer` in the `unnamed` slot of `Dialog`. -}
stateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
stateLayer =
    default_core


{-| Place a `Slide` in the `unnamed` slot of `Dialog`. -}
slide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
slide =
    default_core


{-| Place a `ScrollContainer` in the `unnamed` slot of `Dialog`. -}
scrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
scrollContainer =
    default_core


{-| Place a `Ripple` in the `unnamed` slot of `Dialog`. -}
ripple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
ripple =
    default_core


{-| Place a `PseudoRadio` in the `unnamed` slot of `Dialog`. -}
pseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
pseudoRadio =
    default_core


{-| Place a `PseudoCheckbox` in the `unnamed` slot of `Dialog`. -}
pseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
pseudoCheckbox =
    default_core


{-| Place a `FocusRing` in the `unnamed` slot of `Dialog`. -}
focusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
focusRing =
    default_core


{-| Place a `Elevation` in the `unnamed` slot of `Dialog`. -}
elevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
elevation =
    default_core


{-| Place a `Collapsible` in the `unnamed` slot of `Dialog`. -}
collapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
collapsible =
    default_core


{-| Place a `ActionElementBase` in the `unnamed` slot of `Dialog`. -}
actionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
actionElementBase =
    default_core