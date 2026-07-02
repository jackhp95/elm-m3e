module M3e.Collapsible exposing
    ( view, open, orientation, noAnimate, onOpening, onOpened
    , onClosing, onClosed, child, children
    )

{-|
A container used to expand and collapse content.

**Events:**
- `opening`: Dispatched when the collapsible begins to open.
- `opened`: Dispatched when the collapsible has opened.
- `closing`: Dispatched when the collapsible begins to close.
- `closed`: Dispatched when the collapsible has closed.

@docs view, open, orientation, noAnimate, onOpening, onOpened
@docs onClosing, onClosed, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Collapsible
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-collapsible>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { open : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , noAnimate : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | collapsible : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Collapsible.collapsible
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether content is visible. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Collapsible.open


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.Collapsible.orientation


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool -> M3e.Cem.Attr.Attr { c | noAnimate : M3e.Value.Supported } msg
noAnimate =
    M3e.Cem.Collapsible.noAnimate


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.Collapsible.onOpening


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.Collapsible.onOpened


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.Collapsible.onClosing


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.Collapsible.onClosed


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els