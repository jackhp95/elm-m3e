module M3e.OptionPanel exposing (child, children, loading, noData, optionPanel)

{-| 
@docs optionPanel, child, noData, loading, children
-}


import M3e.Cem.Attr
import M3e.Cem.OptionPanel
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-option-panel>` element (lazy IR). -}
optionPanel :
    List (M3e.Cem.Attr.Attr { state : M3e.Value.Supported
    , scrollStrategy : M3e.Value.Supported
    , fitAnchorWidth : M3e.Value.Supported
    , anchorOffset : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , noData : M3e.Value.Supported
    , loading : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | optionPanel : M3e.Value.Supported } msg
optionPanel attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.OptionPanel.optionPanel
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `no-data` slot. -}
noData :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
noData el =
    M3e.Content.slot "no-data" el


{-| Place content in the `loading` slot. -}
loading :
    M3e.Element.Element { circularProgressIndicator : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    , text : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
loading el =
    M3e.Content.slot "loading" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els