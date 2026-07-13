module M3e.Html.ChipSet exposing (chipSet, vertical)

{-| Middle layer for `<m3e-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ChipSet` module for everyday use.

@docs chipSet, vertical

-}

import Html
import M3e.Raw.ChipSet
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A container used to organize chips into a cohesive unit.

**Component Info:**

  - **Extends:** `LitElement`

-}
chipSet :
    List
        (Markup.Html.Attr.Attr
            { vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
chipSet attributes children =
    M3e.Raw.ChipSet.chipSet
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ChipSet.vertical
