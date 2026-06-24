module Ui.List exposing
    ( Listing, Item
    , Variant(..)
    , new, item, actionItem
    , withAttributes
    , withVariant, withId
    , withItemLeadingIcon, withItemTrailingIcon, withItemOverline
    , withItemSupporting, withItemOnClick, withItemDisabled
    , view
    )

{-| Typed builder for `<m3e-list>` and `<m3e-list-item>` — a vertical
collection of rows. Mirrors the Material 3 [Lists][m3] surface.

[m3]: https://m3.material.io/components/lists/overview

The module is named `Ui.List` to honor the m3-doc-page rule, but the
opaque type is `Listing` to avoid shadowing Elm's core `List` type at
call sites.


# Required-by-design

  - `new` — takes the list of items.
  - `item` — a static, non-interactive row (`<m3e-list-item>`). Required
    `headline` text plus optional decorations via `withItem*` setters.
  - `actionItem` — an interactive row (`<m3e-list-item-button>`). Pair
    with [`withItemOnClick`](#withItemOnClick) to handle activation.

The rendered element is chosen at the **call site** by which constructor
you use — never inferred from whether a modifier happens to be present.


# Quick example

    Ui.List.new
        [ Ui.List.item "Inbox"
            |> Ui.List.withItemLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.inbox)
            |> Ui.List.withItemSupporting "12 unread"
            |> Ui.List.withItemOnClick (NavigateTo Inbox)
        , Ui.List.item "Archive"
            |> Ui.List.withItemLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.archive)
            |> Ui.List.withItemOnClick (NavigateTo Archive)
        ]
        |> Ui.List.view


# Type

@docs Listing, Item


# Configuration

@docs Variant


# Constructors

@docs new, item, actionItem


# Host attributes

@docs withAttributes


# List-level modifiers

@docs withVariant, withId


# Item modifiers

@docs withItemLeadingIcon, withItemTrailingIcon, withItemOverline
@docs withItemSupporting, withItemOnClick, withItemDisabled


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.List
import M3e.ListItem
import M3e.ListItemButton
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A list (named `Listing` to avoid shadowing Elm's `List`).
-}
type Listing msg
    = Listing (ListConfig msg)


{-| One row in a list.
-}
type Item msg
    = Item (ItemConfig msg)


{-| List visual style (m3e variant axis). Default `Standard`.
-}
type Variant
    = Standard
    | Segmented


type alias ListConfig msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , variant : Variant
    , items : List (Item msg)
    }


type alias ItemConfig msg =
    { headline : String
    , overline : Maybe String
    , supporting : Maybe String
    , leadingIcon : Maybe (Ui.Icon.Icon msg)
    , trailingIcon : Maybe (Ui.Icon.Icon msg)
    , onClick : Maybe msg
    , disabled : Bool
    , interactive : Bool
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a list from items.
-}
new : List (Item msg) -> Listing msg
new items =
    Listing
        { id = Nothing
        , attributes = []
        , variant = Standard
        , items = items
        }


{-| Construct a static, non-interactive list item (`<m3e-list-item>`)
with required headline text.

    Ui.List.item "Inbox"
        |> Ui.List.withItemLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.inbox)

A static item has no activation affordance — `withItemOnClick` and
`withItemDisabled` are no-ops on it (the underlying `<m3e-list-item>`
element neither dispatches clicks nor honours `disabled`). Use
[`actionItem`](#actionItem) for an interactive row.

-}
item : String -> Item msg
item headline =
    Item
        { headline = headline
        , overline = Nothing
        , supporting = Nothing
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , onClick = Nothing
        , disabled = False
        , interactive = False
        }


