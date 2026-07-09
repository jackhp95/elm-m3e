module M3e.Cem.Html.Autocomplete exposing
    ( autocomplete, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
    , hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for
    , onChange, onQuery, onToggle
    )

{-|
Bottom layer for `<m3e-autocomplete>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs autocomplete, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
@docs hideNoData, loading, loadingLabel, noDataLabel, panelClass, required
@docs for, onChange, onQuery, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-autocomplete>` element — a partial application of `Html.node`. -}
autocomplete :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
autocomplete =
    Html.node "m3e-autocomplete"


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate : Bool -> Html.Attribute msg
autoActivate val_ =
    if val_ then
        Html.Attributes.attribute "auto-activate" ""
    
    else
        Html.Attributes.classList []


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    if val_ then
        Html.Attributes.attribute "case-sensitive" ""
    
    else
        Html.Attributes.classList []


{-| Mode in which to filter options. (default: `"contains"`) -}
filter : String -> Html.Attribute msg
filter =
    Html.Attributes.attribute "filter"


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    if val_ then
        Html.Attributes.attribute "hide-selection-indicator" ""
    
    else
        Html.Attributes.classList []


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading : Bool -> Html.Attribute msg
hideLoading val_ =
    if val_ then
        Html.Attributes.attribute "hide-loading" ""
    
    else
        Html.Attributes.classList []


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData : Bool -> Html.Attribute msg
hideNoData val_ =
    if val_ then
        Html.Attributes.attribute "hide-no-data" ""
    
    else
        Html.Attributes.classList []


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> Html.Attribute msg
loading val_ =
    if val_ then
        Html.Attributes.attribute "loading" ""
    
    else
        Html.Attributes.classList []


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel : String -> Html.Attribute msg
loadingLabel =
    Html.Attributes.attribute "loading-label"


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel : String -> Html.Attribute msg
noDataLabel =
    Html.Attributes.attribute "no-data-label"


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`) -}
panelClass : String -> Html.Attribute msg
panelClass =
    Html.Attributes.attribute "panel-class"


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    if val_ then
        Html.Attributes.attribute "required" ""
    
    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `query` events. -}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery =
    Html.Events.on "query"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"