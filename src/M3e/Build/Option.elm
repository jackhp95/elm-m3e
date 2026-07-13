module M3e.Build.Option exposing
    ( Builder, AttrCaps, SlotCaps, option, attr, disabled
    , disableHighlight, highlightMode, selected, term, value, build
    )

{-| The Build form for `<m3e-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Option as Option`.

@docs Builder, AttrCaps, SlotCaps, option, attr, disabled
@docs disableHighlight, highlightMode, selected, term, value, build

-}

import M3e.Build.Internal
import M3e.Html.Option
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-option>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | option : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disableHighlight : M3e.Build.Internal.Available
    , highlightMode : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-option>` with the required fields.
-}
option :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
option req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Option.option
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode req_.content ]
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
            (Markup.Html.Attr.Internal.forget (M3e.Html.Option.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight :
    Bool
    ->
        Builder
            { a
                | disableHighlight : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disableHighlight : M3e.Build.Internal.Used } s msg kind
disableHighlight v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Option.disableHighlight v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> Builder { a | highlightMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | highlightMode : M3e.Build.Internal.Used } s msg kind
highlightMode v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Option.highlightMode v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`)
-}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Option.selected v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The search term to highlight. (default: `""`)
-}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | term : M3e.Build.Internal.Used } s msg kind
term v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Option.term v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the option.
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Option.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-option>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { option : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
