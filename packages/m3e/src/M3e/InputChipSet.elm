module M3e.InputChipSet exposing (child, children, input, inputChipSet)

{-| 
@docs inputChipSet, child, input, children
-}


import M3e.Cem.Attr
import M3e.Cem.InputChipSet
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-input-chip-set>` element (lazy IR). -}
inputChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , input : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChipSet : M3e.Value.Supported } msg
inputChipSet attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.InputChipSet.inputChipSet
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { inputChip : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `input` slot. -}
input :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
input el =
    M3e.Content.slot "input" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { inputChip : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els