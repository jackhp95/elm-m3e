module M3e.Build exposing
    ( Builder
    , toElement
    , AccordionIs, ActionListIs, AppBarIs, AssistChipIs, AutocompleteIs, AvatarIs, BadgeIs, BottomSheetIs, BottomSheetActionIs, BottomSheetTriggerIs, BreadcrumbIs, BreadcrumbItemIs, BreadcrumbItemButtonIs, ButtonIs, ButtonGroupIs, ButtonSegmentIs, CalendarIs, CardIs, CheckboxIs, ChipIs, ChipSetIs, CircularProgressIndicatorIs, CollapsibleIs, ContentPaneIs, DateInputIs, DatepickerIs, DatepickerToggleIs, DialogIs, DialogActionIs, DialogTriggerIs, DividerIs, DrawerContainerIs, DrawerToggleIs, ElevationIs, ExpandableListItemIs, ExpansionHeaderIs, ExpansionPanelIs, FabIs, FabMenuIs, FabMenuItemIs, FabMenuTriggerIs, FilterChipIs, FilterChipSetIs, FloatingPanelIs, FocusRingIs, FocusTrapIs, FormFieldIs, HeadingIs, IconIs, IconButtonIs, InputChipIs, InputChipSetIs, LinearProgressIndicatorIs, ListIs, ListActionIs, ListItemIs, ListItemButtonIs, ListOptionIs, LoadingIndicatorIs, MenuIs, MenuItemIs, MenuItemCheckboxIs, MenuItemGroupIs, MenuItemRadioIs, MenuTriggerIs, MonthViewIs, MultiYearViewIs, NavBarIs, NavItemIs, NavMenuIs, NavMenuItemIs, NavMenuItemGroupIs, NavRailIs, NavRailToggleIs, OptgroupIs, OptionIs, OptionPanelIs, PaginatorIs, PseudoCheckboxIs, PseudoRadioIs, RadioIs, RadioGroupIs, RichTooltipIs, RichTooltipActionIs, RippleIs, ScrollContainerIs, SearchBarIs, SearchViewIs, SegmentedButtonIs, SelectIs, SelectionIndicatorIs, SelectionListIs, ShapeIs, SkeletonIs, SlideIs, SlideGroupIs, SliderIs, SliderThumbIs, SnackbarIs, SplitButtonIs, SplitPaneIs, StateLayerIs, StepIs, StepPanelIs, StepperIs, StepperNextIs, StepperPreviousIs, StepperResetIs, SuggestionChipIs, SwitchIs, TabIs, TabPanelIs, TabsIs, TextHighlightIs, TextOverflowIs, TextareaAutosizeIs, ThemeIs, ThemeIconIs, TimepickerIs, TimepickerDialIs, TimepickerInputIs, TimepickerInputPeriodToggleIs, TimepickerToggleIs, TocIs, TocItemIs, ToolbarIs, TooltipIs, TreeIs, TreeItemIs, YearViewIs
    )

{-| The shared builder surface for the `M3e` brand: the opaque `Builder`
and the single `toElement` that closes any component's builder. Per-component
modules provide the seeds (`build`) and the narrowed `withX` setters; they all
share this one representation, so `toElement` is defined once (in
`M3e.Build.Internal`) and re-exported here.

The `Is` aliases (`ButtonIs`, `CardIs`, …) let you annotate a phantom-kind
type without importing the component or its builder module.

@docs Builder
@docs toElement
@docs AccordionIs, ActionListIs, AppBarIs, AssistChipIs, AutocompleteIs, AvatarIs, BadgeIs, BottomSheetIs, BottomSheetActionIs, BottomSheetTriggerIs, BreadcrumbIs, BreadcrumbItemIs, BreadcrumbItemButtonIs, ButtonIs, ButtonGroupIs, ButtonSegmentIs, CalendarIs, CardIs, CheckboxIs, ChipIs, ChipSetIs, CircularProgressIndicatorIs, CollapsibleIs, ContentPaneIs, DateInputIs, DatepickerIs, DatepickerToggleIs, DialogIs, DialogActionIs, DialogTriggerIs, DividerIs, DrawerContainerIs, DrawerToggleIs, ElevationIs, ExpandableListItemIs, ExpansionHeaderIs, ExpansionPanelIs, FabIs, FabMenuIs, FabMenuItemIs, FabMenuTriggerIs, FilterChipIs, FilterChipSetIs, FloatingPanelIs, FocusRingIs, FocusTrapIs, FormFieldIs, HeadingIs, IconIs, IconButtonIs, InputChipIs, InputChipSetIs, LinearProgressIndicatorIs, ListIs, ListActionIs, ListItemIs, ListItemButtonIs, ListOptionIs, LoadingIndicatorIs, MenuIs, MenuItemIs, MenuItemCheckboxIs, MenuItemGroupIs, MenuItemRadioIs, MenuTriggerIs, MonthViewIs, MultiYearViewIs, NavBarIs, NavItemIs, NavMenuIs, NavMenuItemIs, NavMenuItemGroupIs, NavRailIs, NavRailToggleIs, OptgroupIs, OptionIs, OptionPanelIs, PaginatorIs, PseudoCheckboxIs, PseudoRadioIs, RadioIs, RadioGroupIs, RichTooltipIs, RichTooltipActionIs, RippleIs, ScrollContainerIs, SearchBarIs, SearchViewIs, SegmentedButtonIs, SelectIs, SelectionIndicatorIs, SelectionListIs, ShapeIs, SkeletonIs, SlideIs, SlideGroupIs, SliderIs, SliderThumbIs, SnackbarIs, SplitButtonIs, SplitPaneIs, StateLayerIs, StepIs, StepPanelIs, StepperIs, StepperNextIs, StepperPreviousIs, StepperResetIs, SuggestionChipIs, SwitchIs, TabIs, TabPanelIs, TabsIs, TextHighlightIs, TextOverflowIs, TextareaAutosizeIs, ThemeIs, ThemeIconIs, TimepickerIs, TimepickerDialIs, TimepickerInputIs, TimepickerInputPeriodToggleIs, TimepickerToggleIs, TocIs, TocItemIs, ToolbarIs, TooltipIs, TreeIs, TreeItemIs, YearViewIs

-}

