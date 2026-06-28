module M3e.Switch exposing
    ( view
    , Option, Icons(..)
    , checked, disabled, icons, onChange
    , name, value
    )

{-| `<m3e-switch>` — an on/off toggle for a setting that takes effect immediately.

Upstream mixins: `FormAssociated` → `name` (attr), `value` (attr, default `"on"`).

Spec (per docs/CONVENTIONS.md):

  - Required: { ariaLabel : String }
    (the a11y label — switch renders bare with no visible text,
    so a required aria-label is mandatory for accessibility)
  - Options: checked, disabled, icons, onChange, name, value
  - Slots: none (leaf element)
  - Properties: checked (Node.property "checked"), disabled (Node.property "disabled")
    — introspectable/testable; Test.Html cannot read DOM properties
  - Attrs: icons (string enum) via Cem.M3e.Switch.icons wrapped in Node.rawAttr
    (opaque; not introspectable — callers never need to read it back);
    name, value via Node.attribute (introspectable; form participation)
  - Events: change → Bool (decoded from event.target.checked)
  - Escape: none (leaf)
  - Tag: m3e-switch

Note on `checked`: `Cem.M3e.Switch.checked` delegates to
`Html.Attributes.checked`, which Elm's virtual-DOM implements as
`property "checked" (Json.Encode.bool _)`. We therefore emit it via
`Node.property "checked"` so the IR can see and test it.

Upstream reference: `custom-elements.json` — `m3e-switch`, property `icons`,
parsedType `'none' | 'selected' | 'both'`, default `"none"`.

@docs view
@docs Option, Icons
@docs checked, disabled, icons, onChange
@docs name, value

-}

import Cem.M3e.Switch as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Which handle icons to show on the switch track.

  - `None` — no icons (upstream default: `"none"`)
  - `Selected` — icon only when the switch is on (`"selected"`)
  - `Both` — icon when on AND when off (`"both"`)

-}
type Icons
    = None
    | Selected
    | Both


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
disabled =
    Attr.disabled


{-| Choose which handle icons to display. Upstream attribute `icons`;
default is `None` (no attribute emitted, matching upstream default `"none"`).
-}
icons : Icons -> Option msg
icons v =
    Internal.option (\c -> { c | icons = Just v })


{-| Wire a change handler. The decoder reads `event.target.checked` (a Bool).
-}
onChange : (Bool -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Set the form field name (the `name` attribute on `<m3e-switch>`).
This identifies the switch when its containing form is submitted.
Upstream: `FormAssociated` mixin → `name` attribute.
-}
name : String -> Option msg
name v =
    Internal.option (\c -> { c | name = Just v })


{-| Set the submitted value (the `value` attribute on `<m3e-switch>`).
Upstream default is `"on"`. Only submitted when the switch is checked.
Upstream: `FormAssociated` mixin → `value` attribute, default `"on"`.
-}
value : String -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , icons : Maybe Icons
    , onChange : Maybe (Bool -> msg)
    , name : Maybe String
    , value : Maybe String
    }


{-| Render the switch. `ariaLabel` is the required accessible label (the switch
has no visible text).
-}
view : { ariaLabel : String } -> List (Option msg) -> Element { s | switch : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { checked = False
                , disabled = False
                , icons = Nothing
                , onChange = Nothing
                , name = Nothing
                , value = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-switch"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.ariaLabel)
                , Just (Node.property "checked" (Encode.bool c.checked))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (\v -> Node.rawAttr (Cem.icons (toCemIcons v))) c.icons
                , Maybe.map (\v -> Node.attribute "name" v) c.name
                , Maybe.map (\v -> Node.attribute "value" v) c.value
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


toCemIcons : Icons -> Cem.Icons
toCemIcons v =
    case v of
        None ->
            Cem.None

        Selected ->
            Cem.Selected

        Both ->
            Cem.Both
