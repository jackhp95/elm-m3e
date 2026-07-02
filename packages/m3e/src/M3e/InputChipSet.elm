module M3e.InputChipSet exposing
    ( view, disabled, name, required, vertical, onChange
    , child, input, children
    )

{-|
A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**
- **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**
- `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**
- `input`: Renders the input element used to add new chips to the set.

@docs view, disabled, name, required, vertical, onChange
@docs child, input, children
-}


import M3e.Cem.Attr
import M3e.Cem.InputChipSet
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-input-chip-set>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , input : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChipSet : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.InputChipSet.inputChipSet
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.InputChipSet.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.InputChipSet.name


{-| Whether a value is required for the element. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.InputChipSet.required


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.InputChipSet.vertical


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.InputChipSet.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { inputChip : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `input` slot. -}
input :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | input : M3e.Value.Supported } msg
input el =
    M3e.Content.slot "input" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { inputChip : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els