import HtmlIr.Element exposing (Element)
import M3e.Accordion.Build
import M3e.ActionList.Build
import M3e.AppBar.Build
import M3e.AssistChip.Build
import M3e.Autocomplete.Build
import M3e.Avatar.Build
import M3e.Badge.Build
import M3e.BottomSheet.Build
import M3e.BottomSheetAction.Build
import M3e.BottomSheetTrigger.Build
import M3e.Breadcrumb.Build
import M3e.BreadcrumbItem.Build
import M3e.BreadcrumbItemButton.Build
import M3e.Build.Internal as Internal
import M3e.Button.Build
import M3e.ButtonGroup.Build
import M3e.ButtonSegment.Build
import M3e.Calendar.Build
import M3e.Card.Build
import M3e.Checkbox.Build
import M3e.Chip.Build
import M3e.ChipSet.Build
import M3e.CircularProgressIndicator.Build
import M3e.Collapsible.Build
import M3e.ContentPane.Build
import M3e.DateInput.Build
import M3e.Datepicker.Build
import M3e.DatepickerToggle.Build
import M3e.Dialog.Build
import M3e.DialogAction.Build
import M3e.DialogTrigger.Build
import M3e.Divider.Build
import M3e.DrawerContainer.Build
import M3e.DrawerToggle.Build
import M3e.Elevation.Build
import M3e.ExpandableListItem.Build
import M3e.ExpansionHeader.Build
import M3e.ExpansionPanel.Build
import M3e.Fab.Build
import M3e.FabMenu.Build
import M3e.FabMenuItem.Build
import M3e.FabMenuTrigger.Build
import M3e.FilterChip.Build
import M3e.FilterChipSet.Build
import M3e.FloatingPanel.Build
import M3e.FocusRing.Build
import M3e.FocusTrap.Build
import M3e.FormField.Build
import M3e.Heading.Build
import M3e.Icon.Build
import M3e.IconButton.Build
import M3e.InputChip.Build
import M3e.InputChipSet.Build
import M3e.LinearProgressIndicator.Build
import M3e.List.Build
import M3e.ListAction.Build
import M3e.ListItem.Build
import M3e.ListItemButton.Build
import M3e.ListOption.Build
import M3e.LoadingIndicator.Build
import M3e.Menu.Build
import M3e.MenuItem.Build
import M3e.MenuItemCheckbox.Build
import M3e.MenuItemGroup.Build
import M3e.MenuItemRadio.Build
import M3e.MenuTrigger.Build
import M3e.MonthView.Build
import M3e.MultiYearView.Build
import M3e.NavBar.Build
import M3e.NavItem.Build
import M3e.NavMenu.Build
import M3e.NavMenuItem.Build
import M3e.NavMenuItemGroup.Build
import M3e.NavRail.Build
import M3e.NavRailToggle.Build
import M3e.Optgroup.Build
import M3e.Option.Build
import M3e.OptionPanel.Build
import M3e.Paginator.Build
import M3e.PseudoCheckbox.Build
import M3e.PseudoRadio.Build
import M3e.Radio.Build
import M3e.RadioGroup.Build
import M3e.RichTooltip.Build
import M3e.RichTooltipAction.Build
import M3e.Ripple.Build
import M3e.ScrollContainer.Build
import M3e.SearchBar.Build
import M3e.SearchView.Build
import M3e.SegmentedButton.Build
import M3e.Select.Build
import M3e.SelectionIndicator.Build
import M3e.SelectionList.Build
import M3e.Shape.Build
import M3e.Skeleton.Build
import M3e.Slide.Build
import M3e.SlideGroup.Build
import M3e.Slider.Build
import M3e.SliderThumb.Build
import M3e.Snackbar.Build
import M3e.SplitButton.Build
import M3e.SplitPane.Build
import M3e.StateLayer.Build
import M3e.Step.Build
import M3e.StepPanel.Build
import M3e.Stepper.Build
import M3e.StepperNext.Build
import M3e.StepperPrevious.Build
import M3e.StepperReset.Build
import M3e.SuggestionChip.Build
import M3e.Switch.Build
import M3e.Tab.Build
import M3e.TabPanel.Build
import M3e.Tabs.Build
import M3e.TextHighlight.Build
import M3e.TextOverflow.Build
import M3e.TextareaAutosize.Build
import M3e.Theme.Build
import M3e.ThemeIcon.Build
import M3e.Timepicker.Build
import M3e.TimepickerDial.Build
import M3e.TimepickerInput.Build
import M3e.TimepickerInputPeriodToggle.Build
import M3e.TimepickerToggle.Build
import M3e.Toc.Build
import M3e.TocItem.Build
import M3e.Toolbar.Build
import M3e.Tooltip.Build
import M3e.Tree.Build
import M3e.TreeItem.Build
import M3e.YearView.Build


