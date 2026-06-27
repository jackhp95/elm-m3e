module M3e.Button exposing
    ( Option, Variant(..), Size(..), Shape(..)
    , view
    , size, shape, disabled, onClick, href, target, rel, download, leadingIcon, trailingIcon
    )

{-| `<m3e-button>` — a labeled action button (Material 3 Buttons, 1:1).

Spec (per docs/CONVENTIONS.md):

  - Required: { label : String, variant : Variant } (label is visible -> it IS
    the accessible name; no separate a11y field)
  - Options: size, shape, disabled, onClick, href(+target/rel/download),
    leadingIcon, trailingIcon
  - Slots: icon -> single M3e.Icon (slot "icon"); trailing-icon likewise
  - Properties: disabled (DOM property -> introspectable/testable)
  - Attrs: variant/size/shape/href/... via Cem.M3e.Button.\* as RawAttr
    (codegen name+enum safety; opaque, which is fine — no parent
    introspects them)
  - Escape: none (leaf)
  - Tag: m3e-button

Action wiring (`onClick`/`href`) is last-write-wins options, not a required sum
field — a button with no action is degenerate-but-valid (caught by a review rule,
per ADR 0006 / the prior NoActionlessButton design).


# Types

@docs Option, Variant, Size, Shape

@docs view


# Options

@docs size, shape, disabled, onClick, href, target, rel, download, leadingIcon, trailingIcon

-}

import Cem.M3e.Button as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Button style — `Elevated`, `Filled`, `Tonal`, `Outlined`, or `Text`.
Supplied as a required field of [`view`](#view).
-}
type Variant
    = Elevated
    | Filled
    | Tonal
    | Outlined
    | Text


{-| Button size, from `ExtraSmall` to `ExtraLarge` (default `Small`).
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Button corner shape — `Rounded` or `Square`.
-}
type Shape
    = Rounded
    | Square


{-| A button configuration option. Build with the option functions below and
pass a list to [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the button size (default `Small`).
-}
size : Size -> Option msg
size v =
    Internal.option (\c -> { c | size = v })


{-| Set the button corner shape.
-}
shape : Shape -> Option msg
shape v =
    Internal.option (\c -> { c | shape = Just v })


{-| Disable the button (sets the `disabled` DOM property).
-}
disabled : Bool -> Option msg
disabled v =
    Internal.option (\c -> { c | disabled = v })


{-| Wire a click handler for the button.
-}
onClick : msg -> Option msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Render the button as a link to the given URL.
-}
href : String -> Option msg
href v =
    Internal.option (\c -> { c | href = Just v })


{-| Set the link `target` (e.g. `"_blank"`); only meaningful with [`href`](#href).
-}
target : String -> Option msg
target v =
    Internal.option (\c -> { c | target = Just v })


{-| Set the link `rel` (e.g. `"noreferrer noopener"`); only meaningful with [`href`](#href).
-}
rel : String -> Option msg
rel v =
    Internal.option (\c -> { c | rel = Just v })


{-| Request the link target be downloaded; only meaningful with [`href`](#href).
-}
download : String -> Option msg
download v =
    Internal.option (\c -> { c | download = Just v })


{-| Place an icon in the `icon` slot, before the label.
-}
leadingIcon : Element { icon : Supported } msg -> Option msg
leadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Place an icon in the `trailing-icon` slot, after the label.
-}
trailingIcon : Element { icon : Supported } msg -> Option msg
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
    , leadingIcon : Maybe (Element { icon : Supported } msg)
    , trailingIcon : Maybe (Element { icon : Supported } msg)
    }


{-| Render the button. The required `label` is the visible text and the
accessible name; `variant` selects the M3 button style.
-}
view : { label : String, variant : Variant } -> List (Option msg) -> Element { s | button : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { size = Small
                , shape = Nothing
                , disabled = False
                , onClick = Nothing
                , href = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                , leadingIcon = Nothing
                , trailingIcon = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-button"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.variant (toCemVariant req.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , Maybe.map (\v -> Node.rawAttr (Cem.shape (toCemShape v))) c.shape
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "icon" (Element.toNode i)) c.leadingIcon
                , Just (Node.text req.label)
                , Maybe.map (\i -> Node.withSlot "trailing-icon" (Element.toNode i)) c.trailingIcon
                ]
            )
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Elevated ->
            Cem.Elevated

        Filled ->
            Cem.Filled

        Tonal ->
            Cem.Tonal

        Outlined ->
            Cem.Outlined

        Text ->
            Cem.Text


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        ExtraSmall ->
            Cem.ExtraSmall

        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large

        ExtraLarge ->
            Cem.ExtraLarge


toCemShape : Shape -> Cem.Shape
toCemShape s =
    case s of
        Rounded ->
            Cem.Rounded

        Square ->
            Cem.Square
