module M3e.Record.SuggestionChip exposing
    ( view, disabled, disabledInteractive, name, type_, value
    , variant, icon
    )

{-|
A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

**Component Info:**
- **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.

<!-- elm-cem:docmeta category=Selection -->

## Examples

### Examples

<!-- elm-cem:example title="Suggestion chip with a link action" -->
```elm
M3e.SuggestionChip.view [ M3e.SuggestionChip.href "/weather" ] [ M3e.SuggestionChip.child (Kit.text "What's the weather?") ]
```

@docs view, disabled, disabledInteractive, name, type_, value
@docs variant, icon
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SuggestionChip
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-suggestion-chip>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
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
    , name : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | suggestionChip : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SuggestionChip.suggestionChip
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


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SuggestionChip.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.SuggestionChip.disabledInteractive


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.SuggestionChip.name


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.SuggestionChip.type_


{-| A string representing the value of the chip. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.SuggestionChip.value


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.SuggestionChip.variant


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.Internal.slot "icon" el