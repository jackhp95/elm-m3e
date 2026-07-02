module M3e.SegmentedButton exposing
    ( view, disabled, hideSelectionIndicator, multi, name, onChange
    , onBeforeinput, onInput, child, children
    )

{-|
A button that allows a user to select from a limited set of options.

**Events:**
- `change`: Dispatched when the checked state of a segment changes.
- `beforeinput`: Dispatched before the checked state of a segment changes.
- `input`: Dispatched when the checked state of a segment changes.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Segmented button with icons" -->
```elm
M3e.SegmentedButton.view [] (M3e.SegmentedButton.children [ M3e.ButtonSegment.view [ M3e.ButtonSegment.value "paste", M3e.ButtonSegment.checked True ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "content_paste" ] []), M3e.ButtonSegment.child (Kit.text "Paste") ], M3e.ButtonSegment.view [ M3e.ButtonSegment.value "file" ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "upload_file" ] []), M3e.ButtonSegment.child (Kit.text "File") ] ])
```

<!-- elm-cem:example title="Segmented button for value selection" -->
```elm
M3e.SegmentedButton.view [] (M3e.SegmentedButton.children [ M3e.ButtonSegment.view [ M3e.ButtonSegment.value "0.75" ] [ M3e.ButtonSegment.child (Kit.text "0.75x") ], M3e.ButtonSegment.view [ M3e.ButtonSegment.value "1", M3e.ButtonSegment.checked True ] [ M3e.ButtonSegment.child (Kit.text "1x") ], M3e.ButtonSegment.view [ M3e.ButtonSegment.value "1.5" ] [ M3e.ButtonSegment.child (Kit.text "1.5x") ] ])
```

@docs view, disabled, hideSelectionIndicator, multi, name, onChange
@docs onBeforeinput, onInput, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.SegmentedButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-segmented-button>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | segmentedButton : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SegmentedButton.segmentedButton
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SegmentedButton.disabled


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.SegmentedButton.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.SegmentedButton.multi


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.SegmentedButton.name


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.SegmentedButton.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.SegmentedButton.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.SegmentedButton.onInput


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { buttonSegment : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { buttonSegment : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els