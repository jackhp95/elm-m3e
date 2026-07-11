module M3e.Html.RadioGroup exposing
    ( radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange
    )

{-| Middle layer for `<m3e-radio-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RadioGroup` module for everyday use.

@docs radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.RadioGroup
import M3e.Token


{-| A container for a set of radio buttons.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state of a radio button changes.
  - `input`: Dispatched when the checked state of a radio button changes.
  - `change`: Dispatched when the checked state of a radio button changes.

-}
radioGroup :
    List
        (M3e.Html.Attr.Attr
            { ariaInvalid : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
radioGroup attributes children =
    M3e.Raw.RadioGroup.radioGroup
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid : String -> M3e.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    M3e.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.ariaInvalid


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.name


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> M3e.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.required


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onChange
        (Json.Decode.succeed f_)
