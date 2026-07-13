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

import M3e.Html.LoadingIndicator
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-loading-indicator>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | loadingIndicator : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.LoadingIndicator.loadingIndicator
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`)
-}
variant :
    M3e.Token.Value
        { contained : M3e.Token.Supported
        , uncontained : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.LoadingIndicator.variant
