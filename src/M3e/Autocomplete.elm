module M3e.Autocomplete exposing
    ( view
    , option
    , Option, OptionOption, Filter(..)
    , options, loadingContent, noDataContent
    , autoActivate, caseSensitive, filter
    , hideSelectionIndicator, hideLoading, hideNoData
    , loading, loadingLabel, noDataLabel, panelClass, required
    , onChange, onQuery, onToggle
    , optionDisabled
    )

{-| Material 3 Expressive autocomplete — a text-input combobox with a
filtered suggestion menu.

Spec (per docs/CONVENTIONS.md):

  - `view` → `<m3e-autocomplete>` — the controller element. Attaches to an
    existing `<input>` via the `for` attribute; does **not** render the input
    itself. Pass the input's `id` as the required `for` field.
  - `option` → `<m3e-option>` — a suggestion in the panel. Supply a list via
    the `options` option.
  - Slots: default (options), `loading`, `no-data` — supply slotted content via
    `loadingContent` / `noDataContent`.
  - Properties: `autoActivate`, `caseSensitive`, `hideSelectionIndicator`,
    `hideLoading`, `hideNoData`, `loading`, `required` (all bool, emitted
    unconditionally so they reset).
  - Attributes: `filter`, `loading-label`, `no-data-label`, `panel-class`, `for`.
  - Events (`M3eAutocompleteElement`):
      - `change` → `onChange`: committed value changed (option selected or input
        cleared). Decodes `event.target.value` as `Maybe String` (the element's
        `value` property is `string | null`).
      - `query` → `onQuery`: fires when the attached input is focused or when the
        user modifies its value. The `CustomEvent` detail is the current search
        string; decoded from `event.detail` as `String` (empty string on bare
        focus with no input yet).
      - `toggle` → `onToggle`: panel open/close. Decoded from `event.newState`
        as `Bool` (`True` = panel opened), same as `M3e.Select.onToggle`.
  - Tag: `autocomplete`

Note: `results-label` accepts a JS function `(count: number) => string` and
cannot be set from Elm — it is omitted.


## Container

@docs view


## Option item

@docs option


## Types

@docs Option, OptionOption, Filter


## Slotted content

@docs options, loadingContent, noDataContent


## Filter mode

@docs autoActivate, caseSensitive, filter


## Visibility toggles

@docs hideSelectionIndicator, hideLoading, hideNoData


## Loading state

@docs loading, loadingLabel, noDataLabel, panelClass, required


## Events

@docs onChange, onQuery, onToggle


## Option item options

@docs optionDisabled

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES -----------------------------------------------------------------------


{-| Option for the `<m3e-autocomplete>` container.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Option for an individual `<m3e-option>` suggestion item.
-}
type alias OptionOption msg =
    Internal.Option OptionItemConfig msg


{-| Filtering strategy applied to the option list as the user types.

  - `Contains` — option label contains the search term (default).
  - `StartsWith` — option label begins with the search term.
  - `EndsWith` — option label ends with the search term.
  - `None` — no client-side filtering; the host application is responsible
    for supplying the correct options.

-}
type Filter
    = Contains
    | StartsWith
    | EndsWith
    | None


type alias Config msg =
    { autoActivate : Bool
    , caseSensitive : Bool
    , filterMode : Filter
    , hideSelectionIndicator : Bool
    , hideLoading : Bool
    , hideNoData : Bool
    , loading : Bool
    , loadingLabel : Maybe String
    , noDataLabel : Maybe String
    , panelClass : Maybe String
    , required : Bool
    , onChange : Maybe (Maybe String -> msg)
    , onQuery : Maybe (String -> msg)
    , onToggle : Maybe (Bool -> msg)
    , options : List (Element { autocompleteOption : Supported } msg)
    , loadingContent : Maybe (Element { element : Supported } msg)
    , noDataContent : Maybe (Element { element : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { autoActivate = False
    , caseSensitive = False
    , filterMode = Contains
    , hideSelectionIndicator = False
    , hideLoading = False
    , hideNoData = False
    , loading = False
    , loadingLabel = Nothing
    , noDataLabel = Nothing
    , panelClass = Nothing
    , required = False
    , onChange = Nothing
    , onQuery = Nothing
    , onToggle = Nothing
    , options = []
    , loadingContent = Nothing
    , noDataContent = Nothing
    }


type alias OptionItemConfig =
    { disabled : Bool }



-- SLOTTED CONTENT ------------------------------------------------------------


{-| Supply the list of `<m3e-option>` suggestions rendered inside the panel.

    M3e.Autocomplete.options
        [ M3e.Autocomplete.option { value = "apple", label = "Apple" } []
        , M3e.Autocomplete.option { value = "banana", label = "Banana" } []
        ]

-}
options : List (Element { autocompleteOption : Supported } msg) -> Option msg
options os =
    Internal.option (\c -> { c | options = os })


{-| Slot custom content shown while `loading = True` (fills the `loading` slot).

Overrides the `loadingLabel` text in the built-in loading indicator.

-}
loadingContent : Element { element : Supported } msg -> Option msg
loadingContent el =
    Internal.option (\c -> { c | loadingContent = Just el })


{-| Slot custom content shown when there are no matching options (fills the
`no-data` slot).

Overrides the `noDataLabel` text in the built-in no-data indicator.

-}
noDataContent : Element { element : Supported } msg -> Option msg
noDataContent el =
    Internal.option (\c -> { c | noDataContent = Just el })



-- FILTER OPTIONS -------------------------------------------------------------


{-| Automatically activate (pre-select) the first matching option as the user
types.

Sets the `autoActivate` DOM property. Default `False`. Emitted unconditionally.

-}
autoActivate : Bool -> Option msg
autoActivate b =
    Internal.option (\c -> { c | autoActivate = b })


{-| Make the client-side filter case-sensitive.

Sets the `caseSensitive` DOM property. Default `False` (case-insensitive).
Emitted unconditionally.

-}
caseSensitive : Bool -> Option msg
caseSensitive b =
    Internal.option (\c -> { c | caseSensitive = b })


{-| Set the client-side filter strategy.

Sets the `filter` attribute on `<m3e-autocomplete>`. Default `Contains`.

Use `None` when the host application performs server-side or custom filtering
and supplies its own option list on each `onQuery` event.

-}
filter : Filter -> Option msg
filter f =
    Internal.option (\c -> { c | filterMode = f })



-- VISIBILITY TOGGLES ---------------------------------------------------------


{-| Hide the built-in selection indicator (checkmark) next to selected options.

Sets the `hideSelectionIndicator` DOM property. Default `False`. Emitted
unconditionally.

-}
hideSelectionIndicator : Bool -> Option msg
hideSelectionIndicator b =
    Internal.option (\c -> { c | hideSelectionIndicator = b })


{-| Hide the panel while `loading = True` instead of showing the loading slot.

Sets the `hideLoading` DOM property. Default `False`. Emitted unconditionally.

-}
hideLoading : Bool -> Option msg
hideLoading b =
    Internal.option (\c -> { c | hideLoading = b })


{-| Hide the panel when no options match instead of showing the no-data slot.

Sets the `hideNoData` DOM property. Default `False`. Emitted unconditionally.

-}
hideNoData : Bool -> Option msg
hideNoData b =
    Internal.option (\c -> { c | hideNoData = b })



-- STATE & LABELS -------------------------------------------------------------


{-| Signal that options are being fetched asynchronously.

Sets the `loading` DOM property. While `True`, the panel shows a loading
indicator (or nothing if `hideLoading = True`). Default `False`. Emitted
unconditionally.

-}
loading : Bool -> Option msg
loading b =
    Internal.option (\c -> { c | loading = b })


{-| Text shown (and announced to screen readers) while `loading = True`.

Sets the `loading-label` attribute. Default `"Loading..."`.

-}
loadingLabel : String -> Option msg
loadingLabel s =
    Internal.option (\c -> { c | loadingLabel = Just s })


{-| Text shown (and announced to screen readers) when no options are available.

Sets the `no-data-label` attribute. Default `"No options"`.

-}
noDataLabel : String -> Option msg
noDataLabel s =
    Internal.option (\c -> { c | noDataLabel = Just s })


{-| CSS class (or space-separated list of classes) applied to the overlay panel.

Sets the `panel-class` attribute.

-}
panelClass : String -> Option msg
panelClass s =
    Internal.option (\c -> { c | panelClass = Just s })


{-| Require the user to select an option before the form can be submitted.

Sets the `required` DOM property. Default `False`. Emitted unconditionally.

-}
required : Bool -> Option msg
required b =
    Internal.option (\c -> { c | required = b })



-- EVENTS ---------------------------------------------------------------------


{-| Handle committed value changes.

The `change` event fires on `<m3e-autocomplete>` when the user selects an
option from the panel or clears the input. The handler receives the current
value decoded from `event.target.value` as `Maybe String` — `Nothing` when the
input is cleared and no option is selected.

-}
onChange : (Maybe String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Handle query changes.

The `query` CustomEvent fires when the attached `<input>` receives focus, or
when the user types in it. The handler receives the current search string
decoded from `event.detail`. An empty string is delivered on bare focus (no
text typed yet).

-}
onQuery : (String -> msg) -> Option msg
onQuery f =
    Internal.option (\c -> { c | onQuery = Just f })


{-| Handle the suggestion panel opening and closing.

The `toggle` ToggleEvent fires when the panel opens or closes. The handler
receives `True` when the panel opens and `False` when it closes, decoded from
`event.newState`.

-}
onToggle : (Bool -> msg) -> Option msg
onToggle f =
    Internal.option (\c -> { c | onToggle = Just f })



-- OPTION ITEM OPTIONS --------------------------------------------------------


{-| Disable an individual `<m3e-option>` suggestion.

Disabled options are displayed but cannot be selected.

-}
optionDisabled : Bool -> OptionOption msg
optionDisabled b =
    Internal.option (\c -> { c | disabled = b })



-- OPTION ITEM CONSTRUCTOR ----------------------------------------------------


{-| Construct an `<m3e-option>` suggestion item.

The `value` field is set as the `value` attribute on the element, which is
what `event.target.value` on `onChange` returns when this option is selected.
The `label` field is the human-readable text displayed in the panel.

    M3e.Autocomplete.option { value = "au", label = "Australia" } []

    M3e.Autocomplete.option { value = "us", label = "United States" }
        [ M3e.Autocomplete.optionDisabled True ]

-}
option :
    { value : String, label : String }
    -> List (OptionOption msg)
    -> Element { s | autocompleteOption : Supported } msg
option req opts =
    let
        oc : OptionItemConfig
        oc =
            Internal.applyOptions opts { disabled = False }
    in
    Internal.fromNode
        (Node.element "m3e-option"
            [ Node.attribute "value" req.value
            , Node.property "disabled" (Encode.bool oc.disabled)
            ]
            [ Node.text req.label ]
        )



-- CONTAINER ------------------------------------------------------------------


{-| Render an `<m3e-autocomplete>` element attached to an existing `<input>`.

`for` must match the `id` of the `<input>` element this autocomplete should
enhance. The `<input>` and `<label>` are rendered separately by the host page
— `M3e.Autocomplete.view` only renders the `<m3e-autocomplete>` controller.

    label [ for "country" ] [ text "Country" ]

    input [ id "country", placeholder "Start typing…" ] []

    Element.toHtml
        (M3e.Autocomplete.view { for = "country" }
            [ M3e.Autocomplete.options
                [ M3e.Autocomplete.option { value = "au", label = "Australia" } []
                , M3e.Autocomplete.option { value = "ca", label = "Canada" } []
                ]
            , M3e.Autocomplete.filter M3e.Autocomplete.StartsWith
            , M3e.Autocomplete.onChange CountrySelected
            , M3e.Autocomplete.onQuery QueryChanged
            ]
        )

-}
view :
    { for : String }
    -> List (Option msg)
    -> Element { s | autocomplete : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig

        slottedChildren : List (Node msg)
        slottedChildren =
            List.filterMap identity
                [ Maybe.map
                    (\el -> Node.withSlot "loading" (Element.toNode el))
                    c.loadingContent
                , Maybe.map
                    (\el -> Node.withSlot "no-data" (Element.toNode el))
                    c.noDataContent
                ]
                ++ List.map Element.toNode c.options
    in
    Internal.fromNode
        (Node.element "m3e-autocomplete"
            (List.filterMap identity
                [ Just (Node.attribute "for" req.for)
                , Just (Node.property "autoActivate" (Encode.bool c.autoActivate))
                , Just (Node.property "caseSensitive" (Encode.bool c.caseSensitive))
                , Just (Node.attribute "filter" (filterToString c.filterMode))
                , Just (Node.property "hideSelectionIndicator" (Encode.bool c.hideSelectionIndicator))
                , Just (Node.property "hideLoading" (Encode.bool c.hideLoading))
                , Just (Node.property "hideNoData" (Encode.bool c.hideNoData))
                , Just (Node.property "loading" (Encode.bool c.loading))
                , Just (Node.property "required" (Encode.bool c.required))
                , Maybe.map (Node.attribute "loading-label") c.loadingLabel
                , Maybe.map (Node.attribute "no-data-label") c.noDataLabel
                , Maybe.map (Node.attribute "panel-class") c.panelClass
                , Maybe.map
                    (\f ->
                        Node.on "change"
                            (Decode.at [ "target", "value" ] (Decode.nullable Decode.string)
                                |> Decode.map f
                            )
                    )
                    c.onChange
                , Maybe.map
                    (\f ->
                        Node.on "query"
                            (Decode.oneOf
                                [ Decode.at [ "detail" ] Decode.string
                                , Decode.succeed ""
                                ]
                                |> Decode.map f
                            )
                    )
                    c.onQuery
                , Maybe.map
                    (\f ->
                        Node.on "toggle"
                            (Decode.at [ "newState" ] Decode.string
                                |> Decode.map (\s -> f (s == "open"))
                            )
                    )
                    c.onToggle
                ]
            )
            slottedChildren
        )



-- INTERNAL -------------------------------------------------------------------


filterToString : Filter -> String
filterToString f =
    case f of
        Contains ->
            "contains"

        StartsWith ->
            "starts-with"

        EndsWith ->
            "ends-with"

        None ->
            "none"
