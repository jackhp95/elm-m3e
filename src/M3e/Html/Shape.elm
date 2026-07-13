module M3e.Html.Shape exposing (shape, name)

{-| Middle layer for `<m3e-shape>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Shape` module for everyday use.

@docs shape, name

-}

import Html
import M3e.Raw.Shape
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A shape used to add emphasis and decorative flair.

**Component Info:**

  - **Extends:** `LitElement`

-}
shape :
    List
        (Markup.Html.Attr.Attr
            { nameEnum : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
shape attributes children =
    M3e.Raw.Shape.shape
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The name of the shape. (default: `null`)
-}
name :
    M3e.Token.Value
        { value12SidedCookie : M3e.Token.Supported
        , value4LeafClover : M3e.Token.Supported
        , value4SidedCookie : M3e.Token.Supported
        , value6SidedCookie : M3e.Token.Supported
        , value7SidedCookie : M3e.Token.Supported
        , value8LeafClover : M3e.Token.Supported
        , value9SidedCookie : M3e.Token.Supported
        , arch : M3e.Token.Supported
        , arrow : M3e.Token.Supported
        , boom : M3e.Token.Supported
        , bun : M3e.Token.Supported
        , burst : M3e.Token.Supported
        , circle : M3e.Token.Supported
        , diamond : M3e.Token.Supported
        , fan : M3e.Token.Supported
        , flower : M3e.Token.Supported
        , gem : M3e.Token.Supported
        , ghostIsh : M3e.Token.Supported
        , heart : M3e.Token.Supported
        , hexagon : M3e.Token.Supported
        , oval : M3e.Token.Supported
        , pentagon : M3e.Token.Supported
        , pill : M3e.Token.Supported
        , pixelCircle : M3e.Token.Supported
        , pixelTriangle : M3e.Token.Supported
        , puffy : M3e.Token.Supported
        , puffyDiamond : M3e.Token.Supported
        , semicircle : M3e.Token.Supported
        , slanted : M3e.Token.Supported
        , softBoom : M3e.Token.Supported
        , softBurst : M3e.Token.Supported
        , square : M3e.Token.Supported
        , sunny : M3e.Token.Supported
        , triangle : M3e.Token.Supported
        , verySunny : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | nameEnum : M3e.Token.Supported } msg
name v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Shape.name
        (M3e.Token.toString v_)
