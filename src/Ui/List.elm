module Ui.List exposing
    ( Listing, Item
    , Variant(..)
    , new, item, actionItem, option, divider, expandable
    , withAttributes
    , withVariant, withId
    , withItemLeadingIcon, withItemTrailingIcon, withItemOverline
    , withItemSupporting, withItemOnClick, withItemDisabled
    , withItemLeadingHtml, withItemTrailingHtml
    , withItemSelected, withItemValue, withItemOnChange
    , withItemOpen, withItemChildren
    , view
    )

{-| Typed builder for `<m3e-list>` and its rows — a vertical collection
of items. Mirrors the Material 3 [Lists][m3] surface.

[m3]: https://m3.material.io/components/lists/overview

Use a list to render rows of items — optionally selectable, actionable, or
expandable. Shallow nesting is covered by the [`expandable`](#expandable)
row; for date input reach for `Ui.Calendar` / `Ui.DatePicker` instead. A
list's rows are the building block; for a single subject's content+actions
use `Ui.Card`.

The module is named `Ui.List` to honor the m3-doc-page rule, but the
opaque type is `Listing` to avoid shadowing Elm's core `List` type at
call sites.


# Required-by-design

  - `new` — takes the list of items.
  - `item` — a static, non-interactive row (`<m3e-list-item>`). Required
    `headline` text plus optional decorations via `withItem*` setters.
  - `actionItem` — an interactive row (`<m3e-list-item-button>`). Pair
    with [`withItemOnClick`](#withItemOnClick) to handle activation.
  - `option` — a selectable row (`<m3e-list-option>`). Wire its state
    with [`withItemSelected`](#withItemSelected) and
    [`withItemOnChange`](#withItemOnChange).
  - `divider` — a thin separator row (`<m3e-divider>`).
  - `expandable` — a row that expands to reveal nested rows
    (`<m3e-expandable-list-item>`). Supply children with
    [`withItemChildren`](#withItemChildren).

The rendered element is chosen at the **call site** by which constructor
you use — never inferred from whether a modifier happens to be present.


# Quick example

    Ui.List.new
        [ Ui.List.item "Inbox"
            |> Ui.List.withItemLeadingIcon (Ui.Icon.fontAwesome Icon.FontAwesome.inbox)
            |> Ui.List.withItemSupporting "12 unread"
        , Ui.List.divider
        , Ui.List.actionItem "Open settings"
            |> Ui.List.withItemOnClick OpenSettings
        , Ui.List.expandable "More"
            |> Ui.List.withItemChildren
                [ Ui.List.item "Nested A"
                , Ui.List.item "Nested B"
                ]
        ]
        |> Ui.List.view


# Type

@docs Listing, Item


# Configuration

@docs Variant


# Constructors

@docs new, item, actionItem, option, divider, expandable


# Host attributes

@docs withAttributes


# List-level modifiers

@docs withVariant, withId


# Item modifiers

@docs withItemLeadingIcon, withItemTrailingIcon, withItemOverline
@docs withItemSupporting, withItemOnClick, withItemDisabled
@docs withItemLeadingHtml, withItemTrailingHtml


# Option modifiers

@docs withItemSelected, withItemValue, withItemOnChange


# Expandable modifiers

@docs withItemOpen, withItemChildren


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Divider
import M3e.ExpandableListItem
import M3e.List
import M3e.ListItem
import M3e.ListItemButton
import M3e.ListOption
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A list (named `Listing` to avoid shadowing Elm's `List`).
-}
type Listing msg
    = Listing (ListConfig msg)


{-| One row in a list. Which `<m3e-*>` element it renders is fixed by the
constructor used to make it ([`item`](#item), [`actionItem`](#actionItem),
[`option`](#option), [`divider`](#divider), or [`expandable`](#expandable));
a modifier that does not apply to a row's kind is a no-op.
-}
type Item msg
    = Item (ItemConfig msg)
    | DividerItem (List (Attribute msg))


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
    , leadingHtml : Maybe (Html msg)
    , trailingHtml : Maybe (Html msg)
    , onClick : Maybe msg
    , disabled : Bool
    , kind : ItemKind msg
    }


{-| Per-row kind-specific state. Internal — the row's element is selected
from this, never inferred from modifier presence.
-}
type ItemKind msg
    = Static
    | Action
    | Selectable (SelectableData msg)
    | Expandable (ExpandableData msg)


type alias SelectableData msg =
    { selected : Bool
    , value : Maybe String
    , onChange : Maybe (Bool -> msg)
    }


type alias ExpandableData msg =
    { open : Bool
    , items : List (Item msg)
    }


emptyItem : ItemKind msg -> String -> Item msg
emptyItem kind headline =
    Item
        { headline = headline
        , overline = Nothing
        , supporting = Nothing
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , leadingHtml = Nothing
        , trailingHtml = Nothing
        , onClick = Nothing
        , disabled = False
        , kind = kind
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
    emptyItem Static headline


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
    emptyItem Action headline


{-| Construct a selectable list option (`<m3e-list-option>`) with required
headline text. Drive its state from your model with
[`withItemSelected`](#withItemSelected) and react to toggles with
[`withItemOnChange`](#withItemOnChange); the handler receives the new
selected value. Optionally tag the option with a submission
[`withItemValue`](#withItemValue).

    Ui.List.option "Wi-Fi"
        |> Ui.List.withItemSelected model.wifiOn
        |> Ui.List.withItemOnChange WifiToggled

-}
option : String -> Item msg
option headline =
    emptyItem
        (Selectable { selected = False, value = Nothing, onChange = Nothing })
        headline


{-| Construct a separator row (`<m3e-divider>`) to place between items.
-}
divider : Item msg
divider =
    DividerItem []


{-| Construct an expandable list item (`<m3e-expandable-list-item>`) with
required headline text. It shows the same leading/overline/supporting
decorations as a regular item and reveals nested rows (supplied with
[`withItemChildren`](#withItemChildren)) when expanded. Control the
expanded state with [`withItemOpen`](#withItemOpen).

The underlying element does not expose a trailing slot (it renders its
own expand/collapse toggle there), so `withItemTrailingIcon` /
`withItemTrailingHtml` are no-ops on an expandable row.

    Ui.List.expandable "Folders"
        |> Ui.List.withItemOpen True
        |> Ui.List.withItemChildren
            [ Ui.List.item "Drafts"
            , Ui.List.item "Sent"
            ]

-}
expandable : String -> Item msg
expandable headline =
    emptyItem (Expandable { open = False, items = [] }) headline



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


{-| Map the shared config of any item row; a no-op on a [`divider`](#divider).
-}
mapConfig : (ItemConfig msg -> ItemConfig msg) -> Item msg -> Item msg
mapConfig f item_ =
    case item_ of
        Item cfg ->
            Item (f cfg)

        DividerItem _ ->
            item_


{-| Map the kind-specific state of an item row; a no-op on a divider.
-}
mapKind : (ItemKind msg -> ItemKind msg) -> Item msg -> Item msg
mapKind f =
    mapConfig (\cfg -> { cfg | kind = f cfg.kind })


{-| Add a leading icon to an item. Overridden by
[`withItemLeadingHtml`](#withItemLeadingHtml) if both are set.
-}
withItemLeadingIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemLeadingIcon icon =
    mapConfig (\cfg -> { cfg | leadingIcon = Just icon })


{-| Add a trailing icon to an item. Overridden by
[`withItemTrailingHtml`](#withItemTrailingHtml) if both are set. A no-op on
an [`expandable`](#expandable) row (it has no trailing slot).
-}
withItemTrailingIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemTrailingIcon icon =
    mapConfig (\cfg -> { cfg | trailingIcon = Just icon })


{-| Put arbitrary `Html` in the row's leading slot — the escape hatch for
leading content the typed [`withItemLeadingIcon`](#withItemLeadingIcon) can't
express, such as an avatar or checkbox. Wins over a leading icon if both are
set.
-}
withItemLeadingHtml : Html msg -> Item msg -> Item msg
withItemLeadingHtml html =
    mapConfig (\cfg -> { cfg | leadingHtml = Just html })


{-| Put arbitrary `Html` in the row's trailing slot — the escape hatch for
trailing content the typed [`withItemTrailingIcon`](#withItemTrailingIcon)
can't express. Wins over a trailing icon if both are set. A no-op on an
[`expandable`](#expandable) row (it has no trailing slot).
-}
withItemTrailingHtml : Html msg -> Item msg -> Item msg
withItemTrailingHtml html =
    mapConfig (\cfg -> { cfg | trailingHtml = Just html })


{-| Set overline text (small label above the headline).
-}
withItemOverline : String -> Item msg -> Item msg
withItemOverline text =
    mapConfig (\cfg -> { cfg | overline = Just text })


{-| Set supporting text (below the headline).
-}
withItemSupporting : String -> Item msg -> Item msg
withItemSupporting text =
    mapConfig (\cfg -> { cfg | supporting = Just text })


{-| Wire a click handler. Only meaningful on an [`actionItem`](#actionItem)
(`<m3e-list-item-button>`); on other row kinds it is ignored.
-}
withItemOnClick : msg -> Item msg -> Item msg
withItemOnClick msg =
    mapConfig (\cfg -> { cfg | onClick = Just msg })


{-| Mark the item disabled. Meaningful on [`actionItem`](#actionItem),
[`option`](#option), and [`expandable`](#expandable) rows; a static
[`item`](#item) ignores it (`<m3e-list-item>` is non-interactive).
-}
withItemDisabled : Bool -> Item msg -> Item msg
withItemDisabled b =
    mapConfig (\cfg -> { cfg | disabled = b })


{-| Set whether an [`option`](#option) row is selected. A no-op on other
row kinds.
-}
withItemSelected : Bool -> Item msg -> Item msg
withItemSelected b =
    mapKind
        (\kind ->
            case kind of
                Selectable data ->
                    Selectable { data | selected = b }

                _ ->
                    kind
        )


{-| Tag an [`option`](#option) row with a submission value (the option's
`value` attribute). A no-op on other row kinds.
-}
withItemValue : String -> Item msg -> Item msg
withItemValue v =
    mapKind
        (\kind ->
            case kind of
                Selectable data ->
                    Selectable { data | value = Just v }

                _ ->
                    kind
        )


{-| React to an [`option`](#option) row toggling. The handler receives the
new selected value (the opposite of the current
[`withItemSelected`](#withItemSelected) state). A no-op on other row kinds.
-}
withItemOnChange : (Bool -> msg) -> Item msg -> Item msg
withItemOnChange f =
    mapKind
        (\kind ->
            case kind of
                Selectable data ->
                    Selectable { data | onChange = Just f }

                _ ->
                    kind
        )


{-| Set whether an [`expandable`](#expandable) row is open. A no-op on
other row kinds.
-}
withItemOpen : Bool -> Item msg -> Item msg
withItemOpen b =
    mapKind
        (\kind ->
            case kind of
                Expandable data ->
                    Expandable { data | open = b }

                _ ->
                    kind
        )


{-| Supply the nested rows revealed when an [`expandable`](#expandable) row
is open. A no-op on other row kinds.
-}
withItemChildren : List (Item msg) -> Item msg -> Item msg
withItemChildren children =
    mapKind
        (\kind ->
            case kind of
                Expandable data ->
                    Expandable { data | items = children }

                _ ->
                    kind
        )



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
        (List.map (itemViewWith []) cfg.items)


itemViewWith : List (Attribute msg) -> Item msg -> Html msg
itemViewWith extra item_ =
    case item_ of
        DividerItem attrs ->
            M3e.Divider.component (extra ++ attrs) []

        Item cfg ->
            case cfg.kind of
                Static ->
                    -- `<m3e-list-item>` is non-interactive and has no
                    -- `disabled` attribute, so neither onClick nor disabled
                    -- is emitted here.
                    M3e.ListItem.component extra (decorationChildren True cfg)

                Action ->
                    M3e.ListItemButton.component (extra ++ actionAttrs cfg)
                        (decorationChildren True cfg)

                Selectable data ->
                    M3e.ListOption.component (extra ++ optionAttrs cfg data)
                        (decorationChildren True cfg)

                Expandable data ->
                    M3e.ExpandableListItem.component (extra ++ expandableAttrs cfg data)
                        (decorationChildren False cfg ++ nestedChildren data)


actionAttrs : ItemConfig msg -> List (Attribute msg)
actionAttrs cfg =
    List.filterMap identity
        [ if cfg.disabled then
            Just (M3e.ListItemButton.disabled True)

          else
            Nothing
        , Maybe.map HtmlEvents.onClick cfg.onClick
        ]


optionAttrs : ItemConfig msg -> SelectableData msg -> List (Attribute msg)
optionAttrs cfg data =
    List.filterMap identity
        [ Just (M3e.ListOption.selected data.selected)
        , Maybe.map M3e.ListOption.value data.value
        , if cfg.disabled then
            Just (M3e.ListOption.disabled True)

          else
            Nothing

        -- Selection is owned by Elm (controlled component, like Ui.Select):
        -- a click reports the toggled value via onChange. The element also
        -- dispatches a native `change` event, but driving from `click`
        -- keeps the new value deterministic without decoding DOM state.
        , Maybe.map (\f -> HtmlEvents.onClick (f (not data.selected))) data.onChange
        ]


expandableAttrs : ItemConfig msg -> ExpandableData msg -> List (Attribute msg)
expandableAttrs cfg data =
    List.filterMap identity
        [ if data.open then
            Just (M3e.ExpandableListItem.open True)

          else
            Nothing
        , if cfg.disabled then
            Just (M3e.ExpandableListItem.disabled True)

          else
            Nothing
        ]


nestedChildren : ExpandableData msg -> List (Html msg)
nestedChildren data =
    List.map (itemViewWith [ M3e.ExpandableListItem.itemsSlot ]) data.items


decorationChildren : Bool -> ItemConfig msg -> List (Html msg)
decorationChildren includeTrailing cfg =
    List.concat
        [ leadingChildren cfg
        , overlineSlot cfg.overline
        , [ Html.text cfg.headline ]
        , supportingSlot cfg.supporting
        , if includeTrailing then
            trailingChildren cfg

          else
            []
        ]


leadingChildren : ItemConfig msg -> List (Html msg)
leadingChildren cfg =
    case ( cfg.leadingHtml, cfg.leadingIcon ) of
        ( Just html, _ ) ->
            [ Html.span [ M3e.ListItem.leadingSlot ] [ html ] ]

        ( Nothing, Just icon ) ->
            [ Html.span [ M3e.ListItem.leadingSlot ] [ Ui.Icon.view icon ] ]

        ( Nothing, Nothing ) ->
            []


trailingChildren : ItemConfig msg -> List (Html msg)
trailingChildren cfg =
    case ( cfg.trailingHtml, cfg.trailingIcon ) of
        ( Just html, _ ) ->
            [ Html.span [ M3e.ListItem.trailingSlot ] [ html ] ]

        ( Nothing, Just icon ) ->
            [ Html.span [ M3e.ListItem.trailingSlot ] [ Ui.Icon.view icon ] ]

        ( Nothing, Nothing ) ->
            []


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
