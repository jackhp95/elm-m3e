module M3e.Html.SlideGroup exposing (slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical)

{-| Middle layer for `<m3e-slide-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SlideGroup` module for everyday use.

@docs slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.SlideGroup
import M3e.Token


{-| Presents pagination controls used to scroll overflowing content.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `next-icon`: Renders the icon to present for the next button.
  - `prev-icon`: Renders the icon to present for the previous button.

-}
slideGroup :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , threshold : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
slideGroup attributes children =
    M3e.Raw.SlideGroup.slideGroup
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether scroll buttons are disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SlideGroup.disabled


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> M3e.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SlideGroup.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SlideGroup.previousPageLabel


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
threshold : Float -> M3e.Html.Attr.Attr { c | threshold : M3e.Token.Supported } msg
threshold =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SlideGroup.threshold


{-| Whether content is oriented vertically. (default: `false`)
-}
vertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SlideGroup.vertical
