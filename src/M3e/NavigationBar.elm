module M3e.NavigationBar exposing
    ( Mode(..)
    , ItemOption, Option
    , view, item
    , itemSelected, itemOnClick, itemBadge, itemSelectedIcon, itemDisabled, itemHref
    , withId, mode
    )

{-| `<m3e-nav-bar>` + `<m3e-nav-item>` — bottom-anchored primary navigation
(Material 3 Navigation bar).

Spec (per docs/CONVENTIONS.md):

  - Required (item): `{ icon, label }` — the glyph and its accessible name
  - Required (container): `{ items }` — the destination list (M3 recommends 3–5)
  - Options (item): selected, onClick, badge, selectedIcon, disabled, href
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


type alias ItemOption msg =
    Internal.Option (ItemConfig msg) msg


type alias Option msg =
    Internal.Option ContainerConfig msg


-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Mark this item as selected (the `selected` DOM property on
`<m3e-nav-item>`). -}
itemSelected : Bool -> ItemOption msg
itemSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Fire a message when this destination is chosen. -}
itemOnClick : msg -> ItemOption msg
itemOnClick msg_ =
    Internal.option (\c -> { c | onClick = Just msg_ })


{-| Attach a badge count to the item. Rendered as an `<m3e-badge>` inside the
item's default slot. -}
itemBadge : String -> ItemOption msg
itemBadge s =
    Internal.option (\c -> { c | badge = Just s })


{-| Give the item a distinct glyph for its selected state (the `selected-icon`
slot). Shown in place of the regular icon while the item is selected. -}
itemSelectedIcon : Renderable { icon : Supported } msg -> ItemOption msg
itemSelectedIcon r =
    Internal.option (\c -> { c | selectedIcon = Just r })


{-| Disable this destination. -}
itemDisabled : Bool -> ItemOption msg
itemDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Make this destination a link (the `href` attribute). -}
itemHref : String -> ItemOption msg
itemHref s =
    Internal.option (\c -> { c | href = Just s })


{-| Set the `id` attribute on the `<m3e-nav-bar>` element. -}
withId : String -> Option msg
withId id_ =
    Internal.option (\c -> { c | id = Just id_ })


{-| Set the display mode of the bar. Default `Auto`. -}
mode : Mode -> Option msg
mode m =
    Internal.option (\c -> { c | mode = m })


-- ITEM CONSTRUCTOR --------------------------------------------------------


{-| Construct a navigation bar destination (`<m3e-nav-item>`).

`label` is the destination's accessible name — always required. In `Expanded`
mode it renders as visible text; the web component hides it in `Compact` mode
while keeping it available to screen readers via the slot content.

    M3e.NavigationBar.item { icon = homeIcon, label = "Home" }
        [ M3e.NavigationBar.itemSelected (model.page == Home)
        , M3e.NavigationBar.itemOnClick (Navigate Home)
        ]

-}
item :
    { icon : Renderable { icon : Supported } msg, label : String }
    -> List (ItemOption msg)
    -> Renderable { navItem : Supported } msg
item req opts =
    let
        c =
            Internal.applyOptions opts defaultItemConfig
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
                , Just (Node.text req.label)
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
            Internal.applyOptions opts defaultConfig
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
    , badge : Maybe String
    , selectedIcon : Maybe (Renderable { icon : Supported } msg)
    , disabled : Bool
    , href : Maybe String
    }


defaultItemConfig : ItemConfig msg
defaultItemConfig =
    { selected = False
    , onClick = Nothing
    , badge = Nothing
    , selectedIcon = Nothing
    , disabled = False
    , href = Nothing
    }


type alias ContainerConfig =
    { id : Maybe String
    , mode : Mode
    }


defaultConfig : ContainerConfig
defaultConfig =
    { id = Nothing, mode = Auto }


toCemMode : Mode -> CemNavBar.Mode
toCemMode m =
    case m of
        Compact ->
            CemNavBar.Compact

        Expanded ->
            CemNavBar.Expanded

        Auto ->
            CemNavBar.Auto
