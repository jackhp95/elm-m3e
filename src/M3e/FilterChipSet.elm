module M3e.FilterChipSet exposing
    ( view, disabled, hideSelectionIndicator, multi, name, vertical
    , onChange, onBeforeinput, onInput
    )

{-|
A container that organizes filter chips into a cohesive group, enabling selection and
deselection of values used to refine content or trigger contextual behavior.

**Component Info:**
- **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**
- `change`: Dispatched when the selected state of a chip changes.
- `beforeinput`: Dispatched before the selected state of a chip changes.
- `input`: Dispatched when the selected state of a chip changes.

@docs view, disabled, hideSelectionIndicator, multi, name, vertical
@docs onChange, onBeforeinput, onInput
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.FilterChipSet
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-filter-chip-set>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { filterChip : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | filterChipSet : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FilterChipSet.filterChipSet
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.FilterChipSet.disabled


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.FilterChipSet.hideSelectionIndicator


{-| Whether multiple chips can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.FilterChipSet.multi


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.FilterChipSet.name


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.FilterChipSet.vertical


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.FilterChipSet.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.FilterChipSet.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.FilterChipSet.onInput