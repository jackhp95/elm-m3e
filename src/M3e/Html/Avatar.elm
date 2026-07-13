module M3e.Html.Avatar exposing (avatar)

{-| Middle layer for `<m3e-avatar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Avatar` module for everyday use.

@docs avatar

-}

import Html
import M3e.Raw.Avatar
import M3e.Token
import Markup.Html.Attr


{-| An image, icon or textual initials representing a user or other identity.

**Component Info:**

  - **Extends:** `LitElement`

-}
avatar :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
avatar attributes children =
    M3e.Raw.Avatar.avatar
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
