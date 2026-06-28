module M3e exposing
    ( Element, Supported, Node
    , text, html, toNode
    , disabled, onClick, href, target, rel, download, id
    , buttonElevated, buttonFilled, buttonTonal, buttonOutlined, buttonText
    , iconButton, fab, fabMenu, splitButton, segmentedButton, buttonGroup
    , extendedFabPrimary, extendedFabPrimaryContainer, extendedFabSecondary, extendedFabSecondaryContainer, extendedFabTertiary, extendedFabTertiaryContainer, extendedFabSurface
    , chip, chipAssist, chipSuggestion, chipFilter, chipInput, chipSet
    , card, cardElevated, cardFilled, cardOutlined
    , headingDisplay, headingHeadline, headingTitle, headingLabel, typography, textHighlight, textOverflow
    , checkbox, switch, slider, radioButton, select, textField, search, paginator, timePicker, datePicker, datePickerToggle, calendar, autocomplete
    , dialog, dialogAction, dialogTrigger, snackbar, tooltipPlain, tooltipRich, badge, loadingIndicator, progress
    , avatar, icon, themeIcon, divider, skeleton
    , appBar, toolbar, navigationBar, navigationRail, navRailToggle, navigationDrawer, drawerToggle, breadcrumb, tabs, stepper, stepperNext, stepperPrevious, stepperReset, toc
    , menu, list, actionList, selectionList, tree, disclosure, collapsible
    , bottomSheet, bottomSheetTrigger, sideSheet, floatingPanel, scrollContainer, splitPane, contentPane, optionPanel, slide
    , field, theme, richTooltipAction
    , breadcrumbItem, menuItem, menuCheckboxItem, menuRadioItem, menuGroup, menuTriggerFor
    , navBarItem, navRailItem, navDrawerLink, navDrawerGroup
    , listItem, listActionItem, listOption, listDivider, listExpandable
    , fabMenuItem, disclosureSection, segment, slideGroup
    , selectOption, selectOptions, autocompleteOption, autocompleteOptions
    , step, stepPanel, tab, tabPanel, treeItem
    , chipFilterSet, chipInputSet
    , Label, Role, ProgressShape, ItemAction
    , labelFromHtml, menuClick, menuLink, progressLinear, progressCircular
    , roleBodyLarge, roleBodyMedium, roleBodySmall, roleLabelLarge, roleLabelMedium, roleLabelSmall
    )

{-| Top-level facade for the M3e component library, so the common case is a
single `import M3e exposing (..)`.

This module is a thin re-binding layer — it adds no behaviour. The component
modules (`M3e.Button`, `M3e.Chip`, …) remain the documented source of truth; this
module just collects the most-reached-for names so callers need not import each
component individually.

Per-variant entry points bake the variant in for IDE discovery and brevity:

    import M3e exposing (..)

    M3e.buttonFilled { label = "Save" } [ onClick Save, disabled busy ]
    M3e.chipAssist { label = "Add", onClick = Add } []
    M3e.cardElevated [] |> toNode

Component-specific options that take shared [`M3e.Value`](M3e-Value) tokens
(e.g. `Button.size Value.large`) still come from the component module; only the
universally-shared attributes are re-exposed here. The child-element builders
for container components (`Menu.item`, `Stepper.step`, …) are re-bound under
namespaced names (`menuItem`, `step`, …) so a container is fully usable from
the single import.


# Core vocabulary

@docs Element, Supported, Node
@docs text, html, toNode


# Shared attributes

@docs disabled, onClick, href, target, rel, download, id


# Buttons and FABs

@docs buttonElevated, buttonFilled, buttonTonal, buttonOutlined, buttonText
@docs iconButton, fab, fabMenu, splitButton, segmentedButton, buttonGroup
@docs extendedFabPrimary, extendedFabPrimaryContainer, extendedFabSecondary, extendedFabSecondaryContainer, extendedFabTertiary, extendedFabTertiaryContainer, extendedFabSurface


# Chips

@docs chip, chipAssist, chipSuggestion, chipFilter, chipInput, chipSet


# Cards

@docs card, cardElevated, cardFilled, cardOutlined


# Text and headings

@docs headingDisplay, headingHeadline, headingTitle, headingLabel, typography, textHighlight, textOverflow


# Inputs and pickers

@docs checkbox, switch, slider, radioButton, select, textField, search, paginator, timePicker, datePicker, datePickerToggle, calendar, autocomplete


# Feedback and overlays

@docs dialog, dialogAction, dialogTrigger, snackbar, tooltipPlain, tooltipRich, badge, loadingIndicator, progress


# Icons and media

@docs avatar, icon, themeIcon, divider, skeleton


# Navigation

@docs appBar, toolbar, navigationBar, navigationRail, navRailToggle, navigationDrawer, drawerToggle, breadcrumb, tabs, stepper, stepperNext, stepperPrevious, stepperReset, toc


# Lists, menus and containers

@docs menu, list, actionList, selectionList, tree, disclosure, collapsible
@docs bottomSheet, bottomSheetTrigger, sideSheet, floatingPanel, scrollContainer, splitPane, contentPane, optionPanel, slide


# Layout and misc

@docs field, theme, richTooltipAction


# Container child elements

Builders for the children of container components, re-bound under namespaced
names to avoid collisions in `import M3e exposing (..)` (e.g. `Menu.item`
becomes `menuItem`, `Select.option` becomes `selectOption`).

@docs breadcrumbItem, menuItem, menuCheckboxItem, menuRadioItem, menuGroup, menuTriggerFor
@docs navBarItem, navRailItem, navDrawerLink, navDrawerGroup
@docs listItem, listActionItem, listOption, listDivider, listExpandable
@docs fabMenuItem, disclosureSection, segment, slideGroup
@docs selectOption, selectOptions, autocompleteOption, autocompleteOptions
@docs step, stepPanel, tab, tabPanel, treeItem
@docs chipFilterSet, chipInputSet


# Companion value types

Required value types referenced by the entry points above. Their constructors
live in the component modules and cannot be re-exported directly in Elm, so each
is re-bound here (`Menu.Click` becomes `menuClick`, `Text.BodyLarge` becomes
`roleBodyLarge`, …) to keep the components usable from the single import.

@docs Label, Role, ProgressShape, ItemAction
@docs labelFromHtml, menuClick, menuLink, progressLinear, progressCircular
@docs roleBodyLarge, roleBodyMedium, roleBodySmall, roleLabelLarge, roleLabelMedium, roleLabelSmall

-}

