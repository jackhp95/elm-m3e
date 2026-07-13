module M3e.Html.SearchView exposing
    ( searchView, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle
    )

{-| Middle layer for `<m3e-search-view>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SearchView` module for everyday use.

@docs searchView, contained, mode, open, clearLabel, closeLabel
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle

-}

import Html
import Json.Decode
import M3e.Raw.SearchView
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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

-}
searchView :
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
    -> List (Html.Html msg)
    -> Html.Html msg
searchView attributes children =
    M3e.Raw.SearchView.searchView
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Markup.Html.Attr.Attr { c | contained : M3e.Token.Supported } msg
contained =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchView.contained


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , fullscreen : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchView.mode
        (M3e.Token.toString v_)


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchView.open


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchView.clearLabel


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`)
-}
closeLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchView.closeLabel


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon :
    Bool
    -> Markup.Html.Attr.Attr { c | hideSearchIcon : M3e.Token.Supported } msg
hideSearchIcon =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SearchView.hideSearchIcon


{-| Listen for `query` events.
-}
onQuery : msg -> Markup.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchView.onQuery
        (Json.Decode.succeed f_)


{-| Listen for `clear` events.
-}
onClear : msg -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchView.onClear
        (Json.Decode.succeed f_)


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchView.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SearchView.onToggle
        (Json.Decode.succeed f_)
