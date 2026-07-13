module M3e.Build.SlideGroup exposing
    ( Builder, AttrCaps, SlotCaps, slideGroup, attr, disabled
    , nextPageLabel, previousPageLabel, threshold, vertical, nextIcon, prevIcon
    , build
    )

{-| The Build form for `<m3e-slide-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SlideGroup as SlideGroup`.

@docs Builder, AttrCaps, SlotCaps, slideGroup, attr, disabled
@docs nextPageLabel, previousPageLabel, threshold, vertical, nextIcon, prevIcon
@docs build

-}

import M3e.Build.Internal
import M3e.Html.SlideGroup
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-slide-group>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | slideGroup : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , threshold : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-slide-group>`.
-}
slideGroup : Builder AttrCaps SlotCaps msg kind
slideGroup =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.SlideGroup.slideGroup
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
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


{-| Whether scroll buttons are disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SlideGroup.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg kind
nextPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SlideGroup.nextPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    ->
        Builder
            { a
                | previousPageLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg kind
previousPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SlideGroup.previousPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`)
-}
threshold :
    Float
    -> Builder { a | threshold : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | threshold : M3e.Build.Internal.Used } s msg kind
threshold v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.SlideGroup.threshold v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether content is oriented vertically. (default: `false`)
-}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.SlideGroup.vertical v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `next-icon` slot.
-}
nextIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | nextIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | nextIcon : M3e.Build.Internal.Used } msg kind
nextIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "next-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `prev-icon` slot.
-}
prevIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | prevIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | prevIcon : M3e.Build.Internal.Used } msg kind
prevIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "prev-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slide-group>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { slideGroup : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
