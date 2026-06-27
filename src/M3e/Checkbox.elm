module M3e.Checkbox exposing
    ( Option
    , checked, indeterminate, disabled, onChange
    , view
    )

{-| `<m3e-checkbox>` — a checkbox for selecting items or toggling a value (Material 3).

Spec (per docs/CONVENTIONS.md):

  - Required: { name : String }
    (the a11y label — checkbox renders bare with no visible text,
    so a required aria-label is mandatory for accessibility)
  - Options: checked, indeterminate, disabled, onChange
  - Slots: none (leaf element)
  - Properties: checked, indeterminate, disabled — all via Node.property so
    a unit test can assert their state (Test.Html cannot)
  - Events: change → Bool (decoded from event.target.checked)
  - Escape: none (leaf)
  - Tag: m3e-checkbox

Note on `checked`: `Cem.M3e.Checkbox.checked` delegates to
`Html.Attributes.checked`, which Elm's virtual-DOM implements as
`property "checked" (Json.Encode.bool _)`. We therefore emit it via
`Node.property "checked"` so the IR can see and test it.


# Type

@docs Option


# Options

@docs checked, indeterminate, disabled, onChange

@docs view

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


type alias Config msg =
    { checked : Bool
    , indeterminate : Bool
    , disabled : Bool
    , onChange : Maybe (Bool -> msg)
    }


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the checked state. Maps to the `checked` DOM property.
-}
checked : Bool -> Option msg
checked b =
    Internal.option (\c -> { c | checked = b })


{-| Set the indeterminate state (e.g. a "select all" with mixed children).
Maps to the `indeterminate` DOM property.
-}
indeterminate : Bool -> Option msg
indeterminate b =
    Internal.option (\c -> { c | indeterminate = b })


{-| Disable the checkbox. Maps to the `disabled` DOM property.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Wire a change handler. The decoder reads `event.target.checked` (a Bool).
-}
onChange : (Bool -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Render the checkbox. The required `name` becomes the `aria-label` (the
checkbox renders with no visible text).
-}
view : { name : String } -> List (Option msg) -> Element { s | checkbox : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { checked = False
                , indeterminate = False
                , disabled = False
                , onChange = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-checkbox"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.property "checked" (Encode.bool c.checked))
                , if c.indeterminate then
                    Just (Node.property "indeterminate" (Encode.bool True))

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\f ->
                        Node.on "change"
                            (Decode.map f (Decode.at [ "target", "checked" ] Decode.bool))
                    )
                    c.onChange
                ]
            )
            []
        )
