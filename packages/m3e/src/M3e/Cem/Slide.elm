module M3e.Cem.Slide exposing (selectedIndex, slide)

{-| 
@docs slide, selectedIndex
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Slide
import M3e.Value


{-| A carousel-like container used to horizontally cycle through slotted items. -}
slide :
    List (M3e.Cem.Attr.Attr { selectedIndex : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
slide attributes children =
    M3e.Cem.Html.Slide.slide
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float -> M3e.Cem.Attr.Attr { c | selectedIndex : M3e.Value.Supported } msg
selectedIndex =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Slide.selectedIndex