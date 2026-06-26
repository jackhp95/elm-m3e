module Ui.Breadcrumb exposing
    ( Breadcrumb, new
    , withAttributes
    , withId
    , withWrap
    , withSeparator
    , Item, item, link, current
    , itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
    , withItemIcon
    , withItemTarget, withItemRel, withItemDownload, withItemDisabled
    , withItem, withItems
    , view
    )

{-| Typed builder for `<m3e-breadcrumb>` — a hierarchical navigation
trail that shows where the current page sits in the site's depth and
lets the user step back up the path.

Reach for a breadcrumb to expose **hierarchy depth** within a page.
Sibling navigation: `Ui.Tabs` switches peer views, `Ui.Toc` links to
in-page sections, and `Ui.Stepper` walks an ordered multi-step flow.

Only typed `Item` values can go in. Each item is either an `item`/`link`
(trail) or `current` (the present location, non-clickable).

    Ui.Breadcrumb.new
        |> Ui.Breadcrumb.withItems
            [ Ui.Breadcrumb.link "Dashboard" "/dashboard"
            , Ui.Breadcrumb.link "Reports" "/dashboard/reports"
            , Ui.Breadcrumb.current "Annual"
            ]
        |> Ui.Breadcrumb.view


# Construction

@docs Breadcrumb, new


# Host attributes

@docs withAttributes


# Identity

@docs withId


# Host layout

@docs withWrap


# Separator

@docs withSeparator


# Items

@docs Item, item, link, current
@docs itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
@docs withItemIcon
@docs withItemTarget, withItemRel, withItemDownload, withItemDisabled
@docs withItem, withItems


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Breadcrumb
import M3e.BreadcrumbItem
import Ui.Icon


{-| The breadcrumb opaque type. Build via `new`.
-}
type Breadcrumb msg
    = Breadcrumb (Config msg)


{-| A single crumb. Build via `item`, `link`, or `current`.
-}
type Item msg
    = Item
        { label : Html msg
        , href : Maybe String
        , isCurrent : Bool
        , icon : Maybe (Ui.Icon.Icon msg)
        , target : Maybe String
        , rel : Maybe String
        , download : Maybe String
        , disabled : Bool
        }


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , wrap : Bool
    , separator : Maybe (Html msg)
    , items : List (Item msg)
    }


{-| Construct a fresh breadcrumb with no items.
-}
new : Breadcrumb msg
new =
    Breadcrumb { id = Nothing, attributes = [], wrap = False, separator = Nothing, items = [] }


