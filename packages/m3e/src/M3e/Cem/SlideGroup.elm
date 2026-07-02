module M3e.Cem.SlideGroup exposing
    ( slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical
    )

{-|
Middle layer for `<m3e-slide-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SlideGroup` module for everyday use.

@docs slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.SlideGroup
import M3e.Value


{-| Presents pagination controls used to scroll overflowing content.

**Slots:**
- `next-icon`: Renders the icon to present for the next button.
- `prev-icon`: Renders the icon to present for the previous button.
-}
slideGroup :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , threshold : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
slideGroup attributes children =
    M3e.Cem.Html.SlideGroup.slideGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SlideGroup.disabled


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SlideGroup.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SlideGroup.previousPageLabel


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float -> M3e.Cem.Attr.Attr { c | threshold : M3e.Value.Supported } msg
threshold =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SlideGroup.threshold


{-| Whether content is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SlideGroup.vertical