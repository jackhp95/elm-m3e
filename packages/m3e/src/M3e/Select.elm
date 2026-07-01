module M3e.Select exposing (arrow, child, children, select, value)

{-| 
@docs select, child, arrow, value, children
-}


import M3e.Cem.Attr
import M3e.Cem.Select
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-select>` element (lazy IR). -}
select :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , value : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | select : M3e.Value.Supported } msg
select attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Select.select (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `arrow` slot. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | arrow : M3e.Value.Supported } msg
arrow el =
    M3e.Content.slot "arrow" el


{-| Place content in the `value` slot. -}
value :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | value : M3e.Value.Supported } msg
value el =
    M3e.Content.slot "value" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els