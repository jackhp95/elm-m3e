module M3e.TextHighlight exposing
    ( MatchMode(..), Option
    , view
    , term, mode, caseSensitive, disabled
    )

{-| `<m3e-text-highlight>` — highlights substrings matching a search term.

Spec (per docs/CONVENTIONS.md):

  - Required:   { content : List (Renderable any msg) }
                (the text content to highlight inside; the type variable `any`
                means the content can include the raw `html` escape)
  - Options:    term, mode, caseSensitive, disabled
  - Slots:      default slot ← arbitrary content (free row; no slot injected)
  - Properties: caseSensitive — via Node.property (Cem uses Html.Attributes.property)
                disabled — via Node.property (Cem uses Html.Attributes.property)
  - Attrs:      term, mode — via Node.rawAttr (Cem uses Html.Attributes.attribute)
  - Escape:     html (default-slot region)
  - Tag:        textHighlight

Note: `m3e-text-highlight` is not in the 53 documented Material 3 components;
it ships as a vendor utility. Included here for parity with the `Ui.*` surface.

-}

import Cem.M3e.TextHighlight as Cem
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


{-| How the term is matched against the content. Default `Contains`.
-}
type MatchMode
    = Contains
    | StartsWith
    | EndsWith


type Option msg
    = Term String
    | ModeOpt MatchMode
    | CaseSensitive Bool
    | Disabled Bool


{-| Set the search term to highlight. No highlighting occurs until this is set.
Maps to the `term` attribute.
-}
term : String -> Option msg
term =
    Term


{-| Set the match mode (default `Contains`). Maps to the `mode` attribute.
-}
mode : MatchMode -> Option msg
mode =
    ModeOpt


{-| Enable case-sensitive matching (default `False`). Maps to the
`case-sensitive` DOM property.
-}
caseSensitive : Bool -> Option msg
caseSensitive =
    CaseSensitive


{-| Disable highlighting entirely — children render unaltered (default `False`).
Maps to the `disabled` DOM property.
-}
disabled : Bool -> Option msg
disabled =
    Disabled


type alias Config =
    { term : Maybe String
    , mode : MatchMode
    , caseSensitive : Bool
    , disabled : Bool
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        Term t ->
            { c | term = Just t }

        ModeOpt m ->
            { c | mode = m }

        CaseSensitive b ->
            { c | caseSensitive = b }

        Disabled b ->
            { c | disabled = b }


view : { content : List (Renderable any msg) } -> List (Option msg) -> Renderable { s | textHighlight : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { term = Nothing
                , mode = Contains
                , caseSensitive = False
                , disabled = False
                }
                opts
    in
    Internal.fromNode
        (Node.element "m3e-text-highlight"
            (List.filterMap identity
                [ Maybe.map (\t -> Node.rawAttr (Cem.term t)) c.term
                , Just (Node.rawAttr (Cem.mode (toCemMode c.mode)))
                , if c.caseSensitive then Just (Node.property "case-sensitive" (Encode.bool True)) else Nothing
                , if c.disabled then Just (Node.property "disabled" (Encode.bool True)) else Nothing
                ]
            )
            (List.map Renderable.toNode req.content)
        )


toCemMode : MatchMode -> Cem.Mode
toCemMode m =
    case m of
        Contains ->
            Cem.Contains

        StartsWith ->
            Cem.StartsWith

        EndsWith ->
            Cem.EndsWith