import Html exposing (Html)
import M3e.AppBar as AppBar
import M3e.Attr as Attr
import M3e.Autocomplete as Autocomplete
import M3e.Avatar as Avatar
import M3e.Badge as Badge
import M3e.BottomSheet as BottomSheet
import M3e.BottomSheetTrigger as BottomSheetTrigger
import M3e.Breadcrumb as Breadcrumb
import M3e.Button as Button
import M3e.ButtonGroup as ButtonGroup
import M3e.Calendar as Calendar
import M3e.Card as Card
import M3e.Checkbox as Checkbox
import M3e.Chip as Chip
import M3e.ChipSet as ChipSet
import M3e.Collapsible as Collapsible
import M3e.ContentPane as ContentPane
import M3e.DatePicker as DatePicker
import M3e.DatePickerToggle as DatePickerToggle
import M3e.Dialog as Dialog
import M3e.DialogAction as DialogAction
import M3e.DialogTrigger as DialogTrigger
import M3e.Disclosure as Disclosure
import M3e.Divider as Divider
import M3e.DrawerToggle as DrawerToggle
import M3e.Element as Element
import M3e.ExtendedFab as ExtendedFab
import M3e.Fab as Fab
import M3e.FabMenu as FabMenu
import M3e.Field as Field
import M3e.FloatingPanel as FloatingPanel
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.Internal exposing (Option)
import M3e.Label as MLabel
import M3e.List as MList
import M3e.LoadingIndicator as LoadingIndicator
import M3e.Menu as Menu
import M3e.NavRailToggle as NavRailToggle
import M3e.NavigationBar as NavigationBar
import M3e.NavigationDrawer as NavigationDrawer
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node
import M3e.OptionPanel as OptionPanel
import M3e.Paginator as Paginator
import M3e.Progress as Progress
import M3e.RadioButton as RadioButton
import M3e.RichTooltipAction as RichTooltipAction
import M3e.ScrollContainer as ScrollContainer
import M3e.Search as Search
import M3e.SegmentedButton as SegmentedButton
import M3e.Select as Select
import M3e.SideSheet as SideSheet
import M3e.Skeleton as Skeleton
import M3e.Slide as Slide
import M3e.Slider as Slider
import M3e.Snackbar as Snackbar
import M3e.SplitButton as SplitButton
import M3e.SplitPane as SplitPane
import M3e.Stepper as Stepper
import M3e.StepperNext as StepperNext
import M3e.StepperPrevious as StepperPrevious
import M3e.StepperReset as StepperReset
import M3e.Switch as Switch
import M3e.Tabs as Tabs
import M3e.Text as Text
import M3e.TextField as TextField
import M3e.TextHighlight as TextHighlight
import M3e.TextOverflow as TextOverflow
import M3e.Theme as Theme
import M3e.ThemeIcon as ThemeIcon
import M3e.TimePicker as TimePicker
import M3e.Toc as Toc
import M3e.Toolbar as Toolbar
import M3e.Tooltip as Tooltip
import M3e.Tree as Tree
import M3e.Value as Value



-- CORE VOCABULARY --------------------------------------------------------


