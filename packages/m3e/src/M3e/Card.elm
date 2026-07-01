module M3e.Card exposing (actions, card, child, children, content, footer, header)

{-| 
@docs card, child, header, content, actions, footer, children
-}


import M3e.Cem.Attr
import M3e.Cem.Card
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-card>` element (lazy IR). -}
card :
    List (M3e.Cem.Attr.Attr { actionable : M3e.Value.Supported
    , inline : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    , content : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , footer : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | card : M3e.Value.Supported } msg
card attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Card.card (List.map M3e.Cem.Attr.forget erased) ch
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


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
header el =
    M3e.Content.slot "header" el


{-| Place content in the `content` slot. -}
content :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | content : M3e.Value.Supported } msg
content el =
    M3e.Content.slot "content" el


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
actions el =
    M3e.Content.slot "actions" el


{-| Place content in the `footer` slot. -}
footer :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | footer : M3e.Value.Supported } msg
footer el =
    M3e.Content.slot "footer" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els