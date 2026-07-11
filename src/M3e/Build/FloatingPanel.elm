module M3e.Build.FloatingPanel exposing
    ( Builder, AttrCaps, SlotCaps, floatingPanel, attr, scrollStrategy
    , fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle, build
    )

{-| The Build form for `<m3e-floating-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FloatingPanel as FloatingPanel`.

@docs Builder, AttrCaps, SlotCaps, floatingPanel, attr, scrollStrategy
@docs fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.FloatingPanel
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-floating-panel>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | floatingPanel : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-floating-panel>`.
-}
floatingPanel : Builder AttrCaps SlotCaps msg kind
floatingPanel =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.FloatingPanel.floatingPanel
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


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    M3e.Token.Value
        { hide : M3e.Token.Supported
        , reposition : M3e.Token.Supported
        }
    -> Builder { a | scrollStrategy : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | scrollStrategy : M3e.Build.Internal.Used } s msg kind
scrollStrategy v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.FloatingPanel.scrollStrategy v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth :
    Bool
    -> Builder { a | fitAnchorWidth : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | fitAnchorWidth : M3e.Build.Internal.Used } s msg kind
fitAnchorWidth v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.FloatingPanel.fitAnchorWidth v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset :
    Float
    -> Builder { a | anchorOffset : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | anchorOffset : M3e.Build.Internal.Used } s msg kind
anchorOffset v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.FloatingPanel.anchorOffset v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes.
-}
onBeforetoggle :
    msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.FloatingPanel.onBeforetoggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed.
-}
onToggle :
    msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.FloatingPanel.onToggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-floating-panel>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { floatingPanel : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
