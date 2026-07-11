module M3e.Record.Option exposing
    ( view, disabled, disableHighlight, highlightMode, selected, term
    , value
    )

{-| An option that can be selected.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, disabled, disableHighlight, highlightMode, selected, term
@docs value

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Option
import M3e.Node
import M3e.Token


{-| Build the `<m3e-option>` element (lazy IR).
-}
view :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disableHighlight : M3e.Token.Supported
                , highlightMode : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , term : M3e.Token.Supported
                , value : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | option : M3e.Token.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Option.option
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Element.toNode content_)
            )
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Option.disabled


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight :
    Bool
    -> M3e.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
disableHighlight =
    M3e.Html.Option.disableHighlight


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightMode =
    M3e.Html.Option.highlightMode


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Option.selected


{-| The search term to highlight. (default: `""`)
-}
term : String -> M3e.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    M3e.Html.Option.term


{-| A string representing the value of the option.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Option.value
