module M3e.SelectionList exposing
    ( view, hideSelectionIndicator, multi, variant, name, disabled
    , onChange, onBeforeinput, onInput
    )

{-|
A list of selectable options.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**
- `change`: Dispatched when the selected state of an option changes.
- `beforeinput`: Dispatched before the selected state of an option changes.
- `input`: Dispatched when the selected state of an option changes.

@docs view, hideSelectionIndicator, multi, variant, name, disabled
@docs onChange, onBeforeinput, onInput
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SelectionList
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-selection-list>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { listOption : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | selectionList : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SelectionList.selectionList
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.SelectionList.hideSelectionIndicator


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.SelectionList.multi


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.SelectionList.variant


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.SelectionList.name


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SelectionList.disabled


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.SelectionList.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.SelectionList.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.SelectionList.onInput