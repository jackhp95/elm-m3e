module M3e.Html.Breadcrumb exposing (breadcrumb, wrap)

{-| Middle layer for `<m3e-breadcrumb>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Breadcrumb` module for everyday use.

@docs breadcrumb, wrap

-}

import Html
import M3e.Raw.Breadcrumb
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Displays a hierarchical navigation path and identifies the user's
current location within an application.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `separator`: Renders a custom separator between breadcrumb items.

-}
breadcrumb :
    List
        (Markup.Html.Attr.Attr
            { wrap : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumb attributes children =
    M3e.Raw.Breadcrumb.breadcrumb
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap : Bool -> Markup.Html.Attr.Attr { c | wrap : M3e.Token.Supported } msg
wrap =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Breadcrumb.wrap
