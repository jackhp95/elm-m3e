module M3e.Record exposing
    ( treeItem, tocItem, step, splitButton, snackbar, searchView
    , searchBar, navMenuItem, heading, fab, suggestionChip, inputChip, filterChip
    , assistChip, chip, tooltip, richTooltip, richTooltipAction, iconButton, button
    , option
    )

{-|
The M3e.Record barrel: shortcut re-exports of M3e.Record.<Comp>.view for the components that accept a required record. Each entry is a 3-arg constructor (`required record → [attributes] → [content] → Element`). Use `M3e.<Comp>.view` for the loose 2-arg shape. Combine with `M3e.disabled` (from `M3e`) or `M3e.Cem.<Comp>.disabled` for attribute setters.

@docs treeItem, tocItem, step, splitButton, snackbar, searchView
@docs searchBar, navMenuItem, heading, fab, suggestionChip, inputChip
@docs filterChip, assistChip, chip, tooltip, richTooltip, richTooltipAction
@docs iconButton, button, option
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Content
import M3e.Element
import M3e.Record.AssistChip
import M3e.Record.Button
import M3e.Record.Chip
import M3e.Record.Fab
import M3e.Record.FilterChip
import M3e.Record.Heading
import M3e.Record.IconButton
import M3e.Record.InputChip
import M3e.Record.NavMenuItem
import M3e.Record.Option
import M3e.Record.RichTooltip
import M3e.Record.RichTooltipAction
import M3e.Record.SearchBar
import M3e.Record.SearchView
import M3e.Record.Snackbar
import M3e.Record.SplitButton
import M3e.Record.Step
import M3e.Record.SuggestionChip
import M3e.Record.TocItem
import M3e.Record.Tooltip
import M3e.Record.TreeItem
import M3e.Value


{-| Convenience binding for the `M3e.Record.TreeItem` element: `view` re-exposed from `M3e.Record.TreeItem`. Import that module directly for the strict, component-scoped types. -}
treeItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , openToggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | treeItem : M3e.Value.Supported } msg
treeItem =
    M3e.Record.TreeItem.view


{-| Convenience binding for the `M3e.Record.TocItem` element: `view` re-exposed from `M3e.Record.TocItem`. Import that module directly for the strict, component-scoped types. -}
tocItem :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | tocItem : M3e.Value.Supported } msg
tocItem =
    M3e.Record.TocItem.view


{-| Convenience binding for the `M3e.Record.Step` element: `view` re-exposed from `M3e.Record.Step`. Import that module directly for the strict, component-scoped types. -}
step :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { completed : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , editable : M3e.Value.Supported
    , for : M3e.Value.Supported
    , optional : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , invalid : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , doneIcon : M3e.Value.Supported
    , editIcon : M3e.Value.Supported
    , errorIcon : M3e.Value.Supported
    , hint : M3e.Value.Supported
    , error : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | step : M3e.Value.Supported } msg
step =
    M3e.Record.Step.view


{-| Convenience binding for the `M3e.Record.SplitButton` element: `view` re-exposed from `M3e.Record.SplitButton`. Import that module directly for the strict, component-scoped types. -}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
splitButton =
    M3e.Record.SplitButton.view


