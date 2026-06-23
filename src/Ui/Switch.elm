module Ui.Switch exposing
    ( Switch
    , new
    , withId, withHelp, withError, withDisabled, withHandleIcons
    , view
    )

{-| Typed builder for `<m3e-switch>` — a control for instantly toggling
a setting on or off. Mirrors the Material 3 [Switch][m3] surface 1:1.

[m3]: https://m3.material.io/components/switch/overview

When to choose Switch vs sibling controls (Material guidance):

  - **`Ui.Switch`** — use for settings that take effect _immediately_
    and that can be independently controlled (e.g. "Dark mode",
    "Email notifications").
  - **`Ui.Checkbox`** — use when the user is selecting items in a list
    that get committed on form submit, or when a tristate is needed.
  - **`Ui.RadioButton`** — use for _exclusive_ single-choice in a small
    group.

A switch carries a single boolean state — no tristate / indeterminate
mode. The change handler runs immediately on user interaction.


# Required-by-design

`new` requires:

  - `label` — visible adjacent text; the primary affordance.
  - `checked` — the current on/off state.
  - `onChange` — handler receiving the _new_ boolean state.


# Optional handle icons

Per Material spec, the switch handle can include an optional icon that
communicates the on/off state. `withHandleIcons` toggles m3e's built-in
checkmark / dash glyph pair — useful when the switch sits without
neighboring context that makes its current state unambiguous.


# Quick examples

A settings-style switch:

    Ui.Switch.new
        { label = "Email notifications"
        , checked = state.emailEnabled
        , onChange = EmailToggled
        }
        |> Ui.Switch.view

With handle icons (more glanceable):

    Ui.Switch.new
        { label = "Dark mode"
        , checked = state.darkMode
        , onChange = DarkModeToggled
        }
        |> Ui.Switch.withHandleIcons True
        |> Ui.Switch.view

With help text:

    Ui.Switch.new
        { label = "Auto-renew subscription"
        , checked = state.autoRenew
        , onChange = AutoRenewToggled
        }
        |> Ui.Switch.withHelp (text "Charges your card 7 days before expiry.")
        |> Ui.Switch.view


# Type

@docs Switch


# Constructor

@docs new


# Modifiers

@docs withId, withHelp, withError, withDisabled, withHandleIcons


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.FormField
import M3e.Switch



-- TYPES ------------------------------------------------------------------


{-| A switch, built with `new` and configured with `with*` modifiers.
-}
type Switch msg
    = Switch (Config msg)


type alias Config msg =
    { id : Maybe String
    , label : String
    , checked : Bool
    , onChange : Bool -> msg
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    , disabled : Bool
    , handleIcons : Bool
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a switch.

    Ui.Switch.new
        { label = "Email notifications"
        , checked = state.emailEnabled
        , onChange = EmailToggled
        }
        |> Ui.Switch.view

The `onChange` handler receives the _new_ boolean state.

-}
new : { label : String, checked : Bool, onChange : Bool -> msg } -> Switch msg
new c =
    Switch
        { id = Nothing
        , label = c.label
        , checked = c.checked
        , onChange = c.onChange
        , help = Nothing
        , error = Nothing
        , disabled = False
        , handleIcons = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute on the underlying `<m3e-switch>`.
-}
withId : String -> Switch msg -> Switch msg
withId id (Switch cfg) =
    Switch { cfg | id = Just id }


{-| Set help text rendered beneath the switch.
-}
withHelp : Html msg -> Switch msg -> Switch msg
withHelp help (Switch cfg) =
    Switch { cfg | help = Just help }


{-| Set an error message. When set, the field renders in its error
visual style and the error message replaces help text.
-}
withError : Html msg -> Switch msg -> Switch msg
withError error (Switch cfg) =
    Switch { cfg | error = Just error }


{-| Mark the switch as disabled — non-interactive.
-}
withDisabled : Bool -> Switch msg -> Switch msg
withDisabled disabled (Switch cfg) =
    Switch { cfg | disabled = disabled }


{-| Show or hide the optional handle icons (m3e's built-in checkmark
when on / dash when off). Per Material guidance, use these when the
switch's current state needs to be unambiguous at a glance and no
neighboring context provides that signal.
-}
withHandleIcons : Bool -> Switch msg -> Switch msg
withHandleIcons enabled (Switch cfg) =
    Switch { cfg | handleIcons = enabled }



-- RENDER -----------------------------------------------------------------


{-| Render the switch (wrapped in its form-field chrome) to `Html`.
-}
view : Switch msg -> Html msg
view (Switch cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ switchElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


switchElement : Config msg -> Html msg
switchElement cfg =
    M3e.Switch.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Switch.checked cfg.checked)
            , Just (M3e.Switch.disabled cfg.disabled)
            , if cfg.handleIcons then
                Just (M3e.Switch.icons M3e.Switch.Both)

              else
                Nothing
            , Just (M3e.Switch.onChange (changeDecoder cfg.onChange))
            ]
        )
        []


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            -- FormField has no label slot; the label is a default-slot child.
            [ Maybe.map Attr.for cfg.id
            ]
        )
        [ Html.text cfg.label ]


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []


changeDecoder : (Bool -> msg) -> Decode.Decoder msg
changeDecoder toMsg =
    Decode.at [ "target", "checked" ] Decode.bool
        |> Decode.map toMsg
