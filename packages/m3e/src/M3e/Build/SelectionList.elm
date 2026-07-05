module M3e.Build.SelectionList exposing
    ( Builder, AttrCaps, SlotCaps, selectionList, hideSelectionIndicator, multi
    , variant, name, disabled, onChange, onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-selection-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SelectionList as SelectionList`.

@docs Builder, AttrCaps, SlotCaps, selectionList, hideSelectionIndicator, multi
@docs variant, name, disabled, onChange, onBeforeinput, onInput
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SelectionList
import M3e.Cem.SelectionList
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-selection-list>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | selectionList : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-selection-list>`. -}
selectionList : Builder AttrCaps SlotCaps msg kind
selectionList =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SelectionList.selectionList
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
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
                  (M3e.Cem.SelectionList.hideSelectionIndicator v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether multiple items can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SelectionList.multi v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SelectionList.variant v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.SelectionList.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SelectionList.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an option changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.onChange v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of an option changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.SelectionList.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an option changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-selection-list>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { selectionList : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)