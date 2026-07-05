module M3e.Build.Tab exposing
    ( Builder, AttrCaps, SlotCaps, tab, disabled, for
    , selected, onBeforeinput, onInput, onChange, onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-tab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tab as Tab`.

@docs Builder, AttrCaps, SlotCaps, tab, disabled, for
@docs selected, onBeforeinput, onInput, onChange, onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Tab
import M3e.Cem.Tab
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tab>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tab : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-tab>`. -}
tab : Builder AttrCaps SlotCaps msg kind
tab =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tab.tab
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Tab.disabled v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Tab.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Tab.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Tab.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Tab.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Tab.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Tab.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tab>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tab : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)