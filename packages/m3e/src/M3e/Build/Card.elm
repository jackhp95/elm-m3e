module M3e.Build.Card exposing
    ( Builder, AttrCaps, SlotCaps, card, attr, actionable
    , inline, orientation, variant, href, target, rel, download
    , name, value, type_, disabledInteractive, disabled, onClick, child
    , header, content, actions, footer, build
    )

{-|
The ⑤ Build shape for `<m3e-card>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Card as Card`.

@docs Builder, AttrCaps, SlotCaps, card, attr, actionable
@docs inline, orientation, variant, href, target, rel
@docs download, name, value, type_, disabledInteractive, disabled
@docs onClick, child, header, content, actions, footer
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Card
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-card>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | card : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { actionable : M3e.Build.Internal.Available
    , inline : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , header : M3e.Build.Internal.Available
    , content : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , footer : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-card>`. -}
card : Builder AttrCaps SlotCaps msg kind
card =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Card.card
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
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


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool
    -> Builder { a | actionable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | actionable : M3e.Build.Internal.Used } s msg kind
actionable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.actionable v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline :
    Bool
    -> Builder { a | inline : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | inline : M3e.Build.Internal.Used } s msg kind
inline v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.inline v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The orientation of the card. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg kind
orientation v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.orientation v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the card. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.variant v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.href v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.target v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.rel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.download v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The value associated with the element's name when it's submitted with form data. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.value v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.type_ v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.disabledInteractive v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.disabled v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Card.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | header : M3e.Build.Internal.Used } msg kind
header el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "header" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `content` slot. -}
content :
    M3e.Element.Element any msg
    -> Builder a { s | content : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | content : M3e.Build.Internal.Used } msg kind
content el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "content" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg kind
actions el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "actions" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `footer` slot. -}
footer :
    M3e.Element.Element any msg
    -> Builder a { s | footer : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | footer : M3e.Build.Internal.Used } msg kind
footer el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "footer" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-card>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { card : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)