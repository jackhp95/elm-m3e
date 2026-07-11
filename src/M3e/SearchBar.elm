module M3e.SearchBar exposing
    ( view, clearable, clearLabel, onClear, leading, input
    , trailing, clearIcon
    )

{-| A bar that provides a prominent entry point for search.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `clear`: Dispatched when the search term is cleared.

**Slots:**

  - `leading`: Renders content before the input of the bar.
  - `input`: Renders the input of the bar.
  - `trailing`: Renders content after the input of the bar.

@docs view, clearable, clearLabel, onClear, leading, input
@docs trailing, clearIcon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.SearchBar
import M3e.Node
import M3e.Token


{-| Build the `<m3e-search-bar>` element (lazy IR).
-}
view :
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
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.SearchBar.searchBar
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> M3e.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    M3e.Html.SearchBar.clearable


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> M3e.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.SearchBar.clearLabel


{-| Listen for `clear` events.
-}
onClear : msg -> M3e.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.SearchBar.onClear


{-| Place content in the `leading` slot.
-}
leading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
leading el =
    M3e.Element.Internal.placeSlot "leading" el


{-| Place content in the `input` slot.
-}
input : M3e.Element.Element any msg -> M3e.Element.Element k msg
input el =
    M3e.Element.Internal.placeSlot "input" el


{-| Place content in the `trailing` slot.
-}
trailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , iconButton : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
trailing el =
    M3e.Element.Internal.placeSlot "trailing" el


{-| Place content in the `clear-icon` slot.
-}
clearIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
clearIcon el =
    M3e.Element.Internal.placeSlot "clear-icon" el
