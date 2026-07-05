module M3e.Build.Autocomplete exposing
    ( Builder, AttrCaps, SlotCaps, autocomplete, autoActivate, caseSensitive
    , filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel, noDataLabel
    , panelClass, required, for, onChange, onQuery, onToggle, build
    )

{-|
The ⑤ Build shape for `<m3e-autocomplete>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Autocomplete as Autocomplete`.

@docs Builder, AttrCaps, SlotCaps, autocomplete, autoActivate, caseSensitive
@docs filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel
@docs noDataLabel, panelClass, required, for, onChange, onQuery
@docs onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Autocomplete
import M3e.Cem.Html.Autocomplete
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-autocomplete>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | autocomplete : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { autoActivate : M3e.Build.Internal.Available
    , caseSensitive : M3e.Build.Internal.Available
    , filter : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , hideLoading : M3e.Build.Internal.Available
    , hideNoData : M3e.Build.Internal.Available
    , loading : M3e.Build.Internal.Available
    , loadingLabel : M3e.Build.Internal.Available
    , noDataLabel : M3e.Build.Internal.Available
    , panelClass : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onQuery : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { loading : M3e.Build.Internal.Available
    , noData : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-autocomplete>`. -}
autocomplete : Builder AttrCaps SlotCaps msg kind
autocomplete =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Autocomplete.autocomplete
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool
    -> Builder { a | autoActivate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | autoActivate : M3e.Build.Internal.Used } s msg kind
autoActivate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.autoActivate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg kind
caseSensitive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.caseSensitive v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | filter : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | filter : M3e.Build.Internal.Used } s msg kind
filter v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.filter v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Used
    } s msg kind
hideSelectionIndicator v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Autocomplete.hideSelectionIndicator v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool
    -> Builder { a | hideLoading : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideLoading : M3e.Build.Internal.Used } s msg kind
hideLoading v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.hideLoading v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool
    -> Builder { a | hideNoData : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideNoData : M3e.Build.Internal.Used } s msg kind
hideNoData v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.hideNoData v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether options are being loaded. (default: `false`) -}
loading :
    Bool
    -> Builder { a | loading : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | loading : M3e.Build.Internal.Used } s msg kind
loading v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.loading v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String
    -> Builder { a | loadingLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | loadingLabel : M3e.Build.Internal.Used } s msg kind
loadingLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.loadingLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String
    -> Builder { a | noDataLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | noDataLabel : M3e.Build.Internal.Used } s msg kind
noDataLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.noDataLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`) -}
panelClass :
    String
    -> Builder { a | panelClass : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | panelClass : M3e.Build.Internal.Used } s msg kind
panelClass v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.panelClass v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.required v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Autocomplete.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the committed value changes due to selecting an option or clearing the input. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the input is focused or when the user modifies its value. -}
onQuery :
    Json.Decode.Decoder msg
    -> Builder { a | onQuery : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onQuery : M3e.Build.Internal.Used } s msg kind
onQuery v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.onQuery v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the options menu opens or closes. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Autocomplete.onToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-autocomplete>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { autocomplete : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)