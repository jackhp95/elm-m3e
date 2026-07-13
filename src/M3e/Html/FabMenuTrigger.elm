module M3e.Html.FabMenuTrigger exposing (fabMenuTrigger, for)

{-| Middle layer for `<m3e-fab-menu-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FabMenuTrigger` module for everyday use.

@docs fabMenuTrigger, for

-}

import Html
import M3e.Raw.FabMenuTrigger
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An element, nested within a clickable element, used to open a floating action button (FAB) menu.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
fabMenuTrigger :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
fabMenuTrigger attributes children =
    M3e.Raw.FabMenuTrigger.fabMenuTrigger
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FabMenuTrigger.for
