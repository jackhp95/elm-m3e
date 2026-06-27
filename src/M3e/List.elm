module M3e.List exposing
    ( view
    , item, actionItem, option, divider, expandable
    , Variant(..), Option
    , StaticItemOption, ActionItemOption, OptionItemOption, ExpandableItemOption
    , variant, id
    , staticLeading, staticTrailing, staticOverline, staticSupporting
    , actionLeading, actionTrailing, actionOverline, actionSupporting, actionDisabled, actionOnClick
    , optionLeading, optionOverline, optionSupporting, optionDisabled, optionSelected, optionValue, optionOnChange
    , expandableLeading, expandableOverline, expandableSupporting, expandableDisabled, expandableOpen
    )

{-| `<m3e-list>` + kind-typed item constructors — a vertical collection of rows
(Material 3 Lists). The module is named `M3e.List`; kind-specific options live
on the right constructor so no modifier is ever a silent no-op.

Spec (per docs/CONVENTIONS.md):

  - Required (container): `{ items }` — the item list
  - Required (item / actionItem / option / expandable): `{ headline }` — visible text
  - Required (expandable): `{ headline, children }` — nested rows in the items slot
  - Kinds → tags:
    item → `<m3e-list-item>` (static, non-interactive)
    actionItem → `<m3e-list-item-button>` (interactive)
    option → `<m3e-list-option>` (selectable)
    divider → `<m3e-divider>`
    expandable → `<m3e-expandable-list-item>`
  - Slots: leading / trailing (element); overline / supporting-text (String→span)
    expandable children land in the `items` slot
  - Properties: disabled (action/option/expandable), selected (option), open (expandable)
  - Events: onClick (actionItem), onChange (option)
  - Tag: list / listItem

@docs view
@docs item, actionItem, option, divider, expandable
@docs Variant, Option
@docs StaticItemOption, ActionItemOption, OptionItemOption, ExpandableItemOption
@docs variant, id
@docs staticLeading, staticTrailing, staticOverline, staticSupporting
@docs actionLeading, actionTrailing, actionOverline, actionSupporting, actionDisabled, actionOnClick
@docs optionLeading, optionOverline, optionSupporting, optionDisabled, optionSelected, optionValue, optionOnChange
@docs expandableLeading, expandableOverline, expandableSupporting, expandableDisabled, expandableOpen

-}

import Cem.M3e.List as CemList
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES -------------------------------------------------------------------


{-| Visual style of the list. Default `Standard`.
-}
type Variant
    = Standard
    | Segmented



-- OPTION TYPES (KIND-SPECIFIC) --------------------------------------------


{-| Option for a static `item`.
-}
type alias StaticItemOption msg =
    Internal.Option (StaticConfig msg) msg


{-| Option for an `actionItem`.
-}
type alias ActionItemOption msg =
    Internal.Option (ActionConfig msg) msg


{-| Option for a selectable `option` item.
-}
type alias OptionItemOption msg =
    Internal.Option (OptionConfig msg) msg


{-| Option for an `expandable` item.
-}
type alias ExpandableItemOption msg =
    Internal.Option (ExpandableConfig msg) msg


{-| Option for the list container (`view`).
-}
type alias Option msg =
    Internal.Option ContainerConfig msg



-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Add a leading element to a static item.
-}
staticLeading : Renderable { element : Supported } msg -> StaticItemOption msg
staticLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Add a trailing element to a static item.
-}
staticTrailing : Renderable { element : Supported } msg -> StaticItemOption msg
staticTrailing r =
    Internal.option (\c -> { c | trailing = Just r })


{-| Set overline text on a static item.
-}
staticOverline : String -> StaticItemOption msg
staticOverline s =
    Internal.option (\c -> { c | overline = Just s })


{-| Set supporting text on a static item.
-}
staticSupporting : String -> StaticItemOption msg
staticSupporting s =
    Internal.option (\c -> { c | supporting = Just s })


{-| Add a leading element to an action item.
-}
actionLeading : Renderable { element : Supported } msg -> ActionItemOption msg
actionLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Add a trailing element to an action item.
-}
actionTrailing : Renderable { element : Supported } msg -> ActionItemOption msg
actionTrailing r =
    Internal.option (\c -> { c | trailing = Just r })


{-| Set overline text on an action item.
-}
actionOverline : String -> ActionItemOption msg
actionOverline s =
    Internal.option (\c -> { c | overline = Just s })


{-| Set supporting text on an action item.
-}
actionSupporting : String -> ActionItemOption msg
actionSupporting s =
    Internal.option (\c -> { c | supporting = Just s })


{-| Disable an action item.
-}
actionDisabled : Bool -> ActionItemOption msg
actionDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Wire a click handler for an action item.
-}
actionOnClick : msg -> ActionItemOption msg
actionOnClick msg =
    Internal.option (\c -> { c | onClick = Just msg })


{-| Add a leading element to a selectable option item.
-}
optionLeading : Renderable { element : Supported } msg -> OptionItemOption msg
optionLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Set overline text on a selectable option item.
-}
optionOverline : String -> OptionItemOption msg
optionOverline s =
    Internal.option (\c -> { c | overline = Just s })


{-| Set supporting text on a selectable option item.
-}
optionSupporting : String -> OptionItemOption msg
optionSupporting s =
    Internal.option (\c -> { c | supporting = Just s })


{-| Disable a selectable option item.
-}
optionDisabled : Bool -> OptionItemOption msg
optionDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Set whether a selectable option item is selected (the `selected` DOM property).
-}
optionSelected : Bool -> OptionItemOption msg
optionSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Set the form-submission value of a selectable option item.
-}
optionValue : String -> OptionItemOption msg
optionValue v =
    Internal.option (\c -> { c | value = Just v })


{-| React to a selectable option being toggled. The handler receives the new
selected state.
-}
optionOnChange : (Bool -> msg) -> OptionItemOption msg
optionOnChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Add a leading element to an expandable item.
-}
expandableLeading : Renderable { element : Supported } msg -> ExpandableItemOption msg
expandableLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Set overline text on an expandable item.
-}
expandableOverline : String -> ExpandableItemOption msg
expandableOverline s =
    Internal.option (\c -> { c | overline = Just s })


{-| Set supporting text on an expandable item.
-}
expandableSupporting : String -> ExpandableItemOption msg
expandableSupporting s =
    Internal.option (\c -> { c | supporting = Just s })


{-| Disable an expandable item.
-}
expandableDisabled : Bool -> ExpandableItemOption msg
expandableDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Control the expanded state of an expandable item (the `open` DOM property).
-}
expandableOpen : Bool -> ExpandableItemOption msg
expandableOpen b =
    Internal.option (\c -> { c | open = b })


{-| Set the `id` attribute on the `<m3e-list>` element.
-}
id : String -> Option msg
id newId =
    Internal.option (\c -> { c | id = Just newId })


{-| Set the visual style of the list. Default `Standard`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })



-- ITEM CONSTRUCTORS -------------------------------------------------------


{-| A static, non-interactive list item (`<m3e-list-item>`).

    M3e.List.item { headline = "Inbox" }
        [ M3e.List.staticLeading myIconElement
        , M3e.List.staticSupporting "12 unread"
        ]

-}
item :
    { headline : String }
    -> List (StaticItemOption msg)
    -> Renderable { listItem : Supported } msg
item req opts =
    let
        c =
            Internal.applyOptions opts defaultStaticConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-item"
            []
            (decorationNodes c.leading c.overline c.supporting c.trailing req.headline)
        )


{-| An interactive list item (`<m3e-list-item-button>`).

    M3e.List.actionItem { headline = "Open settings" }
        [ M3e.List.actionOnClick OpenSettings
        , M3e.List.actionLeading myGearIcon
        ]

-}
actionItem :
    { headline : String }
    -> List (ActionItemOption msg)
    -> Renderable { listItem : Supported } msg
actionItem req opts =
    let
        c =
            Internal.applyOptions opts defaultActionConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-item-button"
            (List.filterMap identity
                [ if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\msg -> Node.on "click" (Decode.succeed msg)) c.onClick
                ]
            )
            (decorationNodes c.leading c.overline c.supporting c.trailing req.headline)
        )


{-| A selectable list option (`<m3e-list-option>`).

    M3e.List.option { headline = "Wi-Fi" }
        [ M3e.List.optionSelected model.wifiOn
        , M3e.List.optionOnChange WifiToggled
        ]

-}
option :
    { headline : String }
    -> List (OptionItemOption msg)
    -> Renderable { listItem : Supported } msg
option req opts =
    let
        c =
            Internal.applyOptions opts defaultOptionConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-option"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool c.selected))
                , Maybe.map (Node.attribute "value") c.value
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\f -> Node.on "click" (Decode.succeed (f (not c.selected))))
                    c.onChange
                ]
            )
            (decorationNodes c.leading c.overline c.supporting Nothing req.headline)
        )


