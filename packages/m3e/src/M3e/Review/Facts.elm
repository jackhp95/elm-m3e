module M3e.Review.Facts exposing (Fact, facts)

{-| GENERATED — per-component facts for the codegen-aware elm-review rules
(ADR 0012). Do not edit by hand; regenerate via `bin/elm-cem.js`.

PROVISIONAL: the `shapes` and `requiredAttrs` fields are pending the facts
spec (see docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md).
Their schema may change; consumers should not rely on stability yet.

@docs Fact, facts
-}


{-| Per-component facts: valid enum token names per attribute, the
required/multi slot names, which shapes the component emits, and which
HTML attributes are required (for D1 missing-required-attribute rule).
-}
type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    , shapes : List String -- PROVISIONAL, may change
    , requiredAttrs : List String -- PROVISIONAL, may change
    }


{-| Every top-layer component's facts. -}
facts : List Fact
facts =
    [ { component = "tree", module_ = "M3e.Tree", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "treeItem", module_ = "M3e.TreeItem", enums = [], requiredSlots = [ "label" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "toolbar", module_ = "M3e.Toolbar", enums = [ ( "shape", [ "rounded", "square" ] ), ( "variant", [ "standard", "vibrant" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "toc", module_ = "M3e.Toc", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "tocItem", module_ = "M3e.TocItem", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "themeIcon", module_ = "M3e.ThemeIcon", enums = [ ( "scheme", [ "auto", "dark", "light" ] ), ( "variant", [ "content", "expressive", "fidelity", "fruitSalad", "monochrome", "neutral", "rainbow", "tonalSpot", "vibrant" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "theme", module_ = "M3e.Theme", enums = [ ( "contrast", [ "high", "medium", "standard" ] ), ( "scheme", [ "auto", "dark", "light" ] ), ( "variant", [ "content", "expressive", "fidelity", "fruitSalad", "monochrome", "neutral", "rainbow", "tonalSpot", "vibrant" ] ), ( "motion", [ "expressive", "standard" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "textareaAutosize", module_ = "M3e.TextareaAutosize", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "tabs", module_ = "M3e.Tabs", enums = [ ( "headerPosition", [ "after", "before" ] ), ( "variant", [ "primary", "secondary" ] ) ], requiredSlots = [], multiSlots = [ "unnamed", "panel" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "tabPanel", module_ = "M3e.TabPanel", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "tab", module_ = "M3e.Tab", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "switch", module_ = "M3e.Switch", enums = [ ( "icons", [ "both", "none", "selected" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "stepperReset", module_ = "M3e.StepperReset", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "stepperPrevious", module_ = "M3e.StepperPrevious", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "step", module_ = "M3e.Step", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "stepPanel", module_ = "M3e.StepPanel", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "stepper", module_ = "M3e.Stepper", enums = [ ( "headerPosition", [ "above", "below" ] ), ( "labelPosition", [ "below", "end" ] ), ( "orientation", [ "auto", "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [ "step", "panel" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "splitPane", module_ = "M3e.SplitPane", enums = [ ( "orientation", [ "auto", "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "splitButton", module_ = "M3e.SplitButton", enums = [ ( "variant", [ "elevated", "filled", "outlined", "tonal" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ) ], requiredSlots = [ "leading-button", "trailing-button" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "snackbar", module_ = "M3e.Snackbar", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "slider", module_ = "M3e.Slider", enums = [ ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "sliderThumb", module_ = "M3e.SliderThumb", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "slideGroup", module_ = "M3e.SlideGroup", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "skeleton", module_ = "M3e.Skeleton", enums = [ ( "animation", [ "none", "pulse", "wave" ] ), ( "shape", [ "auto", "circular", "rounded", "square" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "shape", module_ = "M3e.Shape", enums = [ ( "name", [ "value12SidedCookie", "value4LeafClover", "value4SidedCookie", "value6SidedCookie", "value7SidedCookie", "value8LeafClover", "value9SidedCookie", "arch", "arrow", "boom", "bun", "burst", "circle", "diamond", "fan", "flower", "gem", "ghostIsh", "heart", "hexagon", "oval", "pentagon", "pill", "pixelCircle", "pixelTriangle", "puffy", "puffyDiamond", "semicircle", "slanted", "softBoom", "softBurst", "square", "sunny", "triangle", "verySunny" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "segmentedButton", module_ = "M3e.SegmentedButton", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "buttonSegment", module_ = "M3e.ButtonSegment", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "searchView", module_ = "M3e.SearchView", enums = [ ( "mode", [ "auto", "docked", "fullscreen" ] ) ], requiredSlots = [ "input" ], multiSlots = [ "unnamed", "open-leading", "open-trailing", "closed-leading", "closed-trailing" ], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "searchBar", module_ = "M3e.SearchBar", enums = [], requiredSlots = [ "input" ], multiSlots = [ "leading", "trailing" ], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "radioGroup", module_ = "M3e.RadioGroup", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "radio", module_ = "M3e.Radio", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "progressElementIndicatorBase", module_ = "M3e.ProgressElementIndicatorBase", enums = [ ( "variant", [ "flat", "wavy" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "paginator", module_ = "M3e.Paginator", enums = [ ( "pageSize", [ "all" ] ), ( "pageSizeVariant", [ "filled", "outlined" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "select", module_ = "M3e.Select", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navRailToggle", module_ = "M3e.NavRailToggle", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navRail", module_ = "M3e.NavRail", enums = [ ( "mode", [ "auto", "compact", "expanded" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navMenuItemGroup", module_ = "M3e.NavMenuItemGroup", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navMenu", module_ = "M3e.NavMenu", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navMenuItem", module_ = "M3e.NavMenuItem", enums = [], requiredSlots = [ "label" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "navBar", module_ = "M3e.NavBar", enums = [ ( "mode", [ "auto", "compact", "expanded" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "navItem", module_ = "M3e.NavItem", enums = [ ( "orientation", [ "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuItemRadio", module_ = "M3e.MenuItemRadio", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuItemGroup", module_ = "M3e.MenuItemGroup", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuItemCheckbox", module_ = "M3e.MenuItemCheckbox", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menu", module_ = "M3e.Menu", enums = [ ( "positionX", [ "after", "before" ] ), ( "positionY", [ "above", "below" ] ), ( "variant", [ "standard", "vibrant" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuItem", module_ = "M3e.MenuItem", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuTrigger", module_ = "M3e.MenuTrigger", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "menuItemElementBase", module_ = "M3e.MenuItemElementBase", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "loadingIndicator", module_ = "M3e.LoadingIndicator", enums = [ ( "variant", [ "contained", "uncontained" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "selectionList", module_ = "M3e.SelectionList", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "listOption", module_ = "M3e.ListOption", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "actionList", module_ = "M3e.ActionList", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "expandableListItem", module_ = "M3e.ExpandableListItem", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "listAction", module_ = "M3e.ListAction", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "listItemButton", module_ = "M3e.ListItemButton", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "list", module_ = "M3e.List", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "listItem", module_ = "M3e.ListItem", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "icon", module_ = "M3e.Icon", enums = [ ( "grade", [ "high", "low", "medium" ] ), ( "variant", [ "outlined", "rounded", "sharp" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "heading", module_ = "M3e.Heading", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "variant", [ "display", "headline", "label", "title" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "fabMenuTrigger", module_ = "M3e.FabMenuTrigger", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "fabMenu", module_ = "M3e.FabMenu", enums = [ ( "variant", [ "primary", "secondary", "tertiary" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "fab", module_ = "M3e.Fab", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "primary", "primaryContainer", "secondary", "secondaryContainer", "surface", "tertiary", "tertiaryContainer" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "accordion", module_ = "M3e.Accordion", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "expansionPanel", module_ = "M3e.ExpansionPanel", enums = [ ( "toggleDirection", [ "horizontal", "vertical" ] ), ( "togglePosition", [ "after", "before" ] ) ], requiredSlots = [], multiSlots = [ "actions" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "expansionHeader", module_ = "M3e.ExpansionHeader", enums = [ ( "toggleDirection", [ "horizontal", "vertical" ] ), ( "togglePosition", [ "after", "before" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "drawerToggle", module_ = "M3e.DrawerToggle", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "drawerContainer", module_ = "M3e.DrawerContainer", enums = [ ( "endMode", [ "auto", "over", "push", "side" ] ), ( "startMode", [ "auto", "over", "push", "side" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "divider", module_ = "M3e.Divider", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "dialogTrigger", module_ = "M3e.DialogTrigger", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "dialog", module_ = "M3e.Dialog", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "dialogAction", module_ = "M3e.DialogAction", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "datepickerToggle", module_ = "M3e.DatepickerToggle", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "datepicker", module_ = "M3e.Datepicker", enums = [ ( "variant", [ "auto", "docked", "modal" ] ), ( "startView", [ "month", "multiYear", "year" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "contentPane", module_ = "M3e.ContentPane", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "suggestionChip", module_ = "M3e.SuggestionChip", enums = [ ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "inputChipSet", module_ = "M3e.InputChipSet", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "inputChip", module_ = "M3e.InputChip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "filterChipSet", module_ = "M3e.FilterChipSet", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "filterChip", module_ = "M3e.FilterChip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "chipSet", module_ = "M3e.ChipSet", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "assistChip", module_ = "M3e.AssistChip", enums = [ ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "chip", module_ = "M3e.Chip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "checkbox", module_ = "M3e.Checkbox", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "card", module_ = "M3e.Card", enums = [ ( "orientation", [ "horizontal", "vertical" ] ), ( "variant", [ "elevated", "filled", "outlined" ] ), ( "type", [ "button", "reset", "submit" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "calendar", module_ = "M3e.Calendar", enums = [ ( "startView", [ "month", "multiYear", "year" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "yearView", module_ = "M3e.YearView", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "multiYearView", module_ = "M3e.MultiYearView", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "monthView", module_ = "M3e.MonthView", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "tooltip", module_ = "M3e.Tooltip", enums = [ ( "position", [ "above", "after", "before", "below" ] ), ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "richTooltip", module_ = "M3e.RichTooltip", enums = [ ( "position", [ "above", "aboveAfter", "aboveBefore", "after", "before", "below", "belowAfter", "belowBefore" ] ), ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "tooltipElementBase", module_ = "M3e.TooltipElementBase", enums = [ ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "richTooltipAction", module_ = "M3e.RichTooltipAction", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "buttonGroup", module_ = "M3e.ButtonGroup", enums = [ ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "variant", [ "connected", "standard" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "iconButton", module_ = "M3e.IconButton", enums = [ ( "shape", [ "rounded", "square" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "filled", "outlined", "standard", "tonal" ] ), ( "width", [ "default", "narrow", "wide" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "button", module_ = "M3e.Button", enums = [ ( "shape", [ "rounded", "square" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "filled", "outlined", "text", "tonal" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "breadcrumb", module_ = "M3e.Breadcrumb", enums = [], requiredSlots = [ "unnamed" ], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "breadcrumbItem", module_ = "M3e.BreadcrumbItem", enums = [ ( "current", [ "date", "location", "page", "step", "time", "true" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "breadcrumbItemButton", module_ = "M3e.BreadcrumbItemButton", enums = [ ( "current", [ "date", "location", "page", "step", "time", "true" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "bottomSheetTrigger", module_ = "M3e.BottomSheetTrigger", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "bottomSheet", module_ = "M3e.BottomSheet", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "bottomSheetAction", module_ = "M3e.BottomSheetAction", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "badge", module_ = "M3e.Badge", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "position", [ "above", "aboveAfter", "aboveBefore", "after", "before", "below", "belowAfter", "belowBefore" ] ) ], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "avatar", module_ = "M3e.Avatar", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "autocomplete", module_ = "M3e.Autocomplete", enums = [ ( "filter", [ "contains", "endsWith", "none", "startsWith" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "formField", module_ = "M3e.FormField", enums = [ ( "floatLabel", [ "always", "auto" ] ), ( "hideSubscript", [ "always", "auto", "never" ] ), ( "variant", [ "filled", "outlined" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "optionPanel", module_ = "M3e.OptionPanel", enums = [ ( "state", [ "content", "loading", "noData" ] ), ( "scrollStrategy", [ "hide", "reposition" ] ) ], requiredSlots = [], multiSlots = [ "unnamed", "loading" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "floatingPanel", module_ = "M3e.FloatingPanel", enums = [ ( "scrollStrategy", [ "hide", "reposition" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "optgroup", module_ = "M3e.Optgroup", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "option", module_ = "M3e.Option", enums = [ ( "highlightMode", [ "contains", "endsWith", "startsWith" ] ) ], requiredSlots = [ "unnamed" ], multiSlots = [], shapes = [ "Shape3", "Shape4" ], requiredAttrs = [] }
    , { component = "focusTrap", module_ = "M3e.FocusTrap", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "appBar", module_ = "M3e.AppBar", enums = [ ( "size", [ "large", "medium", "small" ] ) ], requiredSlots = [], multiSlots = [ "trailing" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "textOverflow", module_ = "M3e.TextOverflow", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "textHighlight", module_ = "M3e.TextHighlight", enums = [ ( "mode", [ "contains", "endsWith", "startsWith" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "stateLayer", module_ = "M3e.StateLayer", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "slide", module_ = "M3e.Slide", enums = [], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "scrollContainer", module_ = "M3e.ScrollContainer", enums = [ ( "dividers", [ "above", "aboveBelow", "below", "none" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "ripple", module_ = "M3e.Ripple", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "pseudoRadio", module_ = "M3e.PseudoRadio", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "pseudoCheckbox", module_ = "M3e.PseudoCheckbox", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "focusRing", module_ = "M3e.FocusRing", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "elevation", module_ = "M3e.Elevation", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "collapsible", module_ = "M3e.Collapsible", enums = [ ( "orientation", [ "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [ "unnamed" ], shapes = [ "Shape3" ], requiredAttrs = [] }
    , { component = "actionElementBase", module_ = "M3e.ActionElementBase", enums = [], requiredSlots = [], multiSlots = [], shapes = [ "Shape3" ], requiredAttrs = [] }
    ]
