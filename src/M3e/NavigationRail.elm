module M3e.NavigationRail exposing
    ( Mode(..)
    , ItemOption, Option
    , view, item
    , itemSelected, itemOnClick, itemLabel, itemBadge, itemSelectedIcon, itemDisabled, itemHref
    , withId, mode
    )

{-| `<m3e-nav-rail>` + `<m3e-nav-item>` — side-anchored primary navigation for
medium-width viewports (Material 3 Navigation rail).

Spec (per docs/CONVENTIONS.md):

  - Required (item): `{ icon }` — the destination glyph
  - Required (container): `{ items }` — the destination list
  - Options (item): selected, onClick, label, badge, selectedIcon, disabled, href
  - Options (container): id, mode
  - Slots (item): icon (leading glyph), selected-icon (active glyph)
  - Properties: selected (item; DOM property), disabled (item; DOM property)
  - Events: click (item)
  - Tag: navRail / navItem

Items are the same `<m3e-nav-item>` element used by `M3e.NavigationBar`;
`navItem` is a shared kind tag. Selection state is fully Elm-controlled.

-}

import Cem.M3e.NavRail as CemNavRail
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


-- TYPES -------------------------------------------------------------------


{-| How items are laid out. `Compact` (icon only) is the m3e default; `Expanded`
always shows labels; `Auto` switches based on available width.
-}
type Mode
    = Compact
    | Expanded
    | Auto


-- OPTION TYPES ------------------------------------------------------------


type ItemOption msg
    = ItemSelected Bool
    | ItemOnClick msg
    | ItemLabel String
    | ItemBadge String
    | ItemSelectedIcon (Renderable { icon : Supported } msg)
    | ItemDisabled Bool
    | ItemHref String


type Option msg
    = WithId String
    | ModeOpt Mode


-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Mark this item as selected (the `selected` DOM property on
`<m3e-nav-item>`). -}
itemSelected : Bool -> ItemOption msg
itemSelected =
    ItemSelected


{-| Fire a message when this destination is chosen. -}
itemOnClick : msg -> ItemOption msg
itemOnClick =
    ItemOnClick


{-| Set the visible label text (goes in the default slot). -}
itemLabel : String -> ItemOption msg
itemLabel =
    ItemLabel


{-| Attach a badge count to the item. Rendered as an `<m3e-badge>` inside the
item's default slot. -}
itemBadge : String -> ItemOption msg
itemBadge =
    ItemBadge


{-| Give the item a distinct glyph for its selected state (the `selected-icon`
slot). Shown in place of the regular icon while the item is selected. -}
itemSelectedIcon : Renderable { icon : Supported } msg -> ItemOption msg
itemSelectedIcon =
    ItemSelectedIcon


{-| Disable this destination. -}
itemDisabled : Bool -> ItemOption msg
itemDisabled =
    ItemDisabled


{-| Make this destination a link (the `href` attribute). -}
itemHref : String -> ItemOption msg
itemHref =
    ItemHref


{-| Set the `id` attribute on the `<m3e-nav-rail>` element. -}
withId : String -> Option msg
withId =
    WithId


{-| Set the display mode of the rail. Default `Auto`. -}
mode : Mode -> Option msg
mode =
    ModeOpt


-- ITEM CONSTRUCTOR --------------------------------------------------------


{-| Construct a navigation rail destination (`<m3e-nav-item>`).

    M3e.NavigationRail.item { icon = homeIcon }
        [ M3e.NavigationRail.itemLabel "Home"
        , M3e.NavigationRail.itemSelected (model.page == Home)
        , M3e.NavigationRail.itemOnClick (Navigate Home)
        ]

-}
item :
    { icon : Renderable { icon : Supported } msg }
    -> List (ItemOption msg)
    -> Renderable { navItem : Supported } msg
item req opts =
    let
        c =
            List.foldl applyItem defaultItemConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-nav-item"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool c.selected))
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (Node.attribute "href") c.href
                , Maybe.map (\msg -> Node.on "click" (Decode.succeed msg)) c.onClick
                ]
            )
            (List.filterMap identity
                [ Just (Node.withSlot "icon" (Renderable.toNode req.icon))
                , Maybe.map (\si -> Node.withSlot "selected-icon" (Renderable.toNode si)) c.selectedIcon
                , Maybe.map Node.text c.label
                , Maybe.map (\b -> Node.element "m3e-badge" [] [ Node.text b ]) c.badge
                ]
            )
        )


-- CONTAINER ---------------------------------------------------------------


{-| Render the navigation rail.

    M3e.NavigationRail.view
        { items =
            [ M3e.NavigationRail.item { icon = homeIcon }
                [ M3e.NavigationRail.itemLabel "Home"
                , M3e.NavigationRail.itemSelected (model.page == Home)
                , M3e.NavigationRail.itemOnClick (Navigate Home)
                ]
            ]
        }
        []

-}
view :
    { items : List (Renderable { navItem : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | navRail : Supported } msg
view req opts =
    let
        c =
            List.foldl applyOption defaultConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-nav-rail"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemNavRail.mode (toCemMode c.mode)))
                ]
            )
            (List.map Renderable.toNode req.items)
        )


-- INTERNAL ----------------------------------------------------------------


type alias ItemConfig msg =
    { selected : Bool
    , onClick : Maybe msg
    , label : Maybe String
    , badge : Maybe String
    , selectedIcon : Maybe (Renderable { icon : Supported } msg)
    , disabled : Bool
    , href : Maybe String
    }


defaultItemConfig : ItemConfig msg
defaultItemConfig =
    { selected = False
    , onClick = Nothing
    , label = Nothing
    , badge = Nothing
    , selectedIcon = Nothing
    , disabled = False
    , href = Nothing
    }


applyItem : ItemOption msg -> ItemConfig msg -> ItemConfig msg
applyItem opt c =
    case opt of
        ItemSelected b ->
            { c | selected = b }

        ItemOnClick msg ->
            { c | onClick = Just msg }

        ItemLabel s ->
            { c | label = Just s }

        ItemBadge s ->
            { c | badge = Just s }

        ItemSelectedIcon r ->
            { c | selectedIcon = Just r }

        ItemDisabled b ->
            { c | disabled = b }

        ItemHref s ->
            { c | href = Just s }


type alias ContainerConfig =
    { id : Maybe String
    , mode : Mode
    }


defaultConfig : ContainerConfig
defaultConfig =
    { id = Nothing, mode = Auto }


applyOption : Option msg -> ContainerConfig -> ContainerConfig
applyOption opt c =
    case opt of
        WithId id ->
            { c | id = Just id }

        ModeOpt m ->
            { c | mode = m }


toCemMode : Mode -> CemNavRail.Mode
toCemMode m =
    case m of
        Compact ->
            CemNavRail.Compact

        Expanded ->
            CemNavRail.Expanded

        Auto ->
            CemNavRail.Auto
