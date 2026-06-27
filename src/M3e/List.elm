module M3e.List exposing
    ( list, actionList, selectionList
    , item, actionItem, option, divider, expandable
    , Variant(..), Option, SelectionOption
    , StaticItemOption, ActionItemOption, OptionItemOption, ExpandableItemOption
    , id, variant
    , staticLeading, staticTrailing, staticOverline, staticSupporting
    , actionLeading, actionTrailing, actionOverline, actionSupporting
    , actionDisabled, actionHref, actionTarget, actionRel, actionDownload, actionOnClick
    , optionLeading, optionOverline, optionSupporting, optionDisabled, optionSelected, optionValue, optionOnChange
    , expandableLeading, expandableOverline, expandableSupporting, expandableDisabled, expandableOpen
    , selectionId, selectionVariant, multi, selectionName, hideSelectionIndicator, selectionDisabled
    )

{-| Material 3 Expressive list family — three typed containers with kind-specific
item constructors so no option is ever a silent no-op.

Spec (per docs/CONVENTIONS.md):

  - `list` → `<m3e-list>` — static / expandable rows
  - `actionList` → `<m3e-action-list>` — interactive rows with RovingTabIndex keyboard nav
  - `selectionList` → `<m3e-selection-list>` — selectable options, multi-select, form-associated
  - `item` → `<m3e-list-item>` — non-interactive row (goes in `list`)
  - `actionItem` → `<m3e-list-action>` — interactive row (goes in `actionList`);
    link attrs (`href`/`target`/`rel`/`download`) supported
  - `option` → `<m3e-list-option>` — selectable row (goes in `selectionList`);
    change event reads element-managed selected state
  - `divider` → `<m3e-divider>` — separator (goes in `list`)
  - `expandable` → `<m3e-expandable-list-item>` — collapsible group (goes in `list`)


## Containers

@docs list, actionList, selectionList


## Items

@docs item, actionItem, option, divider, expandable


## Types

@docs Variant, Option, SelectionOption
@docs StaticItemOption, ActionItemOption, OptionItemOption, ExpandableItemOption


## Container options (`list` / `actionList`)

@docs id, variant


## Static item options

@docs staticLeading, staticTrailing, staticOverline, staticSupporting


## Action item options

@docs actionLeading, actionTrailing, actionOverline, actionSupporting
@docs actionDisabled, actionHref, actionTarget, actionRel, actionDownload, actionOnClick


## Selectable option item options

@docs optionLeading, optionOverline, optionSupporting, optionDisabled, optionSelected, optionValue, optionOnChange


## Expandable item options

@docs expandableLeading, expandableOverline, expandableSupporting, expandableDisabled, expandableOpen


## Selection list container options

@docs selectionId, selectionVariant, multi, selectionName, hideSelectionIndicator, selectionDisabled

-}

import Cem.M3e.ActionList as CemActionList
import Cem.M3e.List as CemList
import Cem.M3e.ListAction as CemListAction
import Cem.M3e.SelectionList as CemSelectionList
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES -------------------------------------------------------------------


{-| Visual style of a list container. Default `Standard`.
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


{-| Option for the `list` and `actionList` containers.
-}
type alias Option msg =
    Internal.Option ContainerConfig msg


{-| Option for the `selectionList` container.
-}
type alias SelectionOption msg =
    Internal.Option SelectionConfig msg



-- STATIC ITEM OPTIONS -----------------------------------------------------


{-| Add a leading element to a static item.
-}
staticLeading : Element { element : Supported } msg -> StaticItemOption msg
staticLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Add a trailing element to a static item.
-}
staticTrailing : Element { element : Supported } msg -> StaticItemOption msg
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



-- ACTION ITEM OPTIONS -----------------------------------------------------


{-| Add a leading element to an action item.
-}
actionLeading : Element { element : Supported } msg -> ActionItemOption msg
actionLeading r =
    Internal.option (\c -> { c | leading = Just r })


{-| Add a trailing element to an action item.
-}
actionTrailing : Element { element : Supported } msg -> ActionItemOption msg
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


{-| Set the link URL. When set the item renders as an `<a>` inside the element.
-}
actionHref : String -> ActionItemOption msg
actionHref v =
    Internal.option (\c -> { c | href = Just v })


