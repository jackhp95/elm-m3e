module M3e.Cem.Icon exposing
    ( icon, filled, grade, opticalSize, name, variant
    , weight
    )

{-|
Middle layer for `<m3e-icon>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Icon` module for everyday use.

@docs icon, filled, grade, opticalSize, name, variant
@docs weight
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Icon
import M3e.Value


{-| A small symbol used to easily identify an action or category.

**Component Info:**
- **Extends:** `LitElement`
-}
icon :
    List (M3e.Cem.Attr.Attr { filled : M3e.Value.Supported
    , grade : M3e.Value.Supported
    , opticalSize : M3e.Value.Supported
    , name : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , weight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
icon attributes children =
    M3e.Cem.Html.Icon.icon
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> M3e.Cem.Attr.Attr { c | filled : M3e.Value.Supported } msg
filled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.filled


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
grade v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.grade (M3e.Value.toString v_)


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float -> M3e.Cem.Attr.Attr { c | opticalSize : M3e.Value.Supported } msg
opticalSize =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.opticalSize


{-| The name of the icon. (default: `""`) -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.name


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { outlined : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , sharp : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.variant (M3e.Value.toString v_)


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
weight =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Icon.weight