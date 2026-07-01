module M3e.Toolbar exposing (child, children, elevated, shape, toolbar, variant, vertical)

{-| 
@docs toolbar, elevated, shape, variant, vertical, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Toolbar
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-toolbar>` element (lazy IR). -}
toolbar :
    List (M3e.Cem.Attr.Attr { elevated : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | toolbar : M3e.Value.Supported } msg
toolbar attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Toolbar.toolbar (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
elevated =
    M3e.Cem.Toolbar.elevated


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.Toolbar.shape


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Toolbar.variant


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Toolbar.vertical


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els