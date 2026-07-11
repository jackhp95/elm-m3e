module M3e.Raw.Toc exposing (toc, for, maxDepth)

{-| Bottom layer for `<m3e-toc>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs toc, for, maxDepth

-}

import Html
import Html.Attributes


{-| The raw `<m3e-toc>` element — a partial application of `Html.node`.
-}
toc : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
toc =
    Html.node "m3e-toc"


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.attribute "max-depth" (String.fromFloat val_)
