module Ui.Breadcrumb exposing
    ( Breadcrumb, new
    , withAttributes
    , withId
    , Item, item, link, current
    , itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
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


# Items

@docs Item, item, link, current
@docs itemEscapeHatchHtml, linkEscapeHatchHtml, currentEscapeHatchHtml
@docs withItem, withItems


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Breadcrumb
import M3e.BreadcrumbItem


type Breadcrumb msg
    = Breadcrumb (Config msg)


type Item msg
    = Item
        { label : Html msg
        , href : Maybe String
        , isCurrent : Bool
        }


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , items : List (Item msg)
    }


new : Breadcrumb msg
new =
    Breadcrumb { id = Nothing, attributes = [], items = [] }


{-| Append attributes to the underlying `<m3e-breadcrumb>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Breadcrumb msg -> Breadcrumb msg
withAttributes attributes (Breadcrumb cfg) =
    Breadcrumb { cfg | attributes = cfg.attributes ++ attributes }


withId : String -> Breadcrumb msg -> Breadcrumb msg
withId id (Breadcrumb cfg) =
    Breadcrumb { cfg | id = Just id }


{-| A trail item (not the current location) from plain text.
-}
item : String -> Item msg
item label =
    Item { label = Html.text label, href = Nothing, isCurrent = False }


{-| A clickable trail item from plain text and its target href.
-}
link : String -> String -> Item msg
link label href =
    Item { label = Html.text label, href = Just href, isCurrent = False }


{-| The current (non-clickable) crumb from plain text.
-}
current : String -> Item msg
current label =
    Item { label = Html.text label, href = Nothing, isCurrent = True }


{-| Escape hatch: `item` from arbitrary `Html` (e.g. an icon + text).
-}
itemEscapeHatchHtml : Html msg -> Item msg
itemEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = False }


{-| Escape hatch: `link` from arbitrary `Html` and a target href.
-}
linkEscapeHatchHtml : Html msg -> String -> Item msg
linkEscapeHatchHtml label href =
    Item { label = label, href = Just href, isCurrent = False }


{-| Escape hatch: `current` crumb from arbitrary `Html`.
-}
currentEscapeHatchHtml : Html msg -> Item msg
currentEscapeHatchHtml label =
    Item { label = label, href = Nothing, isCurrent = True }


withItem : Item msg -> Breadcrumb msg -> Breadcrumb msg
withItem i (Breadcrumb cfg) =
    Breadcrumb { cfg | items = cfg.items ++ [ i ] }


withItems : List (Item msg) -> Breadcrumb msg -> Breadcrumb msg
withItems is (Breadcrumb cfg) =
    Breadcrumb { cfg | items = cfg.items ++ is }


view : Breadcrumb msg -> Html msg
view (Breadcrumb cfg) =
    M3e.Breadcrumb.component
        (cfg.attributes ++ List.filterMap identity [ Maybe.map Attr.id cfg.id ])
        (List.map viewItem cfg.items)


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
        [ i.label ]
