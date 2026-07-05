module M3e.Tab exposing
    ( view, disabled, for, selected, onBeforeinput, onInput
    , onChange, onClick, child, icon, children
    )

{-|
An interactive element that, when activated, presents an associated tab panel.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the tab's label.

@docs view, disabled, for, selected, onBeforeinput, onInput
@docs onChange, onClick, child, icon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tab
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tab>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | tab : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tab.tab
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Tab.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Tab.for


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Tab.selected


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Tab.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Tab.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Tab.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Tab.onClick


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.Internal.slot "icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els