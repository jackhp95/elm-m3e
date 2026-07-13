module M3e.Html.Optgroup exposing (optgroup)

{-| Middle layer for `<m3e-optgroup>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Optgroup` module for everyday use.

@docs optgroup

-}

import Html
import M3e.Raw.Optgroup
import M3e.Token
import Markup.Html.Attr


{-| Groups options under a subheading.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `label`: Renders the label of the group.

-}
optgroup :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
optgroup attributes children =
    M3e.Raw.Optgroup.optgroup
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
