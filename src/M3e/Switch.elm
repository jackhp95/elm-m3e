module M3e.Switch exposing
    ( view
    , Option
    , checked, disabled, handleIcons, onChange
    )

{-| `<m3e-switch>` — an on/off toggle for a setting that takes effect immediately.

Spec (per docs/CONVENTIONS.md):

  - Required: { name : String }
    (the a11y label — switch renders bare with no visible text,
    so a required aria-label is mandatory for accessibility)
  - Options: checked, disabled, handleIcons, onChange
  - Slots: none (leaf element)
  - Properties: checked (Node.property "checked"), disabled (Node.property "disabled")
    — introspectable/testable; Test.Html cannot read DOM properties
  - Attrs: icons (string enum) via Cem.M3e.Switch.icons wrapped in Node.rawAttr
    (opaque; not introspectable — callers never need to read it back)
  - Events: change → Bool (decoded from event.target.checked)
  - Escape: none (leaf)
  - Tag: m3e-switch

Note on `checked`: `Cem.M3e.Switch.checked` delegates to
`Html.Attributes.checked`, which Elm's virtual-DOM implements as
`property "checked" (Json.Encode.bool _)`. We therefore emit it via
`Node.property "checked"` so the IR can see and test it.

@docs view
@docs Option
@docs checked, disabled, handleIcons, onChange

-}

import Cem.M3e.Switch as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| An option configuring a switch.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the checked (on/off) state. Maps to the `checked` DOM property.
-}
checked : Bool -> Option msg
checked b =
    Internal.option (\c -> { c | checked = b })


{-| Disable the switch. Maps to the `disabled` DOM property.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Show handle icons (m3e's built-in checkmark when on / dash when off).
`True` → icons="both"; `False` (default) → no icons attr emitted.
-}
handleIcons : Bool -> Option msg
handleIcons b =
    Internal.option (\c -> { c | handleIcons = b })


{-| Wire a change handler. The decoder reads `event.target.checked` (a Bool).
-}
onChange : (Bool -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , handleIcons : Bool
    , onChange : Maybe (Bool -> msg)
    }


{-| Render the switch. `name` is the required accessible label (the switch has
no visible text).
-}
view : { name : String } -> List (Option msg) -> Element { s | switch : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { checked = False
                , disabled = False
                , handleIcons = False
                , onChange = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-switch"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.property "checked" (Encode.bool c.checked))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , if c.handleIcons then
                    Just (Node.rawAttr (Cem.icons Cem.Both))

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
