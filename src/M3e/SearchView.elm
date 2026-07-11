module M3e.SearchView exposing
    ( view, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, input
    , openLeading, openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon
    , clearIcon
    )

{-| A surface that presents suggestions and results for a search.

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
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, input
@docs openLeading, openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon
@docs clearIcon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.SearchView
import M3e.Node
import M3e.Token


{-| Build the `<m3e-search-view>` element (lazy IR).
-}
view :
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
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.SearchView.searchView
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> M3e.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
contained =
    M3e.Html.SearchView.contained


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , fullscreen : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.SearchView.mode


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.SearchView.open


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> M3e.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.SearchView.clearLabel


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`)
-}
closeLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.SearchView.closeLabel


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon : Bool -> M3e.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
hideSearchIcon =
    M3e.Html.SearchView.hideSearchIcon


{-| Listen for `query` events.
-}
onQuery : msg -> M3e.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    M3e.Html.SearchView.onQuery


{-| Listen for `clear` events.
-}
onClear : msg -> M3e.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.SearchView.onClear


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.SearchView.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.SearchView.onToggle


{-| Place content in the `input` slot.
-}
input : M3e.Element.Element any msg -> M3e.Element.Element k msg
input el =
    M3e.Element.Internal.placeSlot "input" el


{-| Place content in the `open-leading` slot.
-}
openLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
openLeading el =
    M3e.Element.Internal.placeSlot "open-leading" el


{-| Place content in the `open-trailing` slot.
-}
openTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
openTrailing el =
    M3e.Element.Internal.placeSlot "open-trailing" el


{-| Place content in the `closed-leading` slot.
-}
closedLeading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
closedLeading el =
    M3e.Element.Internal.placeSlot "closed-leading" el


{-| Place content in the `closed-trailing` slot.
-}
closedTrailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
closedTrailing el =
    M3e.Element.Internal.placeSlot "closed-trailing" el


{-| Place content in the `search-icon` slot.
-}
searchIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
searchIcon el =
    M3e.Element.Internal.placeSlot "search-icon" el


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
closeIcon el =
    M3e.Element.Internal.placeSlot "close-icon" el


{-| Place content in the `clear-icon` slot.
-}
clearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
clearIcon el =
    M3e.Element.Internal.placeSlot "clear-icon" el
