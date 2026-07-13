module M3e.ScrollContainer exposing (view, dividers, thin)

{-| A vertically oriented content container which presents dividers above and below content when scrolled.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Containment -->


## Examples


### Examples

<!-- elm-cem:example title="Scroll effects" -->
```elm
M3e.ScrollContainer.view [ M3e.Attributes.style [ ( "display", "block" ), ( "height", "160px" ) ] ] [ Native.p [] [ Kit.text "Scroll down to reveal the divider above." ], Native.p [] [ Kit.text "Line 1 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 2 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 3 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 4 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 5 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 6 of a long list of trail notes." ], Native.p [] [ Kit.text "Line 7 of a long list of trail notes." ], Native.p [] [ Kit.text "Keep scrolling to reveal the divider below." ] ]
```

@docs view, dividers, thin

-}

import M3e.Html.ScrollContainer
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-scroll-container>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { dividers : M3e.Token.Supported
            , thin : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | scrollContainer : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ScrollContainer.scrollContainer
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveBelow : M3e.Token.Supported
        , below : M3e.Token.Supported
        , none : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividers =
    M3e.Html.ScrollContainer.dividers


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> Markup.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
thin =
    M3e.Html.ScrollContainer.thin
