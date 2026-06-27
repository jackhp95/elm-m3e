module M3e.Fab exposing
    ( Variant(..), Size(..), Option
    , view
    , variant, size, lowered, disabled, onClick, href, target, rel, download, label
    )

{-| `<m3e-fab>` — a floating action button for the primary action on a screen.

Spec (per docs/CONVENTIONS.md):

  - Required:   { icon : String, name : String }
                (icon = glyph name; name = a11y label — FAB is icon-only with no
                visible text, so a required aria-label is mandatory)
  - Options:    variant, size, lowered, disabled, onClick, href(+target/rel/download),
                label (extended-FAB visible text → sets `extended` property + slot "label")
  - Slots:      default slot ← `<m3e-icon>` for the glyph;
                "label" slot ← a span carrying the extended-FAB label text
  - Properties: disabled, lowered, extended (all via Node.property — introspectable/testable)
  - Attrs:      variant/size via Cem.M3e.Fab.* wrapped in Node.rawAttr
                (codegen name+enum safety; opaque, which is fine — no parent introspects them)
  - Events:     click
  - A11y:       aria-label = name (required; m3e aria-hides its icon slot)
  - Tag:        m3e-fab

-}

import Cem.M3e.Fab as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Icon as Icon
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


{-| FAB variant — seven M3 color roles. Default `PrimaryContainer`.
-}
type Variant
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Tertiary
    | TertiaryContainer
    | Surface


{-| FAB size. Default `Medium`.
-}
type Size
    = Small
    | Medium
    | Large


type alias Config msg =
    { variant : Variant
    , size : Size
    , lowered : Bool
    , disabled : Bool
    , onClick : Maybe msg
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , label : Maybe String
    }


type alias Option msg =
    Internal.Option (Config msg) msg


variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


lowered : Bool -> Option msg
lowered b =
    Internal.option (\c -> { c | lowered = b })


disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


onClick : msg -> Option msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


href : String -> Option msg
href v =
    Internal.option (\c -> { c | href = Just v })


target : String -> Option msg
target v =
    Internal.option (\c -> { c | target = Just v })


rel : String -> Option msg
rel v =
    Internal.option (\c -> { c | rel = Just v })


download : String -> Option msg
download v =
    Internal.option (\c -> { c | download = Just v })


{-| Visible label for an extended FAB. Setting this option also sets the
`extended` property on the element so it expands to show the label.
-}
label : String -> Option msg
label v =
    Internal.option (\c -> { c | label = Just v })


view : { icon : String, name : String } -> List (Option msg) -> Renderable { s | fab : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { variant = PrimaryContainer
                , size = Medium
                , lowered = False
                , disabled = False
                , onClick = Nothing
                , href = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                , label = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-fab"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.rawAttr (Cem.variant (toCemVariant c.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , if c.lowered then Just (Node.property "lowered" (Encode.bool True)) else Nothing
                , if c.disabled then Just (Node.property "disabled" (Encode.bool True)) else Nothing
                , if c.label /= Nothing then Just (Node.property "extended" (Encode.bool True)) else Nothing
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                ]
            )
            (List.filterMap identity
                [ Just (Renderable.toNode (Icon.view { name = req.icon }))
                , Maybe.map (\lbl -> Node.withSlot "label" (Node.element "span" [] [ Node.text lbl ])) c.label
                ]
            )
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Primary ->
            Cem.Primary

        PrimaryContainer ->
            Cem.PrimaryContainer

        Secondary ->
            Cem.Secondary

        SecondaryContainer ->
            Cem.SecondaryContainer

        Tertiary ->
            Cem.Tertiary

        TertiaryContainer ->
            Cem.TertiaryContainer

        Surface ->
            Cem.Surface


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large
