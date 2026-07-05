module M3e.Build.AppBar.Slots exposing
    ( leadingIcon, leading_iconButton, leadingButton, leadingIconTree, leadingIconTreeItem, leadingIconToolbar
    , leadingIconToc, leadingIconTocItem, leadingIconThemeIcon, leadingIconTheme, leadingIconTextareaAutosize, leadingIconTabs, leadingIconTabPanel
    , leadingIconTab, leadingIconSwitch, leadingIconStepperReset, leadingIconStepperPrevious, leadingIconStep, leadingIconStepPanel, leadingIconStepper
    , leadingIconSplitPane, leadingIconSplitButton, leadingIconSnackbar, leadingIconSlider, leadingIconSliderThumb, leadingIconSlideGroup, leadingIconSkeleton
    , leadingIconShape, leadingIconSegmentedButton, leadingIconButtonSegment, leadingIconSearchView, leadingIconSearchBar, leadingIconRadioGroup, leadingIconRadio
    , leadingIconProgressElementIndicatorBase, leadingIconPaginator, leadingIconSelect, leadingIconNavRailToggle, leadingIconNavRail, leadingIconNavMenuItemGroup, leadingIconNavMenu
    , leadingIconNavMenuItem, leadingIconNavBar, leadingIconNavItem, leadingIconMenuItemRadio, leadingIconMenuItemGroup, leadingIconMenuItemCheckbox, leadingIconMenu
    , leadingIconMenuItem, leadingIconMenuTrigger, leadingIconMenuItemElementBase, leadingIconLoadingIndicator, leadingIconSelectionList, leadingIconListOption, leadingIconActionList
    , leadingIconExpandableListItem, leadingIconListAction, leadingIconListItemButton, leadingIconList, leadingIconListItem, leadingIconIcon, leadingIconHeading
    , leadingIconFabMenuTrigger, leadingIconFabMenu, leadingIconFab, leadingIconAccordion, leadingIconExpansionPanel, leadingIconExpansionHeader, leadingIconDrawerToggle
    , leadingIconDrawerContainer, leadingIconDivider, leadingIconDialogTrigger, leadingIconDialog, leadingIconDialogAction, leadingIconDatepickerToggle, leadingIconDatepicker
    , leadingIconContentPane, leadingIconSuggestionChip, leadingIconInputChipSet, leadingIconInputChip, leadingIconFilterChipSet, leadingIconFilterChip, leadingIconChipSet
    , leadingIconAssistChip, leadingIconChip, leadingIconCheckbox, leadingIconCard, leadingIconCalendar, leadingIconYearView, leadingIconMultiYearView
    , leadingIconMonthView, leadingIconTooltip, leadingIconRichTooltip, leadingIconTooltipElementBase, leadingIconRichTooltipAction, leadingIconButtonGroup, leadingIconIconButton
    , leadingIcon_button, leadingIconBreadcrumb, leadingIconBreadcrumbItem, leadingIconBreadcrumbItemButton, leadingIconBottomSheetTrigger, leadingIconBottomSheet, leadingIconBottomSheetAction
    , leadingIconBadge, leadingIconAvatar, leadingIconAutocomplete, leadingIconFormField, leadingIconOptionPanel, leadingIconFloatingPanel, leadingIconOptgroup
    , leadingIconOption, leadingIconFocusTrap, leadingIconAppBar, leadingIconTextOverflow, leadingIconTextHighlight, leadingIconStateLayer, leadingIconSlide
    , leadingIconScrollContainer, leadingIconRipple, leadingIconPseudoRadio, leadingIconPseudoCheckbox, leadingIconFocusRing, leadingIconElevation, leadingIconCollapsible
    , leadingIconActionElementBase, trailingIconTree, trailingIconTreeItem, trailingIconToolbar, trailingIconToc, trailingIconTocItem, trailingIconThemeIcon
    , trailingIconTheme, trailingIconTextareaAutosize, trailingIconTabs, trailingIconTabPanel, trailingIconTab, trailingIconSwitch, trailingIconStepperReset
    , trailingIconStepperPrevious, trailingIconStep, trailingIconStepPanel, trailingIconStepper, trailingIconSplitPane, trailingIconSplitButton, trailingIconSnackbar
    , trailingIconSlider, trailingIconSliderThumb, trailingIconSlideGroup, trailingIconSkeleton, trailingIconShape, trailingIconSegmentedButton, trailingIconButtonSegment
    , trailingIconSearchView, trailingIconSearchBar, trailingIconRadioGroup, trailingIconRadio, trailingIconProgressElementIndicatorBase, trailingIconPaginator, trailingIconSelect
    , trailingIconNavRailToggle, trailingIconNavRail, trailingIconNavMenuItemGroup, trailingIconNavMenu, trailingIconNavMenuItem, trailingIconNavBar, trailingIconNavItem
    , trailingIconMenuItemRadio, trailingIconMenuItemGroup, trailingIconMenuItemCheckbox, trailingIconMenu, trailingIconMenuItem, trailingIconMenuTrigger, trailingIconMenuItemElementBase
    , trailingIconLoadingIndicator, trailingIconSelectionList, trailingIconListOption, trailingIconActionList, trailingIconExpandableListItem, trailingIconListAction, trailingIconListItemButton
    , trailingIconList, trailingIconListItem, trailingIconIcon, trailingIconHeading, trailingIconFabMenuTrigger, trailingIconFabMenu, trailingIconFab
    , trailingIconAccordion, trailingIconExpansionPanel, trailingIconExpansionHeader, trailingIconDrawerToggle, trailingIconDrawerContainer, trailingIconDivider, trailingIconDialogTrigger
    , trailingIconDialog, trailingIconDialogAction, trailingIconDatepickerToggle, trailingIconDatepicker, trailingIconContentPane, trailingIconSuggestionChip, trailingIconInputChipSet
    , trailingIconInputChip, trailingIconFilterChipSet, trailingIconFilterChip, trailingIconChipSet, trailingIconAssistChip, trailingIconChip, trailingIconCheckbox
    , trailingIconCard, trailingIconCalendar, trailingIconYearView, trailingIconMultiYearView, trailingIconMonthView, trailingIconTooltip, trailingIconRichTooltip
    , trailingIconTooltipElementBase, trailingIconRichTooltipAction, trailingIconButtonGroup, trailingIconIconButton, trailingIcon_button, trailingIconBreadcrumb, trailingIconBreadcrumbItem
    , trailingIconBreadcrumbItemButton, trailingIconBottomSheetTrigger, trailingIconBottomSheet, trailingIconBottomSheetAction, trailingIconBadge, trailingIconAvatar, trailingIconAutocomplete
    , trailingIconFormField, trailingIconOptionPanel, trailingIconFloatingPanel, trailingIconOptgroup, trailingIconOption, trailingIconFocusTrap, trailingIconAppBar
    , trailingIconTextOverflow, trailingIconTextHighlight, trailingIconStateLayer, trailingIconSlide, trailingIconScrollContainer, trailingIconRipple, trailingIconPseudoRadio
    , trailingIconPseudoCheckbox, trailingIconFocusRing, trailingIconElevation, trailingIconCollapsible, trailingIconActionElementBase, trailingSearchBar, trailing_iconButton
    , trailingButton
    )

