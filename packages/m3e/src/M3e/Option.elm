module M3e.Option exposing
    ( view, disabled, disableHighlight, highlightMode, selected, term
    , value
    )

{-|
An option that can be selected.

<!-- elm-cem:docmeta category=Selection -->

## Examples

### Examples

<!-- elm-cem:example title="Option panel with search-term highlighting" -->
```elm
M3e.OptionPanel.view [ M3e.OptionPanel.state M3e.Value.content, M3e.OptionPanel.scrollStrategy M3e.Value.reposition ] (M3e.OptionPanel.children [ M3e.Option.view { content = Kit.text "React" } [ M3e.Option.value "react", M3e.Option.term "re", M3e.Option.highlightMode M3e.Value.startsWith ] [], M3e.Option.view { content = Kit.text "Redux" } [ M3e.Option.value "redux", M3e.Option.term "re", M3e.Option.highlightMode M3e.Value.startsWith ] [], M3e.Option.view { content = Kit.text "Remix" } [ M3e.Option.value "remix", M3e.Option.term "re", M3e.Option.highlightMode M3e.Value.startsWith ] [] ])
```

@docs view, disabled, disableHighlight, highlightMode, selected, term
@docs value
-}


import M3e.Cem.Attr
import M3e.Cem.Option
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-option>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHighlight : M3e.Value.Supported
    , highlightMode : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , term : M3e.Value.Supported
    , value : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | option : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Option.option (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.append
                  [ M3e.Element.toNode req_.content ]
                  (List.map M3e.Content.toNode content_)
             )
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Option.disabled


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool -> M3e.Cem.Attr.Attr { c | disableHighlight : M3e.Value.Supported } msg
disableHighlight =
    M3e.Cem.Option.disableHighlight


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightMode =
    M3e.Cem.Option.highlightMode


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Option.selected


{-| The search term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.Option.term


{-| A string representing the value of the option. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Option.value