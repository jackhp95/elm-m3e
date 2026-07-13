module M3e.TextHighlight exposing (view, caseSensitive, disabled, mode, term, onHighlight)

{-| Highlights text which matches a given search term.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `highlight`: Dispatched when content is highlighted.

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Highlight a term" -->
```elm
M3e.TextHighlight.view [ M3e.TextHighlight.term "trail" ] [ Kit.text "Discover the top ten hiking trails. Every trail on the list has a difficulty rating and each trail entry links to a map." ]
```

@docs view, caseSensitive, disabled, mode, term, onHighlight

-}

import M3e.Html.TextHighlight
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-text-highlight>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { caseSensitive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , term : M3e.Token.Supported
            , onHighlight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | textHighlight : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.TextHighlight.textHighlight
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether matching is case sensitive. (default: `false`)
-}
caseSensitive :
    Bool
    -> Markup.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
caseSensitive =
    M3e.Html.TextHighlight.caseSensitive


{-| A value indicating whether text highlighting is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.TextHighlight.disabled


{-| The mode in which to highlight text. (default: `"contains"`)
-}
mode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.TextHighlight.mode


{-| The term to highlight. (default: `""`)
-}
term : String -> Markup.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    M3e.Html.TextHighlight.term


{-| Listen for `highlight` events.
-}
onHighlight : msg -> Markup.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight =
    M3e.Html.TextHighlight.onHighlight
