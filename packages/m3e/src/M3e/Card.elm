module M3e.Card exposing
    ( view, actionable, inline, orientation, variant, href
    , target, rel, download, name, value, type_, disabledInteractive
    , disabled, onClick, child, header, content, actions, footer
    , children
    )

{-|
A content container for text, images (or other media), and actions in the context of a single subject.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `header`: Renders the header of the card.
- `content`: Renders the content of the card with padding.
- `actions`: Renders the actions of the card.
- `footer`: Renders the footer of the card.

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ M3e.Heading.child (Kit.text "Card Header") ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child (Kit.text "Action") ] ]), M3e.Card.footer (Native.div [] [ Kit.text "Card Footer" ]) ]
```

<!-- elm-cem:example title="Card Header" -->
```elm
M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ M3e.Heading.child (Kit.text "Card Header") ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child (Kit.text "Action") ] ]) ]
```

<!-- elm-cem:example title="Card Header (2)" -->
```elm
M3e.Card.view [] [ M3e.Card.child (Kit.text "Card content") ]
```

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Card.view [ M3e.Card.variant M3e.Value.filled ] [ M3e.Card.content (Native.div [] [ Kit.text "Filled" ]) ]
    , Native.br
    , M3e.Card.view [ M3e.Card.variant M3e.Value.outlined ] [ M3e.Card.content (Native.div [] [ Kit.text "Outlined" ]) ]
    , Native.br
    , M3e.Card.view [ M3e.Card.variant M3e.Value.elevated ] [ M3e.Card.content (Native.div [] [ Kit.text "Elevated" ]) ]
    ]
```

<!-- elm-cem:example title="Inline" -->
```elm
M3e.Card.view [ M3e.Card.inline True ] [ M3e.Card.content (Native.div [] [ Kit.text "Inline" ]) ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
M3e.Card.view [ M3e.Card.inline True, M3e.Card.orientation M3e.Value.horizontal ] [ M3e.Card.header (Native.img []), M3e.Card.content (Native.div [] [ Kit.text "Horizontal" ]) ]
```

<!-- elm-cem:example title="Actionable" -->
```elm
[ M3e.Card.view [ M3e.Card.variant M3e.Value.filled, M3e.Card.actionable True ] [ M3e.Card.content (Native.div [] [ Kit.text "Filled Actionable" ]) ]
    , Native.br
    , M3e.Card.view [ M3e.Card.variant M3e.Value.outlined, M3e.Card.actionable True ] [ M3e.Card.content (Native.div [] [ Kit.text "Outlined Actionable" ]) ]
    , Native.br
    , M3e.Card.view [ M3e.Card.variant M3e.Value.elevated, M3e.Card.actionable True ] [ M3e.Card.content (Native.div [] [ Kit.text "Elevated Actionable" ]) ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.Card.view [ M3e.Card.variant M3e.Value.filled, M3e.Card.actionable True, M3e.Card.disabled True ] [ M3e.Card.content (Native.div [] [ Kit.text "Disabled" ]) ]
    , Native.br
    , M3e.Card.view [ M3e.Card.variant M3e.Value.filled, M3e.Card.actionable True, M3e.Card.disabledInteractive True ] [ M3e.Card.content (Native.div [] [ Kit.text "Disabled Interactive" ]) ]
    ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.Card.view [ M3e.Card.actionable True, M3e.Card.href "https://www.google.com", M3e.Card.target "_blank" ] [ M3e.Card.content (Native.div [] [ Kit.text "Google" ]) ]
```

@docs view, actionable, inline, orientation, variant, href
@docs target, rel, download, name, value, type_
@docs disabledInteractive, disabled, onClick, child, header, content
@docs actions, footer, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Card
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-card>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { actionable : M3e.Value.Supported
    , inline : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    , content : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , footer : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | card : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Card.card
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool -> M3e.Cem.Attr.Attr { c | actionable : M3e.Value.Supported } msg
actionable =
    M3e.Cem.Card.actionable


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> M3e.Cem.Attr.Attr { c | inline : M3e.Value.Supported } msg
inline =
    M3e.Cem.Card.inline


{-| The orientation of the card. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.Card.orientation


{-| The appearance variant of the card. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Card.variant


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Card.href


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Card.target


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Card.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Card.download


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Card.name


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Card.value


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.Card.type_


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Card.disabledInteractive


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Card.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Card.onClick


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
header el =
    M3e.Content.Internal.slot "header" el


{-| Place content in the `content` slot. -}
content :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | content : M3e.Value.Supported } msg
content el =
    M3e.Content.Internal.slot "content" el


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
actions el =
    M3e.Content.Internal.slot "actions" el


{-| Place content in the `footer` slot. -}
footer :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | footer : M3e.Value.Supported } msg
footer el =
    M3e.Content.Internal.slot "footer" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els