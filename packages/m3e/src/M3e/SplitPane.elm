module M3e.SplitPane exposing (end, splitPane, start)

{-| 
@docs splitPane, start, end
-}


import M3e.Cem.Attr
import M3e.Cem.SplitPane
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-pane>` element (lazy IR). -}
splitPane :
    List (M3e.Cem.Attr.Attr { label : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , step : M3e.Value.Supported
    , value : M3e.Value.Supported
    , wrapDetents : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | splitPane : M3e.Value.Supported } msg
splitPane attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SplitPane.splitPane
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `start` slot. -}
start :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
start el =
    M3e.Content.slot "start" el


{-| Place content in the `end` slot. -}
end :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
end el =
    M3e.Content.slot "end" el