module M3e.TextareaAutosize exposing
    ( view, disabled, for, maxRows, minRows
    )

{-|
A non-visual element used to automatically resize a `textarea` to fit its content.

<!-- elm-cem:docmeta category=Text inputs -->

## Examples

### Examples

<!-- elm-cem:example title="Auto-resizing comment textarea" -->
```elm
[ Native.node Html.label [] [ Kit.text "Add a comment" ]
    , Native.node Html.textarea [] []
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "comment", M3e.TextareaAutosize.minRows 2, M3e.TextareaAutosize.maxRows 8 ] []
    ]
```

<!-- elm-cem:example title="Disabled auto-sizing on a fixed message box" -->
```elm
[ Native.node Html.label [] [ Kit.text "Message" ]
    , Native.node Html.textarea [] []
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "msg", M3e.TextareaAutosize.disabled True ] []
    ]
```

@docs view, disabled, for, maxRows, minRows
-}


import M3e.Cem.Attr
import M3e.Cem.TextareaAutosize
import M3e.Content
import M3e.Element
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
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TextareaAutosize.textareaAutosize
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
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