{-|
Slot setters for `M3e.Build.AppBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIcon, leading_iconButton, leadingButton, leadingIconTree, leadingIconTreeItem, leadingIconToolbar
@docs leadingIconToc, leadingIconTocItem, leadingIconThemeIcon, leadingIconTheme, leadingIconTextareaAutosize, leadingIconTabs
@docs leadingIconTabPanel, leadingIconTab, leadingIconSwitch, leadingIconStepperReset, leadingIconStepperPrevious, leadingIconStep
@docs leadingIconStepPanel, leadingIconStepper, leadingIconSplitPane, leadingIconSplitButton, leadingIconSnackbar, leadingIconSlider
@docs leadingIconSliderThumb, leadingIconSlideGroup, leadingIconSkeleton, leadingIconShape, leadingIconSegmentedButton, leadingIconButtonSegment
@docs leadingIconSearchView, leadingIconSearchBar, leadingIconRadioGroup, leadingIconRadio, leadingIconProgressElementIndicatorBase, leadingIconPaginator
@docs leadingIconSelect, leadingIconNavRailToggle, leadingIconNavRail, leadingIconNavMenuItemGroup, leadingIconNavMenu, leadingIconNavMenuItem
@docs leadingIconNavBar, leadingIconNavItem, leadingIconMenuItemRadio, leadingIconMenuItemGroup, leadingIconMenuItemCheckbox, leadingIconMenu
@docs leadingIconMenuItem, leadingIconMenuTrigger, leadingIconMenuItemElementBase, leadingIconLoadingIndicator, leadingIconSelectionList, leadingIconListOption
@docs leadingIconActionList, leadingIconExpandableListItem, leadingIconListAction, leadingIconListItemButton, leadingIconList, leadingIconListItem
@docs leadingIconIcon, leadingIconHeading, leadingIconFabMenuTrigger, leadingIconFabMenu, leadingIconFab, leadingIconAccordion
@docs leadingIconExpansionPanel, leadingIconExpansionHeader, leadingIconDrawerToggle, leadingIconDrawerContainer, leadingIconDivider, leadingIconDialogTrigger
@docs leadingIconDialog, leadingIconDialogAction, leadingIconDatepickerToggle, leadingIconDatepicker, leadingIconContentPane, leadingIconSuggestionChip
@docs leadingIconInputChipSet, leadingIconInputChip, leadingIconFilterChipSet, leadingIconFilterChip, leadingIconChipSet, leadingIconAssistChip
@docs leadingIconChip, leadingIconCheckbox, leadingIconCard, leadingIconCalendar, leadingIconYearView, leadingIconMultiYearView
@docs leadingIconMonthView, leadingIconTooltip, leadingIconRichTooltip, leadingIconTooltipElementBase, leadingIconRichTooltipAction, leadingIconButtonGroup
@docs leadingIconIconButton, leadingIcon_button, leadingIconBreadcrumb, leadingIconBreadcrumbItem, leadingIconBreadcrumbItemButton, leadingIconBottomSheetTrigger
@docs leadingIconBottomSheet, leadingIconBottomSheetAction, leadingIconBadge, leadingIconAvatar, leadingIconAutocomplete, leadingIconFormField
@docs leadingIconOptionPanel, leadingIconFloatingPanel, leadingIconOptgroup, leadingIconOption, leadingIconFocusTrap, leadingIconAppBar
@docs leadingIconTextOverflow, leadingIconTextHighlight, leadingIconStateLayer, leadingIconSlide, leadingIconScrollContainer, leadingIconRipple
@docs leadingIconPseudoRadio, leadingIconPseudoCheckbox, leadingIconFocusRing, leadingIconElevation, leadingIconCollapsible, leadingIconActionElementBase
@docs trailingIconTree, trailingIconTreeItem, trailingIconToolbar, trailingIconToc, trailingIconTocItem, trailingIconThemeIcon
@docs trailingIconTheme, trailingIconTextareaAutosize, trailingIconTabs, trailingIconTabPanel, trailingIconTab, trailingIconSwitch
@docs trailingIconStepperReset, trailingIconStepperPrevious, trailingIconStep, trailingIconStepPanel, trailingIconStepper, trailingIconSplitPane
@docs trailingIconSplitButton, trailingIconSnackbar, trailingIconSlider, trailingIconSliderThumb, trailingIconSlideGroup, trailingIconSkeleton
@docs trailingIconShape, trailingIconSegmentedButton, trailingIconButtonSegment, trailingIconSearchView, trailingIconSearchBar, trailingIconRadioGroup
@docs trailingIconRadio, trailingIconProgressElementIndicatorBase, trailingIconPaginator, trailingIconSelect, trailingIconNavRailToggle, trailingIconNavRail
@docs trailingIconNavMenuItemGroup, trailingIconNavMenu, trailingIconNavMenuItem, trailingIconNavBar, trailingIconNavItem, trailingIconMenuItemRadio
@docs trailingIconMenuItemGroup, trailingIconMenuItemCheckbox, trailingIconMenu, trailingIconMenuItem, trailingIconMenuTrigger, trailingIconMenuItemElementBase
@docs trailingIconLoadingIndicator, trailingIconSelectionList, trailingIconListOption, trailingIconActionList, trailingIconExpandableListItem, trailingIconListAction
@docs trailingIconListItemButton, trailingIconList, trailingIconListItem, trailingIconIcon, trailingIconHeading, trailingIconFabMenuTrigger
@docs trailingIconFabMenu, trailingIconFab, trailingIconAccordion, trailingIconExpansionPanel, trailingIconExpansionHeader, trailingIconDrawerToggle
@docs trailingIconDrawerContainer, trailingIconDivider, trailingIconDialogTrigger, trailingIconDialog, trailingIconDialogAction, trailingIconDatepickerToggle
@docs trailingIconDatepicker, trailingIconContentPane, trailingIconSuggestionChip, trailingIconInputChipSet, trailingIconInputChip, trailingIconFilterChipSet
@docs trailingIconFilterChip, trailingIconChipSet, trailingIconAssistChip, trailingIconChip, trailingIconCheckbox, trailingIconCard
@docs trailingIconCalendar, trailingIconYearView, trailingIconMultiYearView, trailingIconMonthView, trailingIconTooltip, trailingIconRichTooltip
@docs trailingIconTooltipElementBase, trailingIconRichTooltipAction, trailingIconButtonGroup, trailingIconIconButton, trailingIcon_button, trailingIconBreadcrumb
@docs trailingIconBreadcrumbItem, trailingIconBreadcrumbItemButton, trailingIconBottomSheetTrigger, trailingIconBottomSheet, trailingIconBottomSheetAction, trailingIconBadge
@docs trailingIconAvatar, trailingIconAutocomplete, trailingIconFormField, trailingIconOptionPanel, trailingIconFloatingPanel, trailingIconOptgroup
@docs trailingIconOption, trailingIconFocusTrap, trailingIconAppBar, trailingIconTextOverflow, trailingIconTextHighlight, trailingIconStateLayer
@docs trailingIconSlide, trailingIconScrollContainer, trailingIconRipple, trailingIconPseudoRadio, trailingIconPseudoCheckbox, trailingIconFocusRing
@docs trailingIconElevation, trailingIconCollapsible, trailingIconActionElementBase, trailingSearchBar, trailing_iconButton, trailingButton
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


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


leadingIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailingIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `leading` slot of `AppBar`. -}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingIcon =
    leading_core


{-| Place a `IconButton` in the `leading` slot of `AppBar`. -}
leading_iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leading_iconButton =
    leading_core


{-| Place a `Button` in the `leading` slot of `AppBar`. -}
leadingButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingButton =
    leading_core


{-| Place a `Tree` in the `leading-icon` slot of `AppBar`. -}
leadingIconTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTree =
    leadingIcon_core


{-| Place a `TreeItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTreeItem =
    leadingIcon_core


{-| Place a `Toolbar` in the `leading-icon` slot of `AppBar`. -}
leadingIconToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconToolbar =
    leadingIcon_core


{-| Place a `Toc` in the `leading-icon` slot of `AppBar`. -}
leadingIconToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconToc =
    leadingIcon_core


{-| Place a `TocItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTocItem =
    leadingIcon_core


{-| Place a `ThemeIcon` in the `leading-icon` slot of `AppBar`. -}
leadingIconThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconThemeIcon =
    leadingIcon_core


{-| Place a `Theme` in the `leading-icon` slot of `AppBar`. -}
leadingIconTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTheme =
    leadingIcon_core


{-| Place a `TextareaAutosize` in the `leading-icon` slot of `AppBar`. -}
leadingIconTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTextareaAutosize =
    leadingIcon_core


{-| Place a `Tabs` in the `leading-icon` slot of `AppBar`. -}
leadingIconTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTabs =
    leadingIcon_core


{-| Place a `TabPanel` in the `leading-icon` slot of `AppBar`. -}
leadingIconTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTabPanel =
    leadingIcon_core


{-| Place a `Tab` in the `leading-icon` slot of `AppBar`. -}
leadingIconTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTab =
    leadingIcon_core


{-| Place a `Switch` in the `leading-icon` slot of `AppBar`. -}
leadingIconSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSwitch =
    leadingIcon_core


{-| Place a `StepperReset` in the `leading-icon` slot of `AppBar`. -}
leadingIconStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStepperReset =
    leadingIcon_core


{-| Place a `StepperPrevious` in the `leading-icon` slot of `AppBar`. -}
leadingIconStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStepperPrevious =
    leadingIcon_core


{-| Place a `Step` in the `leading-icon` slot of `AppBar`. -}
leadingIconStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStep =
    leadingIcon_core


{-| Place a `StepPanel` in the `leading-icon` slot of `AppBar`. -}
leadingIconStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStepPanel =
    leadingIcon_core


{-| Place a `Stepper` in the `leading-icon` slot of `AppBar`. -}
leadingIconStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStepper =
    leadingIcon_core


{-| Place a `SplitPane` in the `leading-icon` slot of `AppBar`. -}
leadingIconSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSplitPane =
    leadingIcon_core


{-| Place a `SplitButton` in the `leading-icon` slot of `AppBar`. -}
leadingIconSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSplitButton =
    leadingIcon_core


{-| Place a `Snackbar` in the `leading-icon` slot of `AppBar`. -}
leadingIconSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSnackbar =
    leadingIcon_core


{-| Place a `Slider` in the `leading-icon` slot of `AppBar`. -}
leadingIconSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSlider =
    leadingIcon_core


{-| Place a `SliderThumb` in the `leading-icon` slot of `AppBar`. -}
leadingIconSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSliderThumb =
    leadingIcon_core


{-| Place a `SlideGroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSlideGroup =
    leadingIcon_core


{-| Place a `Skeleton` in the `leading-icon` slot of `AppBar`. -}
leadingIconSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSkeleton =
    leadingIcon_core


{-| Place a `Shape` in the `leading-icon` slot of `AppBar`. -}
leadingIconShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconShape =
    leadingIcon_core


{-| Place a `SegmentedButton` in the `leading-icon` slot of `AppBar`. -}
leadingIconSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSegmentedButton =
    leadingIcon_core


{-| Place a `ButtonSegment` in the `leading-icon` slot of `AppBar`. -}
leadingIconButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconButtonSegment =
    leadingIcon_core


{-| Place a `SearchView` in the `leading-icon` slot of `AppBar`. -}
leadingIconSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSearchView =
    leadingIcon_core


{-| Place a `SearchBar` in the `leading-icon` slot of `AppBar`. -}
leadingIconSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSearchBar =
    leadingIcon_core


{-| Place a `RadioGroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconRadioGroup =
    leadingIcon_core


{-| Place a `Radio` in the `leading-icon` slot of `AppBar`. -}
leadingIconRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconRadio =
    leadingIcon_core


{-| Place a `ProgressElementIndicatorBase` in the `leading-icon` slot of `AppBar`. -}
leadingIconProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconProgressElementIndicatorBase =
    leadingIcon_core


{-| Place a `Paginator` in the `leading-icon` slot of `AppBar`. -}
leadingIconPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconPaginator =
    leadingIcon_core


{-| Place a `Select` in the `leading-icon` slot of `AppBar`. -}
leadingIconSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSelect =
    leadingIcon_core


{-| Place a `NavRailToggle` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavRailToggle =
    leadingIcon_core


{-| Place a `NavRail` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavRail =
    leadingIcon_core


{-| Place a `NavMenuItemGroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavMenuItemGroup =
    leadingIcon_core


{-| Place a `NavMenu` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavMenu =
    leadingIcon_core


{-| Place a `NavMenuItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavMenuItem =
    leadingIcon_core


{-| Place a `NavBar` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavBar =
    leadingIcon_core


{-| Place a `NavItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconNavItem =
    leadingIcon_core


{-| Place a `MenuItemRadio` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuItemRadio =
    leadingIcon_core


{-| Place a `MenuItemGroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuItemGroup =
    leadingIcon_core


{-| Place a `MenuItemCheckbox` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuItemCheckbox =
    leadingIcon_core


{-| Place a `Menu` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenu =
    leadingIcon_core


{-| Place a `MenuItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuItem =
    leadingIcon_core


{-| Place a `MenuTrigger` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuTrigger =
    leadingIcon_core


{-| Place a `MenuItemElementBase` in the `leading-icon` slot of `AppBar`. -}
leadingIconMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMenuItemElementBase =
    leadingIcon_core


{-| Place a `LoadingIndicator` in the `leading-icon` slot of `AppBar`. -}
leadingIconLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconLoadingIndicator =
    leadingIcon_core


{-| Place a `SelectionList` in the `leading-icon` slot of `AppBar`. -}
leadingIconSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSelectionList =
    leadingIcon_core


{-| Place a `ListOption` in the `leading-icon` slot of `AppBar`. -}
leadingIconListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconListOption =
    leadingIcon_core


{-| Place a `ActionList` in the `leading-icon` slot of `AppBar`. -}
leadingIconActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconActionList =
    leadingIcon_core


{-| Place a `ExpandableListItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconExpandableListItem =
    leadingIcon_core


{-| Place a `ListAction` in the `leading-icon` slot of `AppBar`. -}
leadingIconListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconListAction =
    leadingIcon_core


{-| Place a `ListItemButton` in the `leading-icon` slot of `AppBar`. -}
leadingIconListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconListItemButton =
    leadingIcon_core


{-| Place a `List` in the `leading-icon` slot of `AppBar`. -}
leadingIconList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconList =
    leadingIcon_core


{-| Place a `ListItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconListItem =
    leadingIcon_core


{-| Place a `Icon` in the `leading-icon` slot of `AppBar`. -}
leadingIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconIcon =
    leadingIcon_core


{-| Place a `Heading` in the `leading-icon` slot of `AppBar`. -}
leadingIconHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconHeading =
    leadingIcon_core


{-| Place a `FabMenuTrigger` in the `leading-icon` slot of `AppBar`. -}
leadingIconFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFabMenuTrigger =
    leadingIcon_core


{-| Place a `FabMenu` in the `leading-icon` slot of `AppBar`. -}
leadingIconFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFabMenu =
    leadingIcon_core


{-| Place a `Fab` in the `leading-icon` slot of `AppBar`. -}
leadingIconFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFab =
    leadingIcon_core


{-| Place a `Accordion` in the `leading-icon` slot of `AppBar`. -}
leadingIconAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconAccordion =
    leadingIcon_core


{-| Place a `ExpansionPanel` in the `leading-icon` slot of `AppBar`. -}
leadingIconExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconExpansionPanel =
    leadingIcon_core


{-| Place a `ExpansionHeader` in the `leading-icon` slot of `AppBar`. -}
leadingIconExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconExpansionHeader =
    leadingIcon_core


{-| Place a `DrawerToggle` in the `leading-icon` slot of `AppBar`. -}
leadingIconDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDrawerToggle =
    leadingIcon_core


{-| Place a `DrawerContainer` in the `leading-icon` slot of `AppBar`. -}
leadingIconDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDrawerContainer =
    leadingIcon_core


{-| Place a `Divider` in the `leading-icon` slot of `AppBar`. -}
leadingIconDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDivider =
    leadingIcon_core


{-| Place a `DialogTrigger` in the `leading-icon` slot of `AppBar`. -}
leadingIconDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDialogTrigger =
    leadingIcon_core


{-| Place a `Dialog` in the `leading-icon` slot of `AppBar`. -}
leadingIconDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDialog =
    leadingIcon_core


{-| Place a `DialogAction` in the `leading-icon` slot of `AppBar`. -}
leadingIconDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDialogAction =
    leadingIcon_core


{-| Place a `DatepickerToggle` in the `leading-icon` slot of `AppBar`. -}
leadingIconDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDatepickerToggle =
    leadingIcon_core


{-| Place a `Datepicker` in the `leading-icon` slot of `AppBar`. -}
leadingIconDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconDatepicker =
    leadingIcon_core


{-| Place a `ContentPane` in the `leading-icon` slot of `AppBar`. -}
leadingIconContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconContentPane =
    leadingIcon_core


{-| Place a `SuggestionChip` in the `leading-icon` slot of `AppBar`. -}
leadingIconSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSuggestionChip =
    leadingIcon_core


{-| Place a `InputChipSet` in the `leading-icon` slot of `AppBar`. -}
leadingIconInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconInputChipSet =
    leadingIcon_core


{-| Place a `InputChip` in the `leading-icon` slot of `AppBar`. -}
leadingIconInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconInputChip =
    leadingIcon_core


{-| Place a `FilterChipSet` in the `leading-icon` slot of `AppBar`. -}
leadingIconFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFilterChipSet =
    leadingIcon_core


{-| Place a `FilterChip` in the `leading-icon` slot of `AppBar`. -}
leadingIconFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFilterChip =
    leadingIcon_core


{-| Place a `ChipSet` in the `leading-icon` slot of `AppBar`. -}
leadingIconChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconChipSet =
    leadingIcon_core


{-| Place a `AssistChip` in the `leading-icon` slot of `AppBar`. -}
leadingIconAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconAssistChip =
    leadingIcon_core


{-| Place a `Chip` in the `leading-icon` slot of `AppBar`. -}
leadingIconChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconChip =
    leadingIcon_core


{-| Place a `Checkbox` in the `leading-icon` slot of `AppBar`. -}
leadingIconCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconCheckbox =
    leadingIcon_core


{-| Place a `Card` in the `leading-icon` slot of `AppBar`. -}
leadingIconCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconCard =
    leadingIcon_core


{-| Place a `Calendar` in the `leading-icon` slot of `AppBar`. -}
leadingIconCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconCalendar =
    leadingIcon_core


{-| Place a `YearView` in the `leading-icon` slot of `AppBar`. -}
leadingIconYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconYearView =
    leadingIcon_core


{-| Place a `MultiYearView` in the `leading-icon` slot of `AppBar`. -}
leadingIconMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMultiYearView =
    leadingIcon_core


{-| Place a `MonthView` in the `leading-icon` slot of `AppBar`. -}
leadingIconMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconMonthView =
    leadingIcon_core


{-| Place a `Tooltip` in the `leading-icon` slot of `AppBar`. -}
leadingIconTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTooltip =
    leadingIcon_core


{-| Place a `RichTooltip` in the `leading-icon` slot of `AppBar`. -}
leadingIconRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconRichTooltip =
    leadingIcon_core


{-| Place a `TooltipElementBase` in the `leading-icon` slot of `AppBar`. -}
leadingIconTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTooltipElementBase =
    leadingIcon_core


{-| Place a `RichTooltipAction` in the `leading-icon` slot of `AppBar`. -}
leadingIconRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconRichTooltipAction =
    leadingIcon_core


{-| Place a `ButtonGroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconButtonGroup =
    leadingIcon_core


{-| Place a `IconButton` in the `leading-icon` slot of `AppBar`. -}
leadingIconIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconIconButton =
    leadingIcon_core


{-| Place a `Button` in the `leading-icon` slot of `AppBar`. -}
leadingIcon_button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIcon_button =
    leadingIcon_core


{-| Place a `Breadcrumb` in the `leading-icon` slot of `AppBar`. -}
leadingIconBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBreadcrumb =
    leadingIcon_core


{-| Place a `BreadcrumbItem` in the `leading-icon` slot of `AppBar`. -}
leadingIconBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBreadcrumbItem =
    leadingIcon_core


{-| Place a `BreadcrumbItemButton` in the `leading-icon` slot of `AppBar`. -}
leadingIconBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBreadcrumbItemButton =
    leadingIcon_core


{-| Place a `BottomSheetTrigger` in the `leading-icon` slot of `AppBar`. -}
leadingIconBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBottomSheetTrigger =
    leadingIcon_core


{-| Place a `BottomSheet` in the `leading-icon` slot of `AppBar`. -}
leadingIconBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBottomSheet =
    leadingIcon_core


{-| Place a `BottomSheetAction` in the `leading-icon` slot of `AppBar`. -}
leadingIconBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBottomSheetAction =
    leadingIcon_core


{-| Place a `Badge` in the `leading-icon` slot of `AppBar`. -}
leadingIconBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconBadge =
    leadingIcon_core


{-| Place a `Avatar` in the `leading-icon` slot of `AppBar`. -}
leadingIconAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconAvatar =
    leadingIcon_core


{-| Place a `Autocomplete` in the `leading-icon` slot of `AppBar`. -}
leadingIconAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconAutocomplete =
    leadingIcon_core


{-| Place a `FormField` in the `leading-icon` slot of `AppBar`. -}
leadingIconFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFormField =
    leadingIcon_core


{-| Place a `OptionPanel` in the `leading-icon` slot of `AppBar`. -}
leadingIconOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconOptionPanel =
    leadingIcon_core


{-| Place a `FloatingPanel` in the `leading-icon` slot of `AppBar`. -}
leadingIconFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFloatingPanel =
    leadingIcon_core


{-| Place a `Optgroup` in the `leading-icon` slot of `AppBar`. -}
leadingIconOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconOptgroup =
    leadingIcon_core


{-| Place a `Option` in the `leading-icon` slot of `AppBar`. -}
leadingIconOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconOption =
    leadingIcon_core


{-| Place a `FocusTrap` in the `leading-icon` slot of `AppBar`. -}
leadingIconFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFocusTrap =
    leadingIcon_core


{-| Place a `AppBar` in the `leading-icon` slot of `AppBar`. -}
leadingIconAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconAppBar =
    leadingIcon_core


{-| Place a `TextOverflow` in the `leading-icon` slot of `AppBar`. -}
leadingIconTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTextOverflow =
    leadingIcon_core


{-| Place a `TextHighlight` in the `leading-icon` slot of `AppBar`. -}
leadingIconTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconTextHighlight =
    leadingIcon_core


{-| Place a `StateLayer` in the `leading-icon` slot of `AppBar`. -}
leadingIconStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconStateLayer =
    leadingIcon_core


{-| Place a `Slide` in the `leading-icon` slot of `AppBar`. -}
leadingIconSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconSlide =
    leadingIcon_core


{-| Place a `ScrollContainer` in the `leading-icon` slot of `AppBar`. -}
leadingIconScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconScrollContainer =
    leadingIcon_core


{-| Place a `Ripple` in the `leading-icon` slot of `AppBar`. -}
leadingIconRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconRipple =
    leadingIcon_core


{-| Place a `PseudoRadio` in the `leading-icon` slot of `AppBar`. -}
leadingIconPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconPseudoRadio =
    leadingIcon_core


{-| Place a `PseudoCheckbox` in the `leading-icon` slot of `AppBar`. -}
leadingIconPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconPseudoCheckbox =
    leadingIcon_core


{-| Place a `FocusRing` in the `leading-icon` slot of `AppBar`. -}
leadingIconFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconFocusRing =
    leadingIcon_core


{-| Place a `Elevation` in the `leading-icon` slot of `AppBar`. -}
leadingIconElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconElevation =
    leadingIcon_core


{-| Place a `Collapsible` in the `leading-icon` slot of `AppBar`. -}
leadingIconCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconCollapsible =
    leadingIcon_core


{-| Place a `ActionElementBase` in the `leading-icon` slot of `AppBar`. -}
leadingIconActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | leadingIcon : M3e.Build.Internal.Used
    } msg pk
leadingIconActionElementBase =
    leadingIcon_core


{-| Place a `Tree` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTree :
    M3e.Build.Tree.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTree =
    trailingIcon_core


{-| Place a `TreeItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTreeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTreeItem =
    trailingIcon_core


{-| Place a `Toolbar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconToolbar :
    M3e.Build.Toolbar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconToolbar =
    trailingIcon_core


{-| Place a `Toc` in the `trailing-icon` slot of `AppBar`. -}
trailingIconToc :
    M3e.Build.Toc.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconToc =
    trailingIcon_core


{-| Place a `TocItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTocItem :
    M3e.Build.TocItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTocItem =
    trailingIcon_core


{-| Place a `ThemeIcon` in the `trailing-icon` slot of `AppBar`. -}
trailingIconThemeIcon :
    M3e.Build.ThemeIcon.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconThemeIcon =
    trailingIcon_core


{-| Place a `Theme` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTheme :
    M3e.Build.Theme.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTheme =
    trailingIcon_core


{-| Place a `TextareaAutosize` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTextareaAutosize :
    M3e.Build.TextareaAutosize.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTextareaAutosize =
    trailingIcon_core


{-| Place a `Tabs` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTabs :
    M3e.Build.Tabs.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTabs =
    trailingIcon_core


{-| Place a `TabPanel` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTabPanel =
    trailingIcon_core


{-| Place a `Tab` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTab =
    trailingIcon_core


{-| Place a `Switch` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSwitch =
    trailingIcon_core


{-| Place a `StepperReset` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStepperReset =
    trailingIcon_core


{-| Place a `StepperPrevious` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStepperPrevious =
    trailingIcon_core


{-| Place a `Step` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStep =
    trailingIcon_core


{-| Place a `StepPanel` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStepPanel =
    trailingIcon_core


{-| Place a `Stepper` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStepper :
    M3e.Build.Stepper.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStepper =
    trailingIcon_core


{-| Place a `SplitPane` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSplitPane :
    M3e.Build.SplitPane.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSplitPane =
    trailingIcon_core


{-| Place a `SplitButton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSplitButton :
    M3e.Build.SplitButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSplitButton =
    trailingIcon_core


{-| Place a `Snackbar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSnackbar :
    M3e.Build.Snackbar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSnackbar =
    trailingIcon_core


{-| Place a `Slider` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSlider :
    M3e.Build.Slider.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSlider =
    trailingIcon_core


{-| Place a `SliderThumb` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSliderThumb :
    M3e.Build.SliderThumb.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSliderThumb =
    trailingIcon_core


{-| Place a `SlideGroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSlideGroup :
    M3e.Build.SlideGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSlideGroup =
    trailingIcon_core


{-| Place a `Skeleton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSkeleton :
    M3e.Build.Skeleton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSkeleton =
    trailingIcon_core


{-| Place a `Shape` in the `trailing-icon` slot of `AppBar`. -}
trailingIconShape :
    M3e.Build.Shape.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconShape =
    trailingIcon_core


{-| Place a `SegmentedButton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSegmentedButton :
    M3e.Build.SegmentedButton.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSegmentedButton =
    trailingIcon_core


{-| Place a `ButtonSegment` in the `trailing-icon` slot of `AppBar`. -}
trailingIconButtonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconButtonSegment =
    trailingIcon_core


{-| Place a `SearchView` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSearchView :
    M3e.Build.SearchView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSearchView =
    trailingIcon_core


{-| Place a `SearchBar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSearchBar =
    trailingIcon_core


{-| Place a `RadioGroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconRadioGroup :
    M3e.Build.RadioGroup.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconRadioGroup =
    trailingIcon_core


{-| Place a `Radio` in the `trailing-icon` slot of `AppBar`. -}
trailingIconRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconRadio =
    trailingIcon_core


{-| Place a `ProgressElementIndicatorBase` in the `trailing-icon` slot of `AppBar`. -}
trailingIconProgressElementIndicatorBase :
    M3e.Build.ProgressElementIndicatorBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconProgressElementIndicatorBase =
    trailingIcon_core


{-| Place a `Paginator` in the `trailing-icon` slot of `AppBar`. -}
trailingIconPaginator :
    M3e.Build.Paginator.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconPaginator =
    trailingIcon_core


{-| Place a `Select` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSelect :
    M3e.Build.Select.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSelect =
    trailingIcon_core


{-| Place a `NavRailToggle` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavRailToggle =
    trailingIcon_core


{-| Place a `NavRail` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavRail :
    M3e.Build.NavRail.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavRail =
    trailingIcon_core


{-| Place a `NavMenuItemGroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavMenuItemGroup =
    trailingIcon_core


{-| Place a `NavMenu` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavMenu :
    M3e.Build.NavMenu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavMenu =
    trailingIcon_core


{-| Place a `NavMenuItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavMenuItem =
    trailingIcon_core


{-| Place a `NavBar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavBar :
    M3e.Build.NavBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavBar =
    trailingIcon_core


{-| Place a `NavItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconNavItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconNavItem =
    trailingIcon_core


{-| Place a `MenuItemRadio` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuItemRadio =
    trailingIcon_core


{-| Place a `MenuItemGroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuItemGroup =
    trailingIcon_core


{-| Place a `MenuItemCheckbox` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuItemCheckbox =
    trailingIcon_core


{-| Place a `Menu` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenu :
    M3e.Build.Menu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenu =
    trailingIcon_core


{-| Place a `MenuItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuItem =
    trailingIcon_core


{-| Place a `MenuTrigger` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuTrigger =
    trailingIcon_core


{-| Place a `MenuItemElementBase` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMenuItemElementBase :
    M3e.Build.MenuItemElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMenuItemElementBase =
    trailingIcon_core


{-| Place a `LoadingIndicator` in the `trailing-icon` slot of `AppBar`. -}
trailingIconLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconLoadingIndicator =
    trailingIcon_core


{-| Place a `SelectionList` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSelectionList :
    M3e.Build.SelectionList.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSelectionList =
    trailingIcon_core


{-| Place a `ListOption` in the `trailing-icon` slot of `AppBar`. -}
trailingIconListOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconListOption =
    trailingIcon_core


{-| Place a `ActionList` in the `trailing-icon` slot of `AppBar`. -}
trailingIconActionList :
    M3e.Build.ActionList.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconActionList =
    trailingIcon_core


{-| Place a `ExpandableListItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconExpandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconExpandableListItem =
    trailingIcon_core


{-| Place a `ListAction` in the `trailing-icon` slot of `AppBar`. -}
trailingIconListAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconListAction =
    trailingIcon_core


{-| Place a `ListItemButton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconListItemButton :
    M3e.Build.ListItemButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconListItemButton =
    trailingIcon_core


{-| Place a `List` in the `trailing-icon` slot of `AppBar`. -}
trailingIconList :
    M3e.Build.List.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconList =
    trailingIcon_core


{-| Place a `ListItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconListItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconListItem =
    trailingIcon_core


{-| Place a `Icon` in the `trailing-icon` slot of `AppBar`. -}
trailingIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconIcon =
    trailingIcon_core


{-| Place a `Heading` in the `trailing-icon` slot of `AppBar`. -}
trailingIconHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconHeading =
    trailingIcon_core


{-| Place a `FabMenuTrigger` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFabMenuTrigger =
    trailingIcon_core


{-| Place a `FabMenu` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFabMenu :
    M3e.Build.FabMenu.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFabMenu =
    trailingIcon_core


{-| Place a `Fab` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFab =
    trailingIcon_core


{-| Place a `Accordion` in the `trailing-icon` slot of `AppBar`. -}
trailingIconAccordion :
    M3e.Build.Accordion.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconAccordion =
    trailingIcon_core


{-| Place a `ExpansionPanel` in the `trailing-icon` slot of `AppBar`. -}
trailingIconExpansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconExpansionPanel =
    trailingIcon_core


{-| Place a `ExpansionHeader` in the `trailing-icon` slot of `AppBar`. -}
trailingIconExpansionHeader :
    M3e.Build.ExpansionHeader.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconExpansionHeader =
    trailingIcon_core


{-| Place a `DrawerToggle` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDrawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDrawerToggle =
    trailingIcon_core


{-| Place a `DrawerContainer` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDrawerContainer :
    M3e.Build.DrawerContainer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDrawerContainer =
    trailingIcon_core


{-| Place a `Divider` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDivider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDivider =
    trailingIcon_core


{-| Place a `DialogTrigger` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDialogTrigger =
    trailingIcon_core


{-| Place a `Dialog` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDialog :
    M3e.Build.Dialog.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDialog =
    trailingIcon_core


{-| Place a `DialogAction` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDialogAction =
    trailingIcon_core


{-| Place a `DatepickerToggle` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDatepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDatepickerToggle =
    trailingIcon_core


{-| Place a `Datepicker` in the `trailing-icon` slot of `AppBar`. -}
trailingIconDatepicker :
    M3e.Build.Datepicker.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconDatepicker =
    trailingIcon_core


{-| Place a `ContentPane` in the `trailing-icon` slot of `AppBar`. -}
trailingIconContentPane :
    M3e.Build.ContentPane.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconContentPane =
    trailingIcon_core


{-| Place a `SuggestionChip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSuggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSuggestionChip =
    trailingIcon_core


{-| Place a `InputChipSet` in the `trailing-icon` slot of `AppBar`. -}
trailingIconInputChipSet :
    M3e.Build.InputChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconInputChipSet =
    trailingIcon_core


{-| Place a `InputChip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconInputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconInputChip =
    trailingIcon_core


{-| Place a `FilterChipSet` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFilterChipSet :
    M3e.Build.FilterChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFilterChipSet =
    trailingIcon_core


{-| Place a `FilterChip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFilterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFilterChip =
    trailingIcon_core


{-| Place a `ChipSet` in the `trailing-icon` slot of `AppBar`. -}
trailingIconChipSet :
    M3e.Build.ChipSet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconChipSet =
    trailingIcon_core


{-| Place a `AssistChip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconAssistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconAssistChip =
    trailingIcon_core


{-| Place a `Chip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconChip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconChip =
    trailingIcon_core


{-| Place a `Checkbox` in the `trailing-icon` slot of `AppBar`. -}
trailingIconCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconCheckbox =
    trailingIcon_core


{-| Place a `Card` in the `trailing-icon` slot of `AppBar`. -}
trailingIconCard :
    M3e.Build.Card.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconCard =
    trailingIcon_core


{-| Place a `Calendar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconCalendar :
    M3e.Build.Calendar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconCalendar =
    trailingIcon_core


{-| Place a `YearView` in the `trailing-icon` slot of `AppBar`. -}
trailingIconYearView :
    M3e.Build.YearView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconYearView =
    trailingIcon_core


{-| Place a `MultiYearView` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMultiYearView :
    M3e.Build.MultiYearView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMultiYearView =
    trailingIcon_core


{-| Place a `MonthView` in the `trailing-icon` slot of `AppBar`. -}
trailingIconMonthView :
    M3e.Build.MonthView.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconMonthView =
    trailingIcon_core


{-| Place a `Tooltip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTooltip :
    M3e.Build.Tooltip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTooltip =
    trailingIcon_core


{-| Place a `RichTooltip` in the `trailing-icon` slot of `AppBar`. -}
trailingIconRichTooltip :
    M3e.Build.RichTooltip.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconRichTooltip =
    trailingIcon_core


{-| Place a `TooltipElementBase` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTooltipElementBase :
    M3e.Build.TooltipElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTooltipElementBase =
    trailingIcon_core


{-| Place a `RichTooltipAction` in the `trailing-icon` slot of `AppBar`. -}
trailingIconRichTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconRichTooltipAction =
    trailingIcon_core


{-| Place a `ButtonGroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconButtonGroup :
    M3e.Build.ButtonGroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconButtonGroup =
    trailingIcon_core


{-| Place a `IconButton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconIconButton =
    trailingIcon_core


{-| Place a `Button` in the `trailing-icon` slot of `AppBar`. -}
trailingIcon_button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIcon_button =
    trailingIcon_core


{-| Place a `Breadcrumb` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBreadcrumb :
    M3e.Build.Breadcrumb.Builder ca { cs
        | default : M3e.Build.Internal.Filled
    } msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBreadcrumb =
    trailingIcon_core


{-| Place a `BreadcrumbItem` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBreadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBreadcrumbItem =
    trailingIcon_core


{-| Place a `BreadcrumbItemButton` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBreadcrumbItemButton :
    M3e.Build.BreadcrumbItemButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBreadcrumbItemButton =
    trailingIcon_core


{-| Place a `BottomSheetTrigger` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBottomSheetTrigger =
    trailingIcon_core


{-| Place a `BottomSheet` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBottomSheet :
    M3e.Build.BottomSheet.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBottomSheet =
    trailingIcon_core


{-| Place a `BottomSheetAction` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBottomSheetAction =
    trailingIcon_core


{-| Place a `Badge` in the `trailing-icon` slot of `AppBar`. -}
trailingIconBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconBadge =
    trailingIcon_core


{-| Place a `Avatar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconAvatar =
    trailingIcon_core


{-| Place a `Autocomplete` in the `trailing-icon` slot of `AppBar`. -}
trailingIconAutocomplete :
    M3e.Build.Autocomplete.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconAutocomplete =
    trailingIcon_core


{-| Place a `FormField` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFormField :
    M3e.Build.FormField.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFormField =
    trailingIcon_core


{-| Place a `OptionPanel` in the `trailing-icon` slot of `AppBar`. -}
trailingIconOptionPanel :
    M3e.Build.OptionPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconOptionPanel =
    trailingIcon_core


{-| Place a `FloatingPanel` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFloatingPanel :
    M3e.Build.FloatingPanel.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFloatingPanel =
    trailingIcon_core


{-| Place a `Optgroup` in the `trailing-icon` slot of `AppBar`. -}
trailingIconOptgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconOptgroup =
    trailingIcon_core


{-| Place a `Option` in the `trailing-icon` slot of `AppBar`. -}
trailingIconOption :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconOption =
    trailingIcon_core


{-| Place a `FocusTrap` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFocusTrap :
    M3e.Build.FocusTrap.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFocusTrap =
    trailingIcon_core


{-| Place a `AppBar` in the `trailing-icon` slot of `AppBar`. -}
trailingIconAppBar :
    M3e.Build.AppBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconAppBar =
    trailingIcon_core


{-| Place a `TextOverflow` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTextOverflow :
    M3e.Build.TextOverflow.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTextOverflow =
    trailingIcon_core


{-| Place a `TextHighlight` in the `trailing-icon` slot of `AppBar`. -}
trailingIconTextHighlight :
    M3e.Build.TextHighlight.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconTextHighlight =
    trailingIcon_core


{-| Place a `StateLayer` in the `trailing-icon` slot of `AppBar`. -}
trailingIconStateLayer :
    M3e.Build.StateLayer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconStateLayer =
    trailingIcon_core


{-| Place a `Slide` in the `trailing-icon` slot of `AppBar`. -}
trailingIconSlide :
    M3e.Build.Slide.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconSlide =
    trailingIcon_core


{-| Place a `ScrollContainer` in the `trailing-icon` slot of `AppBar`. -}
trailingIconScrollContainer :
    M3e.Build.ScrollContainer.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconScrollContainer =
    trailingIcon_core


{-| Place a `Ripple` in the `trailing-icon` slot of `AppBar`. -}
trailingIconRipple :
    M3e.Build.Ripple.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconRipple =
    trailingIcon_core


{-| Place a `PseudoRadio` in the `trailing-icon` slot of `AppBar`. -}
trailingIconPseudoRadio :
    M3e.Build.PseudoRadio.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconPseudoRadio =
    trailingIcon_core


{-| Place a `PseudoCheckbox` in the `trailing-icon` slot of `AppBar`. -}
trailingIconPseudoCheckbox :
    M3e.Build.PseudoCheckbox.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconPseudoCheckbox =
    trailingIcon_core


{-| Place a `FocusRing` in the `trailing-icon` slot of `AppBar`. -}
trailingIconFocusRing :
    M3e.Build.FocusRing.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconFocusRing =
    trailingIcon_core


{-| Place a `Elevation` in the `trailing-icon` slot of `AppBar`. -}
trailingIconElevation :
    M3e.Build.Elevation.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconElevation =
    trailingIcon_core


{-| Place a `Collapsible` in the `trailing-icon` slot of `AppBar`. -}
trailingIconCollapsible :
    M3e.Build.Collapsible.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconCollapsible =
    trailingIcon_core


{-| Place a `ActionElementBase` in the `trailing-icon` slot of `AppBar`. -}
trailingIconActionElementBase :
    M3e.Build.ActionElementBase.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.AppBar.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconActionElementBase =
    trailingIcon_core


{-| Place a `SearchBar` in the `trailing` slot of `AppBar`. -}
trailingSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailingSearchBar =
    trailing_core


{-| Place a `IconButton` in the `trailing` slot of `AppBar`. -}
trailing_iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailing_iconButton =
    trailing_core


{-| Place a `Button` in the `trailing` slot of `AppBar`. -}
trailingButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailingButton =
    trailing_core