{-| The shared pipe-builder — see each component's `Builder` alias for its
narrowed, brand-typed form.
-}
type alias Builder row attrCaps slotCaps accepts msg =
    Internal.Builder row attrCaps slotCaps accepts msg


{-| Close any builder into its element.
-}
toElement : Builder row attrCaps slotCaps accepts msg -> Element accepts admittedBy msg
toElement =
    Internal.toElement


{-| The `Accordion` kind phantom — annotate with `List (Element (AccordionIs s) admittedBy msg)`.
-}
type alias AccordionIs s =
    M3e.Accordion.Build.Is s


{-| The `ActionList` kind phantom — annotate with `List (Element (ActionListIs s) admittedBy msg)`.
-}
type alias ActionListIs s =
    M3e.ActionList.Build.Is s


{-| The `AppBar` kind phantom — annotate with `List (Element (AppBarIs s) admittedBy msg)`.
-}
type alias AppBarIs s =
    M3e.AppBar.Build.Is s


{-| The `AssistChip` kind phantom — annotate with `List (Element (AssistChipIs s) admittedBy msg)`.
-}
type alias AssistChipIs s =
    M3e.AssistChip.Build.Is s


{-| The `Autocomplete` kind phantom — annotate with `List (Element (AutocompleteIs s) admittedBy msg)`.
-}
type alias AutocompleteIs s =
    M3e.Autocomplete.Build.Is s


{-| The `Avatar` kind phantom — annotate with `List (Element (AvatarIs s) admittedBy msg)`.
-}
type alias AvatarIs s =
    M3e.Avatar.Build.Is s


{-| The `Badge` kind phantom — annotate with `List (Element (BadgeIs s) admittedBy msg)`.
-}
type alias BadgeIs s =
    M3e.Badge.Build.Is s


{-| The `BottomSheet` kind phantom — annotate with `List (Element (BottomSheetIs s) admittedBy msg)`.
-}
type alias BottomSheetIs s =
    M3e.BottomSheet.Build.Is s


{-| The `BottomSheetAction` kind phantom — annotate with `List (Element (BottomSheetActionIs s) admittedBy msg)`.
-}
type alias BottomSheetActionIs s =
    M3e.BottomSheetAction.Build.Is s


{-| The `BottomSheetTrigger` kind phantom — annotate with `List (Element (BottomSheetTriggerIs s) admittedBy msg)`.
-}
type alias BottomSheetTriggerIs s =
    M3e.BottomSheetTrigger.Build.Is s


{-| The `Breadcrumb` kind phantom — annotate with `List (Element (BreadcrumbIs s) admittedBy msg)`.
-}
type alias BreadcrumbIs s =
    M3e.Breadcrumb.Build.Is s


{-| The `BreadcrumbItem` kind phantom — annotate with `List (Element (BreadcrumbItemIs s) admittedBy msg)`.
-}
type alias BreadcrumbItemIs s =
    M3e.BreadcrumbItem.Build.Is s


{-| The `BreadcrumbItemButton` kind phantom — annotate with `List (Element (BreadcrumbItemButtonIs s) admittedBy msg)`.
-}
type alias BreadcrumbItemButtonIs s =
    M3e.BreadcrumbItemButton.Build.Is s


{-| The `Button` kind phantom — annotate with `List (Element (ButtonIs s) admittedBy msg)`.
-}
type alias ButtonIs s =
    M3e.Button.Build.Is s


