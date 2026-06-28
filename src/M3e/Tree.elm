module M3e.Tree exposing
    ( view
    , treeItem
    , Option, ItemOption
    , multi, cascade, onChange
    , itemDisabled, itemIndeterminate, itemOpen, itemSelected
    , itemIcon, itemSelectedIcon, itemToggleIcon, itemOpenToggleIcon
    , itemOnOpening, itemOnOpened, itemOnClosing, itemOnClosed, itemOnClick
    )

{-| Material 3 Expressive tree — hierarchical, collapsible navigation.

Spec (per docs/CONVENTIONS.md):

  - `view` → `<m3e-tree>` — the container; accepts typed `treeItem` children
  - `treeItem` → `<m3e-tree-item>` — a node in the tree; label, optional icon
    slots, optional nested children (also `treeItem`s), bool state attrs, and
    expand/select events

The `children` field of `treeItem` is typed `Element { treeItem : Supported }`,
so only `treeItem`s can nest inside another `treeItem` — the compiler enforces
correct hierarchy.

Import: `import "@m3e/web/tree";` (separate bundle from the main m3e build).


## Container

@docs view


## Item

@docs treeItem


## Types

@docs Option, ItemOption


## Container options

@docs multi, cascade, onChange


## Item bool properties

@docs itemDisabled, itemIndeterminate, itemOpen, itemSelected


## Item icon slots

@docs itemIcon, itemSelectedIcon, itemToggleIcon, itemOpenToggleIcon


## Item events

@docs itemOnOpening, itemOnOpened, itemOnClosing, itemOnClosed, itemOnClick

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES -----------------------------------------------------------------------


{-| Option for the `<m3e-tree>` container.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Option for a `<m3e-tree-item>`.
-}
type alias ItemOption msg =
    Internal.Option (ItemConfig msg) msg


type alias Config msg =
    { multi : Bool
    , cascade : Bool
    , onChange : Maybe msg
    }


defaultConfig : Config msg
defaultConfig =
    { multi = False, cascade = False, onChange = Nothing }


type alias ItemConfig msg =
    { disabled : Bool
    , indeterminate : Bool
    , open : Bool
    , selected : Bool
    , icon : Maybe (Element { element : Supported } msg)
    , selectedIcon : Maybe (Element { element : Supported } msg)
    , toggleIcon : Maybe (Element { element : Supported } msg)
    , openToggleIcon : Maybe (Element { element : Supported } msg)
    , onOpening : Maybe msg
    , onOpened : Maybe msg
    , onClosing : Maybe msg
    , onClosed : Maybe msg
    , onClick : Maybe msg
    }


defaultItemConfig : ItemConfig msg
defaultItemConfig =
    { disabled = False
    , indeterminate = False
    , open = False
    , selected = False
    , icon = Nothing
    , selectedIcon = Nothing
    , toggleIcon = Nothing
    , openToggleIcon = Nothing
    , onOpening = Nothing
    , onOpened = Nothing
    , onClosing = Nothing
    , onClosed = Nothing
    , onClick = Nothing
    }



-- CONTAINER OPTIONS -----------------------------------------------------------


{-| Allow multiple items to be selected simultaneously.

Sets the `multi` DOM property on `<m3e-tree>`. Default `False`.

-}
multi : Bool -> Option msg
multi b =
    Internal.option (\c -> { c | multi = b })


{-| Cascade multi-selection to child items (checkbox ripple-through behaviour).

Sets the `cascade` DOM property on `<m3e-tree>`. Default `False`. Requires
`multi = True` to have a visible effect.

-}
cascade : Bool -> Option msg
cascade b =
    Internal.option (\c -> { c | cascade = b })


{-| React to selection changes in the tree.

The `change` event is fired on `<m3e-tree>` whenever the selected set of items
changes. Because selected items are returned as live DOM element references by
the upstream element (not serialisable values), there is no useful payload to
decode — the handler is a plain `msg`. Wire your model to re-render from your
own selection state.

-}
onChange : msg -> Option msg
onChange msg =
    Internal.option (\c -> { c | onChange = Just msg })



-- ITEM BOOL PROPERTIES -------------------------------------------------------


{-| Disable a tree item (sets the `disabled` DOM property on `<m3e-tree-item>`).

Disabled items are not interactive and are skipped in keyboard navigation.
Default `False`. Emitted unconditionally so the DOM property resets to `false`
when the Elm value is `False`.

-}
itemDisabled : Bool -> ItemOption msg
itemDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Mark a tree item's selection state as indeterminate.

Sets the `indeterminate` DOM property on `<m3e-tree-item>`. Typically set on
parent items whose children are partially selected in a multi-select tree.
Default `False`. Emitted unconditionally.

-}
itemIndeterminate : Bool -> ItemOption msg
itemIndeterminate b =
    Internal.option (\c -> { c | indeterminate = b })


