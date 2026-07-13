module M3e.Html.Radio exposing
    ( radio, checked, disabled, name, required, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-| Middle layer for `<m3e-radio>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Radio` module for everyday use.

@docs radio, checked, disabled, name, required, value
@docs onBeforeinput, onInput, onChange, onClick

-}

import Html
import Json.Decode
import M3e.Raw.Radio
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A radio button that allows a user to select one option from a set of options.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

-}
radio :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
radio attributes children =
    M3e.Raw.Radio.radio
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Radio.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Radio.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Radio.name


{-| Whether the element is required.
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Radio.required


{-| A string representing the value of the radio. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Radio.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Radio.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Radio.onInput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Radio.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Radio.onClick
        (Json.Decode.succeed f_)
