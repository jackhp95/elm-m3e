module M3e.SegmentedButton exposing
    ( view, disabled, hideSelectionIndicator, multi, name, onChange
    , onBeforeinput, onInput
    )

{-|
A button that allows a user to select from a limited set of options.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the checked state of a segment changes.
- `beforeinput`: Dispatched before the checked state of a segment changes.
- `input`: Dispatched when the checked state of a segment changes.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
```

<!-- elm-cem:example title="Icons" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.multi True ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.disabled True ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.disabled True ] [ M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Hiding the selection indicator" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.hideSelectionIndicator True ] [ M3e.ButtonSegment.view [] [ Kit.text "Design" ], M3e.ButtonSegment.view [] [ Kit.text "Accessibility" ], M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.SegmentedButton.view [ M3e.Attributes.class "density-3" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-2" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-1" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-0" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    ]
```

@docs view, disabled, hideSelectionIndicator, multi, name, onChange
@docs onBeforeinput, onInput
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SegmentedButton
import M3e.Element
import M3e.Element.Internal
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
    -> List (M3e.Element.Element { buttonSegment : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | segmentedButton : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SegmentedButton.segmentedButton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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