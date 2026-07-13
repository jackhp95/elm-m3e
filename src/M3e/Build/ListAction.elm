module M3e.Build.ListAction exposing
    ( Builder, AttrCaps, SlotCaps, listAction, attr, disabled
    , download, href, rel, target, onClick, child
    , leading, overline, supportingText, trailing, build
    )

{-| The Build form for `<m3e-list-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListAction as ListAction`.

@docs Builder, AttrCaps, SlotCaps, listAction, attr, disabled
@docs download, href, rel, target, onClick, child
@docs leading, overline, supportingText, trailing, build

-}

import M3e.Build.Internal
import M3e.Html.ListAction
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-list-action>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | listAction : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-action>`.
-}
listAction : Builder AttrCaps SlotCaps msg kind
listAction =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ListAction.listAction
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.download v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the link button points. (default: `""`)
-}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.href v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.rel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The target of the link button. (default: `""`)
-}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.target v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked.
-}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ListAction.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , dialogTrigger : M3e.Kind.Brand
        , dialogAction : M3e.Kind.Brand
        , menuTrigger : M3e.Kind.Brand
        , fabMenuTrigger : M3e.Kind.Brand
        , bottomSheetTrigger : M3e.Kind.Brand
        , bottomSheetAction : M3e.Kind.Brand
        , stepperPrevious : M3e.Kind.Brand
        , stepperReset : M3e.Kind.Brand
        , richTooltipAction : M3e.Kind.Brand
        , drawerToggle : M3e.Kind.Brand
        , datepickerToggle : M3e.Kind.Brand
        , navRailToggle : M3e.Kind.Brand
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg kind
leading el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "leading" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "overline" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg kind
supportingText el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "supporting-text" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing` slot.
-}
trailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg kind
trailing el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "trailing" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-list-action>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { listAction : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
