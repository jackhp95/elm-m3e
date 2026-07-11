module M3e.Html.Skeleton exposing (skeleton, animation, shape, loaded)

{-| Middle layer for `<m3e-skeleton>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Skeleton` module for everyday use.

@docs skeleton, animation, shape, loaded

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Skeleton
import M3e.Token


{-| A visual placeholder that mimics the layout of content while it's still loading.

**Component Info:**

  - **Extends:** `LitElement`

-}
skeleton :
    List
        (M3e.Html.Attr.Attr
            { animation : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , loaded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
skeleton attributes children =
    M3e.Raw.Skeleton.skeleton
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    M3e.Token.Value
        { none : M3e.Token.Supported
        , pulse : M3e.Token.Supported
        , wave : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animation v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Skeleton.animation
        (M3e.Token.toString v_)


{-| The shape of the skeleton. (default: `"auto"`)
-}
shape :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , circular : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Skeleton.shape
        (M3e.Token.toString v_)


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> M3e.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
loaded =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Skeleton.loaded
