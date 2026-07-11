module M3e.Html.Slide exposing (slide, selectedIndex)

{-| Middle layer for `<m3e-slide>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Slide` module for everyday use.

@docs slide, selectedIndex

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Slide
import M3e.Token


{-| A carousel-like container used to horizontally cycle through slotted items.

**Component Info:**

  - **Extends:** `LitElement`

-}
slide :
    List
        (M3e.Html.Attr.Attr
            { selectedIndex : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
slide attributes children =
    M3e.Raw.Slide.slide (List.map M3e.Html.Attr.toAttribute attributes) children


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex : Float -> M3e.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
selectedIndex =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slide.selectedIndex
