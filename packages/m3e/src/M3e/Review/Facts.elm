module M3e.Review.Facts exposing (Fact, facts)

{-| GENERATED — per-component facts for the codegen-aware elm-review rules
(ADR 0012). Do not edit by hand; regenerate via `bin/elm-cem.js`.

@docs Fact, facts
-}


{-| Per-component facts: valid enum token names per attribute, and the
required/multi slot names. -}
type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    }


{-| Every top-layer component's facts. -}
facts : List Fact
facts =
    [ { component = "tree", module_ = "M3e.Tree", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "treeItem", module_ = "M3e.TreeItem", enums = [], requiredSlots = [ "label" ], multiSlots = [ "default" ] }
    , { component = "toolbar", module_ = "M3e.Toolbar", enums = [ ( "shape", [ "rounded", "square" ] ), ( "variant", [ "standard", "vibrant" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "toc", module_ = "M3e.Toc", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "tocItem", module_ = "M3e.TocItem", enums = [], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "themeIcon", module_ = "M3e.ThemeIcon", enums = [ ( "scheme", [ "auto", "dark", "light" ] ), ( "variant", [ "content", "expressive", "fidelity", "fruitSalad", "monochrome", "neutral", "rainbow", "tonalSpot", "vibrant" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "theme", module_ = "M3e.Theme", enums = [ ( "contrast", [ "high", "medium", "standard" ] ), ( "scheme", [ "auto", "dark", "light" ] ), ( "variant", [ "content", "expressive", "fidelity", "fruitSalad", "monochrome", "neutral", "rainbow", "tonalSpot", "vibrant" ] ), ( "motion", [ "expressive", "standard" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "textareaAutosize", module_ = "M3e.TextareaAutosize", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "tabs", module_ = "M3e.Tabs", enums = [ ( "headerPosition", [ "after", "before" ] ), ( "variant", [ "primary", "secondary" ] ) ], requiredSlots = [], multiSlots = [ "default", "panel" ] }
    , { component = "tabPanel", module_ = "M3e.TabPanel", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "tab", module_ = "M3e.Tab", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "switch", module_ = "M3e.Switch", enums = [ ( "icons", [ "both", "none", "selected" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "stepperReset", module_ = "M3e.StepperReset", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "stepperPrevious", module_ = "M3e.StepperPrevious", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "step", module_ = "M3e.Step", enums = [], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "stepPanel", module_ = "M3e.StepPanel", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "stepper", module_ = "M3e.Stepper", enums = [ ( "headerPosition", [ "above", "below" ] ), ( "labelPosition", [ "below", "end" ] ), ( "orientation", [ "auto", "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [ "default", "step", "panel" ] }
    , { component = "splitPane", module_ = "M3e.SplitPane", enums = [ ( "orientation", [ "auto", "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "splitButton", module_ = "M3e.SplitButton", enums = [ ( "variant", [ "elevated", "filled", "outlined", "tonal" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ) ], requiredSlots = [ "leading-button", "trailing-button" ], multiSlots = [ "default" ] }
    , { component = "snackbar", module_ = "M3e.Snackbar", enums = [], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "slider", module_ = "M3e.Slider", enums = [ ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ) ], requiredSlots = [ "default" ], multiSlots = [ "default" ] }
    , { component = "sliderThumb", module_ = "M3e.SliderThumb", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "slideGroup", module_ = "M3e.SlideGroup", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "skeleton", module_ = "M3e.Skeleton", enums = [ ( "animation", [ "none", "pulse", "wave" ] ), ( "shape", [ "auto", "circular", "rounded", "square" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "shape", module_ = "M3e.Shape", enums = [ ( "name", [ "value12SidedCookie", "value4LeafClover", "value4SidedCookie", "value6SidedCookie", "value7SidedCookie", "value8LeafClover", "value9SidedCookie", "arch", "arrow", "boom", "bun", "burst", "circle", "diamond", "fan", "flower", "gem", "ghostIsh", "heart", "hexagon", "oval", "pentagon", "pill", "pixelCircle", "pixelTriangle", "puffy", "puffyDiamond", "semicircle", "slanted", "softBoom", "softBurst", "square", "sunny", "triangle", "verySunny" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "segmentedButton", module_ = "M3e.SegmentedButton", enums = [], requiredSlots = [ "default" ], multiSlots = [ "default" ] }
    , { component = "buttonSegment", module_ = "M3e.ButtonSegment", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "searchView", module_ = "M3e.SearchView", enums = [ ( "mode", [ "auto", "docked", "fullscreen" ] ) ], requiredSlots = [ "input" ], multiSlots = [ "default", "open-leading", "open-trailing", "closed-leading", "closed-trailing" ] }
    , { component = "searchBar", module_ = "M3e.SearchBar", enums = [], requiredSlots = [ "input" ], multiSlots = [ "leading", "trailing" ] }
    , { component = "radioGroup", module_ = "M3e.RadioGroup", enums = [], requiredSlots = [ "default" ], multiSlots = [ "default" ] }
    , { component = "radio", module_ = "M3e.Radio", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "progressElementIndicatorBase", module_ = "M3e.ProgressElementIndicatorBase", enums = [ ( "variant", [ "flat", "wavy" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "paginator", module_ = "M3e.Paginator", enums = [ ( "pageSize", [ "all" ] ), ( "pageSizeVariant", [ "filled", "outlined" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "select", module_ = "M3e.Select", enums = [], requiredSlots = [ "default" ], multiSlots = [ "default" ] }
    , { component = "navRailToggle", module_ = "M3e.NavRailToggle", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "navRail", module_ = "M3e.NavRail", enums = [ ( "mode", [ "auto", "compact", "expanded" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "navMenuItemGroup", module_ = "M3e.NavMenuItemGroup", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "navMenu", module_ = "M3e.NavMenu", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "navMenuItem", module_ = "M3e.NavMenuItem", enums = [], requiredSlots = [ "label" ], multiSlots = [ "default" ] }
    , { component = "navBar", module_ = "M3e.NavBar", enums = [ ( "mode", [ "auto", "compact", "expanded" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "navItem", module_ = "M3e.NavItem", enums = [ ( "orientation", [ "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "menuItemRadio", module_ = "M3e.MenuItemRadio", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "menuItemGroup", module_ = "M3e.MenuItemGroup", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "menuItemCheckbox", module_ = "M3e.MenuItemCheckbox", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "menu", module_ = "M3e.Menu", enums = [ ( "positionX", [ "after", "before" ] ), ( "positionY", [ "above", "below" ] ), ( "variant", [ "standard", "vibrant" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "menuItem", module_ = "M3e.MenuItem", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "menuTrigger", module_ = "M3e.MenuTrigger", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "menuItemElementBase", module_ = "M3e.MenuItemElementBase", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "loadingIndicator", module_ = "M3e.LoadingIndicator", enums = [ ( "variant", [ "contained", "uncontained" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "selectionList", module_ = "M3e.SelectionList", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "listOption", module_ = "M3e.ListOption", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "actionList", module_ = "M3e.ActionList", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "expandableListItem", module_ = "M3e.ExpandableListItem", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "listAction", module_ = "M3e.ListAction", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "listItemButton", module_ = "M3e.ListItemButton", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "list", module_ = "M3e.List", enums = [ ( "variant", [ "segmented", "standard" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "listItem", module_ = "M3e.ListItem", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "icon", module_ = "M3e.Icon", enums = [ ( "grade", [ "high", "low", "medium" ] ), ( "variant", [ "outlined", "rounded", "sharp" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "heading", module_ = "M3e.Heading", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "variant", [ "display", "headline", "label", "title" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "fabMenuTrigger", module_ = "M3e.FabMenuTrigger", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "fabMenu", module_ = "M3e.FabMenu", enums = [ ( "variant", [ "primary", "secondary", "tertiary" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "fab", module_ = "M3e.Fab", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "primary", "primaryContainer", "secondary", "secondaryContainer", "surface", "tertiary", "tertiaryContainer" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "accordion", module_ = "M3e.Accordion", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "expansionPanel", module_ = "M3e.ExpansionPanel", enums = [ ( "toggleDirection", [ "horizontal", "vertical" ] ), ( "togglePosition", [ "after", "before" ] ) ], requiredSlots = [], multiSlots = [ "actions" ] }
    , { component = "expansionHeader", module_ = "M3e.ExpansionHeader", enums = [ ( "toggleDirection", [ "horizontal", "vertical" ] ), ( "togglePosition", [ "after", "before" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "drawerToggle", module_ = "M3e.DrawerToggle", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "drawerContainer", module_ = "M3e.DrawerContainer", enums = [ ( "endMode", [ "auto", "over", "push", "side" ] ), ( "startMode", [ "auto", "over", "push", "side" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "divider", module_ = "M3e.Divider", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "dialogTrigger", module_ = "M3e.DialogTrigger", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "dialog", module_ = "M3e.Dialog", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "dialogAction", module_ = "M3e.DialogAction", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "datepickerToggle", module_ = "M3e.DatepickerToggle", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "datepicker", module_ = "M3e.Datepicker", enums = [ ( "variant", [ "auto", "docked", "modal" ] ), ( "startView", [ "month", "multiYear", "year" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "contentPane", module_ = "M3e.ContentPane", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "suggestionChip", module_ = "M3e.SuggestionChip", enums = [ ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "inputChipSet", module_ = "M3e.InputChipSet", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "inputChip", module_ = "M3e.InputChip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "filterChipSet", module_ = "M3e.FilterChipSet", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "filterChip", module_ = "M3e.FilterChip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "chipSet", module_ = "M3e.ChipSet", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "assistChip", module_ = "M3e.AssistChip", enums = [ ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "chip", module_ = "M3e.Chip", enums = [ ( "variant", [ "elevated", "outlined" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "checkbox", module_ = "M3e.Checkbox", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "card", module_ = "M3e.Card", enums = [ ( "orientation", [ "horizontal", "vertical" ] ), ( "variant", [ "elevated", "filled", "outlined" ] ), ( "type", [ "button", "reset", "submit" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "calendar", module_ = "M3e.Calendar", enums = [ ( "startView", [ "month", "multiYear", "year" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "yearView", module_ = "M3e.YearView", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "multiYearView", module_ = "M3e.MultiYearView", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "monthView", module_ = "M3e.MonthView", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "tooltip", module_ = "M3e.Tooltip", enums = [ ( "position", [ "above", "after", "before", "below" ] ), ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "richTooltip", module_ = "M3e.RichTooltip", enums = [ ( "position", [ "above", "aboveAfter", "aboveBefore", "after", "before", "below", "belowAfter", "belowBefore" ] ), ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "tooltipElementBase", module_ = "M3e.TooltipElementBase", enums = [ ( "touchGestures", [ "auto", "off", "on" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "richTooltipAction", module_ = "M3e.RichTooltipAction", enums = [], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "buttonGroup", module_ = "M3e.ButtonGroup", enums = [ ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "variant", [ "connected", "standard" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "iconButton", module_ = "M3e.IconButton", enums = [ ( "shape", [ "rounded", "square" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "filled", "outlined", "standard", "tonal" ] ), ( "width", [ "default", "narrow", "wide" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "button", module_ = "M3e.Button", enums = [ ( "shape", [ "rounded", "square" ] ), ( "size", [ "extraLarge", "extraSmall", "large", "medium", "small" ] ), ( "type", [ "button", "reset", "submit" ] ), ( "variant", [ "elevated", "filled", "outlined", "text", "tonal" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "breadcrumb", module_ = "M3e.Breadcrumb", enums = [], requiredSlots = [ "default" ], multiSlots = [ "default" ] }
    , { component = "breadcrumbItem", module_ = "M3e.BreadcrumbItem", enums = [ ( "current", [ "date", "location", "page", "step", "time", "true" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "breadcrumbItemButton", module_ = "M3e.BreadcrumbItemButton", enums = [ ( "current", [ "date", "location", "page", "step", "time", "true" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "bottomSheetTrigger", module_ = "M3e.BottomSheetTrigger", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "bottomSheet", module_ = "M3e.BottomSheet", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "bottomSheetAction", module_ = "M3e.BottomSheetAction", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "badge", module_ = "M3e.Badge", enums = [ ( "size", [ "large", "medium", "small" ] ), ( "position", [ "above", "aboveAfter", "aboveBefore", "after", "before", "below", "belowAfter", "belowBefore" ] ) ], requiredSlots = [], multiSlots = [] }
    , { component = "avatar", module_ = "M3e.Avatar", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "autocomplete", module_ = "M3e.Autocomplete", enums = [ ( "filter", [ "contains", "endsWith", "none", "startsWith" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "formField", module_ = "M3e.FormField", enums = [ ( "floatLabel", [ "always", "auto" ] ), ( "hideSubscript", [ "always", "auto", "never" ] ), ( "variant", [ "filled", "outlined" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "optionPanel", module_ = "M3e.OptionPanel", enums = [ ( "state", [ "content", "loading", "noData" ] ), ( "scrollStrategy", [ "hide", "reposition" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "floatingPanel", module_ = "M3e.FloatingPanel", enums = [ ( "scrollStrategy", [ "hide", "reposition" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "optgroup", module_ = "M3e.Optgroup", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "option", module_ = "M3e.Option", enums = [ ( "highlightMode", [ "contains", "endsWith", "startsWith" ] ) ], requiredSlots = [ "default" ], multiSlots = [] }
    , { component = "focusTrap", module_ = "M3e.FocusTrap", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "appBar", module_ = "M3e.AppBar", enums = [ ( "size", [ "large", "medium", "small" ] ) ], requiredSlots = [], multiSlots = [ "trailing", "default" ] }
    , { component = "textOverflow", module_ = "M3e.TextOverflow", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "textHighlight", module_ = "M3e.TextHighlight", enums = [ ( "mode", [ "contains", "endsWith", "startsWith" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "stateLayer", module_ = "M3e.StateLayer", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "slide", module_ = "M3e.Slide", enums = [], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "scrollContainer", module_ = "M3e.ScrollContainer", enums = [ ( "dividers", [ "above", "aboveBelow", "below", "none" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "ripple", module_ = "M3e.Ripple", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "pseudoRadio", module_ = "M3e.PseudoRadio", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "pseudoCheckbox", module_ = "M3e.PseudoCheckbox", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "focusRing", module_ = "M3e.FocusRing", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "elevation", module_ = "M3e.Elevation", enums = [], requiredSlots = [], multiSlots = [] }
    , { component = "collapsible", module_ = "M3e.Collapsible", enums = [ ( "orientation", [ "horizontal", "vertical" ] ) ], requiredSlots = [], multiSlots = [ "default" ] }
    , { component = "actionElementBase", module_ = "M3e.ActionElementBase", enums = [], requiredSlots = [], multiSlots = [] }
    ]
