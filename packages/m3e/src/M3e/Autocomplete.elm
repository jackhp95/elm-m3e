module M3e.Autocomplete exposing
    ( view, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
    , hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for
    , onChange, onQuery, onToggle, child, loadingSlot, noData, children
    )

{-|
Enhances a text input with suggested options.

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

<!-- elm-cem:example title="Favorite fruit autocomplete with auto-activation" -->
```elm
[ Native.node Html.label [] [ Kit.text "Choose your favorite fruit" ]
    , Native.node Html.input [] []
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "fruit", M3e.Autocomplete.autoActivate True, M3e.Autocomplete.required True ] (M3e.Autocomplete.children [ M3e.Option.view { content = Kit.text "Apples" } [] [], M3e.Option.view { content = Kit.text "Oranges" } [] [], M3e.Option.view { content = Kit.text "Bananas" } [] [], M3e.Option.view { content = Kit.text "Grapes" } [] [] ])
    ]
```

<!-- elm-cem:example title="Starts-with country search with no-data message" -->
```elm
[ Native.node Html.label [] [ Kit.text "Country" ]
    , Native.node Html.input [] []
    , M3e.Autocomplete.view [ M3e.Autocomplete.for "country", M3e.Autocomplete.noDataLabel "No matching countries" ] ([ M3e.Autocomplete.noData (Native.span [] [ Kit.text "Try a different spelling" ]) ] ++ M3e.Autocomplete.children [ M3e.Option.view { content = Kit.text "Australia" } [] [], M3e.Option.view { content = Kit.text "Brazil" } [] [], M3e.Option.view { content = Kit.text "Canada" } [] [], M3e.Option.view { content = Kit.text "Denmark" } [] [] ])
    ]
```

@docs view, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
@docs hideNoData, loading, loadingLabel, noDataLabel, panelClass, required
@docs for, onChange, onQuery, onToggle, child, loadingSlot
@docs noData, children
-}


import M3e.Cem.Attr
import M3e.Cem.Autocomplete
import M3e.Content
import M3e.Element
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | autocomplete : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Autocomplete.autocomplete
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
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


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `loading` slot. -}
loadingSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | loading : M3e.Value.Supported } msg
loadingSlot el =
    M3e.Content.slot "loading" el


{-| Place content in the `no-data` slot. -}
noData :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | noData : M3e.Value.Supported } msg
noData el =
    M3e.Content.slot "no-data" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els