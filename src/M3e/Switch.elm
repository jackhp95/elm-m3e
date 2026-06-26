module M3e.Switch exposing
    ( Option
    , view
    , checked, disabled, handleIcons, onChange
    )

{-| `<m3e-switch>` — an on/off toggle for a setting that takes effect immediately.

Spec (per docs/CONVENTIONS.md):

  - Required:   { name : String }
                (the a11y label — switch renders bare with no visible text,
                so a required aria-label is mandatory for accessibility)
  - Options:    checked, disabled, handleIcons, onChange
  - Slots:      none (leaf element)
  - Properties: checked (Node.property "checked"), disabled (Node.property "disabled")
                — introspectable/testable; Test.Html cannot read DOM properties
  - Attrs:      icons (string enum) via Cem.M3e.Switch.icons wrapped in Node.rawAttr
                (opaque; not introspectable — callers never need to read it back)
  - Events:     change → Bool (decoded from event.target.checked)
  - Escape:     none (leaf)
  - Tag:        m3e-switch

Note on `checked`: `Cem.M3e.Switch.checked` delegates to
`Html.Attributes.checked`, which Elm's virtual-DOM implements as
`property "checked" (Json.Encode.bool _)`. We therefore emit it via
`Node.property "checked"` so the IR can see and test it.

-}

import Cem.M3e.Switch as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Checked Bool
    | Disabled Bool
    | HandleIcons Bool
    | OnChange (Bool -> msg)


{-| Set the checked (on/off) state. Maps to the `checked` DOM property.
-}
checked : Bool -> Option msg
checked =
    Checked


{-| Disable the switch. Maps to the `disabled` DOM property.
-}
disabled : Bool -> Option msg
disabled =
    Disabled


{-| Show handle icons (m3e's built-in checkmark when on / dash when off).
`True` → icons="both"; `False` (default) → no icons attr emitted.
-}
handleIcons : Bool -> Option msg
handleIcons =
    HandleIcons


{-| Wire a change handler. The decoder reads `event.target.checked` (a Bool).
-}
onChange : (Bool -> msg) -> Option msg
onChange =
    OnChange


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , handleIcons : Bool
    , onChange : Maybe (Bool -> msg)
    }


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        Checked b ->
            { c | checked = b }

        Disabled b ->
            { c | disabled = b }

        HandleIcons b ->
            { c | handleIcons = b }

        OnChange f ->
            { c | onChange = Just f }


view : { name : String } -> List (Option msg) -> Renderable { s | switch : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { checked = False
                , disabled = False
                , handleIcons = False
                , onChange = Nothing
                }
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-switch"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Just (Node.property "checked" (Encode.bool c.checked))
                , if c.disabled then Just (Node.property "disabled" (Encode.bool True)) else Nothing
                , if c.handleIcons then Just (Node.rawAttr (Cem.icons Cem.Both)) else Nothing
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