{-| Control whether the item is expanded (its children are visible).

Sets the `open` DOM property on `<m3e-tree-item>`. Default `False`. Emitted
unconditionally so collapsing works correctly when the Elm value flips to
`False`.

-}
itemOpen : Bool -> ItemOption msg
itemOpen b =
    Internal.option (\c -> { c | open = b })


{-| Mark this item as selected.

Sets the `selected` DOM property on `<m3e-tree-item>`. Default `False`.
Emitted unconditionally.

-}
itemSelected : Bool -> ItemOption msg
itemSelected b =
    Internal.option (\c -> { c | selected = b })



-- ITEM ICON SLOTS ------------------------------------------------------------


{-| Provide a leading icon for the item (fills the `icon` slot).

Typically an `M3e.Icon.view` element. Shown in the normal (unselected) state.

-}
itemIcon : Element { element : Supported } msg -> ItemOption msg
itemIcon el =
    Internal.option (\c -> { c | icon = Just el })


{-| Provide an icon shown when the item is selected (fills the `selected-icon`
slot). Overrides the `icon` slot when the item is in the selected state.
-}
itemSelectedIcon : Element { element : Supported } msg -> ItemOption msg
itemSelectedIcon el =
    Internal.option (\c -> { c | selectedIcon = Just el })


{-| Provide a custom toggle (expand/collapse) icon (fills the `toggle-icon`
slot). Shown when the item is collapsed.
-}
itemToggleIcon : Element { element : Supported } msg -> ItemOption msg
itemToggleIcon el =
    Internal.option (\c -> { c | toggleIcon = Just el })


{-| Provide a custom toggle icon shown when the item is open (fills the
`open-toggle-icon` slot).
-}
itemOpenToggleIcon : Element { element : Supported } msg -> ItemOption msg
itemOpenToggleIcon el =
    Internal.option (\c -> { c | openToggleIcon = Just el })



-- ITEM EVENTS ----------------------------------------------------------------


{-| React to the item beginning to expand (`opening` event on `<m3e-tree-item>`).
-}
itemOnOpening : msg -> ItemOption msg
itemOnOpening msg =
    Internal.option (\c -> { c | onOpening = Just msg })


{-| React to the item having fully expanded (`opened` event on `<m3e-tree-item>`).
-}
itemOnOpened : msg -> ItemOption msg
itemOnOpened msg =
    Internal.option (\c -> { c | onOpened = Just msg })


{-| React to the item beginning to collapse (`closing` event on `<m3e-tree-item>`).
-}
itemOnClosing : msg -> ItemOption msg
itemOnClosing msg =
    Internal.option (\c -> { c | onClosing = Just msg })


{-| React to the item having fully collapsed (`closed` event on `<m3e-tree-item>`).
-}
itemOnClosed : msg -> ItemOption msg
itemOnClosed msg =
    Internal.option (\c -> { c | onClosed = Just msg })


{-| React to a click on the item (`click` event on `<m3e-tree-item>`).
-}
itemOnClick : msg -> ItemOption msg
itemOnClick msg =
    Internal.option (\c -> { c | onClick = Just msg })