{-| Set the link `target` (e.g. `"_blank"`); only meaningful with `actionHref`.
-}
actionTarget : String -> ActionItemOption msg
actionTarget v =
    Internal.option (\c -> { c | target = Just v })


{-| Set the link `rel` (e.g. `"noreferrer noopener"`); only meaningful with `actionHref`.
-}
actionRel : String -> ActionItemOption msg
actionRel v =
    Internal.option (\c -> { c | rel = Just v })


{-| Request the link target be downloaded; only meaningful with `actionHref`.
-}
actionDownload : String -> ActionItemOption msg
actionDownload v =
    Internal.option (\c -> { c | download = Just v })


{-| Wire a click handler for an action item.
-}
actionOnClick : msg -> ActionItemOption msg
actionOnClick msg =
    Internal.option (\c -> { c | onClick = Just msg })



-- OPTION ITEM OPTIONS -----------------------------------------------------


{-| Add a leading element to a selectable option item.
-}
optionLeading : Element { element : Supported } msg -> OptionItemOption msg
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


{-| React to the element's `change` event. The handler receives the new
`selected` state as reported by the element itself — **not** a client-side
guess. This correctly tracks multi-select state managed by `<m3e-selection-list>`.
-}
optionOnChange : (Bool -> msg) -> OptionItemOption msg
optionOnChange f =
    Internal.option (\c -> { c | onChange = Just f })



-- EXPANDABLE ITEM OPTIONS -------------------------------------------------


{-| Add a leading element to an expandable item.
-}
expandableLeading : Element { element : Supported } msg -> ExpandableItemOption msg
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



-- CONTAINER OPTIONS (list / actionList) -----------------------------------


{-| Set the `id` attribute on the list element.
-}
id : String -> Option msg
id newId =
    Internal.option (\c -> { c | id = Just newId })


{-| Set the visual style of the list. Default `Standard`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })



-- SELECTION LIST CONTAINER OPTIONS ----------------------------------------


{-| Set the `id` attribute on the `<m3e-selection-list>` element.
-}
selectionId : String -> SelectionOption msg
selectionId newId =
    Internal.option (\c -> { c | id = Just newId })


{-| Set the visual style of the selection list. Default `Standard`.
-}
selectionVariant : Variant -> SelectionOption msg
selectionVariant v =
    Internal.option (\c -> { c | variant = v })


{-| Allow multiple options to be selected simultaneously.
-}
multi : Bool -> SelectionOption msg
multi b =
    Internal.option (\c -> { c | multi = b })


{-| Set the `name` attribute used for form submission.
-}
selectionName : String -> SelectionOption msg
selectionName n =
    Internal.option (\c -> { c | name = Just n })


{-| Hide the built-in selection indicator (checkbox/checkmark).
-}
hideSelectionIndicator : Bool -> SelectionOption msg
hideSelectionIndicator b =
    Internal.option (\c -> { c | hideSelectionIndicator = b })


{-| Disable the entire selection list.
-}
selectionDisabled : Bool -> SelectionOption msg
selectionDisabled b =
    Internal.option (\c -> { c | disabled = b })



-- ITEM CONSTRUCTORS -------------------------------------------------------


{-| A static, non-interactive list item (`<m3e-list-item>`). Use inside `list`.

    M3e.List.item { headline = "Inbox" }
        [ M3e.List.staticLeading myIconElement
        , M3e.List.staticSupporting "12 unread"
        ]

-}
item :
    { headline : String }
    -> List (StaticItemOption msg)
    -> Element { listItem : Supported } msg
item req opts =
    let
        c : StaticConfig msg
        c =
            Internal.applyOptions opts defaultStaticConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-item"
            []
            (decorationNodes c.leading c.overline c.supporting c.trailing req.headline)
        )


{-| An interactive list item (`<m3e-list-action>`). Use inside `actionList`.

    M3e.List.actionItem { headline = "Open settings" }
        [ M3e.List.actionOnClick OpenSettings
        , M3e.List.actionLeading myGearIcon
        ]

    -- Link variant:
    M3e.List.actionItem { headline = "Account" }
        [ M3e.List.actionHref "/account"
        , M3e.List.actionTarget "_blank"
        ]

-}
actionItem :
    { headline : String }
    -> List (ActionItemOption msg)
    -> Element { actionItem : Supported } msg
