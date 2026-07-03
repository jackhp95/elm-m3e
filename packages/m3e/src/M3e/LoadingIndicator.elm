module M3e.LoadingIndicator exposing ( view, variant )

{-|
Shows indeterminate progress for a short wait time.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Inline loading indicator while content loads" -->
```elm
Native.section [] [ Native.header [] [ Native.node Html.h2 [] [ Kit.text "Your dashboard" ] ], Native.div [] [ M3e.LoadingIndicator.view [] [], Native.p [] [ Kit.text "Loading your latest activity..." ] ] ]
```

<!-- elm-cem:example title="Contained loading indicator inside a refresh button" -->
```elm
Native.div [] [ M3e.Button.view { content = Kit.text "Refreshing", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.tonal, M3e.Button.disabled True ] [ M3e.Button.icon (M3e.LoadingIndicator.view [ M3e.LoadingIndicator.variant M3e.Value.contained ] []) ] ]
```

@docs view, variant
-}


import M3e.Cem.Attr
import M3e.Cem.LoadingIndicator
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-loading-indicator>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.LoadingIndicator.loadingIndicator
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant :
    M3e.Value.Value { contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.LoadingIndicator.variant