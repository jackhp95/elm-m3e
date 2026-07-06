module M3e.Build.AssistChip exposing
    ( Builder, AttrCaps, SlotCaps, assistChip, attr, disabled
    , disabledInteractive, download, href, name, rel, target, type_
    , value, variant, onClick, icon, build
    )

{-|
The ⑤ Build shape for `<m3e-assist-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AssistChip as AssistChip`.

@docs Builder, AttrCaps, SlotCaps, assistChip, attr, disabled
@docs disabledInteractive, download, href, name, rel, target
@docs type_, value, variant, onClick, icon, build
-}


import M3e.Build.Internal
import M3e.Cem.AssistChip
import M3e.Cem.Attr.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-assist-chip>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | assistChip : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-assist-chip>` with the required fields. -}
assistChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
assistChip req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.AssistChip.assistChip
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             [ M3e.Element.toNode req_.content ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.AssistChip.disabledInteractive v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.download v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.href v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.rel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The target of the link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.target v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.type_ v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the chip. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.AssistChip.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-assist-chip>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { assistChip : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)