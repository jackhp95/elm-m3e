module M3e.Build.OptionPanel exposing
    ( Builder, AttrCaps, SlotCaps, optionPanel, state, scrollStrategy
    , fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle
    )

{-|
The ⑤ Build shape for `<m3e-option-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.OptionPanel as OptionPanel`.

@docs Builder, AttrCaps, SlotCaps, optionPanel, state, scrollStrategy
@docs fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.OptionPanel
import M3e.Cem.OptionPanel
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-option-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | optionPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { state : M3e.Build.Internal.Available
    , scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { noData : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-option-panel>`. -}
optionPanel : Builder AttrCaps SlotCaps msg kind
optionPanel =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.OptionPanel.optionPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The state for which to present content. (default: `"content"`) -}
state :
    M3e.Value.Value { content : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    }
    -> Builder { a | state : M3e.Build.Internal.Available } s msg kind
    -> Builder { state : M3e.Build.Internal.Used } s msg kind
state v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.OptionPanel.state v_))
             (M3e.Build.Internal.node_ b_)
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
             (M3e.Cem.Attr.forget (M3e.Cem.OptionPanel.scrollStrategy v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.OptionPanel.fitAnchorWidth v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.OptionPanel.anchorOffset v_))
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
                       M3e.Cem.Html.OptionPanel.onBeforetoggle
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.OptionPanel.onToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )