module M3e.FloatingPanel exposing
    ( view, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle
    )

{-|
A lightweight, generic floating surface used to present content above the page.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

@docs view, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.FloatingPanel
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-floating-panel>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { scrollStrategy : M3e.Value.Supported
    , fitAnchorWidth : M3e.Value.Supported
    , anchorOffset : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | floatingPanel : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FloatingPanel.floatingPanel
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategy =
    M3e.Cem.FloatingPanel.scrollStrategy


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool -> M3e.Cem.Attr.Attr { c | fitAnchorWidth : M3e.Value.Supported } msg
fitAnchorWidth =
    M3e.Cem.FloatingPanel.fitAnchorWidth


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float -> M3e.Cem.Attr.Attr { c | anchorOffset : M3e.Value.Supported } msg
anchorOffset =
    M3e.Cem.FloatingPanel.anchorOffset


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.FloatingPanel.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.FloatingPanel.onToggle