module M3e.Build.DialogAction exposing
    ( Builder, AttrCaps, SlotCaps, dialogAction, attr, returnValue
    , child, build
    )

{-| The Build form for `<m3e-dialog-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DialogAction as DialogAction`.

@docs Builder, AttrCaps, SlotCaps, dialogAction, attr, returnValue
@docs child, build

-}

import M3e.Build.Internal
import M3e.Html.DialogAction
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-dialog-action>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | dialogAction : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { returnValue : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-dialog-action>`.
-}
dialogAction : Builder AttrCaps SlotCaps msg kind
dialogAction =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.DialogAction.dialogAction
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


{-| The value to return from the dialog. (default: `""`)
-}
returnValue :
    String
    -> Builder { a | returnValue : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | returnValue : M3e.Build.Internal.Used } s msg kind
returnValue v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DialogAction.returnValue v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-dialog-action>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { dialogAction : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
