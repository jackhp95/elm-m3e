module M3e.DatePickerToggle exposing
    ( view
    , Option
    , for
    )

{-| `<m3e-datepicker-toggle>` — a companion element, nested within a clickable
element, that opens a [`M3e.DatePicker`](M3e.DatePicker) panel.

Place it inside a button-like element. Wire it to the target datepicker by
passing the datepicker's `id` to [`for`](#for).

Spec (per upstream CEM):

  - Required: none
  - Options: for
  - Slots: none (functional companion — no visible content)
  - Attrs: `for` via `Node.attribute` (introspectable)
  - Tag: datePickerToggle

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


{-| Wire this toggle to a datepicker by its `id` (the `for` attribute).
-}
for : String -> Option msg
for v =
    Internal.option (\c -> { c | for = Just v })


{-| Render an `<m3e-datepicker-toggle>`. Place inside a clickable element
to open the target datepicker.

    M3e.Button.view { label = "Pick date", variant = M3e.Button.Filled }
        [ M3e.Button.extraContent
            [ M3e.Element.fromNode
                (M3e.DatePickerToggle.view [ M3e.DatePickerToggle.for "my-datepicker" ]
                    |> M3e.Element.toNode
                )
            ]
        ]

-}
view : List (Option msg) -> Element { s | datePickerToggle : Supported } msg
view opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { for = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-datepicker-toggle"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "for") c.for
                ]
            )
            []
        )