actionItem req opts =
    let
        c : ActionConfig msg
        c =
            Internal.applyOptions opts defaultActionConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-action"
            (List.filterMap identity
                [ Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (\v -> Node.rawAttr (CemListAction.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (CemListAction.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (CemListAction.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (CemListAction.download v)) c.download
                , Maybe.map (\msg -> Node.on "click" (Decode.succeed msg)) c.onClick
                ]
            )
            (decorationNodes c.leading c.overline c.supporting c.trailing req.headline)
        )


{-| A selectable list option (`<m3e-list-option>`). Use inside `selectionList`.

The `change` event (not `click`) is what the element fires when its selection
state changes; `optionOnChange` decodes `event.target.selected` directly so
the handler always receives the element-authoritative state.

    M3e.List.option { headline = "Wi-Fi" }
        [ M3e.List.optionSelected model.wifiOn
        , M3e.List.optionOnChange WifiToggled
        , M3e.List.optionValue "wifi"
        ]

-}
option :
    { headline : String }
    -> List (OptionItemOption msg)
    -> Element { optionItem : Supported } msg
option req opts =
    let
        c : OptionConfig msg
        c =
            Internal.applyOptions opts defaultOptionConfig
    in
    Internal.fromNode
        (Node.element "m3e-list-option"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool c.selected))
                , Maybe.map (Node.attribute "value") c.value
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map
                    (\f ->
                        Node.on "change"
                            (Decode.at [ "target", "selected" ] Decode.bool
                                |> Decode.map f
                            )
                    )
                    c.onChange
                ]
            )
            (decorationNodes c.leading c.overline c.supporting Nothing req.headline)
        )


{-| A thin separator row (`<m3e-divider>`). Use inside `list`.
-}
divider : Element { listItem : Supported } msg
divider =
    Internal.fromNode (Node.element "m3e-divider" [] [])


{-| An expandable list item (`<m3e-expandable-list-item>`). Children are
injected into the `items` slot automatically. Use inside `list`.

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
    , children : List (Element { listItem : Supported } msg)
    }
    -> List (ExpandableItemOption msg)
    -> Element { listItem : Supported } msg
expandable req opts =
    let
        c : ExpandableConfig msg
        c =
            Internal.applyOptions opts defaultExpandableConfig

        childNodes : List (Node msg)
        childNodes =
            List.map (Node.withSlot "items" << Element.toNode) req.children
    in
    Internal.fromNode
        (Node.element "m3e-expandable-list-item"
            [ Node.property "open" (Encode.bool c.open)
            , Node.property "disabled" (Encode.bool c.disabled)
            ]
            (decorationNodes c.leading c.overline c.supporting Nothing req.headline
                ++ childNodes
            )
        )



-- CONTAINERS --------------------------------------------------------------


{-| Render a plain `<m3e-list>` — for static items, dividers, and expandable
groups. Items must be built with `item`, `divider`, or `expandable`.

    M3e.List.list
        { items =
            [ M3e.List.item { headline = "Inbox" } []
            , M3e.List.divider
            , M3e.List.item { headline = "Sent" } []
            ]
        }
        []

-}
list :
    { items : List (Element { listItem : Supported } msg) }
    -> List (Option msg)
    -> Element { s | list : Supported } msg
list req opts =
    let
        c : ContainerConfig
        c =
            Internal.applyOptions opts defaultContainerConfig
    in
    Internal.fromNode
        (Node.element "m3e-list"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemList.variant (toCemListVariant c.variant)))
                ]
            )
            (List.map Element.toNode req.items)
        )


{-| Render an `<m3e-action-list>` — for interactive action rows with roving
tabindex keyboard navigation. Items must be built with `actionItem`.

    M3e.List.actionList
        { items =
            [ M3e.List.actionItem { headline = "Account" }
                [ M3e.List.actionHref "/account" ]
            , M3e.List.actionItem { headline = "Settings" }
                [ M3e.List.actionOnClick OpenSettings ]
            ]
        }
        []

-}
actionList :
    { items : List (Element { actionItem : Supported } msg) }
    -> List (Option msg)
    -> Element { s | list : Supported } msg
actionList req opts =
    let
        c : ContainerConfig
        c =
            Internal.applyOptions opts defaultContainerConfig
    in
    Internal.fromNode
        (Node.element "m3e-action-list"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemActionList.variant (toCemActionListVariant c.variant)))
                ]
            )
            (List.map Element.toNode req.items)
        )


