module Ui.Breadcrumb exposing
    ( Breadcrumb, new
    , withId
    , Item, item, link, current, withItem, withItems
    , view
    )

{-| Typed builder for M3 breadcrumbs. Only typed `Item` values can go
in. Each item is either an `item`/`link` (trail) or `current` (the
present location, non-clickable).


# Construction

@docs Breadcrumb, new


# Identity

@docs withId


# Items

@docs Item, item, link, current, withItem, withItems


# Render

@docs view

-}

import Html exposing (Html)
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
    , items : List (Item msg)
    }


new : Breadcrumb msg
new =
    Breadcrumb { id = Nothing, items = [] }


withId : String -> Breadcrumb msg -> Breadcrumb msg
withId id (Breadcrumb cfg) =
    Breadcrumb { cfg | id = Just id }


item : Html msg -> Item msg
item label =
    Item { label = label, href = Nothing, isCurrent = False }


link : Html msg -> String -> Item msg
link label href =
    Item { label = label, href = Just href, isCurrent = False }


current : Html msg -> Item msg
current label =
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
        (List.filterMap identity [ Maybe.map Attr.id cfg.id ])
        (List.map viewItem cfg.items)


viewItem : Item msg -> Html msg
viewItem (Item i) =
    M3e.BreadcrumbItem.component
        (List.filterMap identity
            [ Maybe.map M3e.BreadcrumbItem.href i.href
            , if i.isCurrent then
                Just (M3e.BreadcrumbItem.current "true")

              else
                Nothing
            ]
        )
        [ i.label ]
