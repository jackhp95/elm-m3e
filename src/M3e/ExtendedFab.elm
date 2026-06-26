module M3e.ExtendedFab exposing
    ( Variant(..), Size(..), Option
    , view
    , size, lowered, disabled, onClick, href, target, rel, download
    )

{-| `<m3e-fab>` with `extended = True` — a floating action button with a
**visible label** (Material 3 Extended FAB).

Spec (per docs/CONVENTIONS.md):

  - Required:   { icon : String, label : String, variant : Variant }
               (label is always visible → it IS the accessible name;
               no separate a11y field needed)
  - Options:    size, lowered, disabled, onClick, href(+target/rel/download)
  - Slots:      default slot ← `<m3e-icon>` for the glyph;
               "label" slot ← a `<span>` carrying the visible label text
  - Properties: extended (always True), disabled, lowered (all Node.property)
  - Attrs:      variant/size via Cem.M3e.Fab.* as rawAttr
  - Events:     click
  - A11y:       label is visible text — no aria-label required
  - Tag:        extendedFab

-}

import Cem.M3e.Fab as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Icon as Icon
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| FAB variant — seven M3 color roles. Default `PrimaryContainer`. -}
type Variant
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Tertiary
    | TertiaryContainer
    | Surface


{-| FAB size. Default `Medium`. -}
type Size
    = Small
    | Medium
    | Large


type Option msg
    = SizeOpt Size
    | Lowered Bool
    | Disabled Bool
    | OnClick msg
    | Href String
    | Target String
    | Rel String
    | Download String


size : Size -> Option msg
size =
    SizeOpt


lowered : Bool -> Option msg
lowered =
    Lowered


disabled : Bool -> Option msg
disabled =
    Disabled


onClick : msg -> Option msg
onClick =
    OnClick


href : String -> Option msg
href =
    Href


target : String -> Option msg
target =
    Target


rel : String -> Option msg
rel =
    Rel


download : String -> Option msg
download =
    Download


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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        SizeOpt s ->
            { c | size = s }

        Lowered b ->
            { c | lowered = b }

        Disabled b ->
            { c | disabled = b }

        OnClick m ->
            { c | onClick = Just m }

        Href v ->
            { c | href = Just v }

        Target v ->
            { c | target = Just v }

        Rel v ->
            { c | rel = Just v }

        Download v ->
            { c | download = Just v }


view :
    { icon : String, label : String, variant : Variant }
    -> List (Option msg)
    -> Renderable { s | extendedFab : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { size = Medium
                , lowered = False
                , disabled = False
                , onClick = Nothing
                , href = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                }
                opts
    in
    Renderable.fromNode
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
