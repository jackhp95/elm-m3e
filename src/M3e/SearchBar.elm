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

import M3e.Html.SearchBar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-search-bar>` element (lazy IR).
-}
view :
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
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SearchBar.searchBar
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> Markup.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    M3e.Html.SearchBar.clearable


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.SearchBar.clearLabel


{-| Listen for `clear` events.
-}
onClear : msg -> Markup.Html.Attr.Attr { c | onClear : M3e.Token.Supported } msg
onClear =
    M3e.Html.SearchBar.onClear


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
leading el =
    Markup.Element.Internal.placeSlot "leading" el


{-| Place content in the `input` slot.
-}
input : Markup.Element.Element any msg -> Markup.Element.Element k msg
input el =
    Markup.Element.Internal.placeSlot "input" el


{-| Place content in the `trailing` slot.
-}
trailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , iconButton : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
trailing el =
    Markup.Element.Internal.placeSlot "trailing" el


{-| Place content in the `clear-icon` slot.
-}
clearIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
clearIcon el =
    Markup.Element.Internal.placeSlot "clear-icon" el