{-| The introspectable IR element. Re-export of [`M3e.Element.Element`](M3e-Element#Element).
-}
type alias Element supported msg =
    Element.Element supported msg


{-| Marker for a slot/kind a component supports. Re-export of
[`M3e.Element.Supported`](M3e-Element#Supported).
-}
type alias Supported =
    Element.Supported


{-| The raw IR node. Re-export of [`M3e.Node.Node`](M3e-Node#Node).
-}
type alias Node msg =
    Node.Node msg


{-| A bit of text as a slottable element. Re-export of
[`M3e.Element.text`](M3e-Element#text).
-}
text : String -> Element { s | element : Supported } msg
text =
    Element.text


{-| Lift raw `Html` into a default-slot-region element. Re-export of
[`M3e.Element.html`](M3e-Element#html).
-}
html : Html msg -> Element { s | html : Supported } msg
html =
    Element.html


{-| Unwrap an element to its underlying `Node` for rendering. Re-export of
[`M3e.Element.toNode`](M3e-Element#toNode).
-}
toNode : Element supported msg -> Node msg
toNode =
    Element.toNode



-- SHARED ATTRIBUTES ------------------------------------------------------


{-| Disable a component. Re-export of [`M3e.Attr.disabled`](M3e-Attr#disabled).
-}
disabled : Bool -> Option { c | disabled : Bool } msg
disabled =
    Attr.disabled


{-| Wire a click handler. Re-export of [`M3e.Attr.onClick`](M3e-Attr#onClick).
-}
onClick : msg -> Option { c | onClick : Maybe msg } msg
onClick =
    Attr.onClick


{-| Render as a link. Re-export of [`M3e.Attr.href`](M3e-Attr#href).
-}
href : String -> Option { c | href : Maybe String } msg
href =
    Attr.href


{-| Set the link target. Re-export of [`M3e.Attr.target`](M3e-Attr#target).
-}
target : String -> Option { c | target : Maybe String } msg
target =
    Attr.target


{-| Set the link rel. Re-export of [`M3e.Attr.rel`](M3e-Attr#rel).
-}
rel : String -> Option { c | rel : Maybe String } msg
rel =
    Attr.rel


{-| Request the link target be downloaded. Re-export of
[`M3e.Attr.download`](M3e-Attr#download).
-}
download : String -> Option { c | download : Maybe String } msg
download =
    Attr.download


{-| Set the element id. Re-export of [`M3e.Attr.id`](M3e-Attr#id).
-}
id : String -> Option { c | id : Maybe String } msg
id =
    Attr.id



-- BUTTONS AND FABS -------------------------------------------------------


{-| An elevated button. [`M3e.Button.view`](M3e-Button#view) with `variant = Value.elevated`.
-}
buttonElevated : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonElevated req =
    Button.view { label = req.label, variant = Value.elevated }


{-| A filled button. [`M3e.Button.view`](M3e-Button#view) with `variant = Value.filled`.
-}
buttonFilled : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonFilled req =
    Button.view { label = req.label, variant = Value.filled }


{-| A tonal button. [`M3e.Button.view`](M3e-Button#view) with `variant = Value.tonal`.
-}
buttonTonal : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonTonal req =
    Button.view { label = req.label, variant = Value.tonal }


{-| An outlined button. [`M3e.Button.view`](M3e-Button#view) with `variant = Value.outlined`.
-}
buttonOutlined : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonOutlined req =
    Button.view { label = req.label, variant = Value.outlined }


{-| A text button. [`M3e.Button.view`](M3e-Button#view) with `variant = Value.textVariant`.
-}
buttonText : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonText req =
    Button.view { label = req.label, variant = Value.textVariant }


{-| An icon button. Re-export of [`M3e.IconButton.view`](M3e-IconButton#view).
-}
iconButton : { icon : String, ariaLabel : String } -> List (IconButton.Option msg) -> Element { s | iconButton : Supported } msg
iconButton =
    IconButton.view


{-| A floating action button. Re-export of [`M3e.Fab.view`](M3e-Fab#view).
-}
fab : { icon : String, ariaLabel : String } -> List (Fab.Option msg) -> Element { s | fab : Supported } msg
fab =
    Fab.view


{-| A FAB menu. Re-export of [`M3e.FabMenu.view`](M3e-FabMenu#view).
-}
fabMenu : { triggerIcon : String, name : String, items : List (Element { fabMenuItem : Supported } msg) } -> List (FabMenu.Option msg) -> Element { s | fabMenu : Supported } msg
fabMenu =
    FabMenu.view


{-| A split button. Re-export of [`M3e.SplitButton.view`](M3e-SplitButton#view).
-}
splitButton :
    { label : String
    , name : String
    , trailingContent : List (Element { icon : Supported, element : Supported } msg)
    , onPrimaryClick : msg
    , onTriggerClick : msg
    }
    -> List (SplitButton.Option msg)
    -> Element { s | splitButton : Supported } msg
splitButton =
    SplitButton.view


{-| A segmented button. Re-export of [`M3e.SegmentedButton.view`](M3e-SegmentedButton#view).
-}
segmentedButton : { segments : List (Element { segment : Supported } msg) } -> List (SegmentedButton.ParentOption msg) -> Element { s | segmentedButton : Supported } msg
segmentedButton =
    SegmentedButton.view


{-| A button group. Re-export of [`M3e.ButtonGroup.view`](M3e-ButtonGroup#view).
-}
buttonGroup : { buttons : List (Element { button : Supported, iconButton : Supported } msg) } -> List (ButtonGroup.Option msg) -> Element { s | buttonGroup : Supported } msg
buttonGroup =
    ButtonGroup.view


{-| A primary extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.primary`.
-}
extendedFabPrimary : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabPrimary req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.primary }


{-| A primary-container extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.primaryContainer`.
-}
extendedFabPrimaryContainer : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabPrimaryContainer req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.primaryContainer }


{-| A secondary extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.secondary`.
-}
extendedFabSecondary : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabSecondary req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.secondary }


{-| A secondary-container extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.secondaryContainer`.
-}
extendedFabSecondaryContainer : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabSecondaryContainer req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.secondaryContainer }


{-| A tertiary extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.tertiary`.
-}
extendedFabTertiary : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabTertiary req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.tertiary }


{-| A tertiary-container extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.tertiaryContainer`.
-}
extendedFabTertiaryContainer : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabTertiaryContainer req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.tertiaryContainer }


{-| A surface extended FAB. [`M3e.ExtendedFab.view`](M3e-ExtendedFab#view) with `variant = Value.surface`.
-}
extendedFabSurface : { icon : String, label : String } -> List (ExtendedFab.Option msg) -> Element { s | extendedFab : Supported } msg
extendedFabSurface req =
    ExtendedFab.view { icon = req.icon, label = req.label, variant = Value.surface }



-- CHIPS ------------------------------------------------------------------


{-| A display chip. Re-export of [`M3e.Chip.view`](M3e-Chip#view).
-}
chip : { label : String } -> List (Chip.ViewOption msg) -> Element { s | chip : Supported } msg
chip =
    Chip.view


{-| An assist chip. Re-export of [`M3e.Chip.assist`](M3e-Chip#assist).
-}
chipAssist : { label : String, onClick : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipAssist =
    Chip.assist


{-| A suggestion chip. Re-export of [`M3e.Chip.suggestion`](M3e-Chip#suggestion).
-}
chipSuggestion : { label : String, onClick : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipSuggestion =
    Chip.suggestion


{-| A filter chip. Re-export of [`M3e.Chip.filter`](M3e-Chip#filter).
-}
chipFilter : { label : String, onToggle : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipFilter =
    Chip.filter


{-| An input chip. Re-export of [`M3e.Chip.input`](M3e-Chip#input).
-}
chipInput : { label : String, onRemove : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipInput =
    Chip.input


{-| A chip set container. Re-export of [`M3e.ChipSet.view`](M3e-ChipSet#view).
-}
chipSet : List (ChipSet.Option msg) -> Element { s | chipSet : Supported } msg
chipSet =
    ChipSet.view



-- CARDS ------------------------------------------------------------------


{-| A card with no explicit variant. Re-export of [`M3e.Card.view`](M3e-Card#view).
-}
card : List (Card.Option msg) -> Element { s | card : Supported } msg
card =
    Card.view


{-| An elevated card. [`M3e.Card.view`](M3e-Card#view) with `variant = Value.elevated` prepended.
-}
cardElevated : List (Card.Option msg) -> Element { s | card : Supported } msg
cardElevated opts =
    Card.view (Card.variant Value.elevated :: opts)


{-| A filled card. [`M3e.Card.view`](M3e-Card#view) with `variant = Value.filled` prepended.
-}
cardFilled : List (Card.Option msg) -> Element { s | card : Supported } msg
cardFilled opts =
    Card.view (Card.variant Value.filled :: opts)


{-| An outlined card. [`M3e.Card.view`](M3e-Card#view) with `variant = Value.outlined` prepended.
-}
cardOutlined : List (Card.Option msg) -> Element { s | card : Supported } msg
cardOutlined opts =
    Card.view (Card.variant Value.outlined :: opts)



-- TEXT AND HEADINGS ------------------------------------------------------


{-| A display heading. [`M3e.Heading.view`](M3e-Heading#view) with `variant = Value.display`.
-}
headingDisplay : { label : String } -> List (Heading.Option msg) -> Element { s | heading : Supported } msg
headingDisplay req =
    Heading.view { label = req.label, variant = Value.display }


{-| A headline heading. [`M3e.Heading.view`](M3e-Heading#view) with `variant = Value.headline`.
-}
headingHeadline : { label : String } -> List (Heading.Option msg) -> Element { s | heading : Supported } msg
headingHeadline req =
    Heading.view { label = req.label, variant = Value.headline }


{-| A title heading. [`M3e.Heading.view`](M3e-Heading#view) with `variant = Value.title`.
-}
headingTitle : { label : String } -> List (Heading.Option msg) -> Element { s | heading : Supported } msg
headingTitle req =
    Heading.view { label = req.label, variant = Value.title }


{-| A label heading. [`M3e.Heading.view`](M3e-Heading#view) with `variant = Value.label`.
-}
headingLabel : { label : String } -> List (Heading.Option msg) -> Element { s | heading : Supported } msg
headingLabel req =
    Heading.view { label = req.label, variant = Value.label }


{-| Typographic text. Re-export of [`M3e.Text.view`](M3e-Text#view).
-}
typography : { content : String, role : Role } -> List (Text.Option msg) -> Element { s | text : Supported } msg
typography =
    Text.view


{-| Highlighted text. Re-export of [`M3e.TextHighlight.view`](M3e-TextHighlight#view).
-}
textHighlight : { content : List (Element any msg) } -> List (TextHighlight.Option msg) -> Element { s | textHighlight : Supported } msg
textHighlight =
    TextHighlight.view


{-| Text overflow container. Re-export of [`M3e.TextOverflow.view`](M3e-TextOverflow#view).
-}
textOverflow : { content : List (Element any msg) } -> Element { s | textOverflow : Supported } msg
textOverflow =
    TextOverflow.view



-- INPUTS AND PICKERS -----------------------------------------------------


{-| A checkbox. Re-export of [`M3e.Checkbox.view`](M3e-Checkbox#view).
-}
checkbox : { ariaLabel : String } -> List (Checkbox.Option msg) -> Element { s | checkbox : Supported } msg
checkbox =
    Checkbox.view


{-| A switch. Re-export of [`M3e.Switch.view`](M3e-Switch#view).
-}
switch : { ariaLabel : String } -> List (Switch.Option msg) -> Element { s | switch : Supported } msg
switch =
    Switch.view


{-| A slider. Re-export of [`M3e.Slider.view`](M3e-Slider#view).
-}
slider : { name : String } -> List (Slider.Option msg) -> Element { s | slider : Supported } msg
slider =
    Slider.view


{-| A radio button group. Re-export of [`M3e.RadioButton.view`](M3e-RadioButton#view).
-}
radioButton :
    { name : String
    , options : List { value : String, label : String }
    , selected : Maybe String
    }
    -> List (RadioButton.Option msg)
    -> Element { s | radioButton : Supported } msg
radioButton =
    RadioButton.view


{-| A select. Re-export of [`M3e.Select.view`](M3e-Select#view).
-}
select : { label : String } -> List (Select.Option msg) -> Element { s | select : Supported } msg
select =
    Select.view


{-| A text field. Re-export of [`M3e.TextField.view`](M3e-TextField#view).
-}
textField : { label : String } -> List (TextField.Option msg) -> Element { s | textField : Supported } msg
textField =
    TextField.view


{-| A search field. Re-export of [`M3e.Search.view`](M3e-Search#view).
-}
search : { placeholder : String } -> List (Search.Option msg) -> Element { s | search : Supported } msg
search =
    Search.view


{-| A paginator. Re-export of [`M3e.Paginator.view`](M3e-Paginator#view).
-}
paginator : { length : Int } -> List (Paginator.Option msg) -> Element { s | paginator : Supported } msg
paginator =
    Paginator.view


{-| A time picker. Re-export of [`M3e.TimePicker.view`](M3e-TimePicker#view).
-}
timePicker : { label : String } -> List (TimePicker.Option msg) -> Element { s | timePicker : Supported } msg
timePicker =
    TimePicker.view


{-| A date picker. Re-export of [`M3e.DatePicker.view`](M3e-DatePicker#view).
-}
datePicker : List (DatePicker.Option msg) -> Element { s | datePicker : Supported } msg
datePicker =
    DatePicker.view


{-| A date-picker toggle. Re-export of [`M3e.DatePickerToggle.view`](M3e-DatePickerToggle#view).
-}
datePickerToggle : List (DatePickerToggle.Option msg) -> Element { s | datePickerToggle : Supported } msg
datePickerToggle =
    DatePickerToggle.view


{-| A calendar. Re-export of [`M3e.Calendar.view`](M3e-Calendar#view).
-}
calendar : List (Calendar.Option msg) -> Element { s | calendar : Supported } msg
calendar =
    Calendar.view


{-| An autocomplete. Re-export of [`M3e.Autocomplete.view`](M3e-Autocomplete#view).
-}
autocomplete : { for : String } -> List (Autocomplete.Option msg) -> Element { s | autocomplete : Supported } msg
autocomplete =
    Autocomplete.view



-- FEEDBACK AND OVERLAYS --------------------------------------------------


{-| A dialog. Re-export of [`M3e.Dialog.view`](M3e-Dialog#view).
-}
dialog : { headline : String, content : List (Element any msg) } -> List (Dialog.Option msg) -> Element { s | dialog : Supported } msg
dialog =
    Dialog.view


{-| A dialog action region. Re-export of [`M3e.DialogAction.view`](M3e-DialogAction#view).
-}
dialogAction : List (Element any msg) -> List (DialogAction.Option msg) -> Element { s | dialogAction : Supported } msg
dialogAction =
    DialogAction.view


{-| A dialog trigger. Re-export of [`M3e.DialogTrigger.view`](M3e-DialogTrigger#view).
-}
dialogTrigger : List (DialogTrigger.Option msg) -> Element { s | dialogTrigger : Supported } msg
dialogTrigger =
    DialogTrigger.view


{-| A snackbar. Re-export of [`M3e.Snackbar.view`](M3e-Snackbar#view).
-}
snackbar : { message : String } -> List (Snackbar.Option msg) -> Element { s | snackbar : Supported } msg
snackbar =
    Snackbar.view


{-| A plain tooltip. Re-export of [`M3e.Tooltip.plain`](M3e-Tooltip#plain).
-}
tooltipPlain : { anchorId : String, label : String } -> List (Tooltip.PlainOption msg) -> Element { s | tooltip : Supported } msg
tooltipPlain =
    Tooltip.plain


{-| A rich tooltip. Re-export of [`M3e.Tooltip.rich`](M3e-Tooltip#rich).
-}
tooltipRich : { anchorId : String, content : List (Element any msg) } -> List (Tooltip.RichOption msg) -> Element { s | tooltip : Supported } msg
tooltipRich =
    Tooltip.rich


{-| A badge. Re-export of [`M3e.Badge.view`](M3e-Badge#view).
-}
badge : List (Badge.Option msg) -> Element { s | badge : Supported } msg
badge =
    Badge.view


{-| A loading indicator. Re-export of [`M3e.LoadingIndicator.view`](M3e-LoadingIndicator#view).
-}
loadingIndicator : List (LoadingIndicator.Option msg) -> Element { s | loadingIndicator : Supported } msg
loadingIndicator =
    LoadingIndicator.view


{-| A progress indicator. Re-export of [`M3e.Progress.view`](M3e-Progress#view).
-}
progress : { shape : ProgressShape } -> List (Progress.Option msg) -> Element { s | progress : Supported } msg
progress =
    Progress.view



-- ICONS AND MEDIA --------------------------------------------------------


{-| An avatar. Re-export of [`M3e.Avatar.view`](M3e-Avatar#view).
-}
avatar : { ariaLabel : String } -> List (Avatar.Option msg) -> Element { s | avatar : Supported } msg
avatar =
    Avatar.view


{-| An icon. Re-export of [`M3e.Icon.view`](M3e-Icon#view).
-}
icon : { name : String } -> List (Icon.Option msg) -> Element { s | icon : Supported } msg
icon =
    Icon.view


{-| A theme icon. Re-export of [`M3e.ThemeIcon.view`](M3e-ThemeIcon#view).
-}
themeIcon : List (ThemeIcon.Option msg) -> Element { s | themeIcon : Supported } msg
themeIcon =
    ThemeIcon.view


{-| A divider. Re-export of [`M3e.Divider.view`](M3e-Divider#view).
-}
divider : List (Divider.Option msg) -> Element { s | divider : Supported } msg
divider =
    Divider.view


{-| A skeleton placeholder. Re-export of [`M3e.Skeleton.view`](M3e-Skeleton#view).
-}
skeleton : { content : List (Element any msg) } -> List (Skeleton.Option msg) -> Element { s | skeleton : Supported } msg
skeleton =
    Skeleton.view



-- NAVIGATION -------------------------------------------------------------


{-| An app bar. Re-export of [`M3e.AppBar.view`](M3e-AppBar#view).
-}
appBar : List (AppBar.Option msg) -> Element { s | appBar : Supported } msg
appBar =
    AppBar.view


{-| A toolbar. Re-export of [`M3e.Toolbar.view`](M3e-Toolbar#view).
-}
toolbar : { content : List (Element any msg) } -> List (Toolbar.Option msg) -> Element { s | toolbar : Supported } msg
toolbar =
    Toolbar.view


{-| A navigation bar. Re-export of [`M3e.NavigationBar.view`](M3e-NavigationBar#view).
-}
navigationBar : { items : List (Element { navItem : Supported } msg) } -> List (NavigationBar.Option msg) -> Element { s | navBar : Supported } msg
navigationBar =
    NavigationBar.view


{-| A navigation rail. Re-export of [`M3e.NavigationRail.view`](M3e-NavigationRail#view).
-}
navigationRail : { items : List (Element { navItem : Supported, iconButton : Supported, fab : Supported } msg) } -> List (NavigationRail.Option msg) -> Element { s | navRail : Supported } msg
navigationRail =
    NavigationRail.view


{-| A navigation-rail toggle. Re-export of [`M3e.NavRailToggle.view`](M3e-NavRailToggle#view).
-}
navRailToggle : List (NavRailToggle.Option msg) -> Element { s | navRailToggle : Supported } msg
navRailToggle =
    NavRailToggle.view


{-| A navigation drawer. Re-export of [`M3e.NavigationDrawer.view`](M3e-NavigationDrawer#view).
-}
navigationDrawer : { entries : List (Element { navMenuItem : Supported } msg) } -> List (NavigationDrawer.Option msg) -> Element { s | navigationDrawer : Supported } msg
navigationDrawer =
    NavigationDrawer.view


{-| A drawer toggle. Re-export of [`M3e.DrawerToggle.view`](M3e-DrawerToggle#view).
-}
drawerToggle : List (DrawerToggle.Option msg) -> Element { s | drawerToggle : Supported } msg
drawerToggle =
    DrawerToggle.view


{-| A breadcrumb trail. Re-export of [`M3e.Breadcrumb.view`](M3e-Breadcrumb#view).
-}
breadcrumb : { items : List (Element { breadcrumbItem : Supported } msg) } -> List (Breadcrumb.BreadcrumbOption msg) -> Element { s | breadcrumb : Supported } msg
breadcrumb =
    Breadcrumb.view


{-| A tab set. Re-export of [`M3e.Tabs.view`](M3e-Tabs#view).
-}
tabs : { tabs : List (Element { tab : Supported } msg), panels : List (Element { tabPanel : Supported } msg) } -> List (Tabs.Option msg) -> Element { s | tabs : Supported } msg
tabs =
    Tabs.view


{-| A stepper. Re-export of [`M3e.Stepper.view`](M3e-Stepper#view).
-}
stepper : { steps : List (Element { step : Supported } msg), panels : List (Element { stepPanel : Supported } msg) } -> List (Stepper.Option msg) -> Element { s | stepper : Supported } msg
stepper =
    Stepper.view


{-| A stepper "next" action. Re-export of [`M3e.StepperNext.view`](M3e-StepperNext#view).
-}
stepperNext : List (Element any msg) -> Element { s | stepperNext : Supported } msg
stepperNext =
    StepperNext.view


{-| A stepper "previous" action. Re-export of [`M3e.StepperPrevious.view`](M3e-StepperPrevious#view).
-}
stepperPrevious : List (Element any msg) -> Element { s | stepperPrevious : Supported } msg
stepperPrevious =
    StepperPrevious.view


{-| A stepper "reset" action. Re-export of [`M3e.StepperReset.view`](M3e-StepperReset#view).
-}
stepperReset : List (Element any msg) -> Element { s | stepperReset : Supported } msg
stepperReset =
    StepperReset.view


{-| A table of contents. Re-export of [`M3e.Toc.view`](M3e-Toc#view).
-}
toc : { for : String } -> List (Toc.Option msg) -> Element { s | toc : Supported } msg
toc =
    Toc.view



-- LISTS, MENUS AND CONTAINERS --------------------------------------------


{-| A menu. Re-export of [`M3e.Menu.view`](M3e-Menu#view).
-}
menu : { items : List (Element { menuItem : Supported } msg) } -> List (Menu.Option msg) -> Element { s | menu : Supported } msg
menu =
    Menu.view


{-| A static list. Re-export of [`M3e.List.list`](M3e-List#list).
-}
list : { items : List (Element { listItem : Supported } msg) } -> List (MList.Option msg) -> Element { s | list : Supported } msg
list =
    MList.list


{-| An action list. Re-export of [`M3e.List.actionList`](M3e-List#actionList).
-}
actionList : { items : List (Element { actionItem : Supported } msg) } -> List (MList.Option msg) -> Element { s | list : Supported } msg
actionList =
    MList.actionList


{-| A selection list. Re-export of [`M3e.List.selectionList`](M3e-List#selectionList).
-}
selectionList : { items : List (Element { optionItem : Supported } msg) } -> List (MList.SelectionOption msg) -> Element { s | list : Supported } msg
selectionList =
    MList.selectionList


{-| A tree. Re-export of [`M3e.Tree.view`](M3e-Tree#view).
-}
tree : { items : List (Element { treeItem : Supported } msg) } -> List (Tree.Option msg) -> Element { s | tree : Supported } msg
tree =
    Tree.view


{-| A disclosure / accordion. Re-export of [`M3e.Disclosure.view`](M3e-Disclosure#view).
-}
disclosure : { sections : List (Element { section : Supported } msg) } -> List (Disclosure.Option msg) -> Element { s | disclosure : Supported } msg
disclosure =
    Disclosure.view


{-| A collapsible. Re-export of [`M3e.Collapsible.view`](M3e-Collapsible#view).
-}
collapsible : { content : List (Element any msg) } -> List (Collapsible.Option msg) -> Element { s | collapsible : Supported } msg
collapsible =
    Collapsible.view


{-| A bottom sheet. Re-export of [`M3e.BottomSheet.view`](M3e-BottomSheet#view).
-}
bottomSheet : { content : List (Element any msg) } -> List (BottomSheet.Option msg) -> Element { s | bottomSheet : Supported } msg
bottomSheet =
    BottomSheet.view


{-| A bottom-sheet trigger. Re-export of [`M3e.BottomSheetTrigger.view`](M3e-BottomSheetTrigger#view).
-}
bottomSheetTrigger : List (Element any msg) -> List (BottomSheetTrigger.Option msg) -> Element { s | bottomSheetTrigger : Supported } msg
bottomSheetTrigger =
    BottomSheetTrigger.view


{-| A side sheet. Re-export of [`M3e.SideSheet.view`](M3e-SideSheet#view).
-}
sideSheet : { content : List (Element any msg) } -> List (SideSheet.Option msg) -> Element { s | sideSheet : Supported } msg
sideSheet =
    SideSheet.view


{-| A floating panel. Re-export of [`M3e.FloatingPanel.view`](M3e-FloatingPanel#view).
-}
floatingPanel : { content : List (Element any msg) } -> List (FloatingPanel.Option msg) -> Element { s | floatingPanel : Supported } msg
floatingPanel =
    FloatingPanel.view


{-| A scroll container. Re-export of [`M3e.ScrollContainer.view`](M3e-ScrollContainer#view).
-}
scrollContainer : { content : List (Element any msg) } -> List (ScrollContainer.Option msg) -> Element { s | scrollContainer : Supported } msg
scrollContainer =
    ScrollContainer.view


{-| A split pane. Re-export of [`M3e.SplitPane.view`](M3e-SplitPane#view).
-}
splitPane : { start : List (Element any msg), end : List (Element any msg) } -> List (SplitPane.Option msg) -> Element { s | splitPane : Supported } msg
splitPane =
    SplitPane.view


{-| A content pane. Re-export of [`M3e.ContentPane.view`](M3e-ContentPane#view).
-}
contentPane : { content : List (Element any msg) } -> Element { s | contentPane : Supported } msg
contentPane =
    ContentPane.view


{-| An option panel. Re-export of [`M3e.OptionPanel.view`](M3e-OptionPanel#view).
-}
optionPanel : { content : List (Element any msg) } -> List (OptionPanel.Option msg) -> Element { s | optionPanel : Supported } msg
optionPanel =
    OptionPanel.view


{-| A slide carousel. Re-export of [`M3e.Slide.view`](M3e-Slide#view).
-}
slide : { items : List (Element any msg) } -> List (Slide.Option msg) -> Element { s | slide : Supported } msg
slide =
    Slide.view



-- LAYOUT AND MISC --------------------------------------------------------


{-| A form field wrapper. Re-export of [`M3e.Field.view`](M3e-Field#view).
-}
field :
    { id : String
    , label : Label msg
    , control :
        Element
            { switch : Supported
            , checkbox : Supported
            , slider : Supported
            , radioButton : Supported
            , select : Supported
            , textField : Supported
            , timePicker : Supported
            , datePicker : Supported
            , segment : Supported
            , element : Supported
            }
            msg
    }
    -> List (Field.Option msg)
    -> Node msg
field =
    Field.view


{-| A theme provider. Re-export of [`M3e.Theme.view`](M3e-Theme#view).
-}
theme : { content : List (Element any msg) } -> List (Theme.Option msg) -> Element { s | theme : Supported } msg
theme =
    Theme.view


{-| A rich-tooltip action region. Re-export of [`M3e.RichTooltipAction.view`](M3e-RichTooltipAction#view).
-}
richTooltipAction : List (Element any msg) -> List (RichTooltipAction.Option msg) -> Element { s | richTooltipAction : Supported } msg
richTooltipAction =
    RichTooltipAction.view



-- CONTAINER CHILD ELEMENTS -----------------------------------------------


{-| A breadcrumb item. Re-export of [`M3e.Breadcrumb.item`](M3e-Breadcrumb#item).
-}
breadcrumbItem : { label : String } -> List (Breadcrumb.ItemOption msg) -> Element { s | breadcrumbItem : Supported } msg
breadcrumbItem =
    Breadcrumb.item


{-| A menu item. Re-export of [`M3e.Menu.item`](M3e-Menu#item).
-}
menuItem : { label : String, action : ItemAction msg } -> List (Menu.ItemOption msg) -> Element { menuItem : Supported } msg
menuItem =
    Menu.item


{-| A menu checkbox item. Re-export of [`M3e.Menu.checkboxItem`](M3e-Menu#checkboxItem).
-}
menuCheckboxItem : { label : String, onChange : Bool -> msg } -> List (Menu.CheckboxItemOption msg) -> Element { menuItem : Supported } msg
menuCheckboxItem =
    Menu.checkboxItem


{-| A menu radio item. Re-export of [`M3e.Menu.radioItem`](M3e-Menu#radioItem).
-}
menuRadioItem : { label : String, onClick : msg } -> List (Menu.RadioItemOption msg) -> Element { menuItem : Supported } msg
menuRadioItem =
    Menu.radioItem


{-| A nested menu group. Re-export of [`M3e.Menu.group`](M3e-Menu#group).
-}
menuGroup : { label : String, items : List (Element { menuItem : Supported } msg) } -> Element { menuItem : Supported } msg
menuGroup =
    Menu.group


{-| A submenu trigger. Re-export of [`M3e.Menu.triggerFor`](M3e-Menu#triggerFor).
-}
menuTriggerFor : String -> Element { s | element : Supported } msg
menuTriggerFor =
    Menu.triggerFor


{-| A navigation-bar item. Re-export of [`M3e.NavigationBar.item`](M3e-NavigationBar#item).
-}
navBarItem : { icon : Element { icon : Supported } msg, label : String } -> List (NavigationBar.ItemOption msg) -> Element { navItem : Supported } msg
navBarItem =
    NavigationBar.item


{-| A navigation-rail item. Re-export of [`M3e.NavigationRail.item`](M3e-NavigationRail#item).
-}
navRailItem : { icon : Element { icon : Supported } msg, label : String } -> List (NavigationRail.ItemOption msg) -> Element { s | navItem : Supported } msg
navRailItem =
    NavigationRail.item


{-| A navigation-drawer link. Re-export of [`M3e.NavigationDrawer.link`](M3e-NavigationDrawer#link).
-}
navDrawerLink : { label : String, href : String } -> List (NavigationDrawer.LinkOption msg) -> Element { navMenuItem : Supported } msg
navDrawerLink =
    NavigationDrawer.link


{-| A navigation-drawer group. Re-export of [`M3e.NavigationDrawer.group`](M3e-NavigationDrawer#group).
-}
navDrawerGroup : { label : String } -> List (Element { navMenuItem : Supported } msg) -> List (NavigationDrawer.GroupOption msg) -> Element { navMenuItem : Supported } msg
navDrawerGroup =
    NavigationDrawer.group


{-| A static list item. Re-export of [`M3e.List.item`](M3e-List#item).
-}
listItem : { headline : String } -> List (MList.StaticItemOption msg) -> Element { listItem : Supported } msg
listItem =
    MList.item


{-| An action list item. Re-export of [`M3e.List.actionItem`](M3e-List#actionItem).
-}
listActionItem : { headline : String } -> List (MList.ActionItemOption msg) -> Element { actionItem : Supported } msg
listActionItem =
    MList.actionItem


{-| A selection list option. Re-export of [`M3e.List.option`](M3e-List#option).
-}
listOption : { headline : String } -> List (MList.OptionItemOption msg) -> Element { optionItem : Supported } msg
listOption =
    MList.option


{-| A list divider. Re-export of [`M3e.List.divider`](M3e-List#divider).
-}
listDivider : Element { listItem : Supported } msg
listDivider =
    MList.divider


{-| An expandable list item. Re-export of [`M3e.List.expandable`](M3e-List#expandable).
-}
listExpandable : { headline : String, children : List (Element { listItem : Supported } msg) } -> List (MList.ExpandableItemOption msg) -> Element { listItem : Supported } msg
listExpandable =
    MList.expandable


{-| A FAB-menu item. Re-export of [`M3e.FabMenu.item`](M3e-FabMenu#item).
-}
fabMenuItem : { icon : String, label : String, onClick : msg } -> Element { s | fabMenuItem : Supported } msg
fabMenuItem =
    FabMenu.item


{-| A disclosure section. Re-export of [`M3e.Disclosure.section`](M3e-Disclosure#section).
-}
disclosureSection : { header : String, content : List (Element any msg) } -> List (Disclosure.SectionOption msg) -> Element { s | section : Supported } msg
disclosureSection =
    Disclosure.section


{-| A segmented-button segment. Re-export of [`M3e.SegmentedButton.segment`](M3e-SegmentedButton#segment).
-}
segment : { label : String, checked : Bool } -> List (SegmentedButton.SegmentOption msg) -> Element { s | segment : Supported } msg
segment =
    SegmentedButton.segment


{-| A slide group. Re-export of [`M3e.Slide.slideGroup`](M3e-Slide#slideGroup).
-}
slideGroup : { content : List (Element any msg) } -> List (Slide.SlideGroupOption msg) -> Element { s | slideGroup : Supported } msg
slideGroup =
    Slide.slideGroup


{-| A select option. Re-export of [`M3e.Select.option`](M3e-Select#option).
-}
selectOption : { value : String, label : String } -> List (Select.OptionOption msg) -> Element { selectOption : Supported } msg
selectOption =
    Select.option


{-| The select options setter. Re-export of [`M3e.Select.options`](M3e-Select#options).
-}
selectOptions : List (Element { selectOption : Supported } msg) -> Select.Option msg
selectOptions =
    Select.options


{-| An autocomplete option. Re-export of [`M3e.Autocomplete.option`](M3e-Autocomplete#option).
-}
autocompleteOption : { value : String, label : String } -> List (Autocomplete.OptionOption msg) -> Element { s | autocompleteOption : Supported } msg
autocompleteOption =
    Autocomplete.option


{-| The autocomplete options setter. Re-export of [`M3e.Autocomplete.options`](M3e-Autocomplete#options).
-}
autocompleteOptions : List (Element { autocompleteOption : Supported } msg) -> Autocomplete.Option msg
autocompleteOptions =
    Autocomplete.options


{-| A stepper step. Re-export of [`M3e.Stepper.step`](M3e-Stepper#step).
-}
step : { label : String } -> List (Stepper.StepOption msg) -> Element { s | step : Supported } msg
step =
    Stepper.step


{-| A stepper step panel. Re-export of [`M3e.Stepper.stepPanel`](M3e-Stepper#stepPanel).
-}
stepPanel : { content : List (Element any msg) } -> List (Stepper.PanelOption msg) -> Element { s | stepPanel : Supported } msg
stepPanel =
    Stepper.stepPanel


{-| A tab. Re-export of [`M3e.Tabs.tab`](M3e-Tabs#tab).
-}
tab : { label : String } -> List (Tabs.TabOption msg) -> Element { t | tab : Supported } msg
tab =
    Tabs.tab


{-| A tab panel. Re-export of [`M3e.Tabs.panel`](M3e-Tabs#panel).
-}
tabPanel : { content : List (Element any msg) } -> List (Tabs.PanelOption msg) -> Element { p | tabPanel : Supported } msg
tabPanel =
    Tabs.panel


{-| A tree item. Re-export of [`M3e.Tree.treeItem`](M3e-Tree#treeItem).
-}
treeItem : { label : String, children : List (Element { treeItem : Supported } msg) } -> List (Tree.ItemOption msg) -> Element { s | treeItem : Supported } msg
treeItem =
    Tree.treeItem


{-| A filter chip set. Re-export of [`M3e.ChipSet.filterSet`](M3e-ChipSet#filterSet).
-}
chipFilterSet : { label : String } -> List (ChipSet.Option msg) -> Element { s | chipSet : Supported } msg
chipFilterSet =
    ChipSet.filterSet


{-| An input chip set. Re-export of [`M3e.ChipSet.inputSet`](M3e-ChipSet#inputSet).
-}
chipInputSet : { label : String } -> List (ChipSet.Option msg) -> Element { s | chipSet : Supported } msg
chipInputSet =
    ChipSet.inputSet



-- COMPANION VALUE TYPES --------------------------------------------------


{-| A form-field label. Re-export of [`M3e.Label.Label`](M3e-Label#Label).
-}
type alias Label msg =
    MLabel.Label msg


{-| Build a [`Label`](#Label) from raw `Html`. Re-export of
[`M3e.Label.fromHtml`](M3e-Label#fromHtml).
-}
labelFromHtml : Html msg -> Label msg
labelFromHtml =
    MLabel.fromHtml


{-| A typescale role for [`typography`](#typography). Re-export of
[`M3e.Text.Role`](M3e-Text#Role).
-}
type alias Role =
    Text.Role


{-| The `body-large` typescale role. Re-export of `M3e.Text.BodyLarge`.
-}
roleBodyLarge : Role
roleBodyLarge =
    Text.BodyLarge


{-| The `body-medium` typescale role. Re-export of `M3e.Text.BodyMedium`.
-}
roleBodyMedium : Role
roleBodyMedium =
    Text.BodyMedium


{-| The `body-small` typescale role. Re-export of `M3e.Text.BodySmall`.
-}
roleBodySmall : Role
roleBodySmall =
    Text.BodySmall


{-| The `label-large` typescale role. Re-export of `M3e.Text.LabelLarge`.
-}
roleLabelLarge : Role
roleLabelLarge =
    Text.LabelLarge


{-| The `label-medium` typescale role. Re-export of `M3e.Text.LabelMedium`.
-}
roleLabelMedium : Role
roleLabelMedium =
    Text.LabelMedium


{-| The `label-small` typescale role. Re-export of `M3e.Text.LabelSmall`.
-}
roleLabelSmall : Role
roleLabelSmall =
    Text.LabelSmall


{-| The shape of a [`progress`](#progress) indicator. Re-export of
[`M3e.Progress.Shape`](M3e-Progress#Shape).
-}
type alias ProgressShape =
    Progress.Shape


{-| A linear (bar) progress indicator. Re-export of `M3e.Progress.Linear`.
-}
progressLinear : ProgressShape
progressLinear =
    Progress.Linear


{-| A circular (ring) progress indicator. Re-export of `M3e.Progress.Circular`.
-}
progressCircular : ProgressShape
progressCircular =
    Progress.Circular


{-| The action taken by a [`menuItem`](#menuItem). Re-export of
[`M3e.Menu.ItemAction`](M3e-Menu#ItemAction).
-}
type alias ItemAction msg =
    Menu.ItemAction msg


{-| A menu item that fires a message on click. Re-export of `M3e.Menu.Click`.
-}
menuClick : msg -> ItemAction msg
menuClick =
    Menu.Click


{-| A menu item that navigates to a URL. Re-export of `M3e.Menu.Link`.
-}
menuLink : String -> ItemAction msg
menuLink =
    Menu.Link
