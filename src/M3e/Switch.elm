module M3e.Switch exposing
    ( view, checked, disabled, icons, name, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-| An on/off control that can be toggled by clicking.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

<!-- elm-cem:docmeta category=Selection -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Switch.view [ M3e.Switch.checked True ] []
```

<!-- elm-cem:example title="Labels" -->
```elm
[ Native.node Html.label [] [ M3e.Switch.view [] [], Kit.text "Switch 1" ]
    , M3e.Switch.view [ M3e.Attributes.id "switch2" ] []
    , Native.node Html.label [ Native.attribute "for" "switch2" ] [ Kit.text "Switch 2" ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ Native.node Html.label [] [ M3e.Switch.view [ M3e.Switch.disabled True ] [], Kit.text "Disabled Switch 1" ]
    , M3e.Switch.view [ M3e.Attributes.id "chk3", M3e.Switch.disabled True ] []
    , Native.node Html.label [ Native.attribute "for" "chk3" ] [ Kit.text "Disabled Switch 2" ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Switch.view [ M3e.Attributes.class "density-3" ] []
    , M3e.Switch.view [ M3e.Attributes.class "density-2" ] []
    , M3e.Switch.view [ M3e.Attributes.class "density-1" ] []
    , M3e.Switch.view [ M3e.Attributes.class "density-0" ] []
    ]
```


### Icons

<!-- elm-cem:example title="Icons" -->
```elm
[ M3e.Switch.view [ M3e.Switch.icons M3e.Token.selected, M3e.Switch.checked True ] []
    , M3e.Switch.view [ M3e.Switch.icons M3e.Token.both ] []
    ]
```

@docs view, checked, disabled, icons, name, value
@docs onBeforeinput, onInput, onChange, onClick

-}

import M3e.Html.Switch
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-switch>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | switch : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Switch.switch
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.Switch.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Switch.disabled


{-| The icons to present. (default: `"none"`)
-}
icons :
    M3e.Token.Value
        { both : M3e.Token.Supported
        , none : M3e.Token.Supported
        , selected : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | icons : M3e.Token.Supported } msg
icons =
    M3e.Html.Switch.icons


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Switch.name


{-| A string representing the value of the switch. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Switch.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Switch.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Switch.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Switch.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Switch.onClick
