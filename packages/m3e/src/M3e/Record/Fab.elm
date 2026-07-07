module M3e.Record.Fab exposing
    ( view, disabled, disabledInteractive, extended, lowered, name
    , size, type_, value, variant, label, closeIcon
    )

{-|
A floating action button (FAB) used to present important actions.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `label`: Renders the label of an extended button.
- `close-icon`: Renders the close icon when used to open a FAB menu.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Fab.view [ M3e.Fab.variant M3e.Value.primary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.primaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.secondary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.secondaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.tertiary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.tertiaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Value.surface ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

<!-- elm-cem:example title="Lowering" -->
```elm
[ M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.primary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.primaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.secondary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.secondaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.tertiary ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.tertiaryContainer ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Value.surface ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Value.small ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.medium ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.large ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

### Examples

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.Fab.view [ M3e.Fab.disabled True ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.disabledInteractive True ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Value.small ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.small ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.small ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.small ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Value.medium ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.medium ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.medium ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Value.medium ] [ M3e.Fab.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    ]
```

@docs view, disabled, disabledInteractive, extended, lowered, name
@docs size, type_, value, variant, label, closeIcon
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Fab
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-fab>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , extended : M3e.Value.Supported
    , lowered : M3e.Value.Supported
    , name : M3e.Value.Supported
    , size : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { label : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | fab : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Fab.fab
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.append
                  (List.map
                       M3e.Cem.Attr.Internal.forget
                       (M3e.Action.toAttrs req_.action)
                  )
                  (List.map M3e.Cem.Attr.Internal.forget attributes)
             )
             (List.append
                  [ M3e.Action.wrapContent
                      req_.action
                      (M3e.Element.toNode req_.content)
                  ]
                  (List.map M3e.Content.toNode content_)
             )
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Fab.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Fab.disabledInteractive


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> M3e.Cem.Attr.Attr { c | extended : M3e.Value.Supported } msg
extended =
    M3e.Cem.Fab.extended


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> M3e.Cem.Attr.Attr { c | lowered : M3e.Value.Supported } msg
lowered =
    M3e.Cem.Fab.lowered


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Fab.name


{-| The size of the button. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Fab.size


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.Fab.type_


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Fab.value


{-| The appearance variant of the button. (default: `"primary-container"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , primaryContainer : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , secondaryContainer : M3e.Value.Supported
    , surface : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    , tertiaryContainer : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Fab.variant


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
label el =
    M3e.Content.Internal.slot "label" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.Internal.slot "close-icon" el