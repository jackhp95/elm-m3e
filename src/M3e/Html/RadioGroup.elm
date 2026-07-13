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
import M3e.Raw.RadioGroup
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
        (Markup.Html.Attr.Attr
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
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid :
    String
    -> Markup.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.ariaInvalid


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.name


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RadioGroup.required


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RadioGroup.onChange
        (Json.Decode.succeed f_)
