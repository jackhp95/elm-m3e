module M3e.Build.FloatingPanel exposing
    ( Builder, AttrCaps, SlotCaps, floatingPanel, scrollStrategy, fitAnchorWidth
    , anchorOffset, onBeforetoggle, onToggle
    )

{-|
The ⑤ Build shape for `<m3e-floating-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FloatingPanel as FloatingPanel`.

@docs Builder, AttrCaps, SlotCaps, floatingPanel, scrollStrategy, fitAnchorWidth
@docs anchorOffset, onBeforetoggle, onToggle
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FloatingPanel
import M3e.Cem.Html.FloatingPanel
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-floating-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | floatingPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-floating-panel>`. -}
floatingPanel : Builder AttrCaps SlotCaps msg kind
floatingPanel =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FloatingPanel.floatingPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> Builder { a | scrollStrategy : M3e.Build.Internal.Available } s msg kind
    -> Builder { scrollStrategy : M3e.Build.Internal.Used } s msg kind
scrollStrategy v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FloatingPanel.scrollStrategy v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool
    -> Builder { a | fitAnchorWidth : M3e.Build.Internal.Available } s msg kind
    -> Builder { fitAnchorWidth : M3e.Build.Internal.Used } s msg kind
fitAnchorWidth v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FloatingPanel.fitAnchorWidth v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float
    -> Builder { a | anchorOffset : M3e.Build.Internal.Available } s msg kind
    -> Builder { anchorOffset : M3e.Build.Internal.Used } s msg kind
anchorOffset v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.FloatingPanel.anchorOffset v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.FloatingPanel.onBeforetoggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.FloatingPanel.onToggle v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )