module M3e.List exposing
    ( Variant(..)
    , StaticItemOption, ActionItemOption, OptionItemOption, ExpandableItemOption, Option
    , view
    , item, actionItem, option, divider, expandable
    , staticLeading, staticTrailing, staticOverline, staticSupporting
    , actionLeading, actionTrailing, actionOverline, actionSupporting
    , actionDisabled, actionOnClick
    , optionLeading, optionOverline, optionSupporting
    , optionDisabled, optionSelected, optionValue, optionOnChange
    , expandableLeading, expandableOverline, expandableSupporting
    , expandableDisabled, expandableOpen
    , withId, variant
    )

{-| `<m3e-list>` + kind-typed item constructors — a vertical collection of rows
(Material 3 Lists). The module is named `M3e.List`; kind-specific options live
on the right constructor so no modifier is ever a silent no-op.

Spec (per docs/CONVENTIONS.md):

  - Required (container): `{ items }` — the item list
  - Required (item / actionItem / option / expandable): `{ headline }` — visible text
  - Required (expandable): `{ headline, children }` — nested rows in the items slot
  - Kinds → tags:
      item        → `<m3e-list-item>` (static, non-interactive)
      actionItem  → `<m3e-list-item-button>` (interactive)
      option      → `<m3e-list-option>` (selectable)
      divider     → `<m3e-divider>`
      expandable  → `<m3e-expandable-list-item>`
  - Slots: leading / trailing (element); overline / supporting-text (String→span)
    expandable children land in the `items` slot
  - Properties: disabled (action/option/expandable), selected (option), open (expandable)
  - Events: onClick (actionItem), onChange (option)
  - Tag: list / listItem

-}

import Cem.M3e.List as CemList
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


-- TYPES -------------------------------------------------------------------


{-| Visual style of the list. Default `Standard`. -}
type Variant
    = Standard
    | Segmented


-- OPTION TYPES (KIND-SPECIFIC) --------------------------------------------


type StaticItemOption msg
    = StaticLeading (Renderable { element : Supported } msg)
    | StaticTrailing (Renderable { element : Supported } msg)
    | StaticOverline String
    | StaticSupporting String


type ActionItemOption msg
    = ActionLeading (Renderable { element : Supported } msg)
    | ActionTrailing (Renderable { element : Supported } msg)
    | ActionOverline String
    | ActionSupporting String
    | ActionDisabled Bool
    | ActionOnClick msg


type OptionItemOption msg
    = OptionLeading (Renderable { element : Supported } msg)
    | OptionOverline String
    | OptionSupporting String
    | OptionDisabled Bool
    | OptionSelected Bool
    | OptionValue String
    | OptionOnChange (Bool -> msg)


type ExpandableItemOption msg
    = ExpandableLeading (Renderable { element : Supported } msg)
    | ExpandableOverline String
    | ExpandableSupporting String
    | ExpandableDisabled Bool
    | ExpandableOpen Bool


type Option msg
    = WithId String
    | VariantOpt Variant


-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Add a leading element to a static item. -}
staticLeading : Renderable { element : Supported } msg -> StaticItemOption msg
staticLeading =
    StaticLeading


{-| Add a trailing element to a static item. -}
staticTrailing : Renderable { element : Supported } msg -> StaticItemOption msg
staticTrailing =
    StaticTrailing


{-| Set overline text on a static item. -}
staticOverline : String -> StaticItemOption msg
staticOverline =
    StaticOverline


{-| Set supporting text on a static item. -}
staticSupporting : String -> StaticItemOption msg
staticSupporting =
    StaticSupporting


{-| Add a leading element to an action item. -}
actionLeading : Renderable { element : Supported } msg -> ActionItemOption msg
actionLeading =
    ActionLeading


{-| Add a trailing element to an action item. -}
actionTrailing : Renderable { element : Supported } msg -> ActionItemOption msg
actionTrailing =
    ActionTrailing


{-| Set overline text on an action item. -}
actionOverline : String -> ActionItemOption msg
actionOverline =
    ActionOverline


{-| Set supporting text on an action item. -}
actionSupporting : String -> ActionItemOption msg
actionSupporting =
    ActionSupporting


{-| Disable an action item. -}
actionDisabled : Bool -> ActionItemOption msg
actionDisabled =
    ActionDisabled


{-| Wire a click handler for an action item. -}
actionOnClick : msg -> ActionItemOption msg
actionOnClick =
    ActionOnClick


{-| Add a leading element to a selectable option item. -}
optionLeading : Renderable { element : Supported } msg -> OptionItemOption msg
optionLeading =
    OptionLeading


{-| Set overline text on a selectable option item. -}
optionOverline : String -> OptionItemOption msg
optionOverline =
    OptionOverline


{-| Set supporting text on a selectable option item. -}
optionSupporting : String -> OptionItemOption msg
optionSupporting =
    OptionSupporting


{-| Disable a selectable option item. -}
optionDisabled : Bool -> OptionItemOption msg
optionDisabled =
    OptionDisabled


{-| Set whether a selectable option item is selected (the `selected` DOM property). -}
optionSelected : Bool -> OptionItemOption msg
optionSelected =
    OptionSelected


{-| Set the form-submission value of a selectable option item. -}
optionValue : String -> OptionItemOption msg
optionValue =
    OptionValue


{-| React to a selectable option being toggled. The handler receives the new
selected state. -}
optionOnChange : (Bool -> msg) -> OptionItemOption msg
optionOnChange =
    OptionOnChange


{-| Add a leading element to an expandable item. -}
expandableLeading : Renderable { element : Supported } msg -> ExpandableItemOption msg
expandableLeading =
    ExpandableLeading


{-| Set overline text on an expandable item. -}
expandableOverline : String -> ExpandableItemOption msg
expandableOverline =
    ExpandableOverline


{-| Set supporting text on an expandable item. -}
expandableSupporting : String -> ExpandableItemOption msg
expandableSupporting =
    ExpandableSupporting


{-| Disable an expandable item. -}
expandableDisabled : Bool -> ExpandableItemOption msg
expandableDisabled =
    ExpandableDisabled


{-| Control the expanded state of an expandable item (the `open` DOM property). -}
expandableOpen : Bool -> ExpandableItemOption msg
expandableOpen =
    ExpandableOpen


{-| Set the `id` attribute on the `<m3e-list>` element. -}
withId : String -> Option msg
withId =
    WithId


{-| Set the visual style of the list. Default `Standard`. -}
variant : Variant -> Option msg
variant =
    VariantOpt


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
            List.foldl applyStatic defaultStaticConfig opts
    in
    Renderable.fromNode
        (Node.element "m3e-list-item"
            []
            (decorationNodes c.leading c.overline c.supporting True c.trailing req.headline)
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
            List.foldl applyAction defaultActionConfig opts
    in
    Renderable.fromNode
        (Node.element "m3e-list-item-button"
            (List.filterMap identity
                [ if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\msg -> Node.on "click" (Decode.succeed msg)) c.onClick
                ]
            )
            (decorationNodes c.leading c.overline c.supporting True c.trailing req.headline)
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
            List.foldl applyOptionItem defaultOptionConfig opts
    in
    Renderable.fromNode
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
            (decorationNodes c.leading c.overline c.supporting True Nothing req.headline)
        )


{-| A thin separator row (`<m3e-divider>`). -}
divider : Renderable { listItem : Supported } msg
divider =
    Renderable.fromNode (Node.element "m3e-divider" [] [])


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
            List.foldl applyExpandable defaultExpandableConfig opts

        childNodes =
            List.map (Node.withSlot "items" << Renderable.toNode) req.children
    in
    Renderable.fromNode
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
            (decorationNodes c.leading c.overline c.supporting False Nothing req.headline
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
            List.foldl applyContainerOption defaultContainerConfig opts
    in
    Renderable.fromNode
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


applyStatic : StaticItemOption msg -> StaticConfig msg -> StaticConfig msg
applyStatic opt c =
    case opt of
        StaticLeading r ->
            { c | leading = Just r }

        StaticTrailing r ->
            { c | trailing = Just r }

        StaticOverline s ->
            { c | overline = Just s }

        StaticSupporting s ->
            { c | supporting = Just s }


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
    { leading = Nothing, trailing = Nothing, overline = Nothing, supporting = Nothing
    , disabled = False, onClick = Nothing
    }


applyAction : ActionItemOption msg -> ActionConfig msg -> ActionConfig msg
applyAction opt c =
    case opt of
        ActionLeading r ->
            { c | leading = Just r }

        ActionTrailing r ->
            { c | trailing = Just r }

        ActionOverline s ->
            { c | overline = Just s }

        ActionSupporting s ->
            { c | supporting = Just s }

        ActionDisabled b ->
            { c | disabled = b }

        ActionOnClick msg ->
            { c | onClick = Just msg }


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
    { leading = Nothing, overline = Nothing, supporting = Nothing
    , disabled = False, selected = False, value = Nothing, onChange = Nothing
    }


applyOptionItem : OptionItemOption msg -> OptionConfig msg -> OptionConfig msg
applyOptionItem opt c =
    case opt of
        OptionLeading r ->
            { c | leading = Just r }

        OptionOverline s ->
            { c | overline = Just s }

        OptionSupporting s ->
            { c | supporting = Just s }

        OptionDisabled b ->
            { c | disabled = b }

        OptionSelected b ->
            { c | selected = b }

        OptionValue v ->
            { c | value = Just v }

        OptionOnChange f ->
            { c | onChange = Just f }


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


applyExpandable : ExpandableItemOption msg -> ExpandableConfig msg -> ExpandableConfig msg
applyExpandable opt c =
    case opt of
        ExpandableLeading r ->
            { c | leading = Just r }

        ExpandableOverline s ->
            { c | overline = Just s }

        ExpandableSupporting s ->
            { c | supporting = Just s }

        ExpandableDisabled b ->
            { c | disabled = b }

        ExpandableOpen b ->
            { c | open = b }


type alias ContainerConfig =
    { id : Maybe String
    , variant : Variant
    }


defaultContainerConfig : ContainerConfig
defaultContainerConfig =
    { id = Nothing, variant = Standard }


applyContainerOption : Option msg -> ContainerConfig -> ContainerConfig
applyContainerOption opt c =
    case opt of
        WithId id ->
            { c | id = Just id }

        VariantOpt v ->
            { c | variant = v }


{-| Build the common decoration children for any list item kind. -}
decorationNodes :
    Maybe (Renderable { element : Supported } msg)
    -> Maybe String
    -> Maybe String
    -> Bool
    -> Maybe (Renderable { element : Supported } msg)
    -> String
    -> List (Node.Node msg)
decorationNodes leading_ overline_ supporting_ includeTrailing trailing_ headline =
    List.filterMap identity
        [ Maybe.map (\r -> Node.withSlot "leading" (Renderable.toNode r)) leading_
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "overline" ] [ Node.text s ]) overline_
        , Just (Node.text headline)
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "supporting-text" ] [ Node.text s ]) supporting_
        , if includeTrailing then
            Maybe.map (\r -> Node.withSlot "trailing" (Renderable.toNode r)) trailing_

          else
            Nothing
        ]


toCemVariant : Variant -> CemList.Variant
toCemVariant v =
    case v of
        Standard ->
            CemList.Standard

        Segmented ->
            CemList.Segmented
