module M3e.ScrollContainer exposing
    ( view, dividers, thin, child, children
    )

{-|
A vertically oriented content container which presents dividers above and below content when scrolled.

@docs view, dividers, thin, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.ScrollContainer
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-scroll-container>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { dividers : M3e.Value.Supported
    , thin : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | scrollContainer : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ScrollContainer.scrollContainer
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividers =
    M3e.Cem.ScrollContainer.dividers


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> M3e.Cem.Attr.Attr { c | thin : M3e.Value.Supported } msg
thin =
    M3e.Cem.ScrollContainer.thin


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