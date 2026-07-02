module M3e.SplitButton exposing
    ( view, variant, size, child, children
    )

{-|
A button used to show an action with a menu of related actions.

**Slots:**
- `leading-button`: The leading button used to perform the primary action.
- `trailing-button`: The trailing icon button used to open a menu of related actions.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Filled split button with primary action and menu toggle" -->
```elm
M3e.SplitButton.view { leadingButton = M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), M3e.Button.child (Kit.text "Edit") ], trailingButton = M3e.Button.view [] [ M3e.Button.child (M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] []) ] } [ M3e.SplitButton.variant M3e.Value.filled, M3e.SplitButton.size M3e.Value.medium ] []
```

<!-- elm-cem:example title="Tonal split button" -->
```elm
M3e.SplitButton.view { leadingButton = M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "save" ] []), M3e.Button.child (Kit.text "Save") ], trailingButton = M3e.Button.view [] [ M3e.Button.child (M3e.Icon.view [ M3e.Icon.name "arrow_drop_down" ] []) ] } [ M3e.SplitButton.variant M3e.Value.tonal, M3e.SplitButton.size M3e.Value.large ] []
```

@docs view, variant, size, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.SplitButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-button>` element (lazy IR). -}
view :
    { leadingButton : M3e.Element.Element any msg
    , trailingButton : M3e.Element.Element any msg
    }
    -> List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SplitButton.splitButton
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.append
                  [ M3e.Element.toNode
                      (M3e.Element.withSlot "leading-button" req_.leadingButton)
                  , M3e.Element.toNode
                      (M3e.Element.withSlot
                         "trailing-button"
                         req_.trailingButton
                      )
                  ]
                  (List.map M3e.Content.toNode content_)
             )
        )


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.SplitButton.variant


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.SplitButton.size


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els