module M3e.Theme exposing (child, children, theme)

{-| 
@docs theme, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Theme
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-theme>` element (lazy IR). -}
theme :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , contrast : M3e.Value.Supported
    , density : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , strongFocus : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , motion : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | theme : M3e.Value.Supported } msg
theme attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Theme.theme (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


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