module M3e.ExtendedFab exposing
    ( view
    , Option, Size(..), Variant(..)
    , size, lowered, disabled, onClick, href, target, rel, download
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

@docs view
@docs Option, Size, Variant
@docs size, lowered, disabled, onClick, href, target, rel, download

-}

import Cem.M3e.Fab as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element as Element exposing (Element, Supported)
import M3e.Icon as Icon
import M3e.Internal as Internal
import M3e.Node as Node


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


{-| Configuration option for `view`.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the FAB size (`Small`, `Medium`, `Large`). Default `Medium`.
-}
size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


{-| Use the lowered (less-elevated) style. Default `False`.
-}
lowered : Bool -> Option msg
lowered b =
    Internal.option (\c -> { c | lowered = b })


{-| Disable the FAB. Default `False`.
-}
disabled : Bool -> Option msg
disabled =
    Attr.disabled


{-| Wire a click handler.
-}
onClick : msg -> Option msg
onClick =
    Attr.onClick


{-| Render the FAB as a link to the given URL.
-}
href : String -> Option msg
href =
    Attr.href


{-| Set the `target` for a link FAB (used with `href`).
-}
target : String -> Option msg
target =
    Attr.target


{-| Set the `rel` for a link FAB (used with `href`).
-}
rel : String -> Option msg
rel =
    Attr.rel


{-| Set the `download` for a link FAB (used with `href`).
-}
download : String -> Option msg
download =
    Attr.download


{-| Render the extended FAB with its required `icon`, `label`, and `variant`.
-}
view :
    { icon : String, label : String, variant : Variant }
    -> List (Option msg)
    -> Element { s | extendedFab : Supported } msg
view req opts =
    let
        c : Config msg
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
                , Just (Node.property "lowered" (Encode.bool c.lowered))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                ]
            )
            [ Element.toNode (Icon.view { name = req.icon } [])
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
