module M3e.Record exposing
    ( treeItem, tocItem, step, splitPane, splitButton, snackbar
    , searchView, searchBar, navMenuItem, heading, fab, expansionPanel
    , suggestionChip, inputChip, filterChip, assistChip, chip, tooltip
    , richTooltip, richTooltipAction, iconButton, button, option
    )

{-| The M3e.Record barrel: shortcut re-exports of M3e.Record.<Comp>.view for the components that accept a required record. Each entry is a 3-arg constructor (`required record → [attributes] → [content] → Element`). Use `M3e.<Comp>.view` for the standard 2-arg shape. Combine with `M3e.disabled` (from `M3e`) or `M3e.Html.<Comp>.disabled` for attribute setters.

@docs treeItem, tocItem, step, splitPane, splitButton, snackbar
@docs searchView, searchBar, navMenuItem, heading, fab, expansionPanel
@docs suggestionChip, inputChip, filterChip, assistChip, chip, tooltip
@docs richTooltip, richTooltipAction, iconButton, button, option

-}

import M3e.Action
import M3e.Element
import M3e.Html.Attr
import M3e.Record.AssistChip
import M3e.Record.Button
import M3e.Record.Chip
import M3e.Record.ExpansionPanel
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
import M3e.Record.SplitPane
import M3e.Record.Step
import M3e.Record.SuggestionChip
import M3e.Record.TocItem
import M3e.Record.Tooltip
import M3e.Record.TreeItem
import M3e.Token


{-| Convenience binding for the `M3e.Record.TreeItem` element: `view` re-exposed from `M3e.Record.TreeItem`. Import that module directly for the strict, component-scoped types.
-}
treeItem :
    { label :
        M3e.Element.Element
            { text : M3e.Token.Supported
            , link : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , indeterminate : M3e.Token.Supported
                , open : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , onOpening : M3e.Token.Supported
                , onOpened : M3e.Token.Supported
                , onClosing : M3e.Token.Supported
                , onClosed : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | treeItem : M3e.Token.Supported } msg
treeItem =
    M3e.Record.TreeItem.view


{-| Convenience binding for the `M3e.Record.TocItem` element: `view` re-exposed from `M3e.Record.TocItem`. Import that module directly for the strict, component-scoped types.
-}
tocItem :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | tocItem : M3e.Token.Supported } msg
tocItem =
    M3e.Record.TocItem.view


{-| Convenience binding for the `M3e.Record.Step` element: `view` re-exposed from `M3e.Record.Step`. Import that module directly for the strict, component-scoped types.
-}
step :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { completed : M3e.Token.Supported
                , disabled : M3e.Token.Supported
                , editable : M3e.Token.Supported
                , for : M3e.Token.Supported
                , optional : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , invalid : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | step : M3e.Token.Supported } msg
step =
    M3e.Record.Step.view


{-| Convenience binding for the `M3e.Record.SplitPane` element: `view` re-exposed from `M3e.Record.SplitPane`. Import that module directly for the strict, component-scoped types.
-}
splitPane :
    { start : M3e.Element.Element any msg, end : M3e.Element.Element any msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { detents : M3e.Token.Supported
                , label : M3e.Token.Supported
                , max : M3e.Token.Supported
                , min : M3e.Token.Supported
                , orientation : M3e.Token.Supported
                , overshootLimit : M3e.Token.Supported
                , step : M3e.Token.Supported
                , valueFloat : M3e.Token.Supported
                , wrapDetents : M3e.Token.Supported
                , name : M3e.Token.Supported
                , disabled : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitPane : M3e.Token.Supported } msg
splitPane =
    M3e.Record.SplitPane.view


{-| Convenience binding for the `M3e.Record.SplitButton` element: `view` re-exposed from `M3e.Record.SplitButton`. Import that module directly for the strict, component-scoped types.
-}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Token.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Token.Supported } msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { variant : M3e.Token.Supported
                , size : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitButton : M3e.Token.Supported } msg
splitButton =
    M3e.Record.SplitButton.view


