module M3e.RadioButton exposing
    ( Option
    , view
    , disabled, required, onChange
    )

{-| `<m3e-radio-group>` + `<m3e-radio>` — a group of radio buttons for
selecting exactly one option from a small set (Material 3 Radio button).

Spec (per docs/CONVENTIONS.md):

  - Required: { name : String
    , options : List { value : String, label : String }
    , selected : Maybe String }
    (name = a11y aria-label on the group + the shared `name`
    attribute threaded onto every `<m3e-radio>`)
  - Options: disabled, required, onChange
  - Slots: none (radios rendered as children of the group)
  - Properties: disabled (group), required (group), checked (per radio)
    all via Node.property — introspectable/testable
  - Events: `change` on `<m3e-radio-group>` → String decoded from
    `event.target.value` (the selected radio's value attribute).
    Upstream ref: `M3eRadioGroupElement` emits `change` when the
    checked state of any radio changes; `event.target.value` is
    `string | null`.
  - A11y: aria-label = name on `<m3e-radio-group>`
  - Tag: radioButton

F-bug fix: `<m3e-radio>` is slotless. Passing the visible label as a
CHILD of the radio element silently drops it. Instead each radio is
wrapped in a `<label>` element, with the `<m3e-radio>` and the label
text as **siblings** inside the label:

    <label>
      <m3e-radio name="..." value="..." checked /> ← zero children
      Label text                                    ← sibling, not child
    </label>

Each `<m3e-radio>` carries a `value` attribute so that
`event.target.value` on the group's `change` event returns the
correct value string.

@docs Option
@docs view
@docs disabled, required, onChange

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)


{-| Configuration option for a radio group, built by the helpers below.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Disable the whole group (and every radio within it).
-}
disabled : Bool -> Option msg
disabled =
    Attr.disabled


{-| Mark the group as required for form submission.
-}
required : Bool -> Option msg
required b =
    Internal.option (\c -> { c | required = b })


{-| Wire a change handler. Receives the `value` string of the newly
selected radio option, decoded from `event.target.value` on the
`<m3e-radio-group>`'s `change` event. Fired on both mouse click and
keyboard selection (unlike the old `click` approach).
-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


type alias Config msg =
    { disabled : Bool
    , required : Bool
    , onChange : Maybe (String -> msg)
    }


{-| Render a radio group. `name` is the shared radio name and the group's
accessible label, `options` are the selectable values/labels, and `selected`
is the currently chosen value (if any).
-}
view :
    { name : String
    , options : List { value : String, label : String }
    , selected : Maybe String
    }
    -> List (Option msg)
    -> Element { s | radioButton : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { disabled = False, required = False, onChange = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-radio-group"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.attribute "name" req.name)
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "required" (Encode.bool c.required))
                , Maybe.map
                    (\f ->
                        Node.on "change"
                            (Decode.at [ "target", "value" ] Decode.string
                                |> Decode.map f
                            )
                    )
                    c.onChange
                ]
            )
            (List.map (renderOption req.name req.selected c) req.options)
        )


renderOption :
    String
    -> Maybe String
    -> Config msg
    -> { value : String, label : String }
    -> Node msg
renderOption groupName selected cfg opt =
    let
        isChecked : Bool
        isChecked =
            selected == Just opt.value
    in
    Node.element "label"
        []
        [ Node.element "m3e-radio"
            [ Node.attribute "name" groupName
            , Node.attribute "value" opt.value
            , Node.property "checked" (Encode.bool isChecked)
            , Node.property "disabled" (Encode.bool cfg.disabled)
            ]
            []
        , Node.text opt.label
        ]
