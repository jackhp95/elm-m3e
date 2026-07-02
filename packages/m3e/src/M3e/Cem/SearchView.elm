module M3e.Cem.SearchView exposing
    ( searchView, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle
    )

{-|
Middle layer for `<m3e-search-view>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SearchView` module for everyday use.

@docs searchView, contained, mode, open, clearLabel, closeLabel
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.SearchView
import M3e.Value


{-| A surface that presents suggestions and results for a search.

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
-}
searchView :
    List (M3e.Cem.Attr.Attr { contained : M3e.Value.Supported
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
    -> List (Html.Html msg)
    -> Html.Html msg
searchView attributes children =
    M3e.Cem.Html.SearchView.searchView
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool -> M3e.Cem.Attr.Attr { c | contained : M3e.Value.Supported } msg
contained =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.contained


{-| The behavior mode of the view. (default: `"docked"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , fullscreen : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.mode (M3e.Value.toString v_)


{-| Whether the view is expanded to show results. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.open


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.clearLabel


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.closeLabel


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool -> M3e.Cem.Attr.Attr { c | hideSearchIcon : M3e.Value.Supported } msg
hideSearchIcon =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SearchView.hideSearchIcon


{-| Listen for `query` events. -}
onQuery : msg -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SearchView.onQuery
        (Json.Decode.succeed f_)


{-| Listen for `clear` events. -}
onClear : msg -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SearchView.onClear
        (Json.Decode.succeed f_)


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SearchView.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SearchView.onToggle
        (Json.Decode.succeed f_)