{-| Append attributes to the underlying `<m3e-breadcrumb>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Breadcrumb msg -> Breadcrumb msg
withAttributes attributes (Breadcrumb cfg) =
    Breadcrumb { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Breadcrumb msg -> Breadcrumb msg
withId id (Breadcrumb cfg) =
    Breadcrumb { cfg | id = Just id }


{-| Allow crumbs to wrap onto a new line when the trail is too wide
(`wrap` on `<m3e-breadcrumb>`, default false). By default the trail stays
on a single line.
-}
withWrap : Bool -> Breadcrumb msg -> Breadcrumb msg
withWrap flag (Breadcrumb cfg) =
    Breadcrumb { cfg | wrap = flag }


{-| Replace the glyph rendered between crumbs via the `separator` slot.
Omit this to keep `m3e-breadcrumb`'s default separator.
-}
withSeparator : Html msg -> Breadcrumb msg -> Breadcrumb msg
withSeparator separator (Breadcrumb cfg) =
    Breadcrumb { cfg | separator = Just separator }


{-| A non-clickable trail item (no `href`) from plain text — for a level
that has no destination of its own.
-}
item : String -> Item msg
item label =
    Item { label = Html.text label, href = Nothing, isCurrent = False, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| A clickable trail item from plain text and its target `href` — the
usual crumb for an ancestor page.
-}
link : String -> String -> Item msg
link label href =
    Item { label = Html.text label, href = Just href, isCurrent = False, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| The present location as the last crumb. Sets `current` on the
underlying `<m3e-breadcrumb-item>`, marking it the active, non-clickable
end of the path. Use exactly one per trail.
-}
current : String -> Item msg
current label =
    Item { label = Html.text label, href = Nothing, isCurrent = True, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| Escape hatch: `item` from arbitrary `Html` (e.g. an icon + text).
-}
itemEscapeHatchHtml : Html msg -> Item msg
itemEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = False, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| Escape hatch: `link` from arbitrary `Html` and a target href.
-}
linkEscapeHatchHtml : Html msg -> String -> Item msg
linkEscapeHatchHtml label href =
    Item { label = label, href = Just href, isCurrent = False, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| Escape hatch: `current` crumb from arbitrary `Html`.
-}
currentEscapeHatchHtml : Html msg -> Item msg
currentEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = True, icon = Nothing, target = Nothing, rel = Nothing, download = Nothing, disabled = False }


{-| Attach a leading icon, rendered before the label in the item's `icon`
slot. Emitted `aria-hidden`, so keep the label meaningful on its own.
-}
withItemIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemIcon icon (Item i) =
    Item { i | icon = Just icon }


{-| Set the `target` of the crumb's internal link button (e.g. `"_blank"`),
mirroring an anchor's `target` (m3e `target` on `<m3e-breadcrumb-item>`,
default `""`). Only meaningful on a `link` crumb.
-}
withItemTarget : String -> Item msg -> Item msg
withItemTarget target (Item i) =
    Item { i | target = Just target }


{-| Set the `rel` of the crumb's internal link button (e.g.
`"noreferrer noopener"`), describing the relationship between the link
target and the document (m3e `rel` on `<m3e-breadcrumb-item>`, default
`""`). Only meaningful on a `link` crumb.
-}
withItemRel : String -> Item msg -> Item msg
withItemRel rel (Item i) =
    Item { i | rel = Just rel }


{-| Request that the crumb's link target be downloaded rather than
navigated to, optionally naming the file (m3e `download` on
`<m3e-breadcrumb-item>`, default unset). An empty string requests the
default filename. Only meaningful on a `link` crumb.
-}
withItemDownload : String -> Item msg -> Item msg
withItemDownload download (Item i) =
    Item { i | download = Just download }


{-| Disable the crumb (`disabled` on `<m3e-breadcrumb-item>`, default
false). The item renders but its internal button is inert.
-}
withItemDisabled : Bool -> Item msg -> Item msg
withItemDisabled flag (Item i) =
    Item { i | disabled = flag }


{-| Append a single crumb.
-}
withItem : Item msg -> Breadcrumb msg -> Breadcrumb msg
withItem i (Breadcrumb cfg) =
    Breadcrumb { cfg | items = cfg.items ++ [ i ] }


{-| Append a list of crumbs.
-}
withItems : List (Item msg) -> Breadcrumb msg -> Breadcrumb msg
withItems is (Breadcrumb cfg) =
    Breadcrumb { cfg | items = cfg.items ++ is }


{-| Render the breadcrumb.
-}
view : Breadcrumb msg -> Html msg
view (Breadcrumb cfg) =
    M3e.Breadcrumb.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , if cfg.wrap then
                    Just (M3e.Breadcrumb.wrap True)

                  else
                    Nothing
                ]
        )
        (separatorChildren cfg.separator ++ List.map viewItem cfg.items)


separatorChildren : Maybe (Html msg) -> List (Html msg)
separatorChildren separator =
    case separator of
        Nothing ->
            []

        Just content ->
            [ Html.span [ M3e.Breadcrumb.separatorSlot ] [ content ] ]


viewItem : Item msg -> Html msg
viewItem (Item i) =
    M3e.BreadcrumbItem.component
        (List.filterMap identity
            [ Maybe.map M3e.BreadcrumbItem.href i.href
            , Maybe.map M3e.BreadcrumbItem.target i.target
            , Maybe.map M3e.BreadcrumbItem.rel i.rel
            , Maybe.map M3e.BreadcrumbItem.download i.download
            , if i.disabled then
                Just (M3e.BreadcrumbItem.disabled True)

              else
                Nothing
            , if i.isCurrent then
                Just (M3e.BreadcrumbItem.current M3e.BreadcrumbItem.True)

              else
                Nothing
            ]
        )
        (iconChildren i.icon ++ [ i.label ])


iconChildren : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
iconChildren icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span
                [ M3e.BreadcrumbItem.iconSlot
                , Attr.attribute "aria-hidden" "true"
                ]
                [ Ui.Icon.view i ]
            ]
