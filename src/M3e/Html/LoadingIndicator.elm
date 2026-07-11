module M3e.Html.LoadingIndicator exposing (loadingIndicator, variant)

{-| Middle layer for `<m3e-loading-indicator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.LoadingIndicator` module for everyday use.

@docs loadingIndicator, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.LoadingIndicator
import M3e.Token


{-| Shows indeterminate progress for a short wait time.

**Component Info:**

  - **Extends:** `LitElement`

-}
loadingIndicator :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
loadingIndicator attributes children =
    M3e.Raw.LoadingIndicator.loadingIndicator
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The appearance variant of the indicator. (default: `"uncontained"`)
-}
variant :
    M3e.Token.Value
        { contained : M3e.Token.Supported
        , uncontained : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.LoadingIndicator.variant
        (M3e.Token.toString v_)
