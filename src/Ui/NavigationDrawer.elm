module Ui.NavigationDrawer exposing
    ( NavigationDrawer, Item, Entry
    , Side(..), Mode(..)
    , new, item, tree, group, link
    , withAttributes
    , withId, withSide, withModal, withMode, withOpen, withOnChange
    , withItemLabel, withItemBadge, withContent, withEntries
    , withEntryIcon, withEntryHref, withEntryTarget, withEntrySelected, withEntryOpen, withEntryBadge, withEntryChildren
    , view
    )

{-| Typed builder for `<m3e-nav-menu>` inside `<m3e-drawer-container>`
— a full-height side panel hosting top-level destinations for
expanded-width viewports. Mirrors the Material 3
[Navigation drawer][m3] surface.

[m3]: https://m3.material.io/components/navigation-drawer/overview

The drawer is the **large-screen** top of the responsive
top-level-navigation trio: for compact viewports step down to
`Ui.NavigationBar` (bottom bar); for medium viewports use
`Ui.NavigationRail` (side rail).


# Two shapes

  - **Flat, selectable** (`new` + `item`) — a single level of destinations
    selected by value, reporting changes through `onChange`. Use for
    in-app section switching (the `Reply` mailbox list).
  - **Hierarchical, link-based** (`tree` + `group` / `link`) — collapsible
    groups of real `a[href]` destinations, with the main content projected
    into the drawer's content region via `withContent`. Use for a docs/app
    shell where navigation is real anchors and the URL drives selection.


# Modal vs side mode

  - **Modal** (`withModal True`) — overlays content with a scrim; closes on
    outside click. The default for the flat shape.
  - **Side** (`withModal False`) — sits alongside content as part of the
    layout. The default for the `tree` shape (a permanent desktop drawer).


# Flat example

    Ui.NavigationDrawer.new
        { items =
            [ Ui.NavigationDrawer.item { value = Home, icon = home }
                |> Ui.NavigationDrawer.withItemLabel "Home"
            , Ui.NavigationDrawer.item { value = Settings, icon = settings }
                |> Ui.NavigationDrawer.withItemLabel "Settings"
            ]
        , selected = Just state.currentPage
        , onChange = PageChanged
        }
        |> Ui.NavigationDrawer.view


# Tree example

    Ui.NavigationDrawer.tree
        |> Ui.NavigationDrawer.withEntries
            [ Ui.NavigationDrawer.group "Getting Started"
                |> Ui.NavigationDrawer.withEntryIcon (Ui.Icon.material "rocket_launch")
                |> Ui.NavigationDrawer.withEntryOpen True
                |> Ui.NavigationDrawer.withEntryChildren
                    [ Ui.NavigationDrawer.link "Overview"
                        |> Ui.NavigationDrawer.withEntryHref "/getting-started/overview"
                        |> Ui.NavigationDrawer.withEntrySelected True
                    ]
            ]
        |> Ui.NavigationDrawer.withContent pageBody
        |> Ui.NavigationDrawer.view


# Types

@docs NavigationDrawer, Item, Entry


# Configuration

@docs Side, Mode


# Constructors

@docs new, item, tree, group, link


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withSide, withModal, withMode, withOpen, withOnChange
@docs withItemLabel, withItemBadge, withContent, withEntries
@docs withEntryIcon, withEntryHref, withEntryTarget, withEntrySelected, withEntryOpen, withEntryBadge, withEntryChildren


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import M3e.DrawerContainer
import M3e.NavMenu
import M3e.NavMenuItem
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A navigation drawer.
-}
type NavigationDrawer value msg
    = NavigationDrawer (DrawerConfig value msg)


{-| One destination in the flat, value-selected shape.
-}
type Item value msg
    = Item (ItemConfig value msg)


{-| One node in the hierarchical, link-based shape — either a `group`
(expandable, holds children) or a `link` (a real `a[href]` destination).
-}
type Entry msg
    = Entry (EntryConfig msg)


{-| Which edge of the viewport the drawer anchors to.
-}
type Side
    = Start
    | End


{-| How the drawer relates to the content.

  - **`Side`** — pinned inline; the drawer is always visible and consumes
    layout width.
  - **`Over`** — modal overlay; the drawer floats above content with a scrim.
  - **`Auto`** — `m3e-drawer-container` switches between `Side` (medium and
    larger breakpoints) and `Over` (small breakpoints) on its own. The
    natural choice for a responsive app shell; pair with `withOpen` and
    `withOnChange` to track the open state across the auto-switch.

If both `withMode` and `withModal` are called, `withMode` wins.

-}
type Mode
    = ModeSide
    | ModeOver
    | ModeAuto


