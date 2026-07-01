module M3e.LoadingIndicator exposing (loadingIndicator, variant)

{-| 
@docs loadingIndicator, variant
-}


import M3e.Cem.Attr
import M3e.Cem.LoadingIndicator
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-loading-indicator>` element (lazy IR). -}
loadingIndicator :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Value.Supported } msg
loadingIndicator attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.LoadingIndicator.loadingIndicator
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant :
    M3e.Value.Value { contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.LoadingIndicator.variant