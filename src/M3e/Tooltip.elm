module M3e.Tooltip exposing
    ( view, disabled, for, hideDelay, position, showDelay
    , touchGestures
    )

{-| Adds additional context to a button or other UI element.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

<!-- elm-cem:docmeta category=Communication -->


## Examples


### Examples

<!-- elm-cem:example title="Plain tooltip" -->
```elm
[ M3e.IconButton.view [ M3e.Attributes.id "button" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button" ] [ Kit.text "Go Back" ]
    ]
```

<!-- elm-cem:example title="Delays" -->
```elm
[ M3e.IconButton.view [ M3e.Attributes.id "button" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button", M3e.Tooltip.showDelay 0, M3e.Tooltip.hideDelay 200 ] [ Kit.text "Go Back" ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.IconButton.view [ M3e.Attributes.id "button" ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ]
    , M3e.Tooltip.view [ M3e.Tooltip.for "button", M3e.Tooltip.disabled True ] [ Kit.text "Go Back" ]
    ]
```

@docs view, disabled, for, hideDelay, position, showDelay
@docs touchGestures

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Tooltip
import M3e.Node
import M3e.Token


{-| Build the `<m3e-tooltip>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , hideDelay : M3e.Token.Supported
            , position : M3e.Token.Supported
            , showDelay : M3e.Token.Supported
            , touchGestures : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | tooltip : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Tooltip.tooltip
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Tooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Tooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> M3e.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    M3e.Html.Tooltip.hideDelay


{-| The position of the tooltip. (default: `"below"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position =
    M3e.Html.Tooltip.position


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> M3e.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    M3e.Html.Tooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures =
    M3e.Html.Tooltip.touchGestures
