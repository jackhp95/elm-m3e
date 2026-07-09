module M3e.TextHighlight exposing
    ( view, caseSensitive, disabled, mode, term, onHighlight
    )

{-|
Highlights text which matches a given search term.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `highlight`: Dispatched when content is highlighted.

@docs view, caseSensitive, disabled, mode, term, onHighlight
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.TextHighlight
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-text-highlight>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { caseSensitive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , term : M3e.Value.Supported
    , onHighlight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | textHighlight : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TextHighlight.textHighlight
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.TextHighlight.caseSensitive


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.TextHighlight.disabled


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.TextHighlight.mode


{-| The term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.TextHighlight.term


{-| Listen for `highlight` events. -}
onHighlight :
    msg -> M3e.Cem.Attr.Attr { c | onHighlight : M3e.Value.Supported } msg
onHighlight =
    M3e.Cem.TextHighlight.onHighlight