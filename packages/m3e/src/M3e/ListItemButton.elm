module M3e.ListItemButton exposing (child, children, leading, listItemButton, overline, supportingText, trailing)

{-| 
@docs listItemButton, child, leading, overline, supportingText, trailing, children
-}


import M3e.Cem.Attr
import M3e.Cem.ListItemButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-list-item-button>` element (lazy IR). -}
listItemButton :
    List (M3e.Cem.Attr.Attr { href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listItemButton : M3e.Value.Supported } msg
listItemButton attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ListItemButton.listItemButton
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
leading el =
    M3e.Content.slot "leading" el


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
overline el =
    M3e.Content.slot "overline" el


{-| Place content in the `supporting-text` slot. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
supportingText el =
    M3e.Content.slot "supporting-text" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , text : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
trailing el =
    M3e.Content.slot "trailing" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els