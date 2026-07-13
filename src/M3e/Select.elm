module M3e.Select exposing
    ( view, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput, arrow
    , value
    )

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

<!-- elm-cem:docmeta category=Text inputs -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select1" (Native.node Html.label [ Native.attribute "for" "select1" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select1" (M3e.Select.view [ M3e.Attributes.id "select1" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Empty options" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select2" (Native.node Html.label [ Native.attribute "for" "select2" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select2" (M3e.Select.view [ M3e.Attributes.id "select2" ] [ M3e.Option.view [ M3e.Option.value "" ] [ Kit.text "None" ], M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select4" (Native.node Html.label [ Native.attribute "for" "select4" ] [ Kit.text "Toppings" ]), M3e.FormField.control "select4" (M3e.Select.view [ M3e.Attributes.id "select4", M3e.Select.multi True ] [ M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Extra cheese" ], M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Mushroom" ], M3e.Option.view [] [ Kit.text "Onion" ], M3e.Option.view [] [ Kit.text "Pepperoni" ], M3e.Option.view [] [ Kit.text "Sausage" ], M3e.Option.view [] [ Kit.text "Tomato" ] ]) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select5" (Native.node Html.label [ Native.attribute "for" "select5" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select5" (M3e.Select.view [ M3e.Attributes.id "select5", M3e.Select.disabled True ] [ M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select6" (Native.node Html.label [ Native.attribute "for" "select6" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select6" (M3e.Select.view [ M3e.Attributes.id "select6" ] [ M3e.Option.view [ M3e.Option.disabled True ] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Required" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select7" (Native.node Html.label [ Native.attribute "for" "select7" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select7" (M3e.Select.view [ M3e.Attributes.id "select7", M3e.Select.required True ] [ M3e.Option.view [ M3e.Option.value "" ] [ Kit.text "None" ], M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.FormField.view [ M3e.Attributes.class "density-3" ] [ M3e.FormField.label "ds1" (Native.node Html.label [ Native.attribute "for" "ds1" ] [ Kit.text "Density -3" ]), M3e.FormField.control "ds1" (M3e.Select.view [ M3e.Attributes.id "ds1", M3e.Select.panelClass "density-3" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [ M3e.Attributes.class "density-2" ] [ M3e.FormField.label "ds2" (Native.node Html.label [ Native.attribute "for" "ds2" ] [ Kit.text "Density -2" ]), M3e.FormField.control "ds2" (M3e.Select.view [ M3e.Attributes.id "ds2", M3e.Select.panelClass "density-2" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [ M3e.Attributes.class "density-1" ] [ M3e.FormField.label "ds3" (Native.node Html.label [ Native.attribute "for" "ds3" ] [ Kit.text "Density -1" ]), M3e.FormField.control "ds3" (M3e.Select.view [ M3e.Attributes.id "ds3", M3e.Select.panelClass "density-1" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [ M3e.Attributes.class "density-0" ] [ M3e.FormField.label "ds4" (Native.node Html.label [ Native.attribute "for" "ds4" ] [ Kit.text "Density 0" ]), M3e.FormField.control "ds4" (M3e.Select.view [ M3e.Attributes.id "ds4", M3e.Select.panelClass "density-0" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    ]
```

@docs view, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput, arrow
@docs value

-}

import M3e.Html.Select
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-select>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element { option : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | select : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Select.select
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Select.disabled


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
    M3e.Html.Select.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Select.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Select.name


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> Markup.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
panelClass =
    M3e.Html.Select.panelClass


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.Select.required


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Select.onChange


{-| Listen for `toggle` events.
-}
onToggle :
    (String -> msg)
    -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Select.onToggle


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Select.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Select.onInput


{-| Place content in the `arrow` slot.
-}
arrow :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
arrow el =
    Markup.Element.Internal.placeSlot "arrow" el


{-| Place content in the `value` slot.
-}
value : Markup.Element.Element any msg -> Markup.Element.Element k msg
value el =
    Markup.Element.Internal.placeSlot "value" el
