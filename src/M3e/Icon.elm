module M3e.Icon exposing
    ( view, filled, grade, opticalSize, name, variant
    , weight
    )

{-| A small symbol used to easily identify an action or category.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Basic icons" -->
```elm
M3e.Icon.view [ M3e.Icon.name "home" ] []
```

<!-- elm-cem:example title="SVG icons" -->
```elm
[ M3e.Icon.view [ M3e.Icon.variant M3e.Token.outlined, M3e.Icon.name "search" ] []
    , M3e.Icon.view [ M3e.Icon.variant M3e.Token.outlined, M3e.Icon.name "home" ] []
    , M3e.Icon.view [ M3e.Icon.variant M3e.Token.outlined, M3e.Icon.name "settings" ] []
    , M3e.Icon.view [ M3e.Icon.variant M3e.Token.outlined, M3e.Icon.name "favorite" ] []
    , M3e.Icon.view [ M3e.Icon.variant M3e.Token.outlined, M3e.Icon.name "notifications" ] []
    ]
```

@docs view, filled, grade, opticalSize, name, variant
@docs weight

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Icon
import M3e.Node
import M3e.Token


{-| Build the `<m3e-icon>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | icon : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Icon.icon
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the icon is filled. (default: `false`)
-}
filled : Bool -> M3e.Html.Attr.Attr { c | filled : M3e.Token.Supported } msg
filled =
    M3e.Html.Icon.filled


{-| The grade of the icon. (default: `"medium"`)
-}
grade :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , low : M3e.Token.Supported
        , medium : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | grade : M3e.Token.Supported } msg
grade =
    M3e.Html.Icon.grade


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> M3e.Html.Attr.Attr { c | opticalSize : M3e.Token.Supported } msg
opticalSize =
    M3e.Html.Icon.opticalSize


{-| The name of the icon. (default: `""`)
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Icon.name


{-| The appearance variant of the icon. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { outlined : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , sharp : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Icon.variant


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : Int -> M3e.Html.Attr.Attr { c | weight : M3e.Token.Supported } msg
weight =
    M3e.Html.Icon.weight
