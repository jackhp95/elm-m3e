module M3e.Autocomplete exposing
    ( view, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
    , hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for
    , onChange, onQuery, onToggle, loadingSlot, noData
    )

{-|
Enhances a text input with suggested options.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the committed value changes due to selecting an option or clearing the input.
- `query`: Dispatched when the input is focused or when the user modifies its value.
- `toggle`: Dispatched when the options menu opens or closes.

**Slots:**
- `loading`: Renders content when loading options.
- `no-data`: Renders content when there are no options to show.

<!-- elm-cem:docmeta category=Text inputs -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit" (Native.node Html.label [ Native.attribute "for" "fruit" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit" (Native.node Html.input [ Native.attribute "id" "fruit" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Filter modes" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit5" (Native.node Html.label [ Native.attribute "for" "fruit5" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit5" (Native.node Html.input [ Native.attribute "id" "fruit5" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit5", M3e.Autocomplete.caseSensitive True ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Custom filtering" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit4" (Native.node Html.label [ Native.attribute "for" "fruit4" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit4" (Native.node Html.input [ Native.attribute "id" "fruit4" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit4" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="No data" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit6" (Native.node Html.label [ Native.attribute "for" "fruit6" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit6" (Native.node Html.input [ Native.attribute "id" "fruit6", Native.attribute "value" "Pear" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit6", M3e.Autocomplete.noDataLabel "No data" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Initial load" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "state" (Native.node Html.label [ Native.attribute "for" "state" ] [ Kit.text "State" ]), M3e.FormField.control "state" (Native.node Html.input [ Native.attribute "id" "state" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "state" ] [ M3e.Autocomplete.loadingSlot (M3e.LoadingIndicator.view [] []) ]
    ]
```

<!-- elm-cem:example title="Search as you type" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "state2" (Native.node Html.label [ Native.attribute "for" "state2" ] [ Kit.text "State" ]), M3e.FormField.control "state2" (Native.node Html.input [ Native.attribute "id" "state2" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "state2" ] [ M3e.Autocomplete.loadingSlot (M3e.LoadingIndicator.view [] []) ]
    ]
```

<!-- elm-cem:example title="Requiring an option to be selected" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit2" (Native.node Html.label [ Native.attribute "for" "fruit2" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit2" (Native.node Html.input [ Native.attribute "id" "fruit2", Native.attribute "value" "Apple" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit2", M3e.Autocomplete.required True ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Automatic activation" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit3" (Native.node Html.label [ Native.attribute "for" "fruit3" ] [ Kit.text "Choose your favorite fruit" ]), M3e.FormField.control "fruit3" (Native.node Html.input [ Native.attribute "id" "fruit3" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit3", M3e.Autocomplete.autoActivate True ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Chips" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "fruit7" (Native.node Html.label [ Native.attribute "for" "fruit7" ] [ Kit.text "Choose your favorite fruits" ]), M3e.FormField.control "" (M3e.InputChipSet.view [ M3e.Aria.label "Enter favorite fruits" ] [ M3e.InputChipSet.input (Native.node Html.input [ Native.attribute "id" "fruit7", Native.attribute "placeholder" "Add fruit..." ] []) ]) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit7" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "d1" (Native.node Html.label [ Native.attribute "for" "d1" ] [ Kit.text "Density -3" ]), M3e.FormField.control "d1" (Native.node Html.input [ Native.attribute "id" "d1" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "d1", M3e.Autocomplete.panelClass "density-3" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    , M3e.FormField.view [] [ M3e.FormField.label "d2" (Native.node Html.label [ Native.attribute "for" "d2" ] [ Kit.text "Density -2" ]), M3e.FormField.control "d2" (Native.node Html.input [ Native.attribute "id" "d2" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "d2", M3e.Autocomplete.panelClass "density-2" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    , M3e.FormField.view [] [ M3e.FormField.label "d3" (Native.node Html.label [ Native.attribute "for" "d3" ] [ Kit.text "Density -1" ]), M3e.FormField.control "d3" (Native.node Html.input [ Native.attribute "id" "d3" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "d3", M3e.Autocomplete.panelClass "density-1" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    , M3e.FormField.view [] [ M3e.FormField.label "d4" (Native.node Html.label [ Native.attribute "for" "d4" ] [ Kit.text "Density 0" ]), M3e.FormField.control "d4" (Native.node Html.input [ Native.attribute "id" "d4" ] []) ]
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "d4", M3e.Autocomplete.panelClass "density-0" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]
    ]
```

@docs view, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
@docs hideNoData, loading, loadingLabel, noDataLabel, panelClass, required
@docs for, onChange, onQuery, onToggle, loadingSlot, noData
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Autocomplete
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-autocomplete>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { autoActivate : M3e.Value.Supported
    , caseSensitive : M3e.Value.Supported
    , filter : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , hideLoading : M3e.Value.Supported
    , hideNoData : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , loadingLabel : M3e.Value.Supported
    , noDataLabel : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , for : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onQuery : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | autocomplete : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Autocomplete.autocomplete
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool -> M3e.Cem.Attr.Attr { c | autoActivate : M3e.Value.Supported } msg
autoActivate =
    M3e.Cem.Autocomplete.autoActivate


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.Autocomplete.caseSensitive


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filter =
    M3e.Cem.Autocomplete.filter


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Autocomplete.hideSelectionIndicator


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool -> M3e.Cem.Attr.Attr { c | hideLoading : M3e.Value.Supported } msg
hideLoading =
    M3e.Cem.Autocomplete.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool -> M3e.Cem.Attr.Attr { c | hideNoData : M3e.Value.Supported } msg
hideNoData =
    M3e.Cem.Autocomplete.hideNoData


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> M3e.Cem.Attr.Attr { c | loading : M3e.Value.Supported } msg
loading =
    M3e.Cem.Autocomplete.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String -> M3e.Cem.Attr.Attr { c | loadingLabel : M3e.Value.Supported } msg
loadingLabel =
    M3e.Cem.Autocomplete.loadingLabel


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String -> M3e.Cem.Attr.Attr { c | noDataLabel : M3e.Value.Supported } msg
noDataLabel =
    M3e.Cem.Autocomplete.noDataLabel


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`) -}
panelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
panelClass =
    M3e.Cem.Autocomplete.panelClass


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Autocomplete.required


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Autocomplete.for


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Autocomplete.onChange


{-| Listen for `query` events. -}
onQuery : msg -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery =
    M3e.Cem.Autocomplete.onQuery


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Autocomplete.onToggle


{-| Place content in the `loading` slot. -}
loadingSlot : M3e.Element.Element any msg -> M3e.Element.Element k msg
loadingSlot el =
    M3e.Element.Internal.placeSlot "loading" el


{-| Place content in the `no-data` slot. -}
noData : M3e.Element.Element any msg -> M3e.Element.Element k msg
noData el =
    M3e.Element.Internal.placeSlot "no-data" el