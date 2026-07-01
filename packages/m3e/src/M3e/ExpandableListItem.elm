module M3e.ExpandableListItem exposing (child, children, expandableListItem, items, leading, overline, supportingText, toggleIcon)

{-| 
@docs expandableListItem, child, leading, overline, supportingText, toggleIcon, items, children
-}


import M3e.Cem.Attr
import M3e.Cem.ExpandableListItem
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-expandable-list-item>` element (lazy IR). -}
expandableListItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , items : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | expandableListItem : M3e.Value.Supported } msg
expandableListItem attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ExpandableListItem.expandableListItem
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


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
toggleIcon el =
    M3e.Content.slot "toggle-icon" el


{-| Place content in the `items` slot. -}
items :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | items : M3e.Value.Supported } msg
items el =
    M3e.Content.slot "items" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els