module M3e.Badge exposing (view, size, position, for)

{-| A visual indicator used to label content.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->


## Examples


### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Badge.view [ M3e.Badge.size M3e.Token.small ] [ Kit.text "10" ]
    , M3e.Badge.view [ M3e.Badge.size M3e.Token.medium ] [ Kit.text "10" ]
    , M3e.Badge.view [ M3e.Badge.size M3e.Token.large ] [ Kit.text "10" ]
    ]
```


### Examples

<!-- elm-cem:example title="Anchoring" -->
```elm
[ M3e.Button.view [ M3e.Attributes.id "btn", M3e.Button.variant M3e.Token.outlined ] [ Kit.text "Button" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.aboveAfter ] [ Kit.text "AA" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.aboveBefore ] [ Kit.text "AB" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.belowBefore ] [ Kit.text "BB" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.belowAfter ] [ Kit.text "BA" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.before ] [ Kit.text "BE" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.after ] [ Kit.text "AF" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.above ] [ Kit.text "A" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Token.below ] [ Kit.text "B" ]
    ]
```

@docs view, size, position, for

-}

import M3e.Html.Badge
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-badge>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { size : M3e.Token.Supported
            , position : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | badge : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Badge.badge
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The size of the badge. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.Badge.size


{-| The position of the badge, when attached to another element. (default: `"above-after"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveAfter : M3e.Token.Supported
        , aboveBefore : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        , belowAfter : M3e.Token.Supported
        , belowBefore : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position =
    M3e.Html.Badge.position


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Badge.for
