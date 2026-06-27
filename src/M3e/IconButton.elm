module M3e.IconButton exposing
    ( Variant(..), Size(..), Shape(..), Width(..), Option
    , view
    , variant, size, shape, width
    , disabled, toggle, onClick, selected
    , href, target, rel, download
    , onChange
    , selectedIcon
    )

{-| `<m3e-icon-button>` — a one-tap icon action (Material 3 Icon buttons).

Spec (per docs/CONVENTIONS.md):

  - Required:   { icon : String, name : String }
                (`name` → `aria-label`; icon-only so no visible-text fallback)
  - Options:    variant, size, shape, width, disabled, toggle, onClick, selected,
                href, target, rel, download, onChange, selectedIcon
  - Slots:      icon (default, the <m3e-icon> child); selected → single icon
  - Properties: selected, disabled, toggle  (DOM properties — introspectable)
  - Attrs:      variant, size, shape, width via rawAttr; href/target/rel/download
                via Node.attribute (introspectable string attrs)
  - Events:     click (onClick), change (onChange for toggle state)
  - Escape:     none (leaf)
  - Tag:        iconButton

-}

import Cem.M3e.IconButton as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal



-- TYPES ------------------------------------------------------------------


type Variant
    = Standard
    | Filled
    | Tonal
    | Outlined


type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


type Shape
    = Round
    | Square


type Width
    = Narrow
    | Default
    | Wide


-- SMART CONSTRUCTORS ----------------------------------------------------


variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


shape : Shape -> Option msg
shape s =
    Internal.option (\c -> { c | shape = Just s })


width : Width -> Option msg
width w =
    Internal.option (\c -> { c | width = w })


disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


toggle : Bool -> Option msg
toggle b =
    Internal.option (\c -> { c | toggle = b })


onClick : msg -> Option msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


selected : Bool -> Option msg
selected b =
    Internal.option (\c -> { c | selected = b })


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


{-| Wire the toggle-state change event. Invoked with the new `selected` Bool
whenever the button dispatches a `change` event.
-}
onChange : (Bool -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Icon to show when the toggle button is selected. Slotted into
`slot="selected"`.
-}
selectedIcon : Renderable { icon : Supported } msg -> Option msg
selectedIcon i =
    Internal.option (\c -> { c | selectedIcon = Just i })



-- CONFIG -----------------------------------------------------------------


type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { variant : Variant
    , size : Size
    , width : Width
    , shape : Maybe Shape
    , disabled : Bool
    , toggle : Bool
    , onClick : Maybe msg
    , selected : Bool
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , onChange : Maybe (Bool -> msg)
    , selectedIcon : Maybe (Renderable { icon : Supported } msg)
    }


defaults : Config msg
defaults =
    { variant = Standard
    , size = Small
    , width = Default
    , shape = Nothing
    , disabled = False
    , toggle = False
    , onClick = Nothing
    , selected = False
    , href = Nothing
    , target = Nothing
    , rel = Nothing
    , download = Nothing
    , onChange = Nothing
    , selectedIcon = Nothing
    }


-- VIEW -------------------------------------------------------------------


view : { icon : String, name : String } -> List (Option msg) -> Renderable { s | iconButton : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaults
    in
    Internal.fromNode
        (Node.element "m3e-icon-button"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.rawAttr (Cem.variant (toCemVariant c.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , Just (Node.rawAttr (Cem.width (toCemWidth c.width)))
                , Maybe.map (\s -> Node.rawAttr (Cem.shape (toCemShape s))) c.shape
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.toggle then
                    Just (Node.property "toggle" (Encode.bool True))

                  else
                    Nothing
                , if c.selected then
                    Just (Node.property "selected" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (Node.attribute "href") c.href
                , Maybe.map (Node.attribute "target") c.target
                , Maybe.map (Node.attribute "rel") c.rel
                , Maybe.map (Node.attribute "download") c.download
                , Maybe.map
                    (\f ->
                        Node.on "change"
                            (Decode.at [ "target", "selected" ] Decode.bool
                                |> Decode.map f
                            )
                    )
                    c.onChange
                ]
            )
            (List.filterMap identity
                [ Just (Node.element "m3e-icon" [ Node.attribute "name" req.icon ] [])
                , Maybe.map (\i -> Node.withSlot "selected" (Renderable.toNode i)) c.selectedIcon
                ]
            )
        )



-- CONVERTERS ------------------------------------------------------------


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Standard ->
            Cem.Standard

        Filled ->
            Cem.Filled

        Tonal ->
            Cem.Tonal

        Outlined ->
            Cem.Outlined


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
        Round ->
            Cem.Rounded

        Square ->
            Cem.Square


toCemWidth : Width -> Cem.Width
toCemWidth w =
    case w of
        Narrow ->
            Cem.Narrow

        Default ->
            Cem.Default

        Wide ->
            Cem.Wide
