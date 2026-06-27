module M3e.Menu exposing
    ( CheckboxItemOption
    , ItemAction(..)
    , ItemOption
    , Option
    , PositionX(..)
    , PositionY(..)
    , RadioItemOption
    , Variant(..)
    , checkboxChecked
    , checkboxDisabled
    , checkboxItem
    , checkboxLeadingIcon
    , checkboxTrailingIcon
    , divider
    , group
    , id
    , item
    , itemDisabled
    , itemLeadingIcon
    , itemTrailingIcon
    , menuVariant
    , onToggle
    , positionX
    , positionY
    , radioDisabled
    , radioItem
    , radioLeadingIcon
    , radioSelected
    , radioTrailingIcon
    , submenu
    , triggerFor
    , view
    )

{-| `<m3e-menu>` + kind-typed item constructors — an action menu anchored to a
trigger (Material 3 Menus).

Spec (per docs/CONVENTIONS.md):

  - Required (container): `{ items }` — the item list
  - Required (item): `{ label, action }` — label + sum-typed action
  - Required (checkboxItem): `{ label, onChange }` — label + toggle handler
  - Required (radioItem): `{ label, onClick }` — label + select handler
  - Options (container): id, variant, positionX, positionY, submenu, onToggle
  - Options (item): leadingIcon, trailingIcon, disabled
  - Options (checkboxItem): checked, leadingIcon, trailingIcon, disabled
  - Options (radioItem): selected, leadingIcon, trailingIcon, disabled
  - Slots: icon / trailing-icon per item (named slots → element)
  - Properties: checked (checkbox), selected (radio), submenu (container)
  - Events: onToggle (toggle/newState on container), click per item
  - Tag: menu / menuItem

Relational wiring — `id` + `triggerFor` — is caller-driven: give the menu
an id via `id`, and nest `triggerFor menuId` inside any clickable control
via that control's escape/element slot or default slot.

-}

import Cem.M3e.Menu as CemMenu
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES -------------------------------------------------------------------


{-| Horizontal placement of the menu relative to its trigger. Default `After`.
-}
type PositionX
    = After
    | Before


{-| Vertical placement of the menu relative to its trigger. Default `Below`.
-}
type PositionY
    = Above
    | Below


{-| Visual style of the menu surface. Default `Standard`.
-}
type Variant
    = Standard
    | Vibrant


{-| The action a plain menu item performs — either a message or a link.
-}
type ItemAction msg
    = Click msg
    | Link String



-- OPTIONS -----------------------------------------------------------------


type alias ItemOption msg =
    Internal.Option (ItemConfig msg) msg


type alias CheckboxItemOption msg =
    Internal.Option (CheckboxConfig msg) msg


type alias RadioItemOption msg =
    Internal.Option (RadioConfig msg) msg


type alias Option msg =
    Internal.Option (ContainerConfig msg) msg



-- SMART CONSTRUCTORS ------------------------------------------------------


{-| Add a leading icon to a plain menu item.
-}
itemLeadingIcon : Renderable { icon : Supported } msg -> ItemOption msg
itemLeadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Add a trailing icon to a plain menu item.
-}
itemTrailingIcon : Renderable { icon : Supported } msg -> ItemOption msg
itemTrailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })


{-| Disable a plain menu item.
-}
itemDisabled : Bool -> ItemOption msg
itemDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Set the checked state of a checkbox item (the `checked` DOM property).
-}
checkboxChecked : Bool -> CheckboxItemOption msg
checkboxChecked b =
    Internal.option (\c -> { c | checked = b })


{-| Add a leading icon to a checkbox item.
-}
checkboxLeadingIcon : Renderable { icon : Supported } msg -> CheckboxItemOption msg
checkboxLeadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Add a trailing icon to a checkbox item.
-}
checkboxTrailingIcon : Renderable { icon : Supported } msg -> CheckboxItemOption msg
checkboxTrailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })


{-| Disable a checkbox item.
-}
checkboxDisabled : Bool -> CheckboxItemOption msg
checkboxDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Mark a radio item as selected (the `checked` DOM property on
`<m3e-menu-item-radio>`).
-}
radioSelected : Bool -> RadioItemOption msg
radioSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Add a leading icon to a radio item.
-}
radioLeadingIcon : Renderable { icon : Supported } msg -> RadioItemOption msg
radioLeadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Add a trailing icon to a radio item.
-}
radioTrailingIcon : Renderable { icon : Supported } msg -> RadioItemOption msg
radioTrailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })


