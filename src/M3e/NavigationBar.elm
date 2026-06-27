module M3e.NavigationBar exposing
    ( Mode(..)
    , ItemOption, Option
    , view, item
    , itemSelected, itemOnClick, itemLabel, itemBadge, itemSelectedIcon, itemDisabled, itemHref
    , withId, mode
    )

{-| `<m3e-nav-bar>` + `<m3e-nav-item>` — bottom-anchored primary navigation
(Material 3 Navigation bar).

Spec (per docs/CONVENTIONS.md):

  - Required (item): `{ icon }` — the destination glyph (every nav item has one)
  - Required (container): `{ items }` — the destination list (M3 recommends 3–5)
  - Options (item): selected, onClick, label, badge, selectedIcon, disabled, href
  - Options (container): id, mode
  - Slots (item): icon (leading glyph), selected-icon (active glyph)
  - Properties: selected (item; DOM property)
  - Events: click (item)
  - Tag: navBar / navItem

Selection state is fully Elm-controlled: set `itemSelected True` on the active
item and wire `itemOnClick` on each destination to update your model.

-}

import Cem.M3e.NavBar as CemNavBar
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


{-| Set the `id` attribute on the `<m3e-nav-bar>` element. -}
withId : String -> Option msg
withId =
    WithId


{-| Set the display mode of the bar. Default `Auto`. -}
mode : Mode -> Option msg
mode =
    ModeOpt


-- ITEM CONSTRUCTOR --------------------------------------------------------


{-| Construct a navigation bar destination (`<m3e-nav-item>`).

    M3e.NavigationBar.item { icon = homeIcon }
        [ M3e.NavigationBar.itemLabel "Home"
        , M3e.NavigationBar.itemSelected (model.page == Home)
        , M3e.NavigationBar.itemOnClick (Navigate Home)
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


{-| Render the navigation bar.

    M3e.NavigationBar.view
        { items =
            [ M3e.NavigationBar.item { icon = homeIcon }
                [ M3e.NavigationBar.itemLabel "Home"
                , M3e.NavigationBar.itemSelected (model.page == Home)
                , M3e.NavigationBar.itemOnClick (Navigate Home)
                ]
            , M3e.NavigationBar.item { icon = inboxIcon }
                [ M3e.NavigationBar.itemLabel "Inbox"
                , M3e.NavigationBar.itemBadge "3"
                , M3e.NavigationBar.itemSelected (model.page == Inbox)
                , M3e.NavigationBar.itemOnClick (Navigate Inbox)
                ]
            ]
        }
        []

-}
view :
    { items : List (Renderable { navItem : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | navBar : Supported } msg
view req opts =
    let
        c =
            List.foldl applyOption defaultConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-nav-bar"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemNavBar.mode (toCemMode c.mode)))
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


toCemMode : Mode -> CemNavBar.Mode
toCemMode m =
    case m of
        Compact ->
            CemNavBar.Compact

        Expanded ->
            CemNavBar.Expanded

        Auto ->
            CemNavBar.Auto
