module M3e.Html.TextOverflow exposing (textOverflow)

{-| Middle layer for `<m3e-text-overflow>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TextOverflow` module for everyday use.

@docs textOverflow

-}

import Html
import M3e.Raw.TextOverflow
import M3e.Token
import Markup.Html.Attr


{-| An inline container which presents an ellipsis when content overflows.

**Component Info:**

  - **Extends:** `LitElement`

-}
textOverflow :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
textOverflow attributes children =
    M3e.Raw.TextOverflow.textOverflow
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
