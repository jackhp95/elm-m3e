module M3e.IconButton exposing
    ( view
    , Option
    , Variant(..), Size(..), Shape(..), Width(..)
    , variant, size, shape, width
    , disabled, toggle, selected, onClick, onChange
    , href, target, rel, download
    , selectedIcon, extraContent
    )

{-| `<m3e-icon-button>` — a one-tap icon action (Material 3 Icon buttons).

Spec (per docs/CONVENTIONS.md):

  - Required: { icon : String, name : String }
    (`name` → `aria-label`; icon-only so no visible-text fallback)
  - Options: variant, size, shape, width, disabled, toggle, onClick, selected,
    href, target, rel, download, onChange, selectedIcon
  - Slots: icon (default, the <m3e-icon> child); selected → single icon
  - Properties: selected, disabled, toggle (DOM properties — introspectable)
  - Attrs: variant, size, shape, width via rawAttr; href/target/rel/download
    via Node.attribute (introspectable string attrs)
  - Events: click (onClick), change (onChange for toggle state)
  - Escape: none (leaf)
  - Tag: iconButton

@docs view
@docs Option
@docs Variant, Size, Shape, Width
@docs variant, size, shape, width
@docs disabled, toggle, selected, onClick, onChange
@docs href, target, rel, download
@docs selectedIcon, extraContent

-}

import Cem.M3e.IconButton as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES ------------------------------------------------------------------


{-| Visual style of the icon button: `Standard` (default), `Filled`, `Tonal`,
or `Outlined`.
-}
type Variant
    = Standard
    | Filled
    | Tonal
    | Outlined


{-| Touch-target size of the icon button, from `ExtraSmall` to `ExtraLarge`.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Container shape: `Round` (pill) or `Square`.
-}
type Shape
    = Round
    | Square


{-| Container width: `Narrow`, `Default`, or `Wide`.
-}
type Width
    = Narrow
    | Default
    | Wide



-- SMART CONSTRUCTORS ----------------------------------------------------


{-| Set the visual variant. Default `Standard`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Set the touch-target size. Default `Small`.
-}
size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


{-| Set the container shape (`Round` or `Square`).
-}
shape : Shape -> Option msg
shape s =
    Internal.option (\c -> { c | shape = Just s })


{-| Set the container width. Default `Default`.
-}
width : Width -> Option msg
width w =
    Internal.option (\c -> { c | width = w })


{-| Disable the button (the `disabled` DOM property).
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Make the button a toggle (the `toggle` DOM property), so taps flip its
`selected` state.
-}
toggle : Bool -> Option msg
toggle b =
    Internal.option (\c -> { c | toggle = b })


{-| Fire a message when the button is clicked.
-}
onClick : msg -> Option msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Mark a toggle button as selected (the `selected` DOM property).
-}
selected : Bool -> Option msg
selected b =
    Internal.option (\c -> { c | selected = b })


{-| Render the button as a link by setting its `href`.
-}
href : String -> Option msg
href v =
    Internal.option (\c -> { c | href = Just v })


{-| Set the link `target` (used with `href`).
-}
target : String -> Option msg
target v =
    Internal.option (\c -> { c | target = Just v })


{-| Set the link `rel` (used with `href`).
-}
rel : String -> Option msg
rel v =
    Internal.option (\c -> { c | rel = Just v })


{-| Set the link `download` attribute (used with `href`).
-}
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
selectedIcon : Element { icon : Supported } msg -> Option msg
selectedIcon i =
    Internal.option (\c -> { c | selectedIcon = Just i })


{-| Project extra children into the button's default slot, alongside the icon.
The intended use is a slot-ready marker such as `M3e.Menu.triggerFor "my-menu"`,
which makes the icon button open a menu (open/close is element-managed).
-}
extraContent : List (Element any msg) -> Option msg
extraContent items =
    Internal.option (\c -> { c | extraContent = c.extraContent ++ List.map Element.toNode items })



-- CONFIG -----------------------------------------------------------------


{-| A configuration option for an icon button, produced by the smart
constructors above and passed to [`view`](#view).
-}
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
    , selectedIcon : Maybe (Element { icon : Supported } msg)
    , extraContent : List (Node msg)
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
    , extraContent = []
    }



-- VIEW -------------------------------------------------------------------


{-| Render an `<m3e-icon-button>`. `icon` is the Material Symbols glyph name and
`name` becomes the `aria-label` (the button is icon-only, so it has no visible
text fallback).

    M3e.IconButton.view { icon = "settings", name = "Settings" }
        [ M3e.IconButton.variant M3e.IconButton.Filled
        , M3e.IconButton.onClick OpenSettings
        ]

-}
view : { icon : String, name : String } -> List (Option msg) -> Element { s | iconButton : Supported } msg
view req opts =
    let
        c : Config msg
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
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "toggle" (Encode.bool c.toggle))
                , Just (Node.property "selected" (Encode.bool c.selected))
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
                , Maybe.map (\i -> Node.withSlot "selected" (Element.toNode i)) c.selectedIcon
                ]
                ++ c.extraContent
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
