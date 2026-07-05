module M3e.Build.TextHighlight exposing
    ( Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
    , mode, term, onHighlight, build
    )

{-|
The ⑤ Build shape for `<m3e-text-highlight>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextHighlight as TextHighlight`.

@docs Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
@docs mode, term, onHighlight, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.TextHighlight
import M3e.Cem.TextHighlight
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-text-highlight>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | textHighlight : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { caseSensitive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , onHighlight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-text-highlight>`. -}
textHighlight : Builder AttrCaps SlotCaps msg kind
textHighlight =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.TextHighlight.textHighlight
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg kind
    -> Builder { caseSensitive : M3e.Build.Internal.Used } s msg kind
caseSensitive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TextHighlight.caseSensitive v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TextHighlight.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg kind
    -> Builder { mode : M3e.Build.Internal.Used } s msg kind
mode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TextHighlight.mode v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The term to highlight. (default: `""`) -}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg kind
    -> Builder { term : M3e.Build.Internal.Used } s msg kind
term v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.TextHighlight.term v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when content is highlighted. -}
onHighlight :
    Json.Decode.Decoder msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Available } s msg kind
    -> Builder { onHighlight : M3e.Build.Internal.Used } s msg kind
onHighlight v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.TextHighlight.onHighlight
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-text-highlight>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { textHighlight : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)