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

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ScrollContainer
import M3e.Node
import M3e.Token


{-| Build the `<m3e-scroll-container>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { dividers : M3e.Token.Supported
            , thin : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | scrollContainer : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ScrollContainer.scrollContainer
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
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
    -> M3e.Html.Attr.Attr { c | dividers : M3e.Token.Supported } msg
dividers =
    M3e.Html.ScrollContainer.dividers


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> M3e.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
thin =
    M3e.Html.ScrollContainer.thin
