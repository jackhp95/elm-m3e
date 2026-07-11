module M3e.LoadingIndicator exposing (view, variant)

{-| Shows indeterminate progress for a short wait time.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->


## Examples


### Examples

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.LoadingIndicator.view [] []
    , M3e.LoadingIndicator.view [ M3e.LoadingIndicator.variant M3e.Token.contained ] []
    ]
```

@docs view, variant

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.LoadingIndicator
import M3e.Node
import M3e.Token


{-| Build the `<m3e-loading-indicator>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | loadingIndicator : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.LoadingIndicator.loadingIndicator
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`)
-}
variant :
    M3e.Token.Value
        { contained : M3e.Token.Supported
        , uncontained : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.LoadingIndicator.variant