{-| The `ButtonGroup` kind phantom — annotate with `List (Element (ButtonGroupIs s) admittedBy msg)`.
-}
type alias ButtonGroupIs s =
    M3e.ButtonGroup.Build.Is s


{-| The `ButtonSegment` kind phantom — annotate with `List (Element (ButtonSegmentIs s) admittedBy msg)`.
-}
type alias ButtonSegmentIs s =
    M3e.ButtonSegment.Build.Is s


{-| The `Calendar` kind phantom — annotate with `List (Element (CalendarIs s) admittedBy msg)`.
-}
type alias CalendarIs s =
    M3e.Calendar.Build.Is s


{-| The `Card` kind phantom — annotate with `List (Element (CardIs s) admittedBy msg)`.
-}
type alias CardIs s =
    M3e.Card.Build.Is s


{-| The `Checkbox` kind phantom — annotate with `List (Element (CheckboxIs s) admittedBy msg)`.
-}
type alias CheckboxIs s =
    M3e.Checkbox.Build.Is s


{-| The `Chip` kind phantom — annotate with `List (Element (ChipIs s) admittedBy msg)`.
-}
type alias ChipIs s =
    M3e.Chip.Build.Is s


{-| The `ChipSet` kind phantom — annotate with `List (Element (ChipSetIs s) admittedBy msg)`.
-}
type alias ChipSetIs s =
    M3e.ChipSet.Build.Is s


{-| The `CircularProgressIndicator` kind phantom — annotate with `List (Element (CircularProgressIndicatorIs s) admittedBy msg)`.
-}
type alias CircularProgressIndicatorIs s =
    M3e.CircularProgressIndicator.Build.Is s


{-| The `Collapsible` kind phantom — annotate with `List (Element (CollapsibleIs s) admittedBy msg)`.
-}
type alias CollapsibleIs s =
    M3e.Collapsible.Build.Is s


{-| The `ContentPane` kind phantom — annotate with `List (Element (ContentPaneIs s) admittedBy msg)`.
-}
type alias ContentPaneIs s =
    M3e.ContentPane.Build.Is s


{-| The `DateInput` kind phantom — annotate with `List (Element (DateInputIs s) admittedBy msg)`.
-}
type alias DateInputIs s =
    M3e.DateInput.Build.Is s


{-| The `Datepicker` kind phantom — annotate with `List (Element (DatepickerIs s) admittedBy msg)`.
-}
type alias DatepickerIs s =
    M3e.Datepicker.Build.Is s


{-| The `DatepickerToggle` kind phantom — annotate with `List (Element (DatepickerToggleIs s) admittedBy msg)`.
-}
type alias DatepickerToggleIs s =
    M3e.DatepickerToggle.Build.Is s


{-| The `Dialog` kind phantom — annotate with `List (Element (DialogIs s) admittedBy msg)`.
-}
type alias DialogIs s =
    M3e.Dialog.Build.Is s


{-| The `DialogAction` kind phantom — annotate with `List (Element (DialogActionIs s) admittedBy msg)`.
-}
type alias DialogActionIs s =
    M3e.DialogAction.Build.Is s


{-| The `DialogTrigger` kind phantom — annotate with `List (Element (DialogTriggerIs s) admittedBy msg)`.
-}
type alias DialogTriggerIs s =
    M3e.DialogTrigger.Build.Is s


{-| The `Divider` kind phantom — annotate with `List (Element (DividerIs s) admittedBy msg)`.
-}
type alias DividerIs s =
    M3e.Divider.Build.Is s


{-| The `DrawerContainer` kind phantom — annotate with `List (Element (DrawerContainerIs s) admittedBy msg)`.
-}
type alias DrawerContainerIs s =
    M3e.DrawerContainer.Build.Is s


{-| The `DrawerToggle` kind phantom — annotate with `List (Element (DrawerToggleIs s) admittedBy msg)`.
-}
type alias DrawerToggleIs s =
    M3e.DrawerToggle.Build.Is s


{-| The `Elevation` kind phantom — annotate with `List (Element (ElevationIs s) admittedBy msg)`.
-}
type alias ElevationIs s =
    M3e.Elevation.Build.Is s


{-| The `ExpandableListItem` kind phantom — annotate with `List (Element (ExpandableListItemIs s) admittedBy msg)`.
-}
type alias ExpandableListItemIs s =
    M3e.ExpandableListItem.Build.Is s


{-| The `ExpansionHeader` kind phantom — annotate with `List (Element (ExpansionHeaderIs s) admittedBy msg)`.
-}
type alias ExpansionHeaderIs s =
    M3e.ExpansionHeader.Build.Is s


{-| The `ExpansionPanel` kind phantom — annotate with `List (Element (ExpansionPanelIs s) admittedBy msg)`.
-}
type alias ExpansionPanelIs s =
    M3e.ExpansionPanel.Build.Is s


