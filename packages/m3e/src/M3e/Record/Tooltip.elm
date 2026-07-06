module M3e.Record.Tooltip exposing
    ( view, disabled, for, hideDelay, position, showDelay
    , touchGestures
    )

{-|
Adds additional context to a button or other UI element.

**Component Info:**
- **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Plain tooltip" -->
```elm
[ M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button" ] [ M3e.Tooltip.child (Kit.text "Go Back") ]
    ]
```

<!-- elm-cem:example title="Delays" -->
```elm
[ M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button", M3e.Tooltip.showDelay 0, M3e.Tooltip.hideDelay 200 ] [ M3e.Tooltip.child (Kit.text "Go Back") ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button", M3e.Tooltip.disabled True ] [ M3e.Tooltip.child (Kit.text "Go Back") ]
    ]
```

<!-- elm-cem:example title="Rich tooltip" -->
```elm
[ M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "settings" ] []) ]
    , M3e.RichTooltip.view [ M3e.RichTooltip.for "button" ] [ M3e.RichTooltip.subhead (Native.span [] [ Kit.text "New settings available" ]), M3e.RichTooltip.child (Kit.text "Now you can adjust the uploaded image quality, and upgrade your available storage space.") ]
    ]
```

@docs view, disabled, for, hideDelay, position, showDelay
@docs touchGestures
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tooltip
import M3e.Content
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tooltip>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | tooltip : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tooltip.tooltip
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.append
                  [ M3e.Element.toNode req_.content ]
                  (List.map M3e.Content.toNode content_)
             )
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Tooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Tooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Tooltip.hideDelay


{-| The position of the tooltip. (default: `"below"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position =
    M3e.Cem.Tooltip.position


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Tooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures =
    M3e.Cem.Tooltip.touchGestures