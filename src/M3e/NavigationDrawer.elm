module M3e.NavigationDrawer exposing
    ( view
    , Option, Side(..), Mode(..)
    , id, open, side, mode, content
    , link, group
    , LinkOption
    , linkSelected, linkBadge, linkIcon, linkTarget
    , GroupOption
    , groupSelected, groupOpen, groupBadge, groupIcon
    )

{-| `<m3e-drawer-container>` + `<m3e-nav-menu>` + `<m3e-nav-menu-item>` —
Material 3 Navigation Drawer with a hierarchical, link-based tree API.

Spec (per docs/CONVENTIONS.md):

  - Required (container): `{ entries }` — the entry tree
  - Options (container): id, open, side, mode, content (main page body)
  - Required (link): `{ label, href }` — label text + URL destination
  - Options (link): selected, badge, icon, target
  - Required (group): `{ label }` + children (list of nested nav-menu-items)
  - Options (group): selected, open, badge, icon
  - Slots:
      - `navMenuItem` — the item type for both `link` and `group`
      - `icon` (named slot on nav-menu-item) — leading icon
      - `label` (named slot on nav-menu-item) — the label / link text
      - `badge` (named slot on nav-menu-item) — badge chip
      - `start` / `end` (named slot on drawer-container) — the nav panel
  - Properties: `selected`, `open` (DOM properties on `m3e-nav-menu-item`);
    `start` / `end` / `start-mode` / `end-mode` (on drawer-container)
  - Tags: `navMenuItem` (entries), `navigationDrawer` (container)

**Tree rendering:** `group` items render `<m3e-nav-menu-item>` with child
items in the DEFAULT slot (no slot injection on children — the element
handles nesting natively).

**Open state:** the drawer's open state is driven by the `start` / `end`
ATTRIBUTE (not DOM property) on `<m3e-drawer-container>`, matching the
approach in `Ui.NavigationDrawer`: the element's CSS selectors key off
`:host([start])`, so attribute presence is the reliable surface across Elm
re-renders.


# Container

@docs view
@docs Option, Side, Mode
@docs id, open, side, mode, content


# Entries

@docs link, group


# Link options

@docs LinkOption
@docs linkSelected, linkBadge, linkIcon, linkTarget


# Group options

@docs GroupOption
@docs groupSelected, groupOpen, groupBadge, groupIcon

-}

import Html exposing (Html)
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES -----------------------------------------------------------------------


{-| Which edge the drawer anchors to.
-}
type Side
    = Start
    | End


{-| How the drawer relates to the layout.

  - `ModeSide` — pinned inline, always visible.
  - `ModeOver` — modal overlay with a scrim.
  - `ModeAuto` — responsive: `ModeSide` on medium+ viewports, `ModeOver` on
    small. The right choice for a responsive app shell.

-}
type Mode
    = ModeSide
    | ModeOver
    | ModeAuto


{-| Options on a `link` entry.
-}
type alias LinkOption msg =
    Internal.Option (LinkConfig msg) msg


{-| Options on a `group` entry.
-}
type alias GroupOption msg =
    Internal.Option (GroupConfig msg) msg


{-| Options on the container.
-}
type alias Option msg =
    Internal.Option (ContainerConfig msg) msg



-- LINK OPTION CONSTRUCTORS ----------------------------------------------------


{-| Mark this link as the currently selected destination.
-}
linkSelected : Bool -> LinkOption msg
linkSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Attach a badge text to this link (e.g. an unread count).
-}
linkBadge : String -> LinkOption msg
linkBadge s =
    Internal.option (\c -> { c | badge = Just s })


{-| Leading icon for this link.
-}
linkIcon : Renderable { icon : Supported } msg -> LinkOption msg
linkIcon ic =
    Internal.option (\c -> { c | icon = Just ic })


{-| Set the `target` attribute on the anchor (e.g. `"_blank"`).
-}
linkTarget : String -> LinkOption msg
linkTarget s =
    Internal.option (\c -> { c | target = Just s })



-- GROUP OPTION CONSTRUCTORS ---------------------------------------------------


{-| Mark this group as selected (e.g. it contains the active destination).
-}
groupSelected : Bool -> GroupOption msg
groupSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Expand the group. Default `False` (collapsed).
-}
groupOpen : Bool -> GroupOption msg
groupOpen b =
    Internal.option (\c -> { c | open = b })


{-| Attach a badge text to this group.
-}
groupBadge : String -> GroupOption msg
groupBadge s =
    Internal.option (\c -> { c | badge = Just s })


{-| Leading icon for this group.
-}
groupIcon : Renderable { icon : Supported } msg -> GroupOption msg
groupIcon ic =
    Internal.option (\c -> { c | icon = Just ic })



-- CONTAINER OPTION CONSTRUCTORS -----------------------------------------------


{-| Set the `id` attribute on the `<m3e-drawer-container>`.
-}
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Control whether the drawer is open. Default `True` (open — the usual
shape for a permanent side drawer). Pass `False` on mobile / overlay mode.
-}
open : Bool -> Option msg
open b =
    Internal.option (\c -> { c | open = b })


{-| Which edge the drawer anchors to. Default `Start`.
-}
side : Side -> Option msg
side s =
    Internal.option (\c -> { c | side = s })


{-| Set the display mode. Default `ModeSide`.
-}
mode : Mode -> Option msg
mode m =
    Internal.option (\c -> { c | mode = m })


{-| Main page content to project into the drawer's content region (the
default slot of `<m3e-drawer-container>`).
-}
content : List (Html msg) -> Option msg
content items =
    Internal.option (\c -> { c | content = items })



-- ENTRY CONSTRUCTORS ----------------------------------------------------------


