module M3e.Build.Autocomplete exposing
    ( Builder, AttrCaps, SlotCaps, autocomplete, attr, autoActivate
    , caseSensitive, filter, hideSelectionIndicator, hideLoading, hideNoData, loading
    , loadingLabel, noDataLabel, panelClass, required, for, onChange
    , onQuery, onToggle, loadingSlot, noData, build
    )

{-| The Build form for `<m3e-autocomplete>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Autocomplete as Autocomplete`.

@docs Builder, AttrCaps, SlotCaps, autocomplete, attr, autoActivate
@docs caseSensitive, filter, hideSelectionIndicator, hideLoading, hideNoData, loading
@docs loadingLabel, noDataLabel, panelClass, required, for, onChange
@docs onQuery, onToggle, loadingSlot, noData, build

-}

import M3e.Build.Internal
import M3e.Html.Autocomplete
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-autocomplete>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | autocomplete : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
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


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { loading : M3e.Build.Internal.Available
    , noData : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-autocomplete>`.
-}
autocomplete : Builder AttrCaps SlotCaps msg kind
autocomplete =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Autocomplete.autocomplete
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the first option should be automatically activated. (default: `false`)
-}
autoActivate :
    Bool
    -> Builder { a | autoActivate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | autoActivate : M3e.Build.Internal.Used } s msg kind
autoActivate v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.autoActivate v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg kind
caseSensitive v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.caseSensitive v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Mode in which to filter options. (default: `"contains"`)
-}
filter :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , none : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Builder { a | filter : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | filter : M3e.Build.Internal.Used } s msg kind
filter v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Autocomplete.filter v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Builder
            { a
                | hideSelectionIndicator : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    ->
        Builder
            { a
                | hideSelectionIndicator : M3e.Build.Internal.Used
            }
            s
            msg
            kind
hideSelectionIndicator v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.hideSelectionIndicator v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the menu when loading options. (default: `false`)
-}
hideLoading :
    Bool
    -> Builder { a | hideLoading : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideLoading : M3e.Build.Internal.Used } s msg kind
hideLoading v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.hideLoading v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the menu when there are no options to show. (default: `false`)
-}
hideNoData :
    Bool
    -> Builder { a | hideNoData : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideNoData : M3e.Build.Internal.Used } s msg kind
hideNoData v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.hideNoData v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether options are being loaded. (default: `false`)
-}
loading :
    Bool
    -> Builder { a | loading : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | loading : M3e.Build.Internal.Used } s msg kind
loading v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.loading v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The text announced and presented when loading options. (default: `"Loading..."`)
-}
loadingLabel :
    String
    -> Builder { a | loadingLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | loadingLabel : M3e.Build.Internal.Used } s msg kind
loadingLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.loadingLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`)
-}
noDataLabel :
    String
    -> Builder { a | noDataLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | noDataLabel : M3e.Build.Internal.Used } s msg kind
noDataLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.noDataLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`)
-}
panelClass :
    String
    -> Builder { a | panelClass : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | panelClass : M3e.Build.Internal.Used } s msg kind
panelClass v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.panelClass v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`)
-}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.required v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Autocomplete.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the committed value changes due to selecting an option or clearing the input.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.onChange v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the input is focused or when the user modifies its value.
-}
onQuery :
    msg
    -> Builder { a | onQuery : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onQuery : M3e.Build.Internal.Used } s msg kind
onQuery v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.onQuery v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the options menu opens or closes.
-}
onToggle :
    msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Autocomplete.onToggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `loading` slot.
-}
loadingSlot :
    Markup.Element.Element any msg
    -> Builder a { s | loading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | loading : M3e.Build.Internal.Used } msg kind
loadingSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "loading" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `no-data` slot.
-}
noData :
    Markup.Element.Element any msg
    -> Builder a { s | noData : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | noData : M3e.Build.Internal.Used } msg kind
noData el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "no-data" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-autocomplete>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { autocomplete : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
