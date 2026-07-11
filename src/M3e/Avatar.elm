module M3e.Avatar exposing (view)

{-| An image, icon or textual initials representing a user or other identity.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Usage" -->
```elm
[ M3e.Avatar.view [] [ Kit.text "AB" ]
    , M3e.Avatar.view [] [ Native.img [ Native.attribute "src" "https://avatars.githubusercontent.com/u/224686995?s=48&v=4" ] ]
    , M3e.Avatar.view [] [ M3e.Icon.view [ M3e.Icon.name "person" ] [] ]
    ]
```

@docs view

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Avatar
import M3e.Node
import M3e.Token


{-| Build the `<m3e-avatar>` element (lazy IR).
-}
view :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | avatar : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Avatar.avatar
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )
