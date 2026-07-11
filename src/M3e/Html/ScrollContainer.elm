module M3e.Html.ScrollContainer exposing (scrollContainer, dividers, thin)

{-| Middle layer for `<m3e-scroll-container>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ScrollContainer` module for everyday use.

@docs scrollContainer, dividers, thin

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.ScrollContainer
import M3e.Token


{-| A vertically oriented content container which presents dividers above and below content when scrolled.

**Component Info:**

  - **Extends:** `LitElement`

-}
scrollContainer :
    List
        (M3e.Html.Attr.Attr
            { dividers : M3e.Token.Supported
            , thin : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
scrollContainer attributes children =
    M3e.Raw.ScrollContainer.scrollContainer
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


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
dividers v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ScrollContainer.dividers
        (M3e.Token.toString v_)


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> M3e.Html.Attr.Attr { c | thin : M3e.Token.Supported } msg
thin =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ScrollContainer.thin