{-| Construct an interactive list item (`<m3e-list-item-button>`) with
required headline text. Pair with [`withItemOnClick`](#withItemOnClick)
to handle activation, and [`withItemDisabled`](#withItemDisabled) to
disable it.

    Ui.List.actionItem "Open settings"
        |> Ui.List.withItemLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.gear)
        |> Ui.List.withItemOnClick OpenSettings

-}
actionItem : String -> Item msg
actionItem headline =
    Item
        { headline = headline
        , overline = Nothing
        , supporting = Nothing
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , onClick = Nothing
        , disabled = False
        , interactive = True
        }



-- LIST-LEVEL MODIFIERS ---------------------------------------------------


{-| Append attributes to the underlying `<m3e-list>` host element — the
escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Listing msg -> Listing msg
withAttributes attributes (Listing cfg) =
    Listing { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the list's visual variant.
-}
withVariant : Variant -> Listing msg -> Listing msg
withVariant v (Listing cfg) =
    Listing { cfg | variant = v }


{-| Set the `id` attribute on the underlying `<m3e-list>`.
-}
withId : String -> Listing msg -> Listing msg
withId id (Listing cfg) =
    Listing { cfg | id = Just id }



-- ITEM MODIFIERS ---------------------------------------------------------


{-| Add a leading icon to an item.
-}
withItemLeadingIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemLeadingIcon icon (Item cfg) =
    Item { cfg | leadingIcon = Just icon }


{-| Add a trailing icon to an item.
-}
withItemTrailingIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemTrailingIcon icon (Item cfg) =
    Item { cfg | trailingIcon = Just icon }


{-| Set overline text (small label above the headline).
-}
withItemOverline : String -> Item msg -> Item msg
withItemOverline text (Item cfg) =
    Item { cfg | overline = Just text }


{-| Set supporting text (below the headline).
-}
withItemSupporting : String -> Item msg -> Item msg
withItemSupporting text (Item cfg) =
    Item { cfg | supporting = Just text }


{-| Wire a click handler. Only meaningful on an [`actionItem`](#actionItem)
(`<m3e-list-item-button>`); on a static [`item`](#item) it is ignored,
since `<m3e-list-item>` is non-interactive.
-}
withItemOnClick : msg -> Item msg -> Item msg
withItemOnClick msg (Item cfg) =
    Item { cfg | onClick = Just msg }


{-| Mark the item disabled. Only meaningful on an
[`actionItem`](#actionItem); static [`item`](#item) rows ignore it.
-}
withItemDisabled : Bool -> Item msg -> Item msg
withItemDisabled b (Item cfg) =
    Item { cfg | disabled = b }



-- RENDER -----------------------------------------------------------------


{-| Render the list to `Html`.
-}
view : Listing msg -> Html msg
view (Listing cfg) =
    M3e.List.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (variantAttr cfg.variant)
                ]
        )
        (List.map itemView cfg.items)


itemView : Item msg -> Html msg
itemView (Item cfg) =
    if cfg.interactive then
        M3e.ListItemButton.component
            (List.filterMap identity
                [ if cfg.disabled then
                    Just (M3e.ListItemButton.disabled True)

                  else
                    Nothing
                , Maybe.map HtmlEvents.onClick cfg.onClick
                ]
            )
            (itemChildren cfg)

    else
        -- `<m3e-list-item>` is non-interactive and has no `disabled`
        -- attribute, so neither onClick nor disabled is emitted here.
        M3e.ListItem.component [] (itemChildren cfg)


itemChildren : ItemConfig msg -> List (Html msg)
itemChildren cfg =
    List.concat
        [ leadingSlot cfg.leadingIcon
        , overlineSlot cfg.overline
        , [ Html.text cfg.headline ]
        , supportingSlot cfg.supporting
        , trailingSlot cfg.trailingIcon
        ]


leadingSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
leadingSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.ListItem.leadingSlot ] [ Ui.Icon.view i ] ]


trailingSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
trailingSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.ListItem.trailingSlot ] [ Ui.Icon.view i ] ]


overlineSlot : Maybe String -> List (Html msg)
overlineSlot text =
    case text of
        Nothing ->
            []

        Just t ->
            [ Html.span [ M3e.ListItem.overlineSlot ] [ Html.text t ] ]


supportingSlot : Maybe String -> List (Html msg)
supportingSlot text =
    case text of
        Nothing ->
            []

        Just t ->
            [ Html.span [ M3e.ListItem.supportingTextSlot ] [ Html.text t ] ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Standard ->
            M3e.List.variant M3e.List.Standard

        Segmented ->
            M3e.List.variant M3e.List.Segmented
