module M3e.Build.TextareaAutosize exposing
    ( Builder, AttrCaps, SlotCaps, textareaAutosize, attr, disabled
    , for, maxRows, minRows, build
    )

{-| The Build form for `<m3e-textarea-autosize>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextareaAutosize as TextareaAutosize`.

@docs Builder, AttrCaps, SlotCaps, textareaAutosize, attr, disabled
@docs for, maxRows, minRows, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.TextareaAutosize
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-textarea-autosize>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | textareaAutosize : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , maxRows : M3e.Build.Internal.Available
    , minRows : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-textarea-autosize>`.
-}
textareaAutosize : Builder AttrCaps SlotCaps msg kind
textareaAutosize =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.TextareaAutosize.textareaAutosize
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


{-| Whether auto-sizing is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.TextareaAutosize.disabled v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.TextareaAutosize.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows :
    Float
    -> Builder { a | maxRows : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxRows : M3e.Build.Internal.Used } s msg kind
maxRows v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.TextareaAutosize.maxRows v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows :
    Float
    -> Builder { a | minRows : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | minRows : M3e.Build.Internal.Used } s msg kind
minRows v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.TextareaAutosize.minRows v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-textarea-autosize>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { textareaAutosize : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
