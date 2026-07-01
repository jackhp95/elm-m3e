module M3e.Autocomplete exposing (autocomplete, child, children, loadingSlot, noData)

{-| 
@docs autocomplete, child, loadingSlot, noData, children
-}


import M3e.Cem.Attr
import M3e.Cem.Autocomplete
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-autocomplete>` element (lazy IR). -}
autocomplete :
    List (M3e.Cem.Attr.Attr { autoActivate : M3e.Value.Supported
    , caseSensitive : M3e.Value.Supported
    , filter : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , hideLoading : M3e.Value.Supported
    , hideNoData : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , loadingLabel : M3e.Value.Supported
    , noDataLabel : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , for : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onQuery : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | autocomplete : M3e.Value.Supported } msg
autocomplete attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Autocomplete.autocomplete
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
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `loading` slot. -}
loadingSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
loadingSlot el =
    M3e.Content.slot "loading" el


{-| Place content in the `no-data` slot. -}
noData :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
noData el =
    M3e.Content.slot "no-data" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els