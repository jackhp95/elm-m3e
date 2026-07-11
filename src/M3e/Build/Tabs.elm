module M3e.Build.Tabs exposing
    ( Builder, AttrCaps, SlotCaps, tabs, attr, disablePagination
    , headerPosition, nextPageLabel, previousPageLabel, stretch, variant, onChange
    , onBeforeinput, onInput, nextIcon, prevIcon, build
    )

{-| The Build form for `<m3e-tabs>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tabs as Tabs`.

@docs Builder, AttrCaps, SlotCaps, tabs, attr, disablePagination
@docs headerPosition, nextPageLabel, previousPageLabel, stretch, variant, onChange
@docs onBeforeinput, onInput, nextIcon, prevIcon, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Tabs
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-tabs>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | tabs : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disablePagination : M3e.Build.Internal.Available
    , headerPosition : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , stretch : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-tabs>`.
-}
tabs : Builder AttrCaps SlotCaps msg kind
tabs =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Tabs.tabs
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


{-| Whether scroll buttons are disabled.
-}
disablePagination :
    M3e.Token.Value
        { true : M3e.Token.Supported
        , false : M3e.Token.Supported
        , auto : M3e.Token.Supported
        }
    ->
        Builder
            { a
                | disablePagination : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disablePagination : M3e.Build.Internal.Used } s msg kind
disablePagination v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.disablePagination v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg kind
headerPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.headerPosition v_))
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
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.nextPageLabel v_))
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
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.previousPageLabel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch :
    Bool
    -> Builder { a | stretch : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | stretch : M3e.Build.Internal.Used } s msg kind
stretch v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.stretch v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected tab changes.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a tab changes.
-}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.onBeforeinput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a tab changes.
-}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Tabs.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `next-icon` slot.
-}
nextIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | nextIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | nextIcon : M3e.Build.Internal.Used } msg kind
nextIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "next-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `prev-icon` slot.
-}
prevIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | prevIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | prevIcon : M3e.Build.Internal.Used } msg kind
prevIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "prev-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tabs>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tabs : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
