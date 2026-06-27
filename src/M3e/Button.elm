module M3e.Button exposing
    ( Variant(..), Size(..), Shape(..), Option
    , view
    , size, shape, disabled, onClick, href, target, rel, download
    , leadingIcon, trailingIcon
    )

{-| `<m3e-button>` — a labeled action button (Material 3 Buttons, 1:1).

Spec (per docs/CONVENTIONS.md):

  - Required:   { label : String, variant : Variant }  (label is visible -> it IS
                the accessible name; no separate a11y field)
  - Options:    size, shape, disabled, onClick, href(+target/rel/download),
                leadingIcon, trailingIcon
  - Slots:      icon -> single M3e.Icon (slot "icon"); trailing-icon likewise
  - Properties: disabled (DOM property -> introspectable/testable)
  - Attrs:      variant/size/shape/href/... via Cem.M3e.Button.* as RawAttr
                (codegen name+enum safety; opaque, which is fine — no parent
                introspects them)
  - Escape:     none (leaf)
  - Tag:        m3e-button

Action wiring (`onClick`/`href`) is last-write-wins options, not a required sum
field — a button with no action is degenerate-but-valid (caught by a review rule,
per ADR 0006 / the prior NoActionlessButton design).
-}

import Cem.M3e.Button as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


type Variant
    = Elevated
    | Filled
    | Tonal
    | Outlined
    | Text


type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


type Shape
    = Rounded
    | Square


type alias Option msg =
    Internal.Option (Config msg) msg


size : Size -> Option msg
size v =
    Internal.option (\c -> { c | size = v })


shape : Shape -> Option msg
shape v =
    Internal.option (\c -> { c | shape = Just v })


disabled : Bool -> Option msg
disabled v =
    Internal.option (\c -> { c | disabled = v })


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


leadingIcon : Renderable { icon : Supported } msg -> Option msg
leadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


trailingIcon : Renderable { icon : Supported } msg -> Option msg
trailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })


type alias Config msg =
    { size : Size
    , shape : Maybe Shape
    , disabled : Bool
    , onClick : Maybe msg
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    }


view : { label : String, variant : Variant } -> List (Option msg) -> Renderable { s | button : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { size = Small, shape = Nothing, disabled = False, onClick = Nothing
                , href = Nothing, target = Nothing, rel = Nothing, download = Nothing
                , leadingIcon = Nothing, trailingIcon = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-button"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.variant (toCemVariant req.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , Maybe.map (\v -> Node.rawAttr (Cem.shape (toCemShape v))) c.shape
                , if c.disabled then Just (Node.property "disabled" (Encode.bool True)) else Nothing
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "icon" (Renderable.toNode i)) c.leadingIcon
                , Just (Node.text req.label)
                , Maybe.map (\i -> Node.withSlot "trailing-icon" (Renderable.toNode i)) c.trailingIcon
                ]
            )
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Elevated -> Cem.Elevated
        Filled -> Cem.Filled
        Tonal -> Cem.Tonal
        Outlined -> Cem.Outlined
        Text -> Cem.Text


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        ExtraSmall -> Cem.ExtraSmall
        Small -> Cem.Small
        Medium -> Cem.Medium
        Large -> Cem.Large
        ExtraLarge -> Cem.ExtraLarge


toCemShape : Shape -> Cem.Shape
toCemShape s =
    case s of
        Rounded -> Cem.Rounded
        Square -> Cem.Square