type alias DrawerConfig value msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , side : Side
    , modal : Bool
    , mode : Maybe Mode
    , open : Bool
    , onScrimChange : Maybe (Bool -> msg)
    , items : List (Item value msg)
    , selected : Maybe value
    , onChange : Maybe (value -> msg)
    , entries : List (Entry msg)
    , content : List (Html msg)
    }


type alias ItemConfig value msg =
    { value : value
    , icon : Ui.Icon.Icon msg
    , label : Maybe String
    , badge : Maybe String
    }


type alias EntryConfig msg =
    { label : String
    , icon : Maybe (Ui.Icon.Icon msg)
    , href : Maybe String
    , target : Maybe String
    , selected : Bool
    , open : Bool
    , badge : Maybe String
    , children : List (Entry msg)
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a flat, value-selected navigation drawer.
-}
new :
    { items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> NavigationDrawer value msg
new c =
    NavigationDrawer
        { id = Nothing
        , attributes = []
        , side = Start
        , modal = True
        , mode = Nothing
        , open = True
        , onScrimChange = Nothing
        , items = c.items
        , selected = c.selected
        , onChange = Just c.onChange
        , entries = []
        , content = []
        }


{-| Construct a destination item for the flat shape.
-}
item : { value : value, icon : Ui.Icon.Icon msg } -> Item value msg
item c =
    Item
        { value = c.value
        , icon = c.icon
        , label = Nothing
        , badge = Nothing
        }


{-| Construct an empty hierarchical (link-based) drawer. Add destinations
with `withEntries` and main content with `withContent`. Defaults to side
(permanent) mode — the common shell layout.
-}
tree : NavigationDrawer value msg
tree =
    NavigationDrawer
        { id = Nothing
        , attributes = []
        , side = Start
        , modal = False
        , mode = Nothing
        , open = True
        , onScrimChange = Nothing
        , items = []
        , selected = Nothing
        , onChange = Nothing
        , entries = []
        , content = []
        }


{-| An expandable group node. Give it children with `withEntryChildren` and
expand it with `withEntryOpen`.
-}
group : String -> Entry msg
group label =
    Entry
        { label = label
        , icon = Nothing
        , href = Nothing
        , target = Nothing
        , selected = False
        , open = False
        , badge = Nothing
        , children = []
        }


{-| A leaf destination. Give it an address with `withEntryHref`.
-}
link : String -> Entry msg
link label =
    Entry
        { label = label
        , icon = Nothing
        , href = Nothing
        , target = Nothing
        , selected = False
        , open = False
        , badge = Nothing
        , children = []
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> NavigationDrawer value msg -> NavigationDrawer value msg
withAttributes attributes (NavigationDrawer cfg) =
    NavigationDrawer { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> NavigationDrawer value msg -> NavigationDrawer value msg
withId id (NavigationDrawer cfg) =
    NavigationDrawer { cfg | id = Just id }


{-| Anchor edge (default `Start`).
-}
withSide : Side -> NavigationDrawer value msg -> NavigationDrawer value msg
withSide s (NavigationDrawer cfg) =
    NavigationDrawer { cfg | side = s }


{-| Modal (overlay) vs side (inline/permanent) mode. Convenience kept for the
flat-shape consumers; for the responsive app-shell case prefer `withMode Auto`.
-}
withModal : Bool -> NavigationDrawer value msg -> NavigationDrawer value msg
withModal b (NavigationDrawer cfg) =
    NavigationDrawer { cfg | modal = b }


{-| Set the drawer's display mode explicitly. Supersedes `withModal` when set.
Use `ModeAuto` for a responsive app shell — the underlying
`m3e-drawer-container` observes breakpoints and switches between side (medium+)
and over (small) on its own.
-}
withMode : Mode -> NavigationDrawer value msg -> NavigationDrawer value msg
withMode m (NavigationDrawer cfg) =
    NavigationDrawer { cfg | mode = Just m }


{-| Drive the drawer's open state from outside. Defaults to `True` (always
open) — the right shape for a permanent side drawer. For an `Auto` shell, pass
`isMobile then showMenu else True` so the drawer is closed-by-default on
mobile and toggled by the app bar's menu button.
-}
withOpen : Bool -> NavigationDrawer value msg -> NavigationDrawer value msg
withOpen o (NavigationDrawer cfg) =
    NavigationDrawer { cfg | open = o }


{-| Receive open-state changes the user makes outside Elm (tapping the
modal scrim, hitting Escape). The handler gets the drawer's new open state;
typically wire it to a `MenuClosed`/`MenuOpened` `Msg` that flips the same
state `withOpen` reads from.
-}
withOnChange : (Bool -> msg) -> NavigationDrawer value msg -> NavigationDrawer value msg
withOnChange handler (NavigationDrawer cfg) =
    NavigationDrawer { cfg | onScrimChange = Just handler }


{-| Add a label to a flat item.
-}
withItemLabel : String -> Item value msg -> Item value msg
withItemLabel label (Item cfg) =
    Item { cfg | label = Just label }


{-| Attach a small badge text to a flat item.
-}
withItemBadge : String -> Item value msg -> Item value msg
withItemBadge badge (Item cfg) =
    Item { cfg | badge = Just badge }


{-| Project the main page content into the drawer's content region (the
default slot of `m3e-drawer-container`). Used by the `tree` shape to make the
drawer the whole app shell.
-}
withContent : List (Html msg) -> NavigationDrawer value msg -> NavigationDrawer value msg
withContent content (NavigationDrawer cfg) =
    NavigationDrawer { cfg | content = content }


{-| Set the destinations of a `tree` drawer.
-}
withEntries : List (Entry msg) -> NavigationDrawer value msg -> NavigationDrawer value msg
withEntries entries (NavigationDrawer cfg) =
    NavigationDrawer { cfg | entries = entries }


{-| Leading icon for an entry (group or link).
-}
withEntryIcon : Ui.Icon.Icon msg -> Entry msg -> Entry msg
withEntryIcon icon (Entry cfg) =
    Entry { cfg | icon = Just icon }


{-| Address for a link entry. The label becomes a real `a[href]`.
-}
withEntryHref : String -> Entry msg -> Entry msg
withEntryHref href (Entry cfg) =
    Entry { cfg | href = Just href }


{-| Anchor `target` for a link entry (e.g. `"_blank"`).
-}
withEntryTarget : String -> Entry msg -> Entry msg
withEntryTarget target (Entry cfg) =
    Entry { cfg | target = Just target }


{-| Mark an entry as the current selection — the `selected` attribute on
`m3e-nav-menu-item` (default `False`).
-}
withEntrySelected : Bool -> Entry msg -> Entry msg
withEntrySelected b (Entry cfg) =
    Entry { cfg | selected = b }


{-| Expand a group entry — the `open` attribute on `m3e-nav-menu-item`
(default `False`, collapsed).
-}
withEntryOpen : Bool -> Entry msg -> Entry msg
withEntryOpen b (Entry cfg) =
    Entry { cfg | open = b }


{-| Attach a small badge text to an entry.
-}
withEntryBadge : String -> Entry msg -> Entry msg
withEntryBadge badge (Entry cfg) =
    Entry { cfg | badge = Just badge }


{-| Nest child entries under a group.
-}
withEntryChildren : List (Entry msg) -> Entry msg -> Entry msg
withEntryChildren children (Entry cfg) =
    Entry { cfg | children = children }



-- RENDER -----------------------------------------------------------------


{-| Render the navigation drawer to `Html`.
-}
view : NavigationDrawer value msg -> Html msg
view (NavigationDrawer cfg) =
    M3e.DrawerContainer.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , sideAttr cfg
                , Just (modeAttr cfg)
                , Maybe.map (M3e.DrawerContainer.onChange << scrimChangeDecoder cfg.side) cfg.onScrimChange
                ]
        )
        (M3e.NavMenu.component [ panelSlot cfg ]
            (List.map (flatItemView cfg) cfg.items
                ++ List.map entryView cfg.entries
            )
            :: cfg.content
        )


