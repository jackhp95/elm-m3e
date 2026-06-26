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


type Option msg
    = Variant_ Variant
    | Size_ Size
    | Shape_ Shape
    | Width_ Width
    | Disabled Bool
    | Toggle Bool
    | OnClick msg
    | Selected Bool
    | Href String
    | Target String
    | Rel String
    | Download String
    | OnChange (Bool -> msg)
    | SelectedIcon (Renderable { icon : Supported } msg)



-- SMART CONSTRUCTORS ----------------------------------------------------


variant : Variant -> Option msg
variant =
    Variant_


size : Size -> Option msg
size =
    Size_


shape : Shape -> Option msg
shape =
    Shape_


width : Width -> Option msg
width =
    Width_


disabled : Bool -> Option msg
disabled =
    Disabled


toggle : Bool -> Option msg
toggle =
    Toggle


onClick : msg -> Option msg
onClick =
    OnClick


selected : Bool -> Option msg
selected =
    Selected


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


{-| Wire the toggle-state change event. Invoked with the new `selected` Bool
whenever the button dispatches a `change` event.
-}
onChange : (Bool -> msg) -> Option msg
onChange =
    OnChange


{-| Icon to show when the toggle button is selected. Slotted into
`slot="selected"`.
-}
selectedIcon : Renderable { icon : Supported } msg -> Option msg
selectedIcon =
    SelectedIcon



-- CONFIG -----------------------------------------------------------------


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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        Variant_ v ->
            { c | variant = v }

        Size_ s ->
            { c | size = s }

        Shape_ s ->
            { c | shape = Just s }

        Width_ w ->
            { c | width = w }

        Disabled b ->
            { c | disabled = b }

        Toggle b ->
            { c | toggle = b }

        OnClick m ->
            { c | onClick = Just m }

        Selected b ->
            { c | selected = b }

        Href v ->
            { c | href = Just v }

        Target v ->
            { c | target = Just v }

        Rel v ->
            { c | rel = Just v }

        Download v ->
            { c | download = Just v }

        OnChange f ->
            { c | onChange = Just f }

        SelectedIcon i ->
            { c | selectedIcon = Just i }



-- VIEW -------------------------------------------------------------------


view : { icon : String, name : String } -> List (Option msg) -> Renderable { s | iconButton : Supported } msg
view req opts =
    let
        c =
            List.foldl apply defaults opts
    in
    Renderable.fromNode
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
