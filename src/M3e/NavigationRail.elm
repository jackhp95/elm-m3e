module M3e.NavigationRail exposing
    ( view, item
    , Option, ItemOption, Mode(..)
    , id, mode
    , itemSelected, itemOnClick, itemBadge, itemSelectedIcon, itemDisabled, itemHref
    )

{-| `<m3e-nav-rail>` + `<m3e-nav-item>` — side-anchored primary navigation for
medium-width viewports (Material 3 Navigation rail).

Spec (per docs/CONVENTIONS.md):

  - Required (item): `{ icon, label }` — the glyph and its accessible name
  - Required (container): `{ items }` — the destination list
  - Options (item): selected, onClick, badge, selectedIcon, disabled, href
  - Options (container): id, mode
  - Slots (item): icon (leading glyph), selected-icon (active glyph)
  - Properties: selected (item; DOM property), disabled (item; DOM property)
  - Events: click (item)
  - Tag: navRail / navItem

Items are the same `<m3e-nav-item>` element used by `M3e.NavigationBar`;
`navItem` is a shared kind tag. Selection state is fully Elm-controlled.

@docs view, item
@docs Option, ItemOption, Mode
@docs id, mode
@docs itemSelected, itemOnClick, itemBadge, itemSelectedIcon, itemDisabled, itemHref

-}

import Cem.M3e.NavRail as CemNavRail
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- TYPES -------------------------------------------------------------------


{-| How items are laid out. `Compact` (icon only) is the m3e default; `Expanded`
always shows labels; `Auto` switches based on available width.
-}
type Mode
    = Compact
    | Expanded
    | Auto



-- OPTION TYPES ------------------------------------------------------------


{-| A configuration option for a navigation rail item, produced by the
`item*` smart constructors and passed to [`item`](#item).
-}
type alias ItemOption msg =
    Internal.Option (ItemConfig msg) msg


{-| A configuration option for the navigation rail container, passed to
[`view`](#view).
-}
type alias Option msg =
    Internal.Option ContainerConfig msg



-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Mark this item as selected (the `selected` DOM property on
`<m3e-nav-item>`).
-}
itemSelected : Bool -> ItemOption msg
itemSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Fire a message when this destination is chosen.
-}
itemOnClick : msg -> ItemOption msg
itemOnClick msg_ =
    Internal.option (\c -> { c | onClick = Just msg_ })


{-| Attach a badge count to the item. Rendered as an `<m3e-badge>` inside the
item's default slot.
-}
itemBadge : String -> ItemOption msg
itemBadge s =
    Internal.option (\c -> { c | badge = Just s })


{-| Give the item a distinct glyph for its selected state (the `selected-icon`
slot). Shown in place of the regular icon while the item is selected.
-}
itemSelectedIcon : Element { icon : Supported } msg -> ItemOption msg
itemSelectedIcon r =
    Internal.option (\c -> { c | selectedIcon = Just r })


{-| Disable this destination.
-}
itemDisabled : Bool -> ItemOption msg
itemDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Make this destination a link (the `href` attribute).
-}
itemHref : String -> ItemOption msg
itemHref s =
    Internal.option (\c -> { c | href = Just s })


{-| Set the `id` attribute on the `<m3e-nav-rail>` element.
-}
id : String -> Option msg
id id_ =
    Internal.option (\c -> { c | id = Just id_ })


{-| Set the display mode of the rail. Default `Auto`.
-}
mode : Mode -> Option msg
mode m =
    Internal.option (\c -> { c | mode = m })



-- ITEM CONSTRUCTOR --------------------------------------------------------


{-| Construct a navigation rail destination (`<m3e-nav-item>`).

`label` is the destination's accessible name — always required. In `Expanded`
mode it renders as visible text; the web component hides it in `Compact` mode
while keeping it available to screen readers via the slot content.

    M3e.NavigationRail.item { icon = homeIcon, label = "Home" }
        [ M3e.NavigationRail.itemSelected (model.page == Home)
        , M3e.NavigationRail.itemOnClick (Navigate Home)
        ]

-}
item :
    { icon : Element { icon : Supported } msg, label : String }
    -> List (ItemOption msg)
    -> Element { navItem : Supported } msg
item req opts =
    let
        c : ItemConfig msg
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
                [ Just (Node.withSlot "icon" (Element.toNode req.icon))
                , Maybe.map (\si -> Node.withSlot "selected-icon" (Element.toNode si)) c.selectedIcon
                , Just (Node.text req.label)
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
    { items : List (Element { navItem : Supported } msg) }
    -> List (Option msg)
    -> Element { s | navRail : Supported } msg
view req opts =
    let
        c : ContainerConfig
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-nav-rail"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemNavRail.mode (toCemMode c.mode)))
                ]
            )
            (List.map Element.toNode req.items)
        )



-- INTERNAL ----------------------------------------------------------------


type alias ItemConfig msg =
    { selected : Bool
    , onClick : Maybe msg
    , badge : Maybe String
    , selectedIcon : Maybe (Element { icon : Supported } msg)
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


toCemMode : Mode -> CemNavRail.Mode
toCemMode m =
    case m of
        Compact ->
            CemNavRail.Compact

        Expanded ->
            CemNavRail.Expanded

        Auto ->
            CemNavRail.Auto