{-| The `Fab` kind phantom — annotate with `List (Element (FabIs s) admittedBy msg)`.
-}
type alias FabIs s =
    M3e.Fab.Build.Is s


{-| The `FabMenu` kind phantom — annotate with `List (Element (FabMenuIs s) admittedBy msg)`.
-}
type alias FabMenuIs s =
    M3e.FabMenu.Build.Is s


{-| The `FabMenuItem` kind phantom — annotate with `List (Element (FabMenuItemIs s) admittedBy msg)`.
-}
type alias FabMenuItemIs s =
    M3e.FabMenuItem.Build.Is s


{-| The `FabMenuTrigger` kind phantom — annotate with `List (Element (FabMenuTriggerIs s) admittedBy msg)`.
-}
type alias FabMenuTriggerIs s =
    M3e.FabMenuTrigger.Build.Is s


{-| The `FilterChip` kind phantom — annotate with `List (Element (FilterChipIs s) admittedBy msg)`.
-}
type alias FilterChipIs s =
    M3e.FilterChip.Build.Is s


{-| The `FilterChipSet` kind phantom — annotate with `List (Element (FilterChipSetIs s) admittedBy msg)`.
-}
type alias FilterChipSetIs s =
    M3e.FilterChipSet.Build.Is s


{-| The `FloatingPanel` kind phantom — annotate with `List (Element (FloatingPanelIs s) admittedBy msg)`.
-}
type alias FloatingPanelIs s =
    M3e.FloatingPanel.Build.Is s


{-| The `FocusRing` kind phantom — annotate with `List (Element (FocusRingIs s) admittedBy msg)`.
-}
type alias FocusRingIs s =
    M3e.FocusRing.Build.Is s


{-| The `FocusTrap` kind phantom — annotate with `List (Element (FocusTrapIs s) admittedBy msg)`.
-}
type alias FocusTrapIs s =
    M3e.FocusTrap.Build.Is s


{-| The `FormField` kind phantom — annotate with `List (Element (FormFieldIs s) admittedBy msg)`.
-}
type alias FormFieldIs s =
    M3e.FormField.Build.Is s


{-| The `Heading` kind phantom — annotate with `List (Element (HeadingIs s) admittedBy msg)`.
-}
type alias HeadingIs s =
    M3e.Heading.Build.Is s


{-| The `Icon` kind phantom — annotate with `List (Element (IconIs s) admittedBy msg)`.
-}
type alias IconIs s =
    M3e.Icon.Build.Is s


{-| The `IconButton` kind phantom — annotate with `List (Element (IconButtonIs s) admittedBy msg)`.
-}
type alias IconButtonIs s =
    M3e.IconButton.Build.Is s


{-| The `InputChip` kind phantom — annotate with `List (Element (InputChipIs s) admittedBy msg)`.
-}
type alias InputChipIs s =
    M3e.InputChip.Build.Is s


{-| The `InputChipSet` kind phantom — annotate with `List (Element (InputChipSetIs s) admittedBy msg)`.
-}
type alias InputChipSetIs s =
    M3e.InputChipSet.Build.Is s


{-| The `LinearProgressIndicator` kind phantom — annotate with `List (Element (LinearProgressIndicatorIs s) admittedBy msg)`.
-}
type alias LinearProgressIndicatorIs s =
    M3e.LinearProgressIndicator.Build.Is s


{-| The `List` kind phantom — annotate with `List (Element (ListIs s) admittedBy msg)`.
-}
type alias ListIs s =
    M3e.List.Build.Is s


{-| The `ListAction` kind phantom — annotate with `List (Element (ListActionIs s) admittedBy msg)`.
-}
type alias ListActionIs s =
    M3e.ListAction.Build.Is s


{-| The `ListItem` kind phantom — annotate with `List (Element (ListItemIs s) admittedBy msg)`.
-}
type alias ListItemIs s =
    M3e.ListItem.Build.Is s


{-| The `ListItemButton` kind phantom — annotate with `List (Element (ListItemButtonIs s) admittedBy msg)`.
-}
type alias ListItemButtonIs s =
    M3e.ListItemButton.Build.Is s


{-| The `ListOption` kind phantom — annotate with `List (Element (ListOptionIs s) admittedBy msg)`.
-}
type alias ListOptionIs s =
    M3e.ListOption.Build.Is s


{-| The `LoadingIndicator` kind phantom — annotate with `List (Element (LoadingIndicatorIs s) admittedBy msg)`.
-}
type alias LoadingIndicatorIs s =
    M3e.LoadingIndicator.Build.Is s


{-| The `Menu` kind phantom — annotate with `List (Element (MenuIs s) admittedBy msg)`.
-}
type alias MenuIs s =
    M3e.Menu.Build.Is s


