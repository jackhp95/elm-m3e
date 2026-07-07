module M3e.TextareaAutosize exposing
    ( view, disabled, for, maxRows, minRows
    )

{-|
A non-visual element used to automatically resize a `textarea` to fit its content.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Text inputs -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "field" (Native.node Html.label [] [ Kit.text "Textarea Autosize" ]), M3e.FormField.child "field" (Native.node Html.textarea [] [ Kit.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." ]) ]
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field" ] []
    ]
```

<!-- elm-cem:example title="Min and max rows" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "field2" (Native.node Html.label [] [ Kit.text "Textarea Autosize" ]), M3e.FormField.child "field2" (Native.node Html.textarea [] [ Kit.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." ]) ]
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field2", M3e.TextareaAutosize.maxRows 5 ] []
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field", M3e.TextareaAutosize.disabled True ] []
```

@docs view, disabled, for, maxRows, minRows
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.TextareaAutosize
import M3e.Content
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-textarea-autosize>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , maxRows : M3e.Value.Supported
    , minRows : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | textareaAutosize : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TextareaAutosize.textareaAutosize
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether auto-sizing is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.TextareaAutosize.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.TextareaAutosize.for


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
maxRows =
    M3e.Cem.TextareaAutosize.maxRows


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
minRows =
    M3e.Cem.TextareaAutosize.minRows