flatItemView : DrawerConfig value msg -> Item value msg -> Html msg
flatItemView cfg (Item it) =
    M3e.NavMenuItem.component
        (List.filterMap identity
            [ Just (M3e.NavMenuItem.selected (cfg.selected == Just it.value))
            , Maybe.map (\f -> HtmlEvents.onClick (f it.value)) cfg.onChange
            ]
        )
        (List.concat
            [ [ Html.span [ M3e.NavMenuItem.iconSlot ] [ Ui.Icon.view it.icon ] ]
            , labelText it.label
            , badgeText it.badge
            ]
        )


entryView : Entry msg -> Html msg
entryView (Entry e) =
    M3e.NavMenuItem.component
        (List.filterMap identity
            [ Just (M3e.NavMenuItem.selected e.selected)
            , if e.open then
                Just (M3e.NavMenuItem.open True)

              else
                Nothing
            ]
        )
        (List.concat
            [ case e.icon of
                Just ic ->
                    [ Html.span [ M3e.NavMenuItem.iconSlot ] [ Ui.Icon.view ic ] ]

                Nothing ->
                    []
            , [ entryLabel e ]
            , badgeText e.badge
            , List.map entryView e.children
            ]
        )


{-| The label of an entry — a real `a[href]` when it has an address, else a
plain `span`. Either rides the `label` slot of `m3e-nav-menu-item`.
-}
entryLabel : EntryConfig msg -> Html msg
entryLabel e =
    case e.href of
        Just href ->
            Html.a
                (List.filterMap identity
                    [ Just M3e.NavMenuItem.labelSlot
                    , Just (Attr.href href)
                    , Maybe.map (Attr.attribute "target") e.target
                    ]
                )
                [ Html.text e.label ]

        Nothing ->
            Html.span [ M3e.NavMenuItem.labelSlot ] [ Html.text e.label ]


