module M3e.Build.ContentPane exposing
    ( Builder, AttrCaps, SlotCaps, contentPane, build
    )

{-|
The ⑤ Build shape for `<m3e-content-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ContentPane as ContentPane`.

@docs Builder, AttrCaps, SlotCaps, contentPane, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ContentPane
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-content-pane>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | contentPane : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-content-pane>`. -}
contentPane : Builder AttrCaps SlotCaps msg kind
contentPane =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ContentPane.contentPane
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-content-pane>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { contentPane : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)