module M3e.Checkbox exposing
    ( view, checked, disabled, indeterminate, name, required
    , value, onBeforeinput, onInput, onChange, onInvalid, onClick
    )

{-| A checkbox that allows a user to select one or more options from a limited number of choices.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `invalid`: Dispatched when a form is submitted and the element fails constraint validation.
  - `click`: Dispatched when the element is clicked.

<!-- elm-cem:docmeta category=Selection -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.Checkbox.view [] []
    , M3e.Checkbox.view [ M3e.Checkbox.checked True ] []
    , M3e.Checkbox.view [ M3e.Checkbox.indeterminate True ] []
    ]
```

<!-- elm-cem:example title="Labels" -->
```elm
[ Native.node Html.label [] [ M3e.Checkbox.view [] [], Kit.text "Checkbox 1" ]
    , M3e.Checkbox.view [ M3e.Attributes.id "chk2" ] []
    , Native.node Html.label [ Native.attribute "for" "chk2" ] [ Kit.text "Checkbox 2" ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.disabled True ] [], Kit.text "Disabled Checkbox 1" ]
    , M3e.Checkbox.view [ M3e.Attributes.id "chk3", M3e.Checkbox.disabled True ] []
    , Native.node Html.label [ Native.attribute "for" "chk3" ] [ Kit.text "Disabled Checkbox 2" ]
    ]
```

<!-- elm-cem:example title="Required" -->
```elm
Native.node Html.form [] [ Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.name "accepted", M3e.Checkbox.required True ] [], Kit.text "I accept the Terms and Conditions" ], Native.br, M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.type_ M3e.Token.submit ] [ Kit.text "Submit" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Attributes.class "density-3" ] [], Kit.text "Density -3" ]
    , Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Attributes.class "density-2" ] [], Kit.text "Density -2" ]
    , Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Attributes.class "density-1" ] [], Kit.text "Density -1" ]
    , Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Attributes.class "density-0" ] [], Kit.text "Density 0" ]
    ]
```

@docs view, checked, disabled, indeterminate, name, required
@docs value, onBeforeinput, onInput, onChange, onInvalid, onClick

-}

import M3e.Html.Checkbox
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-checkbox>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | checkbox : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Checkbox.checkbox
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
    M3e.Html.Checkbox.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Checkbox.disabled


{-| Whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.Checkbox.indeterminate


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Checkbox.name


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.Checkbox.required


{-| A string representing the value of the checkbox. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Checkbox.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Checkbox.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Checkbox.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Checkbox.onChange


{-| Listen for `invalid` events.
-}
onInvalid : msg -> Markup.Html.Attr.Attr { c | onInvalid : M3e.Token.Supported } msg
onInvalid =
    M3e.Html.Checkbox.onInvalid


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Checkbox.onClick