labelText : Maybe String -> List (Html msg)
labelText label =
    case label of
        Nothing ->
            []

        Just l ->
            [ Html.span [ M3e.NavMenuItem.labelSlot ] [ Html.text l ] ]


badgeText : Maybe String -> List (Html msg)
badgeText badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ Html.span [ M3e.NavMenuItem.badgeSlot ] [ Html.text b ] ]


{-| Emit the `start` / `end` open state as an HTML **attribute** (presence =
open, absent = closed). Bypasses the property-reflection path the binding's
`M3e.DrawerContainer.start` uses — the drawer-container's CSS selectors key
off `:host([start])`, so attribute presence is the reliable control surface
across Elm re-renders.
-}
sideAttr : DrawerConfig value msg -> Maybe (Html.Attribute msg)
sideAttr cfg =
    if cfg.open then
        case cfg.side of
            Start ->
                Just (Attr.attribute "start" "")

            End ->
                Just (Attr.attribute "end" "")

    else
        Nothing


{-| Decode the change event into a `(Bool -> msg)` handler. The
`m3e-drawer-container` flips its `start` / `end` boolean property when the
user closes via scrim/escape; read the relevant side's property off the event
target.
-}
scrimChangeDecoder : Side -> (Bool -> msg) -> Decode.Decoder msg
scrimChangeDecoder side toMsg =
    let
        propPath : List String
        propPath =
            case side of
                Start ->
                    [ "target", "start" ]

                End ->
                    [ "target", "end" ]
    in
    Decode.at propPath Decode.bool |> Decode.map toMsg


{-| Project the nav-menu into the drawer's `start`/`end` panel slot (per
`cfg.side`) — the default slot is the main content region, not the panel.
-}
panelSlot : DrawerConfig value msg -> Html.Attribute msg
panelSlot cfg =
    case cfg.side of
        Start ->
            M3e.DrawerContainer.startSlot

        End ->
            M3e.DrawerContainer.endSlot


{-| Emit the panel's display mode via the typed binding (`auto`/`side`/`over`)
on the matching edge. Honours `cfg.mode` when set; otherwise derives from the
legacy `cfg.modal` flag.
-}
modeAttr : DrawerConfig value msg -> Html.Attribute msg
modeAttr cfg =
    let
        effective : Mode
        effective =
            case cfg.mode of
                Just m ->
                    m

                Nothing ->
                    if cfg.modal then
                        ModeOver

                    else
                        ModeSide
    in
    case cfg.side of
        Start ->
            M3e.DrawerContainer.startMode
                (case effective of
                    ModeAuto ->
                        M3e.DrawerContainer.StartModeAuto

                    ModeOver ->
                        M3e.DrawerContainer.StartModeOver

                    ModeSide ->
                        M3e.DrawerContainer.StartModeSide
                )

        End ->
            M3e.DrawerContainer.endMode
                (case effective of
                    ModeAuto ->
                        M3e.DrawerContainer.EndModeAuto

                    ModeOver ->
                        M3e.DrawerContainer.EndModeOver

                    ModeSide ->
                        M3e.DrawerContainer.EndModeSide
                )
