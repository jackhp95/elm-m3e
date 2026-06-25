module Ui.Switch exposing
    ( Switch
    , new
    , withAttributes
    , withId, withDisabled, withHandleIcons
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

A switch renders **bare** (just the toggle, with its `label` kept as an
`aria-label`). For a visible label and supporting/error text, compose it with
[`Ui.Field`](Ui-Field):

    Ui.Field.new "Auto-renew subscription"
        |> Ui.Field.withHint (text "Charges your card 7 days before expiry.")
        |> Ui.Field.view
            (Ui.Switch.new
                { label = "Auto-renew subscription"
                , checked = state.autoRenew
                , onChange = AutoRenewToggled
                }
                |> Ui.Switch.view
            )


# Type

@docs Switch


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withDisabled, withHandleIcons


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Switch



-- TYPES ------------------------------------------------------------------


{-| A switch, built with `new` and configured with `with*` modifiers.
-}
type Switch msg
    = Switch (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , label : String
    , checked : Bool
    , onChange : Bool -> msg
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
        , attributes = []
        , label = c.label
        , checked = c.checked
        , onChange = c.onChange
        , disabled = False
        , handleIcons = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the rendered `<m3e-switch>`. The builder's structural
attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Switch msg -> Switch msg
withAttributes attributes (Switch cfg) =
    Switch { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-switch>`.
-}
withId : String -> Switch msg -> Switch msg
withId id (Switch cfg) =
    Switch { cfg | id = Just id }


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


{-| Render the switch to `Html` — a bare `<m3e-switch>` with its `label` as an
`aria-label`. Wrap it in [`Ui.Field`](Ui-Field) for a visible label / subscript.
-}
view : Switch msg -> Html msg
view (Switch cfg) =
    switchElement cfg.attributes cfg


controlId : Config msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.label


switchElement : List (Attribute msg) -> Config msg -> Html msg
switchElement extraAttrs cfg =
    M3e.Switch.component
        (extraAttrs
            ++ List.filterMap identity
                [ Just (Attr.id (controlId cfg))
                , Just (M3e.Switch.checked cfg.checked)
                , Just (M3e.Switch.disabled cfg.disabled)
                , if cfg.handleIcons then
                    Just (M3e.Switch.icons M3e.Switch.Both)

                  else
                    Nothing
                , Just (Attr.attribute "aria-label" cfg.label)
                , Just (M3e.Switch.onChange (changeDecoder cfg.onChange))
                ]
        )
        []


changeDecoder : (Bool -> msg) -> Decode.Decoder msg
changeDecoder toMsg =
    Decode.at [ "target", "checked" ] Decode.bool
        |> Decode.map toMsg


{-| Derive a stable, deterministic control id from the label text so the
`<label slot="label" for="...">` can anchor the control even when the
caller hasn't supplied an explicit `withId`.
-}
slugify : String -> String
slugify label =
    let
        slug : String
        slug =
            label
                |> String.toLower
                |> String.toList
                |> List.map
                    (\c ->
                        if Char.isAlphaNum c then
                            c

                        else
                            '-'
                    )
                |> String.fromList
                |> String.split "-"
                |> List.filter (not << String.isEmpty)
                |> String.join "-"
    in
    "uif-" ++ slug
