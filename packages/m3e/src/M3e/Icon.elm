module M3e.Icon exposing
    ( view, filled, grade, opticalSize, name, variant
    , weight
    )

{-|
A small symbol used to easily identify an action or category.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Icon variants, fill and weight showcase" -->
```elm
Native.nav [] [ M3e.Icon.view [ M3e.Icon.name "home", M3e.Icon.variant M3e.Value.outlined ] [], M3e.Icon.view [ M3e.Icon.name "favorite", M3e.Icon.variant M3e.Value.rounded, M3e.Icon.filled True ] [], M3e.Icon.view [ M3e.Icon.name "settings", M3e.Icon.variant M3e.Value.sharp, M3e.Icon.weight 600 ] [], M3e.Icon.view [ M3e.Icon.name "star", M3e.Icon.filled True, M3e.Icon.grade M3e.Value.high, M3e.Icon.opticalSize 40 ] [] ]
```

<!-- elm-cem:example title="Light-weight low-grade status icons" -->
```elm
Native.span [] [ M3e.Icon.view [ M3e.Icon.name "check_circle", M3e.Icon.filled True, M3e.Icon.weight 300, M3e.Icon.grade M3e.Value.low ] [], M3e.Icon.view [ M3e.Icon.name "error", M3e.Icon.variant M3e.Value.rounded, M3e.Icon.weight 500 ] [], M3e.Icon.view [ M3e.Icon.name "schedule", M3e.Icon.opticalSize 20 ] [] ]
```

@docs view, filled, grade, opticalSize, name, variant
@docs weight
-}


import M3e.Cem.Attr
import M3e.Cem.Icon
import M3e.Content
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
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | icon : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Icon.icon (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
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
weight : Int -> M3e.Cem.Attr.Attr { c | weight : M3e.Value.Supported } msg
weight =
    M3e.Cem.Icon.weight