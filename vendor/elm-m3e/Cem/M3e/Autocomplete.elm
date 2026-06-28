module Cem.M3e.Autocomplete exposing
    ( component
    , autoActivate, caseSensitive, Filter(..), filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for
    , onChange, onQuery, onToggle
    , loadingSlot, noDataSlot
    , filterToString
    )

{-| Enhances a text input with suggested options.


## Component

@docs component


### Attributes

@docs autoActivate, caseSensitive, Filter, filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel, noDataLabel, panelClass, required, for


### Events

@docs onChange, onQuery, onToggle


### Slots

@docs loadingSlot, noDataSlot


### Omitted Attributes

The following attribute setters were omitted because Elm cannot pass DOM element references:

  - `results-label`: string | ((count: number) => string)

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Enhances a text input with suggested options.

**Events:**

  - `change`: Dispatched when the committed value changes due to selecting an option or clearing the input.
  - `query`: Dispatched when the input is focused or when the user modifies its value.
  - `toggle`: Dispatched when the options menu opens or closes.

**Slots:**

  - `loading`: Renders content when loading options.
  - `no-data`: Renders content when there are no options to show.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-autocomplete" attributes children


{-| Whether the first option should be automatically activated. (default: `false`)
-}
autoActivate : Bool -> Html.Attribute msg
autoActivate val_ =
    Html.Attributes.property "autoActivate" (Json.Encode.bool val_)


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "caseSensitive" (Json.Encode.bool val_)


{-| Values for the `filter` attribute.
-}
type Filter
    = Contains
    | EndsWith
    | None
    | StartsWith


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter : Filter -> Html.Attribute msg
filter val_ =
    Html.Attributes.attribute "filter" (filterToString val_)


filterToString : Filter -> String
filterToString val_ =
    case val_ of
        Contains ->
            "contains"

        EndsWith ->
            "ends-with"

        None ->
            "none"

        StartsWith ->
            "starts-with"


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hideSelectionIndicator" (Json.Encode.bool val_)


{-| Whether to hide the menu when loading options. (default: `false`)
-}
hideLoading : Bool -> Html.Attribute msg
hideLoading val_ =
    Html.Attributes.property "hideLoading" (Json.Encode.bool val_)


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
hideNoData : Bool -> Html.Attribute msg
hideNoData val_ =
    Html.Attributes.property "hideNoData" (Json.Encode.bool val_)


{-| Whether options are being loaded. (default: `false`)
-}
loading : Bool -> Html.Attribute msg
loading val_ =
    Html.Attributes.property "loading" (Json.Encode.bool val_)


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
loadingLabel : String -> Html.Attribute msg
loadingLabel val_ =
    Html.Attributes.attribute "loading-label" val_


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
noDataLabel : String -> Html.Attribute msg
noDataLabel val_ =
    Html.Attributes.attribute "no-data-label" val_


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`)
-}
panelClass : String -> Html.Attribute msg
panelClass val_ =
    Html.Attributes.attribute "panel-class" val_


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Dispatched when the committed value changes due to selecting an option or clearing the input.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the input is focused or when the user modifies its value.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery decoder =
    Html.Events.on "query" decoder


{-| Dispatched when the options menu opens or closes.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder


{-| Renders content when loading options.
-}
loadingSlot : Html.Attribute msg
loadingSlot =
    Html.Attributes.attribute "slot" "loading"


{-| Renders content when there are no options to show.
-}
noDataSlot : Html.Attribute msg
noDataSlot =
    Html.Attributes.attribute "slot" "no-data"
