module M3e.Html.ActionList exposing (actionList, variant)

{-| Middle layer for `<m3e-action-list>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ActionList` module for everyday use.

@docs actionList, variant

-}

import Html
import M3e.Raw.ActionList
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A list of actions.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

-}
actionList :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
actionList attributes children =
    M3e.Raw.ActionList.actionList
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ActionList.variant
        (M3e.Token.toString v_)
