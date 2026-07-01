module M3e.SearchBar exposing (clearIcon, clearLabel, clearable, leading, onClear, searchBar, trailing)

{-| 
@docs searchBar, clearable, clearLabel, onClear, leading, trailing, clearIcon
-}


import M3e.Cem.Attr
import M3e.Cem.SearchBar
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-search-bar>` element (lazy IR). -}
searchBar :
    { input : M3e.Element.Element any msg }
    -> List (M3e.Cem.Attr.Attr { clearable : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , onClear : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchBar : M3e.Value.Supported } msg
searchBar req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SearchBar.searchBar
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.append
                []
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode (M3e.Element.withSlot "input" req_.input) ]
                (List.map M3e.Content.toNode content_)
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
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
leading el =
    M3e.Content.slot "leading" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
trailing el =
    M3e.Content.slot "trailing" el


{-| Place content in the `clear-icon` slot. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | clearIcon : M3e.Value.Supported } msg
clearIcon el =
    M3e.Content.slot "clear-icon" el