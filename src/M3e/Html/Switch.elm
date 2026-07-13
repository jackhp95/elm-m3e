module M3e.Html.Switch exposing
    ( switch, checked, disabled, icons, name, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-| Middle layer for `<m3e-switch>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Switch` module for everyday use.

@docs switch, checked, disabled, icons, name, value
@docs onBeforeinput, onInput, onChange, onClick

-}

import Html
import Json.Decode
import M3e.Raw.Switch
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An on/off control that can be toggled by clicking.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

-}
switch :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , icons : M3e.Token.Supported
            , name : M3e.Token.Supported
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
switch attributes children =
    M3e.Raw.Switch.switch
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Switch.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Switch.disabled


{-| The icons to present. (default: `"none"`)
-}
icons :
    M3e.Token.Value
        { both : M3e.Token.Supported
        , none : M3e.Token.Supported
        , selected : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
icons v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Switch.icons
        (M3e.Token.toString v_)


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Switch.name


{-| A string representing the value of the switch. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Switch.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Switch.onBeforeinput
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
        M3e.Raw.Switch.onInput
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
        M3e.Raw.Switch.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Switch.onClick
        (Json.Decode.succeed f_)
