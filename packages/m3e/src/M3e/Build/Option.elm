module M3e.Build.Option exposing
    ( Builder, AttrCaps, SlotCaps, option, disabled, disableHighlight
    , highlightMode, selected, term, value, build
    )

{-|
The ⑤ Build shape for `<m3e-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Option as Option`.

@docs Builder, AttrCaps, SlotCaps, option, disabled, disableHighlight
@docs highlightMode, selected, term, value, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Option
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-option>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | option : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disableHighlight : M3e.Build.Internal.Available
    , highlightMode : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-option>` with the required fields. -}
option :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
option req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Option.option
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Option.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool
    -> Builder { a
        | disableHighlight : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disableHighlight : M3e.Build.Internal.Used } s msg kind
disableHighlight v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Option.disableHighlight v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | highlightMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | highlightMode : M3e.Build.Internal.Used } s msg kind
highlightMode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Option.highlightMode v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.Option.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The search term to highlight. (default: `""`) -}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | term : M3e.Build.Internal.Used } s msg kind
term v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Option.term v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the option. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Option.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-option>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { option : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)