module M3e.TextareaAutosize exposing (view, disabled, for, maxRows, minRows)

{-| A non-visual element used to automatically resize a `textarea` to fit its content.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Text inputs -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled ] [ M3e.FormField.label "field" (Native.node Html.label [ Native.attribute "for" "field" ] [ Kit.text "Textarea Autosize" ]), M3e.FormField.control "field" (Native.node Html.textarea [ Native.attribute "id" "field" ] [ Kit.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." ]) ]
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field" ] []
    ]
```

<!-- elm-cem:example title="Min and max rows" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled ] [ M3e.FormField.label "field2" (Native.node Html.label [ Native.attribute "for" "field2" ] [ Kit.text "Textarea Autosize" ]), M3e.FormField.control "field2" (Native.node Html.textarea [ Native.attribute "id" "field2" ] [ Kit.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." ]) ]
    , M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field2", M3e.TextareaAutosize.maxRows 5 ] []
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.TextareaAutosize.view [ M3e.TextareaAutosize.for "field", M3e.TextareaAutosize.disabled True ] []
```

@docs view, disabled, for, maxRows, minRows

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.TextareaAutosize
import M3e.Node
import M3e.Token


{-| Build the `<m3e-textarea-autosize>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , maxRows : M3e.Token.Supported
            , minRows : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | textareaAutosize : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.TextareaAutosize.textareaAutosize
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether auto-sizing is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.TextareaAutosize.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.TextareaAutosize.for


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows : Float -> M3e.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
maxRows =
    M3e.Html.TextareaAutosize.maxRows


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows : Float -> M3e.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
minRows =
    M3e.Html.TextareaAutosize.minRows
