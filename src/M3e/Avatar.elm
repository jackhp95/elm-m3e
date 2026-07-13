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

import M3e.Html.Avatar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-avatar>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | avatar : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Avatar.avatar
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
