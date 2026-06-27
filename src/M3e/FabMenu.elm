module M3e.FabMenu exposing
    ( Option
    , Variant(..)
    , item
    , menuId
    , variant
    , view
    )

{-| `<m3e-fab-menu>` + `<m3e-fab>` trigger — a floating action button that
expands into a set of related actions.

Spec (per docs/CONVENTIONS.md):

  - Required: { triggerIcon : String
    , name : String -- a11y aria-label for the FAB trigger
    , items : List (Renderable { fabMenuItem : Supported } msg)
    }
    (items = homogeneous list of `m3e-fab-menu-item` children)
  - Options: variant (of the menu surface), menuId (relational wiring)
  - Structure: emits a wrapping `<div>` containing:
    (1) `<m3e-fab>` trigger: aria-label + icon + `<m3e-fab-menu-trigger for=menuId>`
    (2) `<m3e-fab-menu id=menuId>` with items
  - Properties: none
  - Attrs: variant via Node.rawAttr (Cem enum); for, id via Node.attribute
  - Events: click on items (via Node.on inside each m3e-fab-menu-item)
  - Escape: none (strict: items must be `m3e-fab-menu-item` children)
  - Tag: fabMenu

BUG FIX #18: the previous `Ui.FabMenu` emitted `<m3e-menu-item>` children
inside the FAB menu, but `<m3e-fab-menu>` adopts `<m3e-fab-menu-item>` children.
There is no `Cem.M3e.FabMenuItem` atom — the `m3e-fab-menu-item` element is
constructed directly via `Node.element`.


## Child constructor

`item { icon, label, onClick }` wraps an icon + label into an
`<m3e-fab-menu-item>` with a click event, returning a
`Renderable { s | fabMenuItem : Supported }` for the `items` list.

-}

import Cem.M3e.FabMenu as Cem
import Json.Decode as Decode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Appearance variant of the menu surface (default `Primary`).
-}
type Variant
    = Primary
    | Secondary
    | Tertiary


type alias Config =
    { variant : Variant
    , menuId : String
    }


type alias Option msg =
    Internal.Option Config msg


{-| Set the menu surface variant (default `Primary`).
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Override the DOM id used to link the trigger to the menu (default
`"fab-menu"`). Set a unique id when rendering more than one FAB menu on a
page.
-}
menuId : String -> Option msg
menuId id =
    Internal.option (\c -> { c | menuId = id })


{-| Construct one item in a FAB menu — emits an `<m3e-fab-menu-item>` with an
icon slot and a text label.

BUG FIX #18: emits `m3e-fab-menu-item`, NOT `m3e-menu-item`.

-}
item :
    { icon : String, label : String, onClick : msg }
    -> Renderable { s | fabMenuItem : Supported } msg
item req =
    Internal.fromNode
        (Node.element "m3e-fab-menu-item"
            [ Node.on "click" (Decode.succeed req.onClick) ]
            [ Node.element "span"
                [ Node.attribute "slot" "icon"
                , Node.attribute "aria-hidden" "true"
                ]
                [ Node.element "m3e-icon" [ Node.attribute "name" req.icon ] [] ]
            , Node.text req.label
            ]
        )


view :
    { triggerIcon : String
    , name : String
    , items : List (Renderable { fabMenuItem : Supported } msg)
    }
    -> List (Option msg)
    -> Renderable { s | fabMenu : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { variant = Primary, menuId = "fab-menu" }

        -- The FAB trigger: m3e-fab with aria-label + icon + menu-trigger inside
        fabTrigger =
            Node.element "m3e-fab"
                [ Node.attribute "aria-label" req.name ]
                [ Node.element "m3e-icon"
                    [ Node.attribute "name" req.triggerIcon
                    , Node.attribute "aria-hidden" "true"
                    ]
                    []
                , Node.element "m3e-fab-menu-trigger"
                    [ Node.attribute "for" c.menuId ]
                    []
                ]

        -- The FAB menu: m3e-fab-menu with id + variant + items
        fabMenu =
            Node.element "m3e-fab-menu"
                [ Node.attribute "id" c.menuId
                , Node.rawAttr (Cem.variant (toCemVariant c.variant))
                ]
                (List.map Renderable.toNode req.items)
    in
    Internal.fromNode
        (Node.element "div" [] [ fabTrigger, fabMenu ])


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Primary ->
            Cem.Primary

        Secondary ->
            Cem.Secondary

        Tertiary ->
            Cem.Tertiary
