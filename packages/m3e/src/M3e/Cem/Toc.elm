module M3e.Cem.Toc exposing ( toc, for, maxDepth )

{-|
Middle layer for `<m3e-toc>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Toc` module for everyday use.

@docs toc, for, maxDepth
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Toc
import M3e.Value


{-| A table of contents that provides in-page scroll navigation.

**Slots:**
- `overline`: Renders the overline of the table of contents.
- `title`: Renders the title of the table of contents.
-}
toc :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , maxDepth : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
toc attributes children =
    M3e.Cem.Html.Toc.toc (List.map M3e.Cem.Attr.toAttribute attributes) children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toc.for


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
maxDepth =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toc.maxDepth