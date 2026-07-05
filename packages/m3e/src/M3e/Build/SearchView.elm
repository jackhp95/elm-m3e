module M3e.Build.SearchView exposing
    ( Builder, AttrCaps, SlotCaps, searchView, contained, mode
    , open, clearLabel, closeLabel, hideSearchIcon, onQuery, onClear, onBeforetoggle
    , onToggle, build
    )

{-|
The ⑤ Build shape for `<m3e-search-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchView as SearchView`.

@docs Builder, AttrCaps, SlotCaps, searchView, contained, mode
@docs open, clearLabel, closeLabel, hideSearchIcon, onQuery, onClear
@docs onBeforetoggle, onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.SearchView
import M3e.Cem.SearchView
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-search-view>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | searchView : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { contained : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , hideSearchIcon : M3e.Build.Internal.Available
    , onQuery : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { searchIcon : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    , clearIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-search-view>` with the required fields. -}
searchView :
    { input : M3e.Element.Element any msg }
    -> Builder AttrCaps SlotCaps msg kind
searchView req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SearchView.searchView
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             [ M3e.Element.toNode (M3e.Element.withSlot "input" req_.input) ]
        )


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool
    -> Builder { a | contained : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | contained : M3e.Build.Internal.Used } s msg kind
contained v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SearchView.contained v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The behavior mode of the view. (default: `"docked"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , fullscreen : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg kind
mode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SearchView.mode v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the view is expanded to show results. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SearchView.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg kind
clearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SearchView.clearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg kind
closeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.SearchView.closeLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool
    -> Builder { a | hideSearchIcon : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideSearchIcon : M3e.Build.Internal.Used } s msg kind
hideSearchIcon v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.SearchView.hideSearchIcon v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the view is opened or when the user modifies the search term. -}
onQuery :
    Json.Decode.Decoder msg
    -> Builder { a | onQuery : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onQuery : M3e.Build.Internal.Used } s msg kind
onQuery v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.SearchView.onQuery
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the search term is cleared. -}
onClear :
    Json.Decode.Decoder msg
    -> Builder { a | onClear : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClear : M3e.Build.Internal.Used } s msg kind
onClear v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.SearchView.onClear
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.SearchView.onBeforetoggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.SearchView.onToggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-search-view>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { searchView : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)