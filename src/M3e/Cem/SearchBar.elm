module M3e.Cem.SearchBar exposing ( searchBar, clearable, clearLabel, onClear )

{-|
Middle layer for `<m3e-search-bar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SearchBar` module for everyday use.

@docs searchBar, clearable, clearLabel, onClear
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.SearchBar
import M3e.Value


{-| A bar that provides a prominent entry point for search.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `clear`: Dispatched when the search term is cleared.

**Slots:**
- `leading`: Renders content before the input of the bar.
- `input`: Renders the input of the bar.
- `trailing`: Renders content after the input of the bar.
-}
searchBar :
    List (M3e.Cem.Attr.Attr { clearable : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
searchBar attributes children =
    M3e.Cem.Html.SearchBar.searchBar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
clearable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SearchBar.clearable


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SearchBar.clearLabel


{-| Listen for `clear` events. -}
onClear : msg -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SearchBar.onClear
        (Json.Decode.succeed f_)