{-| The `MenuItem` kind phantom — annotate with `List (Element (MenuItemIs s) admittedBy msg)`.
-}
type alias MenuItemIs s =
    M3e.MenuItem.Build.Is s


{-| The `MenuItemCheckbox` kind phantom — annotate with `List (Element (MenuItemCheckboxIs s) admittedBy msg)`.
-}
type alias MenuItemCheckboxIs s =
    M3e.MenuItemCheckbox.Build.Is s


{-| The `MenuItemGroup` kind phantom — annotate with `List (Element (MenuItemGroupIs s) admittedBy msg)`.
-}
type alias MenuItemGroupIs s =
    M3e.MenuItemGroup.Build.Is s


{-| The `MenuItemRadio` kind phantom — annotate with `List (Element (MenuItemRadioIs s) admittedBy msg)`.
-}
type alias MenuItemRadioIs s =
    M3e.MenuItemRadio.Build.Is s


{-| The `MenuTrigger` kind phantom — annotate with `List (Element (MenuTriggerIs s) admittedBy msg)`.
-}
type alias MenuTriggerIs s =
    M3e.MenuTrigger.Build.Is s


{-| The `MonthView` kind phantom — annotate with `List (Element (MonthViewIs s) admittedBy msg)`.
-}
type alias MonthViewIs s =
    M3e.MonthView.Build.Is s


{-| The `MultiYearView` kind phantom — annotate with `List (Element (MultiYearViewIs s) admittedBy msg)`.
-}
type alias MultiYearViewIs s =
    M3e.MultiYearView.Build.Is s


{-| The `NavBar` kind phantom — annotate with `List (Element (NavBarIs s) admittedBy msg)`.
-}
type alias NavBarIs s =
    M3e.NavBar.Build.Is s


{-| The `NavItem` kind phantom — annotate with `List (Element (NavItemIs s) admittedBy msg)`.
-}
type alias NavItemIs s =
    M3e.NavItem.Build.Is s


{-| The `NavMenu` kind phantom — annotate with `List (Element (NavMenuIs s) admittedBy msg)`.
-}
type alias NavMenuIs s =
    M3e.NavMenu.Build.Is s


{-| The `NavMenuItem` kind phantom — annotate with `List (Element (NavMenuItemIs s) admittedBy msg)`.
-}
type alias NavMenuItemIs s =
    M3e.NavMenuItem.Build.Is s


{-| The `NavMenuItemGroup` kind phantom — annotate with `List (Element (NavMenuItemGroupIs s) admittedBy msg)`.
-}
type alias NavMenuItemGroupIs s =
    M3e.NavMenuItemGroup.Build.Is s


{-| The `NavRail` kind phantom — annotate with `List (Element (NavRailIs s) admittedBy msg)`.
-}
type alias NavRailIs s =
    M3e.NavRail.Build.Is s


{-| The `NavRailToggle` kind phantom — annotate with `List (Element (NavRailToggleIs s) admittedBy msg)`.
-}
type alias NavRailToggleIs s =
    M3e.NavRailToggle.Build.Is s


{-| The `Optgroup` kind phantom — annotate with `List (Element (OptgroupIs s) admittedBy msg)`.
-}
type alias OptgroupIs s =
    M3e.Optgroup.Build.Is s


{-| The `Option` kind phantom — annotate with `List (Element (OptionIs s) admittedBy msg)`.
-}
type alias OptionIs s =
    M3e.Option.Build.Is s


{-| The `OptionPanel` kind phantom — annotate with `List (Element (OptionPanelIs s) admittedBy msg)`.
-}
type alias OptionPanelIs s =
    M3e.OptionPanel.Build.Is s


{-| The `Paginator` kind phantom — annotate with `List (Element (PaginatorIs s) admittedBy msg)`.
-}
type alias PaginatorIs s =
    M3e.Paginator.Build.Is s


{-| The `PseudoCheckbox` kind phantom — annotate with `List (Element (PseudoCheckboxIs s) admittedBy msg)`.
-}
type alias PseudoCheckboxIs s =
    M3e.PseudoCheckbox.Build.Is s


{-| The `PseudoRadio` kind phantom — annotate with `List (Element (PseudoRadioIs s) admittedBy msg)`.
-}
type alias PseudoRadioIs s =
    M3e.PseudoRadio.Build.Is s


{-| The `Radio` kind phantom — annotate with `List (Element (RadioIs s) admittedBy msg)`.
-}
type alias RadioIs s =
    M3e.Radio.Build.Is s


{-| The `RadioGroup` kind phantom — annotate with `List (Element (RadioGroupIs s) admittedBy msg)`.
-}
type alias RadioGroupIs s =
    M3e.RadioGroup.Build.Is s


{-| The `RichTooltip` kind phantom — annotate with `List (Element (RichTooltipIs s) admittedBy msg)`.
-}
type alias RichTooltipIs s =
    M3e.RichTooltip.Build.Is s


