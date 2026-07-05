module M3e.Build.FilterChip exposing
    ( Builder, AttrCaps, SlotCaps, filterChip, disabled, disabledInteractive
    , selected, value, variant, onBeforeinput, onInput, onChange, onClick
    , build
    )

{-|
The ⑤ Build shape for `<m3e-filter-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FilterChip as FilterChip`.

@docs Builder, AttrCaps, SlotCaps, filterChip, disabled, disabledInteractive
@docs selected, value, variant, onBeforeinput, onInput, onChange
@docs onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FilterChip
import M3e.Cem.Html.FilterChip
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-filter-chip>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | filterChip : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-filter-chip>` with the required fields. -}
filterChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
filterChip req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FilterChip.filterChip
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChip.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChip.disabledInteractive v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChip.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the chip. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChip.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FilterChip.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.FilterChip.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FilterChip.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FilterChip.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FilterChip.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-filter-chip>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { filterChip : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)