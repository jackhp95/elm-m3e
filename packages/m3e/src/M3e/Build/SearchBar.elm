module M3e.Build.SearchBar exposing
    ( Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
    , onClear, build
    )

{-|
The ⑤ Build shape for `<m3e-search-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchBar as SearchBar`.

@docs Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
@docs onClear, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SearchBar
import M3e.Cem.SearchBar
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-search-bar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | searchBar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { clearable : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { clearIcon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-search-bar>` with the required fields. -}
searchBar :
    { input : M3e.Element.Element any msg }
    -> Builder AttrCaps SlotCaps msg kind
searchBar req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SearchBar.searchBar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode (M3e.Element.withSlot "input" req_.input) ]
        )


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | clearable : M3e.Build.Internal.Used } s msg kind
clearable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SearchBar.clearable v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.SearchBar.clearLabel v_))
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
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.SearchBar.onClear v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-search-bar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { searchBar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)