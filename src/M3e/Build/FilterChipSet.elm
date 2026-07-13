module M3e.Build.FilterChipSet exposing
    ( Builder, AttrCaps, SlotCaps, filterChipSet, attr, disabled
    , hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput
    , onInput, build
    )

{-| The Build form for `<m3e-filter-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FilterChipSet as FilterChipSet`.

@docs Builder, AttrCaps, SlotCaps, filterChipSet, attr, disabled
@docs hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput
@docs onInput, build

-}

import M3e.Build.Internal
import M3e.Html.FilterChipSet
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-filter-chip-set>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | filterChipSet : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-filter-chip-set>`.
-}
filterChipSet : Builder AttrCaps SlotCaps msg kind
filterChipSet =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.FilterChipSet.filterChipSet
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FilterChipSet.disabled v_)
            )
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
                (M3e.Html.FilterChipSet.hideSelectionIndicator v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple chips can be selected. (default: `false`)
-}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FilterChipSet.multi v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.FilterChipSet.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FilterChipSet.vertical v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a chip changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FilterChipSet.onChange v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a chip changes.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FilterChipSet.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a chip changes.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.FilterChipSet.onInput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-filter-chip-set>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { filterChipSet : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
