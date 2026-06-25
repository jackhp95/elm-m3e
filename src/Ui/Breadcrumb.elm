module Ui.Breadcrumb exposing
    ( Breadcrumb, new
    , withAttributes
    , withId
    , withSeparator
    , Item, item, link, current
    , itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
    , withItemIcon
    , withItem, withItems
    , view
    )

{-| Typed builder for M3 breadcrumbs. Only typed `Item` values can go
in. Each item is either an `item`/`link` (trail) or `current` (the
present location, non-clickable).


# Construction

@docs Breadcrumb, new


# Host attributes

@docs withAttributes


# Identity

@docs withId


# Separator

@docs withSeparator


# Items

@docs Item, item, link, current
@docs itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
@docs withItemIcon
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
        }


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , separator : Maybe (Html msg)
    , items : List (Item msg)
    }


{-| Construct a fresh breadcrumb with no items.
-}
new : Breadcrumb msg
new =
    Breadcrumb { id = Nothing, attributes = [], separator = Nothing, items = [] }


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


{-| Provide custom content for the `separator` slot rendered between crumbs.
-}
withSeparator : Html msg -> Breadcrumb msg -> Breadcrumb msg
withSeparator separator (Breadcrumb cfg) =
    Breadcrumb { cfg | separator = Just separator }


{-| A trail item (not the current location) from plain text.
-}
item : String -> Item msg
item label =
    Item { label = Html.text label, href = Nothing, isCurrent = False, icon = Nothing }


{-| A clickable trail item from plain text and its target href.
-}
link : String -> String -> Item msg
link label href =
    Item { label = Html.text label, href = Just href, isCurrent = False, icon = Nothing }


{-| The current (non-clickable) crumb from plain text.
-}
current : String -> Item msg
current label =
    Item { label = Html.text label, href = Nothing, isCurrent = True, icon = Nothing }


{-| Escape hatch: `item` from arbitrary `Html` (e.g. an icon + text).
-}
itemEscapeHatchHtml : Html msg -> Item msg
itemEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = False, icon = Nothing }


{-| Escape hatch: `link` from arbitrary `Html` and a target href.
-}
linkEscapeHatchHtml : Html msg -> String -> Item msg
linkEscapeHatchHtml label href =
    Item { label = label, href = Just href, isCurrent = False, icon = Nothing }


{-| Escape hatch: `current` crumb from arbitrary `Html`.
-}
currentEscapeHatchHtml : Html msg -> Item msg
currentEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = True, icon = Nothing }


{-| Attach a leading icon (the item's `icon` slot) to a crumb.
-}
withItemIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemIcon icon (Item i) =
    Item { i | icon = Just icon }


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
        (cfg.attributes ++ List.filterMap identity [ Maybe.map Attr.id cfg.id ])
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
