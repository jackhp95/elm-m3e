module M3e.ExtendedFab exposing
    ( Option
    , Size(..)
    , Variant(..)
    , disabled
    , download
    , href
    , lowered
    , onClick
    , rel
    , size
    , target
    , view
    )

{-| `<m3e-fab>` with `extended = True` — a floating action button with a
**visible label** (Material 3 Extended FAB).

Spec (per docs/CONVENTIONS.md):

  - Required: { icon : String, label : String, variant : Variant }
    (label is always visible → it IS the accessible name;
    no separate a11y field needed)
  - Options: size, lowered, disabled, onClick, href(+target/rel/download)
  - Slots: default slot ← `<m3e-icon>` for the glyph;
    "label" slot ← a `<span>` carrying the visible label text
  - Properties: extended (always True), disabled, lowered (all Node.property)
  - Attrs: variant/size via Cem.M3e.Fab.\* as rawAttr
  - Events: click
  - A11y: label is visible text — no aria-label required
  - Tag: extendedFab

-}

import Cem.M3e.Fab as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Icon as Icon
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


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
    { size : Size
    , lowered : Bool
    , disabled : Bool
    , onClick : Maybe msg
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    }


type alias Option msg =
    Internal.Option (Config msg) msg


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


view :
    { icon : String, label : String, variant : Variant }
    -> List (Option msg)
    -> Renderable { s | extendedFab : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { size = Medium
                , lowered = False
                , disabled = False
                , onClick = Nothing
                , href = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-fab"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.variant (toCemVariant req.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , Just (Node.property "extended" (Encode.bool True))
                , if c.lowered then
                    Just (Node.property "lowered" (Encode.bool True))

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                ]
            )
            [ Renderable.toNode (Icon.view { name = req.icon })
            , Node.withSlot "label" (Node.element "span" [] [ Node.text req.label ])
            ]
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
