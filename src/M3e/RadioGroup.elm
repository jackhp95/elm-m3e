module M3e.RadioGroup exposing
    ( view, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange
    )

{-| A container for a set of radio buttons.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state of a radio button changes.
  - `input`: Dispatched when the checked state of a radio button changes.
  - `change`: Dispatched when the checked state of a radio button changes.

<!-- elm-cem:docmeta category=Selection -->


## Examples


### Examples

<!-- elm-cem:example title="Radio groups" -->
```elm
M3e.RadioGroup.view [] [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ]
```

<!-- elm-cem:example title="Labels" -->
```elm
[ Native.node Html.label [ Native.attribute "for" "radio-group" ] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.Attributes.id "radio-group" ] [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ Native.node Html.label [ Native.attribute "for" "radio-group2" ] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.Attributes.id "radio-group2" ] [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.disabled True, M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ]
    ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
[ Native.node Html.label [ Native.attribute "for" "radio-group3" ] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.Attributes.id "radio-group3", M3e.RadioGroup.disabled True ] [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ]
    ]
```

<!-- elm-cem:example title="Required" -->
```elm
[ Native.node Html.label [ Native.attribute "for" "radio-group4" ] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.Attributes.id "radio-group4", M3e.RadioGroup.required True ] [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ Native.node Html.label [] [ M3e.Radio.view [ M3e.Attributes.class "density-3" ] [], Kit.text "Density -3" ]
    , Native.node Html.label [] [ M3e.Radio.view [ M3e.Attributes.class "density-2" ] [], Kit.text "Density -2" ]
    , Native.node Html.label [] [ M3e.Radio.view [ M3e.Attributes.class "density-1" ] [], Kit.text "Density -1" ]
    , Native.node Html.label [] [ M3e.Radio.view [ M3e.Attributes.class "density-0" ] [], Kit.text "Density 0" ]
    ]
```

@docs view, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange

-}

import M3e.Html.RadioGroup
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-radio-group>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | radioGroup : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.RadioGroup.radioGroup
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid :
    String
    -> Markup.Html.Attr.Attr { c | ariaInvalid : M3e.Token.Supported } msg
ariaInvalid =
    M3e.Html.RadioGroup.ariaInvalid


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.RadioGroup.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.RadioGroup.name


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.RadioGroup.required


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.RadioGroup.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.RadioGroup.onInput


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.RadioGroup.onChange
