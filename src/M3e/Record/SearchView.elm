module M3e.Record.SearchView exposing
    ( view, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, openLeading, openTrailing
    , closedLeading, closedTrailing, searchIcon, closeIcon, clearIcon
    )

{-|
A surface that presents suggestions and results for a search.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `query`: Dispatched when the view is opened or when the user modifies the search term.
- `clear`: Dispatched when the search term is cleared.
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `input`: Renders the input of the view.
- `open-leading`: When open, renders content before the input of the view.
- `open-trailing`: When open, renders content after the input of the view.
- `closed-leading`: When closed, renders content before the input of the view.
- `closed-trailing`: When closed, renders content after the input of the view.

@docs view, contained, mode, open, clearLabel, closeLabel
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, openLeading
@docs openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon, clearIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SearchView
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-search-view>` element (lazy IR). -}
view :
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchView : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SearchView.searchView
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.append
                  [ M3e.Element.toNode (M3e.Element.withSlot "input" req_.input)
                  ]
                  (List.map M3e.Element.toNode content_)
             )
        )


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool -> M3e.Cem.Attr.Attr { c | contained : M3e.Value.Supported } msg
contained =
    M3e.Cem.SearchView.contained


{-| The behavior mode of the view. (default: `"docked"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , fullscreen : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.SearchView.mode


{-| Whether the view is expanded to show results. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.SearchView.open


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.SearchView.clearLabel


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.SearchView.closeLabel


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool -> M3e.Cem.Attr.Attr { c | hideSearchIcon : M3e.Value.Supported } msg
hideSearchIcon =
    M3e.Cem.SearchView.hideSearchIcon


{-| Listen for `query` events. -}
onQuery : msg -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery =
    M3e.Cem.SearchView.onQuery


{-| Listen for `clear` events. -}
onClear : msg -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear =
    M3e.Cem.SearchView.onClear


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.SearchView.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.SearchView.onToggle


{-| Place content in the `open-leading` slot. -}
openLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
openLeading el =
    M3e.Element.Internal.placeSlot "open-leading" el


{-| Place content in the `open-trailing` slot. -}
openTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
openTrailing el =
    M3e.Element.Internal.placeSlot "open-trailing" el


{-| Place content in the `closed-leading` slot. -}
closedLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
closedLeading el =
    M3e.Element.Internal.placeSlot "closed-leading" el


{-| Place content in the `closed-trailing` slot. -}
closedTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
closedTrailing el =
    M3e.Element.Internal.placeSlot "closed-trailing" el


{-| Place content in the `search-icon` slot. -}
searchIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
searchIcon el =
    M3e.Element.Internal.placeSlot "search-icon" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
closeIcon el =
    M3e.Element.Internal.placeSlot "close-icon" el


{-| Place content in the `clear-icon` slot. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
clearIcon el =
    M3e.Element.Internal.placeSlot "clear-icon" el