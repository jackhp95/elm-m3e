module M3e.Cem.Shape exposing ( shape, name )

{-|
Middle layer for `<m3e-shape>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Shape` module for everyday use.

@docs shape, name
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Shape
import M3e.Value


{-| A shape used to add emphasis and decorative flair.

**Component Info:**
- **Extends:** `LitElement`
-}
shape :
    List (M3e.Cem.Attr.Attr { name : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
shape attributes children =
    M3e.Cem.Html.Shape.shape
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The name of the shape. (default: `null`) -}
name :
    M3e.Value.Value { value12SidedCookie : M3e.Value.Supported
    , value4LeafClover : M3e.Value.Supported
    , value4SidedCookie : M3e.Value.Supported
    , value6SidedCookie : M3e.Value.Supported
    , value7SidedCookie : M3e.Value.Supported
    , value8LeafClover : M3e.Value.Supported
    , value9SidedCookie : M3e.Value.Supported
    , arch : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , boom : M3e.Value.Supported
    , bun : M3e.Value.Supported
    , burst : M3e.Value.Supported
    , circle : M3e.Value.Supported
    , diamond : M3e.Value.Supported
    , fan : M3e.Value.Supported
    , flower : M3e.Value.Supported
    , gem : M3e.Value.Supported
    , ghostIsh : M3e.Value.Supported
    , heart : M3e.Value.Supported
    , hexagon : M3e.Value.Supported
    , oval : M3e.Value.Supported
    , pentagon : M3e.Value.Supported
    , pill : M3e.Value.Supported
    , pixelCircle : M3e.Value.Supported
    , pixelTriangle : M3e.Value.Supported
    , puffy : M3e.Value.Supported
    , puffyDiamond : M3e.Value.Supported
    , semicircle : M3e.Value.Supported
    , slanted : M3e.Value.Supported
    , softBoom : M3e.Value.Supported
    , softBurst : M3e.Value.Supported
    , square : M3e.Value.Supported
    , sunny : M3e.Value.Supported
    , triangle : M3e.Value.Supported
    , verySunny : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Shape.name (M3e.Value.toString v_)