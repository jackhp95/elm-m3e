module M3e.TextHighlight exposing
    ( view
    , Option
    , MatchMode
    , term, mode, caseSensitive, disabled
    )

{-| `<m3e-text-highlight>` — highlights substrings matching a search term.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (the text content to highlight inside; the type variable `any`
    means the content can include the raw `html` escape)
  - Options: term, mode, caseSensitive, disabled
  - Slots: default slot ← arbitrary content (free row; no slot injected)
  - Properties: caseSensitive — via Node.property (Cem uses Html.Attributes.property)
    disabled — via Node.property (Cem uses Html.Attributes.property)
  - Attrs: term, mode — via Node.rawAttr (Cem uses Html.Attributes.attribute)
  - Escape: html (default-slot region)
  - Tag: textHighlight

Note: `m3e-text-highlight` is not in the 53 documented Material 3 components;
it ships as a vendor utility. Included here for parity with the `Ui.*` surface.

@docs view
@docs Option
@docs MatchMode
@docs term, mode, caseSensitive, disabled

-}

import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| How the term is matched against the content. Default
[`M3e.Value.contains`](M3e-Value#contains).
-}
type alias MatchMode =
    Value
        { contains : Supported
        , startsWith : Supported
        , endsWith : Supported
        }


{-| An option configuring the `<m3e-text-highlight>` element.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the search term to highlight. No highlighting occurs until this is set.
Maps to the `term` attribute.
-}
term : String -> Option msg
term t =
    Internal.option (\c -> { c | term = Just t })


{-| Set the match mode (default `Contains`). Maps to the `mode` attribute.
-}
mode : MatchMode -> Option msg
mode m =
    Internal.option (\c -> { c | mode = m })


{-| Enable case-sensitive matching (default `False`). Maps to the
`case-sensitive` DOM property.
-}
caseSensitive : Bool -> Option msg
caseSensitive b =
    Internal.option (\c -> { c | caseSensitive = b })


{-| Disable highlighting entirely — children render unaltered (default `False`).
Maps to the `disabled` DOM property.
-}
disabled : Bool -> Option msg
disabled =
    Attr.disabled


type alias Config =
    { term : Maybe String
    , mode : MatchMode
    , caseSensitive : Bool
    , disabled : Bool
    }


{-| Build the `<m3e-text-highlight>` IR node. The `content` renders into the
default slot, with substrings matching the configured `term` highlighted.
-}
view : { content : List (Element any msg) } -> List (Option msg) -> Element { s | textHighlight : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { term = Nothing
                , mode = Value.contains
                , caseSensitive = False
                , disabled = False
                }
    in
    Internal.fromNode
        (Node.element "m3e-text-highlight"
            (List.filterMap identity
                [ Maybe.map (\t -> Node.attribute "term" t) c.term
                , Just (Node.attribute "mode" (Value.toString c.mode))
                , Just (Node.property "caseSensitive" (Encode.bool c.caseSensitive))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                ]
            )
            (List.map Element.toNode req.content)
        )
