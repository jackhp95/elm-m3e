module M3e.Icon exposing
    ( view, filled, grade, opticalSize, name, variant
    , weight
    )

{-|
A small symbol used to easily identify an action or category.

@docs view, filled, grade, opticalSize, name, variant
@docs weight
-}


import M3e.Cem.Attr
import M3e.Cem.Icon
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-icon>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { filled : M3e.Value.Supported
    , grade : M3e.Value.Supported
    , opticalSize : M3e.Value.Supported
    , name : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , weight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | icon : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Icon.icon (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> M3e.Cem.Attr.Attr { c | filled : M3e.Value.Supported } msg
filled =
    M3e.Cem.Icon.filled


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | grade : M3e.Value.Supported } msg
grade =
    M3e.Cem.Icon.grade


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float -> M3e.Cem.Attr.Attr { c | opticalSize : M3e.Value.Supported } msg
opticalSize =
    M3e.Cem.Icon.opticalSize


{-| The name of the icon. (default: `""`) -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Icon.name


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { outlined : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , sharp : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Icon.variant


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
weight =
    M3e.Cem.Icon.weight