module M3e.SearchView exposing (child, children, clearIcon, closeIcon, closedLeading, closedTrailing, openLeading, openTrailing, searchIcon, searchView)

{-| 
@docs searchView, child, openLeading, openTrailing, closedLeading, closedTrailing, searchIcon, closeIcon, clearIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.SearchView
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-search-view>` element (lazy IR). -}
searchView :
    { input : M3e.Element.Element any msg }
    -> List (M3e.Cem.Attr.Attr { contained : M3e.Value.Supported
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , openLeading : M3e.Value.Supported
    , openTrailing : M3e.Value.Supported
    , closedLeading : M3e.Value.Supported
    , closedTrailing : M3e.Value.Supported
    , searchIcon : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    , clearIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | searchView : M3e.Value.Supported } msg
searchView req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SearchView.searchView
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


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `open-leading` slot. -}
openLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | openLeading : M3e.Value.Supported } msg
openLeading el =
    M3e.Content.slot "open-leading" el


{-| Place content in the `open-trailing` slot. -}
openTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | openTrailing : M3e.Value.Supported } msg
openTrailing el =
    M3e.Content.slot "open-trailing" el


{-| Place content in the `closed-leading` slot. -}
closedLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | closedLeading : M3e.Value.Supported } msg
closedLeading el =
    M3e.Content.slot "closed-leading" el


{-| Place content in the `closed-trailing` slot. -}
closedTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | closedTrailing : M3e.Value.Supported } msg
closedTrailing el =
    M3e.Content.slot "closed-trailing" el


{-| Place content in the `search-icon` slot. -}
searchIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | searchIcon : M3e.Value.Supported } msg
searchIcon el =
    M3e.Content.slot "search-icon" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.slot "close-icon" el


{-| Place content in the `clear-icon` slot. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | clearIcon : M3e.Value.Supported } msg
clearIcon el =
    M3e.Content.slot "clear-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els