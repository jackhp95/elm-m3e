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
import M3e.Kind
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
import Markup.Element
import Markup.Html.Attr
import Markup.Kind


{-| See `M3e.Record.TreeItem`.
-}
treeItem :
    { label :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedLink : Markup.Kind.Shared
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | treeItem : M3e.Kind.Brand } msg
treeItem =
    M3e.Record.TreeItem.view


{-| See `M3e.Record.TocItem`.
-}
tocItem :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | tocItem : M3e.Kind.Brand } msg
tocItem =
    M3e.Record.TocItem.view


{-| See `M3e.Record.Step`.
-}
step :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | step : M3e.Kind.Brand } msg
step =
    M3e.Record.Step.view


{-| See `M3e.Record.SplitPane`.
-}
splitPane :
    { start : Markup.Element.Element any msg
    , end : Markup.Element.Element any msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | splitPane : M3e.Kind.Brand } msg
splitPane =
    M3e.Record.SplitPane.view


{-| See `M3e.Record.SplitButton`.
-}
splitButton :
    { leadingButton : Markup.Element.Element { button : M3e.Kind.Brand } msg
    , trailingButton :
        Markup.Element.Element { iconButton : M3e.Kind.Brand } msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
                { variant : M3e.Token.Supported
                , size : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | splitButton : M3e.Kind.Brand } msg
splitButton =
    M3e.Record.SplitButton.view


{-| See `M3e.Record.Snackbar`.
-}
snackbar :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | snackbar : M3e.Kind.Brand } msg
snackbar =
    M3e.Record.Snackbar.view


{-| See `M3e.Record.SearchView`.
-}
searchView :
    { input : Markup.Element.Element any msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | searchView : M3e.Kind.Brand } msg
searchView =
    M3e.Record.SearchView.view


{-| See `M3e.Record.SearchBar`.
-}
searchBar :
    { input : Markup.Element.Element any msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { clearable : M3e.Token.Supported
                , clearLabel : M3e.Token.Supported
                , onClear : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | searchBar : M3e.Kind.Brand } msg
searchBar =
    M3e.Record.SearchBar.view


{-| See `M3e.Record.NavMenuItem`.
-}
navMenuItem :
    { label :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedLink : Markup.Kind.Shared
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | navMenuItem : M3e.Kind.Brand } msg
navMenuItem =
    M3e.Record.NavMenuItem.view


{-| See `M3e.Record.Heading`.
-}
heading :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { emphasized : M3e.Token.Supported
                , level : M3e.Token.Supported
                , size : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , tocIgnore : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | heading : M3e.Kind.Brand } msg
heading =
    M3e.Record.Heading.view


{-| See `M3e.Record.Fab`.
-}
fab :
    { content : Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
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
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | fab : M3e.Kind.Brand } msg
fab =
    M3e.Record.Fab.view


{-| See `M3e.Record.ExpansionPanel`.
-}
expansionPanel :
    { header : Markup.Element.Element any msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | expansionPanel : M3e.Kind.Brand } msg
expansionPanel =
    M3e.Record.ExpansionPanel.view


{-| See `M3e.Record.SuggestionChip`.
-}
suggestionChip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
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
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | suggestionChip : M3e.Kind.Brand } msg
suggestionChip =
    M3e.Record.SuggestionChip.view


{-| See `M3e.Record.InputChip`.
-}
inputChip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | inputChip : M3e.Kind.Brand } msg
inputChip =
    M3e.Record.InputChip.view


{-| See `M3e.Record.FilterChip`.
-}
filterChip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | filterChip : M3e.Kind.Brand } msg
filterChip =
    M3e.Record.FilterChip.view


{-| See `M3e.Record.AssistChip`.
-}
assistChip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | assistChip : M3e.Kind.Brand } msg
assistChip =
    M3e.Record.AssistChip.view


{-| See `M3e.Record.Chip`.
-}
chip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | chip : M3e.Kind.Brand } msg
chip =
    M3e.Record.Chip.view


{-| See `M3e.Record.Tooltip`.
-}
tooltip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | tooltip : M3e.Kind.Brand } msg
tooltip =
    M3e.Record.Tooltip.view


{-| See `M3e.Record.RichTooltip`.
-}
richTooltip :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | richTooltip : M3e.Kind.Brand } msg
richTooltip =
    M3e.Record.RichTooltip.view


{-| See `M3e.Record.RichTooltipAction`.
-}
richTooltipAction :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { disableRestoreFocus : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | richTooltipAction : M3e.Kind.Brand } msg
richTooltipAction =
    M3e.Record.RichTooltipAction.view


{-| See `M3e.Record.IconButton`.
-}
iconButton :
    { content :
        Markup.Element.Element
            { sharedIcon : Markup.Kind.Shared
            , menuTrigger : M3e.Kind.Brand
            , dialogTrigger : M3e.Kind.Brand
            , fabMenuTrigger : M3e.Kind.Brand
            , bottomSheetTrigger : M3e.Kind.Brand
            , navRailToggle : M3e.Kind.Brand
            , drawerToggle : M3e.Kind.Brand
            , datepickerToggle : M3e.Kind.Brand
            , dialogAction : M3e.Kind.Brand
            , bottomSheetAction : M3e.Kind.Brand
            , richTooltipAction : M3e.Kind.Brand
            , stepperReset : M3e.Kind.Brand
            , stepperPrevious : M3e.Kind.Brand
            , stepperNext : M3e.Kind.Brand
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
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | iconButton : M3e.Kind.Brand } msg
iconButton =
    M3e.Record.IconButton.view


{-| See `M3e.Record.Button`.
-}
button :
    { content :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedIcon : Markup.Kind.Shared
            , menuTrigger : M3e.Kind.Brand
            , dialogTrigger : M3e.Kind.Brand
            , fabMenuTrigger : M3e.Kind.Brand
            , bottomSheetTrigger : M3e.Kind.Brand
            , navRailToggle : M3e.Kind.Brand
            , drawerToggle : M3e.Kind.Brand
            , datepickerToggle : M3e.Kind.Brand
            , dialogAction : M3e.Kind.Brand
            , bottomSheetAction : M3e.Kind.Brand
            , richTooltipAction : M3e.Kind.Brand
            , stepperReset : M3e.Kind.Brand
            , stepperPrevious : M3e.Kind.Brand
            , stepperNext : M3e.Kind.Brand
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
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | button : M3e.Kind.Brand } msg
button =
    M3e.Record.Button.view


{-| See `M3e.Record.Option`.
-}
option :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | option : M3e.Kind.Brand } msg
option =
    M3e.Record.Option.view
