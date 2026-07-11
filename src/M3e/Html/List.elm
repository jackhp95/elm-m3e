module M3e.Html.List exposing (list, variant)

{-| Middle layer for `<m3e-list>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.List` module for everyday use.

@docs list, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.List
import M3e.Token


{-| A list of items.

**Component Info:**

  - **Extends:** `LitElement`

-}
list :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
list attributes children =
    M3e.Raw.List.list (List.map M3e.Html.Attr.toAttribute attributes) children


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.List.variant
        (M3e.Token.toString v_)
