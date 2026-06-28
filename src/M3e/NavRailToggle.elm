module M3e.NavRailToggle exposing
    ( view
    , Option
    , for
    )

{-| `<m3e-nav-rail-toggle>` — a companion element, nested within a clickable
element, that toggles the expanded state of a [`M3e.NavigationRail`](M3e.NavigationRail).

Place it inside a `<m3e-icon-button>` alongside `<m3e-icon>` children. Wire
it to the target `<m3e-nav-rail>` by passing the rail's `id` to [`for`](#for).

Spec (per upstream CEM):

  - Required: none
  - Options: for
  - Slots: none (functional companion — no visible content)
  - Attrs: `for` via `Node.attribute` (introspectable)
  - Tag: navRailToggle

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


{-| Wire this toggle to a navigation rail by its `id` (the `for` attribute).
-}
for : String -> Option msg
for v =
    Internal.option (\c -> { c | for = Just v })


{-| Render an `<m3e-nav-rail-toggle>`. Place inside a toggle icon button
alongside icon children.

    M3e.IconButton.view { icon = "menu", ariaLabel = "Toggle rail" }
        [ M3e.IconButton.toggle True
        , M3e.IconButton.extraContent
            [ M3e.Element.fromNode
                (M3e.NavRailToggle.view [ M3e.NavRailToggle.for "my-rail" ]
                    |> M3e.Element.toNode
                )
            ]
        ]

-}
view : List (Option msg) -> Element { s | navRailToggle : Supported } msg
view opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { for = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-nav-rail-toggle"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "for") c.for
                ]
            )
            []
        )
