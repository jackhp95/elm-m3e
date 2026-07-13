module M3e.Record.SearchView exposing
    ( view, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, openLeading
    , openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon, clearIcon
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
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, openLeading
@docs openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon, clearIcon

-}

import M3e.Html.SearchView
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-search-view>` element (lazy IR).
-}
view :
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
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SearchView.searchView
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode
                    (Markup.Element.withSlot "input" req_.input)
                ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Markup.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
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
    -> Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.SearchView.mode


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.SearchView.open


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.SearchView.clearLabel


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`)
-}
closeLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.SearchView.closeLabel


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon :
    Bool
    -> Markup.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
hideSearchIcon =
    M3e.Html.SearchView.hideSearchIcon


{-| Listen for `query` events.
-}
onQuery : msg -> Markup.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery =
    M3e.Html.SearchView.onQuery


{-| Listen for `clear` events.
-}
onClear : msg -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.SearchView.onClear


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.SearchView.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.SearchView.onToggle


{-| Place content in the `open-leading` slot.
-}
openLeading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
openLeading el =
    Markup.Element.Internal.placeSlot "open-leading" el


{-| Place content in the `open-trailing` slot.
-}
openTrailing :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
openTrailing el =
    Markup.Element.Internal.placeSlot "open-trailing" el


{-| Place content in the `closed-leading` slot.
-}
closedLeading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
closedLeading el =
    Markup.Element.Internal.placeSlot "closed-leading" el


{-| Place content in the `closed-trailing` slot.
-}
closedTrailing :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
closedTrailing el =
    Markup.Element.Internal.placeSlot "closed-trailing" el


{-| Place content in the `search-icon` slot.
-}
searchIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
searchIcon el =
    Markup.Element.Internal.placeSlot "search-icon" el


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
closeIcon el =
    Markup.Element.Internal.placeSlot "close-icon" el


{-| Place content in the `clear-icon` slot.
-}
clearIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
clearIcon el =
    Markup.Element.Internal.placeSlot "clear-icon" el