{-| Disable a radio item.
-}
radioDisabled : Bool -> RadioItemOption msg
radioDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Set the `id` attribute on the `<m3e-menu>` element (for the trigger to
reference via `triggerFor`).
-}
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Set the menu's appearance variant. Default `Standard`.
-}
menuVariant : Variant -> Option msg
menuVariant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Set the horizontal placement of the menu. Default `After`.
-}
positionX : PositionX -> Option msg
positionX px =
    Internal.option (\c -> { c | positionX = Just px })


{-| Set the vertical placement of the menu. Default `Below`.
-}
positionY : PositionY -> Option msg
positionY py =
    Internal.option (\c -> { c | positionY = Just py })


{-| Mark this menu as a submenu (flyout from a parent menu row).
-}
submenu : Bool -> Option msg
submenu b =
    Internal.option (\c -> { c | submenu = b })


{-| React to the menu opening or closing. The handler receives `True` when the
menu opens, `False` when it closes.
-}
onToggle : (Bool -> msg) -> Option msg
onToggle toMsg =
    Internal.option (\c -> { c | onToggle = Just toMsg })



-- ITEM CONSTRUCTORS -------------------------------------------------------


{-| Construct a plain action menu item (`<m3e-menu-item>`).

    M3e.Menu.item
        { label = "Edit", action = M3e.Menu.Click EditClicked }
        []

For a link item, pass `action = M3e.Menu.Link "https://example.com"`.

-}
item :
    { label : String, action : ItemAction msg }
    -> List (ItemOption msg)
    -> Renderable { menuItem : Supported } msg
