module M3e.Build.FilterChipSet exposing
    ( Builder, AttrCaps, SlotCaps, filterChipSet, disabled, hideSelectionIndicator
    , multi, name, vertical, onChange, onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-filter-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FilterChipSet as FilterChipSet`.

@docs Builder, AttrCaps, SlotCaps, filterChipSet, disabled, hideSelectionIndicator
@docs multi, name, vertical, onChange, onBeforeinput, onInput
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FilterChipSet
import M3e.Cem.Html.FilterChipSet
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-filter-chip-set>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | filterChipSet : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
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


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-filter-chip-set>`. -}
filterChipSet : Builder AttrCaps SlotCaps msg kind
filterChipSet =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FilterChipSet.filterChipSet
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChipSet.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { hideSelectionIndicator : M3e.Build.Internal.Used } s msg kind
hideSelectionIndicator v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.FilterChipSet.hideSelectionIndicator v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple chips can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChipSet.multi v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChipSet.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChipSet.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a chip changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FilterChipSet.onChange v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a chip changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.FilterChipSet.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a chip changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FilterChipSet.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-filter-chip-set>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { filterChipSet : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)