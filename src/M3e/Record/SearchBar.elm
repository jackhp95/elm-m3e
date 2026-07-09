module M3e.Record.SearchBar exposing
    ( view, clearable, clearLabel, onClear, leading, trailing
    , clearIcon
    )

{-|
A bar that provides a prominent entry point for search.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `clear`: Dispatched when the search term is cleared.

**Slots:**
- `leading`: Renders content before the input of the bar.
- `input`: Renders the input of the bar.
- `trailing`: Renders content after the input of the bar.

@docs view, clearable, clearLabel, onClear, leading, trailing
@docs clearIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SearchBar
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-search-bar>` element (lazy IR). -}
view :
    { input : M3e.Element.Element any msg }
    -> List (M3e.Cem.Attr.Attr { clearable : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | searchBar : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SearchBar.searchBar
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


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
clearable =
    M3e.Cem.SearchBar.clearable


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.SearchBar.clearLabel


{-| Listen for `clear` events. -}
onClear : msg -> M3e.Cem.Attr.Attr { c | onClear : M3e.Value.Supported } msg
onClear =
    M3e.Cem.SearchBar.onClear


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
leading el =
    M3e.Element.Internal.placeSlot "leading" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
trailing el =
    M3e.Element.Internal.placeSlot "trailing" el


{-| Place content in the `clear-icon` slot. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
clearIcon el =
    M3e.Element.Internal.placeSlot "clear-icon" el