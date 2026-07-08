module M3e.Badge exposing ( view, size, position, for )

{-|
A visual indicator used to label content.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Badge.view [ M3e.Badge.size M3e.Value.small ] [ Kit.text "10" ]
    , M3e.Badge.view [ M3e.Badge.size M3e.Value.medium ] [ Kit.text "10" ]
    , M3e.Badge.view [ M3e.Badge.size M3e.Value.large ] [ Kit.text "10" ]
    ]
```

### Examples

<!-- elm-cem:example title="Anchoring" -->
```elm
[ M3e.Button.view [ M3e.Attributes.id "btn", M3e.Button.variant M3e.Value.outlined ] [ Kit.text "Button" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.aboveAfter ] [ Kit.text "AA" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.aboveBefore ] [ Kit.text "AB" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.belowBefore ] [ Kit.text "BB" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.belowAfter ] [ Kit.text "BA" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.before ] [ Kit.text "BE" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.after ] [ Kit.text "AF" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.above ] [ Kit.text "A" ]
    , M3e.Badge.view [ M3e.Badge.for "btn", M3e.Badge.position M3e.Value.below ] [ Kit.text "B" ]
    ]
```

@docs view, size, position, for
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Badge
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-badge>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { size : M3e.Value.Supported
    , position : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | badge : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Badge.badge
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The size of the badge. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Badge.size


{-| The position of the badge, when attached to another element. (default: `"above-after"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position =
    M3e.Cem.Badge.position


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Badge.for