-- ITEM CONSTRUCTOR -----------------------------------------------------------


{-| Build a `<m3e-tree-item>`.

The `label` string is rendered inside a `<span slot="label">` so it is slotted
into the named label region of the element.

`children` may be an empty list for leaf nodes, or a list of nested `treeItem`
elements for branch nodes — the type system constrains children to be `treeItem`
elements only, enforcing correct hierarchy.

    -- Leaf node
    M3e.Tree.treeItem
        { label = "Overview", children = [] }
        []

    -- Branch node (expanded by default)
    M3e.Tree.treeItem
        { label = "Getting Started"
        , children =
            [ M3e.Tree.treeItem { label = "Overview", children = [] } []
            , M3e.Tree.treeItem { label = "Installation", children = [] } []
            ]
        }
        [ M3e.Tree.itemOpen True ]

-}
treeItem :
    { label : String
    , children : List (Element { treeItem : Supported } msg)
    }
    -> List (ItemOption msg)
    -> Element { s | treeItem : Supported } msg
treeItem req opts =
    let
        c : ItemConfig msg
        c =
            Internal.applyOptions opts defaultItemConfig

        labelNode : Node msg
        labelNode =
            Node.element "span" [ Node.attribute "slot" "label" ] [ Node.text req.label ]

        slotNode : String -> Element { element : Supported } msg -> Node msg
        slotNode slotName el =
            Node.withSlot slotName (Element.toNode el)

        iconNodes : List (Node msg)
        iconNodes =
            List.filterMap identity
                [ Maybe.map (slotNode "icon") c.icon
                , Maybe.map (slotNode "selected-icon") c.selectedIcon
                , Maybe.map (slotNode "toggle-icon") c.toggleIcon
                , Maybe.map (slotNode "open-toggle-icon") c.openToggleIcon
                ]

        childNodes : List (Node msg)
        childNodes =
            List.map Element.toNode req.children
    in
    Internal.fromNode
        (Node.element "m3e-tree-item"
            (List.filterMap identity
                [ Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "indeterminate" (Encode.bool c.indeterminate))
                , Just (Node.property "open" (Encode.bool c.open))
                , Just (Node.property "selected" (Encode.bool c.selected))
                , Maybe.map (\msg -> Node.on "opening" (Decode.succeed msg)) c.onOpening
                , Maybe.map (\msg -> Node.on "opened" (Decode.succeed msg)) c.onOpened
                , Maybe.map (\msg -> Node.on "closing" (Decode.succeed msg)) c.onClosing
                , Maybe.map (\msg -> Node.on "closed" (Decode.succeed msg)) c.onClosed
                , Maybe.map (\msg -> Node.on "click" (Decode.succeed msg)) c.onClick
                ]
            )
            (labelNode :: iconNodes ++ childNodes)
        )



-- CONTAINER ------------------------------------------------------------------


{-| Render a `<m3e-tree>` container.

Children must be built with `treeItem`. The `multi` and `cascade` options
control selection behaviour; `onChange` fires whenever the selected item set
changes.

    M3e.Tree.view
        { items =
            [ M3e.Tree.treeItem
                { label = "Getting Started"
                , children =
                    [ M3e.Tree.treeItem { label = "Overview", children = [] } []
                    , M3e.Tree.treeItem { label = "Installation", children = [] } []
                    ]
                }
                [ M3e.Tree.itemOpen True ]
            , M3e.Tree.treeItem
                { label = "Components", children = [] }
                []
            ]
        }
        [ M3e.Tree.onChange SelectionChanged ]

-}
view :
    { items : List (Element { treeItem : Supported } msg) }
    -> List (Option msg)
    -> Element { s | tree : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-tree"
            (List.filterMap identity
                [ Just (Node.property "multi" (Encode.bool c.multi))
                , Just (Node.property "cascade" (Encode.bool c.cascade))
                , Maybe.map (\msg -> Node.on "change" (Decode.succeed msg)) c.onChange
                ]
            )
            (List.map Element.toNode req.items)
        )
