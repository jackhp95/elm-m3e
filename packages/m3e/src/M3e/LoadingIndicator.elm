module M3e.LoadingIndicator exposing ( view, variant )

{-|
Shows indeterminate progress for a short wait time.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.LoadingIndicator.view [] []
    , M3e.LoadingIndicator.view [ M3e.LoadingIndicator.variant M3e.Value.contained ] []
    ]
```

@docs view, variant
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.LoadingIndicator
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-loading-indicator>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.LoadingIndicator.loadingIndicator
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
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