{-| Convenience binding for the `M3e.Record.Snackbar` element: `view` re-exposed from `M3e.Record.Snackbar`. Import that module directly for the strict, component-scoped types. -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { action : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , duration : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { closeIcon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | snackbar : M3e.Value.Supported } msg
snackbar =
    M3e.Record.Snackbar.view


{-| Convenience binding for the `M3e.Record.SearchView` element: `view` re-exposed from `M3e.Record.SearchView`. Import that module directly for the strict, component-scoped types. -}
searchView :
    { input : M3e.Element.Element any msg }
    -> List (M3e.Cem.Attr.Attr { contained : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , open : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , hideSearchIcon : M3e.Value.Supported
    , onQuery : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , openLeading : M3e.Value.Supported
    , openTrailing : M3e.Value.Supported
    , closedLeading : M3e.Value.Supported
    , closedTrailing : M3e.Value.Supported
    , searchIcon : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchView : M3e.Value.Supported } msg
searchView =
    M3e.Record.SearchView.view


{-| Convenience binding for the `M3e.Record.SearchBar` element: `view` re-exposed from `M3e.Record.SearchBar`. Import that module directly for the strict, component-scoped types. -}
searchBar :
    { input : M3e.Element.Element any msg }
    -> List (M3e.Cem.Attr.Attr { clearable : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchBar : M3e.Value.Supported } msg
searchBar =
    M3e.Record.SearchBar.view


{-| Convenience binding for the `M3e.Record.NavMenuItem` element: `view` re-exposed from `M3e.Record.NavMenuItem`. Import that module directly for the strict, component-scoped types. -}
navMenuItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , badge : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Value.Supported } msg
navMenuItem =
    M3e.Record.NavMenuItem.view


{-| Convenience binding for the `M3e.Record.Heading` element: `view` re-exposed from `M3e.Record.Heading`. Import that module directly for the strict, component-scoped types. -}
heading :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { emphasized : M3e.Value.Supported
    , level : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | heading : M3e.Value.Supported } msg
heading =
    M3e.Record.Heading.view


{-| Convenience binding for the `M3e.Record.Fab` element: `view` re-exposed from `M3e.Record.Fab`. Import that module directly for the strict, component-scoped types. -}
fab :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , extended : M3e.Value.Supported
    , lowered : M3e.Value.Supported
    , name : M3e.Value.Supported
    , size : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { label : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | fab : M3e.Value.Supported } msg
fab =
    M3e.Record.Fab.view


{-| Convenience binding for the `M3e.Record.SuggestionChip` element: `view` re-exposed from `M3e.Record.SuggestionChip`. Import that module directly for the strict, component-scoped types. -}
suggestionChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | suggestionChip : M3e.Value.Supported } msg
suggestionChip =
    M3e.Record.SuggestionChip.view


{-| Convenience binding for the `M3e.Record.InputChip` element: `view` re-exposed from `M3e.Record.InputChip`. Import that module directly for the strict, component-scoped types. -}
inputChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , removable : M3e.Value.Supported
    , removeLabel : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onRemove : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { avatar : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , removeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Value.Supported } msg
inputChip =
    M3e.Record.InputChip.view


{-| Convenience binding for the `M3e.Record.FilterChip` element: `view` re-exposed from `M3e.Record.FilterChip`. Import that module directly for the strict, component-scoped types. -}
filterChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | filterChip : M3e.Value.Supported } msg
filterChip =
    M3e.Record.FilterChip.view


{-| Convenience binding for the `M3e.Record.AssistChip` element: `view` re-exposed from `M3e.Record.AssistChip`. Import that module directly for the strict, component-scoped types. -}
assistChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | assistChip : M3e.Value.Supported } msg
assistChip =
    M3e.Record.AssistChip.view


{-| Convenience binding for the `M3e.Record.Chip` element: `view` re-exposed from `M3e.Record.Chip`. Import that module directly for the strict, component-scoped types. -}
chip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | chip : M3e.Value.Supported } msg
chip =
    M3e.Record.Chip.view


{-| Convenience binding for the `M3e.Record.Tooltip` element: `view` re-exposed from `M3e.Record.Tooltip`. Import that module directly for the strict, component-scoped types. -}
tooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | tooltip : M3e.Value.Supported } msg
tooltip =
    M3e.Record.Tooltip.view


{-| Convenience binding for the `M3e.Record.RichTooltip` element: `view` re-exposed from `M3e.Record.RichTooltip`. Import that module directly for the strict, component-scoped types. -}
richTooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { subhead : M3e.Value.Supported
    , actions : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | richTooltip : M3e.Value.Supported } msg
richTooltip =
    M3e.Record.RichTooltip.view


{-| Convenience binding for the `M3e.Record.RichTooltipAction` element: `view` re-exposed from `M3e.Record.RichTooltipAction`. Import that module directly for the strict, component-scoped types. -}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disableRestoreFocus : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Value.Supported } msg
richTooltipAction =
    M3e.Record.RichTooltipAction.view


{-| Convenience binding for the `M3e.Record.IconButton` element: `view` re-exposed from `M3e.Record.IconButton`. Import that module directly for the strict, component-scoped types. -}
iconButton :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , width : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { selected : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | iconButton : M3e.Value.Supported } msg
iconButton =
    M3e.Record.IconButton.view


{-| Convenience binding for the `M3e.Record.Button` element: `view` re-exposed from `M3e.Record.Button`. Import that module directly for the strict, component-scoped types. -}
button :
    { content :
        M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | button : M3e.Value.Supported } msg
button =
    M3e.Record.Button.view


{-| Convenience binding for the `M3e.Record.Option` element: `view` re-exposed from `M3e.Record.Option`. Import that module directly for the strict, component-scoped types. -}
option :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHighlight : M3e.Value.Supported
    , highlightMode : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , term : M3e.Value.Supported
    , value : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | option : M3e.Value.Supported } msg
option =
    M3e.Record.Option.view