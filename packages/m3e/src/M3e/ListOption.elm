module M3e.ListOption exposing
    ( view, disabled, selected, value, onBeforeinput, onInput
    , onChange, onClick, child, leading, overline, supportingText, trailing
    , children
    )

{-|
A selectable option in a list.

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.

@docs view, disabled, selected, value, onBeforeinput, onInput
@docs onChange, onClick, child, leading, overline, supportingText
@docs trailing, children
-}


import M3e.Cem.Attr
import M3e.Cem.ListOption
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-list-option>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , leading : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , supportingText : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | listOption : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ListOption.listOption
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.ListOption.disabled


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.ListOption.selected


{-| A string representing the value of the option. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.ListOption.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.ListOption.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.ListOption.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.ListOption.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.ListOption.onClick


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
leading el =
    M3e.Content.slot "leading" el


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
overline el =
    M3e.Content.slot "overline" el


{-| Place content in the `supporting-text` slot. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | supportingText : M3e.Value.Supported } msg
supportingText el =
    M3e.Content.slot "supporting-text" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , text : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
trailing el =
    M3e.Content.slot "trailing" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els