{-| A leaf link destination inside the nav menu.

    M3e.NavigationDrawer.link
        { label = "Overview", href = "/docs/overview" }
        [ M3e.NavigationDrawer.linkSelected True
        , M3e.NavigationDrawer.linkIcon (M3e.Icon.view { name = "home" })
        ]

-}
link :
    { label : String, href : String }
    -> List (LinkOption msg)
    -> Renderable { navMenuItem : Supported } msg
link req opts =
    let
        cfg : LinkConfig msg
        cfg =
            Internal.applyOptions opts defaultLinkConfig
    in
    Internal.fromNode
        (Node.element "m3e-nav-menu-item"
            [ Node.property "selected" (Encode.bool cfg.selected) ]
            (List.filterMap identity
                [ Maybe.map
                    (\ic ->
                        Renderable.toNode ic
                            |> Node.withSlot "icon"
                    )
                    cfg.icon
                , Just
                    (Node.element "a"
                        (List.filterMap identity
                            [ Just (Node.attribute "slot" "label")
                            , Just (Node.attribute "href" req.href)
                            , Maybe.map (Node.attribute "target") cfg.target
                            ]
                        )
                        [ Node.text req.label ]
                    )
                , Maybe.map
                    (\b ->
                        Node.element "span"
                            [ Node.attribute "slot" "badge" ]
                            [ Node.text b ]
                    )
                    cfg.badge
                ]
            )
        )


{-| A collapsible group entry that holds nested nav-menu-items.

    M3e.NavigationDrawer.group
        { label = "Getting Started" }
        [ M3e.NavigationDrawer.link { label = "Overview", href = "/start" } []
        , M3e.NavigationDrawer.link { label = "Install", href = "/install" } []
        ]
        [ M3e.NavigationDrawer.groupOpen True
        , M3e.NavigationDrawer.groupIcon (M3e.Icon.view { name = "rocket_launch" })
        ]

-}
group :
    { label : String }
    -> List (Renderable { navMenuItem : Supported } msg)
    -> List (GroupOption msg)
    -> Renderable { navMenuItem : Supported } msg
group req children opts =
    let
        cfg : GroupConfig msg
        cfg =
            Internal.applyOptions opts defaultGroupConfig
    in
    Internal.fromNode
        (Node.element "m3e-nav-menu-item"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool cfg.selected))
                , if cfg.open then
                    Just (Node.property "open" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (List.filterMap identity
                [ Maybe.map
                    (\ic ->
                        Renderable.toNode ic
                            |> Node.withSlot "icon"
                    )
                    cfg.icon
                , Just
                    (Node.element "span"
                        [ Node.attribute "slot" "label" ]
                        [ Node.text req.label ]
                    )
                , Maybe.map
                    (\b ->
                        Node.element "span"
                            [ Node.attribute "slot" "badge" ]
                            [ Node.text b ]
                    )
                    cfg.badge
                ]
                ++ List.map Renderable.toNode children
            )
        )



-- VIEW (CONTAINER) ------------------------------------------------------------


{-| Render the navigation drawer container.

    M3e.NavigationDrawer.view
        { entries =
            [ M3e.NavigationDrawer.group { label = "Getting Started" }
                [ M3e.NavigationDrawer.link { label = "Overview", href = "/start" }
                    [ M3e.NavigationDrawer.linkSelected True ]
                ]
                [ M3e.NavigationDrawer.groupOpen True ]
            ]
        }
        [ M3e.NavigationDrawer.mode M3e.NavigationDrawer.ModeAuto
        , M3e.NavigationDrawer.open model.drawerOpen
        , M3e.NavigationDrawer.content [ pageBody ]
        ]

-}
view :
    { entries : List (Renderable { navMenuItem : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | navigationDrawer : Supported } msg
view req opts =
    let
        cfg : ContainerConfig msg
        cfg =
            Internal.applyOptions opts defaultContainerConfig

        ( openAttr, slotAttr, modeAttrName ) =
            case cfg.side of
                Start ->
                    ( "start", "start", "start-mode" )

                End ->
                    ( "end", "end", "end-mode" )
    in
    Internal.fromNode
        (Node.element "m3e-drawer-container"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") cfg.id
                , if cfg.open then
                    Just (Node.attribute openAttr "")

                  else
                    Nothing
                , Just (Node.attribute modeAttrName (modeString cfg.mode))
                ]
            )
            (Node.element "m3e-nav-menu"
                [ Node.attribute "slot" slotAttr ]
                (List.map Renderable.toNode req.entries)
                :: List.map (\h -> Node.raw h) cfg.content
            )
        )



-- INTERNAL --------------------------------------------------------------------


type alias LinkConfig msg =
    { selected : Bool
    , badge : Maybe String
    , icon : Maybe (Renderable { icon : Supported } msg)
    , target : Maybe String
    }


defaultLinkConfig : LinkConfig msg
defaultLinkConfig =
    { selected = False, badge = Nothing, icon = Nothing, target = Nothing }


type alias GroupConfig msg =
    { selected : Bool
    , open : Bool
    , badge : Maybe String
    , icon : Maybe (Renderable { icon : Supported } msg)
    }


defaultGroupConfig : GroupConfig msg
defaultGroupConfig =
    { selected = False, open = False, badge = Nothing, icon = Nothing }


type alias ContainerConfig msg =
    { id : Maybe String
    , open : Bool
    , side : Side
    , mode : Mode
    , content : List (Html msg)
    }


defaultContainerConfig : ContainerConfig msg
defaultContainerConfig =
    { id = Nothing, open = True, side = Start, mode = ModeSide, content = [] }


modeString : Mode -> String
modeString m =
    case m of
        ModeSide ->
            "side"

        ModeOver ->
            "over"

        ModeAuto ->
            "auto"
