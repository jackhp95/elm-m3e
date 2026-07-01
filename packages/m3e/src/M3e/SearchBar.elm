module M3e.SearchBar exposing (clearIcon, leading, searchBar, trailing)

{-| 
@docs searchBar, leading, trailing, clearIcon
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