{-| Convenience binding for the `M3e.Record.Snackbar` element: `view` re-exposed from `M3e.Record.Snackbar`. Import that module directly for the strict, component-scoped types.
-}
snackbar :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { action : M3e.Token.Supported
                , closeLabel : M3e.Token.Supported
                , dismissible : M3e.Token.Supported
                , duration : M3e.Token.Supported
                , onBeforetoggle : M3e.Token.Supported
                , onToggle : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | snackbar : M3e.Token.Supported } msg
snackbar =
    M3e.Record.Snackbar.view


{-| Convenience binding for the `M3e.Record.SearchView` element: `view` re-exposed from `M3e.Record.SearchView`. Import that module directly for the strict, component-scoped types.
-}
searchView :
    { input : M3e.Element.Element any msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { contained : M3e.Token.Supported
                , mode : M3e.Token.Supported
                , open : M3e.Token.Supported
                , clearLabel : M3e.Token.Supported
                , closeLabel : M3e.Token.Supported
                , hideSearchIcon : M3e.Token.Supported
                , onQuery : M3e.Token.Supported
                , onClear : M3e.Token.Supported
                , onBeforetoggle : M3e.Token.Supported
                , onToggle : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchView : M3e.Token.Supported } msg
searchView =
    M3e.Record.SearchView.view


{-| Convenience binding for the `M3e.Record.SearchBar` element: `view` re-exposed from `M3e.Record.SearchBar`. Import that module directly for the strict, component-scoped types.
-}
searchBar :
    { input : M3e.Element.Element any msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { clearable : M3e.Token.Supported
                , clearLabel : M3e.Token.Supported
                , onClear : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchBar : M3e.Token.Supported } msg
searchBar =
    M3e.Record.SearchBar.view


{-| Convenience binding for the `M3e.Record.NavMenuItem` element: `view` re-exposed from `M3e.Record.NavMenuItem`. Import that module directly for the strict, component-scoped types.
-}
navMenuItem :
    { label :
        M3e.Element.Element
            { text : M3e.Token.Supported
            , link : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , open : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , onOpening : M3e.Token.Supported
                , onOpened : M3e.Token.Supported
                , onClosing : M3e.Token.Supported
                , onClosed : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Token.Supported } msg
navMenuItem =
    M3e.Record.NavMenuItem.view


{-| Convenience binding for the `M3e.Record.Heading` element: `view` re-exposed from `M3e.Record.Heading`. Import that module directly for the strict, component-scoped types.
-}
heading :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { emphasized : M3e.Token.Supported
                , level : M3e.Token.Supported
                , size : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , tocIgnore : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | heading : M3e.Token.Supported } msg
heading =
    M3e.Record.Heading.view


{-| Convenience binding for the `M3e.Record.Fab` element: `view` re-exposed from `M3e.Record.Fab`. Import that module directly for the strict, component-scoped types.
-}
fab :
    { content : M3e.Element.Element { icon : M3e.Token.Supported } msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , extended : M3e.Token.Supported
                , lowered : M3e.Token.Supported
                , name : M3e.Token.Supported
                , size : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | fab : M3e.Token.Supported } msg
fab =
    M3e.Record.Fab.view


{-| Convenience binding for the `M3e.Record.ExpansionPanel` element: `view` re-exposed from `M3e.Record.ExpansionPanel`. Import that module directly for the strict, component-scoped types.
-}
expansionPanel :
    { header : M3e.Element.Element any msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , hideToggle : M3e.Token.Supported
                , open : M3e.Token.Supported
                , toggleDirection : M3e.Token.Supported
                , togglePosition : M3e.Token.Supported
                , onOpening : M3e.Token.Supported
                , onOpened : M3e.Token.Supported
                , onClosing : M3e.Token.Supported
                , onClosed : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | expansionPanel : M3e.Token.Supported } msg
expansionPanel =
    M3e.Record.ExpansionPanel.view


{-| Convenience binding for the `M3e.Record.SuggestionChip` element: `view` re-exposed from `M3e.Record.SuggestionChip`. Import that module directly for the strict, component-scoped types.
-}
suggestionChip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , name : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | suggestionChip : M3e.Token.Supported } msg
suggestionChip =
    M3e.Record.SuggestionChip.view


{-| Convenience binding for the `M3e.Record.InputChip` element: `view` re-exposed from `M3e.Record.InputChip`. Import that module directly for the strict, component-scoped types.
-}
inputChip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , removable : M3e.Token.Supported
                , removeLabel : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , onRemove : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | inputChip : M3e.Token.Supported } msg
inputChip =
    M3e.Record.InputChip.view


{-| Convenience binding for the `M3e.Record.FilterChip` element: `view` re-exposed from `M3e.Record.FilterChip`. Import that module directly for the strict, component-scoped types.
-}
filterChip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | filterChip : M3e.Token.Supported } msg
filterChip =
    M3e.Record.FilterChip.view