{-| The `RichTooltipAction` kind phantom — annotate with `List (Element (RichTooltipActionIs s) admittedBy msg)`.
-}
type alias RichTooltipActionIs s =
    M3e.RichTooltipAction.Build.Is s


{-| The `Ripple` kind phantom — annotate with `List (Element (RippleIs s) admittedBy msg)`.
-}
type alias RippleIs s =
    M3e.Ripple.Build.Is s


{-| The `ScrollContainer` kind phantom — annotate with `List (Element (ScrollContainerIs s) admittedBy msg)`.
-}
type alias ScrollContainerIs s =
    M3e.ScrollContainer.Build.Is s


{-| The `SearchBar` kind phantom — annotate with `List (Element (SearchBarIs s) admittedBy msg)`.
-}
type alias SearchBarIs s =
    M3e.SearchBar.Build.Is s


{-| The `SearchView` kind phantom — annotate with `List (Element (SearchViewIs s) admittedBy msg)`.
-}
type alias SearchViewIs s =
    M3e.SearchView.Build.Is s


{-| The `SegmentedButton` kind phantom — annotate with `List (Element (SegmentedButtonIs s) admittedBy msg)`.
-}
type alias SegmentedButtonIs s =
    M3e.SegmentedButton.Build.Is s


{-| The `Select` kind phantom — annotate with `List (Element (SelectIs s) admittedBy msg)`.
-}
type alias SelectIs s =
    M3e.Select.Build.Is s


{-| The `SelectionIndicator` kind phantom — annotate with `List (Element (SelectionIndicatorIs s) admittedBy msg)`.
-}
type alias SelectionIndicatorIs s =
    M3e.SelectionIndicator.Build.Is s


{-| The `SelectionList` kind phantom — annotate with `List (Element (SelectionListIs s) admittedBy msg)`.
-}
type alias SelectionListIs s =
    M3e.SelectionList.Build.Is s


{-| The `Shape` kind phantom — annotate with `List (Element (ShapeIs s) admittedBy msg)`.
-}
type alias ShapeIs s =
    M3e.Shape.Build.Is s


{-| The `Skeleton` kind phantom — annotate with `List (Element (SkeletonIs s) admittedBy msg)`.
-}
type alias SkeletonIs s =
    M3e.Skeleton.Build.Is s


{-| The `Slide` kind phantom — annotate with `List (Element (SlideIs s) admittedBy msg)`.
-}
type alias SlideIs s =
    M3e.Slide.Build.Is s


{-| The `SlideGroup` kind phantom — annotate with `List (Element (SlideGroupIs s) admittedBy msg)`.
-}
type alias SlideGroupIs s =
    M3e.SlideGroup.Build.Is s


{-| The `Slider` kind phantom — annotate with `List (Element (SliderIs s) admittedBy msg)`.
-}
type alias SliderIs s =
    M3e.Slider.Build.Is s


{-| The `SliderThumb` kind phantom — annotate with `List (Element (SliderThumbIs s) admittedBy msg)`.
-}
type alias SliderThumbIs s =
    M3e.SliderThumb.Build.Is s


{-| The `Snackbar` kind phantom — annotate with `List (Element (SnackbarIs s) admittedBy msg)`.
-}
type alias SnackbarIs s =
    M3e.Snackbar.Build.Is s


{-| The `SplitButton` kind phantom — annotate with `List (Element (SplitButtonIs s) admittedBy msg)`.
-}
type alias SplitButtonIs s =
    M3e.SplitButton.Build.Is s


{-| The `SplitPane` kind phantom — annotate with `List (Element (SplitPaneIs s) admittedBy msg)`.
-}
type alias SplitPaneIs s =
    M3e.SplitPane.Build.Is s


{-| The `StateLayer` kind phantom — annotate with `List (Element (StateLayerIs s) admittedBy msg)`.
-}
type alias StateLayerIs s =
    M3e.StateLayer.Build.Is s


{-| The `Step` kind phantom — annotate with `List (Element (StepIs s) admittedBy msg)`.
-}
type alias StepIs s =
    M3e.Step.Build.Is s


{-| The `StepPanel` kind phantom — annotate with `List (Element (StepPanelIs s) admittedBy msg)`.
-}
type alias StepPanelIs s =
    M3e.StepPanel.Build.Is s


{-| The `Stepper` kind phantom — annotate with `List (Element (StepperIs s) admittedBy msg)`.
-}
type alias StepperIs s =
    M3e.Stepper.Build.Is s


{-| The `StepperNext` kind phantom — annotate with `List (Element (StepperNextIs s) admittedBy msg)`.
-}
type alias StepperNextIs s =
    M3e.StepperNext.Build.Is s


{-| The `StepperPrevious` kind phantom — annotate with `List (Element (StepperPreviousIs s) admittedBy msg)`.
-}
type alias StepperPreviousIs s =
    M3e.StepperPrevious.Build.Is s


