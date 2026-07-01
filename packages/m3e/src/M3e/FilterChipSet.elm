module M3e.FilterChipSet exposing (child, children, filterChipSet)

{-| 
@docs filterChipSet, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.FilterChipSet
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-filter-chip-set>` element (lazy IR). -}
filterChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | filterChipSet : M3e.Value.Supported } msg
filterChipSet attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.FilterChipSet.filterChipSet
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { filterChip : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { filterChip : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els