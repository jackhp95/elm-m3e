module M3e.Build.TextHighlight exposing
    ( Builder, AttrCaps, SlotCaps, textHighlight, attr, caseSensitive
    , disabled, mode, term, onHighlight, build
    )

{-| The Build form for `<m3e-text-highlight>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextHighlight as TextHighlight`.

@docs Builder, AttrCaps, SlotCaps, textHighlight, attr, caseSensitive
@docs disabled, mode, term, onHighlight, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.TextHighlight
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-text-highlight>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | textHighlight : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { caseSensitive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , onHighlight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-text-highlight>`.
-}
textHighlight : Builder AttrCaps SlotCaps msg kind
textHighlight =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.TextHighlight.textHighlight
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether matching is case sensitive. (default: `false`)
-}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg kind
caseSensitive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.TextHighlight.caseSensitive v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether text highlighting is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TextHighlight.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to highlight text. (default: `"contains"`)
-}
mode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg kind
mode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TextHighlight.mode v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The term to highlight. (default: `""`)
-}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | term : M3e.Build.Internal.Used } s msg kind
term v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TextHighlight.term v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when content is highlighted.
-}
onHighlight :
    msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onHighlight : M3e.Build.Internal.Used } s msg kind
onHighlight v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.TextHighlight.onHighlight v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-text-highlight>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { textHighlight : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