{-| Convenience binding for the `M3e.Record.AssistChip` element: `view` re-exposed from `M3e.Record.AssistChip`. Import that module directly for the strict, component-scoped types.
-}
assistChip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , download : M3e.Token.Supported
                , href : M3e.Token.Supported
                , name : M3e.Token.Supported
                , rel : M3e.Token.Supported
                , target : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | assistChip : M3e.Token.Supported } msg
assistChip =
    M3e.Record.AssistChip.view


{-| Convenience binding for the `M3e.Record.Chip` element: `view` re-exposed from `M3e.Record.Chip`. Import that module directly for the strict, component-scoped types.
-}
chip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | chip : M3e.Token.Supported } msg
chip =
    M3e.Record.Chip.view


{-| Convenience binding for the `M3e.Record.Tooltip` element: `view` re-exposed from `M3e.Record.Tooltip`. Import that module directly for the strict, component-scoped types.
-}
tooltip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , for : M3e.Token.Supported
                , hideDelay : M3e.Token.Supported
                , position : M3e.Token.Supported
                , showDelay : M3e.Token.Supported
                , touchGestures : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | tooltip : M3e.Token.Supported } msg
tooltip =
    M3e.Record.Tooltip.view


{-| Convenience binding for the `M3e.Record.RichTooltip` element: `view` re-exposed from `M3e.Record.RichTooltip`. Import that module directly for the strict, component-scoped types.
-}
richTooltip :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , for : M3e.Token.Supported
                , hideDelay : M3e.Token.Supported
                , position : M3e.Token.Supported
                , showDelay : M3e.Token.Supported
                , touchGestures : M3e.Token.Supported
                , onBeforetoggle : M3e.Token.Supported
                , onToggle : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | richTooltip : M3e.Token.Supported } msg
richTooltip =
    M3e.Record.RichTooltip.view


{-| Convenience binding for the `M3e.Record.RichTooltipAction` element: `view` re-exposed from `M3e.Record.RichTooltipAction`. Import that module directly for the strict, component-scoped types.
-}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disableRestoreFocus : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Token.Supported } msg
richTooltipAction =
    M3e.Record.RichTooltipAction.view


{-| Convenience binding for the `M3e.Record.IconButton` element: `view` re-exposed from `M3e.Record.IconButton`. Import that module directly for the strict, component-scoped types.
-}
iconButton :
    { content :
        M3e.Element.Element
            { icon : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            , stepperNext : M3e.Token.Supported
            }
            msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            , stepperNext : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , name : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , shape : M3e.Token.Supported
                , size : M3e.Token.Supported
                , toggle : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , width : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | iconButton : M3e.Token.Supported } msg
iconButton =
    M3e.Record.IconButton.view


{-| Convenience binding for the `M3e.Record.Button` element: `view` re-exposed from `M3e.Record.Button`. Import that module directly for the strict, component-scoped types.
-}
button :
    { content :
        M3e.Element.Element
            { text : M3e.Token.Supported
            , icon : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            , stepperNext : M3e.Token.Supported
            }
            msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            , stepperNext : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , name : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , shape : M3e.Token.Supported
                , size : M3e.Token.Supported
                , toggle : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | button : M3e.Token.Supported } msg
button =
    M3e.Record.Button.view


{-| Convenience binding for the `M3e.Record.Option` element: `view` re-exposed from `M3e.Record.Option`. Import that module directly for the strict, component-scoped types.
-}
option :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disableHighlight : M3e.Token.Supported
                , highlightMode : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , term : M3e.Token.Supported
                , value : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | option : M3e.Token.Supported } msg
option =
    M3e.Record.Option.view
