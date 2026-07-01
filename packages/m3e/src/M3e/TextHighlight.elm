module M3e.TextHighlight exposing (child, children, textHighlight)

{-| 
@docs textHighlight, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.TextHighlight
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-text-highlight>` element (lazy IR). -}
textHighlight :
    List (M3e.Cem.Attr.Attr { caseSensitive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , term : M3e.Value.Supported
    , onHighlight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | textHighlight : M3e.Value.Supported } msg
textHighlight attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.TextHighlight.textHighlight
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
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