{-| The `StepperReset` kind phantom — annotate with `List (Element (StepperResetIs s) admittedBy msg)`.
-}
type alias StepperResetIs s =
    M3e.StepperReset.Build.Is s


{-| The `SuggestionChip` kind phantom — annotate with `List (Element (SuggestionChipIs s) admittedBy msg)`.
-}
type alias SuggestionChipIs s =
    M3e.SuggestionChip.Build.Is s


{-| The `Switch` kind phantom — annotate with `List (Element (SwitchIs s) admittedBy msg)`.
-}
type alias SwitchIs s =
    M3e.Switch.Build.Is s


{-| The `Tab` kind phantom — annotate with `List (Element (TabIs s) admittedBy msg)`.
-}
type alias TabIs s =
    M3e.Tab.Build.Is s


{-| The `TabPanel` kind phantom — annotate with `List (Element (TabPanelIs s) admittedBy msg)`.
-}
type alias TabPanelIs s =
    M3e.TabPanel.Build.Is s


{-| The `Tabs` kind phantom — annotate with `List (Element (TabsIs s) admittedBy msg)`.
-}
type alias TabsIs s =
    M3e.Tabs.Build.Is s


{-| The `TextHighlight` kind phantom — annotate with `List (Element (TextHighlightIs s) admittedBy msg)`.
-}
type alias TextHighlightIs s =
    M3e.TextHighlight.Build.Is s


{-| The `TextOverflow` kind phantom — annotate with `List (Element (TextOverflowIs s) admittedBy msg)`.
-}
type alias TextOverflowIs s =
    M3e.TextOverflow.Build.Is s


{-| The `TextareaAutosize` kind phantom — annotate with `List (Element (TextareaAutosizeIs s) admittedBy msg)`.
-}
type alias TextareaAutosizeIs s =
    M3e.TextareaAutosize.Build.Is s


{-| The `Theme` kind phantom — annotate with `List (Element (ThemeIs s) admittedBy msg)`.
-}
type alias ThemeIs s =
    M3e.Theme.Build.Is s


{-| The `ThemeIcon` kind phantom — annotate with `List (Element (ThemeIconIs s) admittedBy msg)`.
-}
type alias ThemeIconIs s =
    M3e.ThemeIcon.Build.Is s


{-| The `Timepicker` kind phantom — annotate with `List (Element (TimepickerIs s) admittedBy msg)`.
-}
type alias TimepickerIs s =
    M3e.Timepicker.Build.Is s


{-| The `TimepickerDial` kind phantom — annotate with `List (Element (TimepickerDialIs s) admittedBy msg)`.
-}
type alias TimepickerDialIs s =
    M3e.TimepickerDial.Build.Is s


{-| The `TimepickerInput` kind phantom — annotate with `List (Element (TimepickerInputIs s) admittedBy msg)`.
-}
type alias TimepickerInputIs s =
    M3e.TimepickerInput.Build.Is s


{-| The `TimepickerInputPeriodToggle` kind phantom — annotate with `List (Element (TimepickerInputPeriodToggleIs s) admittedBy msg)`.
-}
type alias TimepickerInputPeriodToggleIs s =
    M3e.TimepickerInputPeriodToggle.Build.Is s


{-| The `TimepickerToggle` kind phantom — annotate with `List (Element (TimepickerToggleIs s) admittedBy msg)`.
-}
type alias TimepickerToggleIs s =
    M3e.TimepickerToggle.Build.Is s


{-| The `Toc` kind phantom — annotate with `List (Element (TocIs s) admittedBy msg)`.
-}
type alias TocIs s =
    M3e.Toc.Build.Is s


{-| The `TocItem` kind phantom — annotate with `List (Element (TocItemIs s) admittedBy msg)`.
-}
type alias TocItemIs s =
    M3e.TocItem.Build.Is s


{-| The `Toolbar` kind phantom — annotate with `List (Element (ToolbarIs s) admittedBy msg)`.
-}
type alias ToolbarIs s =
    M3e.Toolbar.Build.Is s


{-| The `Tooltip` kind phantom — annotate with `List (Element (TooltipIs s) admittedBy msg)`.
-}
type alias TooltipIs s =
    M3e.Tooltip.Build.Is s


{-| The `Tree` kind phantom — annotate with `List (Element (TreeIs s) admittedBy msg)`.
-}
type alias TreeIs s =
    M3e.Tree.Build.Is s


{-| The `TreeItem` kind phantom — annotate with `List (Element (TreeItemIs s) admittedBy msg)`.
-}
type alias TreeItemIs s =
    M3e.TreeItem.Build.Is s


{-| The `YearView` kind phantom — annotate with `List (Element (YearViewIs s) admittedBy msg)`.
-}
type alias YearViewIs s =
    M3e.YearView.Build.Is s
