module M3e.NavItem exposing
    ( view, disabled, disabledInteractive, download, href, orientation
    , rel, selected, target, onBeforeinput, onInput, onChange, onClick
    , child, icon, selectedIcon, children
    )

{-|
An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders the icon of the item.
- `selected-icon`: Renders the icon of the item when selected.

@docs view, disabled, disabledInteractive, download, href, orientation
@docs rel, selected, target, onBeforeinput, onInput, onChange
@docs onClick, child, icon, selectedIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.NavItem
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-item>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navItem : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavItem.navItem
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.NavItem.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.NavItem.disabledInteractive


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.NavItem.download


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.NavItem.href


{-| The layout orientation of the item. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.NavItem.orientation


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.NavItem.rel


{-| A value indicating whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.NavItem.selected


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.NavItem.target


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.NavItem.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.NavItem.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.NavItem.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.NavItem.onClick


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


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
selectedIcon el =
    M3e.Content.Internal.slot "selected-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els