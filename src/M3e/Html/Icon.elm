module M3e.Html.Icon exposing
    ( icon, filled, grade, opticalSize, name, variant
    , weight
    )

{-| Middle layer for `<m3e-icon>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Icon` module for everyday use.

@docs icon, filled, grade, opticalSize, name, variant
@docs weight

-}

import Html
import M3e.Raw.Icon
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A small symbol used to easily identify an action or category.

**Component Info:**

  - **Extends:** `LitElement`

-}
icon :
    List
        (Markup.Html.Attr.Attr
            { filled : M3e.Token.Supported
            , grade : M3e.Token.Supported
            , opticalSize : M3e.Token.Supported
            , name : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , weight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
icon attributes children =
    M3e.Raw.Icon.icon
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the icon is filled. (default: `false`)
-}
filled : Bool -> Markup.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
filled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Icon.filled


{-| The grade of the icon. (default: `"medium"`)
-}
grade :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , low : M3e.Token.Supported
        , medium : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
grade v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Icon.grade
        (M3e.Token.toString v_)


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> Markup.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
opticalSize =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Icon.opticalSize


{-| The name of the icon. (default: `""`)
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Icon.name


{-| The appearance variant of the icon. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { outlined : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , sharp : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Icon.variant
        (M3e.Token.toString v_)


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : Int -> Markup.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
weight =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Icon.weight
