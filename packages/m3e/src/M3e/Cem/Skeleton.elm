module M3e.Cem.Skeleton exposing (animation, loaded, shape, skeleton)

{-| 
@docs skeleton, animation, shape, loaded
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Skeleton
import M3e.Value


{-| A visual placeholder that mimics the layout of content while it's still loading. -}
skeleton :
    List (M3e.Cem.Attr.Attr { animation : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , loaded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
skeleton attributes children =
    M3e.Cem.Html.Skeleton.skeleton
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animation v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Skeleton.animation
        (M3e.Value.toString v_)


{-| The shape of the skeleton. (default: `"auto"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Skeleton.shape (M3e.Value.toString v_)


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
loaded =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Skeleton.loaded