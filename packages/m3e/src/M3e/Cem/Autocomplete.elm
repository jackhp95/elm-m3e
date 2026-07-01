module M3e.Cem.Autocomplete exposing (autoActivate, autocomplete, caseSensitive, filter, for, hideLoading, hideNoData, hideSelectionIndicator, loading, loadingLabel, noDataLabel, onChange, onQuery, onToggle, panelClass, required)

{-| 
@docs autocomplete, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for, onChange, onQuery, onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Autocomplete
import M3e.Value


{-| Enhances a text input with suggested options.

**Events:**
- `change`: Dispatched when the committed value changes due to selecting an option or clearing the input.
- `query`: Dispatched when the input is focused or when the user modifies its value.
- `toggle`: Dispatched when the options menu opens or closes.

**Slots:**
- `loading`: Renders content when loading options.
- `no-data`: Renders content when there are no options to show.
-}
autocomplete :
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
    -> List (Html.Html msg)
    -> Html.Html msg
autocomplete attributes children =
    M3e.Cem.Html.Autocomplete.autocomplete
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool -> M3e.Cem.Attr.Attr { c | autoActivate : M3e.Value.Supported } msg
autoActivate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.autoActivate


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.caseSensitive


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | filter : M3e.Value.Supported } msg
filter v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Autocomplete.filter
        (M3e.Value.toString v_)


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.hideSelectionIndicator


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool -> M3e.Cem.Attr.Attr { c | hideLoading : M3e.Value.Supported } msg
hideLoading =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool -> M3e.Cem.Attr.Attr { c | hideNoData : M3e.Value.Supported } msg
hideNoData =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.hideNoData


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> M3e.Cem.Attr.Attr { c | loading : M3e.Value.Supported } msg
loading =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String -> M3e.Cem.Attr.Attr { c | loadingLabel : M3e.Value.Supported } msg
loadingLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.loadingLabel


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String -> M3e.Cem.Attr.Attr { c | noDataLabel : M3e.Value.Supported } msg
noDataLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.noDataLabel


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`) -}
panelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
panelClass =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.panelClass


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.required


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.for


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Autocomplete.onChange
        (Json.Decode.succeed f_)


{-| Listen for `query` events. -}
onQuery : msg -> M3e.Cem.Attr.Attr { c | onQuery : M3e.Value.Supported } msg
onQuery f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Autocomplete.onQuery
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Autocomplete.onToggle
        (Json.Decode.succeed f_)