{-| A thin separator row (`<m3e-divider>`).
-}
divider : Renderable { listItem : Supported } msg
divider =
    Internal.fromNode (Node.element "m3e-divider" [] [])


{-| An expandable list item (`<m3e-expandable-list-item>`). Children are
injected into the `items` slot automatically.

    M3e.List.expandable
        { headline = "Folders"
        , children =
            [ M3e.List.item { headline = "Drafts" } []
            , M3e.List.item { headline = "Sent" } []
            ]
        }
        [ M3e.List.expandableOpen True ]

-}
expandable :
    { headline : String
    , children : List (Renderable { listItem : Supported } msg)
    }
    -> List (ExpandableItemOption msg)
    -> Renderable { listItem : Supported } msg
expandable req opts =
    let
        c =
            Internal.applyOptions opts defaultExpandableConfig

        childNodes =
            List.map (Node.withSlot "items" << Renderable.toNode) req.children
    in
    Internal.fromNode
        (Node.element "m3e-expandable-list-item"
            (List.filterMap identity
                [ if c.open then
                    Just (Node.property "open" (Encode.bool True))

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (decorationNodes c.leading c.overline c.supporting Nothing req.headline
                ++ childNodes
            )
        )



-- CONTAINER ---------------------------------------------------------------


{-| Render the list element.

    M3e.List.view
        { items =
            [ M3e.List.item { headline = "Inbox" } []
            , M3e.List.divider
            , M3e.List.actionItem { headline = "Settings" }
                [ M3e.List.actionOnClick OpenSettings ]
            ]
        }
        []

-}
view :
    { items : List (Renderable { listItem : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | list : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultContainerConfig
    in
    Internal.fromNode
        (Node.element "m3e-list"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemList.variant (toCemVariant c.variant)))
                ]
            )
            (List.map Renderable.toNode req.items)
        )



-- INTERNAL ----------------------------------------------------------------


type alias StaticConfig msg =
    { leading : Maybe (Renderable { element : Supported } msg)
    , trailing : Maybe (Renderable { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    }


defaultStaticConfig : StaticConfig msg
defaultStaticConfig =
    { leading = Nothing, trailing = Nothing, overline = Nothing, supporting = Nothing }


type alias ActionConfig msg =
    { leading : Maybe (Renderable { element : Supported } msg)
    , trailing : Maybe (Renderable { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    , disabled : Bool
    , onClick : Maybe msg
    }


defaultActionConfig : ActionConfig msg
defaultActionConfig =
    { leading = Nothing
    , trailing = Nothing
    , overline = Nothing
    , supporting = Nothing
    , disabled = False
    , onClick = Nothing
    }


type alias OptionConfig msg =
    { leading : Maybe (Renderable { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    , disabled : Bool
    , selected : Bool
    , value : Maybe String
    , onChange : Maybe (Bool -> msg)
    }


defaultOptionConfig : OptionConfig msg
defaultOptionConfig =
    { leading = Nothing
    , overline = Nothing
    , supporting = Nothing
    , disabled = False
    , selected = False
    , value = Nothing
    , onChange = Nothing
    }


type alias ExpandableConfig msg =
    { leading : Maybe (Renderable { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    , disabled : Bool
    , open : Bool
    }


defaultExpandableConfig : ExpandableConfig msg
defaultExpandableConfig =
    { leading = Nothing, overline = Nothing, supporting = Nothing, disabled = False, open = False }


type alias ContainerConfig =
    { id : Maybe String
    , variant : Variant
    }


defaultContainerConfig : ContainerConfig
defaultContainerConfig =
    { id = Nothing, variant = Standard }


{-| Build the common decoration children for any list item kind.
-}
decorationNodes :
    Maybe (Renderable { element : Supported } msg)
    -> Maybe String
    -> Maybe String
    -> Maybe (Renderable { element : Supported } msg)
    -> String
    -> List (Node.Node msg)
decorationNodes leading_ overline_ supporting_ trailing_ headline =
    List.filterMap identity
        [ Maybe.map (\r -> Node.withSlot "leading" (Renderable.toNode r)) leading_
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "overline" ] [ Node.text s ]) overline_
        , Just (Node.text headline)
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "supporting-text" ] [ Node.text s ]) supporting_
        , Maybe.map (\r -> Node.withSlot "trailing" (Renderable.toNode r)) trailing_
        ]


toCemVariant : Variant -> CemList.Variant
toCemVariant v =
    case v of
        Standard ->
            CemList.Standard

        Segmented ->
            CemList.Segmented
