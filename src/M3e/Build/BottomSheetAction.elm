module M3e.Build.BottomSheetAction exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheetAction, attr, child
    , build
    )

{-| The Build form for `<m3e-bottom-sheet-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetAction as BottomSheetAction`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetAction, attr, child
@docs build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.BottomSheetAction
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet-action>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | bottomSheetAction : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet-action>`.
-}
bottomSheetAction : Builder AttrCaps SlotCaps msg kind
bottomSheetAction =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.BottomSheetAction.bottomSheetAction
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


{-| Place content in the `(default)` slot.
-}
child :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-bottom-sheet-action>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { bottomSheetAction : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