{-| Render an `<m3e-selection-list>` — for selectable option rows with
SelectionManager, multi-select, and form association. Items must be built
with `option`.

    M3e.List.selectionList
        { items =
            [ M3e.List.option { headline = "News" }
                [ M3e.List.optionSelected True, M3e.List.optionValue "news" ]
            , M3e.List.option { headline = "Offers" }
                [ M3e.List.optionValue "offers" ]
            ]
        }
        [ M3e.List.multi True
        , M3e.List.selectionName "topics"
        ]

-}
selectionList :
    { items : List (Element { optionItem : Supported } msg) }
    -> List (SelectionOption msg)
    -> Element { s | list : Supported } msg
selectionList req opts =
    let
        c : SelectionConfig
        c =
            Internal.applyOptions opts defaultSelectionConfig
    in
    Internal.fromNode
        (Node.element "m3e-selection-list"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.rawAttr (CemSelectionList.variant (toCemSelectionListVariant c.variant)))
                , Just (Node.property "multi" (Encode.bool c.multi))
                , Maybe.map (Node.attribute "name") c.name
                , Just (Node.property "hide-selection-indicator" (Encode.bool c.hideSelectionIndicator))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                ]
            )
            (List.map Element.toNode req.items)
        )



-- INTERNAL ----------------------------------------------------------------


type alias StaticConfig msg =
    { leading : Maybe (Element { element : Supported } msg)
    , trailing : Maybe (Element { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    }


defaultStaticConfig : StaticConfig msg
defaultStaticConfig =
    { leading = Nothing, trailing = Nothing, overline = Nothing, supporting = Nothing }


type alias ActionConfig msg =
    { leading : Maybe (Element { element : Supported } msg)
    , trailing : Maybe (Element { element : Supported } msg)
    , overline : Maybe String
    , supporting : Maybe String
    , disabled : Bool
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , onClick : Maybe msg
    }


defaultActionConfig : ActionConfig msg
defaultActionConfig =
    { leading = Nothing
    , trailing = Nothing
    , overline = Nothing
    , supporting = Nothing
    , disabled = False
    , href = Nothing
    , target = Nothing
    , rel = Nothing
    , download = Nothing
    , onClick = Nothing
    }


type alias OptionConfig msg =
    { leading : Maybe (Element { element : Supported } msg)
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
    { leading : Maybe (Element { element : Supported } msg)
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


type alias SelectionConfig =
    { id : Maybe String
    , variant : Variant
    , multi : Bool
    , name : Maybe String
    , hideSelectionIndicator : Bool
    , disabled : Bool
    }


defaultSelectionConfig : SelectionConfig
defaultSelectionConfig =
    { id = Nothing
    , variant = Standard
    , multi = False
    , name = Nothing
    , hideSelectionIndicator = False
    , disabled = False
    }


{-| Build the common decoration children for any list item kind.
-}
decorationNodes :
    Maybe (Element { element : Supported } msg)
    -> Maybe String
    -> Maybe String
    -> Maybe (Element { element : Supported } msg)
    -> String
    -> List (Node msg)
decorationNodes leading overline supporting trailing headline =
    List.filterMap identity
        [ Maybe.map (\r -> Node.withSlot "leading" (Element.toNode r)) leading
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "overline" ] [ Node.text s ]) overline
        , Just (Node.text headline)
        , Maybe.map (\s -> Node.element "span" [ Node.attribute "slot" "supporting-text" ] [ Node.text s ]) supporting
        , Maybe.map (\r -> Node.withSlot "trailing" (Element.toNode r)) trailing
        ]


toCemListVariant : Variant -> CemList.Variant
toCemListVariant v =
    case v of
        Standard ->
            CemList.Standard

        Segmented ->
            CemList.Segmented


toCemActionListVariant : Variant -> CemActionList.Variant
toCemActionListVariant v =
    case v of
        Standard ->
            CemActionList.Standard

        Segmented ->
            CemActionList.Segmented


toCemSelectionListVariant : Variant -> CemSelectionList.Variant
toCemSelectionListVariant v =
    case v of
        Standard ->
            CemSelectionList.Standard

        Segmented ->
            CemSelectionList.Segmented
