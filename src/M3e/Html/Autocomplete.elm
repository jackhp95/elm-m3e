module M3e.Html.Autocomplete exposing
    ( autocomplete, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
    , hideNoData, loading, loadingLabel, noDataLabel, panelClass, required
    , for, onChange, onQuery, onToggle
    )

{-| Middle layer for `<m3e-autocomplete>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Autocomplete` module for everyday use.

@docs autocomplete, autoActivate, caseSensitive, filter, hideSelectionIndicator, hideLoading
@docs hideNoData, loading, loadingLabel, noDataLabel, panelClass, required
@docs for, onChange, onQuery, onToggle

-}

import Html
import Json.Decode
import M3e.Raw.Autocomplete
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Enhances a text input with suggested options.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the committed value changes due to selecting an option or clearing the input.
  - `query`: Dispatched when the input is focused or when the user modifies its value.
  - `toggle`: Dispatched when the options menu opens or closes.

**Slots:**

  - `loading`: Renders content when loading options.
  - `no-data`: Renders content when there are no options to show.

-}
autocomplete :
    List
        (Markup.Html.Attr.Attr
            { autoActivate : M3e.Token.Supported
            , caseSensitive : M3e.Token.Supported
            , filter : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , hideLoading : M3e.Token.Supported
            , hideNoData : M3e.Token.Supported
            , loading : M3e.Token.Supported
            , loadingLabel : M3e.Token.Supported
            , noDataLabel : M3e.Token.Supported
            , panelClass : M3e.Token.Supported
            , required : M3e.Token.Supported
            , for : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onQuery : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
autocomplete attributes children =
    M3e.Raw.Autocomplete.autocomplete
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the first option should be automatically activated. (default: `false`)
-}
autoActivate : Bool -> Markup.Html.Attr.Attr { c | autoActivate : M3e.Token.Supported } msg
autoActivate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.autoActivate


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive :
    Bool
    -> Markup.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
caseSensitive =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.caseSensitive


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , none : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | filter : M3e.Token.Supported } msg
filter v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Autocomplete.filter
        (M3e.Token.toString v_)


{-| Whether to hide the selection indicator. (default: `false`)
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
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Autocomplete.hideSelectionIndicator


{-| Whether to hide the menu when loading options. (default: `false`)
-}
hideLoading : Bool -> Markup.Html.Attr.Attr { c | hideLoading : M3e.Token.Supported } msg
hideLoading =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.hideLoading


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
hideNoData : Bool -> Markup.Html.Attr.Attr { c | hideNoData : M3e.Token.Supported } msg
hideNoData =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.hideNoData


{-| Whether options are being loaded. (default: `false`)
-}
loading : Bool -> Markup.Html.Attr.Attr { c | loading : M3e.Token.Supported } msg
loading =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.loading


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
loadingLabel :
    String
    -> Markup.Html.Attr.Attr { c | loadingLabel : M3e.Token.Supported } msg
loadingLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.loadingLabel


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
noDataLabel :
    String
    -> Markup.Html.Attr.Attr { c | noDataLabel : M3e.Token.Supported } msg
noDataLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.noDataLabel


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`)
-}
panelClass : String -> Markup.Html.Attr.Attr { c | panelClass : M3e.Token.Supported } msg
panelClass =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.panelClass


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.required


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Autocomplete.for


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Autocomplete.onChange
        (Json.Decode.succeed f_)


{-| Listen for `query` events.
-}
onQuery : msg -> Markup.Html.Attr.Attr { c | onQuery : M3e.Token.Supported } msg
onQuery f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Autocomplete.onQuery
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Autocomplete.onToggle
        (Json.Decode.succeed f_)
