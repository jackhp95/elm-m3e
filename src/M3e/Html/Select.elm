module M3e.Html.Select exposing
    ( select, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-select>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Select` module for everyday use.

@docs select, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Raw.Select
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A form control that allows users to select a value from a set of predefined options.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected state changes.
  - `toggle`: No description
  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.

**Slots:**

  - `arrow`: Renders the dropdown arrow.
  - `value`: Renders the selected value(s).

-}
select :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , panelClass : M3e.Token.Supported
            , required : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
select attributes children =
    M3e.Raw.Select.select
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.disabled


{-| Whether to hide the selection indicator for single select options. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.name


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> Markup.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
panelClass =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.panelClass


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Select.required


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Select.onChange
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle :
    (String -> msg)
    -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Select.onToggle
        (Json.Decode.map f_ (Json.Decode.at [ "newState" ] Json.Decode.string))


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Select.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Select.onInput
        (Json.Decode.succeed f_)
