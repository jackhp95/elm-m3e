module M3e.Html.Checkbox exposing
    ( checkbox, checked, disabled, indeterminate, name, required
    , value, onBeforeinput, onInput, onChange, onInvalid, onClick
    )

{-| Middle layer for `<m3e-checkbox>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Checkbox` module for everyday use.

@docs checkbox, checked, disabled, indeterminate, name, required
@docs value, onBeforeinput, onInput, onChange, onInvalid, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Checkbox
import M3e.Token


{-| A checkbox that allows a user to select one or more options from a limited number of choices.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `invalid`: Dispatched when a form is submitted and the element fails constraint validation.
  - `click`: Dispatched when the element is clicked.

-}
checkbox :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onInvalid : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
checkbox attributes children =
    M3e.Raw.Checkbox.checkbox
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.disabled


{-| Whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.indeterminate


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.name


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> M3e.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.required


{-| A string representing the value of the checkbox. (default: `"on"`)
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Checkbox.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Checkbox.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Checkbox.onInput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Checkbox.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `invalid` events.
-}
onInvalid : msg -> M3e.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Checkbox.onInvalid
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Checkbox.onClick
        (Json.Decode.succeed f_)
