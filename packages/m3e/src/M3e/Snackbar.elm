module M3e.Snackbar exposing
    ( view, action, closeLabel, dismissible, duration, onBeforetoggle
    , onToggle, child, closeIcon, children
    )

{-|
Presents short updates about application processes at the bottom of the screen.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `close-icon`: Renders the icon of the button used to close the snackbar.

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Snackbar service" -->
```elm
M3e.Button.view [] [ M3e.Button.child (Kit.text "Delete file") ]
```

<!-- elm-cem:example title="Actions" -->
```elm
M3e.Button.view [] [ M3e.Button.child (Kit.text "Delete file") ]
```

<!-- elm-cem:example title="Dismissal" -->
```elm
M3e.Button.view [] [ M3e.Button.child (Kit.text "Delete file") ]
```

@docs view, action, closeLabel, dismissible, duration, onBeforetoggle
@docs onToggle, child, closeIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Snackbar
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-snackbar>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { action : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , duration : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | snackbar : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Snackbar.snackbar
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> M3e.Cem.Attr.Attr { c | action : M3e.Value.Supported } msg
action =
    M3e.Cem.Snackbar.action


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Snackbar.closeLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Snackbar.dismissible


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> M3e.Cem.Attr.Attr { c | duration : M3e.Value.Supported } msg
duration =
    M3e.Cem.Snackbar.duration


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.Snackbar.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Snackbar.onToggle


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.Internal.slot "close-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els