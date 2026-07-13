module M3e.Build.BottomSheetTrigger exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheetTrigger, attr, detent
    , secondary, for, child, build
    )

{-| The Build form for `<m3e-bottom-sheet-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetTrigger as BottomSheetTrigger`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetTrigger, attr, detent
@docs secondary, for, child, build

-}

import M3e.Build.Internal
import M3e.Html.BottomSheetTrigger
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet-trigger>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | bottomSheetTrigger : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , secondary : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet-trigger>`.
-}
bottomSheetTrigger : Builder AttrCaps SlotCaps msg kind
bottomSheetTrigger =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.BottomSheetTrigger.bottomSheetTrigger
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


{-| The zero‑based index of the detent the sheet should open to.
-}
detent :
    Float
    -> Builder { a | detent : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | detent : M3e.Build.Internal.Used } s msg kind
detent v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BottomSheetTrigger.detent v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary :
    Bool
    -> Builder { a | secondary : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | secondary : M3e.Build.Internal.Used } s msg kind
secondary v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BottomSheetTrigger.secondary v_)
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BottomSheetTrigger.for v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-bottom-sheet-trigger>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { bottomSheetTrigger : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
