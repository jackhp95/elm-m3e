module M3e.Html.SearchBar exposing (searchBar, clearable, clearLabel, onClear)

{-| Middle layer for `<m3e-search-bar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SearchBar` module for everyday use.

@docs searchBar, clearable, clearLabel, onClear

-}

import Html
import Json.Decode
import M3e.Raw.SearchBar
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { clearable : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , onClear : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
searchBar attributes children =
    M3e.Raw.SearchBar.searchBar
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> Markup.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchBar.clearable


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchBar.clearLabel


{-| Listen for `clear` events.
-}
onClear : msg -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchBar.onClear
        (Json.Decode.succeed f_)
