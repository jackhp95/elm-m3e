module M3e.Html.Toc exposing (toc, for, maxDepth)

{-| Middle layer for `<m3e-toc>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Toc` module for everyday use.

@docs toc, for, maxDepth

-}

import Html
import M3e.Raw.Toc
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A table of contents that provides in-page scroll navigation.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `overline`: Renders the overline of the table of contents.
  - `title`: Renders the title of the table of contents.

-}
toc :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , maxDepth : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
toc attributes children =
    M3e.Raw.Toc.toc (List.map Markup.Html.Attr.toAttribute attributes) children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Toc.for


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Markup.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
maxDepth =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Toc.maxDepth
