module M3e.DrawerToggle exposing
    ( view
    , Option
    , for
    )

{-| `<m3e-drawer-toggle>` — a companion element, nested within a clickable
element, that toggles the opened state of a [`M3e.NavigationDrawer`](M3e.NavigationDrawer)
drawer container.

Place it inside a `<m3e-icon-button>` alongside `<m3e-icon>` children. Wire
it to the target `<m3e-drawer-container>` by passing the drawer's `id` to
[`for`](#for).

Spec (per upstream CEM):

  - Required: none
  - Options: for
  - Slots: none (functional companion — no visible content)
  - Attrs: `for` via `Node.attribute` (introspectable)
  - Tag: drawerToggle

@docs view
@docs Option
@docs for

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


type alias Config =
    { for : Maybe String
    }


{-| Configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| Wire this toggle to a drawer container by its `id` (the `for` attribute).
-}
for : String -> Option msg
for v =
    Internal.option (\c -> { c | for = Just v })


{-| Render an `<m3e-drawer-toggle>`. Place inside a clickable element
(e.g. `M3e.IconButton.view`) alongside icon children.

    M3e.IconButton.view { icon = "menu", ariaLabel = "Menu" }
        [ M3e.IconButton.toggle True
        , M3e.IconButton.extraContent
            [ M3e.Element.fromNode
                (M3e.DrawerToggle.view [ M3e.DrawerToggle.for "nav-drawer" ]
                    |> M3e.Element.toNode
                )
            ]
        ]

-}
view : List (Option msg) -> Element { s | drawerToggle : Supported } msg
view opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { for = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-drawer-toggle"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "for") c.for
                ]
            )
            []
        )
