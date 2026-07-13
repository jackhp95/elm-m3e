module M3e.Build.SearchBar exposing
    ( Builder, AttrCaps, SlotCaps, searchBar, attr, clearable
    , clearLabel, onClear, clearIcon, build
    )

{-| The Build form for `<m3e-search-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchBar as SearchBar`.

@docs Builder, AttrCaps, SlotCaps, searchBar, attr, clearable
@docs clearLabel, onClear, clearIcon, build

-}

import M3e.Build.Internal
import M3e.Html.SearchBar
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-search-bar>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | searchBar : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { clearable : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { clearIcon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-search-bar>` with the required fields.
-}
searchBar :
    { input : Markup.Element.Element any msg }
    -> Builder AttrCaps SlotCaps msg kind
searchBar req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.SearchBar.searchBar
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode
                (Markup.Element.withSlot "input" req_.input)
            ]
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


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | clearable : M3e.Build.Internal.Used } s msg kind
clearable v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SearchBar.clearable v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg kind
clearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SearchBar.clearLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the search term is cleared.
-}
onClear :
    msg
    -> Builder { a | onClear : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClear : M3e.Build.Internal.Used } s msg kind
onClear v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SearchBar.onClear v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `clear-icon` slot.
-}
clearIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | clearIcon : M3e.Build.Internal.Used } msg kind
clearIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "clear-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-search-bar>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { searchBar : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
