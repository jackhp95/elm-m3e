module M3e.SplitButton exposing
    ( view
    , Option, Variant(..)
    , variant, disabled
    )

{-| `<m3e-split-button>` — a primary action button paired with a trailing
icon-button trigger for related actions.

Spec (per docs/CONVENTIONS.md):

  - Required: { label : String
    , name : String -- a11y label for the trailing icon-button
    , trailingIcon : String -- m3e-icon glyph name
    , onPrimaryClick : msg -- handler for the leading button
    , onTriggerClick : msg -- handler for the trailing icon-button
    }
  - Options: variant, disabled
  - Slots: "leading-button" ← `<m3e-button>` (the primary action)
    "trailing-button" ← `<m3e-icon-button>` (the dropdown trigger)
  - Properties: none (variant is a string attribute)
  - Attrs: variant via Node.rawAttr (Cem enum)
  - Escape: none (strict: leading-button and trailing-button are fixed kinds)
  - Tag: splitButton

BUG FIX #16: the previous `Ui.SplitButton` slotted native `<button>` elements,
but `<m3e-split-button>` adopts only `<m3e-button>` / `<m3e-icon-button>`. This
port emits the correct element types by constructing the slot children via
`M3e.Button.view` and a hand-built `<m3e-icon-button>` node respectively.

@docs view
@docs Option, Variant
@docs variant, disabled

-}

import Cem.M3e.SplitButton as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Appearance variant (default `Filled`).
-}
type Variant
    = Elevated
    | Filled
    | Tonal
    | Outlined


{-| An option configuring a split button.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the appearance variant (default `Filled`).
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Disable both the leading and trailing buttons.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


type alias Config =
    { variant : Variant
    , disabled : Bool
    }


{-| Render the split button: a leading `<m3e-button>` (the primary action)
paired with a trailing `<m3e-icon-button>` trigger for related actions.
-}
view :
    { label : String
    , name : String
    , trailingIcon : String
    , onPrimaryClick : msg
    , onTriggerClick : msg
    }
    -> List (Option msg)
    -> Renderable { s | splitButton : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { variant = Filled, disabled = False }

        -- Leading button: m3e-button (FIX #16 — not a native <button>)
        leadingButton : Node.Node msg
        leadingButton =
            Button.view
                { label = req.label, variant = toButtonVariant c.variant }
                (List.filterMap identity
                    [ Just (Button.onClick req.onPrimaryClick)
                    , if c.disabled then
                        Just (Button.disabled True)

                      else
                        Nothing
                    ]
                )
                |> Renderable.toNode
                |> Node.withSlot "leading-button"

        -- Trailing button: m3e-icon-button (FIX #16 — not a native <button>)
        trailingButton : Node.Node msg
        trailingButton =
            Node.element "m3e-icon-button"
                (List.filterMap identity
                    [ Just (Node.attribute "aria-label" req.name)
                    , if c.disabled then
                        Just (Node.property "disabled" (Encode.bool True))

                      else
                        Nothing
                    , Just (Node.on "click" (Decode.succeed req.onTriggerClick))
                    ]
                )
                [ Node.element "m3e-icon" [ Node.attribute "name" req.trailingIcon ] [] ]
                |> Node.withSlot "trailing-button"
    in
    Internal.fromNode
        (Node.element "m3e-split-button"
            [ Node.rawAttr (Cem.variant (toCemVariant c.variant)) ]
            [ leadingButton, trailingButton ]
        )


toButtonVariant : Variant -> Button.Variant
toButtonVariant v =
    case v of
        Elevated ->
            Button.Elevated

        Filled ->
            Button.Filled

        Tonal ->
            Button.Tonal

        Outlined ->
            Button.Outlined


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Elevated ->
            Cem.Elevated

        Filled ->
            Cem.Filled

        Tonal ->
            Cem.Tonal

        Outlined ->
            Cem.Outlined