item req opts =
    let
        c =
            Internal.applyOptions opts defaultItemConfig
    in
    Internal.fromNode
        (Node.element "m3e-menu-item"
            (List.filterMap identity
                [ case req.action of
                    Click msg ->
                        Just (Node.on "click" (Decode.succeed msg))

                    Link href ->
                        Just (Node.attribute "href" href)
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (itemChildren c.leadingIcon c.trailingIcon req.label)
        )


{-| Construct a checkable menu item (`<m3e-menu-item-checkbox>`). The handler
receives `True` when the box is checked, `False` when unchecked. Drive the
displayed state with `checkboxChecked`.

    M3e.Menu.checkboxItem
        { label = "Show grid", onChange = GridToggled }
        [ M3e.Menu.checkboxChecked model.showGrid ]

-}
checkboxItem :
    { label : String, onChange : Bool -> msg }
    -> List (CheckboxItemOption msg)
    -> Renderable { menuItem : Supported } msg
checkboxItem req opts =
    let
        c =
            Internal.applyOptions opts defaultCheckboxConfig
    in
    Internal.fromNode
        (Node.element "m3e-menu-item-checkbox"
            (List.filterMap identity
                [ Just (Node.property "checked" (Encode.bool c.checked))
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Just (Node.on "click" (Decode.succeed (req.onChange (not c.checked))))
                ]
            )
            (itemChildren c.leadingIcon c.trailingIcon req.label)
        )


{-| Construct a mutually-exclusive radio menu item (`<m3e-menu-item-radio>`).
Mark the active one with `radioSelected`; group related radios with `group`.

    M3e.Menu.radioItem
        { label = "Left", onClick = Align Left }
        [ M3e.Menu.radioSelected (model.align == Left) ]

-}
radioItem :
    { label : String, onClick : msg }
    -> List (RadioItemOption msg)
    -> Renderable { menuItem : Supported } msg
radioItem req opts =
    let
        c =
            Internal.applyOptions opts defaultRadioConfig
    in
    Internal.fromNode
        (Node.element "m3e-menu-item-radio"
            (List.filterMap identity
                [ Just (Node.property "checked" (Encode.bool c.selected))
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Just (Node.on "click" (Decode.succeed req.onClick))
                ]
            )
            (itemChildren c.leadingIcon c.trailingIcon req.label)
        )


{-| A thin separator row (`<m3e-divider>`) for use between menu items.
-}
divider : Renderable { menuItem : Supported } msg
divider =
    Internal.fromNode (Node.element "m3e-divider" [] [])


{-| A labelled group of related items (`<m3e-menu-item-group>`), typically
radio items. The `label` text goes in the element's `label` slot.

    M3e.Menu.group
        { label = "Alignment"
        , items =
            [ M3e.Menu.radioItem { label = "Left", onClick = Align Left }
                [ M3e.Menu.radioSelected (model.align == Left) ]
            ]
        }

-}
group :
    { label : String, items : List (Renderable { menuItem : Supported } msg) }
    -> Renderable { menuItem : Supported } msg
group req =
    Internal.fromNode
        (Node.element "m3e-menu-item-group"
            []
            (Node.element "span" [ Node.attribute "slot" "label" ] [ Node.text req.label ]
                :: List.map Renderable.toNode req.items
            )
        )


{-| The trigger marker (`<m3e-menu-trigger for="…">`). Nest it inside a
clickable control alongside the control's icon/label content; activating the
control opens the menu that has the same `id`.

    M3e.IconButton.view
        { name = "More actions" }
        [ M3e.IconButton.leadingIcon myOverflowIcon
        , M3e.IconButton.extraContent
            [ M3e.Menu.triggerFor "row-actions" ]
        ]

The returned `Renderable { element }` is slot-ready and carries the `for`
attribute so the element can inject it into any named slot.

-}
triggerFor : String -> Renderable { s | element : Supported } msg
triggerFor menuId =
    Internal.fromNode
        (Node.element "m3e-menu-trigger" [ Node.attribute "for" menuId ] [])



-- CONTAINER ---------------------------------------------------------------


{-| Render the menu element.

    M3e.Menu.view
        { items =
            [ M3e.Menu.item { label = "Edit", action = M3e.Menu.Click EditClicked } []
            , M3e.Menu.item { label = "Delete", action = M3e.Menu.Click DeleteClicked }
                [ M3e.Menu.itemDisabled True ]
            ]
        }
        [ M3e.Menu.id "my-menu" ]

Place a `triggerFor "my-menu"` inside your trigger control. Open/close is
element-managed — no Elm state is needed.

-}
view :
    { items : List (Renderable { menuItem : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | menu : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-menu"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , if c.submenu then
                    Just (Node.property "submenu" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\v -> Node.rawAttr (CemMenu.variant (toCemVariant v))) c.variant
                , Maybe.map (\px -> Node.rawAttr (CemMenu.positionX (toCemPositionX px))) c.positionX
                , Maybe.map (\py -> Node.rawAttr (CemMenu.positionY (toCemPositionY py))) c.positionY
                , Maybe.map
                    (\toMsg ->
                        Node.on "toggle"
                            (Decode.at [ "newState" ] Decode.string
                                |> Decode.map (\s -> toMsg (s == "open"))
                            )
                    )
                    c.onToggle
                ]
            )
            (List.map Renderable.toNode req.items)
        )



-- INTERNAL ----------------------------------------------------------------


type alias ItemConfig msg =
    { leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    , disabled : Bool
    }


defaultItemConfig : ItemConfig msg
defaultItemConfig =
    { leadingIcon = Nothing, trailingIcon = Nothing, disabled = False }


type alias CheckboxConfig msg =
    { checked : Bool
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    , disabled : Bool
    }


defaultCheckboxConfig : CheckboxConfig msg
defaultCheckboxConfig =
    { checked = False, leadingIcon = Nothing, trailingIcon = Nothing, disabled = False }


type alias RadioConfig msg =
    { selected : Bool
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    , disabled : Bool
    }


defaultRadioConfig : RadioConfig msg
defaultRadioConfig =
    { selected = False, leadingIcon = Nothing, trailingIcon = Nothing, disabled = False }


type alias ContainerConfig msg =
    { id : Maybe String
    , submenu : Bool
    , variant : Maybe Variant
    , positionX : Maybe PositionX
    , positionY : Maybe PositionY
    , onToggle : Maybe (Bool -> msg)
    }


defaultConfig : ContainerConfig msg
defaultConfig =
    { id = Nothing
    , submenu = False
    , variant = Nothing
    , positionX = Nothing
    , positionY = Nothing
    , onToggle = Nothing
    }


itemChildren :
    Maybe (Renderable { icon : Supported } msg)
    -> Maybe (Renderable { icon : Supported } msg)
    -> String
    -> List (Node.Node msg)
itemChildren leadingIcon_ trailingIcon_ label =
    List.filterMap identity
        [ Maybe.map (\i -> Node.withSlot "icon" (Renderable.toNode i)) leadingIcon_
        , Just (Node.text label)
        , Maybe.map (\i -> Node.withSlot "trailing-icon" (Renderable.toNode i)) trailingIcon_
        ]


toCemVariant : Variant -> CemMenu.Variant
toCemVariant v =
    case v of
        Standard ->
            CemMenu.Standard

        Vibrant ->
            CemMenu.Vibrant


toCemPositionX : PositionX -> CemMenu.PositionX
toCemPositionX p =
    case p of
        After ->
            CemMenu.After

        Before ->
            CemMenu.Before


toCemPositionY : PositionY -> CemMenu.PositionY
toCemPositionY p =
    case p of
        Above ->
            CemMenu.Above

        Below ->
            CemMenu.Below
