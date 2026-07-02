module M3e.NavRail exposing
    ( view, mode, onBeforeinput, onInput, onChange, child
    , children
    )

{-|
A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Events:**
- `beforeinput`: Dispatched before the selected state of an item changes.
- `input`: Dispatched when the selected state of an item changes.
- `change`: Dispatched when the selected state of an item changes.

@docs view, mode, onBeforeinput, onInput, onChange, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.NavRail
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-rail>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navRail : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavRail.navRail
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.NavRail.mode


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.NavRail.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.NavRail.onInput


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.NavRail.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { navItem : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , fab : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { navItem : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , fab : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els