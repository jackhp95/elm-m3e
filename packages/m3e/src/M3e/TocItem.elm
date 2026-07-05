module M3e.TocItem exposing
    ( view, disabled, selected, onClick, child, children
    )

{-|
An item in a table of contents.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: Dispatched when the element is clicked.

@docs view, disabled, selected, onClick, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.TocItem
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-toc-item>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tocItem : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TocItem.tocItem
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.TocItem.disabled


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.TocItem.selected


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.TocItem.onClick


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els