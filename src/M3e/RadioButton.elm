module M3e.RadioButton exposing
    ( Option
    , view
    , disabled, required, onChange
    )

{-| `<m3e-radio-group>` + `<m3e-radio>` — a group of radio buttons for
selecting exactly one option from a small set (Material 3 Radio button).

Spec (per docs/CONVENTIONS.md):

  - Required:   { name : String
               , options : List { value : String, label : String }
               , selected : Maybe String }
               (name = a11y aria-label on the group + the shared `name`
               attribute threaded onto every `<m3e-radio>`)
  - Options:    disabled, required, onChange
  - Slots:      none (radios rendered as children of the group)
  - Properties: disabled (group), required (group), checked (per radio)
               all via Node.property — introspectable/testable
  - Events:     click on each radio → String (the clicked option value)
  - A11y:       aria-label = name on `<m3e-radio-group>`
  - Tag:        radioButton

F-bug fix: `<m3e-radio>` is slotless. Passing the visible label as a
CHILD of the radio element silently drops it. Instead each radio is
wrapped in a `<label>` element, with the `<m3e-radio>` and the label
text as **siblings** inside the label:

    <label>
      <m3e-radio name="..." checked /> ← zero children
      Label text                        ← sibling, not child
    </label>

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Disabled Bool
    | Required Bool
    | OnChange (String -> msg)


{-| Disable the whole group (and every radio within it). -}
disabled : Bool -> Option msg
disabled =
    Disabled


{-| Mark the group as required for form submission. -}
required : Bool -> Option msg
required =
    Required


{-| Wire a change handler. Receives the `value` string of the clicked
radio option.
-}
onChange : (String -> msg) -> Option msg
onChange =
    OnChange


type alias Config msg =
    { disabled : Bool
    , required : Bool
    , onChange : Maybe (String -> msg)
    }


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        Disabled b ->
            { c | disabled = b }

        Required b ->
            { c | required = b }

        OnChange f ->
            { c | onChange = Just f }


view :
    { name : String
    , options : List { value : String, label : String }
    , selected : Maybe String
    }
    -> List (Option msg)
    -> Renderable { s | radioButton : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { disabled = False, required = False, onChange = Nothing }
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-radio-group"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.attribute "name" req.name)
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.required then
                    Just (Node.property "required" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (List.map (renderOption req.name req.selected c) req.options)
        )


renderOption :
    String
    -> Maybe String
    -> Config msg
    -> { value : String, label : String }
    -> Node.Node msg
renderOption groupName selected cfg opt =
    let
        isChecked =
            selected == Just opt.value
    in
    Node.element "label"
        []
        [ Node.element "m3e-radio"
            (List.filterMap identity
                [ Just (Node.attribute "name" groupName)
                , Just (Node.property "checked" (Encode.bool isChecked))
                , if cfg.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\f -> Node.on "click" (Decode.succeed (f opt.value)))
                    cfg.onChange
                ]
            )
            []
        , Node.text opt.label
        ]
